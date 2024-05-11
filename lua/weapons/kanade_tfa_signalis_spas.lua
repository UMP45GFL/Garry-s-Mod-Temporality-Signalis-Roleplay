SWEP.Base					= "tfa_bash_base"
SWEP.Category				= "Kanade's TFA Signalis" --Category where you will find your weapons
SWEP.PrintName				= "EIN-12 Flechette"		-- Weapon name (Shown on HUD)	
SWEP.Purpose = "EIN-12 Flechette. Can hit multiple targets at once. Low damage, but high chance to stagger enemies at close range."
SWEP.Slot					= 3			-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.Weight					= 75		-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Author = "Zacks & 1nazuma"
SWEP.Spawnable				= (TFA) and true or false -- INSTALL SHARED PARTS
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS 		= false --Draw the crosshair in ironsights?
SWEP.FiresUnderwater 		= false
SWEP.Type					= "Pump-Action Shotgun"


--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("TFA_COD13_SPAS12.1") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = Sound("TFA_COD13_SPAS12.2") -- This is the sound of the weapon, when silenced.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 16 -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 --Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 12 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.RPM = 600 -- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Displayed = 90 -- This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = nil --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = true

SWEP.RTScopeAttachment = 1
SWEP.ScopeAngleTransforms = {}
SWEP.ScopeOverlayTransformMultiplier = 1
SWEP.ScopeOverlayTransforms = {0, 0}

SWEP.RTMaterialOverride 			= -1 											-- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTOpaque 						= true 											-- Do you want your render target to be opaque?
SWEP.RTCode							= nil

--Miscelaneous Sounds
SWEP.IronInSound = "weapon_bo3_gear.rattle"
SWEP.IronOutSound = "weapon_bo3_gear.rattle"

--Silencing
SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?

-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = true --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
SWEP.DefaultFireMode = nil --Default to auto or whatev
SWEP.FireModeName = "Pump-Action" --Change to a text value to override it

--Ammo Related
SWEP.Primary.ClipSize = 6 -- This is the size of a clip
SWEP.Primary.DefaultClip = 60 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "buckshot" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = true --Disable round-in-the-chamber
SWEP.AmmoTypeStrings = {buckshot = "16mm armor-piercing rounds"}
--Recoil Related
SWEP.Primary.KickUp = 2 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.33 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.37 -- This is the maximum sideways recoil (no real term)

--Firing Cone Related
SWEP.Primary.Spread = .04 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .04 -- Ironsight accuracy, should be the same for shotguns

--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = nil--How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = nil --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = nil --How much the spread recovers, per second. Example val: 3

--Range Related
--SWEP.Primary.Range = 11750 * 4 / 3 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.Range = 1500 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = nil -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

--Penetration Related
SWEP.MaxPenetrationCounter = 4 --The maximum number of ricochets.  To prevent stack overflows.

--Misc
SWEP.IronRecoilMultiplier = 0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.5 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

--Movespeed
SWEP.MoveSpeed = 0.9 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.8 --Multiply the player's movespeed by this when sighting.

--[[VIEWMODEL]]--
SWEP.ViewModel				= "models/weapons/signalis/c_signalis_spas.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 70		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true 		--Use gmod c_arms system.
SWEP.VMPos = Vector(-1,1,1) 	--The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0,0,0) 	--The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/weapons/signalis/w_signalis_spas.mdl" -- Weapon world model path
SWEP.HoldType = "shotgun" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = -5.5,
		Right = 0.8,
		Forward = 17
	},
	Ang = {
		Up = 90,
		Right = -0,
		Forward = 189
	},
	Scale = 0.9
} --Procedural world model animation, defaulted for CS:S purposes.
SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.

SWEP.Secondary.BashDamage = 50

--[[HOLDTYPES]]--

--[[SCOPES]]--
SWEP.IronSightsSensitivity = 1 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = false --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.875 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.5 --Scale of the scope overlay
SWEP.ReticleScale = 0.7 --Scale of the reticle overlay

--[[SHOTGUN CODE]]--
SWEP.Shotgun = true --Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim = true --Enable emtpy reloads on shotguns?
SWEP.ShotgunEmptyAnim_Shell = true --Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime = .75 -- For shotguns, how long it takes to insert a shell.

--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.IronSightTime 	 = 0.3
SWEP.IronSightsPos = Vector(-4.115, -2.25, 2.419)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronSightsPos_ACOG 	= Vector(-4.088, -3.3, 1.5)
SWEP.IronSightsAng_ACOG 	= Vector(0, 0, 0)
SWEP.Secondary.IronFOV_ACOG = 55

SWEP.IronSightsPos_Holo 	= Vector(-4.095, -2.25, 1.85)
SWEP.IronSightsAng_Holo 	= Vector(0, 0, 0)

SWEP.IronSightsPos_MicroT1 	= Vector(-4.088, -2.25, 1.615)
SWEP.IronSightsAng_MicroT1 	= Vector(0, 0, 0)

--SWEP.IronSightsPos_Mini 	= Vector(-3.409, -3, 0.11)
--SWEP.IronSightsAng_Mini 	= Vector(0, 0, 0)

SWEP.IronSightsPos_Reflex 	= Vector(-4.115, -2.25, 1.54)
SWEP.IronSightsAng_Reflex	= Vector(0, 0, 0)

SWEP.IronSightsPos_stock = Vector(1, 3, -0.5)
SWEP.IronSightsAns_stock = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_stock = 65

SWEP.IronSightsPos_NVPoint = Vector(1, 3, -0.5)
SWEP.IronSightsAng_NVPoint = Vector(0, 0, 0)

SWEP.Secondary.BashDamage = 50

SWEP.Secondary.IronFOV = 70 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.Secondary.ScopeZoom = 12 --IMPORTANT BIT

--[[SPRINTING]]--

SWEP.RunSprintPos = Vector(2.95, -3.057, -4.119)
SWEP.RunSprintAng = Vector(-13.131, 33.537, -29.906)

SWEP.CrouchPos    = Vector(-2, -2.8, -2)
SWEP.CrouchAng    = Vector(0, 0, -15)

SWEP.SafetyPos = Vector(-1, -2, -0.5)
SWEP.SafetyAng = Vector(-15, 25, -20)
--[[INSPECTION]]--
SWEP.InspectPos = Vector(20.5, -1.5, 0) --Replace with a vector, in style of ironsights position, to be used for inspection
SWEP.InspectAng = Vector(33.5, 55, 33.5) --Replace with a vector, in style of ironsights angle, to be used for inspection
--Replace with a vector, in style of ironsights angle, to be used for inspection

--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

--[[VIEWMODEL BLOWBACK]]--

SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0, -3, 0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = false --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "ShotgunShellEject"--Which shell effect to use

--[[ANIMATION]]--
 --Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
SWEP.SequenceLengthOverride = {
	["melee"] = 0.9,
	["pump"] = 0.7,
} --Changes both the status delay and the nextprimaryfire of a given animation

SWEP.SequenceRateOverride = {
	["reload_loop"] = 1.25,
} --Like above but changes animation length to a target

SWEP.SequenceRateOverrideScaled = {} --Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled = nil
SWEP.ProceduralHolsterTime = 0.3
SWEP.ProceduralHolsterPos = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng = Vector(-40, -30, 10)

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_ANI --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.005 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
--MDL Animations Below
SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_sprint_in", --Number for act, String/Number for sequence
		["is_idle"] = true,
		["transition"] = true
	},
		["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_sprint_loop", --Number for act, String/Number for sequence
		["transition"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "base_sprint_out", --Number for act, String/Number for sequence
		["transition"] = true
	},
}
--[[EFFECTS]]--

--Attachments
SWEP.MuzzleAttachment			= 1 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= 2 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = true --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.MuzzleFlashEffect = nil
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.SmokeParticle = nil --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = false --Disable automatic ejection smoke

--Shell eject override
--SWEP.ShellModel = "models/shell/50beowulf_shell.mdl" --In case you want custom shell models
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellModel = nil --The model to use for ejected shells
SWEP.LuaShellScale = nil --The model scale to use for ejected shells
SWEP.LuaShellYaw = nil --The model yaw rotation ( relative ) to use for ejected shells
SWEP.LuaShellEffect = "ShotgunShellEject" --The effect used for shell ejection; Defaults to that used for blowback
SWEP.ShellScale = nil

--Tracer Stuff
SWEP.TracerName 		= nil 	--Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 1 	--0 disables, otherwise, 1 in X chance

--Impact Effects
SWEP.ImpactEffect = nil--Impact Effect
SWEP.ImpactDecal = nil--Impact Decal

--[[RENDER TARGET]]--

SWEP.RTMaterialOverride = nil -- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTOpaque = false -- Do you want your render target to be opaque?
SWEP.RTCode = nil--function(self) return end --This is the function to draw onto your rendertarget
--[[AKIMBO]]--

SWEP.Akimbo = false --Akimbo gun?  Alternates between primary and secondary attacks.
SWEP.AnimCycle = 0 -- Start on the right

SWEP.Primary.MaxAmmo = 80
-- Max Ammo function
function SWEP:NZMaxAmmo()

    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
    end
end
-- PaP Function
SWEP.NZPaPName                = "Gremlin"
function SWEP:OnPaP()
self.Ispackapunched = 1
self.Primary.Damage = self.Primary.Damage*2
self.Primary.ClipSize = 32
self.Primary.MaxAmmo = 128
self:ClearStatCache()
return true
end

SWEP.EventTable = {
	[ACT_SHOTGUN_PUMP] = {
		{time = 2 / 10, type = "lua", value = function(self) self:EventShell() end, client = true, server = true}
	},
	[ACT_VM_DRAW] = {
	{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
	{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
	},
	[ACT_VM_HOLSTER] = {
	{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
	{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
	},		
}

--[[MISC INFO FOR MODELERS]]--
--[[

Used Animations (for modelers):

ACT_VM_DRAW - Draw
ACT_VM_DRAW_EMPTY - Draw empty
ACT_VM_DRAW_SILENCED - Draw silenced, overrides empty

ACT_VM_IDLE - Idle
ACT_VM_IDLE_SILENCED - Idle empty, overwritten by silenced
ACT_VM_IDLE_SILENCED - Idle silenced

ACT_VM_PRIMARYATTACK - Shoot
ACT_VM_PRIMARYATTACK_EMPTY - Shoot last chambered bullet
ACT_VM_PRIMARYATTACK_SILENCED - Shoot silenced, overrides empty
ACT_VM_PRIMARYATTACK_1 - Shoot ironsights, overriden by everything besides normal shooting
ACT_VM_DRYFIRE - Dryfire

ACT_VM_RELOAD - Reload / Tactical Reload / Insert Shotgun Shell
ACT_SHOTGUN_RELOAD_START - Start shotgun reload, unless ACT_VM_RELOAD_EMPTY is there.
ACT_SHOTGUN_RELOAD_FINISH - End shotgun reload.
ACT_VM_RELOAD_EMPTY - Empty mag reload, chambers the new round.  Works for shotguns too, where applicable.
ACT_VM_RELOAD_SILENCED - Silenced reload, overwrites all


ACT_VM_HOLSTER - Holster
ACT_VM_HOLSTER_SILENCED - Holster empty, overwritten by silenced
ACT_VM_HOLSTER_SILENCED - Holster silenced

]]--

SWEP.Attachments = {
	[1] = { offset = { 0, 0 }, atts = { "sg_frag","sg_slug", "ammo_dragonbreath_shells", "fas2tfa_ammo_incn", "ammo_flechette_shells", "amno_flechette", "kzsf_vc30_incendiary"}, order = 1 },
	[3] = {atts = {"ins2_ub_laser"}, order = 3},	
	[4] = { offset = { 0, 0 }, atts = { "stock2","signalis_lowpoly_acog","signalis_lowpoly_holo","signalis_lowpoly_microt1",--[["signalis_lowpoly_mini_smg",]]"signalis_lowpoly_reflex"}, order = 4 },
	[5] = { offset = { 0, 0 }, atts = { "stock1","stock3"}, order = 5 },	
	[99] = { offset = { 0, 0 }, atts = { "spas_auto",},  },			
}

SWEP.VElements = {
	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_band.mdl", bone = "tag_weapon", rel = "", pos = Vector(20, 0.02, 0.7), angle = Angle(0, 0, 0), size = Vector(1.25, 1.25 ,1.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "A_Beam", rel = "laser", pos = Vector(0, 0, 0), angle = Angle(0, 0.1, 0), size = Vector(2.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
	["sight_low_acog"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_acog.mdl", bone = "tag_weapon", rel = "", pos = Vector(-16.2, -2.8, 5.2), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["sight_low_holo"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_holo.mdl", bone = "tag_weapon", rel = "", pos = Vector(-13.2, -1.55, 3.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["sight_low_t1"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_microt1.mdl", bone = "tag_weapon", rel = "", pos = Vector(-13.2, -1.55, 3.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	--["sight_low_mini"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_mini.mdl", bone = "tag_weapon_right", rel = "", pos = Vector(-5.8, -1.6, 6.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["sight_low_ref"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_reflex.mdl", bone = "tag_weapon", rel = "", pos = Vector(-13.2, -1.55, 3.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["rail_sights"] = { type = "Model", model = "models/weapons/signalis/upgrades/v_lowpoly_rail.mdl", bone = "tag_weapon", rel = "", pos = Vector(-13.2, -1.55, 3.6), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },	
}

SWEP.WElements = {
	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_band.mdl", bone = "prp_pump", rel = "", pos = Vector(-0.7, -12.02, 0), angle = Angle(0, 90, -90), size = Vector(1.25, 1.25 ,1.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "prp_pump", rel = "laser", pos = Vector(0, 0, -2.5), angle = Angle(0, 0, 0), size = Vector(2.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
	["sight_low_acog"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_acog.mdl", bone = "prp_pump", rel = "", pos = Vector(-4.5, 22, -3), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["sight_low_holo"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_holo.mdl", bone = "prp_pump", rel = "",pos = Vector(-3, 19, -2), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["sight_low_t1"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_microt1.mdl", bone = "prp_pump", rel = "", pos = Vector(-3, 19, -2), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["sight_low_ref"] = { type = "Model", model = "models/weapons/signalis/upgrades/lowpoly_scope_reflex.mdl", bone = "prp_pump", rel = "", pos = Vector(-3, 19, -2), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },	
}
SWEP.AttachmentExclusions = {
	["stock1"] = { "stock2" },
	["stock3"] = { "stock2" },
}--{ ["si_iron"] = {"bg_heatshield"} }

SWEP.PumpAction = {
    ["type"] = TFA.Enum.ANIMATION_SEQ,
    ["value"] = "pump"
}

--[Attachments]--
SWEP.LaserSightModAttachment = 1
SWEP.LaserSightModAttachmentWorld = 4

DEFINE_BASECLASS( SWEP.Base )

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
            self.IronSightsPos = Vector(-4.115, -2.25, 2.419)
            self.IronSightsAng = Vector(0, 0, 0)
            self.IronSightsPos_ACOG 	= Vector(-4.088, -3.3, 1.5)
            self.IronSightsAng_ACOG 	= Vector(0, 0, 0)
            self.IronSightsPos_Holo 	= Vector(-4.095, -2.25, 1.85)
            self.IronSightsAng_Holo 	= Vector(0, 0, 0)
            self.IronSightsPos_MicroT1 	= Vector(-4.088, -2.25, 1.615)
            self.IronSightsAng_MicroT1 	= Vector(0, 0, 0)
            self.IronSightsPos_Reflex 	= Vector(-4.115, -2.25, 1.54)
            self.IronSightsAng_Reflex	= Vector(0, 0, 0)
            self.IronSightsPos_stock = Vector(1, 3, -0.5)
            self.IronSightsAns_stock = Vector(0, 0, 0)
			self.Secondary.IronFOV_ACOG = 55
			self.DrawCrosshairIS = false
		end 
    end 
end

	return BaseClass.Think2(self, ...)
end