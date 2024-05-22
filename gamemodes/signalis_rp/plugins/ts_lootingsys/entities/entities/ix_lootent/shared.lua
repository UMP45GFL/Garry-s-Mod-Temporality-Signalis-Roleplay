
ENT.Type = "anim"
ENT.Base = "ix_container"

ENT.PrintName = "Loot Entity"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "ID")
	self:NetworkVar("Int", 1, "Timer")
	self:NetworkVar("Int", 2, "MinPlayers")
	self:NetworkVar("Int", 3, "DesiredItemCount")
	self:NetworkVar("Int", 4, "InventoryWidth")
	self:NetworkVar("Int", 5, "InventoryHeight")
	self:NetworkVar("Int", 6, "Currency")
	self:NetworkVar("Int", 7, "LootTime")
	self:NetworkVar("Float", 0, "AttributeAmount")
	self:NetworkVar("Float", 1, "RequiredAttributeAmount")
	self:NetworkVar("String", 0, "ToolDisplayNameReqAttrib")
	self:NetworkVar("String", 1, "LootPhraseLootSound")
	self:NetworkVar("String", 2, "DescriptionAttributeName")
end

function ENT:GetLootTable(json)
	local loot = util.Decompress(self.lootTable or "")
	
	return json and loot or util.JSONToTable(loot != "" and loot or "[]")
end

function ENT:GetDataString()
	local data = {
		timer = self:GetTimer(),
		minPlayers = self:GetMinPlayers(),
		desiredItemCount = self:GetDesiredItemCount(),
		inventoryWidth = self:GetInventoryWidth(),
		inventoryHeight = self:GetInventoryHeight(),
		tool = self:GetToolDisplayAttribute().tool,
		loot = self.lootTable,
		displayName = self:GetToolDisplayAttribute().displayName,
		description = self:GetDescAttribute().description,
		attribute = self:GetDescAttribute().attribute,
		currency = self:GetCurrency(),
		model = self:GetModel(),
		lootPhrase = self:GetLootInfo().lootPhrase,
		lootSound = self:GetLootInfo().lootSound,
		lootTime = self:GetLootTime(),
		attributeAmount = self:GetAttributeAmount(),
		requiredAttribute = self:GetToolDisplayAttribute().requiredAttribute,
	}

	return util.TableToJSON(data)
end

function ENT:GetToolDisplayAttribute()
	return util.JSONToTable(self:GetToolDisplayNameReqAttrib())
end

function ENT:GetLootInfo()
	return util.JSONToTable(self:GetLootPhraseLootSound())
end

function ENT:GetDescAttribute()
	return util.JSONToTable(self:GetDescriptionAttributeName())
end
