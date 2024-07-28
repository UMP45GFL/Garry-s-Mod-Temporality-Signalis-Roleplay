
ITEM.name = "Cooked meat"
ITEM.model = Model("models/foodnhouseholditems/meat8.mdl")
ITEM.width = 2
ITEM.height = 1
ITEM.description = "A piece of cooked meat. Looks edible."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-30)
		end

		client:SetHealth(math.min(client:Health() + 12, client:GetMaxHealth()))

		return true
	end,
}
