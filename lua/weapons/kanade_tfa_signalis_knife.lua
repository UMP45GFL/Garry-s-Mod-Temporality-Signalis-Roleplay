SWEP.Base 			= "kanade_tfa_signalis_melee_base"
DEFINE_BASECLASS(SWEP.Base)

SWEP.Author 		= "Kanade"
SWEP.PrintName 		= "Small kitchen knife"
SWEP.Spawnable 		= true
SWEP.AdminSpawnable = true
SWEP.Category 		= "Kanade's TFA Signalis"
SWEP.Pickupable 	= true

SWEP.Model = "models/eternalis/items/weapons/kitchen/small_sharp_knife.mdl"
SWEP.Damage = 25

SWEP.WorldModel 	= SWEP.Model
SWEP.HoldType 		= "melee"

SWEP.VElementsNormal = {
	["knife"] = {
		type = "Model",
		model = SWEP.Model,
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 2, -17.5),
		angle = Angle(90, 61.111, 3.332),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

SWEP.WElementsNormal = {
	["knife"] = {
		type = "Model",
		model = SWEP.Model,
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 2, -10.5),
		angle = Angle(90, 61.111, 3.332),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}
