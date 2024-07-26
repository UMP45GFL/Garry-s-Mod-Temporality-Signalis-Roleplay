
ITEM.name = "Repair spray+"
ITEM.model = Model("models/eternalis/items/medical/health_spray_big.mdl")
ITEM.description = "A single-use spray gun to fill damaged areas with fast-curing polyurethane-based foam."
ITEM.category = "Medical"
ITEM.price = 38

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 50, 100))
	end
}
