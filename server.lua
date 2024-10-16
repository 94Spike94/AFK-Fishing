local playersFish = {}

-- Server-Event zum Fangen eines Fisches
RegisterNetEvent('fishing:catch')
AddEventHandler('fishing:catch', function(fish)
    local _source = source
    if not playersFish[_source] then
        playersFish[_source] = {}
    end

    table.insert(playersFish[_source], fish)
    TriggerClientEvent('chat:addMessage', _source, {
        args = {"Fishing", "Du hast einen " .. fish .. " gefangen!"}
    })
end)

-- Server-Event zum Verkaufen von Fischen
RegisterNetEvent('fishing:sell')
AddEventHandler('fishing:sell', function()
    local _source = source
    local fishInventory = playersFish[_source] or {}
    local totalMoney = 0

    for _, fish in pairs(fishInventory) do
        local price = Config.FishPrices[fish] or 0
        totalMoney = totalMoney + price
    end

    playersFish[_source] = {}
    TriggerClientEvent('chat:addMessage', _source, {
        args = {"Fishing", "Du hast deine Fische für $" .. totalMoney .. " verkauft!"}
    })

    -- Hier könntest du einen Befehl hinzufügen, um dem Spieler Geld zu geben
    -- Beispiel: xPlayer.addMoney(totalMoney)
end)
