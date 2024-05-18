CLASS.name = "LSTR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {"models/citric/signalis_lstr/elster_pm.mdl"}
CLASS.health = 115
CLASS.armor = nil
CLASS.physical_damage_taken = 0.7 -- carbon fiber-reinforced shell
CLASS.bullet_damage_taken = 0.7 -- carbon fiber-reinforced shell
CLASS.mental_strength = 1.4 -- "tough and stoic loners"
CLASS.hunger = 0.76
CLASS.thirst = 0.76
-- titanium skeleton makes them more agile
-- carbon fiber-reinforced Polyethylene Shell is lighter than regular Polyethylene Shell
CLASS.speed = 1.15
CLASS.jump_power = 1.15
CLASS.max_stamina = 1.15
CLASS_REPLIKA_LSTR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
