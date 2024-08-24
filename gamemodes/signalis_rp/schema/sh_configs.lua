
ix.currency.symbol = ""
ix.currency.singular = "rationmark"
ix.currency.plural = "rationmarks"

ix.config.SetDefault("scoreboardRecognition", true)
ix.config.SetDefault("maxAttributes", 60)

ix.config.Add("rationTokens", 20, "The amount of rationmarks that a person will get from a ration", nil, {
	data = {min = 0, max = 1000},
	category = "economy"
})

ix.config.Add("rationInterval", 300, "How long a person needs to wait in seconds to get their next ration", nil, {
	data = {min = 0, max = 86400},
	category = "economy"
})

ix.config.Add("weaponProficiencyRecoil", true, "If to enable calculating weapon recoil based on weapon proficiency", nil, {
	category = "Weapons"
})

ix.config.Add("weaponProficiencySpread", true, "If to enable calculating weapon spread based on weapon proficiency", nil, {
	category = "Weapons"
})

ix.config.Add("weaponProficiencyAnimations", true, "If to enable slowing down of weapon handling animations for lower weapon proficiency", nil, {
	category = "Weapons"
})

ix.config.Add("facilityShortName", "S23", "Facility short name, used in naming replikas, changing this with characters already existing may break things.", nil, {
	category = "Other"
})

/* Currently unused
SIGNALIS_MODEL_HEIGHT_FIXES = {
	["models/citric/signalis_stcr/stcr_pm.mdl"] = -20,
	["models/voxaid/signalis_mynah/mynah_pm.mdl"] = -30,
	["models/voxaid/signalis_star/star_pm.mdl"] = -15,
	["models/citric/signalis_fklr/falke_pm.mdl"] = -20,
}
*/

ETERNALIS_HEADSHOT_SOUNDS = {
	"eternalis/player/headshot/headshot_01.wav",
	"eternalis/player/headshot/headshot_02.wav",
	"eternalis/player/headshot/headshot_03.wav",
	"eternalis/player/headshot/headshot_04.wav",
	"eternalis/player/headshot/headshot_05.wav",
}

local path = "eternalis/signalis_ost/"

ETERNALIS_MUSIC_TRACKLIST = {
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
