CLASS.name = "ARAR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.availableByDefault = true
CLASS.models = {
	{
		mdl = "models/voxaid/signalis_arar/arar_pm.mdl",
		hullMins = Vector(-12, -12, 0),
		hullMaxs = Vector(12, 12, 75)
	},
}
CLASS.health = 120
CLASS.armor = nil
CLASS.physical_damage_taken = 0.7 -- titanium reinforced shell
CLASS.bullet_damage_taken = 0.7 -- titanium reinforced shell
CLASS.mental_strength = 0.92 -- arars are a bit more unstable...
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- titanium shell makes them less mobile
CLASS.speed = 0.85
CLASS.jump_power = 0.9 -- not as bad because they are tall
CLASS.max_stamina = 0.87

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 0
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 3
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 3

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
