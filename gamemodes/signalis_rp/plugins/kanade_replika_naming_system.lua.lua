
PLUGIN.name = "Replika naming system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds a naming system to replikas"
PLUGIN.license = [[meow]]

ix.config.Add("ReplikaNamingSystemEnabled", true, "Whether to enable the replika naming system.", nil, {
    category = "Replika Naming System"
})

if SERVER then

hook.Add("OnLoadDatabaseTables", "ReplikaNamingSystem_OnLoadDatabaseTables", function()
    if not ix.config.Get("ReplikaNamingSystemEnabled", true) then
        return
    end

	query = mysql:Create("ix_replika_names")
        --query:Create("id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("class", "VARCHAR(20) NOT NULL")
		query:Create("next_number", "INT(11) UNSIGNED NOT NULL")
		query:PrimaryKey("next_number")
	query:Execute()

    for k,v in pairs(ix.class.list) do
        local query = mysql:Select("ix_replika_names")
        query:Select("next_number")
        query:Where("class", v.uniqueID)
        query:Callback(function(data)
            if not data or !istable(data) or #data == 0 then
                local insertQuery = mysql:Insert("ix_replika_names")
                insertQuery:Insert("next_number", 1)
                insertQuery:Insert("class", v.uniqueID)
                insertQuery:Execute()
            end
        end)
        query:Execute()
    end
end)

function GetNextNumberForClassFromChars(className, func, ignoreNonFacilityChars, ignoreCharTable)
    if ignoreNonFacilityChars == nil then
        ignoreNonFacilityChars = true
    end

	local query = mysql:Select("ix_characters")
	query:Select("name")
    query:Where("class", className)
	query:Callback(function(data)
		if (istable(data) and #data > 0) then
            local facilityName = ix.config.Get("facilityShortName", nil)
            local class = ix.class.GetClass(className)

            if not class or not class.shortName then
                return
            end

            local replikaName = class.shortName
            local highestNum = nil

            for i, char in ipairs(data) do
                local charName = char.name

                if ignoreCharTable and table.HasValue(ignoreCharTable, charName) then
                    continue
                end

                -- remove facility name from the character name
                if facilityName then
                    if string.find(charName, facilityName) then
                        charName = string.gsub(charName, facilityName, "")
                        
                    elseif ignoreNonFacilityChars then
                        continue
                    end
                end

                -- remove replika name from the character name
                if replikaName then
                    charName = string.gsub(charName, replikaName, "")
                end
                charName = string.gsub(charName, "-", "")

                local len = string.len(charName)
                local foundNum = false
                local numString = ""
                for i=1, len do
                    local ch = string.sub(charName, i, i)

                    if tonumber(ch) then
                        numString = numString .. ch
                        foundNum = true

                    elseif foundNum then
                        break
                    end
                end

                --print(i, char.name, charName, numString)

                local num = tonumber(numString)
                if num and (highestNum == nil or num > highestNum) then
                    highestNum = num
                end
            end

            if highestNum != nil and func then
                func(highestNum)
            end
		end
	end)
	query:Execute()
end

function UpdateNextNameNumbersFromChars()
    for k, class in pairs(ix.class.list) do
        if not class.shortName then
            continue
        end

        GetNextNumberForClassFromChars(class.uniqueID, function(highestNum)
            local updateQuery = mysql:Update("ix_replika_names")
            updateQuery:Update("next_number", highestNum + 1)
            updateQuery:Where("class", class.uniqueID)
            updateQuery:Execute()
            print("Updated next number for " .. class.uniqueID .. " to " .. highestNum + 1)
        end)
    end
end

hook.Add("OnCharacterCreated", "ReplikaNamingSystem_OnCharacterCreated", function(client, character)
    local query = mysql:Select("ix_replika_names")
    query:Select("next_number")
    query:Where("class", character.vars.class)
    query:Callback(function(data)
        if istable(data) and #data > 0 and data[1].next_number then
            local updateQuery = mysql:Update("ix_replika_names")
            updateQuery:Update("next_number", data[1].next_number + 1)
            updateQuery:Where("class", character.vars.class)
            updateQuery:Execute()
            print("Replika naming system: Updated next number for class " .. character.vars.class .. " to " .. data[1].next_number + 1)
        else
            print("Replika naming system: Next number not found for class" .. character.vars.class)
        end
    end)
    query:Execute()
end)

/*

print all replika names
lua_run query = mysql:Select("ix_replika_names") query:Select("class") query:Select("next_number") query:Callback(function(data) PrintTable(data) end) query:Execute()

print all characters
lua_run query = mysql:Select("ix_characters") query:Select("name") query:Select("class") query:Callback(function(data) for k,v in pairs(data) do print(v.name) end end) query:Execute()

lua_run GetNextNumberForClassFromChars("replika_arar")

lua_run UpdateNextNameNumbersFromChars()

lua_run GetNewCharacterName("replika_arar")

*/

function GetNewCharacterName(className, func)
	local facilityName = ix.config.Get("facilityShortName", nil)
	local class = ix.class.GetClass(className)

	if not facilityName or not class or not class.shortName then
        print("GetNewCharacterName: facilityName or class or class.shortName is nil")
		return
	end

	local query = mysql:Select("ix_replika_names")
    query:Select("next_number")
    query:Where("class", className)
    query:Callback(function(data)
        local num = 0

        if istable(data) and #data > 0 then
	        num = data[1].next_number
        else
            local insertQuery = mysql:Insert("ix_replika_names")
            insertQuery:Insert("next_number", 1)
            insertQuery:Insert("class", className)
            insertQuery:Execute()
        end

        local newName = class.shortName .. "-" .. facilityName .. string.format("%02d", num)
        if func then
            func(newName)
        end
    end)
	query:Execute()
end

end

if SERVER then
	util.AddNetworkString("getDefaultCharacterName")

	net.Receive("getDefaultCharacterName", function(len, ply)
		local faction = net.ReadString()
		local class = net.ReadString()

        local classTable = ix.class.GetClass(class)

        if classTable and classTable.shortName and classTable.faction == tonumber(faction) then
            GetNewCharacterName(class, function(newName)
                --print("GetDefaultCharacterName has given " .. newName)

                net.Start("getDefaultCharacterName")
                    net.WriteString(newName)
                    net.WriteBool(!ply:IsAdmin())
                net.Send(ply)
            end)
        end
	end)
else
	lastNamePanel = nil
	lastPayload = nil

	net.Receive("getDefaultCharacterName", function(len)
		local name = net.ReadString()
		local disabled = net.ReadBool()

		if lastNamePanel then
			lastNamePanel:SetText(name)
			lastPayload:Set("name", name)
			if disabled then
				lastNamePanel:SetDisabled(true)
				lastNamePanel:SetEditable(false)
			end
		end
	end)
end

hook.Add("GetDefaultCharacterName", "ReplikaNamingSystem_GetDefaultCharacterName", function(client, payload, value, panel)
    if not ix.config.Get("ReplikaNamingSystemEnabled", true) then
        return
    end

    -- Allow admins to edit their names
	if isstring(value) and client:IsAdmin() then
		return value, false
	end

    if CLIENT then
        if value == nil and payload.faction and payload.class and ix.class.list[tonumber(payload.class)] then
            local class = ix.class.list[tonumber(payload.class)]
            if class.shortName then
                lastNamePanel = panel
                lastPayload = payload
                net.Start("getDefaultCharacterName")
                    net.WriteString(payload.faction)
                    net.WriteString(class.uniqueID)
                net.SendToServer()
            end
        end
        return
    end
end)
