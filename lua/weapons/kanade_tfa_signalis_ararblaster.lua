SWEP.Base = "tfa_bash_base"
SWEP.Category = "Kanade's TFA Signalis"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7
SWEP.AdminSpawnable = true
SWEP.UseHands = true
--SWEP.Manufacturer = "NA"
SWEP.Purpose = "Heavy machine gun."
SWEP.Type_Displayed = "Machine Gun"
SWEP.Author = "Zacks & 1nazuma, UMP45"
SWEP.Slot = 2
SWEP.PrintName = "ARAR Blaster"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false

--[Model]--
SWEP.ViewModel			= "models/weapons/signalis/c_signalis_mp5.mdl"
SWEP.ViewModelFOV = 75
SWEP.WorldModel			= "models/weapons/signalis/w_signalis_mp5.mdl"
SWEP.HoldType = "smg"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.MuzzleAttachment = "1"
SWEP.MuzzleAttachmentSilenced = "3"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true
SWEP.CrouchPos    = Vector(-1, 0, -1.25)
SWEP.CrouchAng    = Vector(0, 0, -10)

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -5,
        Right = 1,
        Forward = 6.5,
        },
        Ang = {
		Up = -90,
        Right = 180,
        Forward = 10
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = Sound("TFA_KANADE_SIGNALIS_SMG2.fire1")
--silenced
SWEP.Primary.SilencedSound = Sound("weapon_bo3_kuda.fire_silenced")
SWEP.Primary.LoopSoundSilenced = Sound("weapon_bo3_kuda.fire_silenced_loop")
SWEP.Primary.LoopSoundTailSilenced = Sound("weapon_bo3_kuda.fire_silenced_end")
SWEP.Primary.RapidFire_LoopSoundSilenced = Sound("weapon_bo3_kuda.fire_silenced_loop_rapid")
SWEP.Primary.LoopSoundAutoOnly = false
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("weapon_bo3_smgs.TailInside"),
	[256] = Sound("weapon_bo3_smgs.TailOutside")
}
SWEP.Primary.Sound_DryFire = "weapon_bo3_dryfire.assault"
SWEP.Primary.Sound_Blocked = "weapon_bo3_dryfire.assault"
SWEP.Primary.Ammo = "ammo8mm"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 3000
SWEP.Primary.RPM_Semi = 800
SWEP.Primary.RPM_rapidfire = 3000
SWEP.Primary.Damage = 22
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipSize_Ext = 42
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.35
SWEP.DisableChambering = false
SWEP.FiresUnderwater = true

--[Firemode]--
SWEP.Primary.BurstDelay = 0.1
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = true
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.DefaultFireMode = "auto"
SWEP.FireModeName = nil
SWEP.FireModes = {
	"Auto",
	"Single",
}

--[Range]--
SWEP.Primary.DisplayFalloff = true
SWEP.Primary.RangeFalloffLUT = {
	bezier = false, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "linear", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "meters", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = { -- providing zero point is not required
		-- without zero point it is considered to be as {range = 0, damage = 1}
		{range = 100, damage = 1.0},
		{range = 150, damage = 0.86},
		{range = 300, damage = 0.86},
		{range = 350, damage = 0.6},
	}
}

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.5 --0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 --.09

SWEP.ViewModelPunch_MaxVertialOffset				= 2 --3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 --1.95
SWEP.ViewModelPunch_VertialMultiplier				= 0.75 --1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 --0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 --0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 --0.25

SWEP.ChangeStateRecoilMultiplier = 1.3 --1.3
SWEP.CrouchRecoilMultiplier = 0.65 --0.65
SWEP.JumpRecoilMultiplier = 1.3 --1.3
SWEP.WallRecoilMultiplier = 1.1 --1.1

--[Spread Related]--
SWEP.Primary.Spread		  = .02
SWEP.Primary.IronAccuracy = .0045
SWEP.IronRecoilMultiplier = 0.65

SWEP.Primary.KickUp				= 0.7
SWEP.Primary.KickDown 			= 0.2
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor = 0.5

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 0.85
SWEP.Primary.SpreadRecovery = 6

SWEP.ChangeStateAccuracyMultiplier = 1.5 --1.5
SWEP.CrouchAccuracyMultiplier = 1.0 --0.5
SWEP.JumpAccuracyMultiplier = 3.0 --2
SWEP.WalkAccuracyMultiplier = 1.35 --1.35

--[Bash]--
SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 35
SWEP.Secondary.BashSound = Sound("weapon_bo3_melee.whoosh")
SWEP.Secondary.BashHitSound = Sound("weapon_bo3_melee.hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("weapon_bo3_melee.hit")
SWEP.Secondary.BashLength = 45
SWEP.Secondary.BashDelay = 0.1
SWEP.Secondary.BashDamageType = DMG_CLUB
SWEP.Secondary.BashInterrupt = true

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.IronInSound = "weapon_bo3_gear.rattle"
SWEP.IronOutSound = "weapon_bo3_gear.rattle"
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-3.4, 0, 0.45)
SWEP.IronSightsAng = Vector(0.85, 0, 0)

SWEP.IronSightsPos_ACOG 	= Vector(-3.415, -3, -0.24)
SWEP.IronSightsAng_ACOG 	= Vector(0, 0, 0)
SWEP.Secondary.IronFOV_ACOG = 55

SWEP.IronSightsPos_Holo 	= Vector(-3.409, -3, 0.11)
SWEP.IronSightsAng_Holo 	= Vector(0, 0, 0)

SWEP.IronSightsPos_MicroT1 	= Vector(-3.404, -3, -0.131)
SWEP.IronSightsAng_MicroT1 	= Vector(0, 0, 0)

--SWEP.IronSightsPos_Mini 	= Vector(-3.409, -3, 0.11)
--SWEP.IronSightsAng_Mini 	= Vector(0, 0, 0)

SWEP.IronSightsPos_Reflex 	= Vector(-3.439, -3, -0.21)
SWEP.IronSightsAng_Reflex	= Vector(0, 0, 0)


SWEP.IronSightsPos_NVPoint = Vector(-7.7, 5, 0)
SWEP.IronSightsAng_NVPoint = Vector(0, 0, -52)

SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "ShellEject"
--SWEP.LuaShellModel = "models/entities/tfa_codww2/shells/fx_9mm.mdl"
SWEP.LuaShellSound = "weapon_bo3_shells.large"
SWEP.LuaShellScale = 0.4
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = true

--[Jamming]-- SMG
SWEP.CanJam = false
SWEP.JamChance = 0.02
SWEP.JamFactor = 0.04

--[Misc]--
SWEP.AmmoTypeStrings = {smg1 = "8x22mm Ammo"}
SWEP.FireModeSound = "weapon_bo3_misc.switch"
SWEP.PickupSound = "weapon_bo3_pickup.ammo"
SWEP.InspectPos = Vector(11, -2, -3)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(-1, -2, -0.5)
SWEP.SafetyAng = Vector(-15, 25, -20)
SWEP.TracerCount = 3

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 3
SWEP.DInv2_Volume = nil
SWEP.DInv2_Mass = 2

--[NZombies]--
SWEP.NZPaPName = "Crocuta"
SWEP.Primary.MaxAmmo = 210

function SWEP:NZMaxAmmo()

    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo(self.Primary.MaxAmmo, ammo_type)
		self:SetClip1(self.Primary.ClipSize)
    end
end

SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary.Damage = 150
self.Primary.Knockback = 0
self.Primary.ClipSize = 50
self.Primary.MaxAmmo = 350
self.Attachments = {
[1] = {atts = {"bo3_long_barrel"}, order = 1},
[2] = {atts = {"bo3_suppressor"}, order = 2},
[3] = {atts = {"bo3_si_elo","bo3_si_reflex","bo3_si_boa3","bo3_scope_recon","bo3_scope_varix3"}, order = 3, sel = 2},
[4] = {atts = {"bo3_fg_grip"}, order = 4},
[5] = {atts = {"bo3_ext_mag_nofastanim"}, order = 5, sel = 1},
[6] = {atts = {"bo3_fast_mag"}, order = 6},
[7] = {atts = {"bo3_ub_laser"}, order = 7},
[8] = {atts = {"bo3_fmj_nosiderail"}, order = 8, sel = 1},
[9] = {atts = {"bo3_quickdraw"}, order = 9},
[11] = {atts = {"bo3_stock"}, order = 11},
[12] = {atts = {"bo3_rapidfire"}, order = 12},
}
self:ClearStatCache()
return true
end

--[Animations]--

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 45 / 30,
	[ACT_VM_RELOAD_EMPTY] = 45 / 30,
	["reload_extmag"] = 40 / 30,
	["reload_empty_extmag"] = 40 / 30,
	["reload_fast"] = 30 / 45,
	["reload_empty_fast"] = 30 / 45,
	--[Grip]--
	["reload_grip"] = 45 / 30,
	["reload_empty_grip"] = 45 / 30,
	["reload_grip_extmag"] = 40 / 30,
	["reload_empty_grip_extmag"] = 40 / 30,
	["reload_grip_fast"] = 30 / 45,
	["reload_empty_grip_fast"] = 30 / 45,
}

SWEP.SequenceLengthOverride = {
	["bash_grip"] = 27 / 30,
}

SWEP.SequenceRateOverride = {
	[ACT_VM_RELOAD] = 35 / 30,
	[ACT_VM_RELOAD_EMPTY] = 35 / 30,
	["reload_extmag"] = 35 / 30,
	["reload_empty_extmag"] = 35 / 30,
	["bash"] = 40 / 30,
	--[Grip]--
	["reload_grip"] = 35 / 30,
	["reload_empty_grip"] = 35 / 30,
	["reload_grip_extmag"] = 35 / 30,
	["reload_empty_grip_extmag"] = 35 / 30,
	["bash_grip"] = 40 / 30,
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_IDLE_TO_LOWERED,
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_IDLE_LOWERED,
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_LOWERED_TO_IDLE,
	},
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_forward") },
},
--[Extmag]--
["reload_extmag"] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
},
["reload_empty_extmag"] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_back") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_forward") },
},
--[Fastmag]--
["reload_fast"] = {
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 25 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
},
["reload_empty_fast"] = {
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 25 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
{ ["time"] = 35 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_forward") },
},
--[Grip]--
["draw_grip"] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
["holster_grip"] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
["draw_first_grip"] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_forward") },
},
["reload_grip"] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
},
["reload_empty_grip"] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_back") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_forward") },
},
--[extmag grip]--
["reload_grip_extmag"] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
},
["reload_empty_grip_extmag"] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_back") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_forward") },
},
--[fastmag grip]--
["reload_grip_fast"] = {
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 25 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
},
["reload_empty_grip_fast"] = {
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_out") },
{ ["time"] = 25 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.mag_in") },
{ ["time"] = 35 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_kuda.bolt_forward") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

--[Attachments]--
SWEP.LaserSightModAttachment = 4
SWEP.LaserSightModAttachmentWorld = 4

SWEP.ViewModelBoneMods = {
["tag_silencer_attach"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_muzzle"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_flash"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_dbal"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_foregrip"] = { scale = Vector(1,1,1), pos = Vector(0.75, 0, 0), angle = Angle(0, 0, 0) },
["tag_fast_mag_animate"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.WorldModelBoneMods = {
["tag_silencer_attach"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_muzzle"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_flash"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_dbal"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_foregrip"] = { scale = Vector(1,1,1), pos = Vector(0.75, 0, 0), angle = Angle(0, 0, 0) },
["tag_fast_mag_animate"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.VElements = {
--["laser"] = { type = "Model", model = "models/weapons/bo3/kuda/attach/c_bo3_kuda_att_dbal.mdl", bone = "tag_view", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, active = false, bodygroup = {} },
["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "tag_laser1", rel = "", pos = Vector(0, -1.37, -1.98), angle = Angle(0, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
["suppressor"] = { type = "Model", model = "models/weapons/signalis/upgrades/v_lowpoly_suppressor.mdl", bone = "tag_flash", rel = "", pos = Vector(-20.77, -1.95, 1.63), angle = Angle(0, 0, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
["sight_low_acog"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_acog.mdl", bone = "tag_weapon_right", rel = "", pos = Vector(-8.8, -2.845, 8.2), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
["sight_low_holo"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_holo.mdl", bone = "tag_weapon_right", rel = "", pos = Vector(-5.8, -1.6, 6.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
["sight_low_t1"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_microt1.mdl", bone = "tag_weapon_right", rel = "", pos = Vector(-5.8, -1.6, 6.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
--["sight_low_mini"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_mini.mdl", bone = "tag_weapon_right", rel = "", pos = Vector(-5.8, -1.6, 6.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
["sight_low_ref"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_reflex.mdl", bone = "tag_weapon_right", rel = "", pos = Vector(-5.8, -1.6, 6.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
["rail_sights"] = { type = "Model", model = "models/weapons/signalis/upgrades/v_lowpoly_rail.mdl", bone = "tag_weapon_right", rel = "", pos = Vector(-5.8, -1.6, 6.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
}

SWEP.WElements = {
["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "prp_bolt", rel = "", pos = Vector(3.7, 0, 0), angle = Angle(0, 90, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
["suppressor"] = { type = "Model", model = "models/weapons/signalis/upgrades/v_lowpoly_suppressor.mdl", bone = "prp_bolt", rel = "",pos = Vector(0.3, 17.2, 2.2), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
["sight_low_acog"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_acog.mdl", bone = "prp_bolt", rel = "",pos = Vector(-1.9, 17.2, -2.65), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
["sight_low_holo"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_holo.mdl", bone = "prp_bolt", rel = "", pos = Vector(0, 17.2, -1.8), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
["sight_low_t1"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_microt1.mdl", bone = "prp_bolt", rel = "", pos = Vector(0, 17.2, -1.8), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
--["sight_low_mini"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_mini.mdl", bone = "tag_weapon_right", rel = "", pos = Vector(-5.8, -1.6, 6.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
["sight_low_ref"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_reflex.mdl", bone = "prp_bolt", rel = "", pos = Vector(0, 17.2, -1.8), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
}

SWEP.Attachments = {
[1] = {atts = {"ins2_br_supp"}, order = 1},
[2] = {atts = {"signalis_lowpoly_acog","signalis_lowpoly_holo","signalis_lowpoly_microt1",--[["signalis_lowpoly_mini_smg",]]"signalis_lowpoly_reflex"}, order = 2},
[3] = {atts = {"ins2_ub_laser"}, order = 3, sel = 1},
[4] = {atts = {"signalis_shortstock"}, order = 4},
[99] = { atts = { "am_match", "am_magnum" }, order = 99 },
}

SWEP.AttachmentDependencies     = {}
SWEP.AttachmentExclusions       = {}
SWEP.AttachmentTableOverride = {
	["bo3_ext_mag_nofastanim"] = {
		["ViewModelBoneMods"] = {
			["tag_fast_mag_animate"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -3), angle = Angle(0, 0, 0) },
		},
		["WorldModelBoneMods"] = {
			["tag_fast_mag_animate"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -3), angle = Angle(0, 0, 0) },
		},
	},
	["bo3_long_barrel"] = { -- attachment id, root of WeaponTable override
		["ViewModelBoneMods"] = {
			["tag_muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(1.5, 0, 0), angle = Angle(0, 0, 0) },
			["tag_flash"] = { scale = Vector(1, 1, 1), pos = Vector(4, 0, 0), angle = Angle(0, 0, 0) },
			["tag_silencer_attach"] = { scale = Vector(1, 1, 1), pos = Vector(4, 0, 0), angle = Angle(0, 0, 0) },
		},
		["WorldModelBoneMods"] = {
			["tag_muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(1.5, 0, 0), angle = Angle(0, 0, 0) },
			["tag_flash"] = { scale = Vector(1, 1, 1), pos = Vector(4, 0, 0), angle = Angle(0, 0, 0) },
			["tag_silencer_attach"] = { scale = Vector(1, 1, 1), pos = Vector(4, 0, 0), angle = Angle(0, 0, 0) },
		},
		["Primary"] = {
			["RangeFalloffLUT"] = {
				bezier = false,
				range_func = "linear",
				units = "meters",
				lut = {
					{range = 20, damage = 1.0},
					{range = 30, damage = 0.86},
					{range = 60, damage = 0.86},
					{range = 70, damage = 0.6},
				}
			},
		},
	},
	["bo3_fmj_nosiderail"] = { -- attachment id, root of WeaponTable override
		["ViewModelBoneMods"] = {
			["tag_dbal"] = { scale = Vector(1, 1, 1), pos = Vector(4.5, -0.5, -1.35), angle = Angle(0, 0, 0) },
		},
		["WorldModelBoneMods"] = {
			["tag_dbal"] = { scale = Vector(1, 1, 1), pos = Vector(4.5, -0.5, -1.35), angle = Angle(0, 0, 0) },
		},
	},
	["bo3_ub_laser"] = { -- attachment id, root of WeaponTable override
		["VElements"] = {
			["side_rail"] = {
				["active"] = true
			},
		},
		["WElements"] = {
			["side_rail"] = {
				["active"] = true
			},
		},
	},
}
SWEP.AttachmentIconOverride     = {
	["bo3_long_barrel"] = Material("attachments/kuda/t7_icon_attach_smg_standard_extbarrel_01_rwd.png", "smooth"),
	["bo3_suppressor"] = Material("attachments/kuda/t7_icon_attach_smg_standard_suppressor_01_rwd.png", "smooth"),
	["bo3_fg_grip"] = Material("attachments/kuda/t7_icon_attach_smg_standard_grip_01_rwd.png", "smooth"),
	["bo3_ext_mag_nofastanim"] = Material("attachments/kuda/t7_icon_attach_smg_standard_extmag_01_rwd.png", "smooth"),
	["bo3_fast_mag"] = Material("attachments/kuda/t7_icon_attach_smg_standard_fastmag_01_rwd.png", "smooth"),
	["bo3_fmj_nosiderail"] = Material("attachments/kuda/t7_icon_attach_smg_standard_fmj_01_rwd.png", "smooth"),
	["bo3_ub_laser"] = Material("attachments/kuda/t7_icon_attach_smg_standard_laser_01_rwd.png", "smooth"),
	["bo3_quickdraw"] = Material("attachments/kuda/t7_icon_attach_smg_standard_quickdraw_01_rwd.png", "smooth"),
	["bo3_hical"] = Material("attachments/kuda/t7_icon_attach_smg_standard_highcaliber_01_rwd.png", "smooth"),
	["bo3_stock"] = Material("attachments/kuda/t7_icon_attach_smg_standard_extstock_01_rwd.png", "smooth"),
	--["bo3_rapidfire"] = Material("attachments/kuda/t7_icon_attach_smg_standard_rapidfire_01_rwd.png", "smooth"),
}

DEFINE_BASECLASS(SWEP.Base)

SWEP.StatCache_Blacklist = {
    ["IronSightsPos"] = true,
    ["IronSightsAng"] = true,
	["IronSightsPos_ACOG"] = true,
    ["IronSightsAng_ACOG"] = true,    
	["IronSightsPos_Holo"] = true,
    ["IronSightsAng_Holo"] = true,    
	["IronSightsPos_MicroT1"] = true,
    ["IronSightsAng_MicroT1"] = true,    
	["IronSightsPos_Reflex"] = true,
    ["IronSightsAng_Reflex"] = true,
    ["DrawCrosshairIS"] = true,	
	["Secondary.IronFOV"] = true,
}

SWEP.CurrentSightState = 1

function SWEP:Think2(...)

   if self.Owner:KeyPressed(IN_USE) and self:GetIronSights() then 
		if (!self.editSightTrigger) then
			self.editSightTrigger = true
			timer.Simple(0.5, function()
				self.editSightTrigger = false
			end)
		else
        if self.CurrentSightState == 1 then 
            self.CurrentSightState = 2  	
			self.IronSightsPos = self.IronSightsPos_NVPoint
			self.IronSightsAng = self.IronSightsAng_NVPoint	
			self.IronSightsPos_ACOG = self.IronSightsPos_NVPoint
			self.IronSightsAng_ACOG = self.IronSightsAng_NVPoint	
			self.IronSightsPos_Holo = self.IronSightsPos_NVPoint
			self.IronSightsAng_Holo = self.IronSightsAng_NVPoint	
			self.IronSightsPos_MicroT1 = self.IronSightsPos_NVPoint
			self.IronSightsAng_MicroT1 = self.IronSightsAng_NVPoint	
			self.IronSightsPos_Reflex = self.IronSightsPos_NVPoint
			self.IronSightsAng_Reflex = self.IronSightsAng_NVPoint	
			self.Secondary.IronFOV_ACOG = 70
			self.DrawCrosshairIS = true
        else 
            self.CurrentSightState = 1
            self.IronSightsPos = Vector(-3.4, 0, 0.45)
            self.IronSightsAng = Vector(0.85, 0, 0)
            self.IronSightsPos_ACOG 	= Vector(-3.415, -3, -0.24)
            self.IronSightsAng_ACOG 	= Vector(0, 0, 0)
            self.IronSightsPos_Holo 	= Vector(-3.409, -3, 0.11)
            self.IronSightsAng_Holo 	= Vector(0, 0, 0)
            self.IronSightsPos_MicroT1 	= Vector(-3.404, -3, -0.131)
            self.IronSightsAng_MicroT1 	= Vector(0, 0, 0)
            self.IronSightsPos_Reflex 	= Vector(-3.439, -3, -0.21)
            self.IronSightsAng_Reflex	= Vector(0, 0, 0)
			self.Secondary.IronFOV_ACOG = 55
			self.DrawCrosshairIS = false
		end 
    end 
end

	return BaseClass.Think2(self, ...)
end
