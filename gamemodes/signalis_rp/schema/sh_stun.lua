
if SERVER then
	util.AddNetworkString("stun_effect")

    local meta = FindMetaTable("Player")

    -- lua_run Entity(1):StunPlayer(1, afterEffectsTime)
    function meta:StunPlayer(flashTime, afterEffectsTime)
        net.Start("stun_effect")
            net.WriteFloat(flashTime)
            net.WriteFloat(afterEffectsTime)
        net.Send(self)
    end
end

if CLIENT then
    local stunLength = 2

    local stunStartTime = 0
    local flashFinishTime = 0
    local afterEffectsFinishTime = 0
    
    -- make screen white
    local function DrawStunEffect() 
        if flashFinishTime > CurTime() then
            local alpha = 255

            if stunStartTime + stunLength < CurTime() then
                alpha = 255 - (255 * (CurTime() - stunStartTime - stunLength) / (flashFinishTime - stunStartTime - stunLength))
            end
            
            surface.SetDrawColor(255, 255, 255, math.Round(alpha))
            surface.DrawRect(0, 0, ScrW(), ScrH())
        else
            hook.Remove("HUDPaint", "DrawStunEffect_HUDPaint")
        end 
    end
    
    -- motion blur and other junk
    local function DrawStunMotionEffects()
        if afterEffectsFinishTime > CurTime() then
            local perc = (CurTime() - flashFinishTime) / (afterEffectsFinishTime - flashFinishTime)
            
            DrawMotionBlur(0.5, 0.8, 0.5 * (1 - perc))
            DrawBloom(0.65, 2, 9, 9, 1, 1, 1, 1, 1)
            DrawSharpen(1.2, 1.2)

        elseif flashFinishTime < CurTime() then
            hook.Remove("RenderScreenspaceEffects", "DrawStunMotionEffects_RenderScreenspaceEffects")
        end
    end
    
    net.Receive("stun_effect", function(len, ply)
        local flash_time = net.ReadFloat();
        local after_time = net.ReadFloat();
    
        stunStartTime = CurTime()

        flashFinishTime = flash_time + CurTime()
        afterEffectsFinishTime = flashFinishTime + after_time

        surface.PlaySound("eternalis/weapons/stun_prod/taser_shot_multiple.wav")
        
        hook.Add("HUDPaint", "DrawStunEffect_HUDPaint", DrawStunEffect)
        hook.Add("RenderScreenspaceEffects", "DrawStunMotionEffects_RenderScreenspaceEffects", DrawStunMotionEffects)
    end)
end
