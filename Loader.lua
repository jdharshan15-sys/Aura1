-- ╔══════════════════════════════════════════╗
-- ║        AURA HUB | Loader.lua            ║
-- ║   Put this on GitHub as main script     ║
-- ║   Change YOUR_GITHUB to your username   ║
-- ╚══════════════════════════════════════════╝

local BASE = "https://raw.githubusercontent.com/YOUR_GITHUB/AuraHub/main/"

local scripts = {
    "Core",   -- Load first (utilities)
    "Sea1",   -- Sea 1 enemies + quests
    "Sea2",   -- Sea 2 enemies + quests
    "Sea3",   -- Sea 3 enemies + quests
    "Fruit",  -- Auto fruit collector
    "Chest",  -- Auto chest collector
    "UI",     -- UI last (needs all above)
}

for _, name in pairs(scripts) do
    local ok, err = pcall(function()
        loadstring(game:HttpGet(BASE .. name .. ".lua"))()
    end)
    if not ok then
        warn("[Aura Hub] Failed to load " .. name .. ": " .. tostring(err))
    else
        print("[Aura Hub] ✦ Loaded: " .. name)
    end
    task.wait(0.1)
end

print("╔══════════════════════════════╗")
print("║  ✦ AURA HUB | Blox Fruits   ║")
print("║  All scripts loaded!         ║")
print("║  Press RightCtrl for UI      ║")
print("╚══════════════════════════════╝")
