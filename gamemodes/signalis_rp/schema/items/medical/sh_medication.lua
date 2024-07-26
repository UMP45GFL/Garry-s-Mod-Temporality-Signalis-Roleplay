
ITEM.name = "Bottle of medication"
ITEM.model = Model("models/eternalis/items/medical/medication.mdl")
ITEM.description = "A bottle of medication."
ITEM.category = "Medical"
ITEM.price = 18

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 10, 100))
	end
}
