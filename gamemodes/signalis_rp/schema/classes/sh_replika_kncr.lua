CLASS.name = "KNCR Replika"
CLASS.shortName = "KNCR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false

CLASS.isAdministration = false
CLASS.isProtektor = true

CLASS.isBioresonant = false

CLASS.models = {
	{
		mdl = "models/krizhovnik/kncr2.mdl",
		hullMins = Vector(-16, -16, 0),
		hullMaxs = Vector(16, 16, 82),
		gender = "female",
        bodygroups = "01",
	}
}
CLASS.health = 135 -- they are a bit more robust
CLASS.armor = "bullet_resistant_armor_plating"
CLASS.physical_damage_taken = 0.87 -- replikas take less physical damage by default
CLASS.bullet_damage_taken = 0.72 -- replikas take less bullet damage by default
CLASS.mental_strength = 0.9 -- It is said in signalis that they are more unstable
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- they TALL and STRONK
CLASS.speed = 0.97
CLASS.ladder_speed = 1.15
CLASS.jump_power = 1.22
CLASS.max_stamina = 1.9

CLASS.talkPitch = 90
CLASS.talkSpeed = 0.8
CLASS.death_sounds = {
	{
		snd = "eternalis/player/death/death_stcr.wav",
		volume = 1,
		sndLevel = 110,
		pitch = 92
	}
}
CLASS.breathing_sound = {
	snd = "eternalis/player/breathing/breathing_female.wav",
	volume = 1,
	sndLevel = 65,
	pitch = 87
}

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 3
CLASS.min_weapon_knowledge = 2
CLASS.max_weapon_knowledge = 5
CLASS.weapon_noStartBonus = true
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 2
CLASS.medical_noStartBonus = true

CLASS.description = {""}

CLASS_REPLIKA_KNCR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ration_k4", 1)
	inventory:Add("id_kncr", 1, {
		skin = 6, -- TODO: NEEDS TO BE CHANGED
		name = character:GetName()
	})
end
