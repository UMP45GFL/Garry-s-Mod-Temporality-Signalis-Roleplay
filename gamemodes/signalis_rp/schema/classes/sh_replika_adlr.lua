CLASS.name = "ADLR Replika"
CLASS.shortName = "ADLR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false

CLASS.isAdministration = true
CLASS.isProtektor = false

CLASS.isBioresonant = false

CLASS.models = {
	{
		mdl = "models/citric/signalis_adlr/adler_pm.mdl",
		hullMins = Vector(-11, -11, 0),
		hullMaxs = Vector(11, 11, 73),
		gender = "male"
	}
}
CLASS.health = 110
CLASS.physical_damage_taken = 0.82 -- titanium skeleton makes them a bit stronger
CLASS.bullet_damage_taken = 0.72 -- titanium skeleton makes them a bit stronger
CLASS.mental_strength = 1 -- They need many fetish items
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- titanium skeleton makes them more agile
CLASS.speed = 1.07
CLASS.ladder_speed = 1.2
CLASS.jump_power = 1.04 -- short baby
CLASS.max_stamina = 2.05

CLASS.add_max_weight = 5
CLASS.add_inventory_width = 1
CLASS.add_inventory_height = 0

CLASS.talkPitch = 90
CLASS.talkSpeed = 0.65
CLASS.death_sounds = {
	{
		snd = "eternalis/player/death/death_adlr.wav",
		volume = 1,
		sndLevel = 100,
		pitch = 100
	}
}

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 1
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 4
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 3

CLASS.description = {
	[[Administration-, Datenverarbeitung-, Logistik-Replika
- 'Adler' -
(Administration, Data Processing, Logistics Replika 'Eagle')
Type: Generation 5 High Command Specialist
Frame: Biomechanical with Polyethylene Shell and Titanium Skeleton
Height: 175 cm]],

	[[An integral part of every Protektor Führungskommando is the Administrator unit.
A single ADLR unit can manage and oversee all the administrative tasks for an entire facility, freeing other Operational Command units to focus on the direct control of Protektor units.
The Adler is designed to work as a direct counterpart to the Falke Unit, serving as her adjutant by taking care of necessary paperwork and calculations.]]
}

CLASS_REPLIKA_ADLR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ration_k4", 1)
	inventory:Add("id_adlr", 1, {
		skin = 8,
		name = character:GetName(),
		charId = character:GetID(),
		issued = Schema:GetSignalisDate()
	})
	inventory:Add("paper", 1)
	inventory:Add("paper", 1)
end
