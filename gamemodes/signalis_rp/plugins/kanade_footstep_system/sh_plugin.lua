
if SERVER then
    AddCSLuaFile("footstep_list.lua")
end
include("footstep_list.lua")

PLUGIN.name = "Footstep system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds better footstep sounds"
PLUGIN.license = [[meow]]

if SERVER then
    ix.config.Add("FootstepSystemEnabled", true, "Whether or to enable the better footstep system.", nil, {
        category = "Sound Effects"
    })

    ix.config.Add("FootstepSystemSlowWalkVolume", 0.75, "Changes the volume of slow walk footsteps.", nil, {
        data = {min = 0, max = 5},
        category = "Sound Effects"
    })

    ix.config.Add("FootstepSystemRunSpeedVolume", 1.2, "Changes the volume of footsteps while running.", nil, {
        data = {min = 0, max = 5},
        category = "Sound Effects"
    })
end

-- Precache all the footstep sounds
local function PrecacheSoundsRecursively(folder)
    local files, folders = file.Find(folder .. "/*", "GAME")

    -- Precache all sounds in this folder
    for _, filename in ipairs(files) do
        if string.EndsWith(filename, ".wav") or string.EndsWith(filename, ".ogg") then
            util.PrecacheSound(folder .. "/" .. filename)
        end
    end

    -- Recursively precache sounds in subfolders
    for _, subfolder in ipairs(folders) do
        PrecacheSoundsRecursively(folder .. "/" .. subfolder)
    end
end

PrecacheSoundsRecursively("sound/footsteps")
PrecacheSoundsRecursively("sound/physics")

-- Helper function to build our table of values.
local function BackwardsEnums(enum_name)
	local backenums = {}

	for k, v in pairs(_G) do
		if isstring(k) and string.find(k, "^" .. enum_name) then
			backenums[v] = k
		end
	end

	return backenums
end

local MAT = BackwardsEnums("MAT_")

if CLIENT then
    hook.Remove("Tick", "Kanade_FootstepSystem_Tick")

    local function FindFootstepSound(mat, surface)
        for _, sndTable in pairs(ETERNALIS_FOOTSTEP_LIST) do
            -- Search by MAT
            if istable(sndTable.mat) then
                for k,v in pairs(sndTable.mat) do
                    if mat == v then
                        return sndTable.sounds[math.random(1, #sndTable.sounds)]
                    end
                end

            elseif sndTable.mat == mat then
                return sndTable.sounds[math.random(1, #sndTable.sounds)]
            end

            -- Search by surface
            if istable(sndTable.surface) then
                for k,v in pairs(sndTable.surface) do
                    if string.find(surface, v) then
                        return sndTable.sounds[math.random(1, #sndTable.sounds)]
                    end
                end

            elseif string.find(surface, sndTable.surface) then
                return sndTable.sounds[math.random(1, #sndTable.sounds)]
            end
        end

        return nil
    end

    local function Kanade_Footsteps()
        if !(ix.config.Get("FootstepSystemEnabled", true)) then return end

        for _, ply in pairs(player.GetAll()) do
            local vel = math.Round(ply:GetVelocity():Length())

            -- Only do footsteps on non spectator players who are alive and aren't noclipping
            if ply:Team() != TEAM_SPECTATOR and ply:Alive() and ply:GetMoveType() != MOVETYPE_NOCLIP
            and vel > 25 and ply:IsOnGround() and ply:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
               
                ply.nextstep = ply.nextstep or 0
                if ply.nextstep > CurTime() then return true end
                
                local fvel = math.Clamp(1 - (vel / 100) / 3, 0.22, 2)
                ply.nextstep = CurTime() + fvel

                local tr = util.TraceHull({
                    start = ply:GetPos() + Vector(0,0,15),
                    endpos = ply:GetPos() + (Angle(90,0,0):Forward() * 70),
                    filter = ply,
                    mins = Vector(-10, -10, -10),
                    maxs = Vector(10, 10, 10)
                })
                if !tr.Hit then return end
                
                local mat = tr.MatType
                local surface = util.GetSurfacePropName(tr.SurfaceProps)
                local sound = FindFootstepSound(mat, surface)
                
                if sound == nil then
                    error("No good sound for surface: " .. surface)
                end

                local volume = 0.7
                local soundLevel = 70
                local pitch = math.random(80, 120)
                volume = volume * ((vel / 100) / 3)
                
                -- If we are walking slowly (holding +alt), lower the volume
                -- And if we are running, increase the volume
                if vel <= ply:GetSlowWalkSpeed() then
                    volume = volume * ix.config.Get("FootstepSystemSlowWalkVolume", 0.7)
                    soundLevel = 65
                
                elseif vel >= ply:GetRunSpeed() then
                    volume = volume * ix.config.Get("FootstepSystemRunSpeedVolume", 1.2)
                    soundLevel = 80
                end

                EmitSound(sound, ply:GetPos(), ply:EntIndex(), CHAN_AUTO, math.Clamp(volume, 0, 1), soundLevel, 0, pitch)
            end
        end
    end
    hook.Add("Tick", "Kanade_FootstepSystem_Tick", Kanade_Footsteps)
end

local path = "eternalis/player/footsteps/"

local function OriginalFootstepFunction(ply, pos, foot, sound, volume, filter)
    -- ladder sounds have to be here since its a bit hard to detect when player is on a ladder
    if (ix.config.Get("FootstepSystemEnabled", true)) then
        if string.find(sound, "ladder") then
            EmitSound(path .. "ladder" .. math.random(1, 4)..".wav", ply:GetPos(), ply:EntIndex(), CHAN_AUTO, 0.5, 70)
        end
        return true
    end
    return false
end

hook.Add("PlayerFootstep", "Kanade_FootstepSystem_PlayerFootstep", function(ply, pos, foot, sound, volume, filter)
    return OriginalFootstepFunction(ply, pos, foot, sound, volume, filter)
end)
