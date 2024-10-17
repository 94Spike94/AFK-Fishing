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

-- Startet den Angelprozess mit Animation
function startFishing()
    isFishing = true
    local playerPed = PlayerPedId()

    -- Spielt die Angelanimation ab
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_FISHING", 0, true)
    
    TriggerEvent('chat:addMessage', { args = { "Fishing", "Du hast angefangen zu angeln. Du erhältst alle 5 Minuten Fische." } })

    Citizen.CreateThread(function()
        while isFishing do
            -- Warte 5 Minuten (300 Sekunden)
            Citizen.Wait(300000) 

            -- Sende ein Event an den Server, um Fische zu erhalten
            TriggerServerEvent('fishing:giveFish')
        end
    end)
end

-- Stoppt den Angelprozess und beendet die Animation
function stopFishing()
    isFishing = false
    ClearPedTasksImmediately(PlayerPedId())
    TriggerEvent('chat:addMessage', { args = { "Fishing", "Du hast aufgehört zu angeln." } })
end

-- Hauptthread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- Überprüfen, ob der Spieler in der Nähe eines Angelspots ist
        local isNear, spot = isNearFishingSpot()

        if isNear and not isFishing then
            DrawText3D(spot.x, spot.y, spot.z, "Drücke [E], um zu angeln")

            -- Wenn der Spieler E drückt, startet oder stoppt das Angeln
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
