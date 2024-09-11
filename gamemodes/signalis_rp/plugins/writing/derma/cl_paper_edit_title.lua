
local PLUGIN = PLUGIN
local PANEL = {}

AccessorFunc(PANEL, "itemID", "ItemID", FORCE_NUMBER)

local maxLength = 32

function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	self:SetSize(400, 400)
	self:Center()
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)
	self:SetTitle("Setting title")
	self.OnClose = function()
		netstream.Start("ixWritingSetTitle", self.itemID, self.text:GetValue())
	end

	self.close = self:Add("DButton")
	self.close:Dock(BOTTOM)
	self.close:DockMargin(0, 4, 0, 0)
	self.close:SetText(L("close"))
	self.close.DoClick = function()
		self:Close()
	end

	self.text = self:Add("DTextEntry")
	self.text:SetMultiline(true)
	self.text:SetEditable(true)
	self.text:SetDisabled(false)
	self.text:SetFont("SignalisDocumentsFontMedium")
	self.text:SetPaintBackground(false)
	self.text:Dock(FILL)
	self.text:SetTextColor(color_white)

	self:MakePopup()

	self.bEditable = false
	PLUGIN.panel = self
end

function PANEL:Think()
	local text = self.text:GetValue()

	if (text:len() > maxLength) then
		local newText = text:sub(1, maxLength)

		self.text:SetValue(newText)
		self.text:SetCaretPos(newText:len())

		surface.PlaySound("common/talk.wav")
	end
end

vgui.Register("ixPaperEditTitle", PANEL, "DFrame")
