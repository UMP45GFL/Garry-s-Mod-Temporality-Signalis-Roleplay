
ATTRIBUTE.name = "Weapon Knowledge"
ATTRIBUTE.description = "Your affinity for weapons."

ATTRIBUTE.minValue = function(class)
    return class.min_weapon_knowledge
end

ATTRIBUTE.maxValue = function(class)
    return class.max_weapon_knowledge
end

ATTRIBUTE.defaultValue = function(class)
    return class.weapon_knowledge
end

ATTRIBUTE.CalculateSpread = function(character, spread)
    if !ix.config.Get("weaponProficiencySpread", true) then return spread end

    local attrib = character:GetAttribute("weapon", 0)
    local multiplier = 1 / (attrib + 1)
    multiplier = math.max(0.7, math.min(multiplier, 6))
    multiplier = multiplier * (6 - attrib)

    --print("spread: " .. spread ..  " multiplier: " .. multiplier .. " (attrib: ".. attrib ..")")
    return spread * multiplier
end

ATTRIBUTE.CalculateRecoil = function(character, recoil)
    if !ix.config.Get("weaponProficiencyRecoil", true) then return recoil end

    local attrib = character:GetAttribute("weapon", 0)
    local multiplier = 1 / (attrib + 1)
    multiplier = math.max(0.7, math.min(multiplier, 6))
    multiplier = multiplier * (6 - attrib)

    --print("recoil: " .. recoil ..  " multiplier: " .. multiplier .. " (attrib: ".. attrib ..")")
    return recoil * multiplier
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
