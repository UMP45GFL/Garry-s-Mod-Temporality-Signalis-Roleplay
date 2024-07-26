
ITEM.name = "Blood bag"
ITEM.model = Model("models/eternalis/items/medical/bloodbag.mdl")
ITEM.description = "A bag of blood."
ITEM.category = "Medical"
ITEM.price = 22

ITEM.functions.Apply = {
	sound = "items/medshot4.wav",
	OnRun = function(itemTable)
		local client = itemTable.player

		client:SetHealth(math.min(client:Health() + 35, 100))
	end
}
