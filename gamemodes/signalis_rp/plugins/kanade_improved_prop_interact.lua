
PLUGIN.name = "Improved prop interact"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds improved prop interaction."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	DynamicHeightAndHullEnabled = "Enable dragging ragdolls",
})

ix.config.Add("PropInteractEnabled", true, "Whether or to enable improved prop interact.", nil, {
	category = "Kanade"
})

ix.config.Add("PropInteractSensitivity", true, "Changes prop interact sensitivity.", nil, {
	category = "Kanade"
})

ix.config.Add("PropInteractMoveDampen", true, "Whether to dampen movement.", nil, {
	category = "Kanade"
})

ix.config.Add("PropInteractPlayerStrength", 35, "Changes prop interact player strength.", nil, {
	data = {min = 0, max = 30000},
	category = "Kanade"
})

ix.config.Add("PropInteractPlayerRange", 105, "Limits the range of from how far away players can pick up objects.", nil, {
	data = {min = 0, max = 30000},
	category = "Kanade"
})

if SERVER then
    util.AddNetworkString("propint_keyeval")
    util.AddNetworkString("propInt:key-cast")
 
    local keybinds = {
        {0, "prop_physics"},
        {1, "command2"},
    }

    local function findKey(ent_class)
        for _, bind in ipairs(keybinds) do
            if string.match(ent_class, bind[2] or "", 1) then
                return bind[1]
            end
        end
    end

    local function addKey(ent_class)
        if not findKey(ent_class) then
            table.insert(keybinds, {#keybinds + 1, ent_class})
        end
    end

    local function sendKeyPress(ply, key)
        net.Start("propInt:key-cast")
            net.WriteBool(key)
        net.Send(ply)
    end

    local function clearIPROP(entity)
        entity.propInt_iprop = nil
    end

    local function isValidIPROP(entity)
        if IsValid(entity) and IsValid(entity:GetPhysicsObject()) then
            return true
        end
        return false
    end

    local function traceForEntity(ply)
        local trace = ply:GetEyeTraceNoCursor()
        local distance = trace.HitPos:Distance(ply:EyePos())

        if distance <= ix.config.Get("PropInteractPlayerRange", 105) then
            local entity = trace.Entity
            if IsValid(entity) and not entity:IsWorld() then
                return entity
            end
        end
    end

    local function calculateMovement(ply, entity, mass, strength)
        local trace = ply:GetEyeTraceNoCursor()
        local distance = trace.HitPos:Distance(ply:EyePos())
        
        if strength > ix.config.Get("PropInteractPlayerStrength", 35) then
            if not (entity:GetClass() == "npc_turret_floor") then
                return
            else
                strength = 10
            end
        end
        
        if ix.config.Get("PropInteractPlayerRange", 105) >= 105 and trace.Entity == entity then
            if distance < ix.config.Get("PropInteractPlayerRange", 105) then
                return trace, strength
            end
        end
    end

    local function calculateAngles(ply, entity)
        local eyeAngles = ply:EyeAngles()
        local entityAngles = entity:GetAngles()
        local newAngles = Angle(entityAngles[1], -eyeAngles[2] + entityAngles[2], entityAngles[3])

        newAngles:RotateAroundAxis(Vector(0, -1, 0), eyeAngles[1])

        return newAngles
    end

    local function applyMovement(ply, info, entity)
        local strength = info[4]
        local aimVector = ply:GetAimVector() * (strength / (info[4] / 10) + 10)
        entity:GetPhysicsObject():SetVelocity(entity:GetVelocity() + aimVector)
    end

	net.Receive("propint_keyeval", function(len, ply)
        local keyState = {}

        for i = 1, 4 do
            keyState[i] = net.ReadBool()
        end

        ply.propInt_keys = keyState
	end)

    hook.Add("AllowPlayerPickup", "propint_allow_player_pickup", function(ply, entity)
        return false
    end)

    hook.Add("PlayerUse", "propint_playeruse3", function(ply, entity)
        if !(ix.config.Get("PropInteractEnabled", true)) then return end

        if not IsValid(ply.propInt_iprop) and not ply:KeyDownLast(IN_WALK) and not ply:KeyDownLast(IN_USE) then
            local physicsObject = entity:GetPhysicsObject()
            local trace, strength
    
            if IsValid(physicsObject) then
                trace, strength = calculateMovement(ply, entity, physicsObject:GetMass(), ix.config.Get("PropInteractPlayerStrength", 35))
            end
    
            if trace and findKey(entity:GetClass()) and not string.match(tostring(entity), "RagMod") then
                ply:PickupObject(entity)
                ply.propInt_iprop = {entity, Vector(), calculateAngles(ply, entity), strength}
            end
        end
    end)

    hook.Add("KeyPress", "propint_keypress", function(ply, key)
        if !(ix.config.Get("PropInteractEnabled", true)) then return end
        
        if not isValidIPROP(ply.propInt_iprop) and key == IN_USE and not ply.propInt_phys then
            local entity = traceForEntity(ply)
            if entity then
                timer.Simple(0, function()
                    entity:Use(ply, ply, USE_SET)
                    hook.Run("PlayerUse", ply, entity)
                end)
            end
        end
    end)
    
    hook.Add("GetPreferredCarryAngles", "propint_carryangles", function(entity, ply)
        local iprop = ply.propInt_iprop
        local keys = ply.propInt_keys

        if IsValid(entity) and iprop and keys then
            local command = ply:GetCurrentCommand()
            local strength = ix.config.Get("PropInteractPlayerStrength", 35)
            local multiplier = ix.config.Get("PropInteractMoveDampen", true) and iprop[4] / (strength / iprop[4]) + 10 or 10

            if keys[1] then
                local mouseX, mouseY = command:GetMouseX(), command:GetMouseY()
                local ang = iprop[3]

                ang:RotateAroundAxis(Vector(0, 0, 1), mouseX * ix.config.Get("PropInteractSensitivity", true) / multiplier)
                ang:RotateAroundAxis(Vector(0, -1, 0), mouseY * ix.config.Get("PropInteractSensitivity", true) / multiplier)

                return ang
            end
            return iprop[3]
        end
    end)

    hook.Add("OnPlayerPhysicsPickup", "propint_physics_reg", function(ply, entity)
        sendKeyPress(ply, true)
    end)

    hook.Add("OnPlayerPhysicsDrop", "propint_physics_drop", function(ply, entity, onGround)
        if isValidIPROP(ply.propInt_iprop) then
            if onGround then
                applyMovement(ply, ply.propInt_iprop, entity)
            end
        end
        clearIPROP(ply)
        sendKeyPress(ply, false)
    end)

    hook.Add("PhysgunPickup", "propint_physgun_pickup", function(ply, entity)
        ply.propInt_phys = true
    end)

    hook.Add("PhysgunDrop", "propint_physgun_drop", function(ply, entity)
        ply.propInt_phys = false
    end)
end

if CLIENT then
    local keyPressed = input.IsKeyDown
    local mousePressed = input.IsMouseDown
    local keys = {keyPressed, mousePressed}

    local function sendKeys(keys, keyState)
        net.Start("propint_keyeval")
        for i = 1, #keys do
            local bind = keys[i]
            keyState[i] = bind[1]:GetInt()
            net.WriteBool(keyState[i])
        end
        net.SendToServer()
    end

    local keyBinds = {
        {CreateClientConVar("propInt_rotateKey", "28", true, false, "", 0), 1},
        {CreateClientConVar("propInt_moveXKey", "2", true, false, "", 0), 1},
        {CreateClientConVar("propInt_moveYKey", "3", true, false, "", 0), 1},
        {CreateClientConVar("propInt_moveZKey", "4", true, false, "", 0), 1},
        {CreateClientConVar("propInt_throwKey", "107", true, false, "", 0), 2}
    }

    local keyState = {}
    local frozen = false

    net.Receive("propInt:key-cast", function()
        frozen = net.ReadBool()
    end)

    timer.Create("propInt:keys-tick", 0, 0, function()
        if frozen then
            sendKeys(keyBinds, keyState)
        end
    end)

    hook.Add("InputMouseApply", "propInt:cam-freeze", function(command, x, y, angle)
        if (keyState[1] or keyState[2] or keyState[3] or keyState[4]) and frozen and input.IsKeyDown(KEY_R) then
            angle = LocalPlayer():EyeAngles()
            return true
        end
    end)

    local colorPrimary = Color(0, 130, 255, 255)
    local colorSecondary = Color(0, 90, 195, 195)

    local function createLabel(font, text, parent)
        local label = vgui.Create("DLabel", parent)
        if font == 1 then
            label:SetFont("DermaDefaultBold")
            label:SetTextColor(colorPrimary)
        end
        label:SetText(text)
        label:SetDark(true)
        return label
    end
end

-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=2913809811
-- Creator: https://steamcommunity.com/profiles/76561198250219972
