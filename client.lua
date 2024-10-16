local isFishing = false
local currentSpot = nil

-- Überprüft, ob der Spieler in der Nähe eines Angelspots ist
function isNearFishingSpot()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, spot in pairs(Config.FishingSpots) do
        local distance = #(playerCoords - vector3(spot.x, spot.y, spot.z))
        if distance < 5.0 then
            return true, spot
        end
    end
    return false, nil
end

-- Startet den Angelprozess
function startFishing()
    isFishing = true
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_FISHING", 0, true)

    Citizen.CreateThread(function()
        while isFishing do
            local fish = catchFish()
            if fish then
                TriggerServerEvent('fishing:catch', fish)
                Citizen.Wait(Config.FishDifficulty[fish] * 1000) -- Wartezeit je nach Schwierigkeitsgrad des Fisches
            end
        end
    end)
end

-- Stoppt den Angelprozess
function stopFishing()
    isFishing = false
    ClearPedTasksImmediately(PlayerPedId())
end

-- Fängt einen zufälligen Fisch basierend auf der Wahrscheinlichkeit
function catchFish()
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

-- Hauptthread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local isNear, spot = isNearFishingSpot()

        if isNear and not isFishing then
            DrawText3D(spot.x, spot.y, spot.z, "Drücke [E], um zu angeln")

            if IsControlJustPressed(1, Config.FishingKey) then
                startFishing()
            end
        elseif isFishing then
            DrawText3D(spot.x, spot.y, spot.z, "Drücke [E], um das Angeln zu beenden")

            if IsControlJustPressed(1, Config.FishingKey) then
                stopFishing()
            end
        end
    end
end)

-- Funktion zum Zeichnen von 3D-Text
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local camCoords = GetGameplayCamCoords()
    local dist = #(camCoords - vector3(x, y, z))

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
-- Überprüfe, ob der Spieler beim Verkäufer ist und Fische verkaufen möchte
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - vector3(Config.Seller.x, Config.Seller.y, Config.Seller.z))

        if distance < 3.0 then
            DrawText3D(Config.Seller.x, Config.Seller.y, Config.Seller.z, "Drücke [E], um Fische zu verkaufen")

            if IsControlJustPressed(1, Config.FishingKey) then
                TriggerServerEvent('fishing:sell')
            end
        end
    end
end)