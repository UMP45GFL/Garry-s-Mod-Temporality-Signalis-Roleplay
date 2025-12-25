
ITEM.name = "STAR Mask"
ITEM.description = "Face-covering mask for STAR units."
ITEM.category = "Clothing"
ITEM.model = "models/eternalis/items/equipment/star_mask.mdl"
ITEM.outfitCategory = "mask"

ITEM.bodyGroups = {
	["mask"] = 1
}
ITEM.bodyGroupsUnequipped = {
	["mask"] = 0
}

ITEM.weight = 1

ITEM.width = 1
ITEM.height = 1

function ITEM:CanEquipOutfit(client)
    local character = client:GetCharacter()
    if character and (
        character.vars.class == "replika_star"
    ) then
        return true
    end

    client:NotifyLocalized("cannotEquipOutfit")
	return false
end
