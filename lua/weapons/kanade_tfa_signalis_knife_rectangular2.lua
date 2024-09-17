SWEP.Base 			= "kanade_tfa_signalis_melee_base"
DEFINE_BASECLASS(SWEP.Base)

SWEP.Author 		= "Kanade"
SWEP.PrintName 		= "Kitchen knife"
SWEP.Spawnable 		= true
SWEP.AdminSpawnable = true
SWEP.Category 		= "Kanade's TFA Signalis"
SWEP.Pickupable 	= true

SWEP.Model = "models/eternalis/items/weapons/kitchen/longer_stronger_knife_02.mdl"
SWEP.Damage = 38

SWEP.WorldModel 	= SWEP.Model
SWEP.HoldType 		= "melee"

SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 50, -- Trace distance
		["dir"] = Vector(15,0,5),
		["dmg"] = 30, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.2, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = Sound("Weapon_Crowbar.Single"), -- Sound ID
		["snd_delay"] = 0.1,
		["viewpunch"] = Angle(5, 5, 0), --viewpunch angle
		["end"] = 1.3, --time before next attack
		["hull"] = 15, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = Sound("Weapon_Melee_Sharp.Impact_Light"),
		["hitworld"] = Sound("Weapon_Melee.Impact_Concrete"),
		["combotime"] = 0
	}
}

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

SWEP.VElements = SWEP.VElementsNormal
SWEP.WElements = SWEP.WElementsNormal
