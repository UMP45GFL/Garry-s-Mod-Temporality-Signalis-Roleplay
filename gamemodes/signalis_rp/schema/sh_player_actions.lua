
if SERVER then
    util.AddNetworkString("characterSuicide")

    net.Receive("characterSuicide", function(len, ply)
        local itemId = net.ReadUInt(12)

        if ply:Alive() then
            local item = ix.item.instances[itemId]
            if item and item.functions.Suicide then
                item.player = ply
                SuicideItemFunction(item)
            end
        end
    end)

    function SuicideItemFunction(item)
        if IsValid(item.player) then
            local successChance = math.random(1, 100)
    
            local eyepos = item.player:EyePos()
            local eyeang = item.player:EyeAngles()
            local aimvector = item.player:GetAimVector()
    
            item:Spawn(eyepos + (aimvector * 20), eyeang)
    
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(item.player:Health())
            dmginfo:SetAttacker(item.player)
            dmginfo:SetDamageType(DMG_SLASH)
        
            if successChance > 80 or true then
                dmginfo:SetDamage(item.player:Health() * 0.8)
                item.player:TakeDamageInfo(dmginfo)
                item.player:SetRagdolled(true, 15)
                return false
            end
    
            item.player:TakeDamageInfo(dmginfo)
    
            return true
        end
    
        return false
    end
end

if CLIENT then
    function PromptSuicide(item)
        Derma_Query(
            "Are you sure you want to kill your character?",
            "Suicide confirmation",
            "Yes",
            function()
                print("b wa3", item)
                if item != nil then
                    net.Start("characterSuicide")
                        net.WriteUInt(item:GetID(), 12)
                    net.SendToServer()
                end
            end,
            "No",
            function()
            end
        )

        return false
    end
end
