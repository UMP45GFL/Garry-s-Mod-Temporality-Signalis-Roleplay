
ITEM.name = "Identification cards Base"
ITEM.model = "models/eternalis/items/cards/access_card.mdl"
ITEM.category = "Cards"
ITEM.description = "Base id card item"

ITEM.width = 1
ITEM.height = 1

ITEM.weight = 0.1

function ITEM:GetDescription()
    local desc = string.format(self.description, self:GetData("name", "nobody"))

    local issued = self:GetData("issued", nil)
    if issued then
        desc = desc .. " Issued on " .. issued
    end

	return desc
end

function ITEM:OnInstanced(invID, x, y, item)
	item:SetData("issued", Schema:GetSignalisDate())
end

ITEM.functions.EditName = {
	OnRun = function(item)
		netstream.Start(item.player, "ixGenericItemEdit", item:GetID(), "name", 20)
		return false
	end,
	OnCanRun = function(item)
        if item.player:IsStaff() then
            return true
        end

        local charId = item:GetData("charId", nil)
        if charId != nil then
            return charId == item.player:GetCharacter():GetID()
        end

        local charName = item:GetData("name", nil)
        if charName != nil then
            return charName == item.player:GetCharacter():GetName()
        end

		return false
	end
}

ITEM.functions.UpdateIssueDate = {
	OnRun = function(item)
		netstream.Start(item.player, "ixGenericItemEdit", item:GetID(), "issued", 18)
		return false
	end,
	OnCanRun = function(item)
        if item.player:IsStaff() then
            return true
        end

        local charId = item:GetData("charId", nil)
        if charId != nil then
            return charId == item.player:GetCharacter():GetID()
        end

        local charName = item:GetData("name", nil)
        if charName != nil then
            return charName == item.player:GetCharacter():GetName()
        end

		return false
	end
}
