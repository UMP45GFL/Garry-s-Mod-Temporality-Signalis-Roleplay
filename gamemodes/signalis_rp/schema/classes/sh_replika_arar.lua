CLASS.name = "ARAR Replika"
CLASS.faction = FACTION_REPLIKA
CLASS.isDefault = false
CLASS.models = {"models/voxaid/signalis_arar/arar_pm.mdl"}
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
CLASS_REPLIKA_ARAR = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()
end
