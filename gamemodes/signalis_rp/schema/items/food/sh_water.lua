
ITEM.name = "Bottle of water"
ITEM.model = Model("models/props/cs_office/water_bottle.mdl")
ITEM.description = "A bottle of water, it looks refreshing."
ITEM.category = "Consumables"

ITEM.functions.Drink = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddThirst(-30)
		end

		client:RestoreStamina(25)
		client:SetHealth(math.Clamp(client:Health() + 6, 0, client:GetMaxHealth()))
		client:EmitSound("npc/barnacle/barnacle_gulp2.wav", 75, 90, 0.35)
	end,
}
