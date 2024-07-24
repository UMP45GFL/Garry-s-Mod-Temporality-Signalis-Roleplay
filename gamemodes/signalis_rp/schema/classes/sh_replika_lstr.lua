CLASS.name = "LSTR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {
	{
		mdl = "models/citric/signalis_lstr/elster_pm.mdl",
		hullMins = Vector(-12, -12, 0),
		hullMaxs = Vector(12, 12, 70),
        skin = "3"
	}
}
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

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 4
CLASS.min_weapon_knowledge = 2
CLASS.max_weapon_knowledge = 6
CLASS.medical_knowledge = 1
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 5

CLASS_REPLIKA_LSTR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
