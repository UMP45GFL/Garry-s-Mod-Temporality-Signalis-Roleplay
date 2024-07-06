
PLUGIN.name = "Low health effects system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds screen effects when the player has low health."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	optLowHealthEffectsEnabled = "Enable low health effects.",
})

ix.config.Add("lowHealthEffectsSystemEnabled", true, "Enable the low health effects system", nil, {
	category = "Visual Effects"
})

ix.config.Add("lowHealthEffectsHealthThreshold", 25, "Low health effects health threshold", nil, {
	data = {min = 1, max = 100},
	category = "Visual Effects"
})

ix.config.Add("lowHealthEffectsEnableHeartbeat", true, "Enable heartbeat on low health", nil, {
	category = "Visual Effects"
})

ix.config.Add("lowHealthEffectsEnableRedFlash", true, "Enable red flashing on low health", nil, {
	category = "Visual Effects"
})

ix.config.Add("lowHealthEffectsEnableVignette", true, "Enable vignette on low health", nil, {
	category = "Visual Effects"
})

ix.config.Add("lowHealthEffectsEnableMuffleEffect", true, "Enable effect of sounds becoming muffled when low health", nil, {
	category = "Visual Effects"
})

ix.config.Add("lowHealthEffectsEnableMuffleEffectThreshold", 10, "Low health sound muffling health threshold", nil, {
	data = {min = 1, max = 100},
	category = "Visual Effects"
})

ix.option.Add("lowHealthEffectsEnabled", ix.type.bool, true, {
	category = "Visual Effects"
})

if SERVER then
	resource.AddFile("materials/vgui/vignette_w.vmt")
	resource.AddFile("sound/lowhp/hbeat.wav")
end

local etb_vignette = GetConVar( "etb_vignette" )
local etb_muffle_effect = GetConVar( "etb_muffle_effect" )

if CLIENT then
	local intensity = 0
	local hpwait, hpalpha = 0, 0
	local vig = surface.GetTextureID("vgui/vignette_w")
	
	local clr = {
		[ "$pp_colour_addr" ] = 0,
		[ "$pp_colour_addg" ] = 0,
		[ "$pp_colour_addb" ] = 0,
		[ "$pp_colour_brightness" ] = 0,
		[ "$pp_colour_contrast" ] = 1,
		[ "$pp_colour_colour" ] = 1,
		[ "$pp_colour_mulr" ] = 0,
		[ "$pp_colour_mulg" ] = 0,
		[ "$pp_colour_mulb" ] = 0
	}

	local function LowHP_HUDPaint()
		if !(ix.config.Get("lowHealthEffectsSystemEnabled", true)) or !(ix.option.Get("lowHealthEffectsEnabled", true)) then return end
		
		local ply = LocalPlayer()
		local hp = ply:Health()
		local x, y = ScrW(), ScrH()
		local FT = FrameTime()
		
		if ix.config.Get("lowHealthEffectsEnableMuffleEffect", true) then
			if ply:Health() <= ix.config.Get("lowHealthEffectsEnableMuffleEffectThreshold", 10) then
				if not ply.lastDSP then
					ply:SetDSP(14)
					ply.lastDSP = 14
				end
			else
				if ply.lastDSP then
					ply:SetDSP(0)
					ply.lastDSP = nil
				end
			end
		end
		
		local threshold = ix.config.Get("lowHealthEffectsHealthThreshold", 25)

		intensity = math.Approach(intensity, math.Clamp(1 - math.Clamp(hp / threshold, 0, 1), 0, 1), FT * 3)
		
		if intensity > 0 then
			if ix.config.Get("lowHealthEffectsEnableVignette", true) then
				surface.SetDrawColor(0, 0, 0, 200 * intensity)
				surface.SetTexture(vig)
				surface.DrawTexturedRect(0, 0, x, y)
			end
			
			clr[ "$pp_colour_colour" ] = 1 - intensity
			DrawColorModify(clr)
			
			if ply:Alive() then
				local CT = CurTime()
				
				if ix.config.Get("lowHealthEffectsEnableHeartbeat", true) then
					if CT > hpwait then
						ply:EmitSound("lowhp/hbeat.wav", 45 * intensity, 100 + 20 * intensity)
						hpwait = CT + 0.5
					end
				end
				
				if ix.config.Get("lowHealthEffectsEnableRedFlash", true) then
					surface.SetDrawColor(255, 0, 0, (50 * intensity) * hpalpha)
					surface.DrawTexturedRect(0, 0, x, y)
					
					if CT < hpwait - 0.4 then
						hpalpha = math.Approach(hpalpha, 1, FrameTime() * 10)
					else
						hpalpha = math.Approach(hpalpha, 0.33, FrameTime() * 10)
					end
				end
			end
		end	
	end
	
	hook.Add("HUDPaint", "LowHP_HUDPaint", LowHP_HUDPaint)
end
