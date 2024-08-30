
ITEM.name = "Loaf of bread"
ITEM.model = Model("models/foodnhouseholditems/bread-1.mdl")
ITEM.description = "A loaf of bread, it looks delicious."

ITEM.addHunger = -20
ITEM.addThirst = 0
ITEM.addHealth = 7
ITEM.addStamina = 0
ITEM.eatSound = nil

function BreadSliceTemp(item)
    local ply = item.player

    if (IsValid(ply)) then
        local inventory = ply:GetCharacter():GetInventory()
        local breadSlice = inventory:Add("bread_slice")

        if (breadSlice) then
            inventory:Add("bread_slice")
            inventory:Add("bread_slice")
            inventory:Add("bread_slice")
            return true
        end
    end

    return false
end

ITEM.functions.Slice = {
	OnRun = function(item)
        return BreadSliceTemp(item)
	end
}
