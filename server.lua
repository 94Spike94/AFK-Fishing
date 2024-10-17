ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Event, um dem Spieler Fische zu geben
RegisterNetEvent('fishing:giveFish')
AddEventHandler('fishing:giveFish', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        -- Bestimme die Anzahl der Fische, die der Spieler erhält
        local fishCount = math.random(Config.MinFishCount, Config.MaxFishCount)

        -- Gebe dem Spieler zufällige Fische
        for i = 1, fishCount do
            local randomFish = getRandomFish()
            if randomFish then
                xPlayer.addInventoryItem(randomFish, 1)
                TriggerClientEvent('esx:showNotification', _source, "Du hast einen " .. randomFish .. " gefangen!")
            end
        end
    end
end)

-- Funktion, um einen zufälligen Fisch basierend auf den Wahrscheinlichkeiten zu erhalten
function getRandomFish()
    local randomNum = math.random(1, 100)
    local cumulativeChance = 0

    for _, fish in pairs(Config.FishTypes) do
        cumulativeChance = cumulativeChance + fish.chance
        if randomNum <= cumulativeChance then
            return fish.name
        end
    end
    return nil
end
