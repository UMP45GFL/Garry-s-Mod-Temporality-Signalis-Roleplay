
function Schema:CanPlayerUseBusiness(client, uniqueID)
	if (client:Team() == FACTION_GESTALT or client:Team() == FACTION_REPLIKA) then
		local itemTable = ix.item.list[uniqueID]

		if (itemTable) then
			if (itemTable.permit) then
				local character = client:GetCharacter()
				local inventory = character:GetInventory()

				if (!inventory:HasItem("permit_"..itemTable.permit)) then
					return false
				end
			elseif (itemTable.base ~= "base_permit") then
				return false
			end
		end
	end
end

function Schema:CanDrive()
	return false
end

/*
local function GetDefaultCharacterName(className)
	local class = ix.class.GetClass(className)

	if not class or not class.shortName then
		return
	end

	local facilityName = ix.config.Get("facilityShortName", nil)

	if facilityName then
		return class.shortName .. "-" .. facilityName
	end

	return class.shortName
end
*/


-- FKLR-S2301
-- lua_run print(Schema:GetNewCharacterName("replika_fklr"))
function Schema:GetNewCharacterName(className)
	local nums = {}

	local facilityName = ix.config.Get("facilityShortName", nil)
	local class = ix.class.GetClass(className)

	if not class or not class.shortName then
		print("Error in GetNewCharacterName: class not found", className)
		return
	end

	for _, char in pairs(ix.char.loaded) do
		if char.vars.class == className then
			local replikaName = class.shortName
			local charName = char.vars.name

			-- remove facility name from the character name
			if facilityName then
				charName = string.gsub(charName, facilityName, "")
			end

			-- remove replika name from the character name
			if replikaName then
				charName = string.gsub(charName, replikaName, "")
			end
			charName = string.gsub(charName, "-", "")

			local len = string.len(charName)
			for i=1, len do
				if not nums[i] then
					local ch = string.sub(charName, i, i)

					if tonumber(ch) then
						if len >= i + 1 and tonumber(string.sub(charName, i + 1, i + 1)) then
							local num = tonumber(ch..string.sub(charName, i + 1, i + 1))
							nums[i + 1] = num
						else
							nums[i] = tonumber(ch)
						end
					end
				end
			end
		end
	end

	-- find the first available number
	local freeNum = 1
	for i=1, 100 do
		if not table.HasValue(nums, i) then
			freeNum = i
			break
		end
	end

	local num = string.format("%02d", freeNum)

	return class.shortName .. "-" .. facilityName .. num
end

function Schema:GetDefaultCharacterName(client, faction, class)
	class = tonumber(class)

	if class and ix.class.list[class] then
		/*
		local name = GetDefaultCharacterName(ix.class.list[class].uniqueID)
		if name then
			return name, !client:IsAdmin()
		end
		*/
		local name = self:GetNewCharacterName(ix.class.list[class].uniqueID)
		if name then
			return name, !client:IsAdmin()
		end
	else
		print("Error in GetDefaultCharacterName: class not found", class)
	end
end

function Schema:ValidateCharacterName(name, client, class)
	if class then
		local defaultName = GetDefaultCharacterName(ix.class.list[class].uniqueID)

		if defaultName and !string.find(name, defaultName) then
			return true
		end
	end
end
