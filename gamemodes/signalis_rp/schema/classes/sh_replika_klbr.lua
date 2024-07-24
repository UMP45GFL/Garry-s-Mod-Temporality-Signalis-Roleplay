CLASS.name = "KLBR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {
	{
		mdl = "models/voxaid/signalis_kolibri/kolibri_pm.mdl",
		hullMins = Vector(-10, -10, 0),
		hullMaxs = Vector(10, 10, 60)
	}
}
CLASS.health = 115
--CLASS.armor = "bullet_resistant_armor_plating", TODO
CLASS.physical_damage_taken = 0.9
CLASS.bullet_damage_taken = 0.75
CLASS.mental_strength = 0.8 -- definitely the least strong mentally replika...
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- they short and agile
CLASS.speed = 1.15
CLASS.jump_power = 0.87
CLASS.max_stamina = 1.15

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 4
CLASS.min_weapon_knowledge = 1
CLASS.max_weapon_knowledge = 5
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 4

CLASS_REPLIKA_KLBR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
