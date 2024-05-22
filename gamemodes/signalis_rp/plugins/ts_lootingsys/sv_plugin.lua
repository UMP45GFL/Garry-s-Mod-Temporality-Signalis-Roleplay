
util.AddNetworkString("ixLootentEditPropertyModel")
util.AddNetworkString("ixLootentEditPropertyDisplayName")
util.AddNetworkString("ixLootentEditPropertyDescription")
util.AddNetworkString("ixLootentEditPropertyTool")
util.AddNetworkString("ixLootentEditPropertyInvWidth")
util.AddNetworkString("ixLootentEditPropertyInvHeight")
util.AddNetworkString("ixLootentEditPropertyTimer")
util.AddNetworkString("ixLootentEditPropertyMinPlayers")
util.AddNetworkString("ixLootentEditPropertyLootTable")
util.AddNetworkString("ixLootentEditPropertyDesiredItems")
util.AddNetworkString("ixLootentEditPropertyData")
util.AddNetworkString("ixLootentEditPropertyLootPhrase")
util.AddNetworkString("ixLootentEditPropertyLootTime")
util.AddNetworkString("ixLootentEditPropertyLootSound")
util.AddNetworkString("ixLootentEditPropertyAttributeName")
util.AddNetworkString("ixLootentEditPropertyAttributeAmount")
util.AddNetworkString("ixLootentEditPropertyReqAttributeName")
util.AddNetworkString("ixLootentEditPropertyReqAttributeAmount")
util.AddNetworkString("ixPopulateLootentEditor")

ix.log.AddType("openLootent", function(client, ...)
	local arg = {...}
	return string.format("%s opened the '%s' #%d loot entity.", client:Name(), arg[1], arg[2])
end, FLAG_NORMAL)

ix.log.AddType("closeLootent", function(client, ...)
	local arg = {...}
	return string.format("%s closed the '%s' #%d loot entity.", client:Name(), arg[1], arg[2])
end, FLAG_NORMAL)

function PLUGIN:SaveLootEntities()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_lootent")) do
		data[#data + 1] = {
			pos = v:GetPos(),
			ang = v:GetAngles(),
			timer = v:GetTimer(),
			minPlayers = v:GetMinPlayers(),
			itemCount = v:GetDesiredItemCount(),
			invWidth = v:GetInventoryWidth(),
			invHeight = v:GetInventoryHeight(),
			tool = v:GetToolDisplayAttribute().tool,
			loot = v:GetLootTable(true),
			name = v:GetToolDisplayAttribute().displayName,
			desc = v:GetDescAttribute().description,
			currency = v:GetCurrency(),
			model = v:GetModel(),
			lootPhrase = v:GetLootInfo().lootPhrase,
			lootSound = v:GetLootInfo().lootSound,
			lootTime = v:GetLootTime(),
			attribute = v:GetDescAttribute().attribute,
			attributeAmount = v:GetAttributeAmount(),
			requiredAttribute = v:GetToolDisplayAttribute().requiredAttribute,
			requiredAttributeAmount = v:GetRequiredAttributeAmount()
		}
	end

	ix.data.Set("lootEntities", data)
end

function PLUGIN:LoadLootEntities()
	for _, v in ipairs(ix.data.Get("lootEntities") or {}) do
		local entity = ents.Create("ix_lootent")

		entity:SetPos(v.pos)
		entity:SetAngles(v.ang)
		entity:Spawn()

		entity:SetModel(v.model)
		entity:PhysicsInit(SOLID_VPHYSICS)

		local physObj = entity:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		entity:ChangeToolDisplayNameReqAttrib(v.tool, v.name, v.requiredAttribute)
		entity:ChangeDescAttribute(v.desc, v.attribute)
		entity:SetInventoryWidth(v.invWidth)
		entity:SetInventoryHeight(v.invHeight)
		entity:SetMinPlayers(v.minPlayers)
		entity:SetLootTable(v.loot)
		entity:SetDesiredItemCount(v.itemCount)
		entity:ChangeTimer(v.timer)
		entity:SetCurrency(v.currency)
		entity:ChangeLootInfo(v.lootPhrase, v.lootSound)
		entity:SetLootTime(v.lootTime)
		entity:SetAttributeAmount(v.attributeAmount)
		entity:SetRequiredAttributeAmount(v.requiredAttributeAmount)
	end
end
