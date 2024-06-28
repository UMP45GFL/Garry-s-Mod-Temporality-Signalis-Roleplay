CLASS.name = "FKLR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {
	{
		mdl = "models/citric/signalis_fklr/falke_pm.mdl",
		hullMins = Vector(-13, -13, 0),
		hullMaxs = Vector(13, 13, 95)
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
CLASS.speed = 1.12
CLASS.jump_power = 1.36
CLASS.max_stamina = 1.15

-- attributes
CLASS.weapon_knowledge = 3
CLASS.min_weapon_knowledge = 2
CLASS.max_weapon_knowledge = 6
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 4

CLASS_REPLIKA_FKLR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
