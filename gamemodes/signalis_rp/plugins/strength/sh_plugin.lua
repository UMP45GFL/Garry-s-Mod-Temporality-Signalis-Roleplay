PLUGIN.name = "Strength"
PLUGIN.author = "Chessnut/UMP45"
PLUGIN.description = "Adds a strength attribute, and makes it affect carryweight."

if (SERVER) then
	function PLUGIN:GetPlayerPunchDamage(client, damage, context)
		local character = client:GetCharacter()
		if (not character) then
			return
		end
		local strength = character:GetAttribute("str", 0)
		if (client:GetCharacter()) then
			-- Add to the total fist damage.
			context.damage = context.damage + strength * ix.config.Get("strengthMultiplier", 0.3)
		end
	end

	function PLUGIN:PlayerThrowPunch(client, trace)
		if (client:GetCharacter() and IsValid(trace.Entity) and trace.Entity:IsPlayer()) then
			client:GetCharacter():UpdateAttrib("str", 0.001)
		end
	end
	
	--takes strength attribute number and divides it by 6 
	--then rounds it and adds it to the weight limit
	--code for this can be found in the weight plugin code
	--too lazy to figure out how to code it into this
	
	--base = (base + class.add_max_weight) + (math.floor(strength / 6))
	
	--gets inventory width/height, then divides it by 20,
	--rounds it down to its lowest possible number (5.99 = 5)
	--ex: 60 strength = 3 extra rows
	--insane right? could make it lower but that might too little reward

  
  	--DOESNT WORK, leaving for archival purposes
	--[[function PLUGIN:GetInventoryHeight()
		local h = ix.config.Get("inventoryHeight")

		local character = client:GetCharacter()
		if (not character) then return end

		local strength = character:GetAttribute("str", 0)
		local strvalueinventory = (math.floor(strength / 20))
		--checks if strength should affect inventory rows
		if ix.config.Get("strengthAffectsInventoryRows") == 1 then
			if (class and class.add_inventory_height) then
				h = (h + class.add_inventory_height) + strvalueinventory
			end
		end

		return h
	end
	
	function PLUGIN:GetInventoryWidth()
		local w = ix.config.Get("inventoryWidth")

		local character = client:GetCharacter()
		if (not character) then return end

		local strength = character:GetAttribute("str", 0)
		local strvalueinventory = (math.floor(strength / 20))
		if ix.config.Get("strengthAffectsInventoryRows") == 1 then
			if (class and class.add_inventory_width) then
				w = (w + class.add_inventory_width) + strvalueinventory
			end
		end

		return w
	end--]]
	
end

-- Configuration for the plugin
ix.config.Add("strengthMultiplier", 0.3, "How much strength multiplies Punch damage", nil, {
	data = {min = 0, max = 1.0, decimals = 1},
	category = "Strength"
})

ix.config.Add("strengthAffectsInventoryRows", 1, "If strength should affect inventory rows", nil, {
	data = {min = 0, max = 1, decimals = 0},
	category = "Strength"
})
