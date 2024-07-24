
ATTRIBUTE.name = "Medical Knowledge"
ATTRIBUTE.description = "Your affinity for medical items."

ATTRIBUTE.minPossibleValue = 0
ATTRIBUTE.minValue = function(class)
    return class.min_medical_knowledge
end

ATTRIBUTE.maxPossibleValue = 6
ATTRIBUTE.maxValue = function(class)
    return class.max_medical_knowledge
end

ATTRIBUTE.defaultValue = function(class)
    return class.medical_knowledge
end

ATTRIBUTE.noStartBonus = function(class)
    return class.medical_noStartBonus
end
