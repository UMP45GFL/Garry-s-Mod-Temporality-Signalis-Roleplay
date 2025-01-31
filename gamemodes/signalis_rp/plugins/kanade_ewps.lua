
PLUGIN.name = "Early Warning Profiling System"
PLUGIN.author = "Kanade"
PLUGIN.description = "A system that allows you to profile players."
PLUGIN.license = [[meow]]

ix.config.Add("EWPSEnabled", false, "Whether or to enable the early warning profiling system", nil, {
	category = "EWPS"
})

if SERVER then
    require("chttp")

    -- Configurable scoring values
    local trustConfig = {
        -- slightly bad
        TOO_MUCH_NICKNAMES = -5,
        NO_SIGNALIS_GAME = -5,
        LOW_GMODHOURS = -5,

        -- bad
        HIGH_GMODHOURS = -10,
        LOW_STEAMLEVEL = -10,
        INSUFFICIENT_FRIENDLIST = -10,
        INSUFFICIENT_GAMES = -10,
        INSUFFICIENT_GROUPS = -10,
        PRIVATE_FRIENDLIST = -10,
        INSUFFICIENT_PLAYTIME2W = -15,

        -- very bad
        NON_DECORATED_PROFILE = -20,
        PRIVATE_ACCOUNT = -25,
        PRIVATE_GAMES = -30,
        HIDDEN_GAME_HOURS = -30,
        VAC_BANNED = -50,

        PROFILE_PROFANITIES = -50, --BY HOW MUCH TO AMPLIFY THE PROFANITY SCORE (for example 0.42 * 60 = 25.2)
    }

    /*
    lua_run local query = mysql:Drop("ix_ewps") query:Execute()
    */

    hook.Add("OnLoadDatabaseTables", "EWPS_OnLoadDatabaseTables", function()
        query = mysql:Create("ix_ewps")
            query:Create("steamid", "VARCHAR(20) NOT NULL")
            query:Create("init_time", "INT(11) UNSIGNED NOT NULL")
            query:Create("trust_score", "INT(8) UNSIGNED NOT NULL")
            query:Create("info", "TEXT(200) UNSIGNED NOT NULL")
            query:PrimaryKey("steamid")
        query:Execute()
    end)

    -- Function to calculate the trust score
    local function calculateTrustScore(data)
        -- Starting score (could be adjusted)
        local trustScore = 100

        -- Check each flag in the data table and adjust the score
        if data["LOW_GMODHOURS"] then
            trustScore = trustScore + trustConfig.LOW_GMODHOURS
        end

        if data["HIGH_GMODHOURS"] then
            trustScore = trustScore + trustConfig.HIGH_GMODHOURS
        end

        if data["PRIVATE_ACCOUNT"] then
            trustScore = trustScore + trustConfig.PRIVATE_ACCOUNT
        end

        if data["PRIVATE_GAMES"] then
            trustScore = trustScore + trustConfig.PRIVATE_GAMES
        end

        if data["HIDDEN_GAME_HOURS"] then
            trustScore = trustScore + trustConfig.HIDDEN_GAME_HOURS
        end

        if data["VAC_BANNED"] then
            trustScore = trustScore + trustConfig.VAC_BANNED
        end

        if data["INSUFFICIENT_FRIENDLIST"] then
            trustScore = trustScore + trustConfig.INSUFFICIENT_FRIENDLIST
        end

        if data["INSUFFICIENT_GAMES"] then
            trustScore = trustScore + trustConfig.INSUFFICIENT_GAMES
        end

        if data["INSUFFICIENT_GROUPS"] then
            trustScore = trustScore + trustConfig.INSUFFICIENT_GROUPS
        end

        if data["TOO_MUCH_NICKNAMES"] then
            trustScore = trustScore + trustConfig.TOO_MUCH_NICKNAMES
        end

        if data["NO_SIGNALIS_GAME"] then
            trustScore = trustScore + trustConfig.NO_SIGNALIS_GAME
        end

        if data["LOW_STEAMLEVEL"] then
            trustScore = trustScore + trustConfig.LOW_STEAMLEVEL
        end

        if data["PRIVATE_FRIENDLIST"] then
            trustScore = trustScore + trustConfig.PRIVATE_FRIENDLIST
        end

        if data["PROFILE_PROFANITIES"] then
            -- Deduct points for each type of profanity
            for _, profanity_score in pairs(data["PROFILE_PROFANITIES"]) do
                trustScore = trustScore + (profanity_score * trustConfig.PROFILE_PROFANITIES)
            end
        end

        if data["NON_DECORATED_PROFILE"] then
            trustScore = trustScore + trustConfig.NON_DECORATED_PROFILE
        end

        if data["INSUFFICIENT_PLAYTIME2W"] then
            trustScore = trustScore + trustConfig.INSUFFICIENT_PLAYTIME2W
        end

        -- Return the final trust score
        return trustScore
    end

    local function addToString(string, toAdd)
        if string == "" then
            return toAdd
        else
            return string .. ", " .. toAdd
        end
    end

    local function getImportantInfo(data)
        local info = ""

        if data["PRIVATE_ACCOUNT"] then
            info = addToString(info, "Private Account")
        end

        if data["PRIVATE_GAMES"] then
            info = addToString(info, "Private Games")
        end

        if data["HIDDEN_GAME_HOURS"] then
            info = addToString(info, "Hidden Game Hours")
        end

        if data["NON_DECORATED_PROFILE"] then
            info = addToString(info, "Non Decorated Profile")
        end

        if data["VAC_BANNED"] then
            info = addToString(info, "VAC Banned")
        end

        if data["PROFILE_PROFANITIES"] then
            info = addToString(info, "Profanities")
            
            for profanity, score in pairs(data["PROFILE_PROFANITIES"]) do
                info = addToString(info, profanity .. " " .. score)
            end
        end

        return info
    end

	ix.log.AddType("ewps", function(client, logText)
		return logText
	end, FLAG_DANGER)

    function runNewPlayerEWPS(ply)
        local steamid = ply:SteamID64()

        local secure_pass = util.MD5(os.date("%d%m%y_%H%M"))

        CHTTP({
            failed = function(reason)
                print("EWPS failed for " .. steamid .. ":", reason)
            end,
            success = function(code, body, headers)
                local data = util.JSONToTable(body)

                if data["error"] then
                    print("EWPS errored :", data["error"])
                    return
                end

                local trustScore = calculateTrustScore(data)
                local info = getImportantInfo(data)

                ply.ewpsTrustScore = trustScore
                ply.ewpsInfo = info
                ply:SetNWInt('ewpsTrustScore', trustScore)
                ply:SetNWString('ewpsInfo', info)

                local insertQuery = mysql:Insert("ix_ewps")
                insertQuery:Insert("steamid", ply:SteamID64())
                insertQuery:Insert("init_time", os.time())
                insertQuery:Insert("trust_score", trustScore)
                insertQuery:Insert("info", info)
                insertQuery:Execute()

                local logText = "EWPS created cache for player " .. ply:Name() .. "(" .. steamid .. ") with trust score " .. trustScore

                if string.len(info) > 0 then
                    logText = logText .. " and info " .. info
                end

                ix.log.Add(ply, "ewps", logText)
            end,
            method = "GET",
            headers = {
                ["Cache-Control"] = "no-cache, no-store, must-revalidate",
                ["Pragma"] = "no-cache",
                ["Expires"] = "0"
            },
            url = "https://eternalis.site/EWPS/?pass=" .. secure_pass .. "&steamid=" .. steamid
        })
    end

    -- lua_run loadPlayerEWPS(Entity(1))

    /*
    lua_run for k,v in pairs(player.GetAll()) do loadPlayerEWPS(v) end
    */

    function loadPlayerEWPS(ply)
        local steamid = ply:SteamID64()

        local query = mysql:Select("ix_ewps")
        query:Select("trust_score")
        query:Select("info")
        query:Where("steamid", ply:SteamID64())
        query:Callback(function(data)
            if istable(data) and #data > 0 then
                ply.ewpsTrustScore = data[1].trust_score
                ply.ewpsInfo = data[1].info
                ply:SetNWInt('ewpsTrustScore', ply.ewpsTrustScore)
                ply:SetNWString('ewpsInfo', ply.ewpsInfo)

                local logText = "EWPS loaded cache for player " .. ply:Name() .. "(" .. steamid .. ") with trust score " .. ply.ewpsTrustScore .. " and info " .. ply.ewpsInfo

                ix.log.Add(ply, "ewps", logText)
            else
                runNewPlayerEWPS(ply)
            end
        end)
        query:Execute()
    end

    hook.Add("PostPlayerInitialized", "EWPS_PostPlayerInitialized", function(ply)
        if !ix.config.Get("QuizModuleEnabled", true) then return end
    
        timer.Simple(1, function()
            if IsValid(ply) then
                loadPlayerEWPS(ply)
            end
        end)
    end)
else
    local isEWPStoggled = true

    concommand.Add("signalis_toggle_ewps_esp", function()  
        isEWPStoggled = !isEWPStoggled
    end)

    -- Function to get color based on trust score (0 to 100)
    function GetTrustColor(trustScore)
        -- Ensure the trust score is clamped between 0 and 100
        trustScore = math.Clamp(trustScore, 0, 100)

        -- Calculate the red and green values based on the trust score
        local red = (100 - trustScore) * 2.55  -- Red goes from 255 to 0 as trust increases
        local green = trustScore * 2.55         -- Green goes from 0 to 255 as trust increases

        -- Return the RGB color with 0 blue (R, G, B, A)
        return Color(red, green, 0, 255)
    end

    hook.Add("OnObserverESP", "EWPS_OnObserverESP", function(ply, x, y, size, alpha)
        if isEWPStoggled then
            local trustScore = ply:GetNWInt('ewpsTrustScore', nil)

            local fsize = draw.GetFontHeight("ixSmallFont")

            if trustScore then
                trustScore = tonumber(trustScore)

                local trustColor = GetTrustColor(trustScore)
                trustColor.a = alpha

                draw.SimpleTextOutlined("Trust score: " .. trustScore, "ixSmallFont", x, y - size - fsize - 1, trustColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, alpha))
            
                local info = ply:GetNWString('ewpsInfo', nil)
                if info and info != "" then
                    local info2 = info
                    if string.len(info) > 60 then
                        info = string.sub(info, 1, 60)
                        info2 = string.sub(info2, 61)
    
                        draw.SimpleTextOutlined(info2, "ixSmallFont", x, y - size - (fsize * 2), trustColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, alpha))
                        draw.SimpleTextOutlined(info, "ixSmallFont", x, y - size - (fsize * 3), trustColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, alpha))
                    else
                        draw.SimpleTextOutlined(info, "ixSmallFont", x, y - size - (fsize * 2), trustColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, alpha))
                    end
                end

                return trustColor
            end
        end
    end)
end
