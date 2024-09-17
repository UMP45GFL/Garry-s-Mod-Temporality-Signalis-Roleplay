
ITEM.name = "Halo"
ITEM.description = "Bullet-Resistant Armor Plating."
ITEM.category = "Clothing"
ITEM.model = "models/eternalis/items/weapons/fklr_halo.mdl"
ITEM.outfitCategory = "halo"

ITEM.bodyGroups = {
	["halo"] = 0
}
ITEM.bodyGroupsUnequipped = {
	["halo"] = 1
}

ITEM.weight = 0

ITEM.width = 1
ITEM.height = 1

function ITEM:CanEquipOutfit(client)
    local character = client:GetCharacter()
    if character and character.vars.class == "replika_fklr" then
        return true
    end

    client:NotifyLocalized("cannotEquipOutfit")
	return false
end
