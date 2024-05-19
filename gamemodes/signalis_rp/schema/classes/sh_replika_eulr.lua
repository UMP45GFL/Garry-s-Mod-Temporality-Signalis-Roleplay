CLASS.name = "EULR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {"models/voxaid/signalis_eule/eule_pm.mdl"}
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
CLASS_REPLIKA_EULR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
