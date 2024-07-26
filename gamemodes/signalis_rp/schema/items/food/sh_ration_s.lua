
ITEM.name = "Ration S"
ITEM.model = Model("models/eternalis/items/rations/ration_s.mdl")
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Fish noodle soup, dehydrated. Produced on Leng in S-23 Sierpinski. 400kJ worth of energy."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-20)
		end

		client:SetHealth(math.min(client:Health() + 10, client:GetMaxHealth()))

		return true
	end,
}
