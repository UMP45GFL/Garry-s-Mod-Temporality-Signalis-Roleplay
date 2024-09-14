ITEM.name = "Mining laser"
ITEM.description = [[A mining laser that can be used to mine resources.]]

ITEM.model = "models/eternalis/items/weapons/laserminer.mdl"
ITEM.class = "kanade_tfa_signalis_laser"

ITEM.weaponCategory = "primary"

ITEM.width = 5
ITEM.height = 2

ITEM.weight = 10

ITEM.forceRender = false

function ITEM:CanEquip(client)
	local character = client:GetCharacter()
	if character and (
		character.vars.class == "replika_mnhr"
		or character.vars.class == "replika_sapr"
		or character.vars.class == "replika_fklr"
		or character.vars.class == "replika_lstr"
		or character.vars.class == "replika_star"
		or character.vars.class == "replika_stcr"
		or character.vars.class == "replika_kncr"
	) then
		return true
	end

	client:NotifyLocalized("weaponTooHeavy")

	return false
end
