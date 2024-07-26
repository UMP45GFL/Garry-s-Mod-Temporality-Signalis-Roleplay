CLASS.name = "EULR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {
	{
		mdl = "models/voxaid/signalis_eule/eule_pm.mdl",
		hullMins = Vector(-10, -10, 0),
		hullMaxs = Vector(10, 10, 70),
	}
}
CLASS.health = 100
CLASS.armor = nil
CLASS.physical_damage_taken = 0.9
CLASS.bullet_damage_taken = 0.75
CLASS.mental_strength = 1
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- eules are regular in their mobility
CLASS.speed = 1
CLASS.jump_power = 1
CLASS.max_stamina = 1

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 0
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 2
CLASS.medical_knowledge = 2
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 4

CLASS_REPLIKA_EULR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ration_k4", 1)
	inventory:Add("id_card", 1, {
		skin = 5,
		name = character:GetName()
	})
end
