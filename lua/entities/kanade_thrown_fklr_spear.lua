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
