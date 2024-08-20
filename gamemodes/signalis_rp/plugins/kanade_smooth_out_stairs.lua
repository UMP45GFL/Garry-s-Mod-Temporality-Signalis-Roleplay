
PLUGIN.name = "Smooth out stairs"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds smoothing out stairs"
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	SmoothOutStairsEnabled = "Enable smoothing out stairs",
    optSmoothOutStairsEnabled = "Enable smoothing out stairs",
    optSmoothOutStairsSpeed = "Smooth out stairs speed"
})

ix.config.Add("SmoothOutStairsEnabled", false, "Whether or to enable smoothing out stairs.", nil, {
	category = "Visual Effects"
})

if CLIENT then
    ix.option.Add("SmoothOutStairsEnabled", ix.type.bool, false, {
        category = "Visual Effects"
    })
    
    ix.option.Add("SmoothOutStairsSpeed", ix.type.number, 1, {
        category = "Visual Effects", min = 0.1, max = 20, decimals = 1
    })

    local enabled = ix.config.Get("SmoothOutStairsEnabled", true) && ix.option.Get("SmoothOutStairsEnabled", true)
    local speed = ix.option.Get("SmoothOutStairsSpeed", 1)

    local last_pos = 0
    local pos = 0

    local offset = 0

    local last_realtime = 0
    local realtime = 0

    local blacklist = {
        "mg_%a+"
    }
    if file.Exists("ss_blacklist.json", "DATA") then
        local content = file.Read("ss_blacklist.json")
        blacklist = util.JSONToTable(content)
    else
        file.Write("ss_blacklist.json", util.TableToJSON(blacklist))
    end

    concommand.Add("cl_smooth_steps_ignore_current", function()
        local lp = LocalPlayer()
        local weapon = lp:GetActiveWeapon()

        if !IsValid(weapon) then return end

        table.insert(blacklist, weapon:GetClass())

        file.Write("ss_blacklist.json", util.TableToJSON(blacklist))
    end)

    concommand.Add("cl_smooth_steps_ignore_pattern", function(ply, cmd, args, arg_str)
        table.insert(blacklist, arg_str)

        file.Write("ss_blacklist.json", util.TableToJSON(blacklist))
    end)

    concommand.Add("cl_smooth_steps_remove_pattern", function(ply, cmd, args, arg_str)
        table.remove(blacklist, tonumber(args[1]))

        file.Write("ss_blacklist.json", util.TableToJSON(blacklist))
    end)

    concommand.Add("cl_smooth_steps_get_patterns", function(ply, cmd, args, arg_str)
        PrintTable(blacklist)
    end)

    hook.Add("CalcView", "apply_step_smoothening", function(ply, origin, angles, fov, znear, zfar)
        local enabled = ix.config.Get("SmoothOutStairsEnabled", true) && ix.option.Get("SmoothOutStairsEnabled", true)
        if !enabled || !IsValid(ply) then return end

        last_realtime = realtime
        realtime = SysTime()
        if realtime - last_realtime <= 0.00001 then
            return
        end

        last_pos = pos
        pos = origin.z
        local diff = pos - last_pos
        local abs_diff = math.abs(diff)

        local vel = ply:GetVelocity()

        local ground_entity = ply:GetGroundEntity()

        if not ply:OnGround() ||
        vel:Length2DSqr() <= 0.001 ||
        abs_diff > ply:GetStepSize() ||
        --abs_diff < vel:Length() * FrameTime() ||
        ply:GetMoveType() != MOVETYPE_WALK ||
        (IsValid(ground_entity) && ground_entity:GetVelocity():LengthSqr() > 0.01 )
        then
            diff = 0
        end

        offset = Lerp(FrameTime() * 10 * speed, offset + diff, 0)

        if math.abs(offset) <= 0 then return end

        origin:Sub(Vector(0, 0, offset))
    end)

    local vm_last_realtime = 0
    local vm_realtime = 0

    hook.Add("CalcViewModelView", "apply_step_smoothening", function(wep, vm, oldpos, oldang, origin, ang)
        if math.abs(offset) <= 0 then return end

        if IsValid(wep) then
            local class = wep:GetClass()
            for i, pattern in ipairs(blacklist) do
                if string.match(class, pattern) then return end
            end
        end

        vm_last_realtime = vm_realtime
        vm_realtime = SysTime()
        if vm_realtime - vm_last_realtime <= 0.00001 then
            return
        end

        origin:Sub(Vector(0, 0, offset))
    end)
end

-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=3233720748
-- Creator: https://steamcommunity.com/id/relaxtakenotes
