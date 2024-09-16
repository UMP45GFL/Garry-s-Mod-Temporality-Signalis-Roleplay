SWEP.Base = "tfa_bash_base"
SWEP.Category = "Kanade's TFA Signalis"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.7
SWEP.AdminSpawnable = true
SWEP.UseHands = true
--SWEP.Manufacturer = "NA"
SWEP.Purpose = "BW-5 Nitro Express Rifle. Very high damage. Easily penetrates armor plating, ballistic shields and enemies."
SWEP.Type_Displayed = "Shotgun"
SWEP.Author = "Zacks & 1nazuma"
SWEP.Slot = 3
SWEP.PrintName = "BW-5 Nitro Express Rifle"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/signalis/c_signalis_rifle.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/signalis/w_signalis_rifle.mdl"
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.MuzzleAttachment = "1"
SWEP.MuzzleAttachmentSilenced = "3"
SWEP.VMPos = Vector(0, -6, -1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true
SWEP.CrouchPos    = Vector(-1, 0, -1.25)
SWEP.CrouchAng    = Vector(0, 0, -10)

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
			Up = -2.3,
			Right = 1,
			Forward = 3,
        },
        Ang = {
			Up = -90,
			Right = 180,
			Forward = 10
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "weapon_bo3_olympia.fire"
SWEP.Primary.SilencedSound = "weapon_bo3_olympia.fire_supp"
SWEP.Primary.SoundEchoTable = {
	[0] = Sound("weapon_bo3_shotgun.TailInside"),
	[256] = Sound("weapon_bo3_shotgun.TailOutside")
}
SWEP.Primary.Sound_DryFire = "weapon_bo3_dryfire.shotgun"
SWEP.Primary.Sound_Blocked = "weapon_bo3_dryfire.shotgun"
SWEP.Primary.Ammo = "nitro16mm"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 212
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.RPM_rapidfire = 225
SWEP.Primary.Damage = 24
SWEP.Primary.NumShots = 6
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 11
SWEP.Primary.DryFireDelay = 0.35
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.DefaultFireMode = nil
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
		{range = 10, damage = 1.0},
		{range = 15, damage = 0.54},
		{range = 25, damage = 0.54},
		{range = 30, damage = 0.2},
	}
}

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.5 --0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 --.09

SWEP.ViewModelPunch_MaxVertialOffset				= 2 --3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 --1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 --1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 --0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 --0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 --0.25

SWEP.ChangeStateRecoilMultiplier = 1.3 --1.3
SWEP.CrouchRecoilMultiplier = 0.65 --0.65
SWEP.JumpRecoilMultiplier = 1.3 --1.3
SWEP.WallRecoilMultiplier = 1.1 --1.1

--[Spread Related]--
SWEP.Primary.Spread		  = .04
SWEP.Primary.IronAccuracy = .02
SWEP.IronRecoilMultiplier = 0.75

SWEP.Primary.KickUp				= 7
SWEP.Primary.KickDown 			= 0.7
SWEP.Primary.KickHorizontal		= 0.5
SWEP.Primary.StaticRecoilFactor = 0.6

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 1.2
SWEP.Primary.SpreadRecovery = 3.5

SWEP.ChangeStateAccuracyMultiplier = 1.0 --1.5
SWEP.CrouchAccuracyMultiplier = 1.0 --0.5
SWEP.JumpAccuracyMultiplier = 2.0 --2
SWEP.WalkAccuracyMultiplier = 1.5 --1.35

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
SWEP.IronSightsPos = Vector(-4.66, -2, 1.85)
SWEP.IronSightsAng = Vector(0.15, 0.01, 0)

SWEP.IronSightsPos_NVPoint = Vector(0, 0, 0)
SWEP.IronSightsAng_NVPoint = Vector(0, 0, 0)

SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
--SWEP.LuaShellModel = "models/entities/tfa_codww2/shells/fx_9mm.mdl"
SWEP.LuaShellSound = "weapon_bo3_shells.shotgun"
SWEP.LuaShellScale = 0.4
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = false

--[Jamming]-- Shotgun
SWEP.CanJam = false
SWEP.JamChance = 0.04
SWEP.JamFactor = 0.055

--[Misc]--
SWEP.AmmoTypeStrings = {nitro16mm = "16mm armor-piercing rounds"}
SWEP.FireModeSound = "weapon_bo3_misc.switch"
SWEP.PickupSound = "weapon_bo3_pickup.ammo"
SWEP.InspectPos = Vector(11, -2, -3)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(-1, -2, -0.5)
SWEP.SafetyAng = Vector(-15, 25, -20)
SWEP.TracerCount = 1

--[DInventory2]--
SWEP.DInv2_GridSizeX = 2
SWEP.DInv2_GridSizeY = 3
SWEP.DInv2_Volume = nil
SWEP.DInv2_Mass = 4

--[NZombies]--
SWEP.NZPaPName = "Hades"
SWEP.Primary.MaxAmmo = 40

function SWEP:NZMaxAmmo()

    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Ispackapunched = false
function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary.Damage = 600
self.Primary.Knockback = 15
self.Primary.ClipSize = 2
self.Primary.MaxAmmo = 62
self.Primary.NumShots = 12
self.Primary.DamageType = bit.bor( DMG_BURN, DMG_SLOWBURN )
self.TracerName = "tfa_tracer_incendiary"
self.MuzzleFlashEffect = "tfa_muzzleflash_incendiary"
self.MoveSpeed = 1
self.Attachments = {
[1] = {atts = {"signalis_rifle_long_barrel"}, order = 1, select = 1},
[2] = {atts = {"bo3_suppressor"}, order = 2},
[3] = {atts = {"bo3_si_elo","bo3_si_reflex","bo3_si_boa3"}, order = 3},
[6] = {atts = {"bo3_fast_mag"}, order = 6, select = 1},
[7] = {atts = {"bo3_ub_laser"}, order = 7},
[9] = {atts = {"bo3_quickdraw"}, order = 9},
[11] = {atts = {"bo3_stock"}, order = 11},
[12] = {atts = {"bo3_rapidfire"}, order = 12},
}
self:ClearStatCache()
return true
end

--[Animations]--
SWEP.Animations = {
}

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 70 / 35,
	[ACT_VM_RELOAD_EMPTY] = 70 / 35,
	["reload_fast"] = 50 / 45,
}
SWEP.SequenceRateOverride = {
	["bash"] = 40 / 30,
}
SWEP.SequenceLengthOverride = {
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_in", --Number for act, String/Number for sequence
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
	}
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
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.close") },
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.latch") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 15 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.latch") },
{ ["time"] = 30 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.open") },
{ ["time"] = 35 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.spring") },
{ ["time"] = 65 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.shell_1") },
{ ["time"] = 90 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.close") },
{ ["time"] = 90 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.latch") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 15 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.latch") },
{ ["time"] = 30 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.open") },
{ ["time"] = 35 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.spring") },
{ ["time"] = 65 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.shell_2") },
{ ["time"] = 95 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.close") },
{ ["time"] = 95 / 35, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.latch") },
},
--[Fastmag]--
["reload_fast"] = {
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.open") },
{ ["time"] = 10 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.latch") },
{ ["time"] = 15 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.spring") },
{ ["time"] = 15 / 60, ["type"] = "lua", ["value"] = function(wep, vm) wep:Unload() end, ["client"] = true, ["server"] = true},
{ ["time"] = 45 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.shell_2") },
{ ["time"] = 70 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.close") },
{ ["time"] = 70 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_olympia.latch") },
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
["tag_silencer_attach"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_flash"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.WorldModelBoneMods = {
["tag_silencer_attach"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
["tag_flash"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.VElements = {
--other
--["laser"] = { type = "Model", model = "models/weapons/bo3/olympia/attach/c_bo3_olympia_dbal.mdl", bone = "tag_weapon", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, active = false, bodygroup = {} },
["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "tag_laser1", rel = "", pos = Vector(-11, -1.45, -1.1), angle = Angle(0, 0, 0), size = Vector(2.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, translucent = true, active = false },
["suppressor"] = { type = "Model", model = "models/weapons/bo3/olympia/attach/c_bo3_olympia_suppressor.mdl", bone = "tag_weapon", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, active = false, bodygroup = {} },
}

SWEP.WElements = {
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "prp_barrel", rel = "", pos = Vector(-2, -0.15, 0), angle = Angle(0, 0, 0), size = Vector(2.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, translucent = true, active = false },
}

SWEP.Attachments = {
	[1] = {atts = {"signalis_rifle_long_barrel"}, order = 1, sel = 1},
	--[2] = {atts = {"bo3_suppressor"}, order = 2},
	[6] = {atts = {"bo3_fast_mag"}, order = 3},
	[7] = {atts = {"ins2_ub_laser"}, order = 4, sel = 1},
	[12] = {atts = {"bo3_rapidfire_shotgun"}, order = 5},
	[99] = {atts = { "sg_frag","sg_slug", "spas_dragonbreath_shells", "fas2tfa_ammo_incn", "ammo_flechette_shells", "amno_flechette", "kzsf_vc30_incendiary"}},
}

SWEP.AttachmentDependencies     = {}
SWEP.AttachmentExclusions		= {}
SWEP.AttachmentTableOverride	= {
	["bo3_fast_mag"] = {
		["Animations"] = {
			["reload"] = {
				["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
				["value"] = "reload_fast"
			},
			["reload_empty"] = {
				["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
				["value"] = "reload_fast"
			},
		},
	},
	["signalis_rifle_long_barrel"] = {
		["VElements"] = {
			["default_pip_sight"] = {
				["active"] = false
			},
		},
		["WElements"] = {
			["default_pip_sight"] = {
				["active"] = false
			},
		},
		["ViewModelBoneMods"] = {
			["tag_flash"] = { scale = Vector(1, 1, 1), pos = Vector(3.926, 0, 0), angle = Angle(0, 0, 0) },
			["tag_silencer_attach"] = { scale = Vector(1, 1, 1), pos = Vector(3.926, 0, 0), angle = Angle(0, 0, 0) },
		},
		["WorldModelBoneMods"] = {
			["tag_flash"] = { scale = Vector(1, 1, 1), pos = Vector(3.926, 0, 0), angle = Angle(0, 0, 0) },
			["tag_silencer_attach"] = { scale = Vector(1, 1, 1), pos = Vector(3.926, 0, 0), angle = Angle(0, 0, 0) },
		},
		["Primary"] = {
			["RangeFalloffLUT"] = {
				bezier = false,
				range_func = "linear",
				units = "meters",
				lut = {
					{range = 20, damage = 1.0},
					{range = 30, damage = 0.54},
					{range = 50, damage = 0.54},
					{range = 60, damage = 0.2},
				}
			},
		},
	},
}
SWEP.AttachmentIconOverride     = {
	["signalis_rifle_long_barrel"] = Material("attachments/olympia/t7_icon_attach_shotgun_olympia_extbarrel_01_rwd.png", "smooth"),
	["bo3_suppressor"] = Material("attachments/olympia/t7_icon_attach_shotgun_olympia_suppressor_01_rwd.png", "smooth"),
	["bo3_ext_mag"] = Material("attachments/olympia/t7_icon_attach_shotgun_olympia_extmag_01_rwd.png", "smooth"),
	["bo3_fast_mag"] = Material("attachments/olympia/t7_icon_attach_shotgun_olympia_fastmag_01_rwd.png", "smooth"),
	["bo3_ub_laser"] = Material("attachments/olympia/t7_icon_attach_shotgun_olympia_laser_01_rwd.png", "smooth"),
	["bo3_quickdraw"] = Material("attachments/olympia/t7_icon_attach_shotgun_olympia_quickdraw_01_rwd.png", "smooth"),
	["bo3_stock"] = Material("attachments/olympia/t7_icon_attach_shotgun_olympia_extstock_01_rwd.png", "smooth"),
	["bo3_rapidfire"] = Material("attachments/olympia/t7_icon_attach_shotgun_olympia_rapidfire_01_rwd.png", "smooth"),
}

DEFINE_BASECLASS( SWEP.Base )

SWEP.StatCache_Blacklist = {
    ["IronSightsPos"] = true,
    ["IronSightsAng"] = true,
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
			self.DrawCrosshairIS = true
        else 
            self.CurrentSightState = 1
            self.IronSightsPos = Vector(-4.66, -2, 1.85)
            self.IronSightsAng = Vector(0.15, 0.01, 0)
			self.DrawCrosshairIS = false
		end 
    end 
end

	return BaseClass.Think2(self, ...)
end