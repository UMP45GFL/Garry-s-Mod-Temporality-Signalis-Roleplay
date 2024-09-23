
ITEM.name = "AVA Suit"
ITEM.description = "Environmental suit used for protection from the harsh environments."
ITEM.category = "Clothing"
ITEM.model = "models/eternalis/items/equipment/ava_suit.mdl"
ITEM.outfitCategory = "body"

ITEM.bodyGroups = {
	["hat"] = 2,
	["body"] = 2,
	["ava backpack"] = 1,
	["tasche"] = 0,
}

ITEM.weight = 8

ITEM.width = 2
ITEM.height = 4

ITEM.iconCam = {
    pos = Vector(-50, 0, 31),
    ang = Angle(0, 0, 0),
    fov = 36
}

-- lua_run_cl FORCE_ICONCAM = { pos = Vector(-10, -5, -1), ang = Angle(0, 30, 180), fov = 55 }

function ITEM:CanEquipOutfit(client)
    local character = client:GetCharacter()

    /*
    local items = char:GetInventory():GetItems()
    for _, v in pairs(items) do
        if (v.uniqueID and v.uniqueID == "armor_lstr" and v:GetData("equip")) then
            return false
        end
    end
    */

    if character and (character.vars.class == "replika_lstr") then
        return true
    end

    client:NotifyLocalized("cannotEquipOutfit")
	return false
end
