
PLUGIN.name = "Quiz Module"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds a configurable quiz after a player joins."
PLUGIN.license = [[meow]]

ix.config.Add("QuizModuleEnabled", true, "Whether or to enable the quiz module.", nil, {
    category = "Quiz Module"
})

ix.config.Add("QuizModuleBanLength", 120, "Length of the ban after player fails the quiz, 0 is permanent", nil, {
    data = {min = 0, max = 3600},
    category = "Quiz Module"
})

ix.config.Add("QuizModuleFiledAttempts", 3, "How many attempts until a ban", nil, {
    data = {min = 1, max = 10},
    category = "Quiz Module"
})

ix.config.Add("QuizModuleMaxSpentTimeAnswering", 100, "Max time a player can be answering the quiz until ban (in seconds)", nil, {
    data = {min = 1, max = 360},
    category = "Quiz Module"
})

ix.config.Add("QuizModuleMaxNoQuizAfkTime", 200, "Max time a player can be afk not in the quiz (in seconds)", nil, {
    data = {min = 1, max = 360},
    category = "Quiz Module"
})

ix.config.Add("QuizModuleAfkBanTime", 15, "Time in minutes the player gets banned for after being afk in the quiz (in minutes)", nil, {
    data = {min = 1, max = 360},
    category = "Quiz Module"
})

if SERVER then
    include("sv_answers.lua")
    include("sv_plugin.lua")
    AddCSLuaFile("cl_questions.lua")
    AddCSLuaFile("cl_plugin.lua")
else
    include("cl_questions.lua")
    include("cl_plugin.lua")
end
