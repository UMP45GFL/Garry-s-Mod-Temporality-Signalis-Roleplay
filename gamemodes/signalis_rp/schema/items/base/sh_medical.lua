
ITEM.name = "Medical Base"
ITEM.model = "models/eternalis/items/medical/bandage.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Medical"
ITEM.description = "Base medical item"

ITEM.addHealth = 50
ITEM.applySound = "items/medshot4.wav"
ITEM.replikaOnly = false
ITEM.gestaltOnly = false

if SERVER then
	util.AddNetworkString("ixHealingEffect")

	function SendHealingEffect(client)
		net.Start("ixHealingEffect")
		net.Send(client)
	end
else
	-- Green vignette healing effect
	local vignette = ix.util.GetMaterial("helix/gui/vignette.png")
	local vignetteAlpha = 0
	local vignetteMaxAlpha = 100
	local vignetteSpeed = 6
	local vignetteActive = false

	function RunHealingEffect()
		vignetteAlpha = 0 -- Start with zero opacity
		vignetteActive = true -- Activate the vignette effect

		-- Ramp up the effect to max alpha and then wind it down
		timer.Create("HealingEffectRampUp", 0.01, vignetteMaxAlpha / vignetteSpeed, function()
			vignetteAlpha = math.min(vignetteAlpha + vignetteSpeed, vignetteMaxAlpha)
		end)

		timer.Simple(1, function() -- After 1 second, start winding down the effect
			timer.Create("HealingEffectWindDown", 0.01, vignetteMaxAlpha / vignetteSpeed, function()
				vignetteAlpha = math.max(vignetteAlpha - vignetteSpeed, 0)
				if vignetteAlpha == 0 then
					vignetteActive = false -- Deactivate when fully transparent
				end
			end)
		end)
	end

	-- Hook to draw the vignette on the screen
	hook.Add("DrawOverlay", "DrawHealingVignette", function()
		if vignetteActive then
			surface.SetDrawColor(0, 240, 0, vignetteAlpha) -- Green color
			surface.SetMaterial(vignette)
			surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
		end
	end)

	net.Receive("ixHealingEffect", function()
		RunHealingEffect()
	end)
end

ITEM.functions.Apply = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if itemTable:GetData("replikaOnly", itemTable.replikaOnly) then
			if not client:IsReplika() then
				client:NotifyLocalized("replikaUseOnly")
				client:SendErrorSound()
				return false
			end
		end

		if itemTable:GetData("gestaltOnly", itemTable.gestaltOnly) then
			if client:IsReplika() then
				client:NotifyLocalized("gestaltUseOnly")
				client:SendErrorSound()
				return false
			end
		end

		local healthPercentage = client:Health() / client:GetMaxHealth()
		if healthPercentage >= 0.9 then
			client:NotifyLocalized("healthTooHigh")
			client:SendErrorSound()
			return false
		end

		local addHealth = itemTable:GetData("addHealth", itemTable.addHealth)
		local applySound = itemTable:GetData("applySound", itemTable.applySound)

		if applySound then
			client:EmitSound(applySound)
		end

		SendHealingEffect(client)

		client:SetHealth(math.Clamp(client:Health() + addHealth, 0, client:GetMaxHealth()))
	end
}
