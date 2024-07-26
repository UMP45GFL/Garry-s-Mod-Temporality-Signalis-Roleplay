
ITEM.name = "Watermelon slice"
ITEM.model = Model("models/foodnhouseholditems/watermelon_slice.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A slice of watermelon. It's juicy and sweet."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-8)
		end

		client:SetHealth(math.min(client:Health() + 3, client:GetMaxHealth()))

		return true
	end,
}
