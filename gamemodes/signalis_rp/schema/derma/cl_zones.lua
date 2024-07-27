
local font_structure = {
	font = "Roboto",
	extended = false,
	size = 32,
	weight = 2000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
}
surface.CreateFont("BR_NEW_ZONE_NAME", font_structure)

our_last_zone = nil
our_last_zone_next = 0
our_last_zone_alpha = 0
our_last_zone_stage = 0

local next_zone_check = 0

hook.Add("Tick", "Eternalis_Local_Zone", function()
	if our_last_zone_stage == 0 then
		local our_zone = LocalPlayer():GetZone()
		if our_zone != our_last_zone and our_zone then
			our_last_zone = our_zone
			our_last_zone_stage = 1
			our_last_zone_alpha = 0
		end
	end
end)


hook.Add("HUDPaint", "Eternalis_Zones", function()
	if our_last_zone_stage > 0 and our_last_zone then
		draw.Text({
			text = our_last_zone.name,
			font = "BR_NEW_ZONE_NAME",
			pos = {36, ScrH() - 24},
			xalign = TEXT_ALIGN_LEFT,
			yalign = TEXT_ALIGN_BOTTOM,
			color = Color(255,255,255, math.Clamp(our_last_zone_alpha, 0, 200))
		})

		if our_last_zone_stage == 1 then
			our_last_zone_alpha = our_last_zone_alpha + 1.5
			if our_last_zone_alpha > 500 then
				our_last_zone_alpha = 255
				our_last_zone_stage = 2
			end
		else
			our_last_zone_alpha = our_last_zone_alpha - 1
			if our_last_zone_alpha < 1 then
				our_last_zone_stage = 0
				our_last_zone_next = 0
				our_last_zone_alpha = 0
			end
		end
	end

	/*
	local zone = LocalPlayer():GetZone()
	if istable(zone) then
		draw.Text( {
			text = zone.name,
			font = "CloseCaption_Normal",
			pos = { ScrW() / 2, ScrH() / 2 }
		} )
	end
	*/
end)
