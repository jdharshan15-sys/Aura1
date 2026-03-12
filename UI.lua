-- ╔══════════════════════════════════════════╗
-- ║        AURA HUB | UI.lua                ║
-- ║     Full UI with Toggles                ║
-- ╚══════════════════════════════════════════╝

local Settings = getgenv().AuraHub
local CoreGui  = game:GetService("CoreGui")
local Players  = game:GetService("Players")
local lp       = Players.LocalPlayer

-- Destroy old UI
pcall(function()
    local old = CoreGui:FindFirstChild("AuraHub_UI")
    if old then old:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AuraHub_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.IgnoreGuiInset = true
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = lp.PlayerGui end

-- ── Main Frame ───────────────────────────
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 240, 0, 380)
Main.Position = UDim2.new(0, 12, 0.25, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(255, 0, 127)
stroke.Thickness = 1.5

-- ── Title Bar ────────────────────────────
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -10, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "✦ AURA HUB  |  Blox Fruits"
TitleLabel.TextColor3 = Color3.fromRGB(255, 0, 127)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- ── Content ──────────────────────────────
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -50)
Content.Position = UDim2.new(0, 10, 0, 44)
Content.BackgroundTransparency = 1
Content.Parent = Main

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 6)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- ── Helper: Section Label ────────────────
local function addSection(parent, text, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = "── " .. text .. " ──"
    lbl.TextColor3 = Color3.fromRGB(255, 0, 127)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 10
    lbl.LayoutOrder = order
    lbl.Parent = parent
end

-- ── Helper: Toggle ───────────────────────
local function addToggle(parent, label, key, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 11
    btn.TextColor3 = Color3.fromRGB(170, 170, 170)
    btn.Text = "◉  " .. label .. "  :  OFF"
    btn.LayoutOrder = order
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local function refresh()
        if Settings[key] then
            btn.Text = "◉  " .. label .. "  :  ON"
            btn.TextColor3 = Color3.fromRGB(0, 255, 120)
            btn.BackgroundColor3 = Color3.fromRGB(0, 35, 18)
        else
            btn.Text = "◉  " .. label .. "  :  OFF"
            btn.TextColor3 = Color3.fromRGB(170, 170, 170)
            btn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        end
    end

    btn.MouseButton1Click:Connect(function()
        Settings[key] = not Settings[key]
        refresh()
    end)

    refresh()
    return btn
end

-- ── Helper: Input ────────────────────────
local function addInput(parent, label, key, order)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    frame.BorderSizePixel = 0
    frame.LayoutOrder = order
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.55, 0, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Color3.fromRGB(170, 170, 170)
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(0.38, 0, 0.75, 0)
    tb.Position = UDim2.new(0.59, 0, 0.125, 0)
    tb.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    tb.BorderSizePixel = 0
    tb.Text = tostring(Settings[key])
    tb.TextColor3 = Color3.fromRGB(255, 255, 255)
    tb.Font = Enum.Font.GothamMedium
    tb.TextSize = 11
    tb.ClearTextOnFocus = true
    tb.Parent = frame
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 4)

    tb.FocusLost:Connect(function()
        local val = tonumber(tb.Text)
        if val then Settings[key] = val tb.Text = tostring(val)
        else tb.Text = tostring(Settings[key]) end
    end)
end

-- ── Build UI ─────────────────────────────
addSection(Content, "AUTO FARM", 1)
addToggle(Content, "Auto Farm",        "AutoFarm",       2)
addToggle(Content, "Auto Quest",       "AutoQuest",      3)
addToggle(Content, "Anti AFK",         "AntiAFK",        4)

addSection(Content, "LEVEL RANGE", 5)
addInput(Content,   "Min Level",       "MinLevel",       6)
addInput(Content,   "Max Level",       "MaxLevel",       7)

addSection(Content, "FRUIT & CHEST", 8)
addToggle(Content, "Auto Fruit",       "AutoFruit",      9)
addToggle(Content, "Auto Store Fruit", "AutoStoreFruit", 10)
addToggle(Content, "Auto Chest",       "AutoChest",      11)

-- ── Footer ───────────────────────────────
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 16)
footer.Position = UDim2.new(0, 0, 1, -18)
footer.BackgroundTransparency = 1
footer.Text = "discord.gg/YXJ2xaEwP2  |  Aura Hub"
footer.TextColor3 = Color3.fromRGB(60, 60, 60)
footer.Font = Enum.Font.Gotham
footer.TextSize = 9
footer.Parent = Main

-- ── Toggle UI visibility with RightControl
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)

print("[Aura Hub] ✦ UI loaded! Press RightCtrl to toggle.")
