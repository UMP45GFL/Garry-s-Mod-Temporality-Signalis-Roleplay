
PLUGIN.name = "Sleep system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds sleeping."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	sleepSystemEnabled = "Enable the sleep system",
})

ix.config.Add("sleepSystemEnabled", true, "Enable the sleep system", nil, {
	category = "Sleeping System"
})

ix.config.Add("sleepSystemMaxSleepiness", 75, "Max sleepiness (in minutes)", nil, {
	data = {min = 10, max = 180},
	category = "Sleeping System"
})

ix.config.Add("sleepSystemSleepy", 45, "Amount of minutes of not sleeping thats considered sleepy", nil, {
	data = {min = 10, max = 180},
	category = "Sleeping System"
})

ix.config.Add("sleepSystemVerySleepy", 60, "Amount of minutes of not sleeping thats considered very sleepy", nil, {
	data = {min = 10, max = 180},
	category = "Sleeping System"
})

ix.config.Add("sleepSystemTooSleepy", 75, "Amount of minutes of not sleeping thats considered too sleepy to stay awake", nil, {
	data = {min = 10, max = 180},
	category = "Sleeping System"
})

ix.config.Add("sleepSystemFrequency", 1, "How frequently sleepiness is increased in seconds", nil, {
	data = {min = 1, max = 100},
	category = "Sleeping System"
})

local player_meta = FindMetaTable("Player")

function player_meta:GetMaxSleepiness()
	return ix.config.Get("sleepSystemMaxSleepiness", 60) * 60
end

if SERVER then
	util.AddNetworkString("update_sleepiness")

	function player_meta:AddSleepiness(amount)
		self.sleepiness = math.Clamp(self.sleepiness - amount, 0, self:GetMaxSleepiness())
	end

    function HandleSleepiness()
        if !ix.config.Get("sleepSystemEnabled", true) then return end

        for k,v in pairs(player.GetAll()) do
            if IsValid(v) and v:Alive() and v:Team() != TEAM_SPECTATOR and v:Team() != FACTION_STAFF and v:Team() != FACTION_ADMIN then
                if v.sleepiness == nil then continue end

                if v.nextSleepinessCheck == nil then
                    v.nextSleepinessCheck = CurTime() + math.random(16, 38)
                    v.nextSleepinessUpdate = CurTime() + 1
                end

                if v.nextSleepinessCheck < CurTime() then
                    v.nextSleepinessCheck = CurTime() + ix.config.Get("sleepSystemFrequency", 1)

                    v.sleepiness = v.sleepiness + 1

                    if v.sleepiness == ix.config.Get("sleepSystemSleepy", 30) * 60 then
                        v:PrintMessage(HUD_PRINTTALK, "You are getting sleepy...")

                    elseif v.sleepiness == v.sleepiness == ix.config.Get("sleepSystemVerySleepy", 45) * 60 then
                        v:PrintMessage(HUD_PRINTTALK, "You are getting very sleepy...")

                    elseif v.sleepiness == v.sleepiness == ix.config.Get("sleepSystemTooSleepy", 60) * 60 then
                        v:PrintMessage(HUD_PRINTTALK, "You are too sleepy to stay awake...")
                    end
                end

                if v.nextSleepinessUpdate < CurTime() then
                    net.Start("update_sleepiness")
                        net.WriteInt(v.sleepiness, 16)
                    net.Send(v)
                    v.nextSleepinessUpdate = CurTime() + 1
                end
            end
        end
    end
    hook.Add("Tick", "HandleSleepiness", HandleSleepiness)
end

if CLIENT then
	our_sleepiness = 0

	net.Receive("update_sleepiness", function(len)
		our_sleepiness = net.ReadInt(16)
	end)

	ix.bar.Add(function()
		return our_sleepiness / LocalPlayer():GetMaxSleepiness()
	end, Color(230, 230, 230), nil, "sleepiness")
end
