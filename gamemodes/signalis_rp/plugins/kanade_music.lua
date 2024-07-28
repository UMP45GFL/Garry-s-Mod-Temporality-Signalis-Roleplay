
PLUGIN.name = "Music system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds background music."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	optMusicSystemEnabled = "Enable music",
})

ix.config.Add("musicSystemEnabled", true, "Whether or to enable the music system", nil, {
	category = "Music"
})

ix.option.Add("musicSystemEnabled", ix.type.bool, true, {
	category = "Music"
})

local trackList = {
	{"signalis_music/DoubleBack.mp3", 1, 362},
	{"signalis_music/Dowsing.mp3", 1, 128},
	{"signalis_music/SeaSmoke.mp3", 1, 134},
	{"signalis_music/Crepuscular.mp3", 1, 222},
	{"signalis_music/TurnedAround.mp3", 1, 222},
	{"signalis_music/SafeRoom.mp3", 1, 138},
	{"signalis_music/MNHR.mp3", 1, 294},
	{"signalis_music/DoubleBackVHS.mp3", 1, 361},
}

if SERVER then
	for k,	v in ipairs(trackList) do
		resource.AddFile(v)
	end
end

if CLIENT then
	local last_music = nil
	local last_music_name = nil
	local registered_music = {}

	local function ResetMusicInfo()
		music_info = {
			nextPlay = 0,
			volume = 1,
			length = 0,
			sound = nil,
		}
	end
	ResetMusicInfo()
	
	local function ResetSongQueue()
		song_queue = table.Copy(trackList)
	end
	ResetSongQueue()

	local is_music_ending = false
	local function EndCurrentTrack()
		last_music:ChangeVolume(0, 4)
		is_music_ending = true
		chat.AddText("ending music")
	end

	local function PlayMusicTrack(file_name)
		local sound
		if !registered_music[file_name] then
			sound = CreateSound(game.GetWorld(), file_name, nil)
			if sound then
				sound:SetSoundLevel(0)
				registered_music[file_name] = {sound, nil}
			end
		else
			sound = registered_music[file_name][1]
		end
		if sound then
			sound:Play()
		end
		last_music = sound
		last_music_name = file_name
		return sound
	end

	local next_music_check = 100
	local next_music_play = 0
	function HandleMusic()
		if !ix.config.Get("musicSystemEnabled", true) or !ix.option.Get("musicSystemEnabled", true) then return end

		local client = LocalPlayer()
		if client.Alive != nil and CurTime() < next_music_check and client:Alive() and !client:IsBot() and client:Team() != TEAM_SPECTATOR then
			next_music_check = CurTime() + 1

			if music_info == nil or next_music_play < CurTime() then
				if #song_queue > 0 then
					local next_song = table.remove(song_queue, math.random(1, #song_queue))
					if next_song != nil then
						music_info = {
							nextPlay = 0,
							volume = next_song[2],
							length = next_song[3] + math.random(18, 50),
							sound = next_song[1],
							playUntil = function()
								return false
							end
						}
						PlayMusicTrack(music_info.sound)
						next_music_play = CurTime() + music_info.length
						chat.AddText("playing music: " .. music_info.sound)
					end
				else
					ResetSongQueue()
				end
			end

		end
	end
	hook.Add("Tick", "Eternalis_HandleMusic", HandleMusic)
end
