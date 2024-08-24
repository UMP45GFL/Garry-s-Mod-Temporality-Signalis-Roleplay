
PLUGIN.name = "Music system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds background music."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	optMusicSystemEnabled = "Enable music",
	optMusicSystemVolume = "Music volume",
})

ix.config.Add("musicSystemEnabled", true, "Whether or to enable the music system", nil, {
	category = "Music"
})

if SERVER then
	for k,	v in ipairs(ETERNALIS_MUSIC_TRACKLIST) do
		resource.AddFile(v.sound)
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
		song_queue = table.Copy(ETERNALIS_MUSIC_TRACKLIST)
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

	local next_music_check = 0
	local next_music_play = 0
	local function HandleMusic()
		if !ix.config.Get("musicSystemEnabled", true) or !ix.option.Get("musicSystemEnabled", true) then return end

		local client = LocalPlayer()

		if client.Alive != nil and CurTime() > next_music_check and client:Alive() and !client:IsBot() and client:Team() != TEAM_SPECTATOR then
			next_music_check = CurTime() + 1

			if music_info == nil or next_music_play < CurTime() then
				if #song_queue > 0 then
					local next_song = table.remove(song_queue, math.random(1, #song_queue))
					if next_song != nil then
						music_info = {
							nextPlay = 0,
							name = next_song.name,
							volume = next_song.volume * ix.option.Get("musicSystemVolume", 0.25),
							length = next_song.length + math.random(18, 50),
							sound = next_song.sound,
							playUntil = function()
								return false
							end
						}
						PlayMusicTrack(music_info.sound)
						next_music_play = CurTime() + music_info.length
						chat.AddText("playing music: " .. music_info.name)
					end
				else
					ResetSongQueue()
				end
			end

		end
	end
	hook.Add("Tick", "Eternalis_HandleMusic", HandleMusic)

	-- OPTIONS
	local function isHidden()
		return !ix.config.Get("musicSystemEnabled")
	end

	ix.option.Add("musicSystemEnabled", ix.type.bool, true, {
		category = "Music",
		hidden = isHidden,
		OnChanged = function(oldValue, value)
			if not value then
				if last_music != nil then
					EndCurrentTrack()
				end
			elseif oldValue != value then
				ResetMusicInfo()
			end
		end
	})

	ix.option.Add("musicSystemVolume", ix.type.number, 0.25, {
		category = "Music", min = 0.1, max = 1, decimals = 2, hidden = isHidden,
		OnChanged = function(oldValue, value)
			if last_music != nil then
				last_music:ChangeVolume(value, 3)
			end
		end
	})
end
