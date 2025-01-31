
if SERVER then
    AddCSLuaFile("cl_plugin.lua")
    include("sv_plugin.lua")
end
include("cl_plugin.lua")

PLUGIN.name = "Advanced healing system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Makes the healing system more advanced."
PLUGIN.license = [[meow]]

if SERVER then
    ix.config.Add("AdvancedHealingSystemEnabled", false, "Whether or to enable the advanced healing system.", nil, {
        category = "Advanced Healing System"
    })
end
