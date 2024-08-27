
function Schema:CanPlayerUseBusiness(client, uniqueID)
	if (client:Team() == FACTION_GESTALT or client:Team() == FACTION_REPLIKA) then
		local itemTable = ix.item.list[uniqueID]

		if (itemTable) then
			if (itemTable.permit) then
				local character = client:GetCharacter()
				local inventory = character:GetInventory()

				if (!inventory:HasItem("permit_"..itemTable.permit)) then
					return false
				end
			elseif (itemTable.base ~= "base_permit") then
				return false
			end
		end
	end
end

function Schema:CanDrive()
	return false
end
