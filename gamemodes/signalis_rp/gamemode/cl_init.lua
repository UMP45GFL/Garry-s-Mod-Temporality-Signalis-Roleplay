
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

local fontSettings = {
	font = "Perfect DOS VGA 437",
	--font = "Pokémon DP Pro",
	extended = true,
	size = 32,
	weight = 0,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
}
surface.CreateFont("SignalisDocumentsFontMedium", fontSettings)
fontSettings.size = 38
surface.CreateFont("SignalisDocumentsFontBig", fontSettings)
