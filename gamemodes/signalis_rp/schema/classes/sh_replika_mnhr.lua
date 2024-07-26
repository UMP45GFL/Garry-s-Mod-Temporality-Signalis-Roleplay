CLASS.name = "MNHR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {
	{
		mdl = "models/voxaid/signalis_mynah/mynah_pm.mdl",
		hullMins = Vector(-20, -20, 0),
		hullMaxs = Vector(20, 20, 100)
	}
}
CLASS.health = 200
CLASS.armor = 0
CLASS.physical_damage_taken = 0.9
CLASS.bullet_damage_taken = 0.75
CLASS.mental_strength = 1.35
CLASS.hunger = 0.95
CLASS.thirst = 0.95
CLASS.speed = 0.65
CLASS.jump_power = 0.7
CLASS.max_stamina = 0.75

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 3
CLASS.min_weapon_knowledge = 1
CLASS.max_weapon_knowledge = 4
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 2

CLASS_REPLIKA_MNHR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ration_k4", 1)
	inventory:Add("id_card", 1, {
		skin = 4,
		name = character:GetName()
	})
end
