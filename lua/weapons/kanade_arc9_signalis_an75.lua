SWEP.Base = "arc9_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Kanade's ARC9 Signalis" -- edit this if you like
SWEP.SubCategory = "Handguns"
SWEP.AdminOnly = false

SWEP.PrintName = "Type-75 'Protektor'"
SWEP.Class = "Pistol"
SWEP.Description = [[A semi-automatic pistol. Fires 10mm ammunition from a 10-round magazine. Easy to use, high rate of fire.]]
SWEP.Trivia = {
    Manufacturer = "NA",
    Calibre = "10mm",
    Mechanism = "Short Recoil",
    Country = "NA",
    Games = [[Signalis]]
}
SWEP.Credits = {
    Author = "DuckFlit"
}

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/signalis/c_signalis_cz75.mdl"
SWEP.WorldModel = "models/weapons/signalis/w_signalis_cz75.mdl"
SWEP.WorldModelMirror = "models/weapons/signalis/c_signalis_cz75.mdl"
SWEP.MirrorVMWM = true
SWEP.NoTPIKVMPos = false
SWEP.WorldModelOffset = {
    Pos        =    Vector(-20, 7, -4),
    Ang        =    Angle(0, -2, 180),
    Bone    =    "ValveBiped.Bip01_R_Hand",
    Scale = 1,
}
SWEP.ViewModelFOVBase = 55

SWEP.DefaultBodygroups = "00000000000000"

SWEP.DefaultSkin = 6

SWEP.DamageMax = 40
SWEP.DamageMin = 30 -- damage done at maximum range
SWEP.RangeMax = 4000
SWEP.RangeMin = 1000
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.EntityMuzzleVelocity = 10000

SWEP.ShotDynamicLightBrightness = 4
SWEP.ShotDynamicLightSize = 384

SWEP.PhysBulletMuzzleVelocity = 600 * 39.37

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

SWEP.ChamberSize = 1 -- dont fucking change this again.
SWEP.ClipSize = 10 -- DefaultClip is automatically set.
SWEP.SupplyLimit = 6
SWEP.SecondarySupplyLimit = 6
SWEP.ReloadTime = 1

SWEP.Crosshair = true
SWEP.CanBlindFire = false

SWEP.Recoil = 0.6
SWEP.RecoilSide = 0.4
SWEP.RecoilUp = 6

SWEP.RecoilRandomUp = 1
SWEP.RecoilRandomSide = 0.2

SWEP.RecoilDissipationRate = 40 -- How much recoil dissipates per second.
SWEP.RecoilResetTime = 0.01 -- How long the gun must go before the recoil pattern starts to reset.

SWEP.RecoilAutoControl = 0.5
SWEP.RecoilKick = 0.4

SWEP.Spread = math.rad(3.65 / 37.5)
SWEP.SpreadMultShooting = 1.25

SWEP.SpreadMultSights = 0.1
SWEP.SpreadAddHipFire = math.rad(150 / 37.5)
SWEP.SpreadAddMove = math.rad(0 / 37.5)
SWEP.SpreadAddMidAir = 0
-- SWEP.SpreadAddShooting = math.rad(5 / 37.5) -- 0 -- = math.rad(95 / 37.5)

SWEP.RecoilPatternDrift = 20

SWEP.UseVisualRecoil = true
SWEP.VisualRecoilCenter = Vector(0, 0, 0)
SWEP.VisualRecoilUp = 3
SWEP.VisualRecoilSide = 0.2
SWEP.VisualRecoilRoll = 1
SWEP.VisualRecoilPunch = 4
SWEP.VisualRecoilMultSights = 0.5

SWEP.Speed = 1

SWEP.ShootWhileSprint = true
SWEP.ReloadInSights = false

-------------------------- MELEE

SWEP.Bash = true
SWEP.PrimaryBash = false
SWEP.PreBashTime = 0.2
SWEP.PostBashTime = 0.7


SWEP.SpeedMultSights = 0.8
SWEP.SpeedMultShooting = 0.75
SWEP.SpeedMultMelee = 1
SWEP.SpeedMultCrouch = 1
SWEP.SpeedMultBlindFire = 1

SWEP.AimDownSightsTime = 0.2
SWEP.SprintToFireTime = 0.2

SWEP.RPM = 650
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

SWEP.Ammo = "pistol" -- what ammo type the gun uses

SWEP.ShootVolume = 100
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0

SWEP.ShootSound = "KANADE_ARC9_SIGNALIS_CZ75_Fire"
SWEP.ShootSoundSilenced = "ARC9_SIGNALIS_AN_SILFIRE"

--SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.MuzzleParticle = "muzzleflash_pistol" -- Used for some muzzle effects.

SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1.25
SWEP.ShellMaterial = "models/weapons/arcticcw/shell_556_steel"

SWEP.MuzzleEffectQCA = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectQCA = 2 -- which attachment to put the case effect on
SWEP.ProceduralViewQCA = 0
SWEP.CamQCA = 0

SWEP.BulletBones = {
    [1] = {"j_bullet1","tag_bullet_animate"},
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSights = {
    Pos = Vector(-3.55, -3, 0.55),
    Ang = Angle(-0.1, 0.45, 0),
    Magnification = 1.15,
    --AssociatedSlot = 9,
    ViewModelFOV = 45,
    CrosshairInSights = false,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.SightMidPoint = { -- Where the gun should be at the middle of it's irons
    Pos = Vector(-2, 1, 0.35),
    Ang = Angle(-0.05, -1.075, -2.5),
}

SWEP.HoldType = "revolver"
SWEP.HoldTypeSprint = "revolver"
SWEP.HoldTypeHolstered = "revolver"
SWEP.HoldTypeSights = "rpg"
SWEP.HoldTypeCustomize = "slam"
SWEP.HoldTypeBlindfire = "pistol"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
SWEP.NonTPIKAnimReload = ACT_HL2MP_GESTURE_RELOAD_PISTOL

SWEP.ActivePos = Vector(0, 0, -1)
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

SWEP.SprintVerticalOffset = true
SWEP.SprintPos = SWEP.ActivePos
SWEP.SprintAng = SWEP.ActiveAng

SWEP.BlindFirePos = Vector(-3, -1, 2)
SWEP.BlindFireAng = Angle(0, 0, -50)

SWEP.CustomizePos = Vector(15, 25, 2)
SWEP.CustomizeAng = Angle(90, 0, -1.5)
SWEP.CustomizeSnapshotPos = Vector(0, -5, 2)
SWEP.CustomizeSnapshotAng = Angle(0,0,0)

SWEP.BarrelLength = 0 -- = 9

SWEP.ExtraSightDist = 15



SWEP.Hook_ModifyBodygroups = function(self, data)

    local vm = data.model
    local attached = data.elements
    local color = 6
    if attached["stars"] then
        color = 8
    end
    if attached["elite"] then
        color = 10
    end

    if attached["bo1_pap"] then
        vm:SetSkin(color + 1)
    end

end

--TEST 3

SWEP.Attachments = {
    {
        PrintName = "Muzzle",
        DefaultCompactName = "MUZZ",
        Bone = "tag_silencer",
        Pos = Vector(0, 0, -0.05),
        Ang = Angle(0, 0, 0),
        Category = "muzzle_pistols", "cod_muzzle_pistol",
    },
    {
        PrintName = "Ammunition",
        DefaultCompactName = "AMMO",
        Bone = "tag_clip",
        Pos = Vector(-1.25, 0, -2.5),
        Ang = Angle(0, 0, 0),
        Category = {"bo1_ammo"},
    },
    {
        PrintName = "Perk",
        DefaultCompactName = "PERK",
        Bone = "tag_clip",
        Pos = Vector(-5, 0, -5),
        Ang = Angle(0, 0, 0),
        Category = "mwc_perk",
    },
    {
        PrintName = "Proficiency",
        DefaultCompactName = "PRO",
        Bone = "tag_clip",
        Pos = Vector(-8, 0, -5),
        Ang = Angle(0, 0, 0),
        Category = "mwc_proficiency",
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["enter_sights"] = {
        Source = "idle",
        IKTimeLine = { {t = 0,	lhik = 1, rhik = 1} },
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.4,
    },
    ["holster"] = {
        Source = "holdster",
        IKTimeLine = {{t = 0, lhik = 1, rhik = 1}},
        Time = 0.7,
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        IKTimeLine = {{t = 0, lhik = 1, rhik = 1}},
        Time = 0.6,
    },
    ["ready"] = {
        Source = "first_draw",
        Time = 1.2,
        EventTable = {
            {s = "ARC9_SIGNALIS_AN_cockpull", t = 0.5},
            {s = "ARC9_SIGNALIS_AN_SlideForward", t = 0.7},
        },
    },
    ["fire"] = {
        Source = {"Shoot"},
        Time = 5 / 10,
        ShellEjectAt = 1 / 30,
		
    },
    ["fire_empty"] = {
        Source = "fire_last",
        Time = 5 / 30,
        ShellEjectAt = 1 / 30,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 5 / 30,
        ShellEjectAt = 1 / 30,
    },
    ["fire_iron_empty"] = {
        Source = "fire_last",
        Time = 5 / 30,
        ShellEjectAt = 1 / 30,
    },
    ["reload"] = {
        Source = "reload",
        Time = 2,
        EventTable = {
            {s = "ARC9_SIGNALIS_AN_MagOut", t = 0.25},
            {s = "ARC9_SIGNALIS_AN_MagIn", t = 0.70}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 2.5,
        EventTable = {
            {s = "ARC9_SIGNALIS_AN_MagOut", t = 0.25},
            {s = "ARC9_SIGNALIS_AN_MagIn", t = 0.70},
			{s = "ARC9_SIGNALIS_AN_cockpull", t = 1.4},
            {s = "ARC9_SIGNALIS_AN_SlideForward", t = 1.8},
        },
    },
    ["enter_sprint"] = {
        Source = "Idle_To_Sprint",
        Time = 2.5,
    },
    ["idle_sprint"] = {
        Source = "Sprint_",
        Time = 30 / 40
    },
    ["exit_sprint"] = {
        Source = "Sprint_To_Idle",
        Time = 2,
    },
    ["enter_sprint_empty"] = {
        Source = "Idle_To_Sprint",
        Time = 2,
    },
    ["idle_sprint_empty"] = {
        Source = "Sprint_",
        Time = 30 / 40
    },
    ["exit_sprint_empty"] = {
        Source = "Sprint_To_Idle",
        Time = 1,
    },
    ["bash"] = {
        Source = "bash",
        Time = 1,
    },
}