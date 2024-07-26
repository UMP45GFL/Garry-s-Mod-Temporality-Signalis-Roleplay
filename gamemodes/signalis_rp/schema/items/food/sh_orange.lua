
ITEM.name = "Orange"
ITEM.model = Model("models/foodnhouseholditems/orange.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "An orange. You don't know if it's fresh."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-6)
		end

		client:SetHealth(math.min(client:Health() + 3, client:GetMaxHealth()))

		return true
	end,
}
