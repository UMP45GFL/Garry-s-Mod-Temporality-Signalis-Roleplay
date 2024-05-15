
PLUGIN.name = "Sonic cracks"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds audible sonic cracks to gunshots."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	sonic_cracks = "Sonic cracks",

	optSonicCracksEnabled = "Enable sonic cracks",
})

if CLIENT then
	ix.option.Add("sonicCracksEnabled", ix.type.bool, true, {
		category = "Kanade"
	})
end

ix.config.Add("sonicCracksEnabled", true, "Whether or to adds audible sonic cracks to gunshots.", nil, {
	category = "Kanade"
})

sound.Add(
	{
		name = "sonic_Crack.Light",
		channel = CHAN_ITEM,
		volume = 1.0,
		level = 80,
		sound = {
			"cracks/light/light_crack_01.ogg",
			"cracks/light/light_crack_02.ogg",
			"cracks/light/light_crack_03.ogg",
			"cracks/light/light_crack_04.ogg",
			"cracks/light/light_crack_05.ogg",
			"cracks/light/light_crack_06.ogg",
			"cracks/light/light_crack_06.ogg",
			"cracks/light/light_crack_07.ogg",
			"cracks/light/light_crack_08.ogg",
			"cracks/light/light_crack_09.ogg"
		}
	}
)

sound.Add(
	{
		name = "sonic_Crack.Medium",
		channel = CHAN_ITEM,
		volume = 1.0,
		level = 80,
		sound = {
			"cracks/medium/med_crack_01.ogg",
			"cracks/medium/med_crack_02.ogg",
			"cracks/medium/med_crack_03.ogg",
			"cracks/medium/med_crack_04.ogg",
			"cracks/medium/med_crack_05.ogg",
			"cracks/medium/med_crack_06.ogg",
			"cracks/medium/med_crack_06.ogg",
			"cracks/medium/med_crack_07.ogg",
			"cracks/medium/med_crack_08.ogg",
			"cracks/medium/med_crack_09.ogg"
		}
	}
)

sound.Add(
	{
		name = "sonic_Crack.Heavy",
		channel = CHAN_ITEM,
		volume = 1.0,
		level = 80,
		sound = {
			"cracks/heavy/heav_crack_01.ogg",
			"cracks/heavy/heav_crack_02.ogg",
			"cracks/heavy/heav_crack_03.ogg",
			"cracks/heavy/heav_crack_04.ogg",
			"cracks/heavy/heav_crack_05.ogg",
			"cracks/heavy/heav_crack_06.ogg",
			"cracks/heavy/heav_crack_06.ogg",
			"cracks/heavy/heav_crack_07.ogg",
			"cracks/heavy/heav_crack_08.ogg",
			"cracks/heavy/heav_crack_09.ogg"
		}

	}
)

sound.Add(
	{
		name = "sonic_Crack.Distant",
		channel = CHAN_ITEM,
		volume = 1.0,
		level = 150,
		pitch = {100, 0},
		sound = {
			"cracks/distant/dist_crack_01.ogg",
			"cracks/distant/dist_crack_02.ogg",
			"cracks/distant/dist_crack_03.ogg",
			"cracks/distant/dist_crack_04.ogg",
			"cracks/distant/dist_crack_05.ogg",
			"cracks/distant/dist_crack_06.ogg",
			"cracks/distant/dist_crack_06.ogg",
			"cracks/distant/dist_crack_07.ogg",
			"cracks/distant/dist_crack_08.ogg",
			"cracks/distant/dist_crack_09.ogg",
			"cracks/distant/dist_crack_10.ogg",
			"cracks/distant/dist_crack_11.ogg",
			"cracks/distant/dist_crack_12.ogg",
			"cracks/distant/dist_crack_13.ogg",
			"cracks/distant/dist_crack_14.ogg",
			"cracks/distant/dist_crack_15.ogg",
			"cracks/distant/dist_crack_16.ogg",
			"cracks/distant/dist_crack_17.ogg"
		}
	}
)

if SERVER then
	util.AddNetworkString("soniccracks")
	util.AddNetworkString("soniccracks_dist")

	Ammotype = {}
	Ammotype["Pistol"] = "sonic_Crack.Light"
	Ammotype["357"] = "sonic_Crack.Light"
	Ammotype["SMG1"] = "sonic_Crack.Medium"
	Ammotype["Buckshot"] = "sonic_Crack.Medium"
	Ammotype["AR2"] = "sonic_Crack.Heavy"
	Ammotype["HelicopterGun"] = "sonic_Crack.Heavy"
	Ammotype["SniperRound"] = "sonic_Crack.Heavy"
	Ammotype["SniperPenetratedRound"] = "sonic_Crack.Heavy"
	Ammotype["AirboatGun"] = "sonic_Crack.Heavy"
	Ammotype["StriderMinigun"] = "sonic_Crack.Heavy"

	local range_Theshold = 256

	function GetTrace_sv(ent)
		if !IsValid(ent) then return end

		local Trace
		local BIGNUMBER = 1000000

		if ent:IsNPC() or ent:IsPlayer() then
			Trace = util.TraceLine({
				start = ent:GetShootPos(),
				endpos = ent:GetAimVector() * BIGNUMBER,
				filter = ent,
				mask = 33579137
			})

		else
			Trace = util.TraceLine({
				start = ent:GetPos(),
				endpos = ent:GetAngles():Forward() * BIGNUMBER,
				filter = ent,
				mask = 33579137
			})
		end

		return Trace

	end

	function InRange_sv(ent, ply)
		local Trace = GetTrace_sv(ent)
		local DistanceFromLine = util.DistanceToLine(Trace.StartPos, Trace.HitPos, ply:GetShootPos())
		local DistanceFromEnt = ply:GetPos():Distance(ent:GetPos())

		if (DistanceFromLine <= range_Theshold) then
			if (ply != ent) then
				if (DistanceFromEnt >= range_Theshold) then
					return true
				end
			end
		else
			return false
		end
	end

	function IsNotBehindWall_sv(ent, ply)
		local Trace
		if ent:IsNPC() or ent:IsPlayer() then
			Trace = util.TraceLine({
				start = ent:GetShootPos(),
				endpos = ply:GetShootPos(),
				filter = ent,
				mask = 16395
			})

		else
			Trace = util.TraceLine({
				start = ent:GetPos(),
				endpos = ply:GetShootPos(),
				filter = ent,
				mask = 16395
			})
		end

		return (Trace.Fraction == 1)
	end

	function Talk_sv(ent, data)
		if !(ix.config.Get("sonicCracksEnabled", true)) then return end

		for k, v in pairs(player.GetAll()) do
			local Trace = GetTrace_sv(ent)
			local DistanceFromLine, LinePos = util.DistanceToLine(Trace.StartPos, Trace.HitPos, v:GetShootPos())
			local bulletCrack

			for k, v in pairs(Ammotype) do
				if (data.AmmoType == k) then
					bulletCrack = v
				else
					bulletCrack = "sonic_Crack.Light"
				end
			end

			for i = 1, data.Num do
				if InRange_sv(ent, v) then
					net.Start("soniccracks")
						if (IsNotBehindWall_sv(ent, v)) then
							net.WriteString(bulletCrack)
							net.WriteVector(LinePos)
							--v:ViewPunch(Angle(math.random(-0.1, 0.1), math.random(-0.1, 0.1), math.random(-0.1, 0.1)))
						else
							net.WriteString(bulletCrack)
							net.WriteVector(LinePos)
						end
					net.Send(v)

				elseif not InRange_sv(ent, v) then
					if (DistanceFromLine >= range_Theshold) then
						if (v != ent) then
							net.Start("soniccracks_dist")
								net.WriteString("sonic_Crack.Distant")
								net.WriteVector(LinePos)
							net.Send(v)
						end
					end
				end
			end
		end
	end
	hook.Add("EntityFireBullets", "sc.FireBullets", Talk_sv)

elseif CLIENT then
	function soniccracks_cl(len, pl)
		if !(ix.option.Get("sonicCracksEnabled", true)) then return end
		local receivedString = net.ReadString()
		local receivedVect = net.ReadVector()

		if receivedVect then
			sound.Play(receivedString, receivedVect)
		else
			sound.Play(receivedString, LocalPlayer():GetPos())
		end
	end
	net.Receive("soniccracks", soniccracks_cl)

	function soniccracks_dist_cl(len, pl)
		if !(ix.option.Get("sonicCracksEnabled", true)) then return end
		local receivedString = net.ReadString()
		local receivedVect = net.ReadVector()

		if receivedVect then
			sound.Play(receivedString, receivedVect)
		end
	end
	net.Receive("soniccracks_dist", soniccracks_dist_cl)
end

-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=3175942640
-- Creator: https://steamcommunity.com/id/Dishings
