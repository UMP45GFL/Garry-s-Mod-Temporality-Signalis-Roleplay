
--local ragSuffix = "_rag"
local ragSuffix = ""

local moneyAmounts = {
    {value = 1,     amount = 1,     mdl = "models/eternalis/currency/banknote_1"..ragSuffix..".mdl"},
    {value = 2,     amount = 1,     mdl = "models/eternalis/currency/banknote_2"..ragSuffix..".mdl"},
    {value = 5,     amount = 1,     mdl = "models/eternalis/currency/banknote_5"..ragSuffix..".mdl"},
    {value = 10,    amount = 1,     mdl = "models/eternalis/currency/banknote_10"..ragSuffix..".mdl"},
    {value = 20,    amount = 1,     mdl = "models/eternalis/currency/banknote_20"..ragSuffix..".mdl"},
    
    {value = 1,     amount = 10,    mdl = "models/eternalis/currency/banknote_1_cluster.mdl"},
    {value = 2,     amount = 10,    mdl = "models/eternalis/currency/banknote_2_cluster.mdl"},
    {value = 5,     amount = 10,    mdl = "models/eternalis/currency/banknote_5_cluster.mdl"},
    {value = 10,    amount = 10,    mdl = "models/eternalis/currency/banknote_10_cluster.mdl"},
    {value = 20,    amount = 10,    mdl = "models/eternalis/currency/banknote_20_cluster.mdl"},
}

function MoneySort(amount)
    local sortedMoney = {}
    math.randomseed(os.time())

    -- Sort the moneyAmounts table by value in descending order
    table.sort(moneyAmounts, function(a, b) return (a.value * a.amount) > (b.value * b.amount) end)

    while amount > 0 do
        local added = false
        for _, money in ipairs(moneyAmounts) do
            local unitValue = money.value * money.amount

            if amount >= unitValue then
                -- Randomly decide whether to use this denomination or continue looking
                if math.random() > 0.5 then
                    table.insert(sortedMoney, money)
                    amount = amount - unitValue
                    added = true
                    break
                end
            end
        end
        -- If no suitable denomination was randomly chosen, force the highest possible
        if not added then
            for _, money in ipairs(moneyAmounts) do
                local unitValue = money.value * money.amount
                if amount >= unitValue then
                    table.insert(sortedMoney, money)
                    amount = amount - unitValue
                    break
                end
            end
        end
    end

    return sortedMoney
end
