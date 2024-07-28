SWEP.Base = "arc9_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Kanade's ARC9 Signalis" -- edit this if you like
SWEP.SubCategory = "Handguns"
SWEP.AdminOnly = false

SWEP.PrintName = "Eu-K508 S 'Einhorn'"
SWEP.Class = "Revolver"
SWEP.Description = [[A short-barreled double-action 6-shot revolver that fires .357 high-power ammo. High recoil, strong knockback.]]
SWEP.Trivia = {
    Manufacturer = "NA",
    Calibre = ".357",
    Mechanism = "Revolver",
    Country = "NA",
    Games = [[Signalis]]
}
SWEP.Credits = {
    Author = "DuckFlit"
}

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/signalis/c_signalis_revolver.mdl"
SWEP.WorldModel = "models/weapons/signalis/w_signalis_revolver.mdl"
SWEP.WorldModelMirror = "models/weapons/signalis/c_signalis_revolver.mdl"
SWEP.MirrorVMWM = true
SWEP.NoTPIKVMPos = false
SWEP.WorldModelOffset = {
    Pos         =    Vector(-19.75, 2, -1.75),
    Ang         =    Angle(-6, 0, 182),
    Bone        =    "ValveBiped.Bip01_R_Hand",
    Scale       = 1.1,
}
SWEP.ViewModelFOVBase = 75

SWEP.DefaultBodygroups = "00000000000000"

SWEP.DamageMax = 80
SWEP.DamageMin = 68 -- damage done at maximum range
SWEP.RangeMax = 4500
SWEP.RangeMin = 1500
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.EntityMuzzleVelocity = 10000

SWEP.PhysBulletMuzzleVelocity = 400 * 39.37

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
SWEP.ClipSize = 6 -- DefaultClip is automatically set.
SWEP.SupplyLimit = 10
SWEP.SecondarySupplyLimit = 10
SWEP.ReloadTime = 1

SWEP.Crosshair = true
SWEP.CanBlindFire = false

SWEP.Recoil = 1
SWEP.RecoilSide = 0.6
SWEP.RecoilUp = 3

SWEP.RecoilRandomUp = 0.5
SWEP.RecoilRandomSide = 0.35

SWEP.RecoilDissipationRate = 40 -- How much recoil dissipates per second.
SWEP.RecoilResetTime = 0.01 -- How long the gun must go before the recoil pattern starts to reset.

SWEP.RecoilAutoControl = 0.5
SWEP.RecoilKick = 1

SWEP.Spread = math.rad(1.35 / 37.5)
SWEP.SpreadMultShooting = 1.25

SWEP.SpreadMultSights = 0.1
SWEP.SpreadAddHipFire = math.rad(150 / 37.5)
SWEP.SpreadAddMove = math.rad(0 / 37.5)
SWEP.SpreadAddMidAir = 0
-- SWEP.SpreadAddShooting = math.rad(5 / 37.5) -- 0 -- = math.rad(130 / 37.5)

SWEP.RecoilPatternDrift = 20

SWEP.UseVisualRecoil = true
SWEP.VisualRecoilCenter = Vector(0, 0, 0)
SWEP.VisualRecoilUp = 0.5
SWEP.VisualRecoilSide = 0.15
SWEP.VisualRecoilRoll = 1
SWEP.VisualRecoilPunch = 4
SWEP.VisualRecoilSights = 0.5

SWEP.Speed = 1

SWEP.ShootWhileSprint = true
SWEP.ReloadInSights = false

-------------------------- MELEE

SWEP.Bash = true
SWEP.PrimaryBash = false
SWEP.PreBashTime = 0.2
SWEP.PostBashTime = 0.7

SWEP.HideBones = {
    [1] = "f_speedloader",
}

SWEP.SpeedMultSights = 0.8
SWEP.SpeedMultShooting = 0.75
SWEP.SpeedMultMelee = 1
SWEP.SpeedMultCrouch = 1
SWEP.SpeedMultBlindFire = 1

SWEP.AimDownSightsTime = 0.2
SWEP.SprintToFireTime = 0.2

SWEP.RPM = 200
SWEP.AmmoPerShot = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
}
SWEP.ARC9WeaponCategory = 1
SWEP.NPCWeight = 100

SWEP.FreeAimRadius = 0 -- In degrees, how much this gun can free aim in hip fire.
SWEP.Sway = 0 -- How much the gun sways.

SWEP.FreeAimRadiusMultSights = 0

SWEP.SwayMultSights = 0

SWEP.Ammo = "357" -- what ammo type the gun uses

SWEP.ShootVolume = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0

SWEP.ShootSound = "KANADE_ARC9_SIGNALIS_EINHORN_Fire"

--SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.MuzzleParticle = "muzzleflash_minimi"

SWEP.ShotDynamicLightBrightness = 4
SWEP.ShotDynamicLightSize = 360

-- SWEP.ShellModel = "models/shells/shell_9mm.mdl"
-- SWEP.ShellPitch = 90
-- SWEP.ShellScale = 2
SWEP.NoShellEject = true

SWEP.MuzzleEffectQCA = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectQCA = 2 -- which attachment to put the case effect on
SWEP.ProceduralViewQCA = 1
SWEP.CamQCA = 0

SWEP.BulletBones = {
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSights = {
    Pos = Vector(-2.681, -4, 1.2),
    Ang = Angle(0, 0.9, 0),
    Magnification = 1.1,
    AssociatedSlot = 1,
    ViewModelFOV = 60,
    CrosshairInSights = false,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.SightMidPoint = {
    Pos = Vector(-0.875, 0, -0.25),
    Ang = Angle(0, -0.225, -2.5),
}

SWEP.HoldType = "revolver"
SWEP.HoldTypeSprint = "revolver"
SWEP.HoldTypeHolstered = "revolver"
SWEP.HoldTypeSights = "revolver"
SWEP.HoldTypeCustomize = "slam"
SWEP.HoldTypeBlindfire = "pistol"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
SWEP.NonTPIKAnimReload = ACT_HL2MP_GESTURE_RELOAD_PISTOL

SWEP.ActivePos = Vector(0, -4, -1)
SWEP.ActiveAng = Angle(0, 0, -5)

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

SWEP.CustomizePos = Vector(17.5, 35, 4.5)
SWEP.CustomizeAng = Angle(90, 0, 0)
SWEP.CustomizeSnapshotPos = Vector(2.5,0,0)
SWEP.CustomizeSnapshotAng = Angle(0, 0, 0)
SWEP.CustomizeSnapshotFOV = 70

SWEP.BarrelLength = 0 -- = 10

SWEP.ExtraSightDist = 20




SWEP.Hook_TranslateAnimation = function (self, anim)
    -- local attached = self:GetElements()
end

SWEP.Attachments = {
    {
        PrintName = "Perk",
        DefaultCompactName = "PERK",
        Bone = "j_gun",
        Pos = Vector(-5, 0, -5),
        Ang = Angle(0, 0, 0),
        Category = "mwc_perk",
    },
    {
        PrintName = "Proficiency",
        DefaultCompactName = "PRO",
        Bone = "j_gun",
        Pos = Vector(-8, 0, -5),
        Ang = Angle(0, 0, 0),
        Category = "mwc_proficiency",
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1 / 30,
    },
    ["draw"] = {
        Source = "deploy",
        Time = 15 / 30,
    },
    ["holster"] = {
        Source = "holster",
        Time = 15 / 30,
    },
    ["ready"] = {
        Source = "draw",
        Time = 30 / 30,
    },
    ["fire"] = {
        Source = {"fire"},
        Time = 0.6,
    },
    ["fire_iron"] = {
        Source = "fire",
        Time = 0.4,
    },
    ["reload"] = {
        Source = "reload_short",
        Time = 3,
        EventTable = {
            {s = "ARC9_SIGNALIS_508_CylOpen", t = 0.2},
			{s = "ARC9_SIGNALIS_508_Chamber", t = 0.7},
            {s = "ARC9_SIGNALIS_508_Loader", t = 1.5},
            {s = "ARC9_SIGNALIS_508_CylClose", t = 2.3},
        },
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 1,
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
        Source = "melee",
        Time = 16 / 30,
    },
}