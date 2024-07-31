
local PLUGIN = PLUGIN
local PANEL = {}

AccessorFunc(PANEL, "itemID", "ItemID", FORCE_NUMBER)

PANEL.page = -1
PANEL.pages = {}

local turnPageSound = "signalis_ui/page_turn.wav"
local nextPageTurn = 0
function PANEL:Init()
	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	nextPageTurn = CurTime() + 1

	self:SetSize(ScrW(), ScrH())
	self:Center()
	self:SetBackgroundBlur(true)
	self:SetDeleteOnClose(true)
	self:ShowCloseButton(false)
	self:SetDraggable(false)
	self:SetTitle(L("paper"))
	self.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, w, h)

		/*
		if self.page > 0 then
			draw.TextShadow({
				text = self.pages[self.page],
				font = "SignalisDocumentsFontMedium",
				pos = {w / 2, h * 0.45},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				color = color_white
			}, 1, 255)
		end
		*/
	end

	local img_alpha = 0
	local img_bg = vgui.Create("DImage", self)
	self.img_bg = img_bg
	img_bg:SetSize(ScrW(), ScrH())
	img_bg:SetImageColor(Color(255, 255, 255, img_alpha))
	img_bg.Think = function(this)
		img_bg:SetImageColor(Color(255, 255, 255, img_alpha))
		if self.page == -1 then
			if img_alpha < 255 then
				img_alpha = img_alpha + 2
			else
				img_alpha = 255
				self.page = 0
			end
		end
		if self.page == 1 then
			if img_alpha > 10 then
				img_alpha = img_alpha - 2
			else
				img_alpha = 10
			end
		end
	end

	self.close = self:Add("DButton")
	self.close:Dock(BOTTOM)
	self.close:SetHeight(48)
	self.close:DockMargin(0, 8, 0, 0)
	self.close:SetText(L("close"))
	self.close:SetFont("SignalisDocumentsFontMedium")
	self.close.DoClick = function()
		self:Close()
	end

	local bW = 48
	local pW = 256
	local pH = 48
	local pagePanel = self:Add("DPanel")
	pagePanel:SetSize(pW, pH)
	pagePanel:SetPos(ScrW() / 2 - (pW / 2), ScrH() - (ScrH() / 6) - pH + 4)
	pagePanel.Paint = function(this, w, h)
		if self.page > 0 then
			local page = self.page
			if self.startFromPage0 then
				page = page - 1
			end
			draw.TextShadow({
				text = "0" .. page .. " / 0" .. (#self.pages - 1),
				font = "SignalisDocumentsFontBig",
				pos = {w / 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				color = color_white
			}, 1, 255)
		end
	end

	local buttonPageLeft = pagePanel:Add("DButton")
	buttonPageLeft:SetText("")
	buttonPageLeft:SetSize(bW, bW)
	buttonPageLeft:Dock(LEFT)
	buttonPageLeft.Paint = function(this, w, h)
		if self.page > 0 then
			draw.TextShadow({
				text = "<",
				font = "SignalisDocumentsFontBig",
				pos = {w / 2, h / 2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				color = color_white
			}, 1, 255)
		end
	end
	buttonPageLeft.DoClick = function()
		if nextPageTurn < CurTime() and self.page > 1 then
			self.page = self.page - 1
			self.text:SetValue(self.pages[self.page] or "")
			surface.PlaySound(turnPageSound)
			nextPageTurn = CurTime() + 0.3
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
		if nextPageTurn < CurTime() and self.page > -1 and self.page < #self.pages then
			self.page = self.page + 1
			self.text:SetValue(self.pages[self.page] or "")
			surface.PlaySound(turnPageSound)
			nextPageTurn = CurTime() + 0.3
		end
	end

	local tW = ScrW() * 0.75
	local tH = ScrH() * 0.4

	self.text = self:Add("DTextEntry")
	self.text:SetMultiline(true)
	self.text:SetEditable(false)
	self.text:SetDisabled(true)
	self.text:SetFont("SignalisDocumentsFontBig")
	self.text:SetPaintBackground(false)
	self.text:SetPos(ScrW() / 2 - (tW / 2), ScrH() / 2 - (tH / 2))
	self.text:SetSize(tW, tH)
	self.text:SetTextColor(color_white)

	self:MakePopup()
	PLUGIN.panel = self
end

function PANEL:OnRemove()
	PLUGIN.panel = nil
end

vgui.Register("ixPaperView", PANEL, "DFrame")
