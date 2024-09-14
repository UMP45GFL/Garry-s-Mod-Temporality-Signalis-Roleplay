
ITEM.name = "Autoinjector"
ITEM.model = Model("models/eternalis/items/medical/injector.mdl")
ITEM.description = "Single-use injection syringe. Instantly restores a large amount of health. Usable on the move. When equipped, automatically activates on system failure. Autoinjector Syringe filled with REPLIKA-KLStim-N stimulant. Quick and easy to use."
ITEM.price = 60

ITEM.weight = 0.2

ITEM.addHealth = 120
ITEM.applySound = "eternalis/items/heal.wav"
ITEM.replikaOnly = true

-- Inventory drawing
if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:EquipAutoinjector(client)
	self:SetData("equip", true)
end

function ITEM:UnequipAutoinjector(client)
	self:SetData("equip", false)
end

ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		local character = ix.char.loaded[item.owner]
		local client = character and character:GetPlayer() or item:GetOwner()

		item.player = client
        item:UnequipAutoinjector(client)
	end
end)

ITEM.functions.EquipUn = {
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	OnRun = function(item)
		local character = ix.char.loaded[item.owner]
		local client = character and character:GetPlayer() or item:GetOwner()

        item:UnequipAutoinjector(client)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false
	end
}

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		local client = item.player
		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.uniqueID and v.uniqueID == "autoinjector" and v.id != item.id and v.data.equip) then
                return false
			end
		end

		item:EquipAutoinjector(client)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		if client:Team() != FACTION_REPLIKA then
			return false
		end

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false
	end
}

function ITEM:OnRemoved()
	if (self.invID != 0 and self:GetData("equip")) then
		self.player = self:GetOwner()
        self:UnequipAutoinjector(self.player)
		self.player = nil
	end
end

hook.Add("EntityTakeDamage", "AutoinjectorPreventDeath", function(target, dmginfo)
	if target:IsPlayer() and target:IsReplika() then
        local items = target:GetCharacter():GetInventory():GetItems()

        for _, v in pairs(items) do
            if (v.uniqueID and v.uniqueID == "autoinjector" and v:GetData("equip")) then
                local itemTable = ix.item.instances[v.id]

                if (itemTable:GetData("equip")) then
                    itemTable:UnequipAutoinjector(target)
                end

                target:SetHealth(math.min(target:Health() + itemTable.addHealth, target:GetMaxHealth()))
                target:EmitSound(itemTable.applySound)

                itemTable:Remove()

                return true
            end
        end
	end
end)
