
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

SIGNALIS_HEADSHOT_SOUNDS = {
	"eternalis/player/headshot/headshot_01.wav",
	"eternalis/player/headshot/headshot_02.wav",
	"eternalis/player/headshot/headshot_03.wav",
	"eternalis/player/headshot/headshot_04.wav",
	"eternalis/player/headshot/headshot_05.wav",
}

SIGNALIS_MALE_DEATH_SOUNDS = {
    {
        snd = "eternalis/player/death/death_gestalt_m_1.wav",
        volume = 1,
        sndLevel = 100,
        pitch = 100
    },
    {
        snd = "eternalis/player/death/death_gestalt_m_2.wav",
        volume = 1,
        sndLevel = 100,
        pitch = 100
    }
}

SIGNALIS_FEMALE_DEATH_SOUNDS = {
    {
        snd = "eternalis/player/death/death_gestalt_f_1.wav",
        volume = 1,
        sndLevel = 100,
        pitch = 100
    },
    {
        snd = "eternalis/player/death/death_gestalt_f_2.wav",
        volume = 1,
        sndLevel = 100,
        pitch = 100
    }
}

SIGNALIS_FEMALE_BREATHING_SOUNDS = {
    snd = "eternalis/player/breathing/breathing_female.wav",
    volume = 1,
    sndLevel = 65,
    pitch = 105,
    minPitch = 90,
    maxPitch = 110
}
