CLASS.name = "Gestalt"
CLASS.faction = FACTION_GESTALT
CLASS.isDefault = true
CLASS.models = {
    {
        mdl = "models/voxaid/alina/alina_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 59)
    },
    {
        mdl = "models/citric/signalis_ariane/ariane_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 68),
        skin = "2"
    },
    {
        mdl = "models/citric/signalis_ariane/ariane_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 68),
        skin = "1"
    },
    {
        mdl = "models/citric/signalis_ariane/ariane_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 68),
        skin = "0"
    },
    {
        mdl = "models/voxaid/isa/isa_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
    }
}
CLASS.health = 75 -- amount of health the player has
CLASS.armor = nil -- string of the classname of an armor
CLASS.physical_damage_taken = 1 --  multiplier of how much damage the player receives from fall damage, prop damage, physical/melee attacks
CLASS.bullet_damage_taken = 1 --  multiplier of how much damage the player receives from bullet damage
CLASS.mental_strength = 1 -- multiplier of how strong the character is mentally, will affect persona degradation and trauma, how fast they heal
CLASS.hunger = 1 -- multiplier of how fast the hunger of the player will increase
CLASS.thirst = 1 -- multiplier of how fast the thirst of the player will increase
CLASS.speed = 1 -- multiplier of how fast the player can run
CLASS.jump_power = 1 -- multiplier of how strong the player can jump
CLASS.max_stamina = 1 -- multiplier of how much stamina the player has

-- attributes
CLASS.weapon_knowledge = 0
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 2
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 4

CLASS_GESTALT = CLASS.index
