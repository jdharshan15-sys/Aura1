-- ╔══════════════════════════════════════════╗
-- ║        AURA HUB | Chest.lua             ║
-- ║     Auto Chest Collector                ║
-- ╚══════════════════════════════════════════╝

local Core     = getgenv().AuraCore
local Settings = getgenv().AuraHub

local function isChest(name)
    name = name:lower()
    return name:find("chest") or name:find("treasure") or name:find("crate")
end

local function collectChests()
    local hrp = Core.getHRP()
    if not hrp then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and isChest(obj.Name) then
            local root = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if root then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist < 3000 then
                    Core.moveTo(CFrame.new(root.Position + Vector3.new(0,0,3)))
                    task.wait(0.3)
                    -- Try ProximityPrompt first
                    local found = false
                    for _, v in pairs(obj:GetDescendants()) do
                        if v:IsA("ProximityPrompt") then
                            pcall(function() fireproximityprompt(v) end)
                            found = true
                            break
                        end
                    end
                    if not found then Core.attack() end
                    task.wait(0.5)
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(5)
        if Settings.AutoChest and Core.isAlive() then
            pcall(collectChests)
        end
    end
end)

print("[Aura Hub] ✦ Chest collector loaded!")
