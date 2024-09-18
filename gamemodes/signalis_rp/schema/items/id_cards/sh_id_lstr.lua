
ITEM.name = "Identification card"
ITEM.model = Model("models/eternalis/items/cards/access_card.mdl")
ITEM.description = "An identification card for a member of the staff, assigned to %s."
ITEM.skin = 9

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("name", "nobody"))
end
