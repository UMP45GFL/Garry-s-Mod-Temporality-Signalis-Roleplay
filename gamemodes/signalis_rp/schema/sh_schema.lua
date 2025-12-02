
Schema.name = "Signalis RP"
Schema.author = "Kanade"
Schema.description = "Roleplay based on the universe of SIGNALIS."

-- Include netstream
ix.util.Include("libs/thirdparty/sh_netstream2.lua")

ix.util.Include("sh_ammo.lua")
ix.util.Include("sh_configs.lua")
ix.util.Include("sh_commands.lua")

ix.util.Include("cl_fft.lua")
ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_chat.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sh_anims.lua")
ix.util.Include("sv_schema.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sh_player.lua")
ix.util.Include("sv_money.lua")
ix.util.Include("sh_sounds.lua")
ix.util.Include("sh_stun.lua")
ix.util.Include("sh_player_actions.lua")

ix.flag.Add("v", "Access to light blackmarket goods.")
ix.flag.Add("V", "Access to heavy blackmarket goods.")


ix.anim.SetModelClass("models/temporality/signalis_FKLR/falke_pm.mdl", "player")
ix.anim.SetModelClass("models/temporality/signalis_eule/eule_pm.mdl", "player")
ix.anim.SetModelClass("models/temporality/signalis_lstr/AVA_pm.mdl", "player")
ix.anim.SetModelClass("models/temporality/signalis_arar/arar_pm.mdl", "player")
ix.anim.SetModelClass("models/temporality/signalis_ADLR/adler_pm.mdl", "player")
ix.anim.SetModelClass("models/female/f_geshtalt.mdl", "player")
ix.anim.SetModelClass("models/temporality/signalis_kolibri/kolibri_pm.mdl", "player")
ix.anim.SetModelClass("models/temporality/signalis_lstr/elster_pm.mdl", "player")
ix.anim.SetModelClass("models/temporality/signalis_mynah/mynah_pm.mdl", "player")
ix.anim.SetModelClass("models/male/m_geshtalt.mdl", "player")
ix.anim.SetModelClass("models/temporality/signalis_star/star_pm.mdl", "player")
ix.anim.SetModelClass("models/temporality/signalis_stcr/STCR_pm.mdl", "player")



function Schema:ZeroNumber(number, length)
	local amount = math.max(0, length - string.len(number))
	return string.rep("0", amount)..tostring(number)
end

/* hl2rp
do
	local CLASS = {}
	CLASS.color = Color(150, 100, 100)
	CLASS.format = "Dispatch broadcasts \"%s\""

	function CLASS:CanSay(speaker, text)
		if (!speaker:IsDispatch()) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, text))
	end

	ix.chat.Register("dispatch", CLASS)
end
*/

do
	local CLASS = {}
	CLASS.color = Color(75, 150, 50)
	CLASS.format = "%s radios in \"%s\""

	function CLASS:CanHear(speaker, listener)
		if speaker == listener then return true end

		local speakerInv = speaker:GetCharacter():GetInventory()
		local listenerInv = listener:GetCharacter():GetInventory()

		local matchFrequencies = false

		for k, v in pairs(listenerInv:GetItemsByUniqueID("module_radio", true)) do
			if v:GetData("equip", false) and v:GetData("enabled", false) then
				for k2, v2 in pairs(speakerInv:GetItemsByUniqueID("module_radio", true)) do
					if v2:GetData("equip", false) and v2:GetData("enabled", false) then
						local dist = math.abs(v:GetData("frequency") - v2:GetData("frequency"))
						if dist < 7000 then
							matchFrequencies = true
							break
						end
					end
				end
			end
		end

		return matchFrequencies
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("radio", CLASS)
end

do
	local CLASS = {}
	CLASS.color = Color(255, 255, 175)
	CLASS.format = "%s radios in \"%s\""

	function CLASS:GetColor(speaker, text)
		if (LocalPlayer():GetEyeTrace().Entity == speaker) then
			return Color(175, 255, 175)
		end

		return self.color
	end

	function CLASS:CanHear(speaker, listener)
		if (ix.chat.classes.radio:CanHear(speaker, listener)) then
			return false
		end

		local chatRange = ix.config.Get("chatRange", 280)

		return (speaker:GetPos() - listener:GetPos()):LengthSqr() <= (chatRange * chatRange)
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("radio_eavesdrop", CLASS)
end

do
	local CLASS = {}
	CLASS.color = Color(175, 125, 100)
	CLASS.format = "%s requests \"%s\""

	function CLASS:CanHear(speaker, listener)
		return speaker:Team() == FACTION_ADMIN
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("request", CLASS)
end

do
	local CLASS = {}
	CLASS.color = Color(175, 125, 100)
	CLASS.format = "%s requests \"%s\""

	function CLASS:CanHear(speaker, listener)
		if (ix.chat.classes.request:CanHear(speaker, listener)) then
			return false
		end

		local chatRange = ix.config.Get("chatRange", 280)

		return (speaker:GetPos() - listener:GetPos()):LengthSqr() <= (chatRange * chatRange)
		--return (speaker:Team() == FACTION_GESTALT and listener:Team() == FACTION_GESTALT) and (speaker:GetPos() - listener:GetPos()):LengthSqr() <= (chatRange * chatRange)
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("request_eavesdrop", CLASS)
end

do
	local CLASS = {}
	CLASS.color = Color(150, 125, 175)
	CLASS.format = "%s broadcasts \"%s\""

	function CLASS:CanSay(speaker, text)
		if (speaker:Team() != FACTION_ADMIN) then
			speaker:NotifyLocalized("notAllowed")

			return false
		end
	end

	function CLASS:OnChatAdd(speaker, text)
		chat.AddText(self.color, string.format(self.format, speaker:Name(), text))
	end

	ix.chat.Register("broadcast", CLASS)
end

function CanSuicide(item)
	if !IsValid(item.player) then
		return false
	end

	local character = item.player:GetCharacter()
	if character and character.vars and character.vars.class
	and (
		character.vars.class == "replika_fklr" or
		character.vars.class == "replika_stcr" or
		character.vars.class == "replika_kncr"
	)  then
		return false
	end

	return true
end

function Schema:GetMaxPlayerCharacter(client)
	local maxch = ix.config.Get("maxCharacters", 5)

	if client:IsSuperAdmin() then
		maxch = maxch + 5
		
	elseif client:IsAdmin() then
		maxch = maxch + 4

	elseif client:IsUserGroup("operator") || client:IsUserGroup("moderator") || client:IsUserGroup("gamemaster") then
		maxch = maxch + 3
	end

	return maxch
end


function Schema:GetSignalisDate()
	return ix.date.GetFormatted("%d/%m/%Y")
end
