
ITEM.name = "ARAR helmet"
ITEM.description = "Helmet that protects the head from injury due to falling objects."
ITEM.category = "Clothing"
ITEM.model = "models/eternalis/items/equipment/arar_helmet.mdl"
ITEM.outfitCategory = "hat"

ITEM.bodyGroups = {
	["helmet"] = 0
}
ITEM.bodyGroupsUnequipped = {
	["helmet"] = 1
}

ITEM.weight = 1

ITEM.width = 2
ITEM.height = 2

function ITEM:CanEquipOutfit(client)
    local character = client:GetCharacter()
    if character and character.vars.class == "replika_arar" then
        return true
    end

    client:NotifyLocalized("cannotEquipOutfit")
	return false
end
