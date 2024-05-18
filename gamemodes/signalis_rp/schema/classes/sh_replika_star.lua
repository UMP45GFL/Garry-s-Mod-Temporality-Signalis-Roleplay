CLASS.name = "STAR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {"models/voxaid/signalis_star/star_pm.mdl"}
CLASS.health = 120 -- they are a bit more robust
CLASS.armor = "bullet_resistant_armor_plating"
CLASS.physical_damage_taken = 0.9
CLASS.bullet_damage_taken = 0.75
CLASS.mental_strength = 1.2 -- They definitely have a bit higher mental strength
CLASS.hunger = 0.9
CLASS.thirst = 0.9
 -- they TALL and STRONK
CLASS.speed = 1.05
CLASS.jump_power = 1.25
CLASS.max_stamina = 1.07
CLASS_REPLIKA_STAR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
