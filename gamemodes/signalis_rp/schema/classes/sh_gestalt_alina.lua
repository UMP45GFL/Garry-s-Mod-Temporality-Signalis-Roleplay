CLASS.name = "Alina Seo"
CLASS.faction = FACTION_GESTALT
CLASS.isDefault = false
CLASS.availableByDefault = false

CLASS.models = {
    {
        mdl = "models/voxaid/alina/alina_pm.mdl",
        hullMins = Vector(-10, -10, 0),
        hullMaxs = Vector(10, 10, 59),
        --bodygroups = "01",
		gender = "female"
    }
}
CLASS.health = 70 -- amount of health the player has
CLASS.physical_damage_taken = 1 --  multiplier of how much damage the player receives from fall damage, prop damage, physical/melee attacks
CLASS.bullet_damage_taken = 1 --  multiplier of how much damage the player receives from bullet damage
CLASS.mental_strength = 1 -- multiplier of how strong the character is mentally, will affect persona degradation and trauma, how fast they heal
CLASS.hunger = 1 -- multiplier of how fast the hunger of the player will increase
CLASS.thirst = 1 -- multiplier of how fast the thirst of the player will increase
CLASS.speed = 1.05 -- multiplier of how fast the player can run
CLASS.ladder_speed = 1 -- multiplier of how fast the player can climb ladders
CLASS.jump_power = 0.95 -- multiplier of how strong the player can jump
CLASS.max_stamina = 1 -- multiplier of how much stamina the player has

CLASS.description = {""}

CLASS.breathing_sound = function(ply)
    return SIGNALIS_FEMALE_BREATHING_SOUNDS
end

CLASS.death_sounds = function(ply)
    return SIGNALIS_FEMALE_DEATH_SOUNDS
end

CLASS.talkPitch = 105
CLASS.talkSpeed = 0.82

-- attributes
CLASS.remove_attributes = true

CLASS.weapon_knowledge = 0
CLASS.min_weapon_knowledge = 0
CLASS.max_weapon_knowledge = 0
CLASS.medical_knowledge = 0
CLASS.min_medical_knowledge = 0
CLASS.max_medical_knowledge = 0

CLASS_ALINA = CLASS.index

function CLASS:OnCharacterCreated(client, character)
	local inventory = character:GetInventory()

	inventory:Add("pilotka", 1, {
		equip = true
	})
end
