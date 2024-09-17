SWEP.Base 			= "tfa_melee_base"
DEFINE_BASECLASS(SWEP.Base)

SWEP.Author 		= "Kanade"
SWEP.PrintName 		= "Small kitchen knife"
SWEP.Spawnable 		= false
SWEP.AdminSpawnable = false
SWEP.Category 		= "Kanade's TFA Signalis"
SWEP.Pickupable 	= false

SWEP.Model = "models/eternalis/items/weapons/kitchen/small_sharp_knife.mdl"
SWEP.Damage = 25

SWEP.ViewModelNormal 	= "models/weapons/c_stunstick.mdl"
SWEP.WorldModelNormal 	= SWEP.Model
SWEP.ViewModelFOVNormal 	= 45

SWEP.ViewModel 		= SWEP.ViewModelNormal
SWEP.WorldModel 	= SWEP.WorldModelNormal
SWEP.ViewModelFOV 	= SWEP.ViewModelFOVNormal

SWEP.Slot			= 1
SWEP.SlotPos		= 0

SWEP.UseHands 		= true

SWEP.HoldType 		= "melee"

SWEP.HoldTypeThrowing 	= "daggerthrown"
SWEP.ViewModelThrowing 	= "models/weapons/ageofchivalry/c_dagger_throwable.mdl"
SWEP.WorldModelThrowing = "models/weapons/ageofchivalry/w_dagger2.mdl"
SWEP.ViewModelFOVThrowing 	= 70

SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)

SWEP.ThrowingEnabled = false

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
		["end"] = 1.3, --time before next attack
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
SWEP.UseHands = true

SWEP.VElementsNormal = {
	["knife"] = {
		type = "Model",
		model = SWEP.Model,
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 2, -17.5),
		angle = Angle(90, 61.111, 3.332),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

SWEP.WElementsNormal = {
	["knife"] = {
		type = "Model",
		model = SWEP.Model,
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

SWEP.VElementsThrowing = {
	["knife"] = {
		type = "Model",
		model = SWEP.Model,
		bone = "dagger2",
		rel = "",
		pos = Vector(-0.401, 0, 11),
		angle = Angle(-90, 270, 0),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

SWEP.WElementsThrowing = {
	["knife"] = {
		type = "Model",
		model = SWEP.Model,
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 2, 2),
		angle = Angle(-90, -90, 0),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

SWEP.VElements = SWEP.VElementsNormal
SWEP.WElements = SWEP.WElementsNormal

SWEP.NextToggle = 0
function SWEP:Reload()
	if self.NextToggle < CurTime() then
		self.ThrowingEnabled = !self.ThrowingEnabled

		if self.ThrowingEnabled then
			self:SetHoldType(self.HoldTypeThrowing)
			self:SetWeaponHoldType(self.HoldTypeThrowing)
			self.ViewModel = self.ViewModelThrowing
			self.WorldModel = self.WorldModelThrowing
			self.ViewModelFOV = self.ViewModelFOVThrowing

			self.VElementsThrowing["knife"].model = self.Model
			self.WElementsThrowing["knife"].model = self.Model

			self.VElements = self.VElementsThrowing
			self.WElements = self.WElementsThrowing
		else
			self:SetHoldType(self.HoldType)
			self:SetWeaponHoldType(self.HoldType)
			self.ViewModel = self.ViewModelNormal
			self.WorldModel = self.WorldModelNormal
			self.ViewModelFOV = self.ViewModelFOVNormal
			self.VElements = self.VElementsNormal
			self.WElements = self.WElementsNormal
		end

		self.Owner:GetViewModel():SetModel(self.ViewModel)

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

function SWEP:DrawHUD()
	local text = "Reload to enable throwing"

	if self.ThrowingEnabled then
		text = "Throwing enabled"
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

local cv_dmg_mult = GetConVar("sv_tfa_damage_multiplier")
local cv_dmg_mult_npc = GetConVar("sv_tfa_damage_multiplier_npc")
local cv_dmg_mult_min = GetConVar("sv_tfa_damage_mult_min")
local cv_dmg_mult_max = GetConVar("sv_tfa_damage_mult_max")

local tr = {}
local strikedir = Vector()

local function TraceHitFlesh(b)
	return b.MatType == MAT_FLESH or b.MatType == MAT_ALIENFLESH or (IsValid(b.Entity) and b.Entity.IsNPC and (b.Entity:IsNPC() or b.Entity:IsPlayer() or b.Entity:IsRagdoll()))
end

function SWEP:Strike(attk, precision)
	local hitWorld, hitNonWorld, hitFlesh, needsCB
	local distance, direction, maxhull
	local ow = self:GetOwner()
	if not IsValid(ow) then return end
	distance = attk.len
	direction = attk.dir
	maxhull = attk.hull
	eang = ow:EyeAngles()
	fwd = ow:EyeAngles():Forward()
	tr.start = ow:GetShootPos()
	scl = direction:Length() / precision / 2
	tr.maxs = Vector(scl, scl, scl)
	tr.mins = -tr.maxs
	tr.mask = MASK_SHOT
	tr.filter = {self, ow}

	hitWorld = false
	hitNonWorld = false
	hitFlesh = false

	if attk.callback then
		needsCB = true
	else
		needsCB = false
	end

	if maxhull then
		tr.maxs.x = math.min(tr.maxs.x, maxhull / 2)
		tr.maxs.y = math.min(tr.maxs.y, maxhull / 2)
		tr.maxs.z = math.min(tr.maxs.z, maxhull / 2)
		tr.mins = -tr.maxs
	end

	strikedir:Zero()
	strikedir:Add(direction.x * eang:Right())
	strikedir:Add(direction.y * eang:Forward())
	strikedir:Add(direction.z * eang:Up())
	local strikedirfull = strikedir * 1

	if ow:IsPlayer() and ow:IsAdmin() and GetConVarNumber("developer") > 0 then
		local spos, epos = tr.start + Vector(0, 0, -1) + fwd * distance / 2 - strikedirfull / 2, tr.start + Vector(0, 0, -1) + fwd * distance / 2 + strikedirfull / 2
		debugoverlay.Line(spos, epos, 5, Color(255, 0, 0))
		debugoverlay.Cross(spos, 8, 5, Color(0, 255, 0), true)
		debugoverlay.Cross(epos, 4, 5, Color(0, 255, 255), true)
	end

	if SERVER and not game.SinglePlayer() and ow:IsPlayer() then
		ow:LagCompensation(true)
	end

	local totalResults = {}
	for i = 1, precision do
		dirv = LerpVector((i - 0.5) / precision, -direction / 2, direction / 2)
		strikedir:Zero()
		strikedir:Add(dirv.x * eang:Right())
		strikedir:Add(dirv.y * eang:Forward())
		strikedir:Add(dirv.z * eang:Up())
		tr.endpos = tr.start + distance * fwd + strikedir
		traceres = util.TraceLine(tr)
		table.insert(totalResults, traceres)
	end

	if SERVER and not game.SinglePlayer() and ow:IsPlayer() then
		ow:LagCompensation(false)
	end

	local basedmg = attk.dmg

	if self.Damage then
		basedmg = self.Damage
	end

	local ind = self:GetMelAttackID() or 1
	local srctbl = ind >= 0 and "Primary" or "Secondary"
	if not self:GetStatL(srctbl .. ".SplitDamage") or not basedmg then
		basedmg = self:GetStatL(srctbl .. ".Damage")
	end

	local dmg = basedmg * util.SharedRandom("TFA_Melee_RandomDamageMult" .. CurTime(), cv_dmg_mult_min:GetFloat(), cv_dmg_mult_max:GetFloat(), self:EntIndex())
	if ow:IsNPC() then
		dmg = dmg * cv_dmg_mult_npc:GetFloat()
	else
		dmg = dmg * cv_dmg_mult:GetFloat()
	end

	local forcevec = strikedirfull:GetNormalized() * (attk.force or basedmg / 4) * 128
	local damage = DamageInfo()
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamage(dmg)
	damage:SetDamageType(attk.dmgtype or DMG_SLASH)
	damage:SetDamageForce(forcevec)
	local fleshHits = 0

	--Handle flesh
	for _, v in ipairs(totalResults) do
		if v.Hit and IsValid(v.Entity) and TraceHitFlesh(v) and (not v.Entity.TFA_HasMeleeHit) then
			self:ApplyDamage(v, damage, attk)
			self:SmackEffect(v, damage)
			v.Entity.TFA_HasMeleeHit = true
			fleshHits = fleshHits + 1
			if fleshHits >= (attk.maxhits or 3) then break end

			if attk.hitflesh and not hitFlesh then
				self:EmitSoundNet(attk.hitflesh)
			end

			if attk.callback and needsCB then
				attk.callback(attk, self, v)
				needsCB = false
			end

			hitFlesh = true
		end
		--debugoverlay.Sphere( v.HitPos, 5, 5, color_white )
	end

	--Handle non-world
	for _, v in ipairs(totalResults) do
		if v.Hit and (not TraceHitFlesh(v)) and (not v.Entity.TFA_HasMeleeHit) then
			self:ApplyDamage(v, damage, attk)
			v.Entity.TFA_HasMeleeHit = true

			if not hitNonWorld then
				self:SmackEffect(v, damage)

				if attk.hitworld and not hitFlesh then
					self:EmitSoundNet(attk.hitworld)
				end

				if attk.callback and needsCB then
					attk.callback(attk, self, v)
					needsCB = false
				end

				self:BurstDoor(v.Entity, damage)
				hitNonWorld = true
			end
		end
	end

	-- Handle world
	if not hitNonWorld and not hitFlesh then
		for _, v in ipairs(totalResults) do
			if v.Hit and v.HitWorld and not hitWorld then
				hitWorld = true

				if attk.hitworld then
					self:EmitSoundNet(attk.hitworld)
				end

				self:SmackEffect(v, damage)

				if attk.callback and needsCB then
					attk.callback(attk, self, v)
					needsCB = false
				end
			end
		end
	end

	--Handle empty + cleanup
	for _, v in ipairs(totalResults) do
		if needsCB then
			attk.callback(attk, self, v)
			needsCB = false
		end

		if IsValid(v.Entity) then
			v.Entity.TFA_HasMeleeHit = false
		end
	end

	if attk.kickback and (hitFlesh or hitNonWorld or hitWorld) then
		self:SendViewModelAnim(attk.kickback)
	end
end











SWEP.DrawAmmo = false

SWEP.BobScale = 1
SWEP.SwayScale = 1

SWEP.ThrowSound = "WeaponFrag.Throw"

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsNPC() then return true end
	
	return CurTime() >= self:GetNextPrimaryFire()
end

function SWEP:PrimaryAttack()
	if !self.ThrowingEnabled then
		BaseClass.PrimaryAttack(self)
		return
	end

	if not self:CanPrimaryAttack() then return end

	if self.Owner:IsNPC() then
		local dur = self.Owner:SequenceDuration( self.Owner:SelectWeightedSequence( self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ] ) )

		timer.Simple(dur * 0.3,function()
			if not self:IsValid() or not self.Owner:IsValid() then return end

			self:EmitSound( self.ThrowSound )
		
			self:Throw()

			self:SetNoDraw(true)
		end)

		timer.Simple(dur,function()
			if not self:IsValid() or not self.Owner:IsValid() then return end
			
			self:SetNoDraw(false)
		end)

	elseif not self:GetLoaded() and self:GetThrowTime() == 0 then
		self:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
		self:SetLoaded( true )
		self:SetThrowTime( CurTime() + self:SequenceDuration() )
		self:SetNextIdle( 0 )
		if SERVER then
			self.Owner:SetNextStamina(0)
		end
	end	
end

function SWEP:GetNPCBulletSpread(prof)
	return 0
end

function SWEP:GetNPCRestTimes()
	local dur = self.Owner:SequenceDuration( self.Owner:SelectWeightedSequence( self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ] ) )

	return dur,dur
end

function SWEP:Think()
	if !self.ThrowingEnabled then
		BaseClass.Think(self)
		return
	end

	if SERVER then
		if self:GetLoaded() and GetConVarNumber("gmod_suit") ~= 0 and self.Owner:IsPlayer() then
			local stamina = self.Owner:GetSuitPower()

			self.MaxStamina = math.min( self.MaxStamina or stamina , stamina )
		
			if stamina > self.MaxStamina then
				self.Owner:SetSuitPower( self.MaxStamina )
			end
		else
			self.MaxStamina = nil
		end
	end

	if self:GetLoaded() and not self.Owner:KeyDown(IN_ATTACK) and not self.Owner:KeyDown(IN_ATTACK2) then
		if CurTime() >= self:GetThrowTime() then
			self:EmitSound( self.ThrowSound )
			self:SendWeaponAnim( ACT_VM_THROW )
			local dur = self:SequenceDuration()
			
			self.Owner:DoAttackEvent()
			self:SetNextIdle( 0 )
			self:SetNextPrimaryFire( CurTime() + dur )
			self:SetNextDraw( CurTime() + dur )

			if SERVER then
				self:Throw()

				if GetConVarNumber("gmod_suit") ~= 0 then
					self.Owner:SetSuitPower( math.max( self.Owner:GetSuitPower() - 10 , 0 ) )
				end

				self:SetNoDraw( true )
			end

			self:SetLoaded( false )
			self:SetThrowTime( 0 )
			if SERVER then
				self.Owner:SetNextStamina(CurTime() + dur)
			end

			if SERVER then
				self:RemoveAfterThrow()
			end
		end
	end

	if self:GetNextDraw() ~= 0 and CurTime() >= self:GetNextDraw() then
		if SERVER then
			self:SetNoDraw( false )
		end
		self:SendWeaponAnim( ACT_VM_DRAW )
		self:SetNextDraw( 0 )
		
	elseif self:GetNextIdle() ~= 0 and CurTime() >= self:GetNextIdle() then
		self:SendWeaponAnim(ACT_VM_IDLE)
		self:SetNextIdle( 0 ) -- CurTime() + self:SequenceDuration()
	end
end

function SWEP:RemoveAfterThrow()
	local ply = self.Owner
	local class = self:GetClass()

	ply:StripWeapon(class)

	if ply.GetCharacter then
		local char = ply:GetCharacter()
		if char then
			local inventory = char:GetInventory()
			if inventory then
				local items = inventory:GetItems()
				if items then
					for _, v in pairs(items) do
						if (v.isWeapon and v:GetData("equip") and v.class == class) then
							v:Remove()
						end
					end
				end
			end
		end
	end
end

function SWEP:Throw()
	local dagger = ents.Create( "aoc_throwndagger" )
	local shoot = self.Owner:GetShootPos()
	local aim = self.Owner:GetAimVector() + vector_up * 0.1
	local ang = self.Owner:EyeAngles()
	dagger:SetPos( shoot + ang:Forward() * 18 + ang:Right() * 2 )
	ang:RotateAroundAxis( ang:Forward() , 90 )
	dagger:SetAngles( ang )
	dagger:Spawn()
	dagger:SetOwner( self.Owner )
	dagger:SetPhysicsAttacker( self.Owner )
	local phys = dagger:GetPhysicsObject()
	phys:SetVelocityInstantaneous(aim * 950)
	phys:AddAngleVelocity( Vector( 0 , 0 , -500 ) )
	dagger:StartThrowSound("AOC_Dagger2.Thrown_Fly")
	
	dagger:SetModel(self.Model)

	return dagger
end

function SWEP:Initialize()
	BaseClass.Initialize(self)

	if self.ThrowingEnabled then
		self:SetHoldType(self.HoldTypeThrowing)
	end

	self:SetSaveValue("m_fMaxRange1", 512)
	self:SetSaveValue("m_fMaxRange2", 512)
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVar( "Float" , 0 , "NextIdle" )
	self:NetworkVar( "Float" , 1 , "NextDraw" )
	self:NetworkVar( "Float" , 2 , "ThrowTime" )
	self:NetworkVar( "Bool" , 0, "Loaded" )

	self:SetLoaded( false )

	self:SetNextDraw( 0 )
	self:SetNextIdle( 0 )
	self:SetThrowTime( 0 )
end

function SWEP:Deploy()
	BaseClass.Deploy(self)

	if self.ThrowingEnabled then
		self:SetHoldType(self.HoldTypeThrowing)
		self:SetNextIdle( CurTime() + self:SequenceDuration() )
		
		if self.Owner:IsPlayer() then	
			self.Owner:DoAnimationEvent( PLAYERANIMEVENT_AOC_DRAW )
		end
	end
end

function SWEP:Holster()
	if self.ThrowingEnabled then
		if self.Owner:IsNPC() then return true end
		if self:GetLoaded() then return false end

		if SERVER then
			self.Owner:SetNextStamina(-1)
		end
		
		return true
	else
		return BaseClass.Holster(self)
	end
end

















local PlaceholderHoldTypes = {
	["daggerthrown"] =	"grenade",
}

local function Is_wOS_Loaded()
	if not wOS then return nil end

	if wOS.DynaBase then
		return wOS.DynaBase.Registers["Age of Chivalry Extension"]
	end

	if wOS.AnimExtension then
		return wOS.AnimExtension.Mounted[ "Age of Chivalry" ]
	end
end

function SWEP:SetWeaponHoldType( t )
	t = string.lower( t )

	-- TODO: Replace wia util.GetActivityIDByName
	-- Not works because it returns -1 for all custom ACT_* on client but server

	if Is_wOS_Loaded() then
		if t == "daggerthrown" then
			self.ActivityTranslate[ ACT_MP_STAND_IDLE ]						= "wos_aoc_dagger2_idle"
			self.ActivityTranslate[ ACT_MP_WALK ]							= "wos_aoc_run_dagger3" -- ACT_HL2MP_WALK_PISTOL
			self.ActivityTranslate[ ACT_MP_RUN ]							= "wos_aoc_run_dagger3"
			self.ActivityTranslate[ ACT_MP_CROUCH_IDLE ]					= "wos_aoc_cidle_dagger2_throw"
			self.ActivityTranslate[ ACT_MP_CROUCHWALK ]						= "wos_aoc_cwalk_dagger3"
			self.ActivityTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]		= "wos_aoc_dagger2_throw"
			self.ActivityTranslate[ ACT_MP_ATTACK_STAND_SECONDARYFIRE ]		= "wos_aoc_dagger2_throw"
			self.ActivityTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]		= "wos_aoc_dagger2_throw"
			self.ActivityTranslate[ ACT_MP_ATTACK_CROUCH_SECONDARYFIRE ]	= "wos_aoc_dagger2_throw"
			self.ActivityTranslate[ ACT_MP_ATTACK_STAND_GRENADE ]			= ACT_INVALID
			self.ActivityTranslate[ ACT_MP_ATTACK_CROUCH_GRENADE ]			= ACT_INVALID
			self.ActivityTranslate[ ACT_MP_RELOAD_STAND ]					= ACT_INVALID
			self.ActivityTranslate[ ACT_MP_RELOAD_CROUCH ]					= ACT_INVALID
			self.ActivityTranslate[ ACT_MP_JUMP ]							= "wos_aoc_jump_dagger3"
			self.ActivityTranslate[ ACT_RANGE_ATTACK1 ]						= "wos_aoc_range_dagger2"
			self.ActivityTranslate[ ACT_AOC_GESTURE_DEFLECT ]				= ACT_INVALID
			self.ActivityTranslate[ ACT_MP_SWIM ]							= ACT_HL2MP_SWIM_KNIFE
			self.ActivityTranslate[ ACT_AOC_BLOCK_IDLE ]					= ACT_INVALID
			self.ActivityTranslate[ ACT_AOC_DRAW ]							= "wos_aoc_dagger2_draw"
			self.ActivityTranslate[ ACT_AOC_HOLSTER ]						= "wos_aoc_dagger2_holster"
		else
			BaseClass.SetWeaponHoldType( self , t )
		end
		
		self:SetupWeaponHoldTypeForAI( PlaceholderHoldTypes[ t ] )

		return nil
	end

	if PlaceholderHoldTypes[ t ] then
		BaseClass.SetWeaponHoldType( self , PlaceholderHoldTypes[ t ] )
	else
		BaseClass.SetWeaponHoldType( self , t )
	end

	self.ActivityTranslate[ ACT_MP_ATTACK_STAND_SECONDARYFIRE ]		= self.ActivityTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]
	self.ActivityTranslate[ ACT_MP_ATTACK_STAND_GRENADE ]			= self.ActivityTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]

	self.ActivityTranslate[ ACT_MP_ATTACK_CROUCH_SECONDARYFIRE ]	= self.ActivityTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]
	self.ActivityTranslate[ ACT_MP_ATTACK_CROUCH_GRENADE ]			= self.ActivityTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]

	self.ActivityTranslate[ ACT_AOC_GESTURE_DEFLECT ] =	ACT_FLINCH_PHYSICS

	self.ActivityTranslate[ ACT_MP_RELOAD_STAND ] =		ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND
	self.ActivityTranslate[ ACT_MP_RELOAD_CROUCH ] =	ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND

	self.ActivityTranslate[ ACT_AOC_BLOCK_IDLE ] =		ACT_HL2MP_FIST_BLOCK

end

function SWEP:TranslateActivity( act )
	if not Is_wOS_Loaded() then return BaseClass.TranslateActivity( self , act ) end
	
	local owner = self:GetOwner()

	if owner:IsNPC() then
		return BaseClass.TranslateActivity( self , act )
	end

	if isstring( self.ActivityTranslate[ act ] ) then
		self.ActivityTranslate[ act ] = owner:GetSequenceActivity( owner:LookupSequence( self.ActivityTranslate[ act ] ) )
		
		return self.ActivityTranslate[ act ]
	end

	return BaseClass.TranslateActivity( self , act )
end

if CLIENT then

SWEP.AOC_Base = true

hook.Add("DoAnimationEvent","AgeOfChivalry_AnimationEvents",function(ply,event,data)
	local wep = ply:GetActiveWeapon()

	if wep:IsValid() and wep.AOC_Base and wep.ThrowingEnabled then
		if event == PLAYERANIMEVENT_CUSTOM_GESTURE then
			ply:AnimResetGestureSlot( GESTURE_SLOT_CUSTOM )

			if data == PLAYERANIMEVENT_AOC_BLOCK_UP_BLOCK then
				timer.Remove(tostring(ply)..".AOC_Block")

				local act = wep:TranslateActivity( ACT_AOC_BLOCK_UP_BLOCK )
				ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD , act , true )
				
				if act > 0 then
					local dur = ply:SequenceDuration( ply:SelectWeightedSequence(act) )
					
					timer.Create(tostring(ply)..".AOC_Block",dur,1,function()
						if not ply:IsValid() then return end

						ply:DoAnimationEvent( PLAYERANIMEVENT_AOC_BLOCK_IDLE )
					end)

					return act
				end

				return ACT_INVALID
			elseif data == PLAYERANIMEVENT_AOC_BLOCK_UP then
				timer.Remove(tostring(ply)..".AOC_Block")

				local act = wep:TranslateActivity( ACT_AOC_BLOCK_UP )
				ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD , act , true )
				
				if act > 0 then
					local dur = ply:SequenceDuration( ply:SelectWeightedSequence(act) )

					timer.Create(tostring(ply)..".AOC_Block",dur,1,function()
						if not ply:IsValid() then return end

						ply:DoAnimationEvent( PLAYERANIMEVENT_AOC_BLOCK_IDLE )
					end)

					return act
				end

				act = wep:TranslateActivity( ACT_AOC_BLOCK_IDLE )
				ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD , act , false )
				
				return act
			elseif data == PLAYERANIMEVENT_AOC_BLOCK_IDLE then
				local act = wep:TranslateActivity( ACT_AOC_BLOCK_IDLE )
				ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD , act , false )

				return act
			elseif data == PLAYERANIMEVENT_AOC_BLOCK_DOWN then
				timer.Remove(tostring(ply)..".AOC_Block")

				local act = wep:TranslateActivity( ACT_AOC_BLOCK_DOWN )

				if act > 0 then
					ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD , act , true )

					return act
				end

				ply:AnimResetGestureSlot( GESTURE_SLOT_ATTACK_AND_RELOAD )

				return ACT_RESET
			elseif data == PLAYERANIMEVENT_AOC_DRAW then
				local act = wep:TranslateActivity( ACT_AOC_DRAW )

				if act > 0 then
					ply:AnimRestartGesture( GESTURE_SLOT_CUSTOM , act , true )
				end

				return act
			end

			local act

			if data == PLAYERANIMEVENT_ATTACK_PRIMARY then
				act = wep:TranslateActivity( ply:Crouching() and ACT_MP_ATTACK_CROUCH_PRIMARYFIRE or ACT_MP_ATTACK_STAND_PRIMARYFIRE )
			elseif data == PLAYERANIMEVENT_ATTACK_SECONDARY then
				act = wep:TranslateActivity( ply:Crouching() and ACT_MP_ATTACK_CROUCH_SECONDARYFIRE or ACT_MP_ATTACK_STAND_SECONDARYFIRE )
			elseif data == PLAYERANIMEVENT_RELOAD then
				act = wep:TranslateActivity( ply:Crouching() and ACT_MP_RELOAD_CROUCH or ACT_MP_RELOAD_STAND )
			elseif data == PLAYERANIMEVENT_ATTACK_GRENADE then
				act = wep:TranslateActivity( ply:Crouching() and ACT_MP_ATTACK_CROUCH_GRENADE or ACT_MP_ATTACK_STAND_GRENADE )
			elseif data == PLAYERANIMEVENT_AOC_DEFLECT then
				act = wep:TranslateActivity( ACT_AOC_GESTURE_DEFLECT )
			end

			ply:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD , act , true )

			return act
		end
	end
end)

end

function SWEP:SetupWeaponHoldTypeForAI( t )
	if t == "melee" or t == "melee2" or t == "knife" then
		self.ActivityTranslateAI = {}

		self.ActivityTranslateAI [ ACT_IDLE ] 						= t == "melee2" and ACT_IDLE_ANGRY_MELEE or ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_ANGRY ] 				= ACT_IDLE_ANGRY_MELEE
		self.ActivityTranslateAI [ ACT_IDLE_RELAXED ] 				= t == "melee2" and ACT_IDLE_ANGRY_MELEE or ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_STIMULATED ] 			= t == "melee2" and ACT_IDLE_ANGRY_MELEE or ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_AGITATED ] 				= ACT_IDLE_ANGRY_MELEE
		self.ActivityTranslateAI [ ACT_IDLE_AIM_RELAXED ] 			= ACT_IDLE_ANGRY_MELEE
		self.ActivityTranslateAI [ ACT_IDLE_AIM_STIMULATED ] 		= ACT_IDLE_ANGRY_MELEE
		self.ActivityTranslateAI [ ACT_IDLE_AIM_AGITATED ] 			= ACT_IDLE_ANGRY_MELEE

		self.ActivityTranslateAI [ ACT_RANGE_ATTACK1 ] 				= ACT_MELEE_ATTACK_SWING --ACT_RANGE_ATTACK_THROW
		self.ActivityTranslateAI [ ACT_RANGE_ATTACK1_LOW ]          = ACT_MELEE_ATTACK_SWING
		self.ActivityTranslateAI [ ACT_MELEE_ATTACK1 ]              = ACT_MELEE_ATTACK_SWING
		self.ActivityTranslateAI [ ACT_MELEE_ATTACK2 ]              = ACT_MELEE_ATTACK_SWING
		self.ActivityTranslateAI [ ACT_SPECIAL_ATTACK1 ] 			= ACT_MELEE_ATTACK_SWING --ACT_RANGE_ATTACK_THROW

		self.ActivityTranslateAI [ ACT_RANGE_AIM_LOW ]              = ACT_IDLE_ANGRY_MELEE
		self.ActivityTranslateAI [ ACT_COVER_LOW ] 					= ACT_IDLE_ANGRY_MELEE
		
		self.ActivityTranslateAI [ ACT_WALK ] 						= ACT_WALK
		self.ActivityTranslateAI [ ACT_WALK_RELAXED ] 				= ACT_WALK
		self.ActivityTranslateAI [ ACT_WALK_STIMULATED ] 			= ACT_WALK
		self.ActivityTranslateAI [ ACT_WALK_AGITATED ] 				= ACT_WALK
		
		self.ActivityTranslateAI [ ACT_RUN_CROUCH ] 				= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_CROUCH_AIM ] 			= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN ] 						= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_AIM_RELAXED ] 			= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_AIM_STIMULATED ] 		= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_AIM_AGITATED ] 			= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_AIM ] 					= ACT_RUN
		self.ActivityTranslateAI [ ACT_SMALL_FLINCH ] 				= ACT_RANGE_ATTACK_PISTOL
		self.ActivityTranslateAI [ ACT_BIG_FLINCH ] 				= ACT_RANGE_ATTACK_PISTOL
	elseif t == "grenade" then
		self.ActivityTranslateAI = {}

		self.ActivityTranslateAI [ ACT_IDLE ] 						= ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_ANGRY ] 				= ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_RELAXED ] 				= ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_STIMULATED ] 			= ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_AGITATED ] 				= ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_AIM_RELAXED ] 			= ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_AIM_STIMULATED ] 		= ACT_IDLE
		self.ActivityTranslateAI [ ACT_IDLE_AIM_AGITATED ] 			= ACT_IDLE

		if IsValid( self.Owner ) and self.Owner:GetClass() == "npc_metropolice" then
			self.ActivityTranslateAI [ ACT_RANGE_ATTACK1 ] 				= ACT_MELEE_ATTACK_SWING
			self.ActivityTranslateAI [ ACT_RANGE_ATTACK1_LOW ]          = ACT_MELEE_ATTACK_SWING
			self.ActivityTranslateAI [ ACT_MELEE_ATTACK1 ]              = ACT_MELEE_ATTACK_SWING
			self.ActivityTranslateAI [ ACT_MELEE_ATTACK2 ]              = ACT_MELEE_ATTACK_SWING
			self.ActivityTranslateAI [ ACT_SPECIAL_ATTACK1 ] 			= ACT_MELEE_ATTACK_SWING
		else
			self.ActivityTranslateAI [ ACT_RANGE_ATTACK1 ] 				= ACT_RANGE_ATTACK_THROW
			self.ActivityTranslateAI [ ACT_RANGE_ATTACK1_LOW ]          = ACT_RANGE_ATTACK_THROW
			self.ActivityTranslateAI [ ACT_MELEE_ATTACK1 ]              = ACT_RANGE_ATTACK_THROW
			self.ActivityTranslateAI [ ACT_MELEE_ATTACK2 ]              = ACT_RANGE_ATTACK_THROW
			self.ActivityTranslateAI [ ACT_SPECIAL_ATTACK1 ] 			= ACT_RANGE_ATTACK_THROW
		end

		self.ActivityTranslateAI [ ACT_RANGE_AIM_LOW ]              = ACT_IDLE
		self.ActivityTranslateAI [ ACT_COVER_LOW ] 					= ACT_IDLE
		
		self.ActivityTranslateAI [ ACT_WALK ] 						= ACT_WALK
		self.ActivityTranslateAI [ ACT_WALK_RELAXED ] 				= ACT_WALK
		self.ActivityTranslateAI [ ACT_WALK_STIMULATED ] 			= ACT_WALK
		self.ActivityTranslateAI [ ACT_WALK_AGITATED ] 				= ACT_WALK
		
		self.ActivityTranslateAI [ ACT_RUN_CROUCH ] 				= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_CROUCH_AIM ] 			= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN ] 						= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_AIM_RELAXED ] 			= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_AIM_STIMULATED ] 		= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_AIM_AGITATED ] 			= ACT_RUN
		self.ActivityTranslateAI [ ACT_RUN_AIM ] 					= ACT_RUN
		self.ActivityTranslateAI [ ACT_SMALL_FLINCH ] 				= ACT_RUN
		self.ActivityTranslateAI [ ACT_BIG_FLINCH ] 				= ACT_RUN
	else
		BaseClass.SetupWeaponHoldTypeForAI( self , t )
	end
end
