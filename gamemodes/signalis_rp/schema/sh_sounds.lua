
-- method to play a sound on the client
if SERVER then
    local meta = FindMetaTable("Player")

	util.AddNetworkString("sendErrorSound")
	util.AddNetworkString("sendPlaySound")

	function meta:SendErrorSound()
		net.Start("sendErrorSound")
		net.Send(self)
	end

	function meta:SendPlaySound(snd)
		net.Start("sendPlaySound")
		net.WriteString(snd)
		net.Send(self)
	end
end
if CLIENT then
	net.Receive("sendErrorSound", function()
		surface.PlaySound("eternalis/signalis_ui/no.wav")
	end)

	net.Receive("sendPlaySound", function()
		local snd = net.ReadString()
		if snd then
			surface.PlaySound(snd)
		end
	end)
end

-- Sounds
if CLIENT then
    -- char loaded
    hook.Add("CharacterLoaded", "CharacterLoadedSound", function(char)
        surface.PlaySound("eternalis/signalis_ui/character_selected.wav")
    end)

    -- char load failed
    hook.Add("CharacterLoadFailed", "CharacterLoadFailedSound", function(client, char)
        surface.PlaySound("eternalis/signalis_ui/no.wav")
    end)

    -- char creation limit failure
    hook.Add("OnCharacterLimitFailure", "OnCharacterLimitFailureSound", function(text)
        surface.PlaySound("eternalis/signalis_ui/no.wav")
    end)

    -- keyboard sound
    hook.Add("ChatTextChanged", "ChatTextChangedSound", function(text)
        surface.PlaySound("eternalis/signalis_ui/keyboard_tap.wav")
    end)
else
    -- character saved
    hook.Add("OnCharacterCreated", "OnCharacterCreatedSound", function(client, char)
        client:SendPlaySound("eternalis/signalis_ui/save.wav")
    end)

    local replikaHurtSounds = {
        "eternalis/player/damage/hurt_1.wav",
        "eternalis/player/damage/hurt_2.wav"
    }

    function Schema:GetPlayerPainSound(client)
        if client:IsReplika() then
            return table.Random(replikaHurtSounds)
        end
    end
end

