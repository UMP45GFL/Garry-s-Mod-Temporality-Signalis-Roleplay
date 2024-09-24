CLASS.name = "Gestalt"
CLASS.faction = FACTION_GESTALT
CLASS.isDefault = true
CLASS.models = {
    {
        mdl = "models/voxaid/isa/isa_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "3",
		gender = "female",
        canUse = function(ply) return ply:IsStaff() end
    },
    {
        mdl = "models/voxaid/isa/isa_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "3",
        bodygroups = "00001",
		gender = "female",
        canUse = function(ply) return ply:IsStaff() end
    },

    /* 
    -- penrose program
    {
        mdl = "models/citric/signalis_ariane/ariane_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 68),
        skin = "2",
		gender = "female"
    },
    -- polytechnical school
    {
        mdl = "models/citric/signalis_ariane/ariane_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 68),
        skin = "1",
		gender = "female"
    },
    -- penrose - cancer :sob:
    {
        mdl = "models/citric/signalis_ariane/ariane_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 68),
        skin = "0",
		gender = "female"
    },
    */

    -- female gestalt - different hair
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
		gender = "female"
    },
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "01",
		gender = "female"
    },
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "02",
		gender = "female"
    },
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "03",
		gender = "female"
    },
    {
        mdl = "models/female/f_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "04",
		gender = "female"
    },


    -- New adlr based gestalt
    {
        mdl = "models/citric/signalis_ADLR/Adler_pm.mdl",
        skin = "3",
		gender = "male"
    },
    {
        mdl = "models/citric/signalis_ADLR/Adler_pm.mdl",
        skin = "4",
		gender = "male"
    },
    {
        mdl = "models/citric/signalis_ADLR/Adler_pm.mdl",
        skin = "9",
		gender = "male"
    },


    -- male gestalt - different hair
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
		gender = "male"
    },
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "01",
		gender = "male"
    },
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "02",
		gender = "male"
    },
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "03",
		gender = "male"
    },
    {
        mdl = "models/male/m_geshtalt.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 70),
        skin = "5",
        bodygroups = "04",
		gender = "male"
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
        return ETERNALIS_FEMALE_BREATHING_SOUNDS
    end
end

CLASS.death_sounds = function(ply)
    if ply:IsFemale() then
        return table.Random(ETERNALIS_FEMALE_DEATH_SOUNDS)
    else
        return table.Random(ETERNALIS_MALE_DEATH_SOUNDS)
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
