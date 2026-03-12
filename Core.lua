-- ╔══════════════════════════════════════════╗
-- ║        AURA HUB | Core.lua              ║
-- ║     Utilities, Movement, AntiAFK        ║
-- ╚══════════════════════════════════════════╝

getgenv().AuraHub = getgenv().AuraHub or {}
local Settings = getgenv().AuraHub

Settings.AutoFarm       = false
Settings.AutoQuest      = false
Settings.AutoFruit      = false
Settings.AutoStoreFruit = false
Settings.AutoChest      = false
Settings.AntiAFK        = true
Settings.MinLevel       = 1
Settings.MaxLevel       = 9999
Settings.MoveSpeed      = 175
Settings.Loaded         = true

local Players     = game:GetService("Players")
local RunService  = game:GetService("RunService")
local TweenService= game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local lp          = Players.LocalPlayer

getgenv().AuraCore = {}
local Core = getgenv().AuraCore

function Core.getChar() return lp.Character end
function Core.getHRP()
    local c = Core.getChar()
    return c and c:FindFirstChild("HumanoidRootPart")
end
function Core.getHum()
    local c = Core.getChar()
    return c and c:FindFirstChildOfClass("Humanoid")
end
function Core.isAlive()
    local h = Core.getHum()
    return h and h.Health > 0
end

local _noclipConn = nil
function Core.enableNoclip()
    if _noclipConn then return end
    _noclipConn = RunService.Stepped:Connect(function()
        local c = Core.getChar()
        if not c then return end
        for _, v in pairs(c:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end)
end
function Core.disableNoclip()
    if _noclipConn then _noclipConn:Disconnect() _noclipConn = nil end
end

local _bv = nil
function Core.addAntifall()
    local hrp = Core.getHRP()
    if not hrp or hrp:FindFirstChild("AuraBV") then return end
    local bv = Instance.new("BodyVelocity")
    bv.Name = "AuraBV"
    bv.Velocity = Vector3.zero
    bv.MaxForce = Vector3.new(0, 1e5, 0)
    bv.Parent = hrp
    _bv = bv
end
function Core.removeAntifall()
    if _bv then pcall(function() _bv:Destroy() end) _bv = nil end
    local hrp = Core.getHRP()
    if hrp then
        local b = hrp:FindFirstChild("AuraBV")
        if b then b:Destroy() end
    end
end

function Core.moveTo(targetCF, speed)
    local hrp = Core.getHRP()
    if not hrp then return end
    speed = speed or Settings.MoveSpeed
    local dist = (hrp.Position - targetCF.Position).Magnitude
    if dist < 4 then return end
    local tween = TweenService:Create(hrp,
        TweenInfo.new(dist / speed, Enum.EasingStyle.Linear),
        {CFrame = targetCF})
    Core.addAntifall()
    Core.enableNoclip()
    tween:Play()
    tween.Completed:Wait()
    Core.removeAntifall()
    Core.disableNoclip()
end

function Core.teleportTo(cf)
    local hrp = Core.getHRP()
    if hrp then hrp.CFrame = cf end
end

function Core.attack()
    VirtualUser:ClickButton1(Vector2.new())
end

function Core.notify(title, text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "✦ " .. title, Text = text, Duration = 3,
        })
    end)
end

function Core.getNPC(name)
    local folder = workspace:FindFirstChild("NPCs")
    if folder then return folder:FindFirstChild(name) end
    return workspace:FindFirstChild(name)
end

function Core.getEnemyFolder()
    return workspace:FindFirstChild("Enemies")
end

function Core.getNearestEnemy(minLv, maxLv)
    local hrp = Core.getHRP()
    if not hrp then return nil end
    local folder = Core.getEnemyFolder()
    if not folder then return nil end
    local bestDist, bestEnemy = math.huge, nil
    for _, v in pairs(folder:GetChildren()) do
        if v:IsA("Model") then
            local hum  = v:FindFirstChildOfClass("Humanoid")
            local root = v:FindFirstChild("HumanoidRootPart")
            if hum and root and hum.Health > 0 then
                local lv = tonumber(v.Name:match("%d+")) or 0
                if lv >= minLv and lv <= maxLv then
                    local d = (hrp.Position - root.Position).Magnitude
                    if d < bestDist then
                        bestDist = d
                        bestEnemy = v
                    end
                end
            end
        end
    end
    return bestEnemy
end

-- Anti AFK
task.spawn(function()
    while true do
        task.wait(55)
        if Settings.AntiAFK then
            VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
        end
    end
end)

lp.CharacterAdded:Connect(function()
    task.wait(3)
    Core.removeAntifall()
    Core.disableNoclip()
end)

print("[Aura Hub] ✦ Core loaded!")
