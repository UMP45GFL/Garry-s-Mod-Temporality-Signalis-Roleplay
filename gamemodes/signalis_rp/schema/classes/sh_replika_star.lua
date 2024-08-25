CLASS.name = "STAR Replika"
CLASS.shortName = "STAR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false
CLASS.models = {
	{
		mdl = "models/voxaid/signalis_star/star_pm.mdl",
		hullMins = Vector(-12, -12, 0),
		hullMaxs = Vector(12, 12, 86),
		gender = "female"
	}
}
CLASS.health = 120 -- they are a bit more robust
CLASS.armor = "bullet_resistant_armor_plating"
CLASS.physical_damage_taken = 0.9
CLASS.bullet_damage_taken = 0.75
CLASS.mental_strength = 1.2 -- They definitely have a bit higher mental strength
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- they TALL and STRONK
CLASS.speed = 1.05
CLASS.jump_power = 1.25
CLASS.max_stamina = 2.07

CLASS.death_sounds = {
	{
		snd = "eternalis/player/death/death_stcr.wav",
		volume = 1,
		sndLevel = 120,
		pitch = 100
	}
}
CLASS.breathing_sound = {
	snd = "eternalis/player/breathing/breathing_female.wav",
	volume = 1,
	sndLevel = 65,
	pitch = 93
}

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 4
CLASS.min_weapon_knowledge = 2
CLASS.max_weapon_knowledge = 6
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 3

CLASS.description = {
	[[Sicherheitstechniker-Aufseher-Replika
- 'Star' -
(Security Technician Guard Replika 'Starling')
Type: Generation 4 Low-Cost Combat Unit
Frame: Biomechanical with Polyethylene Shell and Bullet-Resistant Armor Plating
Height: 220cm]],

	[[The Standard model of the Protektor Security Technicians.
Fitted with extended legs, STAR units gracefully tower over most Gestalts.
Despite their heavy armor, they can move swiftly with their long stride.
Their cool and detached demeanor allows them to analyze situations with objectivity and deploy force as required.
Trained in close combat and riot control techniques, they operate best in small squads led by an officer STAR unit equipped with a ballistic shield.]]
}

CLASS_REPLIKA_STAR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	
	inventory:Add("cigarettes", 1)
	inventory:Add("ration_k4", 1)

	local idCard = inventory:Add("id_star", 1, {
		skin = 1,
		name = character:GetName()
	})
	idCard.skin = 1
end
