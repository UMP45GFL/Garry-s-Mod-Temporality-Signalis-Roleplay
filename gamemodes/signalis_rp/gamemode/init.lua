
AddCSLuaFile("cl_init.lua")
DeriveGamemode("helix")

function GM:PlayerFootstep(ply, pos, foot, sound, volume, filter)
    return true
end

