CLASS.name = "ADLR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {
	{
		mdl = "models/citric/signalis_adlr/adler_pm.mdl",
		hullMins = Vector(-11, -11, 0),
		hullMaxs = Vector(11, 11, 73)
	}
}
CLASS.health = 110
CLASS.armor = nil
CLASS.physical_damage_taken = 0.82 -- titanium skeleton makes them a bit stronger
CLASS.bullet_damage_taken = 0.72 -- titanium skeleton makes them a bit stronger
CLASS.mental_strength = 1 -- They need many fetish items
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- titanium skeleton makes them more agile
CLASS.speed = 1.07
CLASS.jump_power = 1.04 -- short baby
CLASS.max_stamina = 1.05

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 1
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 4
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 3

CLASS_REPLIKA_ADLR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("suitcase", 1)
	inventory:Add("ration_k4", 1)
	inventory:Add("id_card", 1, {
		skin = 8,
		name = character:GetName()
	})
end
