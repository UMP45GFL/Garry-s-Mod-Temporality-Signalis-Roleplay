
FACTION.name = "Gestalt"
FACTION.description = "A non-Replika humanoid." --Gestalt names and bios are private (to varying degrees) and can be shared with surrounding players by pressing F3. Cut for now, add later if visible?
FACTION.color = Color(52, 146, 235, 255)
FACTION.isDefault = true
FACTION.availableByDefault = true

function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)

	inventory:Add("ration_k4", 1)
	inventory:Add("id_card", 1, {
		skin = 0,
		name = character:GetName()
	})

	/*
	inventory:Add("suitcase", 1)
	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
	*/
end

FACTION_GESTALT = FACTION.index
