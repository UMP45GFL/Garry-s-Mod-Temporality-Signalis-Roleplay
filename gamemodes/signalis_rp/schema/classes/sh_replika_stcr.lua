CLASS.name = "STCR Replika"
CLASS.shortName = "STCR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false

CLASS.isAdministration = false
CLASS.isProtektor = true

CLASS.isBioresonant = false

CLASS.models = {
	{
		mdl = "models/citric/signalis_stcr/stcr_pm.mdl",
		hullMins = Vector(-13, -13, 0),
		hullMaxs = Vector(13, 13, 92),
        skin = "0",
		gender = "female"
	},
	{
		mdl = "models/citric/signalis_stcr/stcr_pm.mdl",
		hullMins = Vector(-13, -13, 0),
		hullMaxs = Vector(13, 13, 92),
        skin = "2",
		gender = "female",
        canUse = function(ply) return ply:IsStaff() end
	},
}
CLASS.health = 130 -- they are a bit more robust
CLASS.physical_damage_taken = 0.87 -- replikas take less physical damage by default
CLASS.bullet_damage_taken = 0.72 -- replikas take less bullet damage by default
CLASS.mental_strength = 0.9 -- It is said in signalis that they are more unstable
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- they TALL and STRONK
CLASS.speed = 1.04
CLASS.ladder_speed = 1.25
CLASS.jump_power = 1.32
CLASS.max_stamina = 2.05

CLASS.add_max_weight = 9
CLASS.add_inventory_width = 1
CLASS.add_inventory_height = 0

CLASS.talkPitch = 90
CLASS.talkSpeed = 0.8
CLASS.death_sounds = {
	{
		snd = "eternalis/player/death/death_stcr.wav",
		volume = 1,
		sndLevel = 110,
		pitch = 100
	}
}
CLASS.breathing_sound = {
	snd = "eternalis/player/breathing/breathing_female.wav",
	volume = 1,
	sndLevel = 65,
	pitch = 90
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

CLASS.description = {
	[[Sicherheitstechniker-Controller-Replika
- 'Storch' -
(Security Technician Controller Replika 'Stork')
Type: Generation 5 Combat Lead Unit
Frame: Biomechanical with Polyethylene Shell and Bullet-Resistant Armor Plating
Height: 240cm]],

	[[Each Cadre of Protektor Security Technicians is overseen by a Controller Unit, the most common of which is the STCR "Stork" Type.
One of the tallest Replika models thanks to their extended legs, Storks figuratively and literally keep a constant birds-eye view of any situation ready to direct and coordinate their assigned Security Technicians.
Their tough, no-nonsense demeanor, though sometimes described as brutal and even cruel, makes them the perfect fit as unwavering sentinels of order.]]
}

CLASS_REPLIKA_STCR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ration_k4", 1)
	inventory:Add("id_stcr", 1, {
		skin = 6,
		name = character:GetName(),
		charId = character:GetID(),
		issued = Schema:GetSignalisDate()
	})
	inventory:Add("armor_stcr", 1, {
		equip = true
	})
	inventory:Add("baton", 1)
end
