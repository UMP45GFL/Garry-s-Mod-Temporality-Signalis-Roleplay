CLASS.name = "Gestalt"
CLASS.faction = FACTION_GESTALT
CLASS.isDefault = true
CLASS.models = {
    "models/voxaid/alina/alina_pm.mdl",
    "models/citric/signalis_ariane/ariane_pm.mdl",
    "models/voxaid/isa/isa_pm.mdl"
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
CLASS_GESTALT = CLASS.index
