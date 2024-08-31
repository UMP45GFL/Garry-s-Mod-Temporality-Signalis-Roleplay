AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/house furniture/toaster.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self.Entity:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self.isCooking = false
    self.isCooking2 = false
    self.finishBakeTime = 0
    self.finishBakeTime2 = 0
    self.finishBakeTime3 = 0
end

function ENT:Use(activator)
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_toast1" and self.isCooking == false then
        ent:Remove()
        self.isCooking = true
        self.finishBakeTime = CurTime() + 15
        self.finishBakeTime3 = CurTime() + 0.5
		local Angles = self:GetAngles()
		Angles:RotateAroundAxis(Angles:Up(),-90)
		Angles:RotateAroundAxis(Angles:Right(),0)
		Angles:RotateAroundAxis(Angles:Forward(),90)
		local prop2 = ents.Create("cm_cup1")
		prop2:SetPos(self:GetPos() + self:GetAngles():Up()*2.7 + self:GetAngles():Right()*3 + self:GetAngles():Forward()*0)
		prop2:SetAngles(Angles)
		prop2:Spawn()
		prop2:SetModel("models/foodnhouseholditems/toast.mdl")
		prop2:Activate()
		prop2:SetParent(self)
		prop2:SetSolid(SOLID_VPHYSICS)
			timer.Create("toast1", 15, 1, function()
			prop2:Remove()
			end)
    end
    if ent:GetClass() == "cm_toast1" and self.isCooking == true and self.isCooking2 == false and self.finishBakeTime3 <= CurTime() then
        ent:Remove()
        self.isCooking2 = true
        self.finishBakeTime2 = CurTime() + 15
		local Angles = self:GetAngles()
		Angles:RotateAroundAxis(Angles:Up(),-90)
		Angles:RotateAroundAxis(Angles:Right(),0)
		Angles:RotateAroundAxis(Angles:Forward(),90)
		local prop3 = ents.Create("cm_cup1")
		prop3:SetPos(self:GetPos() + self:GetAngles():Up()*2.7 + self:GetAngles():Right()*-3 + self:GetAngles():Forward()*0)
		prop3:SetAngles(Angles)
		prop3:Spawn()
		prop3:SetModel("models/foodnhouseholditems/toast.mdl")
		prop3:Activate()
		prop3:SetParent(self)
		prop3:SetSolid(SOLID_VPHYSICS)
			timer.Create("toast2", 15, 1, function()
			prop3:Remove()
			end)
    end
end

function ENT:Think()
    if self.isCooking == true then
        if self.finishBakeTime <= CurTime() then
            self.isCooking = false
            local bread = ents.Create("cm_toast2")
            bread:SetPos(self:GetPos() + Vector(0, 0, 15))
            bread:Spawn()
        end
    end
    if self.isCooking2 == true then
        if self.finishBakeTime2 <= CurTime() then
            self.isCooking2 = false
            local bread = ents.Create("cm_toast2")
            bread:SetPos(self:GetPos() + Vector(0, 0, 15))
            bread:Spawn()
        end
    end
end