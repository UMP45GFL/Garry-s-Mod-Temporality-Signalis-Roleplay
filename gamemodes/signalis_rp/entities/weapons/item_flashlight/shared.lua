
SWEP.Base = "tfa_nmrimelee_base_sp"
SWEP.Category = "TFA NMRIH"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Maglite"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_item_maglite.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_item_maglite.mdl" --Viewmodel path
SWEP.HoldType = "knife"
SWEP.DefaultHoldType = "knife"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
    Pos = {
        Up = -0.5,
        Right = 2,
        Forward = 5.5,
    },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 178
    },
    Scale = 1.2
}

SWEP.On_Sound = "kanade_items/flashlight_on.wav"
SWEP.Off_Sound = "kanade_items/flashlight_off.wav"
SWEP.TakeIn_Sound = "kanade_items/flashlight_takeIn.wav"
SWEP.TakeOut_Sound = "kanade_items/flashlight_takeOut.wav"
SWEP.ShoulderMove_Sound = "kanade_items/flashlight_Shoulder_move_1.ogg"
SWEP.ShoulderAttach_Sound = "kanade_items/flashlight_Shoulder_attach.ogg"

SWEP.Primary.Sound = Sound("Weapon_Melee.CrowbarLight")
SWEP.Secondary.Sound = Sound("Weapon_Melee.CrowbarHeavy")

SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(-3.418, -6.433, 8.241)
SWEP.InspectAng = Vector(-9.146, 9.145, 17.709)

SWEP.Slot			= 7
SWEP.SlotPos		= 0

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 10
SWEP.Primary.Reach = 40
SWEP.Primary.RPM = 90
SWEP.Primary.SoundDelay = 0
SWEP.Primary.Delay = 0.3
SWEP.Primary.Window = 0.2
SWEP.Primary.Automatic = false

SWEP.Secondary.Blunt = true
SWEP.Secondary.RPM = 60 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 5
SWEP.Secondary.Reach = 40	
SWEP.Secondary.SoundDelay = 0.0
SWEP.Secondary.Delay = 0.2
SWEP.Secondary.Automatic = false

SWEP.Secondary.BashDamage = 5
SWEP.Secondary.BashDelay = 0.35
SWEP.Secondary.BashLength = 40

SWEP.MoveSpeed = 1
SWEP.AllowViewAttachment = false

SWEP.Active = false

function SWEP:PrimaryAttack()
	self:AltAttack()
end

function SWEP:PrimarySlash()
end

function SWEP:rremove()
    if IsValid(self.projectedLight) then
        SafeRemoveEntity(self.projectedLight)
    end

    if IsValid(self.Owner) then
	    self.Owner:SetNWEntity("FL_Flashlight", nil)
    end
	self.Active = false
    if CLIENT then
        removeSideFlashlight()
    end
end

SWEP.NextCanDrop = 0

function SWEP:Deploy()
    self.NextCanDrop = CurTime() + 0.55

    if CLIENT then
        removeSideFlashlight()
    end
end

function SWEP:OnRemove()
	self:rremove()
end

function SWEP:IsBatteryGood()
    return (self.BatteryLevel >= 4)
end

--function SWEP:BurstDoor() end
function SWEP:HandleDoor() end
