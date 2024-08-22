
ATTRIBUTE.name = "Weapon Knowledge"
ATTRIBUTE.description = "Your affinity for weapons."

ATTRIBUTE.minPossibleValue = 0
ATTRIBUTE.minValue = function(class)
    return class.min_weapon_knowledge
end

ATTRIBUTE.maxPossibleValue = 6
ATTRIBUTE.maxValue = function(class)
    return class.max_weapon_knowledge
end

ATTRIBUTE.defaultValue = function(class)
    return class.weapon_knowledge
end

ATTRIBUTE.noStartBonus = function(class)
    return class.weapon_noStartBonus
end

local spread_multipliers_for_level = {
    [0] = 1.8,
    [1] = 1.5,
    [2] = 1.3,
    [3] = 1.1,
    [4] = 1,
    [5] = 0.9,
    [6] = 0.85
}

ATTRIBUTE.CalculateSpread = function(character, spread)
    if !ix.config.Get("weaponProficiencySpread", true) then return spread end

    local attrib = character:GetAttribute("weapon", 0)

    if spread_multipliers_for_level[attrib] == nil then
        print("Invalid spread weapon attribute value: " .. attrib)
        return spread
    end

    return spread * spread_multipliers_for_level[attrib]
end

local recoil_multipliers_for_level = {
    [0] = 2.5,
    [1] = 1.9,
    [2] = 1.5,
    [3] = 1.1,
    [4] = 1,
    [5] = 0.9,
    [6] = 0.85
}

ATTRIBUTE.CalculateRecoil = function(character, recoil)
    if !ix.config.Get("weaponProficiencyRecoil", true) then return recoil end

    local attrib = character:GetAttribute("weapon", 0)

    if recoil_multipliers_for_level[attrib] == nil then
        print("Invalid recoil weapon attribute value: " .. attrib)
        return recoil
    end

    return recoil * recoil_multipliers_for_level[attrib]
end

local anim_time_multipliers_for_level = {
    [0] = 1.2,
    [1] = 1.15,
    [2] = 1.1,
    [3] = 1.05,
    [4] = 1,
    [5] = 0.95,
    [6] = 0.9
}

ATTRIBUTE.CalculateAnimTime = function(character, animation, time)
    if !ix.config.Get("weaponProficiencyAnimations", true) then return time end

    if string.find(animation, "idle") || string.find(animation, "fire") || string.find(animation, "ready") then return time end

    local attrib = character:GetAttribute("weapon", 0)

    -- Get the multiplier for the current attribute value
    local multiplier = anim_time_multipliers_for_level[attrib] or 1  -- Default to 1 if attribute is out of bounds

    --print("time: " .. time ..  " multiplier: " .. multiplier .. " (attrib: ".. attrib ..")")

    return time * multiplier
end

-- lua_run print(Entity(1):GetCharacter():GetAttribute("weapon", 0))
-- lua_run print(Entity(1):GetCharacter():SetAttrib("weapon", 0))
