
ITEM.name = "Burger"
ITEM.model = Model("models/foodnhouseholditems/burgergtaiv.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A burger, it looks delicious."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-30)
		end

		client:SetHealth(math.min(client:Health() + 10, client:GetMaxHealth()))

		return true
	end,
}
