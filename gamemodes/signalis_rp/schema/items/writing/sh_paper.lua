
ITEM.name = "Paper"
ITEM.model = Model("models/eternalis/items/library/paper.mdl")
ITEM.description = "A piece of paper, %s."
ITEM.price = 2
ITEM.skin = 0

ITEM.maxPages = 2
ITEM.backgroundPhoto = "eternalis/documents/DET_GenericNote.png"

function ITEM:GetName()
    if self:GetData("title", nil) then return self:GetData("title", nil) end

	return (CLIENT and L(self.name) or self.name)
end

function ITEM:SetTitle(item, text)
    item.name = text
    item:SetData("title", text)
end

ITEM.functions.SetTitle = {
	OnRun = function(item)
		netstream.Start(item.player, "ixEditTitlePaper", item:GetID())
		return false
	end,
	OnCanRun = function(item)
        if item:GetData("title", nil) then return false end

		local owner = item:GetData("owner", 0)

		local isEmpty = true
	
		if item.pages and #item:GetData("pages", {}) == 0 then
			item:SetData("pages", item.pages)
		end

		for k,v in pairs(item:GetData("pages", {})) do
			if (v and isstring(v) and string.len(v) > 0) or (v and istable(v)) then
				isEmpty = false
				break
			end
		end

		return !isEmpty or (item:GetData("owner", 0) != 0)
	end
}
