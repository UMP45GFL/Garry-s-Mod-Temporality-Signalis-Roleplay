
ITEM.name = "Radio receiver module"
ITEM.model = Model("models/eternalis/items/equipment/radio_module.mdl")
ITEM.description = "Radio receiver module that operates between 50 and 250 KHz. Powered by internal Replika power supply when installed."
ITEM.skin = 0

-- Inventory drawing
if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:EquipRadioModule(client)
	self:SetData("equip", true)
    print("equipped")
end

function ITEM:UnequipRadioModule(client)
	self:SetData("equip", false)
    print("unequipped")
end

ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		local character = ix.char.loaded[item.owner]
		local client = character and character:GetPlayer() or item:GetOwner()

		item.player = client
        item:UnequipRadioModule(client)
	end
end)

ITEM.functions.EquipUn = {
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	OnRun = function(item)
		local character = ix.char.loaded[item.owner]
		local client = character and character:GetPlayer() or item:GetOwner()

        item:UnequipRadioModule(client)
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
			if (v.uniqueID and item.uniqueID == "module_radio" and v.id != item.id and v.data.equip) then
				local itemTable = ix.item.instances[v.id]
                return false
			end
		end

		item:EquipRadioModule(client)
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

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnRemoved()
	if (self.invID != 0 and self:GetData("equip")) then
		self.player = self:GetOwner()
        self:UnequipRadioModule(self.player)
		self.player = nil
	end
end
