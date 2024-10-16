Config = {}

-- Koordinaten für Angelstellen
Config.FishingSpots = {
    {x = -1604.664, y = 5256.856, z = 3.974},
    {x = -1601.264, y = 5261.856, z = 4.000}
}

-- Taste, um mit dem Angeln zu beginnen
Config.FishingKey = 38 -- E Taste

-- Verschiedene Fische und deren Chancen (Prozentsatz)
Config.FishTypes = {
    {name = "Lachs", chance = 50}, -- 50% Wahrscheinlichkeit
    {name = "Thunfisch", chance = 30}, -- 30% Wahrscheinlichkeit
    {name = "Hai", chance = 10}, -- 10% Wahrscheinlichkeit
    {name = "Karpfen", chance = 10} -- 10% Wahrscheinlichkeit
}

-- Verkäufer Position
Config.Seller = {x = -45.564, y = -1754.210, z = 29.421}

-- Preise für die verschiedenen Fische
Config.FishPrices = {
    ["Lachs"] = 100,
    ["Thunfisch"] = 150,
    ["Hai"] = 500,
    ["Karpfen"] = 50
}

-- Schwierigkeitsgrad für jeden Fisch (die Zeit, die du warten musst, um ihn zu fangen, in Sekunden)
Config.FishDifficulty = {
    ["Lachs"] = 5,
    ["Thunfisch"] = 10,
    ["Hai"] = 20,
    ["Karpfen"] = 7
}
