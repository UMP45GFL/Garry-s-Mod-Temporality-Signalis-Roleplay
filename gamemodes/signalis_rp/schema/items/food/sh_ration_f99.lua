
ITEM.name = "Ration F99"
ITEM.model = Model("models/eternalis/items/rations/ration_f99.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "White sausage with sweet mustard and lye dough pieces reconstituted condensate vitamin enriched. From Rotfront Orbital Hydroponics. 900kJ worth of energy."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-40)
		end

		client:SetHealth(math.min(client:Health() + 16, client:GetMaxHealth()))

		return true
	end,
}
