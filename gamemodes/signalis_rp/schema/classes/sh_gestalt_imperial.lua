CLASS.name = "Imperial Gestalt"
CLASS.faction = FACTION_EMPIRE
CLASS.isDefault = true
CLASS.models = {
    {
        mdl = "models/voxaid/isa/isa_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "6",
        bodygroups = "11111",
		gender = "female"
    },
}
CLASS.health = 75 -- amount of health the player has
CLASS.physical_damage_taken = 1 --  multiplier of how much damage the player receives from fall damage, prop damage, physical/melee attacks
CLASS.bullet_damage_taken = 1 --  multiplier of how much damage the player receives from bullet damage
CLASS.mental_strength = 1 -- multiplier of how strong the character is mentally, will affect persona degradation and trauma, how fast they heal
CLASS.hunger = 1 -- multiplier of how fast the hunger of the player will increase
CLASS.thirst = 1 -- multiplier of how fast the thirst of the player will increase
CLASS.speed = 1 -- multiplier of how fast the player can run
CLASS.ladder_speed = 1 -- multiplier of how fast the player can climb ladders
CLASS.jump_power = 1 -- multiplier of how strong the player can jump
CLASS.max_stamina = 1 -- multiplier of how much stamina the player has

CLASS.description = {""}

CLASS.breathing_sound = function(ply)
    if ply:IsFemale() then
        return SIGNALIS_FEMALE_BREATHING_SOUNDS
    end
end

CLASS.death_sounds = function(ply)
    if ply:IsFemale() then
        return table.Random(SIGNALIS_FEMALE_DEATH_SOUNDS)
    else
        return table.Random(SIGNALIS_MALE_DEATH_SOUNDS)
    end
end

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 0
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 0
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 0

CLASS_GESTALT = CLASS.index
