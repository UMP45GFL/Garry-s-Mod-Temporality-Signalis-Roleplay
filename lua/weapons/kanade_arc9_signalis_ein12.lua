SWEP.Base = "arc9_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Kanade's ARC9 Signalis" -- edit this if you like
SWEP.SubCategory = "Shotguns"
SWEP.AdminOnly = false

SWEP.PrintName = "EIN-12 Flechette"
SWEP.Class = "Combat Shotgun"
SWEP.Description = [[EIN-12 Flechette. Can hit multiple targets at once. Low damage, but high chance to stagger enemies at close range.]]
SWEP.Trivia = {
    Manufacturer = "NA",
    Calibre = "18.5 Flechette",
    Mechanism = "Gas-Operated",
    Country = "NA",
    Games = [[Signalis]]
}
SWEP.Credits = {
    Author = "DuckFlit"
}

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/signalis/c_signalis_spas.mdl"
SWEP.WorldModel = "models/weapons/signalis/w_signalis_spas.mdl"
SWEP.WorldModelMirror = "models/weapons/signalis/c_signalis_spas.mdl"
SWEP.MirrorVMWM = true
SWEP.NoTPIKVMPos = true
SWEP.WorldModelOffset = {
    Pos        =    Vector(-5.5, 4.4, -6.4),
    Ang        =    Angle(-5, -1, 180),
    Bone    =    "ValveBiped.Bip01_R_Hand",
    Scale   =   1,
}
SWEP.ViewModelFOVBase = 75

SWEP.CustomCamoTexture = "models/weapons/arc9/bo1/camos/black_detail"
SWEP.CustomCamoScale = 2
SWEP.CustomBlendFactor = 1

SWEP.DefaultBodygroups = "111111"

SWEP.DamageMax = 43
SWEP.DamageMin = 25 -- damage done at maximum range
SWEP.RangeMax = 3000
SWEP.RangeMin = 750
SWEP.Penetration = 2
SWEP.DamageType = DMG_SLASH
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

SWEP.Crosshair = true
SWEP.CanBlindFire = false

SWEP.TracerNum = 1 -- Tracer every X
SWEP.TracerFinalMag = 0 -- The last X bullets in a magazine are all tracers
SWEP.TracerEffect = "ARC9_tracer" -- The effect to use for hitscan tracers
SWEP.TracerColor = Color(255, 255, 255) -- Color of tracers. Only works if tracer effect supports it. For physical bullets, this is compressed down to 9-bit color.

SWEP.ChamberSize = 0 -- dont fucking change this again.
SWEP.ClipSize = 8 -- DefaultClip is automatically set.
SWEP.SupplyLimit = 9
SWEP.SecondarySupplyLimit = 9
SWEP.ShotgunReload = true
SWEP.ReloadTime = 1

SWEP.Recoil = 1
SWEP.RecoilSide = 0.75
SWEP.RecoilUp = 4

SWEP.RecoilRandomUp = 0.76
SWEP.RecoilRandomSide = 0.5

SWEP.RecoilDissipationRate = 40 -- How much recoil dissipates per second.
SWEP.RecoilResetTime = 0.01 -- How long the gun must go before the recoil pattern starts to reset.

SWEP.RecoilAutoControl = 0.5
SWEP.RecoilKick = 2

SWEP.Spread = math.rad(20 / 37.5)
SWEP.SpreadMultShooting = 1.25

SWEP.SpreadMultSights = 2
SWEP.SpreadAddHipFire = math.rad(150 / 37.5)
SWEP.SpreadAddMove = math.rad(0 / 37.5)
SWEP.SpreadAddMidAir = 0
-- SWEP.SpreadAddShooting = math.rad(5 / 37.5) -- 0.05

SWEP.UsePelletSpread = true -- Multiple bullets fired at once clump up, like for a shotgun. Spread affects which direction they get fired, not their spread relative to one another.
SWEP.PelletSpread = math.rad(20 / 37.5)

SWEP.RecoilPatternDrift = 20

SWEP.UseVisualRecoil = true
SWEP.VisualRecoilCenter = Vector(0, 0, 0)
SWEP.VisualRecoilUp = 0.5
SWEP.VisualRecoilSide = 0.2
SWEP.VisualRecoilRoll = 1
SWEP.VisualRecoilPunch = 10
SWEP.VisualRecoilSights = 0.5

SWEP.Speed = 0.95

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

SWEP.AimDownSightsTime = 0.3
SWEP.SprintToFireTime = 0.3

SWEP.RPM = 412
SWEP.Num = 8
SWEP.AmmoPerShot = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
        ManualAction = true,
        PrintName = "PUMP",
        EjectDelay = 0.2,
        SpreadMult = 0.8,
        PhysBulletMuzzleVelocityMult = 1.15
    },
}

SWEP.ManualActionChamber = 1 -- How many shots we go between needing to cycle again.
-- SWEP.ManualAction = true -- Pump/bolt action. Play the "cycle" animation after firing, when the trigger is released.
-- SWEP.ManualActionNoLastCycle = false -- Do not cycle on the last shot.
-- SWEP.SlamFire = true
SWEP.CycleTime = 1

SWEP.ARC9WeaponCategory = 2
SWEP.NPCWeight = 100

SWEP.FreeAimRadius = 0 -- In degrees, how much this gun can free aim in hip fire.
SWEP.Sway = 0 -- How much the gun sways.

SWEP.FreeAimRadiusMultSights = 0

SWEP.SwayMultSights = 0

SWEP.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVolume = 125
SWEP.ShootPitch = 100
SWEP.ShootPitchVariation = 0

SWEP.ShootSound = "KANADE_ARC9_SIGNALIS_EIN12_Fire"
SWEP.ShootSoundSilenced = "ARC9_MW3E.Striker_Sil"

--SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.MuzzleParticle = "muzzleflash_shotgun" -- Used for some muzzle effects.

SWEP.ShotDynamicLightBrightness = 4
SWEP.ShotDynamicLightSize = 400

SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 90
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectQCA = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectQCA = 2 -- which attachment to put the case effect on
SWEP.ProceduralViewQCA = nil
SWEP.CamQCA = 3

SWEP.BulletBones = {
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSights = {
    Pos = Vector(-4.12, 0, 2.319),
    Ang = Angle(0.1, 0.0125, 0),
    ViewModelFOV = 60,
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.SightMidPoint = {
    Pos = Vector(-1.775, -4.5, 0),
    Ang = Angle(0, 0.00125, -2.5),
}

SWEP.HoldType = "rpg"
SWEP.HoldTypeSprint = "rpg"
SWEP.HoldTypeHolstered = "rpg"
SWEP.HoldTypeSights = "rpg"
SWEP.HoldTypeCustomize = "slam"
SWEP.HoldTypeBlindfire = "pistol"


SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
SWEP.NonTPIKAnimReload = ACT_HL2MP_GESTURE_RELOAD_MAGIC

SWEP.ActivePos = Vector(0, -3, -1)
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

SWEP.CustomizePos = Vector(12.5, 40, 4)
SWEP.CustomizeAng = Angle(90, 0, 0)

SWEP.BarrelLength = 0 -- = 25

SWEP.ExtraSightDist = 5

-------------------------- ATTACHMENTS

SWEP.AttachmentElements = {
    ["stock_retract"] = {
        Bodygroups = {
            {1,3},
        },
    },
    ["stock_none"] = {
        Bodygroups = {
			{2,1},
        },
    },
}


SWEP.Hook_ModifyBodygroups = function(wep, data)
    local model = data.model
    if wep:HasElement("hg_k") then model:SetBodygroup(2,1) end 
	if wep:HasElement("hg_k") then model:SetBodygroup(3,1) end
end


SWEP.Attachments = {
    {
        PrintName = "Perk",
        DefaultCompactName = "PERK",
        Bone = "tag_weapon",
        Pos = Vector(-5, 0, -5),
        Ang = Angle(0, 0, 0),
        Category = "mwc_perk",
    },
    {
        PrintName = "Proficiency",
        DefaultCompactName = "PRO",
        Bone = "tag_weapon",
        Pos = Vector(-8, 0, -5),
        Ang = Angle(0, 0, 0),
        Category = "mwc_proficiency",
    },
    {
        PrintName = "Rail optic",
        DefaultName = "Top Rail",
        Bone = "tag_weapon",
        Pos = Vector(-4, 0, 2.5),
        Ang = Angle(0, 0, 0),
        Category = {"csgo_rail_optic", "cod_rail_optic", "rail"}
    },
    {
        PrintName = ARC9:GetPhrase("csgo_category_stock"),
        DefaultAttName = "Default",
        Category = {"stock_retract", "stock_none"},
        Bone = "tag_weapon",
		--InstalledElements = {"stock_none"},
        Pos = Vector(-12, 0, 1),
        Ang = Angle(90, 0, -90),
		Scale = 1.2,
    },
}

SWEP.Hook_TranslateAnimation = function (self, anim)
    local attached = self:GetElements()

    local suffix = ""
    if attached["bo1_pap"] then
        suffix = "_pap"
    end

    return anim .. suffix
end

SWEP.HideBones = {
    "tag_clip",
}
SWEP.ReloadHideBoneTables = {
    [1] = {"tag_clip"},
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["draw"] = {
        Source = "pullout",
        Time = 1,
    },
    ["ready"] = {
        Source = "pullout_first",
        Time = 1,
        EventTable = {
            {s = "ARC9_SIGNALIS_12_Pump", t = 0.5},
        },
    },
    ["holster"] = {
        Source = "putaway",
        Time = 0.5,
    },
    ["fire"] = {
        Source = {
            "fire",
        },
        Time = 9 / 35,
    },
    ["fire_iron"] = {
        Source = {
            "ads_fire",
        },
        Time = 9 / 35,
    },
    ["cycle"] = {
        Source = {
            "pump",
        },
        Time = 1,
        ShellEjectAt = 8 / 35,
        EventTable = {
            {s = "ARC9_SIGNALIS_12_QuickPump", t = 0.2},
        },
    },
    ["cycle_iron"] = {
        Source = {
            "ads_fire",
        },
        Time = 0.7,
        ShellEjectAt = 8 / 35,
        MinProgress = 2,
        EventTable = {
            {s = "ARC9_SIGNALIS_12_QuickPump", t = 0.2},
        },
    },
    ["reload_start"] = {
        Source = "reload_in",
        Time = 1,
        RestoreAmmo = 1,
        EventTable = {
            {s = "ARC9_SIGNALIS_12_Shell", t = 20 / 30},
        },
    },
    ["reload_insert"] = {
        Source = "reload_loop",
        Time = 1,
        EventTable = {
            {s = "ARC9_SIGNALIS_12_Shell", t = 10 / 30},
        },
    },
    ["reload_start_pap"] = {
        Source = "reload_in",
        Time = 40 / 30,
        RestoreAmmo = 8,
        EventTable = {
            {s = "ARC9_SIGNALIS_12_Shell", t = 20 / 30},
        },
    },
    ["reload_insert_pap"] = {
        Source = "reload_loop",
        Time = 0.74,
        RestoreAmmo = 7,
        EventTable = {
            {s = "ARC9_SIGNALIS_12_Shell", t = 10 / 30},
        },
    },
    ["reload_finish"] = {
        Source = "reload_out",
        Time = 1,
        EventTable = {
            {s = "ARC9_SIGNALIS_12_Pump", t = 0.1},
        },
    },
    ["enter_sprint"] = {
        Source = "base_sprint_in",
        Time = 1,
    },
    ["idle_sprint"] = {
        Source = "base_sprint_loop",
        Time = 3,
    },
    ["exit_sprint"] = {
        Source = "base_sprint_out",
        Time = 1,
    },
    ["bash"] = {
        Source = "melee",
        Time = 1.1,
    },
}