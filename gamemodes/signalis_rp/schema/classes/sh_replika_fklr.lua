CLASS.name = "FKLR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {"models/citric/signalis_fklr/falke_pm.mdl"}
CLASS.health = 150
CLASS.armor = "bullet_resistant_armor_plating"
CLASS.physical_damage_taken = 0.75
CLASS.bullet_damage_taken = 0.65
CLASS.mental_strength = 1.35
CLASS.hunger = 0.87
CLASS.thirst = 0.87
-- SUPER TALL
CLASS.speed = 1.12
CLASS.jump_power = 1.36
CLASS.max_stamina = 1.15
CLASS_REPLIKA_FKLR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
