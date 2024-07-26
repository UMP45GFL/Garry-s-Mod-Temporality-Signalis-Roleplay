CLASS.name = "STCR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {
	{
		mdl = "models/citric/signalis_stcr/stcr_pm.mdl",
		hullMins = Vector(-13, -13, 0),
		hullMaxs = Vector(13, 13, 92)
	}
}
CLASS.health = 130 -- they are a bit more robust
CLASS.armor = "bullet_resistant_armor_plating"
CLASS.physical_damage_taken = 0.87 -- replikas take less physical damage by default
CLASS.bullet_damage_taken = 0.72 -- replikas take less bullet damage by default
CLASS.mental_strength = 1.2 -- They definitely have a bit higher mental strength
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- they TALL and STRONK
CLASS.speed = 1.04
CLASS.jump_power = 1.32
CLASS.max_stamina = 1.05

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 4
CLASS.weapon_noStartBonus = true
CLASS.medical_knowledge = 0
CLASS.medical_noStartBonus = true

CLASS_REPLIKA_STCR = CLASS.index

function CLASS:OnSet(client)
end

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("ration_k4", 1)
	inventory:Add("id_card", 1, {
		skin = 6,
		name = character:GetName()
	})
end
