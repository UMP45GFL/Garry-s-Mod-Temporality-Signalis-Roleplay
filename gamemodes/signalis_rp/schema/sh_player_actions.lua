
if SERVER then
    util.AddNetworkString("characterSuicide")

    net.Receive("characterSuicide", function(len, ply)
        local itemId = net.ReadUInt(12)

        if ply:Alive() then
            local item = ix.item.instances[itemId]
            if item and item.functions.Suicide then
                SuicideItemFunction(item, ply)
            end
        end
    end)

    function SuicideItemFunction(item, client)
        if IsValid(client) then
            local successChance = math.random(1, 100)
    
            local eyepos = client:EyePos()
            local eyeang = client:EyeAngles()
            local aimvector = client:GetAimVector()
    
            local isEquipped = item:GetData("equip", false)
            item:Unequip(client, false)
            --item:SetData("equip", false)

            local droppedEnt = item:Transfer(nil, nil, nil, self)
            if isentity(droppedEnt) then
                droppedEnt:SetPos(eyepos + (aimvector * 20))
                droppedEnt:SetAngles(eyeang)

                if isEquipped and item.class then
                    client:StripWeapon(item.class)
                end
            end

            --item:Spawn(eyepos + (aimvector * 20), eyeang)
    
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(client:Health())
            dmginfo:SetAttacker(client)
            dmginfo:SetDamageType(DMG_SLASH)
        
            if successChance > 80 or true then
                dmginfo:SetDamage(client:Health() * 0.8)
                client:TakeDamageInfo(dmginfo)
                client:SetRagdolled(true, 15)
                return false
            end
    
            client:TakeDamageInfo(dmginfo)
    
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
