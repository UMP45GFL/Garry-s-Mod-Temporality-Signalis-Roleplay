
PLUGIN.name = "Signalis Talk Sounds"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds hunger & thirst."
PLUGIN.license = [[meow]]

local sound = "eternalis/ui/voice_text.wav"

ix.config.Add("SignalisTalkSoundsEnabled", true, "Enable the signalis talk sounds", nil, {
	category = "Signalis Talk Sounds"
})

ix.config.Add("SignalisTalkSoundsSpeed", 0.075, "Speed of the signalis talk sounds", nil, {
	data = {min = 0.01, max = 0.5, decimals = 3},
	category = "Signalis Talk Sounds"
})

local function PlaySSound(client, pitch)
	client:EmitSound(sound, 60, pitch, 1, CHAN_AUTO)
end

local function OnTalk(client, chatType, message, anonymous)
	if ix.config.Get("SignalisTalkSoundsEnabled", true) and chatType == "ic" then
		-- split the message into a table of words, keeping in spaces
		local words = string.Explode(" ", message)

		local pitch, speed = client:GetTalkPitchAndSpeed()

		client.sTalkInfo = {
			words = words,
			pitch = pitch,
			speed = speed,
			next = 0
		}
	end
end

local function OnTick()
	if ix.config.Get("SignalisTalkSoundsEnabled", true) then
		for _, client in ipairs(player.GetAll()) do
			if client.sTalkInfo and client.sTalkInfo.next < CurTime() then
				local speed = ix.config.Get("SignalisTalkSoundsSpeed", 0.075) * (2 - client.sTalkInfo.speed)
				
				client.sTalkInfo.next = CurTime() + speed

				-- grab the first word from the words
				local firstChar = client.sTalkInfo.words[1]

				PlaySSound(client, client.sTalkInfo.pitch)

				-- remove the first word from the table
				table.remove(client.sTalkInfo.words, 1)

				-- if the word table is empty, remove the table
				if #client.sTalkInfo.words == 0 then
					client.sTalkInfo = nil
				end
			end
		end
	end
end

if ix.config.Get("SignalisTalkSoundsEnabled", true) then
	hook.Add("PostPlayerSay", "SignalisTalkSounds_PostPlayerSay", OnTalk)
	hook.Add("Tick", "SignalisTalkSounds_Tick", OnTick)
end

