
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
ITEM.sliceableInto = nil
ITEM.eatMessage = nil

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local hunger = itemTable:GetData("addHunger", itemTable.addHunger)
		local thirst = itemTable:GetData("addThirst", itemTable.addThirst)
		local addStamina = itemTable:GetData("addStamina", itemTable.addStamina)
		local eatSound = itemTable:GetData("eatSound", itemTable.eatSound)
		local eatMessage = itemTable:GetData("eatMessage", itemTable.eatMessage)

		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			if client.hunger / client:GetMaxHunger() > 0.9 then
				client:NotifyLocalized("You are too full to eat.")
				return false
			end

			client:AddHunger(hunger)
			client:AddThirst(thirst)
		end

		client:RestoreStamina(addStamina)

		if eatSound then
			client:EmitSound(eatSound)
		end

		if eatMessage then
			client:ChatPrint(eatMessage)
		end

		client:SetHealth( math.Clamp(client:Health() + itemTable.addHealth, 0, client:GetMaxHealth()) )

		return true
	end
}

ITEM.functions.Slice = {
	OnRun = function(item)
		local ply = item.player

		if (IsValid(ply)) then
			local character = ply:GetCharacter()
			if not character then return false end
			local inventory = ply:GetCharacter():GetInventory()
			if not inventory then return false end
			local items = inventory:GetItems()
			if not items then return false end
	
			for _, v in pairs(items) do
				if (v.id != item.id and v.canSlice) then
					local sliceableInto = item:GetData("sliceableInto", item.sliceableInto)
					local breadSlice = inventory:Add(sliceableInto[1])
	
					if (breadSlice) then
						for i=1, sliceableInto[2] - 1 do
							inventory:Add(sliceableInto[1])
						end
						return true
					end
	
					return false
				end
			end
		end
	
		ply:NotifyLocalized("noSlicingItems")
		return false
	end,
	OnCanRun = function(item)
		local sliceableInto = item:GetData("sliceableInto", item.sliceableInto)
		return istable(sliceableInto)
	end
}
