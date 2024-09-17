
ITEM.name = "Golden Spear"
ITEM.model = Model("models/eternalis/items/weapons/fklr_spear.mdl")
ITEM.description = ""
ITEM.skin = 0

ITEM.width = 2
ITEM.height = 1

ITEM.class = "kanade_signalis_fklr_spear"
ITEM.weaponCategory = "melee"

ITEM.weight = 0

function ITEM:CanEquip(client)
	local character = client:GetCharacter()
	if character and (
		character.vars.class == "replika_fklr"
	) then
		return true
	end

	client:NotifyLocalized("weaponTooHeavy")

	return false
end
