
ITEM.name = "Autoinjector"
ITEM.model = Model("models/eternalis/items/medical/injector.mdl")
ITEM.description = "Single-use injection syringe. Instantly restores a large amount of health. Usable on the move. When equipped, automatically activates on system failure. Autoinjector Syringe filled with REPLIKA-KLStim-N stimulant. Quick and easy to use."
ITEM.category = "Medical"
ITEM.price = 60

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 120, 100))
	end
}
