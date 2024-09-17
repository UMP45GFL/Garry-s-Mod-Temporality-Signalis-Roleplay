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
SWEP.UsedUp = false

SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.StunningEnabled = false
SWEP.Primary.Directional = true
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 40, -- Trace distance
		["dir"] = Vector(15, 0, 5), -- Trace arc cast
		["dmg"] = 20, --Damage
		["dmgtype"] = DMG_CLUB, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.2, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = Sound("Weapon_Crowbar.Single"), -- Sound ID
		["snd_delay"] = 0.1,
		["viewpunch"] = Angle(5, 5, 0), --viewpunch angle
		["end"] = 1.2, --time before next attack
		["hull"] = 15, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["hitworld"] = Sound("Weapon_Crowbar.Melee_Hit"),
		["combotime"] = 0
	},
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 40, -- Trace distance
		["dir"] = Vector(15, 0, 5), -- Trace arc cast
		["dmg"] = 35, --Damage
		["dmgtype"] = DMG_SHOCK, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.2, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = Sound("weapons/stunstick/stunstick_swing1.wav"), -- Sound ID
		["snd_delay"] = 0.1,
		["viewpunch"] = Angle(5, 5, 0), --viewpunch angle
		["end"] = 1.2, --time before next attack
		["hull"] = 15, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = Sound("weapons/stunstick/stunstick_fleshhit2.wav"),
		["hitworld"] = Sound("weapons/stunstick/stunstick_impact1.wav"),
		["combotime"] = 0
	}
}

function SWEP:GetMelAttackID()
	if self.StunningEnabled and !self.UsedUp then
		return 2
	else
		return 1
	end
end

function SWEP:StrikeThink()
	if self:GetSprinting() and not self:GetStatL("AllowSprintAttack", false) then
		self:SetComboCount(0)
		--return
	end

	if self:IsSafety() then
		self:SetComboCount(0)
		return
	end

	if not IsFirstTimePredicted() then return end
	if self:GetStatus() ~= TFA.Enum.STATUS_SHOOTING then return end
	if self.up_hat then return end

	local ind = 1

	if self.StunningEnabled and !self.UsedUp then
		ind = 2
	end

	local attack = self.Primary.Attacks[ind]

	if self.AttackSoundTime ~= -1 and CurTime() > self.AttackSoundTime then
		self:EmitSound(attack.snd)

		if self:GetOwner().Vox then
			self:GetOwner():Vox("bash", 4)
		end

		self.AttackSoundTime = -1
	end

	if self:GetOwner().Vox and self.VoxSoundTime ~= -1 and CurTime() > self.VoxSoundTime - self:GetOwner():Ping() * 0.001 then
		if self:GetOwner().Vox then
			self:GetOwner():Vox("bash", 4)
		end

		self.VoxSoundTime = -1
	end

	if CurTime() > self:GetStatusEnd() then
		self.DamageType = attack.dmgtype
		--Just attacked, so don't do it again
		self.up_hat = true
		self:SetStatus(TFA.Enum.STATUS_IDLE, math.huge)

		self:Strike(attack, self.Precision)
	end
end

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

		if SERVER and self.StunningEnabled then
			sound.Play("weapons/stunstick/spark"..math.random(1,3)..".wav", self.Owner:GetPos(), 75, 100, 1)
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
	if trace.Hit and bFirstTimePredicted and (not trSplash) and self.StunningEnabled and !self.UsedUp then
		local data = EffectData()
		data:SetOrigin(trace.HitPos)
		data:SetStart(vSrc)
		data:SetSurfaceProp(trace.SurfaceProps)
		data:SetDamageType(dt)
		data:SetHitBox(trace.HitBox)
		data:SetEntity(trace.Entity)
		util.Effect("StunstickImpact", data)
	end

	if self.StunningEnabled and !self.UsedUp and trace.Hit and IsValid(trace.Entity) and trace.Entity:IsPlayer() and trace.Entity:Team() != TEAM_SPECTATOR and trace.Entity:Team() != FACTION_STAFF then
		if SERVER and trace.Entity.SetRagdolled and not IsValid(trace.Entity.ixRagdoll) then
			trace.Entity:SetRagdolled(true, 30)
			trace.Entity:EmitSound("eternalis/weapons/stun_prod/taser_shot_multiple.wav", 110, 100, 1)

			if self.Owner.GetCharacter then
				local char = self.Owner:GetCharacter()
				if char then
					local inventory = char:GetInventory()
					if inventory then
						local items = inventory:GetItems()
						if items then
							for _, v in pairs(items) do
								if (v.isWeapon and v:GetData("equip") and v.class == self:GetClass()) then
									v:SetData("usedup", true)
								end
							end
						end
					end
				end
			end
		end

		self.UsedUp = true
	end
	
	dmg:SetDamage(dam)
	dmg:SetDamageForce(force)
end

function SWEP:DrawHUD()
	local text = "Reload to enable stunning"

	if self.UsedUp then
		text = "Stun prod used up"

	elseif self.StunningEnabled then
		text = "Stunning enabled"
	end

	draw.Text({
		text = text,
		pos = {ScrW() / 2, ScrH() - 6},
		font = "HudDefault",
		color = Color(255,255,255,50),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_BOTTOM,
	})
end
