-- ╔══════════════════════════════════════════╗
-- ║        AURA HUB | Sea1.lua              ║
-- ║     Sea 1 Enemies + Quests              ║
-- ╚══════════════════════════════════════════╝

local Core     = getgenv().AuraCore
local Settings = getgenv().AuraHub

getgenv().AuraSea1Enemies = {
    { name = "Bandit",              level = 5   },
    { name = "Monkey",              level = 10  },
    { name = "Gorilla",             level = 15  },
    { name = "The Gorilla King",    level = 20  },
    { name = "Pirate",              level = 30  },
    { name = "Brute",               level = 40  },
    { name = "Chef",                level = 55  },
    { name = "Desert Bandit",       level = 60  },
    { name = "Desert Officer",      level = 75  },
    { name = "Snow Bandit",         level = 90  },
    { name = "Snowman",             level = 100 },
    { name = "Yeti",                level = 125 },
    { name = "Chief Petty Officer", level = 130 },
    { name = "Vice Admiral",        level = 130 },
    { name = "Sky Bandit",          level = 150 },
    { name = "Dark Master",         level = 175 },
    { name = "Prisoner",            level = 190 },
    { name = "Dangerous Prisoner",  level = 210 },
    { name = "Warden",              level = 220 },
    { name = "Chief Warden",        level = 240 },
    { name = "Swan",                level = 240 },
    { name = "Toga Warrior",        level = 250 },
    { name = "Gladiator",           level = 260 },
    { name = "Military Soldier",    level = 300 },
    { name = "Military Spy",        level = 325 },
    { name = "Magma Admiral",       level = 350 },
    { name = "Fishman Warrior",     level = 375 },
    { name = "Fishman Commando",    level = 400 },
    { name = "Fishman Lord",        level = 425 },
    { name = "God's Guard",         level = 450 },
    { name = "Shanda",              level = 475 },
    { name = "Wysper",              level = 500 },
    { name = "Royal Squad",         level = 525 },
    { name = "Royal Soldier",       level = 550 },
    { name = "Thunder God",         level = 575 },
    { name = "Galley Captain",      level = 625 },
    { name = "Cyborg",              level = 675 },
}

getgenv().AuraSea1Quests = {
    { npcName = "Bandit Quest Giver",    enemies = {"Bandit"},                              minLevel = 1,   maxLevel = 14,  kills = 8 },
    { npcName = "Adventurer",            enemies = {"Monkey","Gorilla","The Gorilla King"}, minLevel = 10,  maxLevel = 29,  kills = 8 },
    { npcName = "Pirate Adventurer",     enemies = {"Pirate","Brute","Chef"},               minLevel = 30,  maxLevel = 59,  kills = 8 },
    { npcName = "Desert Adventurer",     enemies = {"Desert Bandit","Desert Officer"},      minLevel = 60,  maxLevel = 89,  kills = 8 },
    { npcName = "Villager",              enemies = {"Snow Bandit","Snowman","Yeti"},        minLevel = 90,  maxLevel = 129, kills = 8 },
    { npcName = "Marina",                enemies = {"Chief Petty Officer","Vice Admiral"},  minLevel = 130, maxLevel = 174, kills = 8 },
    { npcName = "Sky Adventurer",        enemies = {"Sky Bandit","Dark Master"},            minLevel = 150, maxLevel = 199, kills = 8 },
    { npcName = "Jail Keeper",           enemies = {"Prisoner","Dangerous Prisoner"},       minLevel = 190, maxLevel = 249, kills = 8 },
    { npcName = "Head Jailer",           enemies = {"Warden","Chief Warden","Swan"},        minLevel = 220, maxLevel = 274, kills = 8 },
    { npcName = "Colosseum Quest Giver", enemies = {"Toga Warrior","Gladiator"},            minLevel = 250, maxLevel = 299, kills = 8 },
    { npcName = "The Mayor",             enemies = {"Military Soldier","Military Spy","Magma Admiral"}, minLevel = 300, maxLevel = 374, kills = 8 },
    { npcName = "King Neptune",          enemies = {"Fishman Warrior","Fishman Commando","Fishman Lord"}, minLevel = 375, maxLevel = 449, kills = 8 },
    { npcName = "Mole",                  enemies = {"God's Guard","Shanda"},                minLevel = 450, maxLevel = 524, kills = 8 },
    { npcName = "Sky Quest Giver 2",     enemies = {"Wysper","Royal Squad","Royal Soldier","Thunder God"}, minLevel = 500, maxLevel = 624, kills = 8 },
    { npcName = "Freebooter Quest Giver",enemies = {"Galley Captain","Cyborg"},             minLevel = 625, maxLevel = 699, kills = 8 },
}

local function getBestQuest(playerLevel)
    for i = #getgenv().AuraSea1Quests, 1, -1 do
        local q = getgenv().AuraSea1Quests[i]
        if playerLevel >= q.minLevel and playerLevel <= q.maxLevel then
            return q
        end
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
        if v:IsA("ProximityPrompt") then
            pcall(function() fireproximityprompt(v) end)
            return
        end
    end
    Core.attack()
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if not (Settings.AutoFarm and Core.isAlive() and Settings.MaxLevel <= 699) then continue end
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
                        for _, e in pairs(getgenv().AuraSea1Enemies) do
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
                if root then
                    Core.moveTo(root.CFrame * CFrame.new(0,0,4))
                    for i = 1,6 do Core.attack() task.wait(0.05) end
                end
            end
        end)
    end
end)

task.spawn(function()
    while true do
        task.wait(10)
        if not (Settings.AutoQuest and Core.isAlive() and Settings.MaxLevel <= 699) then continue end
        pcall(function()
            local q = getBestQuest(Settings.MinLevel)
            if q then acceptQuest(q.npcName) end
        end)
    end
end)

print("[Aura Hub] ✦ Sea 1 loaded!")
