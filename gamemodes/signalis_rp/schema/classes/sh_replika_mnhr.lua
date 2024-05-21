CLASS.name = "MNHR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {
	{
		mdl = "models/voxaid/signalis_mynah/mynah_pm.mdl",
		hullMins = Vector(-20, -20, 0),
		hullMaxs = Vector(20, 20, 100)
	}
}
CLASS.health = 200
CLASS.armor = 0
CLASS.physical_damage_taken = 0.9
CLASS.bullet_damage_taken = 0.75
CLASS.mental_strength = 1.35
CLASS.hunger = 0.95
CLASS.thirst = 0.95
CLASS.speed = 0.65
CLASS.jump_power = 0.7
CLASS.max_stamina = 0.75
CLASS_REPLIKA_MNHR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
