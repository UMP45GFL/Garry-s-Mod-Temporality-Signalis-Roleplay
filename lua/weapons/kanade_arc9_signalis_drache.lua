SWEP.Base = "arc9_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Kanade's ARC9 Signalis" -- edit this if you like
SWEP.SubCategory = "Submachine Guns"
SWEP.AdminOnly = false

SWEP.PrintName = "Type-84 'Drache'"
SWEP.Class = "Submachine Guns"
SWEP.Description = [[An automatic Submachine gun with a collapsible stock. Fires 3-round bursts of 8mm compact ammo from a 30-round magazine.]]
SWEP.Trivia = {
    Manufacturer = "NA",
    Calibre = "8x22mm",
    Mechanism = "Gas-Operated",
    Country = "NA",
    Games = [[Signalis]]
}
SWEP.Credits = {
    Author = "DuckFlit"
}

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/signalis/c_signalis_mp5.mdl"
SWEP.WorldModel = "models/weapons/signalis/w_signalis_mp5.mdl"
SWEP.WorldModelMirror = "models/weapons/signalis/c_signalis_mp5.mdl"
SWEP.MirrorVMWM = true
SWEP.NoTPIKVMPos = false
SWEP.WorldModelOffset = {
    Pos        =    Vector(-3.75, 4.35, 0),
    Ang        =    Angle(-8, 2, 180),
    Bone    =    "ValveBiped.Bip01_R_Hand",
    Scale = 1,
}
SWEP.ViewModelFOVBase = 80

SWEP.DefaultBodygroups = "000000000"

SWEP.CustomCamoTexture = "models/weapons/arc9/colors/blue_mac"
SWEP.CustomCamoScale = 1
SWEP.CustomBlendFactor = 1

SWEP.ShotDynamicLightBrightness = 4
SWEP.ShotDynamicLightSize = 256

SWEP.DamageMax = 23
SWEP.DamageMin = 15 -- damage done at maximum range
SWEP.RangeMax = 8000
SWEP.RangeMin = 2000
SWEP.Penetration = 8
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.EntityMuzzleVelocity = 10000

SWEP.PhysBulletMuzzleVelocity = 1000 * 39.37

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
SWEP.ClipSize = 30 -- DefaultClip is automatically set.
SWEP.SupplyLimit = 9
SWEP.SecondarySupplyLimit = 9
SWEP.ReloadTime = 1

SWEP.Crosshair = true
SWEP.CanBlindFire = false

SWEP.Recoil = 0.65
SWEP.RecoilSide = 0.45
SWEP.RecoilUp = 2

SWEP.RecoilRandomUp = 0.5
SWEP.RecoilRandomSide = 0.4

SWEP.RecoilDissipationRate = 40 -- How much recoil dissipates per second.
SWEP.RecoilResetTime = 0.01 -- How long the gun must go before the recoil pattern starts to reset.

SWEP.RecoilAutoControl = 0.5
SWEP.RecoilKick = 1

SWEP.Spread = math.rad(1.15 / 37.5)
SWEP.SpreadMultShooting = 1.25

SWEP.SpreadMultSights = 0.1
SWEP.SpreadAddHipFire = math.rad(150 / 37.5)
SWEP.SpreadAddMove = math.rad(0 / 37.5)
SWEP.SpreadAddMidAir = 0
-- SWEP.SpreadAddShooting = math.rad(5 / 37.5) -- 0 -- = math.rad(108 / 37.5)

SWEP.RecoilPatternDrift = 20

SWEP.UseVisualRecoil = true
SWEP.VisualRecoilCenter = Vector(0, 0, 0)
SWEP.VisualRecoilUp = 0.3
SWEP.VisualRecoilSide = 0.15
SWEP.VisualRecoilRoll = 1
SWEP.VisualRecoilPunch = 2.5
SWEP.VisualRecoilSights = 0.5

SWEP.Speed = 0.95

SWEP.ShootWhileSprint = true
SWEP.ReloadInSights = false

-------------------------- MELEE

SWEP.Bash = true
SWEP.PrimaryBash = false
SWEP.PreBashTime = 0.2
SWEP.PostBashTime = 0.9

SWEP.SpeedMultSights = 0.8
SWEP.SpeedMultShooting = 0.75
SWEP.SpeedMultMelee = 1
SWEP.SpeedMultCrouch = 1
SWEP.SpeedMultBlindFire = 1

SWEP.AimDownSightsTime = 0.2
SWEP.SprintToFireTime = 0.2

SWEP.Sway = 0
SWEP.SwayAddSights = 0
SWEP.HoldBreathTime = 5
SWEP.RestoreBreathTime = 10

SWEP.FreeAimRadius = 0
SWEP.FreeAimRadiusMultSights = 0

SWEP.RPM = 850
SWEP.AmmoPerShot = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 3,
    },
}
SWEP.RunawayBurst = true
SWEP.PostBurstDelay = 0.2
SWEP.ARC9WeaponCategory = 3
SWEP.NPCWeight = 100

SWEP.Ammo = "smg1" -- what ammo type the gun uses

SWEP.ShootVolume = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0

SWEP.ShootSound = "KANADE_ARC9_SIGNALIS_SMG2_Fire"
SWEP.ShootSoundSilenced = "ARC9_SIGNALIS_84_SILFIRE"

SWEP.UBGLIntegralReload = true -- The UBGL uses reload animations that are baked into the gun.
SWEP.DoFireAnimationUBGL = true
SWEP.NoShellEjectUBGL = true
SWEP.MuzzleEffectQCAUBGL = 1

--SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.MuzzleParticle = "muzzleflash_1" -- Used for some muzzle effects.

SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 90
SWEP.ShellScale = 0.9

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
    Pos = Vector(-3.401, 0.2, 0.45),
    Ang = Angle(0, 0.6, 0),
    Magnification = 1.1,
    ViewModelFOV = 50,
    CrosshairInSights = false,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.SightMidPoint = {
    Pos = Vector(-1.4125, 0, -0.425),
    Ang = Angle(0, 0, -2.5),
}

SWEP.HoldType = "rpg"
SWEP.HoldTypeSprint = "rpg"
SWEP.HoldTypeHolstered = "rpg"
SWEP.HoldTypeSights = "rpg"
SWEP.HoldTypeCustomize = "slam"
SWEP.HoldTypeBlindfire = "pistol"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.NonTPIKAnimReload = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.ActivePos = Vector(0, 0, -1)
SWEP.ActiveAng = Angle(0, 0, -5)

SWEP.PeekPos = Vector(-1.5, 3, -4.5)
SWEP.PeekAng = Angle(0, 0.4, -35)

SWEP.MovingPos = SWEP.ActivePos
SWEP.MovingAng = SWEP.ActiveAng

SWEP.MovingMidPoint = {
    Pos = SWEP.ActivePos,
    Ang = SWEP.ActiveAng
}

SWEP.CrouchPos = Vector(-2, -4.35, -1)
SWEP.CrouchAng = Angle(0, 0, -5)

SWEP.SprintVerticalOffset = false
SWEP.SprintPos = Vector(0, 0, -1)
SWEP.SprintAng = Angle(0, 0, -5)

SWEP.CustomizePos = Vector(12.5, 40, 4)
SWEP.CustomizeAng = Angle(90, 0, 0)

SWEP.RestPos = Vector(0, 0, -1)
SWEP.RestAng = Angle(0, 0, -5)

SWEP.BarrelLength = 0 -- = 25

SWEP.ExtraSightDist = 5

SWEP.AttachmentElements = {
    ["stock_retract"] = {
        Bodygroups = {
            {1,1},
        },
    },
}

SWEP.Hook_ModifyBodygroups = function(wep, data)
    local model = data.model
    if wep:HasElement("hg_k") then model:SetBodygroup(2,1) end 
	if wep:HasElement("hg_k") then model:SetBodygroup(2,2) end
end


SWEP.Attachments = {
    {
        PrintName = "Muzzle",
        Bone = "tag_barrel",
        Pos = Vector(2.4, 0, -0.5),
        Ang = Angle(0, 0, 0),
        Category = {"muzzle", "cod_muzzle"},
    },
    {
        PrintName = "Rail optic",
        DefaultName = "Top Rail",
        Bone = "tag_acog",
        Pos = Vector(-1.5, 0, 0.4),
        Ang = Angle(0, 0, 0),
        Category = {"csgo_rail_optic", "cod_rail_optic", "rail"}
    },
	{
        PrintName = "Stock",
        DefaultAttName = "Fold Stock",
        Category = {"stock_retract", "stock_none"},
        Bone = "tag_weapon",
		--InstalledElements = {"stock_none"},
        Pos = Vector(-12, 0, 1),
        Ang = Angle(90, 0, -90),
		Scale = 1.2,
    }
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle_grip",
        Time = 1,
    },
    ["draw"] = {
        Source = "draw_grip",
        Time = 0.8,
    },
    ["holster"] = {
        Source = "holster_grip",
        Time = 0.5,
    },
    ["holster_empty"] = {
        Source = "holster_grip",
        Time = 0.5,
    },
    ["ready"] = {
        Source = "draw_first_grip",
        Time = 1,
        EventTable = {
            {s = "ARC9_SIGNALIS_AN_Slideback", t = 0.5},
            {s = "ARC9_SIGNALIS_AN_SlideForward", t = 0.7},
        },
    },
    ["fire"] = {
        Source = {"fire_grip"},
        Time = 5 / 10,
        ShellEjectAt = 1 / 30,
    },
    ["fire_empty"] = {
        Source = "fire_grip",
        Time = 5 / 30,
        ShellEjectAt = 1 / 30,
    },
    ["fire_iron"] = {
        Source = "fire_ads_grip",
        Time = 5 / 30,
        ShellEjectAt = 1 / 30,
    },
    ["fire_sights"] = {
        Source = "fire_ads_grip",
        Time = 5 / 30,
        ShellEjectAt = 1 / 30,
    },
    ["enter_sights"] = {
        Source = "idle_grip",
        Time = 5 / 30,
    },
    ["fire_iron_empty"] = {
        Source = "fire_ads_grip",
        Source = "fire_ads_grip",
        Time = 5 / 30,
        ShellEjectAt = 1 / 30,
    },
    ["reload"] = {
        Source = "reload_grip_fast",
        Time = 2.15,
        EventTable = {
            {s = "ARC9_SIGNALIS_84_Boltback", t = 0.27},
            {s = "ARC9_SIGNALIS_84_MagOut", t = 0.43},
            {s = "ARC9_SIGNALIS_84_MagIn", t = 1.23}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty_grip_fast",
        Time = 2.5,
        EventTable = {
            {s = "ARC9_SIGNALIS_84_Boltback", t = 0.3125},
            {s = "ARC9_SIGNALIS_84_MagOut", t = 0.5},
            {s = "ARC9_SIGNALIS_84_MagIn", t = 1.22},
            {s = "ARC9_SIGNALIS_84_BoltForward", t = 1.72},
        },
    },
    ["enter_sprint"] = {
        Source = "sprint_in_grip",
        Time = 2.5,
    },
    ["idle_sprint"] = {
        Source = "sprint_loop_grip",
        Time = 0.71
    },
    ["exit_sprint"] = {
        Source = "sprint_out_grip",
        Time = 1.7,
    },
    ["enter_sprint_empty"] = {
        Source = "sprint_in_grip",
        Time = 1,
    },
    ["idle_sprint_empty"] = {
        Source = "sprint_loop_grip",
        Time = 0.78
    },
    ["exit_sprint_empty"] = {
        Source = "sprint_out_grip",
        Time = 1.55,
    },
    ["bash"] = {
        Source = "bash_grip",
        Time = 1,
    },
}