-- ╔══════════════════════════════════════════╗
-- ║        AURA HUB | Sea3.lua              ║
-- ║     Sea 3 Enemies + Quests              ║
-- ╚══════════════════════════════════════════╝

local Core     = getgenv().AuraCore
local Settings = getgenv().AuraHub

getgenv().AuraSea3Enemies = {
    -- Port Town
    { name = "Pirate",                 level = 1500 },
    { name = "Pistol Pirate",          level = 1525 },
    -- Dragon Corner
    { name = "Dragon Crew Warrior",    level = 1500 },
    { name = "Dragon Crew Officer",    level = 1575 },
    -- Hydra Island
    { name = "Hydra",                  level = 1525 },
    { name = "Vicious Marines",        level = 1550 },
    { name = "Hydra Admiral",          level = 1575 },
    -- Great Tree
    { name = "Marine Rear Admiral",    level = 1625 },
    { name = "Elite Admiral",          level = 1650 },
    -- Turtle Ship
    { name = "Turtle Deckswabber",     level = 1675 },
    { name = "Fishman",                level = 1700 },
    { name = "Refined Pirate",         level = 1725 },
    -- Floating Turtle
    { name = "Mythological Pirate",    level = 1750 },
    { name = "Captain Elephant",       level = 1775 },
    { name = "Google Pirate",          level = 1800 },
    -- Haunted Castle
    { name = "Reborn",                 level = 1825 },
    { name = "Living Zombie",          level = 1850 },
    { name = "Demonic Soul",           level = 1875 },
    { name = "Poseidon Guard",         level = 1900 },
    -- Haunted Castle 2
    { name = "Psycho",                 level = 1925 },
    -- Peanut Island
    { name = "Peanut Scout",           level = 1950 },
    { name = "Peanut Squirrel",        level = 1975 },
    -- Ice Cream Land
    { name = "Ice Cream Chef",         level = 2000 },
    { name = "Ice Cream Commander",    level = 2025 },
    { name = "Cake Queen",             level = 2050 },
    -- Sea of Treats
    { name = "Cookie",                 level = 2075 },
    { name = "Honut Baker",            level = 2100 },
    -- Chocolate Quest 1
    { name = "Cocoa Marine",           level = 2125 },
    { name = "Chocolate Bar Battler",  level = 2150 },
    -- Chocolate Quest 2
    { name = "Candy Robot",            level = 2175 },
    -- Candy Quest
    { name = "Candy Pirate",           level = 2200 },
    { name = "Erreur Correct",         level = 2225 },
    -- Tiki Outpost Quest 1
    { name = "Tiki Outlaw",            level = 2250 },
    -- Tiki Outpost Quest 2
    { name = "Sand Bandit",            level = 2275 },
    { name = "Earthshaker",            level = 2300 },
    -- Tiki Outpost Quest 3
    { name = "Holy Disrupter",         level = 2325 },
    -- Tiki Outpost Quest 4
    { name = "Skull Slayer",           level = 2350 },
    -- Subtracted Island Quest 1
    { name = "Small Bandit",           level = 2375 },
    -- Subtracted Island Quest 2/3
    { name = "Sea Dweller",            level = 2400 },
    { name = "Cave Pirate",            level = 2425 },
    -- Subtracted Island Quest 3
    { name = "High Disciple",          level = 2450 },
    { name = "Glomonde",               level = 2475 },
}

getgenv().AuraSea3Quests = {
    { npcName = "Pirate Port Quest Giver",   enemies = {"Pirate","Pistol Pirate"},                         minLevel = 1500, maxLevel = 1574, kills = 8 },
    { npcName = "Dragon Crew Quest Giver",   enemies = {"Dragon Crew Warrior","Dragon Crew Officer"},       minLevel = 1500, maxLevel = 1574, kills = 8 },
    { npcName = "Hydra Quest Giver",         enemies = {"Hydra","Vicious Marines","Hydra Admiral"},         minLevel = 1525, maxLevel = 1624, kills = 8 },
    { npcName = "Warrior Tree Quest Giver",  enemies = {"Marine Rear Admiral","Elite Admiral"},             minLevel = 1625, maxLevel = 1699, kills = 8 },
    { npcName = "Turtle Ship Quest Giver",   enemies = {"Turtle Deckswabber","Fishman","Refined Pirate"},   minLevel = 1675, maxLevel = 1749, kills = 8 },
    { npcName = "Deep Forest Quest Giver",   enemies = {"Mythological Pirate","Captain Elephant"},          minLevel = 1750, maxLevel = 1824, kills = 8 },
    { npcName = "Deep Forest Quest Giver 2", enemies = {"Google Pirate","Beautiful Pirate"},                minLevel = 1800, maxLevel = 1874, kills = 8 },
    { npcName = "Haunted Castle Quest Giver",enemies = {"Reborn","Living Zombie","Demonic Soul"},           minLevel = 1825, maxLevel = 1924, kills = 8 },
    { npcName = "Haunted Castle Quest Giver 2",enemies = {"Poseidon Guard","Psycho"},                       minLevel = 1900, maxLevel = 1999, kills = 8 },
    { npcName = "Peanut Quest Giver",        enemies = {"Peanut Scout","Peanut Squirrel"},                  minLevel = 1950, maxLevel = 2049, kills = 8 },
    { npcName = "Ice Cream Quest Giver 1",   enemies = {"Ice Cream Chef","Ice Cream Commander","Cake Queen"},minLevel = 2000, maxLevel = 2099, kills = 8 },
    { npcName = "Sea of Treats Quest Giver 1",enemies = {"Cookie","Honut Baker"},                           minLevel = 2075, maxLevel = 2174, kills = 8 },
    { npcName = "Chocolate Quest Giver 1",   enemies = {"Cocoa Marine","Chocolate Bar Battler"},            minLevel = 2125, maxLevel = 2224, kills = 8 },
    { npcName = "Chocolate Quest Giver 2",   enemies = {"Candy Robot"},                                     minLevel = 2175, maxLevel = 2249, kills = 8 },
    { npcName = "Candy Quest Giver",         enemies = {"Candy Pirate","Erreur Correct"},                   minLevel = 2200, maxLevel = 2299, kills = 8 },
    { npcName = "Tiki Outpost Quest Giver 1",enemies = {"Tiki Outlaw"},                                     minLevel = 2250, maxLevel = 2324, kills = 8 },
    { npcName = "Tiki Outpost Quest Giver 2",enemies = {"Sand Bandit","Earthshaker"},                       minLevel = 2275, maxLevel = 2374, kills = 8 },
    { npcName = "Tiki Outpost Quest Giver 3",enemies = {"Holy Disrupter"},                                  minLevel = 2325, maxLevel = 2399, kills = 8 },
    { npcName = "Tiki Outpost Quest Giver 4",enemies = {"Skull Slayer"},                                    minLevel = 2350, maxLevel = 2424, kills = 8 },
    { npcName = "Subtracted Quest Giver 1",  enemies = {"Small Bandit"},                                    minLevel = 2375, maxLevel = 2449, kills = 8 },
    { npcName = "Subtracted Quest Giver 2",  enemies = {"Sea Dweller","Cave Pirate"},                       minLevel = 2400, maxLevel = 2499, kills = 8 },
    { npcName = "Subtracted Quest Giver 3",  enemies = {"High Disciple","Glomonde"},                        minLevel = 2450, maxLevel = 2550, kills = 8 },
}

local function getBestQuest(playerLevel)
    for i = #getgenv().AuraSea3Quests, 1, -1 do
        local q = getgenv().AuraSea3Quests[i]
        if playerLevel >= q.minLevel and playerLevel <= q.maxLevel then return q end
    end
end

local function acceptQuest(questName)
    local npc = Core.getNPC(questName)
    if not npc then return end
    local root = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart")
    if not root then return end
    Core.moveTo(CFrame.new(root.Position + Vector3.new(0,0,4)))
    task.wait(0.5)
    for _, v in pairs(npc:GetDescendants()) do
        if v:IsA("ProximityPrompt") then pcall(function() fireproximityprompt(v) end) return end
    end
    Core.attack()
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if not (Settings.AutoFarm and Core.isAlive() and Settings.MinLevel >= 1500) then continue end
        pcall(function()
            local folder = Core.getEnemyFolder()
            if not folder then return end
            local hrp = Core.getHRP()
            if not hrp then return end
            local bestDist, bestEnemy = math.huge, nil
            for _, v in pairs(folder:GetChildren()) do
                if v:IsA("Model") then
                    local hum  = v:FindFirstChildOfClass("Humanoid")
                    local root = v:FindFirstChild("HumanoidRootPart")
                    if hum and root and hum.Health > 0 then
                        for _, e in pairs(getgenv().AuraSea3Enemies) do
                            if v.Name == e.name and e.level >= Settings.MinLevel and e.level <= Settings.MaxLevel then
                                local d = (hrp.Position - root.Position).Magnitude
                                if d < bestDist then bestDist = d bestEnemy = v end
                                break
                            end
                        end
                    end
                end
            end
            if bestEnemy then
                local root = bestEnemy:FindFirstChild("HumanoidRootPart")
                if root then Core.moveTo(root.CFrame * CFrame.new(0,0,4)) for i=1,6 do Core.attack() task.wait(0.05) end end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(10)
        if not (Settings.AutoQuest and Core.isAlive() and Settings.MinLevel >= 1500) then continue end
        pcall(function()
            local q = getBestQuest(Settings.MinLevel)
            if q then acceptQuest(q.npcName) end
        end)
    end
end)

print("[Aura Hub] ✦ Sea 3 loaded!")
