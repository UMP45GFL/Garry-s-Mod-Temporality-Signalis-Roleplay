
ITEM.name = "Bell pepper"
ITEM.model = Model("models/foodnhouseholditems/pepper1.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Bell pepper You don't know if it's fresh."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-7)
		end

		client:SetHealth(math.min(client:Health() + 3, client:GetMaxHealth()))

		return true
	end,
}
