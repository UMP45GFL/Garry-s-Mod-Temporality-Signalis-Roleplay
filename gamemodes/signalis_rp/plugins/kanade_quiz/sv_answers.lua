
util.AddNetworkString("openquiz")
util.AddNetworkString("openquizfailed")

hook.Add("OnLoadDatabaseTables", "QuizModule_OnLoadDatabaseTables", function()
	query = mysql:Create("ix_quiz_whitelist")
        query:Create("whitelist_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("steamid", "VARCHAR(20) NOT NULL")
		query:Create("quiz_completed_time", "INT(11) UNSIGNED NOT NULL")
		query:Create("answered_incorrectly", "INT(6) UNSIGNED NOT NULL")
		query:PrimaryKey("whitelist_id")
	query:Execute()
end)

local max_amount_of_incorrect_answers = 4

local function checkPlayerQuizWhitelist(ply)
	local query = mysql:Select("ix_quiz_whitelist")
    query:Select("answered_incorrectly")
    query:Select("quiz_completed_time")
    query:Where("steamid", ply:SteamID64())
    query:Callback(function(data)
        if istable(data) and #data > 0 then
            if string.len(data[1].quiz_completed_time) < 4 and tonumber(data[1].answered_incorrectly) >= max_amount_of_incorrect_answers then
                local banLength = ix.config.Get("QuizModuleBanLength", 120)
                ply:Ban(banLength, false)
                ply:Kick("Wrongly answered quiz questions too many times.")
                return
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
	local query = mysql:Select("ix_quiz_whitelist")
		query:Select("answered_incorrectly")
		query:Where("steamid", ply:SteamID64())
		query:Callback(function(data)
			if istable(data) and #data > 0 then
                local answeredIncorrectly = tonumber(data[1].answered_incorrectly)

                if answeredIncorrectly >= max_amount_of_incorrect_answers then
                    ply:Ban(0, false)
                    ply:Kick("Wrongly answered quiz questions too many times.")
                    return
                end

                local updateQuery = mysql:Update("ix_quiz_whitelist")
                updateQuery:Update("answered_incorrectly", answeredIncorrectly + 1)
                updateQuery:Where("steamid", ply:SteamID64())
                updateQuery:Execute()
            else
                local insertQuery = mysql:Insert("ix_quiz_whitelist")
                insertQuery:Insert("steamid", ply:SteamID64())
                insertQuery:Insert("quiz_completed_time", 0)
                insertQuery:Insert("answered_incorrectly", 1)
                insertQuery:Execute()
			end

            net.Start("openquizfailed")
            net.Send(ply)
		end)
	query:Execute()
end

hook.Add("PostPlayerInitialized", "QuizModule_PostPlayerInitialized", function(ply)
    timer.Simple(0.5, function()
        if IsValid(ply) then
            checkPlayerQuizWhitelist(ply)
        end
    end)
end)

KANADE_QUIZ_ANSWERS = {
    {
        question = "What type of [GAME GENRE] do we currently roleplay in?",
        right_option = "Survival horror",
    },
    {
        question = "What is a notable feature of the visual style in SIGNALIS?",
        right_option = "Retro-futuristic and pixelated graphics",
    },
    {
        question = "What or who is ARAR?",
        right_option = "A replika",
    },
    {
        question = "Remember _ ...? (Finish the sentence)",
        right_option = "Our Promise.",
    },
    {
        question = "In question 4. who has said this sentence?",
        right_option = "Ariane",
    }
}

util.AddNetworkString("quizsubmit")

net.Receive("quizsubmit", function(len, ply)
    local answers = net.ReadTable()

    if #answers != #KANADE_QUIZ_ANSWERS then
        print("Invalid number of answers received from " .. ply:Name())
        ply:Ban(0, false)
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

	local query = mysql:Select("ix_quiz_whitelist")
		query:Select("answered_incorrectly")
		query:Where("steamid", ply:SteamID64())
		query:Callback(function(data)
            if istable(data) and #data > 0 then
                local updateQuery = mysql:Update("ix_quiz_whitelist")
                updateQuery:Update("quiz_completed_time", os.time())
                updateQuery:Where("steamid", ply:SteamID64())
                updateQuery:Execute()
            else
                local insertQuery = mysql:Insert("ix_quiz_whitelist")
                insertQuery:Insert("steamid", ply:SteamID64())
                insertQuery:Insert("quiz_completed_time", os.time())
                insertQuery:Insert("answered_incorrectly", 0)
                insertQuery:Execute()
            end
		end)
	query:Execute()
end)
