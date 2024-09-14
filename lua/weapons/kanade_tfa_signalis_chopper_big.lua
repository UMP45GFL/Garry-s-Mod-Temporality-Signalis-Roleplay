SWEP.Base 			= "kanade_tfa_signalis_melee_base"
DEFINE_BASECLASS(SWEP.Base)

SWEP.Author 		= "Kanade"
SWEP.PrintName 		= "Big kitchen chopper"
SWEP.Spawnable 		= true
SWEP.AdminSpawnable = true
SWEP.Category 		= "Kanade's TFA Signalis"
SWEP.Pickupable 	= true

SWEP.WorldModel 	= "models/eternalis/items/weapons/kitchen/chopper_bigger.mdl"
SWEP.HoldType 		= "melee"

SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 50, -- Trace distance
		["dir"] = Vector(15,0,5),
		["dmg"] = 40, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.2, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = Sound("weapons/melee/fireaxe/fireaxe_light1.wav"), -- Sound ID
		["snd_delay"] = 0.22,
		["viewpunch"] = Angle(5, 5, 0), --viewpunch angle
		["end"] = 1.3, --time before next attack
		["hull"] = 15, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = Sound("Weapon_Melee_Sharp.Impact_Light"),
		["hitworld"] = Sound("Weapon_Melee.Impact_Concrete"),
		["combotime"] = 0
	}
}

SWEP.WElements = {
	["knife"] = {
		type = "Model",
		model = "models/eternalis/items/weapons/kitchen/chopper_bigger.mdl",
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

SWEP.VElements = {
	["knife"] = {
		type = "Model",
		model = "models/eternalis/items/weapons/kitchen/chopper_bigger.mdl",
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
