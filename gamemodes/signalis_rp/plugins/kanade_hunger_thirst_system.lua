
PLUGIN.name = "Hunger & Thirst system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds hunger & thirst."
PLUGIN.license = [[meow]]

local MAX_HUNGER = 250
local HUNGRY = 175
local VERY_HUNGRY = 100
local TOO_HUNGRY = 25

local MAX_THIRST = 200
local THIRSTY = 100
local TOO_THIRSTY = 25

ix.config.Add("hungerThirstSystemEnabled", true, "Enable the hunger & thirst system", nil, {
	category = "Hunger And Thirst"
})

ix.config.Add("hungerThirstSystemMaxHunger", MAX_HUNGER, "Amount of max hunger a player can have", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("hungerThirstSystemHungry", HUNGRY, "Amount of hunger to consider the player being hungry", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("hungerThirstSystemVeryHungry", VERY_HUNGRY, "Amount of hunger to consider the player being very hungry", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("hungerThirstSystemTooHungry", TOO_HUNGRY, "Amount of hunger to consider the player being too hungry", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})

ix.config.Add("hungerThirstSystemMaxThirst", MAX_THIRST, "Amount of max hunger a player can have", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("hungerThirstSystemThirsty", THIRSTY, "Amount of thirst to consider the player being thirsty", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("hungerThirstSystemTooThirsty", TOO_THIRSTY, "Amount of thirst to consider the player being too thirsty", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})

local player_meta = FindMetaTable("Player")

function player_meta:GetMaxHunger()
	return ix.config.Get("hungerThirstSystemMaxHunger", MAX_HUNGER)
end

function player_meta:GetMaxThirst()
	return ix.config.Get("hungerThirstSystemMaxThirst", MAX_THIRST)
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
		self.hunger = self:GetMaxHunger()
		self.thirst = self:GetMaxThirst()
	end

	function HandleHungerAndThirst()
		if !ix.config.Get("hungerThirstSystemEnabled", true) then return end

		for k,v in pairs(player.GetAll()) do
			if v and IsValid(v) and v:Alive() and v:Team() != TEAM_SPECTATOR and v:Team() != FACTION_STAFF and v:Team() != FACTION_ADMIN then
				if v.hunger == nil then continue end

				if v.nextHungerCheck == nil then
					v.nextHungerCheck = CurTime() + math.random(16, 38)
					v.nextHungerUpdate = CurTime() + 1
					v.nextThirstCheck = CurTime() + math.random(12, 23)
				end
	
				if v.nextHungerCheck < CurTime() then
					v.nextHungerCheck = CurTime() + math.random(16, 38)

					if v.hunger < ix.config.Get("hungerThirstSystemTooHungry", TOO_HUNGRY) then
						v:SetHealth(v:Health() - 1)
					end

					if v.hunger == ix.config.Get("hungerThirstSystemHungry", HUNGRY) then
						v:PrintMessage(HUD_PRINTTALK, "You are getting hungry...")

					elseif v.hunger == ix.config.Get("hungerThirstSystemVeryHungry", VERY_HUNGRY) then
						v:PrintMessage(HUD_PRINTTALK, "You are getting very hungry...")

					elseif v.hunger == ix.config.Get("hungerThirstSystemTooHungry", TOO_HUNGRY) then
						v:PrintMessage(HUD_PRINTTALK, "Your stomach hurts...")
					end

					if v:Health() < 1 then
						local fdmginfo = DamageInfo()
						fdmginfo:SetDamage(20)
						fdmginfo:SetAttacker(v)
						fdmginfo:SetDamageType(DMG_CLUB)
						v:TakeDamageInfo(fdmginfo)
					end

					v.hunger = v.hunger - 1
				end

				if v.nextThirstCheck < CurTime() then
					v.nextThirstCheck = CurTime() + math.random(12, 23)

					if v.thirst <= ix.config.Get("hungerThirstSystemTooThirsty", TOO_THIRSTY) then
						v:SetHealth(v:Health() - 1)
					end

					if v.thirst == ix.config.Get("hungerThirstSystemThirsty", THIRSTY) then
						v:PrintMessage(HUD_PRINTTALK, "You are getting thirsty...")
						
					elseif v.thirst == ix.config.Get("hungerThirstSystemTooThirsty", TOO_THIRSTY) then
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

					v.thirst = v.thirst - 1
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
	our_hunger = MAX_HUNGER
	our_thirst = MAX_THIRST

	net.Receive("update_hunger", function(len)
		our_hunger = net.ReadInt(16)
		our_thirst = net.ReadInt(16)
	end)

	if ix.config.Get("hungerThirstSystemEnabled", true) then
		ix.bar.Add(function()
			return our_hunger / LocalPlayer():GetMaxHunger()
		end, Color(59, 194, 25), nil, "hunger")

		ix.bar.Add(function()
			return our_thirst / LocalPlayer():GetMaxThirst()
		end, Color(24, 192, 214), nil, "thirst")
	end
end
