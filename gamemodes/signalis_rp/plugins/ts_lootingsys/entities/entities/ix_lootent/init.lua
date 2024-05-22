
include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

DEFINE_BASECLASS("ix_container")

local PLUGIN = PLUGIN

function ENT:Initialize()
	self:SetModel("models/props_junk/trashcluster01a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.receivers = {}

	self:SetTimer(5)
	self:SetMinPlayers(1)
	self:SetDesiredItemCount(1)
	self:SetInventoryWidth(6)
	self:SetInventoryHeight(3)
	self:SetLootTime(3)
	self:ChangeToolDisplayNameReqAttrib("", "Lootable Entity", "None")
	self:ChangeDescAttribute("An entity that you can loot items from.", "None")
	self:ChangeLootInfo("Looting...", "")
	self:SetAttributeAmount(0)
	self:SetRequiredAttributeAmount(0)

	ix.inventory.New(0, "lootent:6x3", function(inventory)
		inventory.vars.isBag = true
		inventory.vars.isContainer = true

		self:SetInventory(inventory)
		PLUGIN:SaveLootEntities()
	end)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

function ENT:Use(activator)
	local tool = self:GetToolDisplayAttribute().tool
	
	if (tool and tool != "" and !activator:GetCharacter():GetInventory():HasItem(tool)) then
		local name = ix.item.list[tool] and ix.item.list[tool].name or tool

		activator:Notify("You need a " .. name .. " to loot this!")

		return
	end

	local inventory = self:GetInventory()

	if (inventory) then
		local requiredAttribute, requiredAttributeAmount = self:GetToolDisplayAttribute().requiredAttribute, self:GetRequiredAttributeAmount()
		
		if (requiredAttribute and requiredAttribute != "None" and requiredAttributeAmount > 0 and !self.looted) then
			local attribute = activator:GetCharacter():GetAttribute(requiredAttribute, 0)

			if (attribute < requiredAttributeAmount) then
				activator:Notify("You need a " .. ix.attributes.list[requiredAttribute].name .. " of " .. requiredAttributeAmount .. " to loot this!")

				return
			end
		end

		ix.storage.Open(activator, inventory, {
			name = self:GetToolDisplayAttribute().displayName,
			entity = self,
			searchTime = self:GetLootTime(),
			searchText = self:GetLootInfo().lootPhrase,
			data = {money = self:GetCurrency()},
			OnPlayerOpen = function()
				if (self.looted) then return end

				local attribute, attributeAmount = self:GetDescAttribute().attribute, self:GetAttributeAmount()

				if (attribute and attribute != "None" and attributeAmount > 0) then
					activator:GetCharacter():UpdateAttrib(attribute, attributeAmount)
				end
				
				self.looted = true
			end,
			OnPlayerClose = function()
				ix.log.Add(activator, "closeLootent", self:GetToolDisplayAttribute().displayName, inventory:GetID())
			end
		})

		local sound = self:GetLootInfo().lootSound

		if (sound and sound != "") then
			activator:EmitSound(sound)
		end
	end
end

function ENT:SetLootTable(lootTable)
	lootTable = util.Compress(lootTable)

	self.lootTable = lootTable
end

function ENT:ChangeTimer(time)
	self:SetTimer(time)

	local entIndex = self:EntIndex()

	if (timer.Exists("LootentTimer" .. entIndex)) then
		timer.Remove("LootentTimer" .. entIndex)
	end

	timer.Create("LootentTimer" .. entIndex, time * 60, 0, function()
		if (!IsValid(self)) then return end
		if (#player.GetAll() < self:GetMinPlayers()) then return end

		self.looted = false

		local inventory = self:GetInventory()

		if (inventory) then
			for k, _ in pairs(inventory:GetItems()) do
				inventory:Remove(k)
			end
		end
		
		local lootTable = self:GetLootTable()
		local desiredItems = self:GetDesiredItemCount()
		local currency = self:GetCurrency()

		local registeredItems = {}

		for uniqueID, chance in pairs(lootTable) do
			for i = 1, chance do
				registeredItems[#registeredItems + 1] = uniqueID
			end
		end

		for i = 1, desiredItems do
			local uniqueID = registeredItems[math.random(1, #registeredItems)]

			inventory:Add(uniqueID)
		end

		self:SetMoney(math.random(0, currency))
	end)
end

function ENT:OnRemove()
	local index = self:GetID()

	if (!index) then return end

	local inventory = ix.item.inventories[index]

	if (!inventory) then return end

	ix.item.inventories[index] = nil

	local query = mysql:Delete("ix_items")
		query:Where("inventory_id", index)
	query:Execute()

	query = mysql:Delete("ix_inventories")
		query:Where("inventory_id", index)
	query:Execute()
end

function ENT:ChangeInventorySize(width, height)
	self:SetInventoryWidth(width)
	self:SetInventoryHeight(height)

	local index = self:GetID()

	if (index) then
		local inventory = ix.item.inventories[index]

		if (inventory) then
			ix.item.inventories[index] = nil

			local query = mysql:Delete("ix_items")
				query:Where("inventory_id", index)
			query:Execute()

			query = mysql:Delete("ix_inventories")
				query:Where("inventory_id", index)
			query:Execute()
		end
	end

	ix.inventory.New(0, "lootent:" .. width .. "x" .. height, function(inventory)
		inventory.vars.isBag = true
		inventory.vars.isContainer = true

		self:SetInventory(inventory)
	end)
end

function ENT:SetDataString(data, lootTable)
	data = util.JSONToTable(data)

	self:ChangeTimer(data.timer)
	self:SetMinPlayers(data.minPlayers)
	self:SetDesiredItemCount(data.desiredItemCount)
	self:ChangeInventorySize(data.inventoryWidth, data.inventoryHeight)
	self:ChangeToolDisplayNameReqAttrib(data.tool, data.displayName, data.requiredAttribute)
	self:SetLootTable(lootTable)
	self:ChangeDescAttribute(data.description, data.attribute)
	self:SetCurrency(data.currency)
	self:SetModel(data.model)
	self:ChangeLootInfo(data.lootPhrase, data.lootSound)
	self:SetLootTime(data.lootTime)
	self:SetAttributeAmount(data.attributeAmount)

	self:PhysicsInit(SOLID_VPHYSICS)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end

-- I'm forced to merge them because of the string networking limit on entities
function ENT:ChangeToolDisplayNameReqAttrib(tool, displayName, requiredAttribute)
	self:SetToolDisplayNameReqAttrib(util.TableToJSON({tool = tool, displayName = displayName, requiredAttribute = requiredAttribute}))
end

function ENT:ChangeLootInfo(lootPhrase, lootSound)
	self:SetLootPhraseLootSound(util.TableToJSON({lootPhrase = lootPhrase, lootSound = lootSound}))
end

function ENT:ChangeDescAttribute(description, attribute)
	self:SetDescriptionAttributeName(util.TableToJSON({description = description, attribute = attribute}))
end
