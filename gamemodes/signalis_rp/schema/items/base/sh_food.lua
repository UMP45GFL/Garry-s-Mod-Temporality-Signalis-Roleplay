
ITEM.name = "Food Base"
ITEM.model = "models/eternalis/items/rations/ration_c.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Consumables"
ITEM.description = "Base food item"

ITEM.addHunger = 0
ITEM.addThirst = 0
ITEM.addHealth = 0
ITEM.addStamina = 0
ITEM.eatSound = nil

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local hunger = itemTable:GetData("addHunger", itemTable.addHunger)
		local thirst = itemTable:GetData("addThirst", itemTable.addThirst)
		local eatSound = itemTable:GetData("eatSound", itemTable.eatSound)
		local addStamina = itemTable:GetData("addStamina", itemTable.addStamina)

		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(hunger)
			client:AddThirst(thirst)
		end

		client:RestoreStamina(addStamina)

		if eatSound then
			client:EmitSound(eatSound)
		end

		client:SetHealth( math.Clamp(client:Health() + itemTable.addHealth, 0, client:GetMaxHealth()) )

		return true
	end,
}
