
PLUGIN.name = "Ragdoll dragging"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds ragdoll dragging."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	ragdollDraggingEnabled = "Enable dragging ragdolls",
})

ix.config.Add("ragdollDraggingEnabled", true, "Whether or to enable ragdoll dragging.", nil, {
	category = "Kanade"
})

ix.config.Add("ragdollDragginAlowMassLimit", true, "Whether or to enable ragdoll dragging.", nil, {
	category = "Kanade"
})

if SERVER then
    local function PickupLimb(ply)
        -- Check if the plugin is enabled
        if !(ix.config.Get("ragdollDraggingEnabled", true)) then return end

        -- Trace a line from the player's eyes to where they're looking
        local trace = ply:GetEyeTrace()

        -- Check if the trace hit a ragdoll limb
        if not IsValid(trace.Entity) or not trace.Entity:IsRagdoll() or trace.PhysicsBone <= 0 then return end
                    
        -- Check if the entity is being held (ex: physgun)
        -- Prevent pickup if mouse1 is held (ex: physgun again)
        if trace.Entity:IsPlayerHolding() or ply.dragdollMouseHeld then return end
        
        local phys = trace.Entity:GetPhysicsObjectNum(trace.PhysicsBone - 1)
        if not IsValid(phys) or not phys:IsMoveable() then return end
        if phys:GetMass() >= 10 and (ix.config.Get("ragdollDragginAlowMassLimit", true)) then return end

        local dist = trace.HitPos:Distance(ply:GetPos())
        if dist > 100 then return end

        -- Create an invisible entity to hold the limb
        local holdEnt = ents.Create("prop_physics")
        holdEnt:SetPos(trace.HitPos - trace.Normal * 5)
        holdEnt:SetModel("models/props_junk/PopCan01a.mdl")
        holdEnt:SetCollisionGroup(COLLISION_GROUP_WORLD)
        holdEnt:Spawn()
        holdEnt:Activate()
        holdEnt:SetNotSolid(true)
        holdEnt:SetNoDraw(true)

        -- Weld the invisible entity to the limb
        local weld = constraint.Weld(holdEnt, trace.Entity, 0, trace.PhysicsBone - 1, 0, true, true)

        -- Store the weld and the original position of the limb
        holdEnt.weld = weld
        holdEnt.limbPos = phys:GetPos()
        holdEnt.player = ply

        -- Wait a frame before making the entity solid and allowing the player to pick it up
        timer.Simple(0, function()
            if IsValid(holdEnt) and IsValid(ply) then
                holdEnt:SetNotSolid(false)
                ply:PickupObject(holdEnt)
                ply:SetNWEntity("HoldEntity", holdEnt)
                ply.holdingLimb = true
            end
        end)
    end

    local function DropLimb(ply)
        if not ply or not ply.holdingLimb then return end

        local holdEnt = ply:GetNWEntity("HoldEntity")

        -- Get the entity the player is holding
        if not IsValid(holdEnt) or holdEnt:GetClass() ~= "prop_physics" or not holdEnt.weld or not holdEnt.limbPos then 
            holdEnt = nil
            ply.holdingLimb = false
            return 
        end

        -- Break the weld and make the limb fall to the ground
        holdEnt.weld:Remove()
        holdEnt:SetPos(holdEnt.limbPos)
        holdEnt:SetCollisionGroup(COLLISION_GROUP_NONE)
        holdEnt:GetPhysicsObject():EnableGravity(true)
        holdEnt:GetPhysicsObject():Wake()

        -- Remove the invisible entity
        holdEnt:Remove()

        -- Update the holdingLimb variable
        ply.holdingLimb = false
    end

    hook.Add("KeyPress", "LimbPickup", function(ply, key)
        if key == IN_USE then
            if not ply.holdingLimb then
                PickupLimb(ply)
            else
                DropLimb(ply)
            end

        elseif key == IN_ATTACK then
            ply.dragdollMouseHeld = true
            if ply.holdingLimb then 
                DropLimb(ply)
            end  
        end
    end)

    hook.Add("KeyRelease", "LimbKeyRelease", function(ply,key)
        if key == IN_ATTACK then
            ply.dragdollMouseHeld = false
        end
    end)

    hook.Add("AllowPlayerPickup", "AllowPickupLimb", function(ply, obj)
        -- Allow the player to pick up the invisible entity we created
        if obj:GetClass() == "prop_physics" and obj:GetModel() == "models/props_junk/PopCan01a.mdl" then
            return true
        end
    end)

    hook.Add("PlayerSpawn", "LimbVariable", function(ply)
        DropLimb(ply)
        ply.holdingLimb = false
    end)

    -- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=2938010635
    -- Creator: https://steamcommunity.com/id/FireFlail
end
