CLASS.name = "FKLR Replika"
CLASS.shortName = "FKLR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false
CLASS.models = {
	{
		mdl = "models/citric/signalis_fklr/falke_pm.mdl",
		hullMins = Vector(-13, -13, 0),
		hullMaxs = Vector(13, 13, 95),
		gender = "female"
	}
}
CLASS.health = 150
CLASS.armor = "bullet_resistant_armor_plating"
CLASS.physical_damage_taken = 0.75
CLASS.bullet_damage_taken = 0.65
CLASS.mental_strength = 1.35
CLASS.hunger = 0.87
CLASS.thirst = 0.87
-- SUPER TALL
CLASS.speed = 1.1
CLASS.jump_power = 1.36
CLASS.max_stamina = 1.15

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 3
CLASS.min_weapon_knowledge = 2
CLASS.max_weapon_knowledge = 6
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 4

CLASS.description = {
	[[Führungskommando-Leiteinheit-Replika
- 'Falke' -
(Operational Command Control Unit Replika 'Falcon')
Type: Generation 6 High-Tech Bioresonance Command Unit
Frame: Biomechanical with Polyethylene Shell and Bullet-Resistant Armor Plating
Height: 250 cm]]
}

CLASS_REPLIKA_FKLR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	
	inventory:Add("ration_k4", 1)
	inventory:Add("id_fklr", 1, {
		skin = 7,
		name = character:GetName()
	})
end
