
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

if CLIENT then
	net.Receive("ixUnequippedRadioModule", function()
		local index = net.ReadString()

		if index then
			local panel = ix.gui["inv"..index]
			if (IsValid(panel)) then
				panel:Remove()
			end
		end
	end)

	net.Receive("ixEquippedRadioModule", function()
		local index = net.ReadString()

		if index then
			CreateRadioPanel(index)
		end
	end)
else
	util.AddNetworkString("ixUnequippedRadioModule")
	util.AddNetworkString("ixEquippedRadioModule")

	util.AddNetworkString("ixRadioEnabled")
	util.AddNetworkString("ixRadioFrequency")

	net.Receive("ixRadioEnabled", function(len, client)
		local invID = net.ReadUInt(18)
		local frequency = net.ReadUInt(18)
		local enabled = net.ReadBool()
	
		if isnumber(invID) and isbool(enabled) then
			local character = client:GetCharacter()
			if character then
				local inventory = character:GetInventory()
				if inventory then
					for k,v in pairs(inventory:GetItemsByUniqueID("module_radio", true)) do
						if v.invID == invID then
							v:SetData("enabled", enabled)
							v:SetData("frequency", frequency)
						end
					end
				end
			end
		end
	end)

	net.Receive("ixRadioFrequency", function(len, client)
		local invID = net.ReadUInt(18)
		local frequency = net.ReadUInt(18)
	
		if isnumber(invID) and isnumber(frequency) then
			local character = client:GetCharacter()
			if character then
				local inventory = character:GetInventory()
				if inventory then
					for k,v in pairs(inventory:GetItemsByUniqueID("module_radio", true)) do
						if v.invID == invID then
							v:SetData("frequency", frequency)
						end
					end
				end
			end
		end
	end)
end

function ITEM:EquipRadioModule(client)
	self:SetData("equip", true)

	net.Start("ixEquippedRadioModule")
		net.WriteString(self.invID)
	net.Send(client)
end

function ITEM:UnequipRadioModule(client)
	self:SetData("equip", false)

	net.Start("ixUnequippedRadioModule")
		net.WriteString(self.invID)
	net.Send(client)
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
			if (v.uniqueID and v.uniqueID == "module_radio" and v.id != item.id and v.data.equip) then
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





----------------------------------------- PANEL -----------------------------------------

ITEM.isBag = true

function CreateRadioPanel(index)
	local panel = ix.gui["inv"..index]
	if (IsValid(panel)) then
		panel:Remove()
	end

	local parent = ix.gui.menuInventoryContainer
	if IsValid(parent) then
		panel = vgui.Create("ixRadioPanel", parent)
		panel:SetParent(parent)
		panel:ShowCloseButton(true)
		panel:MoveToFront()
		panel.index = index

		ix.gui["inv"..index] = panel
	end
end

ITEM.functions.View = {
	icon = "icon16/briefcase.png",
	OnClick = function(item)
		if item:GetData("equip") then
			CreateRadioPanel(item.invID)
		end

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetData("id") and !IsValid(ix.gui["inv" .. item:GetData("id", "")])
	end
}
