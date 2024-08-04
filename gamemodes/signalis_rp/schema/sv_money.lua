
--local ragSuffix = "_rag"
local ragSuffix = ""

local moneyAmounts = {
    -- coins
    {value = 0.25,  amount = 0.25,  mdl = "models/eternalis/currency/coin_025.mdl"},
    {value = 0.5,   amount = 0.5,   mdl = "models/eternalis/currency/coin_05.mdl"},
    {value = 1,     amount = 1,     mdl = "models/eternalis/currency/coin_1.mdl"},

    -- banknotes
    {value = 1,     amount = 1,     mdl = "models/eternalis/currency/banknote_1"..ragSuffix..".mdl"},
    {value = 2,     amount = 1,     mdl = "models/eternalis/currency/banknote_2"..ragSuffix..".mdl"},
    {value = 5,     amount = 1,     mdl = "models/eternalis/currency/banknote_5"..ragSuffix..".mdl"},
    {value = 10,    amount = 1,     mdl = "models/eternalis/currency/banknote_10"..ragSuffix..".mdl"},
    {value = 20,    amount = 1,     mdl = "models/eternalis/currency/banknote_20"..ragSuffix..".mdl"},
    {value = 50,    amount = 1,     mdl = "models/eternalis/currency/banknote_50"..ragSuffix..".mdl"},
    {value = 100,   amount = 1,     mdl = "models/eternalis/currency/banknote_100"..ragSuffix..".mdl"},
    
    -- clusters
    {value = 1,     amount = 10,    mdl = "models/eternalis/currency/banknote_1_cluster_10.mdl"},
    {value = 2,     amount = 10,    mdl = "models/eternalis/currency/banknote_2_cluster_10.mdl"},
    {value = 5,     amount = 10,    mdl = "models/eternalis/currency/banknote_5_cluster_10.mdl"},
    {value = 10,    amount = 10,    mdl = "models/eternalis/currency/banknote_10_cluster_10.mdl"},
    {value = 20,    amount = 10,    mdl = "models/eternalis/currency/banknote_20_cluster_10.mdl"},
    {value = 50,    amount = 10,    mdl = "models/eternalis/currency/banknote_50_cluster_10.mdl"},
    {value = 100,   amount = 10,    mdl = "models/eternalis/currency/banknote_100_cluster_10.mdl"},
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

    --PrintTable(sortedMoney)

    return sortedMoney
end
