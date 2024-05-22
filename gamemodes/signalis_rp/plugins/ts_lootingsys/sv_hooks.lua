
local PLUGIN = PLUGIN

function PLUGIN:LoadData()
	self:LoadLootEntities()
end

function PLUGIN:SaveData()
	self:SaveLootEntities()
end

net.Receive("ixLootentEditPropertyModel", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local model = net.ReadString()

	entity:SetModel(model)
	entity:PhysicsInit(SOLID_VPHYSICS)

	local physObj = entity:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	client:Notify("You have changed the Loot Entity's model to '" .. model .. "'.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyDisplayName", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local displayName = net.ReadString()

	entity:ChangeToolDisplayNameReqAttrib(entity:GetToolDisplayAttribute().tool, displayName, entity:GetToolDisplayAttribute().requiredAttribute)
	client:Notify("You have changed the Loot Entity's display name to '" .. displayName .. "'.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyDescription", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local description = net.ReadString()

	entity:ChangeDescAttribute(description, entity:GetDescAttribute().attribute)
	client:Notify("You have changed the Loot Entity's description to '" .. description .. "'.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyTool", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local tool = net.ReadString()

	entity:ChangeToolDisplayNameReqAttrib(tool, entity:GetToolDisplayAttribute().name, entity:GetToolDisplayAttribute().requiredAttribute)
	client:Notify("You have changed the Loot Entity's required tool to '" .. tool .. "'.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyLootPhrase", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local lootPhrase = net.ReadString()

	entity:ChangeLootInfo(lootPhrase, entity:GetLootInfo().lootSound)
	client:Notify("You have changed the Loot Entity's loot phrase to '" .. lootPhrase .. "'.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyLootSound", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local lootSound = net.ReadString()

	entity:ChangeLootInfo(entity:GetLootInfo().lootPhrase, lootSound)
	client:Notify("You have changed the Loot Entity's loot sound to '" .. lootSound .. "'.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyAttributeName", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local attributeName = net.ReadString()

	entity:ChangeDescAttribute(entity:GetDescAttribute().description, attributeName)
	client:Notify("You have changed the Loot Entity's attribute name to '" .. attributeName .. "'.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyReqAttributeName", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local reqAttributeName = net.ReadString()

	entity:ChangeToolDisplayNameReqAttrib(entity:GetToolDisplayAttribute().tool, entity:GetToolDisplayAttribute().displayName, reqAttributeName)
	client:Notify("You have changed the Loot Entity's required attribute name to '" .. reqAttributeName .. "'.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyAttributeAmount", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local attributeAmount = net.ReadFloat()

	entity:SetAttributeAmount(attributeAmount)
	client:Notify("You have changed the Loot Entity's attribute amount to " .. attributeAmount .. ".")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyReqAttributeAmount", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local requiredAttributeAmount = net.ReadFloat()

	entity:SetRequiredAttributeAmount(requiredAttributeAmount)
	client:Notify("You have changed the Loot Entity's required attribute amount to " .. requiredAttributeAmount .. ".")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyLootTime", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local lootTime = net.ReadUInt(32)

	entity:SetLootTime(lootTime)
	client:Notify("You have changed the Loot Entity's loot time to " .. lootTime .. " seconds.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyInvWidth", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local width = net.ReadUInt(32)

	entity:ChangeInventorySize(width, entity:GetInventoryHeight())
	client:Notify("You have changed the Loot Entity's inventory width to " .. width .. ".")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyInvHeight", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local height = net.ReadUInt(32)

	entity:ChangeInventorySize(entity:GetInventoryWidth(), height)
	client:Notify("You have changed the Loot Entity's inventory height to " .. height .. ".")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyTimer", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local timer = net.ReadUInt(32)

	entity:ChangeTimer(timer)
	client:Notify("You have changed the Loot Entity's timer to " .. timer .. " minutes.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyMinPlayers", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local minPlayers = net.ReadUInt(32)

	entity:SetMinPlayers(minPlayers)
	client:Notify("You have changed the Loot Entity's Minimum Players to " .. minPlayers .. ".")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyDesiredItems", function(_, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local desiredItems = net.ReadUInt(32)

	entity:SetDesiredItemCount(desiredItems)
	client:Notify("You have updated the Loot Entity's desired items.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyLootTable", function(length, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local lootTable = net.ReadData(length / 8)
	local currency = net.ReadUInt(32)

	lootTable = util.Decompress(lootTable)

	entity:SetLootTable(lootTable)
	entity:SetCurrency(currency)
	client:Notify("You have updated the Loot Entity's loot table.")

	PLUGIN:SaveLootEntities()
end)

net.Receive("ixLootentEditPropertyData", function(length, client)
	local entity = net.ReadEntity()

	if (!IsValid(entity) or client.lootent != entity) then return end
	local data = net.ReadString()
	local lootTable = net.ReadData(length / 8)
	lootTable = util.Decompress(lootTable)

	entity:SetDataString(data, lootTable)
	client:Notify("You have updated the Loot Entity's data.")

	PLUGIN:SaveLootEntities()
end)
