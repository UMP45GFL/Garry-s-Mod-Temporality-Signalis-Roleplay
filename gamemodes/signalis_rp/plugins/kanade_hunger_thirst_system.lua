
PLUGIN.name = "Hunger & Thirst system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds hunger & thirst."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	hungerThirstSystemEnabled = "Enable hunger & thirst system",
})

ix.config.Add("hungerThirstSystemEnabled", true, "Enable the hunger & thirst system", nil, {
	category = "Hunger And Thirst"
})

ix.config.Add("hungerThirstSystemMaxHunger", 125, "Amount of max hunger a player can have", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})

ix.config.Add("hungerThirstSystemMaxThirst", 125, "Amount of max hunger a player can have", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})

local player_meta = FindMetaTable("Player")

function player_meta:GetMaxHunger()
	return ix.config.Get("hungerThirstSystemMaxHunger", 125)
end

function player_meta:GetMaxThirst()
	return ix.config.Get("hungerThirstSystemMaxThirst", 125)
end

if SERVER then
	util.AddNetworkString("update_hunger")

	function player_meta:AddHunger(amount)
		self.hunger = math.Clamp(self.hunger - amount, 0, self:GetMaxHunger())
	end
	
	function player_meta:AddThirst(amount)
		self.thirst = math.Clamp(self.thirst - amount, 0, self:GetMaxThirst())
	end
	
	function player_meta:ResetHungerAndThirst()
		self.hunger = 125
		self.thirst = 125
	end

	function HandleHungerAndThirst()
		if !ix.config.Get("hungerThirstSystemEnabled", true) then return end

		for k,v in pairs(player.GetAll()) do
			if v and  IsValid(v) and v:Alive() and v:Team() != TEAM_SPECTATOR and v:Team() != FACTION_STAFF and v:Team() != FACTION_ADMIN then
				if v.hunger == nil then continue end

				if v.nextHungerCheck == nil then
					v.nextHungerCheck = CurTime() + math.random(16, 38)
					v.nextHungerUpdate = CurTime() + 1
					v.nextThirstCheck = CurTime() + math.random(12, 23)
				end
	
				if v.nextHungerCheck < CurTime() then
					v.nextHungerCheck = CurTime() + math.random(16, 38)

					v.hunger = v.hunger - 1

					/*
					if v.hunger < 25 then
						v:SetHealth(v:Health() - 2)

					elseif v.hunger < 50 then
						v:SetHealth(v:Health() - 1)
					end
					*/

					if v.hunger == 49 then
						v:PrintMessage(HUD_PRINTTALK, "You are getting hungry...")

					elseif v.hunger == 24 then
						v:PrintMessage(HUD_PRINTTALK, "You are getting very hungry...")
					end
					if v:Health() < 1 then
						local fdmginfo = DamageInfo()
						fdmginfo:SetDamage(20)
						fdmginfo:SetAttacker(v)
						fdmginfo:SetDamageType(DMG_CLUB)
						v:TakeDamageInfo(fdmginfo)
					end
				end

				if v.nextThirstCheck < CurTime() then
					v.nextThirstCheck = CurTime() + math.random(12, 23)

					v.thirst = v.thirst - 1

					if v.thirst < 25 then
						v:SetHealth(v:Health() - 2)

					elseif v.thirst < 50 then
						v:SetHealth(v:Health() - 1)
					end

					if v.thirst == 49 then
						v:PrintMessage(HUD_PRINTTALK, "You are getting thirsty...")
						
					elseif v.thirst == 24 then
						v:PrintMessage(HUD_PRINTTALK, "You are getting very thirsty...")
					end

					if v:Health() < 1 then
						local fdmginfo = DamageInfo()
						if IsValid(v) and IsValid(fdmginfo) then
							fdmginfo:SetDamage(20)
							fdmginfo:SetAttacker(v)
							fdmginfo:SetDamageType(DMG_ENERGYBEAM)
							v:TakeDamageInfo(fdmginfo)
						end
					end
				end

				if v.nextHungerUpdate < CurTime() then
					net.Start("update_hunger")
						net.WriteInt(v.hunger, 16)
						net.WriteInt(v.thirst, 16)
					net.Send(v)
					v.nextHungerUpdate = CurTime() + 1
				end
			end
		end
	end
	hook.Add("Tick", "HandleHungerAndThirst", HandleHungerAndThirst)
end

if CLIENT then
	our_hunger = 125
	our_thirst = 125

	net.Receive("update_hunger", function(len)
		our_hunger = net.ReadInt(16)
		our_thirst = net.ReadInt(16)
	end)

	ix.bar.Add(function()
		return our_hunger / LocalPlayer():GetMaxHunger()
	end, Color(59, 194, 25), nil, "hunger")

	ix.bar.Add(function()
		return our_thirst / LocalPlayer():GetMaxThirst()
	end, Color(24, 192, 214), nil, "thirst")
end
