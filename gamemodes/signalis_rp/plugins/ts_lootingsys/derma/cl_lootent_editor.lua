
local PANEL = {}

function PANEL:Init()
	self:SetSize(1200, 500)
	self:Center()
	self:SetTitle("Loot Entity Editor")
	self:MakePopup()
end

function PANEL:Populate(entity)
	self.model = self:Add("ixSettingsRowString")
	self.model:Dock(TOP)
	self.model:SetText("Model")
	self.model:SetValue(entity:GetModel())
	function self.model:OnValueChanged(value)
		net.Start("ixLootentEditPropertyModel")
			net.WriteEntity(entity)
			net.WriteString(value)
		net.SendToServer()
	end

	self.displayName = self:Add("ixSettingsRowString")
	self.displayName:Dock(TOP)
	self.displayName:SetText("Display Name")
	self.displayName:SetValue(entity:GetToolDisplayAttribute().displayName)
	function self.displayName:OnValueChanged(value)
		net.Start("ixLootentEditPropertyDisplayName")
			net.WriteEntity(entity)
			net.WriteString(value)
		net.SendToServer()
	end

	self.description = self:Add("ixSettingsRowString")
	self.description:Dock(TOP)
	self.description:SetText("Description")
	self.description:SetValue(entity:GetDescAttribute().description)
	function self.description:OnValueChanged(value)
		net.Start("ixLootentEditPropertyDescription")
			net.WriteEntity(entity)
			net.WriteString(value)
		net.SendToServer()
	end

	self.tool = self:Add("ixSettingsRowString")
	self.tool:Dock(TOP)
	self.tool:SetText("Required Tool")
	self.tool:SetValue(entity:GetToolDisplayAttribute().tool)
	function self.tool:OnValueChanged(value)
		net.Start("ixLootentEditPropertyTool")
			net.WriteEntity(entity)
			net.WriteString(value)
		net.SendToServer()
	end

	self.lootPhrase = self:Add("ixSettingsRowString")
	self.lootPhrase:Dock(TOP)
	self.lootPhrase:SetText("Loot Phrase")
	self.lootPhrase:SetValue(entity:GetLootInfo().lootPhrase)
	function self.lootPhrase:OnValueChanged(value)
		net.Start("ixLootentEditPropertyLootPhrase")
			net.WriteEntity(entity)
			net.WriteString(value)
		net.SendToServer()
	end

	self.lootSound = self:Add("ixSettingsRowString")
	self.lootSound:Dock(TOP)
	self.lootSound:SetText("Loot Sound")
	self.lootSound:SetValue(entity:GetLootInfo().lootSound)
	function self.lootSound:OnValueChanged(value)
		net.Start("ixLootentEditPropertyLootSound")
			net.WriteEntity(entity)
			net.WriteString(value)
		net.SendToServer()
	end

	self.attributeName = self:Add("ixSettingsRowArray")
	self.attributeName:Dock(TOP)
	self.attributeName:SetText("Attribute Name")
	self.attributeName:Populate("Attribute Name", {populate = function()
		local list = {}

		list["None"] = "None"
		for k, v in pairs(ix.attributes.list) do
			list[k] = v.name
		end

		return list
	end})
	self.attributeName:SetValue(entity:GetDescAttribute().attribute)
	function self.attributeName:OnValueChanged(value)
		net.Start("ixLootentEditPropertyAttributeName")
			net.WriteEntity(entity)
			net.WriteString(value)
		net.SendToServer()
	end

	self.reqAttributeName = self:Add("ixSettingsRowArray")
	self.reqAttributeName:Dock(TOP)
	self.reqAttributeName:SetText("Required Attribute Name")
	self.reqAttributeName:Populate("Required Attribute Name", {populate = function()
		local list = {}

		list["None"] = "None"
		for k, v in pairs(ix.attributes.list) do
			list[k] = v.name
		end

		return list
	end})
	self.reqAttributeName:SetValue(entity:GetToolDisplayAttribute().requiredAttribute)
	function self.reqAttributeName:OnValueChanged(value)
		net.Start("ixLootentEditPropertyReqAttributeName")
			net.WriteEntity(entity)
			net.WriteString(value)
		net.SendToServer()
	end

	self.attributeAmount = self:Add("ixSettingsRowNumber")
	self.attributeAmount:Dock(TOP)
	self.attributeAmount:SetText("Attribute Amount")
	self.attributeAmount:SetMin(0)
	self.attributeAmount:SetMax(ix.config.Get("maxAttributes", 100))
	self.attributeAmount:SetDecimals(2)
	self.attributeAmount:SetValue(entity:GetAttributeAmount())
	function self.attributeAmount:OnValueChanged(value)
		net.Start("ixLootentEditPropertyAttributeAmount")
			net.WriteEntity(entity)
			net.WriteFloat(value)
		net.SendToServer()
	end

	self.reqAttributeAmount = self:Add("ixSettingsRowNumber")
	self.reqAttributeAmount:Dock(TOP)
	self.reqAttributeAmount:SetText("Required Attribute Amount")
	self.reqAttributeAmount:SetMin(0)
	self.reqAttributeAmount:SetMax(ix.config.Get("maxAttributes", 100))
	self.reqAttributeAmount:SetDecimals(2)
	self.reqAttributeAmount:SetValue(entity:GetRequiredAttributeAmount())
	function self.reqAttributeAmount:OnValueChanged(value)
		net.Start("ixLootentEditPropertyReqAttributeAmount")
			net.WriteEntity(entity)
			net.WriteFloat(value)
		net.SendToServer()
	end

	self.lootTime = self:Add("ixSettingsRowNumber")
	self.lootTime:Dock(TOP)
	self.lootTime:SetText("Loot Time")
	self.lootTime:SetMin(0)
	self.lootTime:SetMax(60)
	self.lootTime:SetDecimals(0)
	self.lootTime:SetValue(entity:GetLootTime())
	function self.lootTime:OnValueChanged(value)
		net.Start("ixLootentEditPropertyLootTime")
			net.WriteEntity(entity)
			net.WriteUInt(value, 32)
		net.SendToServer()
	end

	self.invWidth = self:Add("ixSettingsRowNumber")
	self.invWidth:Dock(TOP)
	self.invWidth:SetText("Inventory Width")
	self.invWidth:SetMin(1)
	self.invWidth:SetMax(12)
	self.invWidth:SetDecimals(0)
	self.invWidth:SetValue(entity:GetInventoryWidth())
	function self.invWidth:OnValueChanged(value)
		net.Start("ixLootentEditPropertyInvWidth")
			net.WriteEntity(entity)
			net.WriteUInt(value, 32)
		net.SendToServer()
	end

	self.invHeight = self:Add("ixSettingsRowNumber")
	self.invHeight:Dock(TOP)
	self.invHeight:SetText("Inventory Height")
	self.invHeight:SetMin(1)
	self.invHeight:SetMax(12)
	self.invHeight:SetDecimals(0)
	self.invHeight:SetValue(entity:GetInventoryHeight())
	function self.invHeight:OnValueChanged(value)
		net.Start("ixLootentEditPropertyInvHeight")
			net.WriteEntity(entity)
			net.WriteUInt(value, 32)
		net.SendToServer()
	end

	self.timer = self:Add("ixSettingsRowNumber")
	self.timer:Dock(TOP)
	self.timer:SetText("Reset Timer")
	self.timer:SetMin(1)
	self.timer:SetMax(60)
	self.timer:SetDecimals(0)
	self.timer:SetValue(entity:GetTimer())
	function self.timer:OnValueChanged(value)
		net.Start("ixLootentEditPropertyTimer")
			net.WriteEntity(entity)
			net.WriteUInt(value, 32)
		net.SendToServer()
	end

	self.minPlayers = self:Add("ixSettingsRowNumber")
	self.minPlayers:Dock(TOP)
	self.minPlayers:SetText("Minimum Players")
	self.minPlayers:SetMin(1)
	self.minPlayers:SetMax(16)
	self.minPlayers:SetDecimals(0)
	self.minPlayers:SetValue(entity:GetMinPlayers())
	function self.minPlayers:OnValueChanged(value)
		net.Start("ixLootentEditPropertyMinPlayers")
			net.WriteEntity(entity)
			net.WriteUInt(value, 32)
		net.SendToServer()
	end

	self.desiredItems = self:Add("ixSettingsRowNumber")
	self.desiredItems:Dock(TOP)
	self.desiredItems:SetText("Desired Item Count")
	self.desiredItems:SetMin(1)
	self.desiredItems:SetMax(entity:GetInventoryWidth() * entity:GetInventoryHeight())
	self.desiredItems:SetDecimals(0)
	self.desiredItems:SetValue(entity:GetDesiredItemCount())
	function self.desiredItems:OnValueChanged(value)
		net.Start("ixLootentEditPropertyDesiredItems")
			net.WriteEntity(entity)
			net.WriteUInt(value, 32)
		net.SendToServer()
	end

	self.lootTable = self:Add("ixMenuButton")
	self.lootTable:Dock(TOP)
	self.lootTable:SetText("Edit Loot Table")
	self.lootTable:SetContentAlignment(5)
	self.lootTable:SizeToContents()
	function self.lootTable.DoClick()
		vgui.Create("ixLootTableEditor"):Populate(entity, util.JSONToTable(entity.lootTable or "[]"))
	end

	self.data = self:Add("ixSettingsRowString")
	self.data:Dock(TOP)
	self.data:SetText("Data String")
	self.data:SetValue(entity:GetDataString())
	function self.data:OnValueChanged()
		local data = self:GetValue()
		local toTable = util.JSONToTable(data)
		local lootTable = toTable.loot
		toTable.loot = nil
		data = util.TableToJSON(toTable)

		lootTable = util.Compress(lootTable)

		net.Start("ixLootentEditPropertyData")
			net.WriteEntity(entity)
			net.WriteString(data)
			net.WriteData(lootTable, #lootTable)
		net.SendToServer()
	end

	self:InvalidateLayout(true)
	self:SizeToChildren(false, true)
	self:Center()
end

vgui.Register("ixLootentEditor", PANEL, "DFrame")

PANEL = {}

function PANEL:Init()
	self:SetSize(1000, 800)
	self:Center()
	self:SetTitle("Loot Table Editor")
	self:MakePopup()

	self.searchEntry = self:Add("ixIconTextEntry")
	self.searchEntry:Dock(TOP)
	self.searchEntry:SetEnterAllowed(false)
	self.searchEntry.OnChange = function(entry)
		self.settingsPanel:FilterRows(entry:GetValue())
	end

	self.settingsPanel = self:Add("ixSettings")
	self.settingsPanel:Dock(FILL)
	self.settingsPanel:DockMargin(0, 0, 0, 0)

	local saveChanges = self:Add("ixMenuButton")
	saveChanges:Dock(BOTTOM)
	saveChanges:SetText("Save Changes")
	saveChanges:SetContentAlignment(5)
	saveChanges:SizeToContents()
	saveChanges.DoClick = function()
		local rowTable = {}
		local currency = 0

		for uniqueID, value in pairs(self.lootTable) do
			if (value <= 0) then continue end
			if (uniqueID == "currency") then currency = value continue end

			rowTable[uniqueID] = value
		end

		rowTable = util.Compress(util.TableToJSON(rowTable))

		net.Start("ixLootentEditPropertyLootTable")
			net.WriteEntity(self.entity)
			net.WriteData(rowTable, #rowTable)
			net.WriteUInt(currency, 32)
		net.SendToServer()
	end
end

function PANEL:Populate(entity, lootTable)
	self.entity = entity
	self.lootTable = lootTable or {}

	self.settingsPanel:AddCategory("Currency")
	local currency = self.settingsPanel:AddRow(ix.type.number, "Currency")
	currency:SetText(ix.util.ExpandCamelCase(ix.currency.plural))
	currency:SetMin(0)
	currency:SetMax(100)
	currency:SetDecimals(0)
	currency:SetValue(entity:GetCurrency())
	currency.OnValueChanged = function(this, value)
		self.lootTable.currency = value
	end

	-- loop through all item categories and create categories for them
	for k, v in SortedPairsByMemberValue(ix.item.list, "category") do
		self.settingsPanel[v.category] = self.settingsPanel[v.category] or self.settingsPanel:AddCategory(v.category)

		local item = self.settingsPanel:AddRow(ix.type.number, v.category)
		item:SetText(v.name)
		item:SetMin(0)
		item:SetMax(100)
		item:SetDecimals(0)
		item:SetValue(self.lootTable[v.uniqueID] or 0)
		item.uniqueID = v.uniqueID
		item.OnValueChanged = function(this, value)
			self.lootTable[v.uniqueID] = value
		end
	end

	self.settingsPanel:SizeToContents()
end

vgui.Register("ixLootTableEditor", PANEL, "DFrame")
