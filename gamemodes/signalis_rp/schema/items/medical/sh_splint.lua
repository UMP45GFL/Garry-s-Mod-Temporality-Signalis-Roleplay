
ITEM.name = "Splint"
ITEM.model = Model("models/eternalis/items/medical/splint.mdl")
ITEM.description = "Splint that hold bones and joints in place so they can heal after a fracture, injury, or surgery."
ITEM.category = "Medical"
ITEM.price = 18

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 10, 100))
	end
}
