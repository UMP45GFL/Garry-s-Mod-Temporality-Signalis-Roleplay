SWEP.Base = "arc9_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Kanade's ARC9 Signalis" -- edit this if you like
SWEP.SubCategory = "Rifles"
SWEP.AdminOnly = false

SWEP.PrintName = "BU-5 Nitro Expres5"
SWEP.Class = "Rifle"
SWEP.Description = [[Very high damage. Easilupenetrates armor plating,ballistic shields and enemios.]]
SWEP.Trivia = {
    Manufacturer = "NA",
    Calibre = "16mm",
    Mechanism = "Break-Action",
    Country = "NA",
    Games = [[Signalis]]
}
SWEP.Credits = {
    Author = "DuckFlit"
}

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/signalis/c_signalis_rifle.mdl"
SWEP.WorldModel = "models/weapons/signalis/w_signalis_rifle.mdl"
SWEP.WorldModelMirror = "models/weapons/signalis/c_signalis_rifle.mdl"
SWEP.MirrorVMWM = true
SWEP.NoTPIKVMPos = false
SWEP.WorldModelOffset = {
    Pos        =    Vector(-7, 8, -2.8),
    Ang        =    Angle(-5, 5, 180),
    Bone    =    "ValveBiped.Bip01_R_Hand",
    Scale   =   1,
}
SWEP.ViewModelFOVBase = 70
SWEP.DesiredViewModelFOV = 75


SWEP.CustomCamoScale = 1
SWEP.CustomBlendFactor = 1

SWEP.DefaultBodygroups = "11111"

SWEP.DamageMax = 830
SWEP.DamageMin = 790 -- damage done at maximum range
SWEP.RangeMax = 3000
SWEP.RangeMin = 1500
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.EntityMuzzleVelocity = 10000

SWEP.PhysBulletMuzzleVelocity = 200 * 39.37

SWEP.BodyDamageMults = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 1,
    [HITGROUP_RIGHTLEG] = 1,
}

SWEP.TracerNum = 1 -- Tracer every X
SWEP.TracerFinalMag = 0 -- The last X bullets in a magazine are all tracers
SWEP.TracerEffect = "ARC9_tracer" -- The effect to use for hitscan tracers
SWEP.TracerColor = Color(255, 255, 255) -- Color of tracers. Only works if tracer effect supports it. For physical bullets, this is compressed down to 9-bit color.

SWEP.ChamberSize = 0 -- dont fucking change this again.
SWEP.ClipSize = 2 -- DefaultClip is automatically set.
SWEP.SupplyLimit = 30
SWEP.SecondarySupplyLimit = 30
SWEP.ShotgunReload = false
SWEP.ReloadTime = 1

SWEP.Crosshair = true
SWEP.CanBlindFire = false

SWEP.Recoil = 1
SWEP.RecoilSide = 1
SWEP.RecoilUp = 8

SWEP.RecoilRandomUp = 1
SWEP.RecoilRandomSide = 1

SWEP.RecoilDissipationRate = 40 -- How much recoil dissipates per second.
SWEP.RecoilResetTime = 0.01 -- How long the gun must go before the recoil pattern starts to reset.

SWEP.RecoilAutoControl = 0.5
SWEP.RecoilKick = 2

SWEP.PushBackForce = 1 -- Push the player back when shooting.

SWEP.Spread = 0
SWEP.SpreadMultShooting = 1.25

SWEP.SpreadMultSights = 2
SWEP.SpreadAddHipFire = math.rad(150 / 37.5)
SWEP.SpreadAddMove = math.rad(0 / 37.5)
SWEP.SpreadAddMidAir = 0
-- SWEP.SpreadAddShooting = math.rad(5 / 37.5) -- 0 -- = 0.05

SWEP.UsePelletSpread = true -- Multiple bullets fired at once clump up, like for a shotgun. Spread affects which direction they get fired, not their spread relative to one another.
SWEP.PelletSpread = 0.35

SWEP.NoShellEject = true

SWEP.RecoilPatternDrift = 20

SWEP.UseVisualRecoil = true
SWEP.VisualRecoilCenter = Vector(0, 0, 0)
SWEP.VisualRecoilUp = 15
SWEP.VisualRecoilSide = 0.5
SWEP.VisualRecoilRoll = 1
SWEP.VisualRecoilPunch = 15
SWEP.VisualRecoilSights = 0.5

SWEP.Speed = 0.9

SWEP.ShootWhileSprint = true
SWEP.ReloadInSights = false

-------------------------- MELEE

SWEP.Bash = true
SWEP.PrimaryBash = false
SWEP.PreBashTime = 0.2
SWEP.PostBashTime = 1

SWEP.SpeedMultSights = 0.8
SWEP.SpeedMultShooting = 0.75
SWEP.SpeedMultMelee = 1
SWEP.SpeedMultCrouch = 1
SWEP.SpeedMultBlindFire = 1

SWEP.AimDownSightsTime = 0.25
SWEP.SprintToFireTime = 0.25

SWEP.RPM = 312
SWEP.Num = 1
SWEP.AmmoPerShot = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        PrintName = "BOTH",
        Mode = 1,
        NumMult = 2,
        SpreadMult = 1.25,
        AmmoPerShotOverride = 2,
        RecoilMult = 2,
        RecoilUpMult = 2,
        RecoilSideMult = 1.5,
        PushBackForceMult = 2,
    },
}

SWEP.ARC9WeaponCategory = 2
SWEP.NPCWeight = 100

SWEP.FreeAimRadius = 0 -- In degrees, how much this gun can free aim in hip fire.
SWEP.Sway = 0 -- How much the gun sways.

SWEP.FreeAimRadiusMultSights = 0

SWEP.SwayMultSights = 0

SWEP.Ammo = "357" -- what ammo type the gun uses

SWEP.ShootVolume = 150
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0

SWEP.ShootSound = "KANADE_ARC9_SIGNALIS_BU5_Fire"
SWEP.ShootSoundSilenced = "ARC9_SIGNALIS_BU5_FireSil"

--SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.MuzzleParticle = "weapon_muzzle_flash_awp" -- Used for some muzzle effects.

SWEP.ShotDynamicLightBrightness = 4
SWEP.ShotDynamicLightSize = 600

SWEP.ShellModel = "models/shells/shell_338mag.mdl"
SWEP.ShellPitch = 90
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectQCA = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectQCA = 2 -- which attachment to put the case effect on
SWEP.ProceduralViewQCA = nil
SWEP.CamQCA = 0

SWEP.BulletBones = {
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSights = {
    Pos = Vector(-4.66, -10, 0.43),
    Ang = Angle(0, 0, 0.7),
    Magnification = 1.15,
    ViewModelFOV = 60,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.SightMidPoint = {
    Pos = Vector(-1.5025, -1.5, 0.5),
    Ang = Angle(0.006, 0.8, -2.5),
}

SWEP.HoldType = "rpg"
SWEP.HoldTypeSprint = "rpg"
SWEP.HoldTypeHolstered = "rpg"
SWEP.HoldTypeSights = "rpg"
SWEP.HoldTypeCustomize = "slam"
SWEP.HoldTypeBlindfire = "pistol"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
SWEP.NonTPIKAnimReload = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.ActivePos = Vector(-1, -3, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.MovingPos = Vector(0, -1, -1)
SWEP.MovingAng = Angle(0, 0, 0)

SWEP.MovingMidPoint = {
    Pos = Vector(0, -0.5, -0.5),
    Ang = Angle(0, 0, 0)
}

SWEP.CrouchPos =  Vector(0, -0.5, -1)
SWEP.CrouchAng = SWEP.ActiveAng

SWEP.RestPos = SWEP.ActivePos
SWEP.RestAng = SWEP.ActiveAng

SWEP.SprintVerticalOffset = false
SWEP.SprintPos = SWEP.ActivePos
SWEP.SprintAng = SWEP.ActiveAng

SWEP.CustomizePos = Vector(20, 30, 4)
SWEP.CustomizeAng = Angle(90, 0, 0)

SWEP.BarrelLength = 0 -- = 25

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Perk",
        DefaultCompactName = "PERK",
        Bone = "j_gun",
        Pos = Vector(-5, 0, -5),
        Ang = Angle(0, 0, 0),
        Category = "mwc_perk",
        ExcludeElements = {"bo1_perkacola"},
    },
    {
        PrintName = "Rail optic",
        DefaultName = "Top Rail",
        Bone = "tag_rail",
        Pos = Vector(-5, 0.25, -1),
        Ang = Angle(0, 0, 0),
        Category = {"csgo_rail_optic", "cod_rail_optic", "rail"}
    },
    {
        PrintName = "Proficiency",
        DefaultCompactName = "PRO",
        Bone = "j_gun",
        Pos = Vector(-8, 0, -5),
        Ang = Angle(0, 0, 0),
        Category = "mwc_proficiency",
        ExcludeElements = {"bo1_perkacola"},
    }
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1 / 35,
    },
    ["draw"] = {
        Source = "draw",
    },
    ["holster"] = {
        Source = "holster",
    },
    ["ready"] = {
        Source = "draw_first",
        Time = 1,
            {s = "ARC9_SIGNALIS_BU5_BarelClose", t = 0.4},
    },
    ["fire"] = {
        Source = {
            "fire",
        },
        Time = 9 / 30,
    },
    ["fire_iron"] = {
        Source = {
            "fire_ads",
        },
        Time = 9 / 30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 4,
        EventTable = {
            {s = "ARC9_SIGNALIS_BU5_LatchOpen", t = 0.42},
            {s = "ARC9_SIGNALIS_BU5_BarelOpen", t = 1.15},
            {s = "ARC9_SIGNALIS_BU5_Shell1", t = 1.25},
            {s = "ARC9_SIGNALIS_BU5_Spring", t = 2.3},
            {s = "ARC9_SIGNALIS_BU5_Shell1", t = 2.5},
            {s = "ARC9_SIGNALIS_BU5_BarelClose", t = 3.2},
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 4,
        EventTable = {
            {s = "ARC9_SIGNALIS_BU5_LatchOpen", t = 0.42},
            {s = "ARC9_SIGNALIS_BU5_BarelOpen", t = 1.15},
            {s = "ARC9_SIGNALIS_BU5_Shell1", t = 1.25},
            {s = "ARC9_SIGNALIS_BU5_Shell2", t = 1.25},
            {s = "ARC9_SIGNALIS_BU5_Spring", t = 2.3},
            {s = "ARC9_SIGNALIS_BU5_Shell1", t = 2.5},
            {s = "ARC9_SIGNALIS_BU5_BarelClose", t = 3.2},
        },
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 2.5,
    },
    ["idle_sprint"] = {
        Source = "sprint_loop",
        Time = 30 / 40
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
        Time = 1,
    },
    ["bash"] = {
        Source = "bash",
        Time = 1,
    },
}