
DeriveGamemode("helix")

net.Receive("updatebattery", function(len)
	local int_got = net.ReadInt(8)
	local int2_got = net.ReadInt(4)
	local wep = LocalPlayer():GetActiveWeapon()
	for k,v in pairs(LocalPlayer():GetWeapons()) do
		if v.Slot == int2_got then
			wep.BatteryLevel = int_got
		end
	end
end)

function GM:PlayerFootstep(ply, pos, foot, sound, volume, filter)
    return true
end
