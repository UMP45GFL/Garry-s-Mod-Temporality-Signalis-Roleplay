
FACTION.name = "Replika"
FACTION.description = "A biomechanical human made by AEON."
FACTION.color = Color(194, 54, 8, 255)
FACTION.isDefault = false

function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)

	inventory:Add("suitcase", 1)
	inventory:Add("cid", 1, {
		name = character:GetName(),
		id = id
	})
end

FACTION_REPLIKA = FACTION.index
