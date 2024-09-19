
local PLUGIN = PLUGIN
local PANEL = {}

AccessorFunc(PANEL, "itemID", "ItemID", FORCE_NUMBER)

local maxLength = 16

function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	self:SetSize(600, 200)
	self:Center()
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)
	self:SetTitle("Edit id card char name")

	self.saveButton = self:Add("DButton")
	self.saveButton:Dock(BOTTOM)
	self.saveButton:DockMargin(0, 4, 0, 0)
	self.saveButton:SetText("Save")
	self.saveButton.DoClick = function()
		local txt = string.Trim(self.text:GetValue())

		if string.len(txt) < 3 then
			ix.util.Notify("The name is too short. Min 3 characters.")
			return
		end

		if string.len(txt) > maxLength then
			ix.util.Notify("The name is too long. Max "..maxLength.." characters.")
			return
		end

		netstream.Start("ixCardSet", self.itemID, txt)
		self:Close()
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

		if (text:len() > maxLength) then
			local newText = text:sub(1, maxLength)
	
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

vgui.Register("ixCardEdit", PANEL, "DFrame")
