
FACTION.name = "Gestalt"
FACTION.description = "A human that is not a replika."
FACTION.color = Color(52, 146, 235, 255)
FACTION.isDefault = true

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
