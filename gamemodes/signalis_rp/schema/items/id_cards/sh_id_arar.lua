
ITEM.name = "Identification card"
ITEM.model = Model("models/eternalis/items/cards/access_card.mdl")
ITEM.description = "An identification card for a member of the Worker staff, assigned to %s."
ITEM.skin = 3

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("name", "nobody"))
end
