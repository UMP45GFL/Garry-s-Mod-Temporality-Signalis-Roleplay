CLASS.name = "ARAR Replika"
CLASS.shortName = "ARAR"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = false
CLASS.models = {
	{
		mdl = "models/voxaid/signalis_arar/arar_pm.mdl",
		hullMins = Vector(-12, -12, 0),
		hullMaxs = Vector(12, 12, 75),
		gender = "female"
	},
	/*
	{
		mdl = "models/voxaid/araV2/araV2_pm.mdl",
		hullMins = Vector(-12, -12, 0),
		hullMaxs = Vector(12, 12, 75),
		gender = "female"
	}
	*/
}
CLASS.health = 120
CLASS.armor = nil
CLASS.physical_damage_taken = 0.7 -- titanium reinforced shell
CLASS.bullet_damage_taken = 0.7 -- titanium reinforced shell
CLASS.mental_strength = 0.92 -- arars are a bit more unstable...
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- titanium shell makes them less mobile
CLASS.speed = 0.9
CLASS.jump_power = 0.9 -- not as bad because they are tall
CLASS.max_stamina = 0.87

CLASS.death_sounds = {
	{
		snd = "eternalis/player/death/death_stcr.wav",
		volume = 1,
		sndLevel = 100,
		pitch = 105
	}
}

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 0
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 3
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 3

CLASS.description = {
	[[Allzweck-Reparatur-Arbeiter Replika
- 'Ara' -
(All-Purpose Repair Worker Replika 'Macaw')
Type: Generation 2 Low-Cost General Purpose
Frame: Biomechanical with Titanium-Reinforced Polyethylene Shell
Height: 185 cm]],

	[[The tough 'worker bees' of the construction and repair industry.
One of the earlier Replika designs, the simple but efficient Aras are actually the most-produced Replika type to date.
These strong and heavy worker units are a perfect fit for work in construction and production of industrial goods.
In many places throughout our Nation, Aras have already replaced all Gestalt workers in fields like Klimaforming and explosive ordnance disposal.]]
}

CLASS_REPLIKA_ARAR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ration_k4", 1)
	inventory:Add("id_arar", 1, {
		skin = 3,
		name = character:GetName()
	})
end
