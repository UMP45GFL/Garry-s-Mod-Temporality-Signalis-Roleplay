
ITEM.name = "Jägerbier"
ITEM.model = Model("models/eternalis/items/rations/beermugfilled.mdl")
ITEM.description = "A mug of Jägerbier. 35% alcohol by volume."
ITEM.skin = 1
ITEM.width = 1
ITEM.height = 2

ITEM.addHunger = 0
ITEM.addThirst = -10
ITEM.addHealth = 5
ITEM.addStamina = 5
ITEM.eatSound = "npc/barnacle/barnacle_gulp2.wav"

ITEM.weight = 1


--experimental tradeoff, increase attribute but lower another?
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

    client:GetCharacter():UpdateAttrib("end", 0.02)
    client:GetCharacter():UpdateAttrib("str", -0.001)

		client:RestoreStamina(addStamina)

		if eatSound then
			client:EmitSound(eatSound)
		end

		client:SetHealth(math.min(client:Health() + itemTable.addHealth, client:GetMaxHealth()))

		return true
	end,
}
