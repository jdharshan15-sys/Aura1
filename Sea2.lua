-- ╔══════════════════════════════════════════╗
-- ║        AURA HUB | Sea2.lua              ║
-- ║     Sea 2 Enemies + Quests              ║
-- ╚══════════════════════════════════════════╝

local Core     = getgenv().AuraCore
local Settings = getgenv().AuraHub

getgenv().AuraSea2Enemies = {
    { name = "Raider",               level = 700  },
    { name = "Mercenary",            level = 725  },
    { name = "Diamond",              level = 750  },
    { name = "Swan Pirate",          level = 775  },
    { name = "Factory Staff",        level = 800  },
    { name = "Jeremy",               level = 850  },
    { name = "Marine Lieutenant",    level = 875  },
    { name = "Marine Captain",       level = 900  },
    { name = "Orbitus",              level = 925  },
    { name = "Zombie",               level = 950  },
    { name = "Vampire",              level = 975  },
    { name = "Snow Trooper",         level = 1000 },
    { name = "Winter Warrior",       level = 1050 },
    { name = "Lab Subordinate",      level = 1070 },
    { name = "Horned Warrior",       level = 1025 },
    { name = "Smoke Admiral",        level = 1150 },
    { name = "Magma Ninja",          level = 1125 },
    { name = "Lava Pirate",          level = 1300 },
    { name = "Ship Deckhand",        level = 1250 },
    { name = "Ship Engineer",        level = 1275 },
    { name = "Ship Steward",         level = 1300 },
    { name = "Ship Officer",         level = 1325 },
    { name = "Arctic Warrior",       level = 1350 },
    { name = "Snow Lurker",          level = 1375 },
    { name = "Awakened Ice Admiral", level = 1400 },
    { name = "Sea Soldier",          level = 1425 },
    { name = "Water Fighter",        level = 1475 },
    { name = "Tide Keeper",          level = 1475 },
}

getgenv().AuraSea2Quests = {
    { npcName = "Area 1 Quest Giver",    enemies = {"Raider","Mercenary","Diamond"},                           minLevel = 700,  maxLevel = 774,  kills = 8 },
    { npcName = "Area 2 Quest Giver",    enemies = {"Swan Pirate","Factory Staff","Jeremy"},                   minLevel = 775,  maxLevel = 874,  kills = 8 },
    { npcName = "Marine Quest Giver",    enemies = {"Marine Lieutenant","Marine Captain","Orbitus"},           minLevel = 875,  maxLevel = 949,  kills = 8 },
    { npcName = "Graveyard Quest Giver", enemies = {"Zombie","Vampire"},                                       minLevel = 950,  maxLevel = 999,  kills = 8 },
    { npcName = "Snow Quest Giver",      enemies = {"Snow Trooper","Winter Warrior"},                          minLevel = 1000, maxLevel = 1099, kills = 8 },
    { npcName = "Ice Quest Giver",       enemies = {"Lab Subordinate","Horned Warrior","Smoke Admiral"},       minLevel = 1025, maxLevel = 1174, kills = 8 },
    { npcName = "Fire Quest Giver",      enemies = {"Magma Ninja","Lava Pirate"},                              minLevel = 1125, maxLevel = 1249, kills = 8 },
    { npcName = "Rear Crew Quest Giver", enemies = {"Ship Deckhand","Ship Engineer"},                          minLevel = 1250, maxLevel = 1324, kills = 8 },
    { npcName = "Front Crew Quest Giver",enemies = {"Ship Steward","Ship Officer"},                            minLevel = 1300, maxLevel = 1374, kills = 8 },
    { npcName = "Frost Quest Giver",     enemies = {"Arctic Warrior","Snow Lurker","Awakened Ice Admiral","Sea Soldier"}, minLevel = 1350, maxLevel = 1474, kills = 8 },
    { npcName = "Forgotten Quest Giver", enemies = {"Water Fighter","Tide Keeper"},                            minLevel = 1475, maxLevel = 1499, kills = 8 },
}

local function getBestQuest(playerLevel)
    for i = #getgenv().AuraSea2Quests, 1, -1 do
        local q = getgenv().AuraSea2Quests[i]
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
        if not (Settings.AutoFarm and Core.isAlive() and Settings.MinLevel >= 700 and Settings.MaxLevel <= 1499) then continue end
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
                        for _, e in pairs(getgenv().AuraSea2Enemies) do
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
        if not (Settings.AutoQuest and Core.isAlive() and Settings.MinLevel >= 700 and Settings.MaxLevel <= 1499) then continue end
        pcall(function()
            local q = getBestQuest(Settings.MinLevel)
            if q then acceptQuest(q.npcName) end
        end)
    end
end)

print("[Aura Hub] ✦ Sea 2 loaded!")
