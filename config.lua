Config = {}

-- Taste, um mit dem Angeln zu beginnen
Config.FishingKey = 38 -- E Taste

-- Koordinaten für Angelstellen
Config.FishingSpots = {
    {x = 1244.9058, y = -2718.3184, z = 1.8573}, -- Beispiel Koordinaten für Angelstellen 1244.9058, -2718.3184, 1.8573, 149.6978
    {x = -1601.264, y = 5261.856, z = 4.000}  -- Weitere Angelspots können hier hinzugefügt werden
}

-- Verschiedene Fische und ihre Wahrscheinlichkeiten (Prozentsatz)
Config.FishTypes = {
    {name = "alligator_gar", chance = 50}, -- 50% Wahrscheinlichkeit
    {name = "common_bleak", chance = 30}, -- 30% Wahrscheinlichkeit
    {name = "pufferfish", chance = 10}, -- 10% Wahrscheinlichkeit
    {name = "greatwhiteshark", chance = 10} -- 10% Wahrscheinlichkeit
}

-- Die minimale und maximale Anzahl an Fischen, die der Spieler alle 5 Minuten erhalten kann
Config.MinFishCount = 1
Config.MaxFishCount = 5
