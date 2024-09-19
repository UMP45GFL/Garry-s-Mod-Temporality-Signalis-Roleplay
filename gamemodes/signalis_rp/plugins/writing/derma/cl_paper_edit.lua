
local PLUGIN = PLUGIN
local PANEL = {}

AccessorFunc(PANEL, "bEditable", "Editable", FORCE_BOOL)
AccessorFunc(PANEL, "itemID", "ItemID", FORCE_NUMBER)

PANEL.page = 1
PANEL.pages = {}

function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	self:SetSize(700, 400)
	self:Center()
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)
	self:SetTitle("Edit paper text")

	self.close = self:Add("DButton")
	self.close:Dock(BOTTOM)
	self.close:DockMargin(0, 4, 0, 0)
	self.close:SetText(L("close"))
	self.close.DoClick = function()
		if (self.bEditable) then
			self.pages[self.page] = self.text:GetValue()
			netstream.Start("ixWritingEdit", self.itemID, self.pages)
		end

		self:Close()
	end

	local panel = self:Add("DPanel")
	panel:Dock(FILL)

	local bW = 48

	local pagePanel = panel:Add("DPanel")
	pagePanel:SetHeight(bW)
	pagePanel:Dock(BOTTOM)
	pagePanel.Paint = function(this, w, h)
		draw.TextShadow({
			text = "Page: " .. self.page,
			font = "SignalisDocumentsFontMedium",
			pos = {w / 2, h / 2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = color_white
		}, 1, 255)
	end

	local buttonPageLeft = pagePanel:Add("DButton")
	buttonPageLeft:SetText("")
	buttonPageLeft:SetSize(bW, bW)
	buttonPageLeft:Dock(LEFT)
	buttonPageLeft.Paint = function(this, w, h)
		draw.TextShadow({
			text = "<",
			font = "SignalisDocumentsFontBig",
			pos = {w / 2, h / 2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = color_white
		}, 1, 255)
	end
	buttonPageLeft.DoClick = function()
		if self.page > 1 then
			self.pages[self.page] = self.text:GetValue()

			self.page = self.page - 1
			self.text:SetValue(self.pages[self.page] or "")
		end
	end

	local buttonPageRight = pagePanel:Add("DButton")
	buttonPageRight:SetText("")
	buttonPageRight:SetSize(bW, bW)
	buttonPageRight:Dock(RIGHT)
	buttonPageRight.Paint = function(this, w, h)
		draw.TextShadow({
			text = ">",
			font = "SignalisDocumentsFontBig",
			pos = {w / 2, h / 2},
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
			color = color_white
		}, 1, 255)
	end
	buttonPageRight.DoClick = function()
		--if self.page > 1 and self.page + 1 <= self.maxPages then
		if string.len( self.text:GetValue() ) > 0 then
			self.pages[self.page] = self.text:GetValue()

			self.page = self.page + 1
			self.text:SetValue(self.pages[self.page] or "")
		end
	end

	self.text = panel:Add("DTextEntry")
	self.text:SetMultiline(true)
	self.text:SetEditable(false)
	self.text:SetDisabled(true)
	self.text:SetFont("SignalisDocumentsFontSmall")
	self.text:SetPaintBackground(false)
	self.text:Dock(FILL)
	self.text:SetTextColor(color_white)

	self.text.OnTextChanged = function()
		local text = self.text:GetValue()

		if (text:len() > PLUGIN.maxLength) then
			local newText = text:sub(1, PLUGIN.maxLength)
	
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

function PANEL:SetEditable(bValue)
	bValue = tobool(bValue)

	if (bValue == self.bEditable) then
		return
	end

	if (bValue) then
		self.close:SetText(L("save"))
		self.text:SetEditable(true)
		self.text:SetDisabled(false)
	else
		self.close:SetText(L("close"))
		self.text:SetEditable(false)
		self.text:SetDisabled(true)
	end

	self.bEditable = bValue
end

function PANEL:SetText(text)
	self.text:SetValue(text)
	self.pages[self.page] = text
end

function PANEL:SetPages(pages)
	self.pages = pages
	self.text:SetValue(pages[self.page] or "")
end

function PANEL:OnRemove()
	PLUGIN.panel = nil
end

vgui.Register("ixPaperEdit", PANEL, "DFrame")
