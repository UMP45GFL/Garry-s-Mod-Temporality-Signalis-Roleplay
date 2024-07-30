
ITEM.name = "Writing Base"
ITEM.model = Model("models/props_c17/paper01.mdl")
ITEM.description = "Something that can be written on."
ITEM.width = 1
ITEM.height = 1
ITEM.business = true
ITEM.bAllowMultiCharacterInteraction = true

function ITEM:GetDescription()
	return self:GetData("owner", 0) == 0
		and string.format(self.description, "it hasn't been written on.")
		or string.format(self.description, "it has been written on.")
end

function ITEM:SetPages(pages, character)
	self:SetData("pages", pages, false, false, true)
	self:SetData("owner", character and character:GetID() or 0)
end

ITEM.functions.View = {
	OnRun = function(item)
		netstream.Start(item.player, "ixViewPaper", item:GetID(), item:GetData("pages", {}), 0)
		return false
	end,

	OnCanRun = function(item)
		return item:GetData("owner", 0) != 0
	end
}

ITEM.functions.Edit = {
	OnRun = function(item)
		netstream.Start(item.player, "ixViewPaper", item:GetID(), item:GetData("pages", {}), 1)
		return false
	end,

	OnCanRun = function(item)
		local owner = item:GetData("owner", 0)
		local isEmpty = true
		for k,v in pairs(item:GetData("pages", {})) do
			if (v and v != "") then
				isEmpty = false
				break
			end
		end

		return owner == 0 or owner == item.player:GetCharacter():GetID() and isEmpty
	end
}

ITEM.functions.take.OnCanRun = function(item)
	local owner = item:GetData("owner", 0)
	return IsValid(item.entity) and (owner == 0 or owner == item.player:GetCharacter():GetID())
end

