CLASS.name = "Gestalt"
CLASS.faction = FACTION_GESTALT
CLASS.isDefault = true
CLASS.models = {
    {
        mdl = "models/voxaid/alina/alina_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 59)
    },
    -- penrose program
    {
        mdl = "models/citric/signalis_ariane/ariane_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 68),
        skin = "2"
    },
    /* polytechnical school
    {
        mdl = "models/citric/signalis_ariane/ariane_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 68),
        skin = "1"
    },
    */
    /* penrose - cancer :sob:
    {
        mdl = "models/citric/signalis_ariane/ariane_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 68),
        skin = "0"
    },
    */
    {
        mdl = "models/voxaid/isa/isa_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
    },

    -- female gestalt - different hair
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
    },
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        bodygroups = "01"
    },
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        bodygroups = "02"
    },
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        bodygroups = "03"
    },
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        bodygroups = "04"
    },

    -- male gestalt - different hair
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5"
    },
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "01"
    },
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "02"
    },
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "03"
    },
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "04"
    },
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
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 0
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 0
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 0

CLASS_GESTALT = CLASS.index
