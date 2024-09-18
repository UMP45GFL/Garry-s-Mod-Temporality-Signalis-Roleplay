
ITEM.name = "Golden Sword"
ITEM.model = Model("models/eternalis/items/weapons/fklr_sword.mdl")
ITEM.description = ""
ITEM.skin = 0

ITEM.width = 1
ITEM.height = 2

ITEM.class = "kanade_tfa_signalis_fklr_sword"
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
