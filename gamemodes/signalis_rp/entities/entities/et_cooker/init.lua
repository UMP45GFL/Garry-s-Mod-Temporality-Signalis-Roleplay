AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local COOKING = {
    meat_raw = {
        cooked = {"meat_cooked", 1},
        pos = Vector(-9, -12.7, 0),
        scale = nil,
        time = 30
    },
    steak_raw = {
        cooked = {"steak_cooked", 1},
        pos = Vector(-9, -12.7, 0),
        scale = nil,
        time = 20
    },

    /*
    egg = 30,
    pancake = 38,
    bacon = 25,
    meat = 25,
    meat2 = 35,
    fish1 = 35,
    fish2 = 20,
    fish3 = 18,
    cake = 35,
    pizza = 45
    */
}

local SOUND_CHANNEL = CHAN_STATIC
local COOKING_SOUND = "cooking/cookersound.wav"
local COOKING_SOUND_VOLUME = 0.9
local COOKING_SOUND_LEVEL = 60

function ENT:Initialize()
    self:SetModel("models/furniturepack3/kitchen/counter_stove.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self:SetModelScale(1.25)

    -- Initialize cooking state
    self.cookingSlots = {
        egg = false,
        bacon = false,
        meat = false,
        pancake = false,
        meat2 = false,
        fish1 = false,
        fish2 = false,
        fish3 = false,
        cake = false,
        pizza = false
    }

    self.panslot = 0
    self.cooldown = 0
    self.finishTimes = {}

    -- Add sound configuration
    sound.Add({
        name = "cooking",
        channel = SOUND_CHANNEL,
        volume = COOKING_SOUND_VOLUME,
        level = COOKING_SOUND_LEVEL,
        pitch = {95, 110},
        sound = COOKING_SOUND
    })
end

-- Utility to start cooking a food item
function ENT:StartCooking(foodType, model, posOffset, scale, bakeTime)
    self.cookingSlots[foodType] = true
    self.cooldown = CurTime() + 1
    self.finishTimes[foodType] = CurTime() + bakeTime

    local prop = ents.Create("et_pan1")
    prop:SetPos(self:GetPos() + self:GetAngles():Up() * 43.5 + posOffset)
    prop:SetAngles(self:GetAngles())
    prop:Spawn()
    prop:SetModel(model)
    if scale then prop:SetModelScale(scale) end
    prop:Activate()
    prop:SetParent(self)
    prop:SetSolid(SOLID_VPHYSICS)

    self:EmitSound("cooking")

    -- Stop cooking and remove the entity after bake time
    timer.Create(foodType .. "_timer", bakeTime, 1, function()
        prop:Remove()
        self:StopSound("cooking")
        self.cookingSlots[foodType] = false
    end)
end

function ENT:StartTouch(ent)
    local class = ent:GetClass()

    if class != "ix_item" then return end

    class = ent:GetItemTable().uniqueID
    local model = ent:GetModel()
    -- ix.item.Get("meat_cooked").model
    
    if COOKING[class] then
        self:StartCooking(COOKING[class].cooked, model, COOKING[class].pos, COOKING[class].scale, COOKING[class].time)

    elseif class == "et_pan" and self.panslot == 0 then
        ent:Remove()
        self.panslot = 1
        self.cooldown = CurTime() + 1
    end
end

function ENT:CanCook(foodType, requiredPanSlot)
    return not self.cookingSlots[foodType] and self.panslot == requiredPanSlot and self.cooldown <= CurTime()
end

function ENT:Think()
    -- Check for finished food and spawn completed items
    for foodType, isCooking in pairs(self.cookingSlots) do
        if isCooking and self.finishTimes[foodType] <= CurTime() then
            self.cookingSlots[foodType] = false
            --local cookedFood = ents.Create("cm_food_" .. foodType)
            --cookedFood:SetPos(self:GetPos() + Vector(0, 0, 50))
            --cookedFood:Spawn()
        end
    end
end
