-- ╔══════════════════════════════════════════╗
-- ║        AURA HUB | Fruit.lua             ║
-- ║     Auto Collect + Store Fruits         ║
-- ╚══════════════════════════════════════════╝

local Core     = getgenv().AuraCore
local Settings = getgenv().AuraHub
local Players  = game:GetService("Players")
local lp       = Players.LocalPlayer

local FRUIT_NAMES = {
    "Kilo","Bomb","Spike","Chop","Spring","Smoke","Spin","Flame","Ice",
    "Sand","Dark","Light","Rubber","Barrier","Magma","Quake","Buddha",
    "Love","Spider","Bird","Phoenix","Paw","Gravity","Dough","Shadow",
    "Venom","Control","Dragon","Leopard","Spirit","Mammoth","T-Rex",
    "Ghost","Portal","Cipher","Kitsune","Blox","Rumble","Revive","Barrier",
}

local function isFruit(name)
    name = name:lower()
    if name:find("fruit") then return true end
    for _, f in pairs(FRUIT_NAMES) do
        if name:find(f:lower()) then return true end
    end
    return false
end

local function collectFruits()
    local hrp = Core.getHRP()
    if not hrp then return end
    for _, obj in pairs(workspace:GetDescendants()) do
        if (obj:IsA("Model") or obj:IsA("Part") or obj:IsA("MeshPart")) and isFruit(obj.Name) then
            local pos = nil
            if obj:IsA("Model") then
                pos = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            else
                pos = obj
            end
            if pos then
                local dist = (hrp.Position - pos.Position).Magnitude
                if dist < 5000 then
                    Core.moveTo(CFrame.new(pos.Position + Vector3.new(0,2,0)))
                    task.wait(0.3)
                    if Settings.AutoStoreFruit then
                        -- Try store remotes
                        local rs = game:GetService("ReplicatedStorage")
                        local remote = rs:FindFirstChild("StoreFruit")
                            or rs:FindFirstChild("StoreBloxFruit")
                            or rs:FindFirstChild("AddFruit")
                        if remote then
                            pcall(function() remote:FireServer(obj) end)
                        end
                    else
                        Core.attack()
                    end
                    task.wait(0.5)
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(3)
        if Settings.AutoFruit and Core.isAlive() then
            pcall(collectFruits)
        end
    end
end)

print("[Aura Hub] ✦ Fruit collector loaded!")
