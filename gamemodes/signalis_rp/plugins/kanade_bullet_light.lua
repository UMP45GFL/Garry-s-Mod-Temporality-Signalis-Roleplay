
PLUGIN.name = "Bullet light"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds bullet lights."
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	bulletLightEnabled = "Enable bullet light",
})

ix.config.Add("bulletLightEnabled", true, "Whether or to enable bullet light.", nil, {
	category = "Kanade"
})

ix.config.Add("bulletLightRed", 255, "Red color of the bullet light.", nil, {
	data = {min = 0, max = 255},
	category = "Kanade"
})
ix.config.Add("bulletLightGreen", 225, "Green color of the bullet light.", nil, {
	data = {min = 0, max = 255},
	category = "Kanade"
})
ix.config.Add("bulletLightBlue", 150, "Blue color of the bullet light.", nil, {
	data = {min = 0, max = 255},
	category = "Kanade"
})

ix.config.Add("bulletLightRange", 50, "Bullet light range.", nil, {
	data = {min = 5, max = 200},
	category = "Kanade"
})

if SERVER then
	hook.Add("EntityFireBullets", "Kanade_BulletLight_EntityFireBullets", function(Entity, Other)
		if IsValid(Entity) and ix.config.Get("bulletLightEnabled", true) then
			local Trace = {}
			Trace.start = Other.Src
			Trace.endpos = Other.Src + (Other.Dir * 2147483647)
			Trace.filter = Entity

			local Result = util.TraceLine(Trace)
			if Result.Hit then
				local FireLight = ents.Create("light_dynamic")
				FireLight:SetKeyValue("distance", ix.config.Get("bulletLightRange", 50))
				FireLight:SetKeyValue("_light", ix.config.Get("bulletLightRed", 255) .. " " .. ix.config.Get("bulletLightGreen", 225) .. " " .. ix.config.Get("bulletLightBlue", 150))
				FireLight:SetPos(Result.HitPos)
				FireLight:Spawn()
				FireLight:Fire("Kill", "", 0.05)
			end
		end
	end)
end

-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=3175942640
-- Creator: https://steamcommunity.com/id/Dishings
