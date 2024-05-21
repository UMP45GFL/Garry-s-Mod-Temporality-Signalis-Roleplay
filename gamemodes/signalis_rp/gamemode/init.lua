
AddCSLuaFile("cl_init.lua")
DeriveGamemode("helix")

util.AddNetworkString("updatebattery")

function GM:PlayerFootstep(ply, pos, foot, sound, volume, filter)
    return true
end

