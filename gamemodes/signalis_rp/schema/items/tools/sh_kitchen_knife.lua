
ITEM.name = "Kitchen knife"
ITEM.model = Model("models/eternalis/items/weapons/kitchen/small_sharp_knife.mdl")
ITEM.description = "A small, sharp kitchen knife. Perfect for cutting vegetables and meat."
ITEM.skin = 0

ITEM.width = 2
ITEM.height = 1

ITEM.canSlice = true

ITEM.functions.Suicide = {
    icon = "icon16/cross.png",
	OnRun = function(item)
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
	end,
	OnCanRun = function(item)
        local character = ply:GetCharacter()
        if character and character.vars and character.vars.class
        and (character.vars.class == "replika_fklr" or character.vars.class == "replika_stcr" or character.vars.class == "replika_kncr")  then
            return false
        end

		return IsValid(item.player)
	end
}
