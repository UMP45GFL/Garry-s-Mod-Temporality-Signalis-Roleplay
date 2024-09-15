SWEP.Base 			= "tfa_melee_base"
DEFINE_BASECLASS(SWEP.Base)

SWEP.Author 		= "Kanade"
SWEP.PrintName 		= "Disposable stun prod"
SWEP.Purpose		= "Short-range high-voltage electroshock weapon. Can be used one-handed. Non-lethal weapon that instantly incapacitates the target with arcing electricity." 
SWEP.Spawnable 		= true
SWEP.AdminSpawnable = true
SWEP.Category 		= "Kanade's TFA Signalis"
SWEP.Pickupable 	= true

SWEP.ViewModel 		= "models/weapons/c_stunstick.mdl"
SWEP.WorldModel 	= "models/eternalis/items/weapons/star_baton.mdl"
SWEP.ViewModelFOV 	= 50
SWEP.AnimPrefix 	= "stunstick"
SWEP.Slot			= 1
SWEP.SlotPos		= 0

SWEP.UseHands 		= true
SWEP.HoldType 		= "melee"
SWEP.IsStunBaton 	= true

SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.StunningEnabled = false
SWEP.Primary.Directional = true
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 40, -- Trace distance
		["dir"] = Vector(-75, 20, -5), -- Trace arc cast
		["dmg"] = 15, --Damage
		["dmgtype"] = DMG_SHOCK, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.28, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = Sound("Weapon_Crowbar.Single"), -- Sound ID
		["snd_delay"] = 0.22,
		["viewpunch"] = Angle(10, 20, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["hitworld"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["combotime"] = 0
	}
}

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Scale = 1
}

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.WElements = {
	["baton"] = {
		type = "Model",
		model = "models/eternalis/items/weapons/star_baton.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 1.799, -3.5),
		angle = Angle(-83, -5, 0),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

SWEP.VElements = {
	["baton"] = {
		type = "Model",
		model = "models/eternalis/items/weapons/star_baton.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 1.799, -7.5),
		angle = Angle(-83, -5, 0),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end
