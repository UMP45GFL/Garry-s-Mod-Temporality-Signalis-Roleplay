SWEP.Base = "tfa_bash_base"
SWEP.Category = "Kanade's TFA Signalis"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7
SWEP.AdminSpawnable = true
SWEP.UseHands = true
--SWEP.Manufacturer = "Colt"
SWEP.Purpose = "A semi-auto pistol. Fires 10mm ammunition from a 10-round magazine. Easy to use,high rate of fire."
SWEP.Type_Displayed = "Pistol"
SWEP.Author = "Zacks & 1nazuma"
SWEP.Slot = 1
SWEP.PrintName = "Type-75 'An'"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIronSights = false

--[Model]--
SWEP.ViewModel			= "models/weapons/signalis/c_signalis_cz75.mdl"
SWEP.ViewModelFOV = 60
SWEP.WorldModel			= "models/weapons/signalis/w_signalis_cz75.mdl"
SWEP.HoldType = "pistol"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.MuzzleAttachment = "1"
SWEP.MuzzleAttachmentSilenced = "3"
SWEP.VMPos = Vector(-1, -6, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true
SWEP.CrouchPos    = Vector(-1, 0, -1.25)
SWEP.CrouchAng    = Vector(0, 0, -10)

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -2,
		Right = 1.2,
		Forward = 4.5,
	},
	Ang = {
		Up = -90,
		Right = 175,
		Forward = 8
	},
	Scale = 1.1
}

--[Gun Related]--
SWEP.Primary.Sound = "weapon_bo3_1911.fire"
SWEP.Primary.SilencedSound = "weapon_bo3_1911.fire_sup"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("Weapon_BO3_pistols.TailInside"),
	[256] = Sound("Weapon_BO3_pistols.TailOutside")
}
SWEP.Primary.Sound_DryFire = "weapon_bo3_dryfire.assault"
SWEP.Primary.Sound_Blocked = "weapon_bo3_dryfire.assault"
SWEP.Primary.Ammo = "ammo10mm"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 625
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 20
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 10
SWEP.Primary.ClipSize_Ext = 14
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.35
SWEP.DisableChambering = false
SWEP.FiresUnderwater = true

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.DefaultFireMode = ""
SWEP.FireModeName = nil

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
		{range = 120, damage = 1.0},
		{range = 150, damage = 0.8},
		{range = 280, damage = 0.8},
		{range = 320, damage = 0.48},
	}
}

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.5 --0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 --.09

SWEP.ViewModelPunch_MaxVertialOffset				= 3 --3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 --1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 --1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 --0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 --0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 --0.25

SWEP.ChangeStateRecoilMultiplier = 1.3 --1.3
SWEP.CrouchRecoilMultiplier = 0.65 --0.65
SWEP.JumpRecoilMultiplier = 1.65 --1.3
SWEP.WallRecoilMultiplier = 1.1 --1.1

--[Spread Related]--
SWEP.Primary.Spread		  = .013
SWEP.Primary.IronAccuracy = .003
SWEP.IronRecoilMultiplier = 0.6

SWEP.Primary.KickUp				= 0.8
SWEP.Primary.KickDown 			= 0.28
SWEP.Primary.KickHorizontal		= 0.18
SWEP.Primary.StaticRecoilFactor = 0.75

SWEP.Primary.SpreadMultiplierMax = 5
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 5.5

SWEP.ChangeStateAccuracyMultiplier = 1.5 --1.5
SWEP.CrouchAccuracyMultiplier = 1 --0.5
SWEP.JumpAccuracyMultiplier = 3.0 --2
SWEP.WalkAccuracyMultiplier = 1.5 --1.35

--[Bash]--
SWEP.Secondary.CanBash = false
SWEP.Secondary.BashDamage = 35
SWEP.Secondary.BashSound = Sound("weapon_bo3_melee.whoosh")
SWEP.Secondary.BashHitSound = Sound("weapon_bo3_melee.hit")
SWEP.Secondary.BashHitSound_Flesh = Sound("weapon_bo3_melee.hit")
SWEP.Secondary.BashLength = 45
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashDamageType = DMG_CLUB
SWEP.Secondary.BashInterrupt = true

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.IronInSound = "weapon_bo3_gear.rattle"
SWEP.IronOutSound = "weapon_bo3_gear.rattle"
SWEP.Secondary.IronFOV = 60
SWEP.IronSightsPos = Vector(-2.5, 0, 0.63)
SWEP.IronSightsAng = Vector(0.3, 0, 0)

SWEP.IronSightsPos_Mini = Vector(-2.545, 0, 0.05)
SWEP.IronSightsAng_Mini = Vector(0, 0, 0)

SWEP.IronSightsPos_NVPoint = Vector(-5.7, 0, 0)
SWEP.IronSightsAng_NVPoint = Vector(0, 0, -30)

SWEP.IronSightTime = 0.25

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "ShellEject"
--SWEP.LuaShellModel = "models/entities/tfa_codww2/shells/fx_9mm.mdl"
SWEP.LuaShellSound = "weapon_bo3_shells.small"
SWEP.LuaShellScale = 0.5
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = true

--[Jamming]-- Pistol
SWEP.CanJam = false
SWEP.JamChance = 0.025
SWEP.JamFactor = 0.08

--[Misc]--
SWEP.AmmoTypeStrings = {pistol = "10mm"}
SWEP.FireModeSound = "weapon_bo3_misc.switch"
SWEP.PickupSound = "weapon_bo3_pickup.ammo"
SWEP.InspectPos = Vector(11, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(2, -11, -10)
SWEP.SafetyAng = Vector(60, 0, 0)
SWEP.TracerCount = 3

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 2
SWEP.DInv2_Volume = nil
SWEP.DInv2_Mass = 0.5

--[NZombies]--
SWEP.NZPaPReplacement = "tfa_mustangandsally"
SWEP.NZPaPName = "Mustang"
SWEP.Primary.MaxAmmo = 80

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
	self.Primary.Damage = 1150
	self.Primary.Knockback = 10
	self.Primary.ClipSize = 12
	self.Primary.MaxAmmo = 96
	self.Primary.IronAccuracy = .001
	self.Primary.DamageType = bit.bor(DMG_BLAST, DMG_BLAST_SURFACE)
	self.Type_Displayed = "HE Rounds"
	self.Purpose = "250 HU blast range"
	self.Primary.BlastRadius = 250
	self.Secondary.BashDamage = 200
	self:ClearStatCache()
	return true
end

--[Animations]--
SWEP.Animations = {
}

--[Tables]--
SWEP.StatusLengthOverride = {
	["reload"] = 25 / 30,
	["reload_empty"] = 25 / 30,
	["reload_extmag"] = 25 / 30,
	["reload_empty_extmag"] = 25 / 30,
	["reload_fast"] = 25 / 45,
	["reload_empty_fast"] = 25 / 45,
	["reload_fast_extmag"] = 25 / 45,
	["reload_empty_fast_extmag"] = 25 / 45
}
SWEP.SequenceRateOverride = {
}
SWEP.SequenceLengthOverride = {
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "Idle_to_Sprint",
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "Sprint_",
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "Sprint_to_Idle",
	}
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.slide_back") },
{ ["time"] = 30 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.slide_forward") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_out") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_in") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_out") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_in") },
{ ["time"] = 37 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.slide_back") },
{ ["time"] = 41 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.slide_forward") },
},
--[Extmag]--
["reload_extmag"] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_out") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_in") },
},
["reload_empty_extmag"] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_out") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_in") },
{ ["time"] = 37 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.slide_back") },
{ ["time"] = 41 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.slide_forward") },
},
--[Fastmag]--
["reload_fast"] = {
{ ["time"] = 10 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_out") },
{ ["time"] = 20 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_in") },
},
["reload_empty_fast"] = {
{ ["time"] = 10 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_out") },
{ ["time"] = 20 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_in") },
{ ["time"] = 35 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_pistols.hammer") },
},
["reload_fast_extmag"] = {
{ ["time"] = 10 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_out") },
{ ["time"] = 20 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_in") },
},
["reload_empty_fast_extmag"] = {
{ ["time"] = 10 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_out") },
{ ["time"] = 20 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_1911.mag_in") },
{ ["time"] = 35 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_pistols.hammer") },
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
SWEP.sightsmodel_high = "models/weapons/bo3/pistol_1911/attach/c_bo3_1911_sights_hi_cal.mdl"
SWEP.LaserSightModAttachment = 4
SWEP.LaserSightModAttachmentWorld = 4

SWEP.ViewModelBoneMods = {
["tag_silencer"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_laser_iron_sight"] = { scale = Vector(1,1,1), pos = Vector(0, 0, -0.05), angle = Angle(0, 0, 0) },
}

SWEP.WorldModelBoneMods = {
["tag_silencer"] = { scale = Vector(1,1,1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_laser_iron_sight"] = { scale = Vector(1,1,1), pos = Vector(0, 0, -0.05), angle = Angle(0, 0, 0) },
}

SWEP.VElements = {
--[Attachments]--
	["suppressor"] = { type = "Model", model = "models/weapons/signalis/upgrades/v_lowpoly_suppressor.mdl", bone = "tag_silencer", rel = "", pos = Vector(-16.8, -1.58, 1.77), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["sight_low_mini"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_mini.mdl", bone = "tag_slide_attach_animate", rel = "", pos = Vector(-8.5, -1.58, 0.9), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
	["laser_beam"] = {
		type = "Model",
		model = "models/tfa/lbeam.mdl",
		bone = "tag_laser1",
		rel = "",
		pos = Vector(-1.1, 0, 1),
		angle = Angle(0, 0, 0),
		size = Vector(2.5, 0.3, 0.3),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {},
		active = false
	},
}
SWEP.WElements = {
	["laser_beam"] = {
		type = "Model",
		model = "models/tfa/lbeam.mdl",
		bone = "prp_grip",
		rel = "",
		pos = Vector(-1.1, 0, 0),
		angle = Angle(0, 90, 90),
		size = Vector(2.5, 0.3, 0.3),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {},
		active = false
	},
	
	["suppressor"] = { type = "Model", model = "models/weapons/signalis/upgrades/v_lowpoly_suppressor.mdl", bone = "prp_grip", rel = "", pos = Vector(-3.75, 7, 1.8), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["sight_low_mini"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_mini.mdl", bone = "prp_grip", rel = "", pos = Vector(-3, 8, -1.5), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
}

SWEP.Attachments = {
	[1] = {atts = {"ins2_br_supp"}, order = 1},
	[2] = {atts = {"signalis_lowpoly_mini_smg",}, order = 2},
	[3] = {atts = {"bo3_fast_mag"}, order = 5},
	[5] = {atts = {"ins2_ub_laser"}, order = 7, sel = 1},
	--[8] = {atts = {"bo3_quickdraw"}, order = 8},
	[99] = { atts = { "bo3_hical_sights", "bo3_fmj", "am_match"}, order = 99 },	
}

SWEP.AttachmentDependencies     = {}
SWEP.AttachmentExclusions       = {}
--[[SWEP.AttachmentTableOverride = {
	["bo3_fmj"] = {
		["ViewModelBoneMods"] = {
			["tag_silencer"] = { scale = Vector(1, 1, 1), pos = Vector(1.5, 0, 0), angle = Angle(0, 0, 0) },
		},
		["WorldModelBoneMods"] = {
			["tag_silencer"] = { scale = Vector(1, 1, 1), pos = Vector(1.5, 0, 0), angle = Angle(0, 0, 0) }
		},
	},
	["bo3_long_barrel_pistol"] = {
		["Primary"] = {
			["RangeFalloffLUT"] = {
				bezier = false,
				range_func = "linear",
				units = "meters",
				lut = {
					{range = 14, damage = 1.0},
					{range = 17, damage = 0.8},
					{range = 31, damage = 0.8},
					{range = 36, damage = 0.48},
				}
			},
		},
	},
}]]
SWEP.AttachmentIconOverride     = {
	--["bo3_long_barrel_pistol"] = Material("attachments/1911/t7_icon_attach_pistol_m1911_extbarrel_01.png", "smooth"),
	--["bo3_suppressor"] = Material("attachments/1911/t7_icon_attach_pistol_m1911_suppressor_01.png", "smooth"),
	--["bo3_ext_mag"] = Material("attachments/1911/t7_icon_attach_pistol_m1911_extmag_01.png", "smooth"),
	["bo3_fast_mag"] = Material("attachments/1911/t7_icon_attach_pistol_m1911_extmag_01.png", "smooth"),
	--["bo3_fmj"] = Material("attachments/1911/t7_icon_attach_pistol_m1911_fmj_01.png", "smooth"),
	--["bo3_ub_laser"] = Material("attachments/1911/t7_icon_attach_pistol_m1911_laser_01.png", "smooth"),
	--["bo3_quickdraw"] = Material("attachments/1911/t7_icon_attach_pistol_m1911_quickdraw_01.png", "smooth"),
	--["bo3_hical_sights"] = Material("attachments/1911/t7_icon_attach_pistol_m1911_highcaliber_01.png", "smooth"),
}

DEFINE_BASECLASS(SWEP.Base)

SWEP.StatCache_Blacklist = {
    ["IronSightsPos"] = true,
    ["IronSightsAng"] = true,
    ["IronSightsPos_Mini"] = true,
    ["IronSightsAng_Mini"] = true,
    ["DrawCrosshairIS"] = true,		
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
            self.IronSightsPos_Mini = self.IronSightsPos_NVPoint
            self.IronSightsAng_Mini = self.IronSightsAng_NVPoint	
			self.DrawCrosshairIS = true
        else 
            self.CurrentSightState = 1
            self.IronSightsPos = Vector(-3.52, 0, 2.12)
            self.IronSightsAng = Vector(0.3, 0, 0)
            self.IronSightsPos_Mini = Vector(-3.535, -4, 1.55)
            self.IronSightsAng_Mini = Vector(0, 0, 0)
			self.DrawCrosshairIS = false
		end 
    end 
end

	return BaseClass.Think2(self, ...)
end