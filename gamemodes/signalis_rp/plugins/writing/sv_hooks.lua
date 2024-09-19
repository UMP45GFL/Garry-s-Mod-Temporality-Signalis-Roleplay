
local PLUGIN = PLUGIN

netstream.Hook("ixWritingEdit", function(client, itemID, pages)
	for k,v in pairs(pages) do
		pages[k] = tostring(v):sub(1, PLUGIN.maxLength)
	end

	local character = client:GetCharacter()
	local item = ix.item.instances[itemID]

	-- we don't check for entity since data can be changed in the player's inventory
	if (character and item and item.base == "base_writing") then
		local owner = item:GetData("owner", 0)

		if (owner == 0 or owner == character:GetID()) then
			item:SetPages(pages, character)
		end
	end
end)

netstream.Hook("ixWritingSetTitle", function(client, itemID, text)
	local character = client:GetCharacter()
	local item = ix.item.instances[itemID]

	-- we don't check for entity since data can be changed in the player's inventory
	if (character and item and item.base == "base_writing") then
		local owner = item:GetData("owner", 0)

		if (owner == character:GetID()) then
			item:SetTitle(item, string.Trim(text))
		end
	end
end)


-- cards
netstream.Hook("ixCardSet", function(client, itemID, dataName, text)
	local character = client:GetCharacter()
	local item = ix.item.instances[itemID]

	if (character and item and item.base == "base_id_cards") then
		local charId = item:GetData("charId", nil)
		local charName = item:GetData(dataName, nil)

        if (charId and charId == character:GetID())
        || (charName and charName == character:GetName())
		|| client:IsAdmin()
        || client:IsUserGroup("operator")
        || client:IsUserGroup("moderator")
        || client:IsUserGroup("gamemaster")
        then
            item:SetData(dataName, string.Trim(text))
			item:SetData("charId", charId)
        end
	end
end)
