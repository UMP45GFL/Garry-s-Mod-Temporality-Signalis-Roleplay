
PLUGIN.name = "Max replika per session system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Limits the amount of replikas of certain class for a session."
PLUGIN.license = [[meow]]

ix.config.Add("MaxReplikaPerSessionEnabled", true, "Whether or to limit the amount of replikas per session.", nil, {
	category = "Max Replika Per Session"
})

function CreateMaxReplikaPerSessionConfigs()
	for k,v in pairs(ix.class.list) do
		if v.faction == FACTION_REPLIKA and v.shortName then
			print("Creating config for "..v.shortName)
			ix.config.Add("Max"..v.shortName.." PerSession", 5, "The maximum amount of "..v.name.." replikas per session.", nil, {
				category = "Max Replika Per Session",
				data = {min = 0, max = 20},
			})
		end
	end
end

function NumOfReplika(className)
	local num = 0
	for k,v in pairs(player.GetAll()) do
		local character = v:GetCharacter()
		if character and character.vars.class == className then
			num = num + 1
		end
	end
	return num
end

function PLUGIN:CanPlayerUseCharacter(client, character)
	if not ix.config.Get("MaxReplikaPerSessionEnabled", true) then
		return
	end

	local class = ix.class.GetClass(character.vars.class)
	if class and class.faction == FACTION_REPLIKA and class.shortName then
		local max = ix.config.Get("Max"..class.shortName.." PerSession", 5)
		if NumOfReplika(character.vars.class) >= max then
			return false, "You can't have more than "..max.." "..class.name.." replikas per session."
		end
	end
end

hook.Add("InitPostEntity", "MaxReplikaPerSessionSystem_InitPostEntity", function()
	CreateMaxReplikaPerSessionConfigs()
end)
