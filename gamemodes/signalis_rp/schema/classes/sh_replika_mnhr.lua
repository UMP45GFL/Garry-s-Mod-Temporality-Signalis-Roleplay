CLASS.name = "MNHR Replika"
CLASS.shortName = "MNHR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false

CLASS.isAdministration = false
CLASS.isProtektor = false

CLASS.isBioresonant = false

CLASS.models = {
	{
		mdl = "models/voxaid/signalis_mynah/mynah_pm.mdl",
		hullMins = Vector(-20, -20, 0),
		hullMaxs = Vector(20, 20, 100),
		gender = "female"
	}
}
CLASS.health = 200
CLASS.armor = 0
CLASS.physical_damage_taken = 0.9
CLASS.bullet_damage_taken = 0.75
CLASS.mental_strength = 1.4 -- said to be the most stable unit
CLASS.hunger = 0.95
CLASS.thirst = 0.95
CLASS.speed = 0.82
CLASS.ladder_speed = 1
CLASS.jump_power = 0.7
CLASS.max_stamina = 1.75

CLASS.add_max_weight = 15
CLASS.add_inventory_width = 1
CLASS.add_inventory_height = 1

CLASS.talkPitch = 103
CLASS.talkSpeed = 0.85
CLASS.death_sounds = {
	{
		snd = "eternalis/player/death/death_mnhr.wav",
		volume = 1,
		sndLevel = 100,
		pitch = 100
	}
}
CLASS.breathing_sound = {
	snd = "eternalis/player/breathing/breathing_female.wav",
	volume = 1,
	sndLevel = 60,
	pitch = 97
}

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 3
CLASS.min_weapon_knowledge = 1
CLASS.max_weapon_knowledge = 4
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 2

CLASS.description = {
	[[Minenarbeit-, Nukleartechnik-, Hochsicherheits-Replika
- 'Mynah' -
(Mining, Nuclear Tech, High-Security Replika 'Mynah')
Type: Generation 3 Industrial Specialist
Frame: Biomechanical with High-Security Reinforced Armor-Plated Servoshell
Height: 260 cm]],

[[When it comes to dangerous cargo, heavy machinery and hazardous environments, no other model rivals the MNHR units with their high-security power armor bodies.
Even in lethal radiation, under crushing pressure and in zero G, they keep their calm demeanor and show exemplary teamwork.
Despite their hulking bodies, underneath their face shields a standard Generation 3 Cranial Construction can be found, making maintenance and social interfacing as easy as with any other Replika Model.]]
}

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
