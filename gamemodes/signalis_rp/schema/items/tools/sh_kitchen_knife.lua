
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
            local dmginfo = DamageInfo()
            dmginfo:SetDamage(item.player:Health())
            dmginfo:SetAttacker(item.player)
            dmginfo:SetDamageType(DMG_SLASH) 
        
            item.player:TakeDamageInfo(dmginfo)
        end
	end,
	OnCanRun = function(item)
		return IsValid(item.player)
	end
}
