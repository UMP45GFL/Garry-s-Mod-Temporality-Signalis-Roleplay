
ITEM.name = "Writing Base"
ITEM.model = Model("models/props_c17/paper01.mdl")
ITEM.description = "Something that can be written on."
ITEM.width = 1
ITEM.height = 1
ITEM.business = true
ITEM.bAllowMultiCharacterInteraction = true

ITEM.maxPages = 3
ITEM.startFromPage0 = false

function ITEM:GetDescription()
	local hasBeenWrittenTo = false
	
	for k,v in pairs(self:GetData("pages", {})) do
		if (v and v != "") then
			hasBeenWrittenTo = true
			break
		end
	end

	return ((self:GetData("owner", 0) == 0) or hasBeenWrittenTo)
		and string.format(self.description, "it hasn't been written on.")
		or string.format(self.description, "it has been written on.")
end

function ITEM:SetPages(pages, character)
	self:SetData("pages", pages, false, false, true)
	self:SetData("owner", character and character:GetID() or 0)
end

function ITEM:OnInstanced(invID, x, y, item)
	if item.pages then
		item:SetData("pages", item.pages)
	end
end

ITEM.functions.View = {
	OnRun = function(item)
		if item.pages and #item:GetData("pages", {}) == 0 then
			item:SetData("pages", item.pages)
		end
		netstream.Start(item.player, "ixViewPaper", item.maxPages, item.startFromPage0, item.backgroundPhoto, item:GetID(), item:GetData("pages", {}), 0)
		return false
	end,

	OnCanRun = function(item)
		local hasBeenWrittenTo = false
	
		if item.pages and #item:GetData("pages", {}) == 0 then
			item:SetData("pages", item.pages)
		end

		for k,v in pairs(item:GetData("pages", {})) do
			if (v and isstring(v) and string.len(v) > 0) or (v and istable(v)) then
				hasBeenWrittenTo = true
				break
			end
		end

		return hasBeenWrittenTo
	end
}

ITEM.functions.Edit = {
	OnRun = function(item)
		if item.pages and #item:GetData("pages", {}) == 0 then
			item:SetData("pages", item.pages)
		end
		netstream.Start(item.player, "ixViewPaper", item.maxPages, item.startFromPage0, item.backgroundPhoto, item:GetID(), item:GetData("pages", {}), 1)
		return false
	end,

	OnCanRun = function(item)
		local owner = item:GetData("owner", 0)
		
		if item.pages and #item:GetData("pages", {}) == 0 then
			item:SetData("pages", item.pages)
		end

		local isEmpty = true
		for k,v in pairs(item:GetData("pages", {})) do
			if (v and v != "") then
				isEmpty = false
				break
			end
		end

		return (owner == 0 and isEmpty) or (owner == item.player:GetCharacter():GetID() and isEmpty)
	end
}

ITEM.functions.take.OnCanRun = function(item)
	local owner = item:GetData("owner", 0)
	return IsValid(item.entity) and (owner == 0 or owner == item.player:GetCharacter():GetID())
end

