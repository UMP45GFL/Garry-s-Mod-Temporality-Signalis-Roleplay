
ITEM.name = "Envelope"
ITEM.model = Model("models/eternalis/items/library/envelope.mdl")
ITEM.description = "An envelope."
ITEM.category = "Writing"
ITEM.skin = 0

ITEM.invWidth = 1
ITEM.invHeight = 1

ITEM.width = 1
ITEM.height = 1

ITEM.weight = 0.1

ITEM.AcceptableItems = {
    ["paper"] = true,
}

ITEM.AcceptableCategories = {
    ["Photos"] = true,
}

/*
envelope is not sealed, player can put paper in it

then envelope gets sealed,  player can't put paper in it

then envelope gets opened, player can take paper out of it
*/

function ITEM:GetName()
    if self:GetData("sealed", nil) == nil then
        return "Envelope"
    end

	return self:GetData("opened", false) and "Opened envelope" or "Sealed Envelope"
end

function ITEM:GetDescription()
    if self:GetData("sealed", nil) == nil then
        return "An envelope."
    end

	return self:GetData("opened", false) and "An opened envelope." or "A sealed envelope."
end

ITEM.CreatePanel = function(item)
    local index = item:GetData("id", "")

    if (index) then
        local panel = ix.gui["inv"..index]
        local inventory = ix.item.inventories[index]
        local parent = IsValid(ix.gui.menuInventoryContainer) and ix.gui.menuInventoryContainer or ix.gui.openedStorage

        if (IsValid(panel)) then
            panel:Remove()
        end

        if (inventory and inventory.slots) then
            panel = vgui.Create("ixInventory", IsValid(parent) and parent or nil)
            panel:SetInventory(inventory)
            panel:ShowCloseButton(true)
            panel:SetTitle(item.GetName and item:GetName() or L(item.name))
            panel.Think = function(this)
                if item and item:GetData("sealed", false) then
                    this:Remove()
                end
            end

            if (parent != ix.gui.menuInventoryContainer) then
                panel:Center()

                if (parent == ix.gui.openedStorage) then
                    panel:MakePopup()
                end
            else
                panel:MoveToFront()
            end

            ix.gui["inv"..index] = panel
        else
            ErrorNoHalt("[Helix] Attempt to view an uninitialized inventory '"..index.."'\n")
        end
    end
end

ITEM.functions.View = {
	icon = "icon16/briefcase.png",
	OnClick = function(item)
        if item:GetData("sealed", false) then
            return false
        end

        if IsValid(ix.gui.menuInventoryContainer) then
            item:CreatePanel()
        end

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetData("id") and !IsValid(ix.gui["inv" .. item:GetData("id", "")])
        and (item:GetData("opened", false) or !item:GetData("sealed", false))
	end
}

ITEM.functions.combine = {
	OnRun = function(item, data)
		ix.item.instances[data[1]]:Transfer(item:GetData("id"), nil, nil, item.player)

		return false
	end,
	OnCanRun = function(item, data)
        if !item:GetData("sealed", false) then return false end

		local index = item:GetData("id", "")

		if (index) then
			local inventory = ix.item.inventories[index]

			if (inventory) then
				return true
			end
		end

		return false
	end
}

ITEM.functions.Open = {
	OnClick = function(item)
        print(item:GetData("opened", false), item:GetData("sealed", false))

        if !item:GetData("opened", false) and item:GetData("sealed", false) then
            item:CreatePanel()
        end
    end,
	OnRun = function(item)
		item:SetData("opened", true)
		return false
	end,
	OnCanRun = function(item)
        return !item:GetData("opened", false) and item:GetData("sealed", false)
	end
}

ITEM.functions.Seal = {
	OnRun = function(item)
		item:SetData("sealed", true)
		return false
	end,
	OnCanRun = function(item)
        return !item:GetData("sealed", false) and !item:GetData("opened", false)
	end
}
