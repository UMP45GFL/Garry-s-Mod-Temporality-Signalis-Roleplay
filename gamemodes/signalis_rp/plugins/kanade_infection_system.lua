
PLUGIN.name = "Infection system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds infections."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	infectionSystemEnabled = "Enable the infection system",
})

ix.config.Add("infectionSystemEnabled", true, "Enable the infection system", nil, {
	category = "Kanade"
})

if SERVER then
	local player_meta = FindMetaTable("Player")

	util.AddNetworkString("update_infection")

	function player_meta:GetInfected(pl)
		self.next_iup2 = CurTime() + math.random(15,35)
		self.isInfected = true
		print(self:Nick() .. " got infected by " .. pl:Nick())
		PrintMessage(HUD_PRINTTALK, self:Nick() .. " got infected by " .. pl:Nick())
	end
	
	function player_meta:InfectiousTouch()
		if math.random(1,4) == 2 then
			local possibles = {}

			for k,v in pairs(player.GetAll()) do
				if v:Alive() and v:Team() != TEAM_SPECTATOR and !v.isInfected and math.random(1,3) == 2 then
					local tr = util.TraceLine({
						start = self:EyePos(),
						endpos = v:GetPos(),
						filter = self
					})
					if v:GetPos():Distance(self:GetPos()) < 80 and tr.Entity == v then
						table.ForceInsert(possibles, v)
					end
				end
			end

			if table.Count(possibles) > 0 then
				table.Random(possibles):GetInfected(self)
			end
		end
	end
	
	function player_meta:InfectiousCough()
		local closest_player = nil

		for k,v in pairs(player.GetAll()) do
			if v:Alive() and v:Team() != TEAM_SPECTATOR and !v.isInfected then
				local ipos = self:GetShootPos() + (self:EyeAngles():Forward() * 10)
				local idis = v:GetPos():Distance(ipos)

				if math.random(1,100) < 80 and idis < 90 then
					if closest_player == nil or closest_player[2] > idis then
						closest_player = {v, idis}
					end
				end
			end
		end

		if closest_player then
			closest_player[1]:GetInfected(self)
		end
	end

	function HandleInfection()
		if !(ix.config.Get("infectionSystemEnabled", true)) then return end

		for k,v in pairs(player.GetAll()) do
			if v:Alive() and v:Team() != TEAM_SPECTATOR and v.isInfected then
				if v.next_iup1 == nil then
					v.next_iup1 = 0
					v.next_iup2 = 0
					v.infectionProgress = 0
					v.asymptomatic = false
					v.nextInfectionUpdate = 0
				end

				if v.next_iup1 < CurTime() then
					v.next_iup1 = CurTime() + math.random(2,3)
					
					if !has_hazmat then
						v:InfectiousTouch()
					end

					v.infectionProgress = math.Clamp(v.infectionProgress + 1, 0, 100)
				end

				if !v.asymptomatic and v.next_iup2 < CurTime() then

					if v.infectionProgress < 10 then
						v.next_iup2 = CurTime() + math.random(18, 42)

					elseif v.infectionProgress < 25 then
						v.next_iup2 = CurTime() + math.random(14, 37)

					elseif v.infectionProgress < 50 then
						v.next_iup2 = CurTime() + math.random(12, 34)

					elseif v.infectionProgress < 75 then
						v.next_iup2 = CurTime() + math.random(10, 28)

					else
						v.next_iup2 = CurTime() + math.random(7, 26)
					end

					/*
					TODO: Coughing sounds
					if has_gasmask then
						v:EmitSound("breach2/D9341/Cough"..math.random(1,3).."_gasmask.ogg")
					else
						v:EmitSound("breach2/D9341/Cough"..math.random(1,3)..".ogg")
						if v.br_infection > 15 then
							v:InfectiousCough()
						end
					end
					*/

					if v.nextInfectionUpdate < CurTime() then
						v.nextInfectionUpdate = CurTime() + 1
						net.Start("update_infection")
							net.WriteInt(v.infectionProgress, 16)
						net.Send(v)
					end
				end
			end
		end
	end
	hook.Add("Think", "HandleInfection", HandleInfection)
end

if CLIENT then
	BR_OUR_INFECTION = 0

	net.Receive("update_infection", function(len)
		BR_OUR_INFECTION = net.ReadInt(16)
	end)

	if ix.config.Get("infectionSystemEnabled", true) then
		ix.bar.Add(function()
			return BR_OUR_INFECTION / 200
		end, Color(40, 150, 18), nil, "infection")
	end
end
