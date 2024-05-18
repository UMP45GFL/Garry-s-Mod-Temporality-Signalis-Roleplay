CLASS.name = "ADLR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {"models/citric/signalis_adlr/adler_pm.mdl"}
CLASS.health = 110
CLASS.armor = nil
CLASS.physical_damage_taken = 0.82 -- titanium skeleton makes them a bit stronger
CLASS.bullet_damage_taken = 0.72 -- titanium skeleton makes them a bit stronger
CLASS.mental_strength = 1 -- They need many fetish items
CLASS.hunger = 0.9
CLASS.thirst = 0.9
-- titanium skeleton makes them more agile
CLASS.speed = 1.07
CLASS.jump_power = 1.04 -- short baby
CLASS.max_stamina = 1.05
CLASS_REPLIKA_ADLR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
