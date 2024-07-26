
ITEM.name = "Corn"
ITEM.model = Model("models/foodnhouseholditems/corn.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A cob of corn."
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
