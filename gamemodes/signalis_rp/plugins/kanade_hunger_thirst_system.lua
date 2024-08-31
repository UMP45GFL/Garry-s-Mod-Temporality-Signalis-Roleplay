
PLUGIN.name = "Hunger & Thirst system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds hunger & thirst."
PLUGIN.license = [[meow]]

local HUNGER_DECAY_SPEED = 22
local HUNGER_DECAY_AMOUNT = 1
local MAX_HUNGER = 250
local HUNGRY = 175
local VERY_HUNGRY = 100
local TOO_HUNGRY = 25

local THIRST_DECAY_SPEED = 17
local THIRST_DECAY_AMOUNT = 1
local MAX_THIRST = 200
local THIRSTY = 100
local TOO_THIRSTY = 25

ix.config.Add("hungerThirstSystemEnabled", true, "Enable the hunger & thirst system", nil, {
	category = "Hunger And Thirst"
})

ix.config.Add("Hunger decay speed", HUNGER_DECAY_SPEED, "How fast hunger decays (in seconds)", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("Hunger decay amount", HUNGER_DECAY_AMOUNT, "How much hunger decays", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("Max hunger", MAX_HUNGER, "Amount of max hunger a player can have", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("Hungry", HUNGRY, "Amount of hunger to consider the player being hungry", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("Very hungry", VERY_HUNGRY, "Amount of hunger to consider the player being very hungry", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("Too hungry", TOO_HUNGRY, "Amount of hunger to consider the player being too hungry", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})

ix.config.Add("Thirst decay speed", THIRST_DECAY_SPEED, "How fast thirst decays (in seconds)", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("Thirst decay amount", THIRST_DECAY_AMOUNT, "How much thirst decays", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("Max thirst", MAX_THIRST, "Amount of max hunger a player can have", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("Thirsty", THIRSTY, "Amount of thirst to consider the player being thirsty", nil, {
	data = {min = 1, max = 1000},
	category = "Hunger And Thirst"
})
ix.config.Add("Too thirsty", TOO_THIRSTY, "Amount of thirst to consider the player being too thirsty", nil, {
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

	local function niceTime(seconds)
		local minutes = math.floor(seconds / 60)
		local hours = math.floor(minutes / 60)
		local days = math.floor(hours / 24)

		if days > 0 then
			return days .. " days, " .. hours % 24 .. " hours, " .. minutes % 60 .. " minutes, " .. seconds % 60 .. " seconds"
		elseif hours > 0 then
			return hours .. " hours, " .. minutes % 60 .. " minutes, " .. seconds % 60 .. " seconds"
		elseif minutes > 0 then
			return minutes .. " minutes, " .. seconds % 60 .. " seconds"
		else
			return seconds .. " seconds"
		end
	end

	-- lua_run SanityCheckHungerAndThirstSystem()
	function SanityCheckHungerAndThirstSystem()
		local hungerDecaySpeed = ix.config.Get("Hunger decay speed", HUNGER_DECAY_SPEED)
		local hungerDecayAmount = ix.config.Get("Hunger decay amount", HUNGER_DECAY_AMOUNT)
		local hungry = ix.config.Get("Hungry", HUNGRY)
		local veryHungry = ix.config.Get("Very hungry", VERY_HUNGRY)
		local tooHungry = ix.config.Get("Too hungry", TOO_HUNGRY)
		local maxHunger = ix.config.Get("Max hunger", MAX_HUNGER)
		/*
		print("max hunger: " .. maxHunger)
		print("hunger decay speed: " .. hungerDecaySpeed)
		print("hunger decay amount: " .. hungerDecayAmount)
		print("hungry: " .. hungry)
		print("very hungry: " .. veryHungry)
		print("too hungry: " .. tooHungry)
		*/

		print("Time to be hungry: " .. niceTime( ((maxHunger - hungry) / hungerDecayAmount) * hungerDecaySpeed ) .. ".")
		print("Time to be very hungry: " .. niceTime( ((maxHunger - veryHungry) / hungerDecayAmount) * hungerDecaySpeed ) .. ".")
		print("Time to be too hungry: " ..  niceTime( ((maxHunger - tooHungry) / hungerDecayAmount) * hungerDecaySpeed ) .. ".")
		print("Time to lose all hunger: " .. niceTime( (maxHunger / hungerDecayAmount) * hungerDecaySpeed ) .. ".")

		local thirstDecaySpeed = ix.config.Get("Thirst decay speed", THIRST_DECAY_SPEED)
		local thirstDecayAmount = ix.config.Get("Thirst decay amount", THIRST_DECAY_AMOUNT)
		local maxThirst = ix.config.Get("Max thirst", MAX_THIRST)
		local thirsty = ix.config.Get("Thirsty", THIRSTY)
		local tooThirsty = ix.config.Get("Too thirsty", TOO_THIRSTY)
		
		print("")
		print("Time to be thirsty: " .. niceTime( ((maxThirst - thirsty) / thirstDecayAmount) * thirstDecaySpeed ) .. ".")
		print("Time to be too thirsty: " .. niceTime( ((maxThirst - tooThirsty) / thirstDecayAmount) * thirstDecaySpeed ) .. ".")
		print("Time to lose all thirst: " .. niceTime( (maxThirst / thirstDecayAmount) * thirstDecaySpeed ) .. ".")
	end

	function HandleHungerAndThirst()
		if !ix.config.Get("hungerThirstSystemEnabled", true) then return end

		for k,v in pairs(player.GetAll()) do
			if v and IsValid(v) and v:Alive() and v:Team() != TEAM_SPECTATOR and v:Team() != FACTION_STAFF and v:Team() != FACTION_ADMIN then
				if v.hunger == nil then continue end

				if v.nextHungerCheck == nil then
					v.nextHungerCheck = CurTime() + ix.config.Get("Hunger decay speed", HUNGER_DECAY_SPEED) + math.random(-2, 5)
					v.nextHungerUpdate = CurTime() + 1
					v.nextThirstCheck = CurTime() + ix.config.Get("Thirst decay speed", THIRST_DECAY_SPEED) + math.random(-2, 5)
				end
	
				if v.nextHungerCheck < CurTime() then
					v.nextHungerCheck = CurTime() + ix.config.Get("Hunger decay speed", HUNGER_DECAY_SPEED) + math.random(-2, 5)

					if v.hunger < ix.config.Get("Too Hungry", TOO_HUNGRY) then
						v:SetHealth(v:Health() - 1)
					end

					if v.hunger == ix.config.Get("Hungry", HUNGRY) then
						v:PrintMessage(HUD_PRINTTALK, "You are getting hungry...")

					elseif v.hunger == ix.config.Get("Very hungry", VERY_HUNGRY) then
						v:PrintMessage(HUD_PRINTTALK, "You are getting very hungry...")

					elseif v.hunger == ix.config.Get("Too hungry", TOO_HUNGRY) then
						v:PrintMessage(HUD_PRINTTALK, "Your stomach hurts...")
					end

					-- kill when hp low
					if v:Health() < 2 then
						local fdmginfo = DamageInfo()
						fdmginfo:SetDamage(20)
						fdmginfo:SetAttacker(v)
						fdmginfo:SetDamageType(DMG_CLUB)
						v:TakeDamageInfo(fdmginfo)
					end

					v.hunger = v.hunger - ix.config.Get("Hunger decay amount", HUNGER_DECAY_AMOUNT)
				end

				if v.nextThirstCheck < CurTime() then
					v.nextThirstCheck = CurTime() + ix.config.Get("Thirst decay speed", THIRST_DECAY_SPEED) + math.random(-2, 5)

					if v.thirst <= ix.config.Get("Too thirsty", TOO_THIRSTY) then
						v:SetHealth(v:Health() - 1)
					end

					if v.thirst == ix.config.Get("Thirsty", THIRSTY) then
						v:PrintMessage(HUD_PRINTTALK, "You are getting thirsty...")
						
					elseif v.thirst == ix.config.Get("Too thirsty", TOO_THIRSTY) then
						v:PrintMessage(HUD_PRINTTALK, "You are getting very thirsty...")
					end

					if v:Health() < 2 then
						local fdmginfo = DamageInfo()
						if IsValid(v) and IsValid(fdmginfo) then
							fdmginfo:SetDamage(20)
							fdmginfo:SetAttacker(v)
							fdmginfo:SetDamageType(DMG_ENERGYBEAM)
							v:TakeDamageInfo(fdmginfo)
						end
					end

					v.thirst = v.thirst - ix.config.Get("Thirst decay amount", THIRST_DECAY_AMOUNT)
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



/*
local MAX_HUNGER = 250
local HUNGRY = 175
local VERY_HUNGRY = 100
local TOO_HUNGRY = 25

local MAX_THIRST = 200
local THIRSTY = 100
local TOO_THIRSTY = 25

great foods:
meat_cooked (very big chunk of meat) 200
burger_big 95
ration_k4 1200kj 70
chicken_wrap 70
burger_small 70
sandwich 65
ration_f99 900kj 65
ration_c 800kj 60
steak_cooked (normal sized steak) 60

good foods:
chicken_leg_cooked 40
ration_s 400kj 40
bread 40
cheese 40
melon 30
fish_steak 25
bacon_cooked 25
toast 25

melon_slice 15
corn 15
bellpepper 15
orange 15
tomato 15
bread_slice 10
cheese_slice 10

meh foods:
lettuce 5

raw foods (bad):
steak_raw 25
meat_raw 90
bacon_raw 13
fish_bass_raw 30
*/
