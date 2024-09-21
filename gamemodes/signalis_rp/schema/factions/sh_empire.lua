
FACTION.name = "Eusan Empire"
FACTION.description = "The Eusan Empire which is at war with the Eusan Nation."
FACTION.color = Color(252, 194, 3, 255)
FACTION.isDefault = false
FACTION.availableByDefault = false
FACTION.isGloballyRecognized = false

function FACTION:OnCharacterCreated(client, character)
	local id = Schema:ZeroNumber(math.random(1, 99999), 5)
	local inventory = character:GetInventory()

	character:SetData("cid", id)
end

FACTION_EMPIRE = FACTION.index
