
ITEM.name = "Repair spray"
ITEM.model = Model("models/eternalis/items/medical/health_spray_small.mdl")
ITEM.description = "A single-use spray gun to fill damaged areas with polyurethane-based expanding foam. Restores a large amount of health over time."
ITEM.category = "Medical"
ITEM.price = 18

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 30, 100))
	end
}
