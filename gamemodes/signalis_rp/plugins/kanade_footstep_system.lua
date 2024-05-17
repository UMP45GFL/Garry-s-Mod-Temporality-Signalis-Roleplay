
PLUGIN.name = "Footstep system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds better footstep sounds"
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	FootstepSystemEnabled = "Enable footstep system",
})

ix.config.Add("FootstepSystemEnabled", true, "Whether or to enable the better footstep system.", nil, {
	category = "Kanade"
})

ix.config.Add("FootstepSystemSlowWalkVolume", 0.75, "Changes the volume of slow walk footsteps.", nil, {
	data = {min = 0, max = 5},
	category = "Kanade"
})

ix.config.Add("FootstepSystemRunSpeedVolume", 1.2, "Changes the volume of footsteps while running.", nil, {
	data = {min = 0, max = 5},
	category = "Kanade"
})

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

PrecacheSoundsRecursively("sound/kanade_footsteps")
PrecacheSoundsRecursively("sound/physics")


-- Helper function to build our table of values.
local function BackwardsEnums(enum_name)
	local backenums = {}

	for k, v in pairs( _G ) do
		if isstring(k) and string.find(k, "^" .. enum_name) then
			backenums[ v ] = k
		end
	end

	return backenums
end

local MAT = BackwardsEnums( "MAT_" )

local footsteps = {

}

/*
hook.Add("PostPlayerDraw", "PostPlayerDraw2132412", function()
    local v = LocalPlayer()
    local tr = util.TraceHull({
        start = v:GetPos() + Vector(0,0,5),
        endpos = v:GetPos() + (Angle(90,0,0):Forward() * 70),
        filter = v,
        mins = Vector(-10, -10, -10),
        maxs = Vector(10, 10, 10)
    })
    if !tr.Hit then return end

    render.SetColorMaterial()
    render.DrawSphere(tr.HitPos, 5, 30, 30, Color( 0, 175, 175, 100 ) )
end)
*/

local function MathRandom(num)
	return (math.Round(math.random(1, 99999999) % (num)) + 1)
end

local path = "kanade_footsteps/"

if CLIENT then
    hook.Remove("Tick", "Kanade_FootstepSystem_Tick")

    function Kanade_Footsteps()
        if !(ix.config.Get("FootstepSystemEnabled", true)) then return end
        for k,v in pairs(player.GetAll()) do
            local vel = math.Round(v:GetVelocity():Length())

            -- Only do footsteps on non spectator players who are alive and aren't noclipping
            if v:Team() != TEAM_SPECTATOR and v:Alive() and v:GetMoveType() != MOVETYPE_NOCLIP and vel > 25 and v:IsOnGround() then
                v.nextstep = v.nextstep or 0
                if v.nextstep > CurTime() then return true end
                
                local fvel = math.Clamp(1 - (vel / 100) / 3, 0.22, 2)
                v.nextstep = CurTime() + fvel

                local tr = util.TraceHull({
                    start = v:GetPos() + Vector(0,0,15),
                    endpos = v:GetPos() + (Angle(90,0,0):Forward() * 70),
                    filter = v,
                    mins = Vector(-10, -10, -10),
                    maxs = Vector(10, 10, 10)
                })
                
                if !tr.Hit then return end
            
                local volume = 0.7
                local soundLevel = 70
                local sound = ""
                volume = volume * ((vel / 100) / 3)
                
                -- If we are walking slowly (holding +alt), lower the volume
                -- And if we are running, increase the volume
                if vel <= v:GetSlowWalkSpeed() then
                    volume = volume * ix.config.Get("FootstepSystemSlowWalkVolume", 0.7)
                    soundLevel = 65

                elseif vel >= v:GetRunSpeed() then
                    volume = volume * ix.config.Get("FootstepSystemRunSpeedVolume", 1.2)
                    soundLevel = 80
                end

                local mat = tr.MatType
                local surface = util.GetSurfacePropName(tr.SurfaceProps)
                --v:PrintMessage(HUD_PRINTCENTER, "" .. surface .. "  " .. MAT[mat] .. "  " .. CurTime() .. "")

                local rnd4 = MathRandom(4)
                
                if string.find(surface, "dirt") then
                    sound = path .. "dirt"..rnd4..".wav"

                elseif mat == MAT_WOOD or string.find(surface, "wood") then
                    sound = path .. "wood"..rnd4..".wav"

                elseif mat == MAT_GRASS then
                    sound = path .. "grass"..rnd4..".wav"

                elseif mat == MAT_METAL or string.find(surface, "metal") then
                    sound = path .. "metal"..rnd4..".wav"

                elseif mat == MAT_TILE or string.find(surface, "tile") then
                    sound = "player/footsteps/tile"..rnd4..".wav"

                elseif mat == MAT_GRATE then
                    sound = path .. "metalgrate"..rnd4..".wav"
                    
                elseif mat == MAT_CONCRETE or string.find(surface,"rock") or string.find(surface, "concrete") then
                    sound = path .. "concrete"..rnd4..".wav"

                elseif string.find(surface, "wood_plank") then
                    sound = path .. "woodpanel"..rnd4..".wav"

                elseif mat == MAT_PLASTIC or string.find(surface, "plastic") or string.find(surface, "rubber") then
                    sound = "physics/plastic/plastic_box_impact_soft"..rnd4..".wav"

                elseif mat == MAT_SAND or string.find(surface, "sand") then
                    sound = path .. "sand"..rnd4..".wav"

                elseif string.find(surface, "paper") then
                    sound = "physics/cardboard/cardboard_box_impact_soft"..MathRandom(7)..".wav"

                elseif mat == MAT_SNOW or string.find(surface, "snow") then
                    sound = "player/footsteps/tile"..rnd4..".wav"

                elseif mat == MAT_FLESH or string.find(surface, "flesh") then
                    sound = "physics/flesh/flesh_impact_hard"..MathRandom(3)..".wav"

                elseif string.find(surface, "mud") then
                    sound = path .. "mud"..rnd4..".wav"

                elseif mat == MAT_SLOSH then
                    sound = path .. "slosh"..rnd4..".wav"

                elseif mat == MAT_VENT or string.find(surface, "vent") then
                    sound = path .. "duct"..rnd4..".wav"

                elseif mat == MAT_COMPUTER then
                    sound = "physics/metal/metal_box_footstep"..rnd4..".wav"

                elseif string.find(surface, "cardboard") then
                    sound = "physics/cardboard/cardboard_box_impact_soft"..MathRandom(7)..".wav"

                else
                    sound = path .. "dirt"..rnd4..".wav"
                    ErrorNoHalt("No good sound for surface: " .. surface)
                end
                
                if (sound) then
                   EmitSound(sound, v:GetPos(), v:EntIndex(), CHAN_AUTO, math.Clamp(volume, 0, 1), soundLevel)
                else
                    ErrorNoHalt("No good sound for surface: " .. surface)
                end
            end
        end
    end
    hook.Add("Tick", "Kanade_FootstepSystem_Tick", Kanade_Footsteps)
end


local function OriginalFootstepFunction(ply, pos, foot, sound, volume, filter)
    if (ix.config.Get("FootstepSystemEnabled", true)) then
        if string.find(sound, "ladder") then
            EmitSound(path .. "ladder" .. MathRandom(4)..".wav", ply:GetPos(), ply:EntIndex(), CHAN_AUTO, 0.5, 70)
        end
        return true
    end
    return false
end

function Schema:PlayerFootstep(ply, pos, foot, sound, volume, filter)
    return OriginalFootstepFunction(ply, pos, foot, sound, volume, filter)
end
