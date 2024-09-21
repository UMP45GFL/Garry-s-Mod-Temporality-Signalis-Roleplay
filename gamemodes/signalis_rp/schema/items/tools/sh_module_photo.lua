
ITEM.name = "Eidetic module"
ITEM.model = Model("models/eternalis/items/gore/eidet.mdl")
ITEM.description = "An old photographic memory module. Allows recording of up to 6 visual memories. Incredibly outdated, but it might still be useful. When equipped, it can record up to 6 visual memories as grayscale images. Old images are automatically overwritten when taking a picture."
ITEM.skin = 0

ITEM.weight = 0.3

-- Inventory drawing
if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:EquipPhotoModule(client)
	self:SetData("equip", true)
	client:SendPlaySound("eternalis/items/equip.wav")
end

function ITEM:UnequipPhotoModule(client)
	self:SetData("equip", false)
end

ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		local character = ix.char.loaded[item.owner]
		local client = character and character:GetPlayer() or item:GetOwner()

		item.player = client
        item:UnequipPhotoModule(client)
	end
end)

ITEM.functions.EquipUn = {
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	OnRun = function(item)
		local character = ix.char.loaded[item.owner]
		local client = character and character:GetPlayer() or item:GetOwner()

        item:UnequipPhotoModule(client)
		client:SendPlaySound("eternalis/items/equip.wav") 
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		if client:Team() != FACTION_REPLIKA then
			return false
		end

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
			if (v.uniqueID and v.uniqueID == "module_photo" and v.id != item.id and v.data.equip) then
                return false
			end
		end

		item:EquipPhotoModule(client)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		if !client:IsReplika() then
			return false
		end

		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.uniqueID and v.uniqueID == "module_photo" and v.id != item.id and v.data.equip) then
                return false
			end
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
		self:UnequipPhotoModule(self.player)
		self.player = nil
	end
end
