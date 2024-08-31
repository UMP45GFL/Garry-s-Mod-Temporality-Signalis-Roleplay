AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

sound.Add({
    name = "cooking",
    channel = CHAN_STATIC,
    volume = 0.9,
    level = 60,
    pitch = {95, 110},
    sound = "cooking/cookersound.wav"
})

local COOKING = {
    tritip_raw = {
        cooked = {"tritip_cooked", 1},
        offset = Vector(0, 0, 5),
        scale = nil,
        time = 8 * 60,
        temperature = 204
    },
    steak_raw = {
        cooked = {"steak_cooked", 1},
        offset = Vector(0, 0, 3),
        scale = nil,
        time = 3 * 60,
        temperature = 190
    },
    fish_bass_raw = {
        cooked = {"fish_steak", 3},
        offset = Vector(0, 0, 4),
        scale = nil,
        time = 4 * 60,
        temperature = 177
    },
    bacon_raw = {
        cooked = {"bacon_cooked", 1},
        offset = Vector(0, 0, 2),
        scale = nil,
        time = 1 * 60 + 30,
        temperature = {149, 163}
    },
    bacon_raw_big = {
        cooked = {"bacon_cooked", 5},
        offset = Vector(0, 0, 4),
        scale = nil,
        time = 6 * 60,
        temperature = {163, 177}
    }
}

local panPositions = {
    -- bottom right
    {
        up = 40.5,
        right = -9,
        forward = -12.5
    },
    -- bottom left
    {
        up = 40.5,
        right = 9,
        forward = -11.2
    },
    -- top right
    {
        up = 40.5,
        right = -9,
        forward = -23.7
    },
    -- top left
    {
        up = 40.5,
        right = 9,
        forward = -23.7
    }
}

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

    self.itemsBeingCooked = {}
    self.pans = {}
end

-- Utility to start cooking a food item
function ENT:StartCooking(foodTable, ent)
    local panSlot = self:FindClosestPanSlot(ent, true)
    if panSlot == nil then
        return
    end
    local pan = self.pans[panSlot]

    -- this is not a pan, its the item that will be cooked
    local prop = ents.Create("et_pan1")
    prop:SetPos(pan:GetPos() + foodTable.offset)

    local ang = self:GetAngles()
    ang:RotateAroundAxis(ang:Up(), math.random(45, 135))

    prop:SetAngles(ang)
    prop:Spawn()
    prop:SetModel(ent:GetModel())
    prop:Activate()
    prop:SetParent(self)
    prop:SetSolid(SOLID_VPHYSICS)
    if foodTable.scale then
        prop:SetModelScale(foodTable.scale)
    end

    pan:EmitSound("cooking")
    ent:Remove()

    --print("starting cooking at panslot: " .. panSlot .. " with pan: " .. tostring(pan))
    self.itemsBeingCooked[panSlot] = {
        item = foodTable.cooked[1],
        count = foodTable.cooked[2],
        pan = pan,
        prop = prop,
        cookingUntil = CurTime() + foodTable.time + math.random(-30, 30)
    }
end

function ENT:FindClosestPanSlot(ent, valid)
    local closestPan = nil
    for i=1, 4 do
        if IsValid(self.pans[i]) == valid then
            local pos = self:GetPos() + self:GetAngles():Up() * panPositions[i].up + self:GetAngles():Right() * panPositions[i].right + self:GetAngles():Forward() * panPositions[i].forward
            local dist = ent:GetPos():Distance(pos)
            if dist < 15 then
                if closestPan == nil or dist < closestPan.dist then
                    closestPan = {
                        dist = dist,
                        panSlot = i
                    }
                end
            end
        end
    end
    if closestPan == nil then
        return nil
    end
    return closestPan.panSlot
end

function ENT:CreatePan(ent)
    local panSlot = self:FindClosestPanSlot(ent, false)
    if panSlot == nil then
        return
    end

    local ang = self:GetAngles()
    ang:RotateAroundAxis(ang:Up(), math.random(45, 135))

    local newPan = ents.Create("et_pan1")
    if IsValid(newPan) then
        newPan:SetPos(self:GetPos() + self:GetAngles():Up() * panPositions[panSlot].up + self:GetAngles():Right() * panPositions[panSlot].right + self:GetAngles():Forward() * panPositions[panSlot].forward)
        newPan:SetAngles(ang)
        newPan:Spawn()
        newPan:Activate()
        newPan:SetParent(self)
        newPan:SetSolid(SOLID_VPHYSICS)

        self.pans[panSlot] = newPan
        ent:Remove()
    end
end

function ENT:StartTouch(ent)
    local entClass = ent:GetClass()

    if entClass != "ix_item" then
        return
    end

    local model = ent:GetModel()
    local class = ent:GetItemTable().uniqueID
    
    if class == "frying_pan" and table.Count(self.pans) < 4 then
        self:CreatePan(ent)

    elseif COOKING[class] and table.Count(self.itemsBeingCooked) < 4 then
        self:StartCooking(COOKING[class], ent)
    end
end

-- Check for finished food and spawn completed items
function ENT:Think()
    for panSlot, itemCookingTab in ipairs(self.itemsBeingCooked) do

        if itemCookingTab and itemCookingTab.cookingUntil <= CurTime() then
            --print("panslot: " .. panSlot .. " finished cooking with pan: " .. tostring(itemCookingTab.pan))
            itemCookingTab.pan:StopSound("cooking")
            itemCookingTab.prop:Remove()

            for i=1, itemCookingTab.count do
                ix.item.Spawn(itemCookingTab.item, itemCookingTab.pan:GetPos() + Vector(0, 0, 5 * i))
            end

            table.RemoveByValue(self.itemsBeingCooked, itemCookingTab)
        end

    end
end
