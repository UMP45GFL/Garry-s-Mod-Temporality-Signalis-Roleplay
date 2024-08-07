
PLUGIN.name = "Music system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds background music."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	optMusicSystemEnabled = "Enable music",
	optmusicSystemVolume = "Music volume",
})

ix.config.Add("musicSystemEnabled", true, "Whether or to enable the music system", nil, {
	category = "Music"
})

ix.option.Add("musicSystemEnabled", ix.type.bool, true, {
	category = "Music"
})

ix.option.Add("musicSystemVolume", ix.type.number, 0.7, {
	category = "Music", min = 0, max = 1, decimals = 1
})

local path = "eternalis/signalis_ost/"

local trackList = {
	-- casual ones
	{ name = "Turned Around", 			sound = path.."1_turned_around.mp3", 			volume = 1, length = 222 },
	{ name = "Safe Room", 				sound = path.."2_safe_room.mp3", 				volume = 1, length = 138 },
	{ name = "Double Back", 			sound = path.."4_double_back.mp3", 				volume = 1, length = 362 },
	{ name = "Double Back VHS ver.", 	sound = path.."48_double_back_vhs_ver.mp3", 	volume = 1, length = 362 },
	{ name = "Mnhr", 					sound = path.."12_mnhr.mp3", 					volume = 1, length = 294 },
	{ name = "Dowsing", 				sound = path.."15_dowsing.mp3", 				volume = 1, length = 128 },
	{ name = "Crepuscular", 			sound = path.."54_crepuscular.mp3", 			volume = 1, length = 222 },

	-- more sad or scary or intense
	{ name = "Ritual", 					sound = path.."11_ritual.mp3", 					volume = 1, length = 258 },
	{ name = "Adler", 					sound = path.."14_adler.mp3", 					volume = 1, length = 298 },
	{ name = "Sea Smoke", 				sound = path.."32_sea_smoke.mp3", 				volume = 1, length = 134 },
}

if SERVER then
	for k,	v in ipairs(trackList) do
		resource.AddFile(v.sound)
	end
end

if CLIENT then
	local last_music = nil
	local last_music_name = nil
	local last_vol_mul = nil
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

			local vol_mul = ix.option.Get("musicSystemVolume", 0.7)

			if last_vol_mul != nil and last_vol_mul != vol_mul and last_music != nil then
				last_music:ChangeVolume(vol_mul, 4)
			end

			last_vol_mul = vol_mul

			if music_info == nil or next_music_play < CurTime() then
				if #song_queue > 0 then
					local next_song = table.remove(song_queue, math.random(1, #song_queue))
					if next_song != nil then
						music_info = {
							nextPlay = 0,
							name = next_song.name,
							volume = next_song.volume * vol_mul,
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
end
