
ITEM.name = "Ration C"
ITEM.model = Model("models/eternalis/items/rations/ration_c.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Roast pork with rice. Freeze dried and rehydrated. Produced on Leng in S-23 Sierpinski. 800kJ worth of energy."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-40)
		end

		client:SetHealth(math.min(client:Health() + 15, client:GetMaxHealth()))

		return true
	end,
}
