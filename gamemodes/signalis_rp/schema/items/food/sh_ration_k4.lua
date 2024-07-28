
ITEM.name = "Ration K4"
ITEM.model = Model("models/eternalis/items/rations/ration_k4.mdl")
ITEM.width = 1
ITEM.height = 2
ITEM.description = "Schnitzel with cranberries, long-lasting concentrate, self-heating. From Rotfront Orbital Hydroponics. 1200kJ worth of energy."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-50)
		end

		client:SetHealth(math.min(client:Health() + 18, client:GetMaxHealth()))

		return true
	end,
}
