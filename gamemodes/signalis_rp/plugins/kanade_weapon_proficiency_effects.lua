
PLUGIN.name = "Weapon Proficiency Effects"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds weapon proficiency effects like higher recoil and spread for certain replikas with low proficiency."
PLUGIN.license = [[meow]]

ix.config.Add("weaponProficiencyEffectsSystemEnabled", true, "Enable the weapon proficiency effects system", nil, {
	category = "Weapon Proficiency Effects"
})

if SERVER then
	util.AddNetworkString("updatepweaponinfo")

	hook.Add("PlayerSwitchWeapon", "Kanade_WeaponProficiency_PlayerSwitchWeapon", function(ply, oldWeapon, newWeapon)
		if !ix.config.Get("weaponProficiencyEffectsSystemEnabled", true) then return end

		if newWeapon.SetStatRawL then
			newWeapon.Primary.DidWeaponProficiencyCheck = true

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
