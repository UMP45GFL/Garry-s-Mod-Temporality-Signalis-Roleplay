AddCSLuaFile()

ENT.Base 			= "aoc_firedbase"
ENT.PrintName		= "Golden Spear"
ENT.Spawnable		= false

ENT.Model = "models/eternalis/items/weapons/fklr_spear.mdl"
ENT.DamageAmount = 70
ENT.ImpactSound = "AOC_Spear.Thrown_HitWorld"
ENT.HitSound = "AOC_Spear.Thrown_HitBody"

function ENT:OnImpact(data,phys)
	local ang = self:GetAngles()

	timer.Simple(0,function()
		if not IsValid(self) then return end
		
		self:SetSolid( SOLID_NONE )
		self:SetMoveType( MOVETYPE_NONE )
		self:PhysicsInit( SOLID_NONE )
		self:SetMoveCollide( 0 )
		self:SetAngles( ang )
		self:SetPos( data.HitPos )

		if IsValid( data.HitEntity ) then
			self:SetParent( data.HitEntity )
		end
	end)

	SafeRemoveEntityDelayed( self , 10 )
end

if SERVER then
	function ENT:Initialize()
		self:SetModel( self.Model )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_FLYGRAVITY )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_NONE )
		self:PhysicsInitSphere( self.PhysicsRadius )
		self:SetMoveCollide( 3 )
	
		if self.TrailWidth and self.TrailWidth > 0 then
			self.Trail = util.SpriteTrail( self, 0, color_white, false, self.TrailWidth, 0, 0.5, 1 / ( self.TrailWidth + 0 ) * 0.5, "trails/laser" )
		end
	
		local phys = self.Entity:GetPhysicsObject()
	
		if phys:IsValid() then
			phys:Wake()
			phys:SetMass( self.Mass )
			phys:EnableDrag( false )
			phys:EnableGravity( true )
			phys:EnableMotion( true )
			phys:SetBuoyancyRatio( 0.1 )
		end
	end
	
	local function GetPhysObjectHitBox(ent,phys)
		if not isnumber( ent:GetHitboxSetCount() ) then return 0 end
	
		for i = 0, ent:GetPhysicsObjectCount() - 1 do
			if ent:GetPhysicsObjectNum(i) == phys  then
				for hboxset = 0,ent:GetHitboxSetCount() - 1 do
					for hitbox = 0,ent:GetHitBoxCount( hboxset ) - 1 do
						if ent:GetHitBoxBone(hitbox, hboxset) == ent:TranslatePhysBoneToBone(i) then
							return hitbox
						end
					end
				end
			end
		end
	
		return 0
	end

	function ENT:ReplaceWithItem()
		timer.Simple(0.01, function()
			if self.Item then
				self.Item:SetData("equip", false)

				local client = self:GetOwner()
				if IsValid(client) then
					local it = self.Item:Transfer(nil, nil, nil, self:GetOwner())

					if it and it.id and istable(client.thrownItems) then
						for k, v in pairs(client.thrownItems) do
							print(v)
							print(v[3])
							if (CurTime() - v[3]) > 6 or v[2].id == it.id then
								table.remove(client.thrownItems, k)
							end
						end
					end

					if isentity(it) then
						it:SetPos(self:GetPos())
						it:SetAngles(self:GetAngles())
					else
						self.Item:Remove()
					end
				else
					self.Item:Remove()
				end
			end
		end)
	end
	
	function ENT:PhysicsCollide( data, physobj )
		if self.HitObject then return end
	
		self:StopThrowSound()
	
		if IsValid( data.HitEntity ) and ( data.HitEntity:IsNPC() or data.HitEntity:IsPlayer() or data.HitEntity:IsNextBot() ) then
			self:EmitSound(self.HitSound)
			
			local dmg = DamageInfo()
			dmg:SetDamageForce( data.OurOldVelocity )
			dmg:SetInflictor( self )
			dmg:SetAttacker( self:GetOwner():IsValid() and self:GetOwner() or game.GetWorld() )
			dmg:SetDamage( self.DamageAmount )
			dmg:SetDamageType( self.DamageType )
			dmg:SetDamagePosition( data.HitPos )
			data.HitEntity:DispatchTraceAttack( dmg , self:WorldSpaceCenter() , data.HitPos )
	
			data.HitEntity:EmitSound("AOCPlayer.HitSlash")
	
			self:ReplaceWithItem()

			self:Remove()
	
			return
		end
	
		self:EmitSound( self.ImpactSound )
	
		local impactEffect = EffectData()
		impactEffect:SetOrigin( data.HitPos )
		impactEffect:SetStart( self:GetPos() )
		impactEffect:SetSurfaceProp( data.TheirSurfaceProps )
		impactEffect:SetDamageType( self.DamageType )
		impactEffect:SetHitBox( GetPhysObjectHitBox(data.HitEntity,data.HitObject) )
		impactEffect:SetEntity( data.HitEntity )
		impactEffect:SetEntIndex( data.HitEntity:EntIndex() )
		util.Effect( "Impact" , impactEffect , true )
	
		if IsValid( data.HitEntity ) and data.HitEntity:IsRagdoll() then
			self:ReplaceWithItem()
			self:Remove()
	
			return
		end
	
		self.HitObject = true
	
		SafeRemoveEntityDelayed(self.Trail,0.5)
		
		self:ReplaceWithItem()
		self:Remove()
	end
	
	function ENT:OnRemove()
		SafeRemoveEntity(self.Trail)
	end
end
