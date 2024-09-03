
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

                print("EWPS succeded:", code, body)
                local trustScore = calculateTrustScore(data)

                ply.ewps = trustScore
                ply:SetNWInt('ewps', trustScore)

                local insertQuery = mysql:Insert("ix_ewps")
                insertQuery:Insert("steamid", ply:SteamID64())
                insertQuery:Insert("init_time", os.time())
                insertQuery:Insert("trust_score", trustScore)
                insertQuery:Execute()
                print("EWPS created cache for " .. steamid .. " with trust score " .. trustScore)

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
    for k,v in pairs(player.GetAll()) do
        loadPlayerEWPS(v)
    end
    */

    function loadPlayerEWPS(ply)
        local steamid = ply:SteamID64()

        local query = mysql:Select("ix_ewps")
        query:Select("trust_score")
        query:Where("steamid", ply:SteamID64())
        query:Callback(function(data)
            if istable(data) and #data > 0 then
                ply.ewps = data[1].trust_score
                ply:SetNWInt('ewps', ply.ewps)
                print("EWPS loaded cache for " .. steamid)
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
    hook.Add("OnObserverESP", "EWPS_OnObserverESP", function(ply, x, y, size, alpha)
        local trustScore = ply:GetNWInt('ewps', nil)
        if trustScore then
            local trustScore = ply.ewps
            local trustColor = Color(255, 255, 255, alpha)

            if trustScore < 50 then
                trustColor = Color(255, 0, 0, alpha)
                
            elseif trustScore < 75 then
                trustColor = Color(255, 255, 0, alpha)
            end

            draw.SimpleTextOutlined("Trust: " .. trustScore, "ixSmallFont", x, y - 20, trustColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, alpha))
        end
    end)
end
