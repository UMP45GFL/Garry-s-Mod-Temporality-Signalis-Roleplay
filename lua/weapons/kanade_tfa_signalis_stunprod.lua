SWEP.Base 			= "tfa_melee_base"
DEFINE_BASECLASS(SWEP.Base)

SWEP.Author 		= "Kanade"
SWEP.PrintName 		= "Disposable stun prod"
SWEP.Purpose		= "Short-range high-voltage electroshock weapon. Can be used one-handed. Non-lethal weapon that instantly incapacitates the target with arcing electricity." 
SWEP.Spawnable 		= true
SWEP.AdminSpawnable = true
SWEP.Category 		= "Kanade's TFA Signalis"
SWEP.Pickupable 	= true

SWEP.ViewModel 		= "models/weapons/c_stunstick.mdl"
SWEP.WorldModel 	= "models/eternalis/items/weapons/eig2.mdl"
SWEP.ViewModelFOV 	= 50
SWEP.AnimPrefix 	= "stunstick"
SWEP.Slot			= 1
SWEP.SlotPos		= 0

SWEP.UseHands 		= true
SWEP.HoldType 		= "melee"
SWEP.IsStunBaton 	= true

SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.StunningEnabled = false
SWEP.Primary.Directional = true
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 40, -- Trace distance
		["dir"] = Vector(-75, 20, -5), -- Trace arc cast
		["dmg"] = 10, --Damage
		["dmgtype"] = DMG_SHOCK, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.28, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = Sound("Weapon_Crowbar.Single"), -- Sound ID
		["snd_delay"] = 0.22,
		["viewpunch"] = Angle(10, 20, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 10, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["hitworld"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["combotime"] = 0
	}
}

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Scale = 1
}

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.WElements = {
	["baton"] = {
		type = "Model",
		model = "models/eternalis/items/weapons/eig2.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 0.9, -6.5),
		angle = Angle(0, 160, 270),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

SWEP.VElements = {
	["baton"] = {
		type = "Model",
		model = "models/eternalis/items/weapons/eig2.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 0.9, -12.5),
		angle = Angle(0, 180, 270),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

function SWEP:SecondaryAttack()
end

SWEP.NextToggle = 0
function SWEP:Reload()
	if self.NextToggle < CurTime() then
		self.StunningEnabled = !self.StunningEnabled
		if SERVER then
			if self.StunningEnabled then
				sound.Play("weapons/stunstick/spark"..math.random(1,3)..".wav", self.Owner:GetPos(), 75, 100, 1)
				self.Primary.Hit = self.Sound_Enabled
			end
		end
		if self.StunningEnabled then
			self.Primary.Attacks[1].snd = Sound("weapons/stunstick/stunstick_swing1.wav")
			self.Primary.Attacks[1].hitflesh = Sound("weapons/stunstick/stunstick_fleshhit2.wav")
			self.Primary.Attacks[1].hitworld = Sound("weapons/stunstick/stunstick_impact1.wav")
		else
			self.Primary.Attacks[1].snd = Sound("Weapon_Crowbar.Single")
			self.Primary.Attacks[1].hitflesh = Sound("Weapon_Crowbar.Melee_Hit")
			self.Primary.Attacks[1].hitworld = Sound("Weapon_Crowbar.Melee_Hit")
		end
		self.NextToggle = CurTime() + 1
	end
end

function SWEP:SmackEffect(trace, dmg)
	local vSrc = trace.StartPos
	local bFirstTimePredicted = IsFirstTimePredicted()
	local bHitWater = bit.band(util.PointContents(vSrc), MASK_WATER) ~= 0
	local bEndNotWater = bit.band(util.PointContents(trace.HitPos), MASK_WATER) == 0

	local trSplash = bHitWater and bEndNotWater and util.TraceLine({
		start = trace.HitPos,
		endpos = vSrc,
		mask = MASK_WATER
	}) or not (bHitWater or bEndNotWater) and util.TraceLine({
		start = vSrc,
		endpos = trace.HitPos,
		mask = MASK_WATER
	})

	if (trSplash and bFirstTimePredicted) then
		local data = EffectData()
		data:SetOrigin(trSplash.HitPos)
		data:SetScale(1)

		if (bit.band(util.PointContents(trSplash.HitPos), CONTENTS_SLIME) ~= 0) then
			data:SetFlags(1) --FX_WATER_IN_SLIME
		end

		util.Effect("watersplash", data)
	end

	local dam, force, dt = dmg:GetBaseDamage(), dmg:GetDamageForce(), dmg:GetDamageType()
	
	--if (trace.Hit and bFirstTimePredicted and (not trSplash) and self:DoImpactEffect(trace, dt) ~= true) then
	if trace.Hit and bFirstTimePredicted and (not trSplash) and self.StunningEnabled then
		local data = EffectData()
		data:SetOrigin(trace.HitPos)
		data:SetStart(vSrc)
		data:SetSurfaceProp(trace.SurfaceProps)
		data:SetDamageType(dt)
		data:SetHitBox(trace.HitBox)
		data:SetEntity(trace.Entity)
		util.Effect("StunstickImpact", data)
	end

	if SERVER and self.StunningEnabled and trace.Hit and IsValid(trace.Entity) and trace.Entity:IsPlayer() and trace.Entity:Team() != TEAM_SPECTATOR and trace.Entity:Team() != FACTION_STAFF and not IsValid(trace.Entity.ixRagdoll) then
		trace.Entity:EmitSound("eternalis/weapons/stun_prod/taser_shot_multiple.wav", 110, 100, 1)
		trace.Entity:SetRagdolled(true, 15)
	end
	
	dmg:SetDamage(dam)
	dmg:SetDamageForce(force)
end

function SWEP:DrawHUD()
	if !self.StunningEnabled then
		draw.Text({
			text = "Reload to enable stunning",
			pos = { ScrW() / 2, ScrH() - 6},
			font = "HudDefault",
			color = Color(255,255,255,50),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
		})
	end
end
