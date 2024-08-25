CLASS.name = "KLBR Replika"
CLASS.shortName = "KLBR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false
CLASS.models = {
	{
		mdl = "models/voxaid/signalis_kolibri/kolibri_pm.mdl",
		hullMins = Vector(-10, -10, 0),
		hullMaxs = Vector(10, 10, 60),
		gender = "female"
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
CLASS.speed = 1.1
CLASS.jump_power = 0.87
CLASS.max_stamina = 2.15

CLASS.death_sounds = {
	{
		snd = "eternalis/player/death/death_eulr.wav",
		volume = 1,
		sndLevel = 100,
		pitch = 100
	}
}
CLASS.breathing_sound = {
	snd = "eternalis/player/breathing/breathing_female.wav",
	volume = 1,
	sndLevel = 60,
	pitch = 110
}

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 4
CLASS.min_weapon_knowledge = 1
CLASS.max_weapon_knowledge = 5
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 4

CLASS.description = {
	[[Kommando-Leiteinheit Bioresonanztechnik-Replika
- 'Kolibri' -
(Command Control Unit Bioresonance Technology Replika 'Hummingbird')
Type: Generation 6 High-Tech Bioresonance Specialist
Frame: Biomechanical with Polyethylene Shell and Bullet-Resistant Armor Plating
Height: 152 cm]]
}

CLASS_REPLIKA_KLBR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ration_k4", 1)
	inventory:Add("id_klbr", 1, {
		skin = 2,
		name = character:GetName()
	})
end
