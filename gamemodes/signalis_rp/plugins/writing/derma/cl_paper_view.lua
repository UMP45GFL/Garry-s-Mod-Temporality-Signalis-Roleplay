
local PLUGIN = PLUGIN
local PANEL = {}

AccessorFunc(PANEL, "itemID", "ItemID", FORCE_NUMBER)

PANEL.page = -1
PANEL.pages = {}

local function splitLines(lines, maxSize)
	surface.SetFont("SignalisDocumentsFontMedium")

	local newLines = {}

	for k,v in pairs(lines) do
		local words = string.Split(v, " ")
		local line = ""

		for k2, v2 in pairs(words) do
			local lineW, lineH = surface.GetTextSize(line .. v2)
			if lineW > maxSize then
				table.insert(newLines, line)
				line = ""
			end
			line = line .. v2 .. " "
		end

		table.insert(newLines, line)
	end
	return newLines
end

local turnPageSound = "eternalis/signalis_ui/page_turn.wav"
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
		if self.page > 0 then
			if img_alpha > 10 then
				img_alpha = img_alpha - 2
			else
				img_alpha = 10
			end
		end
	end

	surface.SetFont("SignalisDocumentsFontBig")
	local fW, fH = surface.GetTextSize("< 00 / 00 >")

	local pW = fW * 1.1
	local pH = fH * 1.1

	self.close = self:Add("DButton")
	self.close:Dock(BOTTOM)
	self.close:SetHeight(pH)
	self.close:DockPadding(0, pH / 12, 0, pH / 12)
	self.close:SetText(L("close"))
	self.close:SetFont("SignalisDocumentsFontMedium")
	self.close.DoClick = function()
		self:Close()
	end

	local pagePanel = self:Add("DPanel")
	pagePanel:SetSize(pW, pH)
	pagePanel:SetPos(ScrW() / 2 - (pW / 2), ScrH() - (ScrH() / 6) - pH + 4)
	pagePanel.Paint = function(this, w, h)
		if self.page > 0 then
			local page = self.page
			local maxPages = #self.pages
			if self.startFromPage0 then
				page = page - 1
				maxPages = maxPages - 1
			end
			draw.TextShadow({
				text = "0" .. page .. " / 0" .. (maxPages),
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
	buttonPageLeft:SetSize(pH, pH)
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

	local buttonPageRight = pagePanel:Add("DButton")
	buttonPageRight:SetText("")
	buttonPageRight:SetSize(pH, pH)
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

	local tW = ScrW() * 0.65
	local tH = ScrH() * 0.5

	if ScrW() < 1600 then
		tW = ScrW() * 0.8
		tH = ScrH() * 0.6
	end

	self.scrollpanel = self:Add("DScrollPanel")
	self.scrollpanel:SetPos(ScrW() / 2 - (tW / 2), ScrH() / 2 - (tH / 2))
	self.scrollpanel:SetSize(tW, tH)

	local textPanels = {}
	local function populatePages()
		for k,v in pairs(textPanels) do
			v:Remove()
		end

		if self.pages[self.page] then
			local textHeight = ScreenScaleH(15) * 1.1

			if isstring(self.pages[self.page]) then
				local preparedLines = string.Split(self.pages[self.page], "\n")
				preparedLines = splitLines(preparedLines, tW)

				for k,v in ipairs(preparedLines) do
					local textPanel = self.scrollpanel:Add("DPanel")
					textPanel:SetSize(tW, textHeight)
					textPanel:Dock(TOP)
					textPanel.Paint = function(this, w, h)
						draw.TextShadow({
							text = v,
							font = "SignalisDocumentsFontMedium",
							pos = {8, h / 2},
							xalign = TEXT_ALIGN_LEFT,
							yalign = TEXT_ALIGN_CENTER,
							color = color_white
						}, 1, 255)
					end
					table.insert(textPanels, textPanel)
					self.scrollpanel:AddItem(textPanel)
				end
			end

			if istable(self.pages[self.page]) then
				local posY = 8
				for k, v in pairs(self.pages[self.page]) do
					local txt = ""
					local clr = color_white
					local xalign = TEXT_ALIGN_LEFT

					if isstring(v) then
						txt = v
					end

					if istable(v) then
						txt = v[1]
						if v[2] then
							clr = v[2]
						end
						if v[3] then
							xalign = v[3]
						end
					end

					local preparedLines = string.Split(txt, "\n")
					preparedLines = splitLines(preparedLines, tW)

					for i, v2 in ipairs(preparedLines) do
						local textPanel = self.scrollpanel:Add("DPanel")
						textPanel:SetSize(tW, textHeight)
						textPanel:Dock(TOP)
						textPanel.Paint = function(this, w, h)
							local posX = 8
							if xalign == TEXT_ALIGN_CENTER then
								posX = w / 2
							end
							draw.TextShadow({
								text = v2,
								font = "SignalisDocumentsFontMedium",
								pos = {posX, h / 2},
								xalign = xalign,
								yalign = TEXT_ALIGN_CENTER,
								color = color_white
							}, 1, 255)
						end
						table.insert(textPanels, textPanel)
						self.scrollpanel:AddItem(textPanel)
					end
				end
			end
		end
	end

	buttonPageLeft.DoClick = function()
		if nextPageTurn < CurTime() and self.page > 1 then
			self.page = self.page - 1
			surface.PlaySound(turnPageSound)
			nextPageTurn = CurTime() + 0.3
			populatePages()
		end
	end

	buttonPageRight.DoClick = function()
		if nextPageTurn < CurTime() and self.page > -1 and self.page < #self.pages then
			self.page = self.page + 1
			surface.PlaySound(turnPageSound)
			nextPageTurn = CurTime() + 0.3
			populatePages()
		end
	end

	populatePages()

	self:MakePopup()
	PLUGIN.panel = self
end

function PANEL:OnRemove()
	PLUGIN.panel = nil
end

vgui.Register("ixPaperView", PANEL, "DFrame")
