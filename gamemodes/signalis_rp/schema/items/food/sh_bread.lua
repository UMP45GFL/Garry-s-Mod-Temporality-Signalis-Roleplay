
ITEM.name = "Loaf of bread"
ITEM.model = Model("models/foodnhouseholditems/bread-2.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A loaf of bread, it looks delicious."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-20)
		end

		client:SetHealth(math.min(client:Health() + 7, client:GetMaxHealth()))

		return true
	end,
}
