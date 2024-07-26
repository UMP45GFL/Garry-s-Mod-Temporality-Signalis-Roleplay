
ITEM.name = "Big medkit"
ITEM.model = Model("models/eternalis/items/medical/health_kit_big.mdl")
ITEM.description = "A big medkit containing various medical supplies."
ITEM.category = "Medical"
ITEM.price = 50

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 100, 100))
	end
}
