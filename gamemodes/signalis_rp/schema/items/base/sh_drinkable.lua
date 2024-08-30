
ITEM.name = "Drinkable Base"
ITEM.model = "models/props/cs_office/water_bottle.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Consumables"
ITEM.description = "Base drinkable item"

ITEM.addHunger = 0
ITEM.addThirst = 0
ITEM.addHealth = 0
ITEM.addStamina = 0
ITEM.eatSound = nil

ITEM.functions.Drink = {
	OnRun = function(itemTable)
		local hunger = itemTable:GetData("addHunger", itemTable.addHunger)
		local thirst = itemTable:GetData("addThirst", itemTable.addThirst)
		local eatSound = itemTable:GetData("eatSound", itemTable.eatSound)
		local addStamina = itemTable:GetData("addStamina", itemTable.addStamina)

		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			if client.thirst / client:GetMaxThirst() > 0.9 then
				client:NotifyLocalized("You don't need to drink right now.")
				return false
			end

			client:AddHunger(hunger)
			client:AddThirst(thirst)
		end

		client:RestoreStamina(addStamina)

		if eatSound then
			client:EmitSound(eatSound)
		end

		client:SetHealth(math.min(client:Health() + itemTable.addHealth, client:GetMaxHealth()))

		return true
	end,
}
