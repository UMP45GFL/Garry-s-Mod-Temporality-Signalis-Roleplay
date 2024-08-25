CLASS.name = "LSTR Replika"
CLASS.shortName = "LSTR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false
CLASS.models = {
	{
		mdl = "models/citric/signalis_lstr/elster_pm.mdl",
		hullMins = Vector(-12, -12, 0),
		hullMaxs = Vector(12, 12, 70),
        skin = "0",
		gender = "female"
	}
}
CLASS.health = 115
CLASS.armor = nil
CLASS.physical_damage_taken = 0.7 -- carbon fiber-reinforced shell
CLASS.bullet_damage_taken = 0.7 -- carbon fiber-reinforced shell
CLASS.mental_strength = 1.4 -- "tough and stoic loners"
CLASS.hunger = 0.76
CLASS.thirst = 0.76
-- titanium skeleton makes them more agile
-- carbon fiber-reinforced Polyethylene Shell is lighter than regular Polyethylene Shell
CLASS.speed = 1.1
CLASS.jump_power = 1.15
CLASS.max_stamina = 2.15

CLASS.death_sounds = {
	{
		snd = "eternalis/player/death/death_eulr.wav",
		volume = 0.95,
		sndLevel = 100,
		pitch = 92
	}
}
CLASS.breathing_sound = {
	snd = "eternalis/player/breathing/breathing_female.wav",
	volume = 1,
	sndLevel = 62,
	pitch = 96
}

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 4
CLASS.min_weapon_knowledge = 2
CLASS.max_weapon_knowledge = 6
CLASS.medical_knowledge = 1
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 5

CLASS.description = {
	[[Landvermessungs-/Schiff-Techniker Replika
- 'Elster' -
(Land Survey/Ship Technician Replika 'Magpie')
Type: Generation 5 Kosmo-Pioneer Specialist
Frame: Biomechanical with carbon fiber-reinforced Polyethylene Shell and Titanium Skeleton
Height: 178 cm]],

	[[A versatile combat engineer unit primarily designed for orbital service.
These tough and stoic loners are best suited as specialist Sappers and Scouts.
Their technical knowledge and combat capabilities make these units true survivalists, especially when in their iconic white-and-blue heavy combat configuration, which sports bullet-resistant armor plating on their chest and forearms.
Since the original neural pattern for this unit was lost with the destruction of the central Neural Archive on Vineta, new LSTR units have been produced based on a decommissioned unit from the Penrose Program.]]
}

CLASS_REPLIKA_LSTR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()
	
	inventory:Add("ration_k4", 1)
	inventory:Add("id_lstr", 1, {
		skin = 9,
		name = character:GetName()
	})
end
