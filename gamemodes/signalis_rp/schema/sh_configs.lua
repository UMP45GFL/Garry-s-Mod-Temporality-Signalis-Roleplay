
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

SIGNALIS_MODEL_HEIGHT_FIXES = {
	["models/citric/signalis_stcr/stcr_pm.mdl"] = -20,
	["models/voxaid/signalis_mynah/mynah_pm.mdl"] = -30,
	["models/voxaid/signalis_star/star_pm.mdl"] = -15,
	["models/citric/signalis_fklr/falke_pm.mdl"] = -20,
}
