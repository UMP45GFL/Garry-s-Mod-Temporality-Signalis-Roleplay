
PLUGIN.name = "Weapon Proficiency Effects"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds weapon proficiency effects like higher recoil and spread for certain replikas with low proficiency."
PLUGIN.license = [[meow]]

ix.config.Add("weaponProficiencyEffectsSystemEnabled", true, "Enable the weapon proficiency effects system", nil, {
	category = "Weapon Proficiency Effects"
})

if SERVER then
	util.AddNetworkString("updatepweaponinfo")

	hook.Add("PostEntityFireBullets", "WeaponProficiencyEffects_PlayerSwitchWeapon", function(ply, data)
		if !ix.config.Get("weaponProficiencyEffectsSystemEnabled", true) then return end

		if ply:IsPlayer() then
			local weapon = ply:GetActiveWeapon()

			if IsValid(weapon) and weapon:GetClass() == "kanade_tfa_signalis_bw5" then
				local character = ply:GetCharacter()
				if character then
					local attrib = character:GetAttribute("weapon", 0)

					local aimAngles = ply:EyeAngles()
					aimAngles.p = 10

					local direction = aimAngles:Forward()

					if (attrib == 0 or character.vars.class == "replika_klbr") and character.vars.class != "replika_arar" then
						local vel = -500
						if !ply:IsOnGround() then
							vel = -150
						end
						ply:SetVelocity(direction * vel)
						ply:SetRagdolled(true, 10)

					elseif attrib == 1 then
						local vel = -350
						if !ply:IsOnGround() then
							vel = -100
						end
						ply:SetVelocity(direction * vel)

					elseif attrib == 2 and character.vars.class == "replika_arar" then
						local vel = -200
						if !ply:IsOnGround() then
							vel = -70
						end
						ply:SetVelocity(direction * vel)
					end
				end
			end
		end
	end)


	hook.Add("PlayerSwitchWeapon", "WeaponProficiencyEffects_PlayerSwitchWeapon", function(ply, oldWeapon, newWeapon)
		if !ix.config.Get("weaponProficiencyEffectsSystemEnabled", true) then return end

		if newWeapon.SetStatRawL and !newWeapon.DidWeaponProficiencyCheck then
			newWeapon.DidWeaponProficiencyCheck = true

			local character = ply:GetCharacter()
			local newKickUp = newWeapon.Primary.KickUp
			local newSpread = newWeapon.Primary.Spread

			if ix.attributes.list["weapon"] and character then
				newKickUp = ix.attributes.list["weapon"].CalculateRecoil(character, newKickUp)
				newSpread = ix.attributes.list["weapon"].CalculateSpread(character, newSpread)

				timer.Simple(0.1, function()
					if IsValid(ply) and IsValid(newWeapon) then
						newWeapon.Primary.KickUp = newKickUp
						newWeapon:SetStatRawL("Primary.KickUp", newKickUp)

						newWeapon.Primary.Spread = newSpread
						newWeapon:SetStatRawL("Primary.Spread", newSpread)
	
						net.Start("updatepweaponinfo")
						net.WriteString(newWeapon:GetClass())
						net.WriteFloat(newKickUp)
						net.WriteFloat(newSpread)
						net.Send(ply)
					end
				end)
			end
		end
	end)
end

if CLIENT then
	net.Receive("updatepweaponinfo", function()
		local readWeaponClass = net.ReadString()
		local readKickUp = net.ReadFloat()
		local readSpread = net.ReadFloat()
		local weapon = LocalPlayer():GetWeapon(readWeaponClass)

		if IsValid(weapon) and isnumber(readKickUp) and isnumber(readSpread) then
			if weapon.SetStatRawL then
				local newKickUp = math.Round(readKickUp, 2)
				local newSpread = math.Round(readSpread, 4)

				weapon.Primary.KickUp = newKickUp
				weapon:SetStatRawL("Primary.KickUp", newKickUp)

				weapon.Primary.Spread = newSpread
				weapon:SetStatRawL("Primary.Spread", newSpread)
			end
		end
	end)
end
