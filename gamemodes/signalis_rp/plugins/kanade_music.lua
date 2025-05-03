
PLUGIN.name = "Music system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds background music."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	optMusicSystemEnabled = "Enable music",
	optMusicSystemVolume = "Music volume",
})

ix.config.Add("musicSystemEnabled", true, "Whether or not to enable the music system", nil, {
	category = "Music"
})

local path = "eternalis/signalis_ost/"

SIGNALIS_MUSIC_TRACKLIST = {
	-- casual ones
	{ name = "Turned Around", 				sound = path.."1_turned_around.mp3", 				volume = 1, length = 125 },
	{ name = "Safe Room", 					sound = path.."2_safe_room.mp3", 				volume = 1, length = 77.5 },
	{ name = "Double Back", 				sound = path.."4_double_back.mp3", 				volume = 1, length = 204.27 },
	{ name = "Double Back VHS ver.", 			sound = path.."48_double_back_vhs_ver.mp3", 			volume = 1, length = 204.27 },
	{ name = "Mnhr", 					sound = path.."12_mnhr.mp3", 					volume = 1, length = 165.6 },
	{ name = "Dowsing", 					sound = path.."15_dowsing.mp3", 				volume = 1, length = 72 },
	{ name = "Crepuscular", 				sound = path.."54_crepuscular.mp3", 				volume = 1, length = 125.5 },
	{ name = "Home", 					sound = path.."49_home.mp3", 					volume = 1, length = 121.6 },

	-- side b (heartwarming/calming)
	{ name = "Ritual (Vineta)", 				sound = path.."sb_ritual_vineta.mp3", 				volume = 1, length = 172.5 },
	{ name = "Die Toteninsel (Shooting Stars)", 		sound = path.."sb_die_toteninsel_shooting_stars.mp3", 		volume = 1, length = 220.5 },
	{ name = "Home (Kamilla)", 				sound = path.."sb_home_kamilla.mp3", 				volume = 1, length = 200 },
	{ name = "The Promise (Last Goodbye)", 			sound = path.."sb_the_promise_last_goodbye.mp3", 		volume = 1, length = 205.5 },
	{ name = "Warm Light (Graves)", 			sound = path.."sb_warm_light_graves.mp3", 			volume = 1, length = 162.2 },

	-- more sad or scary or intense
	{ name = "Ritual", 					sound = path.."11_ritual.mp3", 					volume = 1, length = 145.5 },
	{ name = "Adler", 					sound = path.."14_adler.mp3", 					volume = 1, length = 168.3 },
	{ name = "Sea Smoke", 					sound = path.."32_sea_smoke.mp3", 				volume = 1, length = 74.6 },
	{ name = "Warm Light", 					sound = path.."56_warm_light.mp3", 				volume = 1, length = 60 },
}

-- Server-side: preload resources
if SERVER then
	for k, v in ipairs(SIGNALIS_MUSIC_TRACKLIST) do
		resource.AddFile(v.sound)
	end
end

-- Client-side music system
if CLIENT then
	local musicSystem = {
		lastMusic = nil,
		lastMusicName = nil,
		registeredMusic = {},
		musicInfo = {},
		songQueue = {},
		isMusicEnding = false,
		nextMusicCheck = 0,
		nextMusicPlay = 0
	}

	-- Reset the music information
	local function ResetMusicInfo()
		musicSystem.musicInfo = {
			nextPlay = 0,
			volume = 1,
			length = 0,
			sound = nil,
		}
	end

	-- Reset the song queue
	local function ResetSongQueue()
		musicSystem.songQueue = table.Copy(SIGNALIS_MUSIC_TRACKLIST)
	end

	ResetMusicInfo()
	ResetSongQueue()

	-- End the current music track properly
	local function EndCurrentTrack()
		if musicSystem.lastMusic then
			musicSystem.lastMusic:Stop()
			musicSystem.registeredMusic[musicSystem.lastMusicName] = nil
			musicSystem.lastMusic = nil
			musicSystem.lastMusicName = nil
			musicSystem.isMusicEnding = true
			chat.AddText("Music has ended.")
		end
	end

	-- Refined function to calculate the next play time
	local function CalculateNextPlayTime(length)
		-- Add a short randomized delay between tracks for natural flow
		local delay = math.random(20, 40) -- Random delay between 5 and 15 seconds
		return CurTime() + length + delay
	end

	-- Play a music track safely
	local function PlayMusicTrack(fileName, defaultLength)
		local sound
		if not musicSystem.registeredMusic[fileName] then
			sound = CreateSound(game.GetWorld(), fileName, nil)
			if not sound then
				chat.AddText("Error: Failed to load music track: " .. fileName)
				return nil
			end
			sound:SetSoundLevel(0)
			musicSystem.registeredMusic[fileName] = {sound, nil}
		else
			sound = musicSystem.registeredMusic[fileName][1]
		end

		if sound then
			sound:Play()

			-- Detect the duration of the track using SoundDuration
			local trackDuration = SoundDuration(fileName)
			if trackDuration and trackDuration > 0 then
				musicSystem.musicInfo.length = trackDuration
				musicSystem.nextMusicPlay = CalculateNextPlayTime(trackDuration)
			else
				musicSystem.musicInfo.length = defaultLength
				musicSystem.nextMusicPlay = CalculateNextPlayTime(defaultLength)
			end

			musicSystem.lastMusic = sound
			musicSystem.lastMusicName = fileName
			return sound
		else
			chat.AddText("Error: Unable to play music track: " .. fileName)
			return nil
		end
	end

	-- Main music handling function
	local function HandleMusic()
		-- Ensure the music system and options are enabled
		if not ix.config.Get("musicSystemEnabled", true) or not ix.option.Get("musicSystemEnabled", true) then return end

		local client = LocalPlayer()

		-- Perform checks periodically
		if client.Alive != nil and CurTime() > musicSystem.nextMusicCheck and client:Alive() and not client:IsBot() and client:Team() != TEAM_SPECTATOR then
			musicSystem.nextMusicCheck = CurTime() + 1

			-- Start playing music if nothing is playing and it's time to play the next track
			if (not musicSystem.musicInfo or musicSystem.nextMusicPlay < CurTime()) and #musicSystem.songQueue > 0 then
				local nextSong = table.remove(musicSystem.songQueue, math.random(1, #musicSystem.songQueue))
				if nextSong then
					musicSystem.musicInfo = {
						nextPlay = 0,
						name = nextSong.name,
						volume = nextSong.volume * ix.option.Get("musicSystemVolume", 0.25),
						length = nextSong.length,
						sound = nextSong.sound,
					}
					PlayMusicTrack(musicSystem.musicInfo.sound, nextSong.length)
					chat.AddText("Playing music: " .. musicSystem.musicInfo.name)
				else
					ResetSongQueue()
				end
			end
		end
	end
	hook.Add("Think", "Signalis_HandleMusic", HandleMusic)

	-- Options for enabling/disabling the music system and controlling volume
	local function isHidden()
		return not ix.config.Get("musicSystemEnabled")
	end

	ix.option.Add("musicSystemEnabled", ix.type.bool, true, {
		category = "Music",
		hidden = isHidden,
		OnChanged = function(oldValue, value)
			if not value then
				if musicSystem.lastMusic then
					EndCurrentTrack()
				end
			elseif oldValue ~= value then
				ResetMusicInfo()
			end
		end
	})

	ix.option.Add("musicSystemVolume", ix.type.number, 0.25, {
		category = "Music", min = 0.1, max = 1, decimals = 2, hidden = isHidden,
		OnChanged = function(oldValue, value)
			if musicSystem.lastMusic then
				musicSystem.lastMusic:ChangeVolume(value, 3)
			end
		end
	})
end
