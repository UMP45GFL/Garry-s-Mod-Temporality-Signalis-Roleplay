
local PLUGIN = PLUGIN
local PANEL = {}

local keyActions = {
	name = {
		onCreate = function(self)
			self:SetTitle("Edit id card's char name")
			self.text:SetPlaceholderText("Enter the new title")

			local item = ix.item.instances[self.itemID]
			if (item) then
				local name = item:GetData("name", nil)
				if name then
					self.text:SetValue(name)
				end
			end
		end,
		onSave = function(self)
			local txt = string.Trim(self.text:GetValue())
			netstream.Start("ixCardSet", self.itemID, "name", txt)
			return true
		end
	},
	issued = {
		onCreate = function(self)
			self:SetTitle("Edit id card's issue date")
			self.text:SetPlaceholderText("Enter the new issue date")

			local item = ix.item.instances[self.itemID]
			if (item) then
				local issued = item:GetData("issued", nil)
				if issued then
					self.text:SetValue(issued)
				end
			end
		end,
		onSave = function(self)
			local txt = string.Trim(self.text:GetValue())
			netstream.Start("ixCardSet", self.itemID, "issued", txt)
			return true
		end
	},
}

function PANEL:AfterInit()
	keyActions[self.dataType].onCreate(self)
end

function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	self:SetSize(600, 200)
	self:Center()
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)

	self.saveButton = self:Add("DButton")
	self.saveButton:Dock(BOTTOM)
	self.saveButton:DockMargin(0, 4, 0, 0)
	self.saveButton:SetText("Save")
	self.saveButton.DoClick = function()
		local txt = string.Trim(self.text:GetValue())

		if string.len(txt) < 3 then
			ix.util.Notify("The ".. self.dataType .." is too short. Min 3 characters.")
			return
		end

		if string.len(txt) > self.maxLength then
			ix.util.Notify("The ".. self.dataType .." is too long. Max "..self.maxLength.." characters.")
			return
		end

		local didSave = keyActions[self.dataType].onSave(self)
		if didSave then
			self:Close()
		end
	end

	self.text = self:Add("DTextEntry")
	self.text:SetMultiline(false)
	self.text:SetEditable(true)
	self.text:SetDisabled(false)
	self.text:SetFont("SignalisDocumentsFontSmall")
	self.text:SetPaintBackground(false)
	self.text:Dock(FILL)
	self.text:SetTextColor(color_white)

	self.text.OnTextChanged = function()
		local text = self.text:GetValue()

		if (text:len() > self.maxLength) then
			local newText = text:sub(1, self.maxLength)
	
			self.text:SetValue(newText)
			self.text:SetText(newText)
			self.text:SetCaretPos(newText:len())
	
			surface.PlaySound("common/talk.wav")
		end
	end

	self:MakePopup()

	self.bEditable = false
	PLUGIN.panel = self
end

vgui.Register("ixGenericEdit", PANEL, "DFrame")
