
ITEM.name = "ARAR Armor"
ITEM.description = "Bullet-Resistant Armor Plating."
ITEM.category = "Clothing"
ITEM.model = "models/armor/arar_armor.mdl"
ITEM.outfitCategory = "body"

ITEM.bodyGroups = {
	["armor"] = 1
}
ITEM.bodyGroupsUnequipped = {
	["armor"] = 0
}

ITEM.weight = 4

ITEM.width = 2
ITEM.height = 2

function ITEM:CanEquipOutfit(client)
    if client:GetModel() == "models/voxaid/araV2/araV2_pm.mdl" then
        return true
    end

    client:NotifyLocalized("cannotEquipOutfit")
	return false
end
