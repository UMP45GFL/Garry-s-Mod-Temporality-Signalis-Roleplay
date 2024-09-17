SWEP.Base 			= "tfa_melee_base"
DEFINE_BASECLASS(SWEP.Base)

SWEP.Author 		= "Kanade"
SWEP.PrintName 		= "Small kitchen knife"
SWEP.Spawnable 		= false
SWEP.AdminSpawnable = false
SWEP.Category 		= "Kanade's TFA Signalis"
SWEP.Pickupable 	= false

SWEP.ViewModel 		= "models/weapons/c_stunstick.mdl"
SWEP.WorldModel 	= "models/eternalis/items/weapons/kitchen/small_sharp_knife.mdl"
SWEP.ViewModelFOV 	= 45

SWEP.Slot			= 1
SWEP.SlotPos		= 0

SWEP.UseHands 		= true
SWEP.HoldType 		= "melee"

SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.Primary.Directional = true
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 50, -- Trace distance
		["dir"] = Vector(15, 0, 5),
		["dmg"] = 40, --Damage
		["dmgtype"] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 0.2, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = Sound("Weapon_Crowbar.Single"), -- Sound ID
		["snd_delay"] = 0.1,
		["viewpunch"] = Angle(5, 5, 0), --viewpunch angle
		["end"] = 1.2, --time before next attack
		["hull"] = 15, --Hullsize
		["direction"] = "L", --Swing dir,
		["hitflesh"] = Sound("Weapon_Melee_Sharp.Impact_Light"),
		["hitworld"] = Sound("Weapon_Melee.Impact_Concrete"),
		["combotime"] = 0
	}
}

SWEP.Offset = {
	Pos = {
        Up = 0,
        Right = 0,
        Forward = 0,
	},
	Ang = {
        Up = 0,
        Right = 0,
        Forward = 0
	},
	Scale = 1
}

/*
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(5, -5, -2), angle = Angle(0, 0, 0) },
	["weapon"] = { scale = Vector(5, 5, 5), pos = Vector(5, -5, -2), angle = Angle(0, 0, 0) },
}
*/

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.WElements = {
	["knife"] = {
		type = "Model",
		model = "models/eternalis/items/weapons/kitchen/small_sharp_knife.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 2, -10.5),
		angle = Angle(90, 61.111, 3.332),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

SWEP.VElements = {
	["knife"] = {
		type = "Model",
		model = "models/eternalis/items/weapons/kitchen/small_sharp_knife.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 2, -10.5),
		angle = Angle(90, 61.111, 3.332),
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

function SWEP:Reload()
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
	if trace.Hit and bFirstTimePredicted and (not trSplash) then
		local data = EffectData()
		data:SetOrigin(trace.HitPos)
		data:SetStart(vSrc)
		data:SetSurfaceProp(trace.SurfaceProps)
		data:SetDamageType(dt)
		data:SetHitBox(trace.HitBox)
		data:SetEntity(trace.Entity)
		util.Effect("Impact", data)
	end
	
	dmg:SetDamage(dam)
	dmg:SetDamageForce(force)
end

/*
local att = {}
local lvec, ply, targ
lvec = Vector()
function SWEP:PrimaryAttack()
	local ow = self:GetOwner()
	if IsValid(ow) and ow:IsNPC() then
		local keys = table.GetKeys(self.Primary.Attacks)
		table.RemoveByValue(keys,"BaseClass")
		local attk = self.Primary.Attacks[table.Random(keys)]
		local owv = self:GetOwner()
		timer.Simple(0.5, function()
			if IsValid(self) and IsValid(owv) and owv:IsCurrentSchedule(SCHED_MELEE_ATTACK1) then
				attack = attk
				self:Strike(attk,5)
			end
		end)
		self:SetNextPrimaryFire(CurTime() + attk["end"] or 1)
		timer.Simple(self:GetNextPrimaryFire() - CurTime(), function()
			if IsValid(owv) then
				owv:ClearSchedule()
			end
		end)
		self:GetOwner():SetSchedule(SCHED_MELEE_ATTACK1)
		return
	end
	if self:GetSprinting() and not self:GetStat("AllowSprintAttack", false) then return end
	if self:IsSafety() then return end
	if not self:VMIV() then return end
	if CurTime() <= self:GetNextPrimaryFire() then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return end
	if self:GetComboCount() >= self.Primary.MaxCombo and self.Primary.MaxCombo > 0 then return end
	table.Empty(att)
	local founddir = false

	self:SendViewModelSeq("Attack_Quick")
	
	if self.Primary.Directional then
		ply = self:GetOwner()
		--lvec = WorldToLocal(ply:GetVelocity(), Angle(0, 0, 0), vector_origin, ply:EyeAngles()):GetNormalized()
		lvec.x = 0
		lvec.y = 0

		if ply:KeyDown(IN_MOVERIGHT) then
			lvec.y = lvec.y - 1
		end

		if ply:KeyDown(IN_MOVELEFT) then
			lvec.y = lvec.y + 1
		end

		if ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_JUMP) then
			lvec.x = lvec.x + 1
		end

		if ply:KeyDown(IN_BACK) or ply:KeyDown(IN_DUCK) then
			lvec.x = lvec.x - 1
		end

		lvec.z = 0

		--lvec:Normalize()
		if lvec.y > 0.3 then
			targ = "L"
		elseif lvec.y < -0.3 then
			targ = "R"
		elseif lvec.x > 0.5 then
			targ = "F"
		elseif lvec.x < -0.1 then
			targ = "B"
		else
			targ = ""
		end

		for k, v in pairs(self.Primary.Attacks) do
			if (not self:GetSprinting() or v.spr) and v.direction and string.find(v.direction, targ) then
				if string.find(v.direction, targ) then
					founddir = true
				end

				table.insert(att, #att + 1, k)
			end
		end
	end

	if not self.Primary.Directional or #att <= 0 or not founddir then
		for k, v in pairs(self.Primary.Attacks) do
			if (not self:GetSprinting() or v.spr) and v.dmg then
				table.insert(att, #att + 1, k)
			end
		end
	end

	if #att <= 0 then return end
	ind = att[self:SharedRandom(1, #att, "PrimaryAttack")]
	attack = self.Primary.Attacks[ind]
	--We have attack isolated, begin attack logic
	self:PlaySwing(attack.act)

	if not attack.snd_delay or attack.snd_delay <= 0 then
		if IsFirstTimePredicted() then
			self:EmitSound(Sound("weapons/melee/fireaxe/fireaxe_light"..math.random(1,3)..".wav"))

			if self:GetOwner().Vox then
				self:GetOwner():Vox("bash", 4)
			end
		end

		self:GetOwner():ViewPunch(attack.viewpunch)
	elseif attack.snd_delay then
		if IsFirstTimePredicted() then
			self.AttackSoundTime = CurTime() + attack.snd_delay / self:GetAnimationRate(attack.act)
			self.VoxSoundTime = CurTime() + attack.snd_delay / self:GetAnimationRate(attack.act)
		end

		--[[
		timer.Simple(attack.snd_delay, function()
			if IsValid(self) and self:IsValid() and SERVER then
				self:EmitSound(attack.snd)

				if self:OwnerIsValid() and self:GetOwner().Vox then
					self:GetOwner():Vox("bash", 4)
				end
			end
		end)
		]]
		--
		self:SetVP(true)
		self:SetVPPitch(attack.viewpunch.p)
		self:SetVPYaw(attack.viewpunch.y)
		self:SetVPRoll(attack.viewpunch.r)
		self:SetVPTime(CurTime() + attack.snd_delay / self:GetAnimationRate(attack.act))
		self:GetOwner():ViewPunch(-Angle(attack.viewpunch.p / 2, attack.viewpunch.y / 2, attack.viewpunch.r / 2))
	end

	self.up_hat = false
	self:SetStatus(TFA.Enum.STATUS_SHOOTING)
	self:SetMelAttackID(ind)
	self:SetStatusEnd(CurTime() + attack.delay / self:GetAnimationRate(attack.act))
	self:SetNextPrimaryFire(CurTime() + attack["end"] / self:GetAnimationRate(attack.act))
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:SetComboCount(self:GetComboCount() + 1)
end
*/