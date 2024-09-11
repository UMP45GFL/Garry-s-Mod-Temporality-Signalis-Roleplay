
ITEM.name = "Identification card"
ITEM.model = Model("models/eternalis/items/cards/access_card.mdl")
ITEM.description = "An identification card for a member of the Protektor staff, assigned to %s."
ITEM.skin = 6 -- TODO: NEEDS TO BE CHANGED

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("name", "nobody"))
end
