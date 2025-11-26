
ITEM.name = "Pilotka Hat"
ITEM.description = "A pilotka hat."
ITEM.category = "Clothing"
ITEM.model = "models/eternalis/items/equipment/pilotka_hat.mdl"
ITEM.outfitCategory = "hat"

ITEM.bodyGroups = function(item, client)
    local character = client:GetCharacter()
    if character and character.vars.class == "replika_lstr" then
        return {
            ["hat"] = 1
        }
    end

    return {
        ["hat"] = 0
    }
end

ITEM.bodyGroupsUnequipped = function(item, client)
    local character = client:GetCharacter()
    if character and character.vars.class == "replika_lstr" or character.vars.class == "replika_star" or character.vars.class == "replika_klbr" then
        return {
            ["hat"] = 0
        }
    end

    return {
        ["hat"] = 1
    }
end

ITEM.weight = 1

ITEM.width = 2
ITEM.height = 1

function ITEM:CanEquipOutfit(client)
    local character = client:GetCharacter()
    if character and (
        character.vars.class == "replika_eulr" or
        character.vars.class == "replika_lstr" or
        character.vars.class == "replika_arar" or
        character.vars.class == "replika_klbr" or
        character.vars.class == "replika_stcr" or
        character.vars.class == "replika_star" or
        client:GetModel() == "models/voxaid/alina/alina_pm.mdl"
   ) then
        return true
    end

    client:NotifyLocalized("cannotEquipOutfit")
	return false
end
