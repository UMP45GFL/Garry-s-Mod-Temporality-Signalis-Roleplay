
PLUGIN.name = "Filmgrain effect"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds a filmgrain effect."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
    optFilmgrainEffectEnabled = "Enable filmgrain",
    optFilmgrainEffectAlpha = "Filmgrain noise transparency",
    optFilmgrainEffectAddAlpha = "Filmgrain noise addition",
})

ix.config.Add("filmgrainEffectEnabled", true, "Whether or to enable the filmgrain effect", nil, {
	category = "Visual Effects"
})

if CLIENT then
	ix.option.Add("filmgrainEffectEnabled", ix.type.bool, false, {
		category = "Visual Effects"
	})

	ix.option.Add("filmgrainEffectAlpha", ix.type.number, 5, {
		category = "Visual Effects", min = 1, max = 25
	})

	ix.option.Add("filmgrainEffectAddAlpha", ix.type.number, 5, {
		category = "Visual Effects", min = 1, max = 25
	})
	
	local NoiseTexture = Material("filmgrain/noise")
	local NoiseTexture2 = Material("filmgrain/noiseadd")
	--[[local NoiseTexture = Material(fg_texture:GetString())
	cvars.AddChangeCallback("pp_filmgrain_texture", function (_, __, ___)
		NoiseTexture:SetTexture("$basetexture", fg_texture:GetString())
	end)]]
	
    hook.Add("RenderScreenspaceEffects", "FilmGrain", function()
		if !(ix.config.Get("filmgrainEffectEnabled", true)) or !(ix.option.Get("filmgrainEffectEnabled", true)) then return end
        local alpha = ix.option.Get("filmgrainEffectAlpha", 5)
        local addalpha = ix.option.Get("filmgrainEffectAddAlpha", 5)

        surface.SetMaterial(NoiseTexture)
        surface.SetDrawColor(255, 255, 255, alpha)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		
		surface.SetMaterial(NoiseTexture2)
        surface.SetDrawColor(255, 255, 255, addalpha * 10)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end)
end

-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=3188660391
-- Creator: https://steamcommunity.com/id/Arifuwu
