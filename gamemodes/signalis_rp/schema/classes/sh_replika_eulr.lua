CLASS.name = "EULR Replika"
CLASS.shortName = "EULR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false
CLASS.models = {
	{
		mdl = "models/voxaid/signalis_eule/eule_pm.mdl",
		hullMins = Vector(-10, -10, 0),
		hullMaxs = Vector(10, 10, 70),
		gender = "female"
	}
}
CLASS.health = 100
CLASS.armor = nil
CLASS.physical_damage_taken = 0.9
CLASS.bullet_damage_taken = 0.75
CLASS.mental_strength = 1
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- eules are regular in their mobility
CLASS.speed = 1
CLASS.jump_power = 1
CLASS.max_stamina = 1

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 0
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 2
CLASS.medical_knowledge = 2
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 4

CLASS.description = {
	[[Einfache Universelle Leichte Replika
- 'Eule' -
(Simple Universal Light Replika 'Owl')
Type: Generation 4 Low-Cost General Purpose
Frame: Biomechanical with Polyethylene Shell
Height: 175 cm]],

	[[EULR units are the backbone of the Eusan Nation's workforce.
These elegant multi-purpose worker units are suited for all kinds of domestic tasks like cleaning, cooking, and simple medical and office work.
Eules are highly social and get along well with each other as well as most other Replika Models.
While unfit for combat, their lightweight frame makes them a prime choice for distant facilities where supplies are limited.]]
}

CLASS_REPLIKA_EULR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ration_k4", 1)
	inventory:Add("id_eulr", 1, {
		skin = 5,
		name = character:GetName()
	})
end
