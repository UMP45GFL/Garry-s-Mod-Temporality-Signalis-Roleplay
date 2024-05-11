SWEP.Base = "arc9_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Kanade's ARC9 Signalis" -- edit this if you like
SWEP.SubCategory = "Handguns"
SWEP.AdminOnly = false

SWEP.PrintName = "Flaregun"
SWEP.Class = "Special"
SWEP.Description = [[Flaregun for Replikas.]]
SWEP.Trivia = {
    Manufacturer = "",
    Calibre = "26.5x80mm",
    Mechanism = "Break-Action",
    Country = ""
}
SWEP.Credits = {
    Author = "DuckFlit"
}

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/signalis/c_signalis_flaregun.mdl"
SWEP.WorldModel = "models/weapons/signalis/w_signalis_flaregun.mdl"
SWEP.WorldModelMirror = "models/weapons/signalis/c_signalis_flaregun.mdl"
SWEP.MirrorVMWM = true
SWEP.NoTPIKVMPos = false
SWEP.WorldModelOffset = {
    Pos        =    Vector(-21, 8, 0),
    Ang        =    Angle(5, 0, 180),
    Bone    =    "ValveBiped.Bip01_R_Hand",
    Scale = 1.1,
}
SWEP.ViewModelFOVBase = 75

SWEP.DefaultBodygroups = "00000000000000"

SWEP.DamageMax = 2192
SWEP.DamageMin = 2181
SWEP.RangeMax = 1000
SWEP.RangeMin = 1000
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET + DMG_BURN + DMG_BLAST
SWEP.ShootEnt = nil -- Set to an entity to launch it out of this weapon.
SWEP.ShootEntForce = 1500
SWEP.ShootEntityData = {} -- Extra data that can be given to a projectile. Sets SENT.WeaponDataLink with this table.

SWEP.PhysBulletMuzzleVelocity = 200 * 39.37

SWEP.BodyDamageMults = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 1,
    [HITGROUP_RIGHTLEG] = 1,
}

SWEP.ChamberSize = 0 -- dont fucking change this again.
SWEP.ClipSize = 1 -- DefaultClip is automatically set.
SWEP.SupplyLimit = 9
SWEP.SecondarySupplyLimit = 9
SWEP.ReloadTime = 1

SWEP.HideBones = {
    [1] = "Flare shell"
}

SWEP.ReloadHideBonesFirstPerson = false -- Set to true to enable HideBones even in first person.

SWEP.Crosshair = true
SWEP.LauncherCrosshair = true
SWEP.CanBlindFire = false

SWEP.Recoil = 1
SWEP.RecoilSide = 0.5
SWEP.RecoilUp = 2

SWEP.RecoilRandomUp = 0.5
SWEP.RecoilRandomSide = 0.25

SWEP.RecoilDissipationRate = 40 -- How much recoil dissipates per second.
SWEP.RecoilResetTime = 0.1 -- How long the gun must go before the recoil pattern starts to reset.

SWEP.RecoilAutoControl = 0.5
SWEP.RecoilKick = 0
SWEP.PushBackForce = 1

SWEP.Spread = 0.005
SWEP.SpreadAddRecoil = 0

SWEP.SpreadMultSights = 0.1
SWEP.SpreadAddHipFire = 0.05
--SWEP.SpreadAddMove = 0
SWEP.SpreadAddMidAir = 0.1
-- SWEP.SpreadAddShooting = math.rad(5 / 37.5) -- 0 -- = 0

SWEP.RecoilPatternDrift = 20

SWEP.UseVisualRecoil = false
SWEP.VisualRecoilCenter = Vector(0, 0, 0)
SWEP.VisualRecoilUp = 1
SWEP.VisualRecoilSide = 0.25
SWEP.VisualRecoilRoll = 1
SWEP.VisualRecoilPunch = 3
SWEP.VisualRecoilMultSights = 0.5

SWEP.Speed = 1

SWEP.ShootWhileSprint = true
SWEP.ReloadInSights = false

SWEP.SpeedMultSights = 0.8
SWEP.SpeedMultShooting = 0.75
SWEP.SpeedMultMelee = 1
SWEP.SpeedMultCrouch = 1
SWEP.SpeedMultBlindFire = 1

-------------------------- TRACERS

SWEP.TracerNum = 1 -- Tracer every X
SWEP.TracerColor = Color(255, 225, 200) -- Color of tracers. Only works if tracer effect supports it. For physical bullets, this is compressed down to 9-bit color.


SWEP.AimDownSightsTime = 0.25
SWEP.SprintToFireTime = 0.25

SWEP.RPM = 150
SWEP.AmmoPerShot = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "SINGLE"
    },
}
SWEP.ARC9WeaponCategory = 2
SWEP.NPCWeight = 20

SWEP.FreeAimRadius = 0 -- In degrees, how much this gun can free aim in hip fire.
SWEP.Sway = 0 -- How much the gun sways.

SWEP.FreeAimRadiusMultSights = 0

SWEP.SwayMultSights = 0

SWEP.Ammo = "SMG1_Grenade" -- what ammo type the gun uses

SWEP.ShootVolume = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0

SWEP.ShootSound = "ARC9_SIGNALIS_FLARE_Fire"

SWEP.MuzzleParticle = "muzzleflash_m79" -- Used for some muzzle effects.

SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellScale = 1.5
SWEP.ShellMaterial = "models/weapons/arcticcw/shell_556_steel"

SWEP.MuzzleEffectQCA = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectQCA = 2 -- which attachment to put the case effect on
SWEP.ProceduralViewQCA = 1
SWEP.CamQCA = 3

SWEP.BulletBones = {
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSights = {
    Pos = Vector(-2.875, 0, -5.6),
    Ang = Angle(0, 18.25, 0),
    Magnification = 1.25,
    CrosshairInSights = true,
    ViewModelFOV = 60,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.SightMidPoint = {
    Pos = Vector(-1.4375, 0, -2.3),
    Ang = Angle(0, 9.125, -2.5),
}

SWEP.NoShellEject = true

SWEP.HoldTypeHolstered = "passive"
SWEP.HoldType = "revolver"
SWEP.HoldTypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
SWEP.NonTPIKAnimReload = ACT_HL2MP_GESTURE_RELOAD_CROSSBOW

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

SWEP.CantPeek = true
SWEP.PeekPos = Vector(-1.5, -6, -4.5)
SWEP.PeekAng = Angle(0, 0.4, -35)

SWEP.SprintVerticalOffset = false
SWEP.SprintPos = SWEP.ActivePos
SWEP.SprintAng = SWEP.ActiveAng

SWEP.CustomizePos = Vector(12.5, 40, 4)
SWEP.CustomizeAng = Angle(90, 0, 0)

SWEP.BarrelLength = 0 -- = 25

SWEP.ExtraSightDist = 5

SWEP.AttachmentElements = {
}

SWEP.HookP_NameChange = function(self, name)

    local attached = self:GetElements()

    local gunname = "Flaregun"

    if attached["bo1_pap"] then
        gunname = "Matter Dismantler"
    end

    return gunname
end



SWEP.Attachments = {
    {
        PrintName = "Ammunition",
        DefaultCompactName = "AMMO",
        Bone = "j_gun",
        Pos = Vector(3, 0, 2),
        Ang = Angle(0, 0, 0),
        Category = {"signalis_ammo_grenade", "signalis_ammo_flare"},
    },
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
    {
        PrintName = "Effects",
        DefaultCompactName = "EFF",
        Bone = "j_gun",
        Pos = Vector(-8, 0, -5),
		hidden = false,
        Ang = Angle(0, 0, 0),
        Category = {"signalis_fire"},
        Integral = true,
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1 / 35,
    },
    ["draw"] = {
        Source = "draw",
        Time = 25 / 35,
        EventTable = {
            {s = "ARC9_MW2E.M79_Draw", t = 1 / 35},
        }
    },
    ["holster"] = {
        Source = "holster",
        Time = 25 / 35,
        EventTable = {
            {s = "ARC9_MW2E.M79_Holster", t = 1 / 35},
        }
    },
    ["fire"] = {
        Source = {
            "fire",
        },
        Time = 15 / 35,
    },
    ["fire_iron"] = {
        Source = {
            "fire_ads",
        },
        Time = 15 / 35,
    },
    ["reload_empty"] = {
        Source = "reload",
        Time = 3,
        EventTable = {
            {s = "ARC9_SIGNALIS_FLARE_Open", t = 0.5},
            {s = "ARC9_SIGNALIS_FLARE_Insert", t = 1.5},
            {s = "ARC9_SIGNALIS_FLARE_Close", t = 2.1},
        },
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 1,
    },
    ["idle_sprint"] = {
        Source = "sprint_loop",
        Time = 30 / 30
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
        Time = 1,
    },
}