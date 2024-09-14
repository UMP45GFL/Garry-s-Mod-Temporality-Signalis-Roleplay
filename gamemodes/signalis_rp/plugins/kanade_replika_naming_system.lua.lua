
PLUGIN.name = "Replika naming system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds a naming system to replikas"
PLUGIN.license = [[meow]]

ix.config.Add("ReplikaNamingSystemEnabled", true, "Whether to enable the replika naming system.", nil, {
    category = "Replika Naming System"
})

function CreateNextReplikaNumberConfigs()
    for k,v in pairs(ix.class.list) do
        if v.faction == FACTION_REPLIKA and v.shortName then
            print("Creating nn config for " .. v.shortName)

            ix.config.Add("Next " .. v.shortName .. " Number", 0, "The next number of " .. v.name, nil, {
                category = "Replika Naming System",
                data = {min = 0, max = 99},
            })
        end
    end
end

hook.Add("InitPostEntity", "ReplikaNamingSystem_InitPostEntity", function()
    CreateNextReplikaNumberConfigs()
end)

function GetNewCharacterName(className)
    local facilityName = ix.config.Get("facilityShortName", nil)
    local class = ix.class.GetClass(className)

    if not facilityName or not class or not class.shortName then
        print("GetNewCharacterName: facilityName or class or class.shortName is nil")
        return
    end

    local num = ix.config.Get("Next " .. class.shortName .. " Number", 1)
    local newName = class.shortName .. "-" .. facilityName .. string.format("%02d", num)

    return newName
end

if SERVER then
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
                print("Updated next number for " .. class.name .. " to " .. highestNum + 1)
                ix.config.Set("Next " .. class.shortName .. " Number", highestNum + 1)
            end)
        end
    end

    hook.Add("OnCharacterCreated", "ReplikaNamingSystem_OnCharacterCreated", function(client, character)
        local class = ix.class.GetClass(character.vars.class)
        if class and class.shortName then
            local num = ix.config.Get("Next " .. class.shortName .. " Number", 0)

            ix.config.Set("Next " .. class.shortName .. " Number", num + 1)
            print("Replika naming system: Updated next number for class " .. class.name .. " to " .. num + 1)
        end
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
end

hook.Add("GetDefaultCharacterName", "ReplikaNamingSystem_GetDefaultCharacterName", function(client, payload, value, panel)
    if not ix.config.Get("ReplikaNamingSystemEnabled", true) then
        return
    end

    -- Allow admins to edit their names
	if isstring(value) and client:IsAdmin() then
		return value, false
	end

    if value == nil and payload.faction and payload.class and ix.class.list[tonumber(payload.class)] then
        local class = ix.class.list[tonumber(payload.class)]
        if class.shortName then
            return GetNewCharacterName(class.uniqueID), !client:IsAdmin()
        end
    end

    return
end)
