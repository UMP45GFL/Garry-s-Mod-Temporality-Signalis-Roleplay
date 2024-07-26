
ITEM.name = "Repair patch"
ITEM.model = Model("models/eternalis/items/medical/health_patch.mdl")
ITEM.description = "A sealed, single-use adhesive patch containing a coagulation agent to patch up damaged areas. Restores a small amount of health over time."
ITEM.category = "Medical"
ITEM.price = 18

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 20, 100))
	end
}
