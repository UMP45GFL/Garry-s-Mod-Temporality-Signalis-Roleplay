
ITEM.name = "Small medkit"
ITEM.model = Model("models/eternalis/items/medical/health_kit_small.mdl")
ITEM.description = "A small medkit containing various medical supplies."
ITEM.category = "Medical"
ITEM.price = 35

ITEM.width = 1
ITEM.height = 2

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 50, 100))
	end
}
