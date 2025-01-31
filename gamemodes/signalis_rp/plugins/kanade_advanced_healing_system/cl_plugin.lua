
function ShowAdvancedHealingMenu()
end

hook.Add("HUDDrawTargetID", "AdvancedHealingSystem_HUDDrawTargetID", function()
    if not ix.config.Get("AdvancedHealingSystemEnabled", true) then
        return
    end

    local client = LocalPlayer()

    local tr = util.TraceLine({
        start = LocalPlayer():EyePos(),
        endpos = LocalPlayer():EyePos() + EyeAngles():Forward() * 70,
        --filter = client
    })

    local entity = tr.Entity

    if tr.Hit and IsValid(entity) and entity:IsPlayer() and entity:Alive() and entity:Team() != TEAM_SPECTATOR then
        draw.SimpleText("Hold use to examine", "ix3D2DMediumFont", ScrW() / 2, ScrH() / 1.5, ix.config.Get("color"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)
