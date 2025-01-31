
util.AddNetworkString("openquiz")
util.AddNetworkString("quizstarted")
util.AddNetworkString("openquizfailed")
util.AddNetworkString("quizcompleted")
util.AddNetworkString("startedbeingactive")

/*
lua_run local query = mysql:Delete("ix_quiz_whitelist") query:Where("steamid", '76561198156389563') query:Execute()
*/

hook.Add("OnLoadDatabaseTables", "QuizModule_OnLoadDatabaseTables", function()
	query = mysql:Create("ix_quiz_whitelist")
        query:Create("whitelist_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("steamid", "VARCHAR(20) NOT NULL")
		query:Create("quiz_completed_time", "INT(11) UNSIGNED NOT NULL")
		query:Create("answered_incorrectly", "INT(6) UNSIGNED NOT NULL")
		query:Create("was_banned", "BIT(1) NOT NULL")
		query:PrimaryKey("whitelist_id")
	query:Execute()
end)

local function checkPlayerQuizWhitelist(ply)
	local query = mysql:Select("ix_quiz_whitelist")
    query:Select("answered_incorrectly")
    query:Select("quiz_completed_time")
    query:Select("was_banned")
    query:Where("steamid", ply:SteamID64())
    query:Callback(function(data)
        if istable(data) and #data > 0 and tonumber(data[1].was_banned) == 0 then
            if data[1].quiz_completed_time and tonumber(data[1].quiz_completed_time) == 0 and tonumber(data[1].answered_incorrectly) >= ix.config.Get("QuizModuleFiledAttempts", 3) then
                local updateQuery = mysql:Update("ix_quiz_whitelist")
                updateQuery:Update("was_banned", 0)
                updateQuery:Where("steamid", ply:SteamID64())
                updateQuery:Execute()
            end

            if tonumber(data[1].quiz_completed_time) > 0 then
                -- Player has completed the quiz
                return
            end
        end

        net.Start("openquiz")
        net.Send(ply)
    end)
	query:Execute()
end

local function quizFailed(ply)
    ply.startedSignalisQuiz = nil

    createAfkLimitTimer(ply)

	local query = mysql:Select("ix_quiz_whitelist")
		query:Select("answered_incorrectly")
		query:Where("steamid", ply:SteamID64())
		query:Callback(function(data)
			if istable(data) and #data > 0 then
                local answeredIncorrectly = tonumber(data[1].answered_incorrectly) + 1

                local updateQuery = mysql:Update("ix_quiz_whitelist")
                updateQuery:Update("answered_incorrectly", answeredIncorrectly)
                updateQuery:Where("steamid", ply:SteamID64())
                updateQuery:Execute()

                if answeredIncorrectly >= ix.config.Get("QuizModuleFiledAttempts", 3) then
                    local banLength = ix.config.Get("QuizModuleBanLength", 120)
                    local niceBanTime = string.NiceTime(banLength * 60)
                    local banText = "Wrongly answered quiz questions too many times. Try again in " .. niceBanTime .. "."
                    RunConsoleCommand("ulx", "ban", tostring(ply:Nick()), tostring(banLength), banText)
                    return
                end
            else
                local insertQuery = mysql:Insert("ix_quiz_whitelist")
                insertQuery:Insert("steamid", ply:SteamID64())
                insertQuery:Insert("quiz_completed_time", 0)
                insertQuery:Insert("answered_incorrectly", 1)
                insertQuery:Insert("was_banned", 0)
                insertQuery:Execute()
			end

            net.Start("openquizfailed")
            net.Send(ply)
		end)
	query:Execute()
end

hook.Add("PostPlayerInitialized", "QuizModule_PostPlayerInitialized", function(ply)
    if !ix.config.Get("QuizModuleEnabled", true) then return end

    timer.Simple(1, function()
        if IsValid(ply) then
            checkPlayerQuizWhitelist(ply)
        end
    end)
end)

hook.Add("PlayerDisconnected", "QuizModule_PlayerDisconnected", function(ply)
    if ply.startedSignalisQuiz != nil then
        local banLength = ix.config.Get("QuizModuleAfkBanTime", 15)
        local niceBanTime = string.NiceTime(banLength * 60)
        local banText = "You disconnected while in the quiz. Return in " .. niceBanTime .. "."
        RunConsoleCommand("ulx", "ban", tostring(ply:Nick()), tostring(banLength), banText)
    end
end)

util.AddNetworkString("quizsubmit")
util.AddNetworkString("quiznofocus")
util.AddNetworkString("questionanswered")

function createAfkLimitTimer(ply)
    if timer.Exists("quizAfkTimeLimit_" .. ply:SteamID64()) then
        timer.Remove("quizAfkTimeLimit_" .. ply:SteamID64())
    end

    timer.Create("quizAfkTimeLimit_" .. ply:SteamID64(), ix.config.Get("QuizModuleMaxNoQuizAfkTime", 200), 1, function()
        if IsValid(ply) then
            local kickText = "Occupied AFK slot"
            RunConsoleCommand("ulx", "kick", tostring(ply:Nick()), kickText)
        end
    end)
end

net.Receive("startedbeingactive", function(len, ply)
    createAfkLimitTimer(ply)
end)

net.Receive("quizstarted", function(len, ply)
    ply.startedSignalisQuiz = CurTime()

    if timer.Exists("quizTimeLimit_" .. ply:SteamID64()) then
        timer.Remove("quizTimeLimit_" .. ply:SteamID64())
    end

    timer.Create("quizTimeLimit_" .. ply:SteamID64(), ix.config.Get("QuizModuleMaxSpentTimeAnsweringQuestion", 100), 1, function()
        if IsValid(ply) then
            local banLength = ix.config.Get("QuizModuleAfkBanTime", 15)
            local niceBanTime = string.NiceTime(banLength * 60)
            local banText = "You took too long to answer the quiz. Return in " .. niceBanTime .. "."
            RunConsoleCommand("ulx", "ban", tostring(ply:Nick()), tostring(banLength), banText)
        end
    end)
end)

net.Receive("quiznofocus", function(len, ply)
	local query = mysql:Select("ix_quiz_whitelist")
    query:Select("answered_incorrectly")
    query:Where("steamid", ply:SteamID64())
    query:Callback(function(data)
        if istable(data) and #data > 0 then
            local answeredIncorrectly = tonumber(data[1].answered_incorrectly) + 1
            local updateQuery = mysql:Update("ix_quiz_whitelist")
            updateQuery:Update("answered_incorrectly", answeredIncorrectly)
            updateQuery:Where("steamid", ply:SteamID64())
            updateQuery:Execute()
        else
            local insertQuery = mysql:Insert("ix_quiz_whitelist")
            insertQuery:Insert("steamid", ply:SteamID64())
            insertQuery:Insert("quiz_completed_time", 0)
            insertQuery:Insert("answered_incorrectly", 2)
            insertQuery:Insert("was_banned", 0)
            insertQuery:Execute()
        end
    end)
    query:Execute()

    local banLength = ix.config.Get("QuizModuleAfkBanTime", 15)
    local niceBanTime = string.NiceTime(banLength * 60)
    local banText = "You cannot minimize the game. Try again in " .. niceBanTime .. "."
    RunConsoleCommand("ulx", "ban", tostring(ply:Nick()), tostring(banLength), banText)
end)

net.Receive("quizsubmit", function(len, ply)
    local answers = net.ReadTable()

    if #answers != #KANADE_QUIZ_ANSWERS then
        print("Invalid number of answers received from " .. ply:Name())
        net.Start("openquizfailed")
        net.Send(ply)
        return
    end

    for _, answerTable in pairs(KANADE_QUIZ_ANSWERS) do
        for k, clientAnswer in pairs(answers) do
            if clientAnswer.question == answerTable.question then
                if clientAnswer.answer != answerTable.right_option then
                    print(ply:Name() .. " has answered question " .. k .. " incorrectly.")
                    quizFailed(ply)
                    return
                end
            end
        end
    end

    ply.startedSignalisQuiz = nil

    net.Start("quizcompleted")
    net.Send(ply)

    if timer.Exists("quizTimeLimit_" .. ply:SteamID64()) then
        timer.Remove("quizTimeLimit_" .. ply:SteamID64())
    end
    if timer.Exists("quizAfkTimeLimit_" .. ply:SteamID64()) then
        timer.Remove("quizAfkTimeLimit_" .. ply:SteamID64())
    end

	local query = mysql:Select("ix_quiz_whitelist")
		query:Select("answered_incorrectly")
		query:Where("steamid", ply:SteamID64())
		query:Callback(function(data)
            if istable(data) and #data > 0 then
                local updateQuery = mysql:Update("ix_quiz_whitelist")
                updateQuery:Update("quiz_completed_time", os.time())
                updateQuery:Where("steamid", ply:SteamID64())
                updateQuery:Execute()

                if tonumber(data[1].was_banned) == 1 then
                    local updateQuery = mysql:Update("ix_quiz_whitelist")
                    updateQuery:Update("was_banned", 0)
                    updateQuery:Where("steamid", ply:SteamID64())
                    updateQuery:Execute()
                end
            else
                local insertQuery = mysql:Insert("ix_quiz_whitelist")
                insertQuery:Insert("steamid", ply:SteamID64())
                insertQuery:Insert("quiz_completed_time", os.time())
                insertQuery:Insert("answered_incorrectly", 0)
                insertQuery:Insert("was_banned", 0)
                insertQuery:Execute()
            end
		end)
	query:Execute()
end)

