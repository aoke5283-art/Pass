local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RS = game:GetService("ReplicatedStorage")

local E = RS["E&F"]
local ShopRF = E.Shop.RequestPurchaseRF
local TryPem = E.Pem["[C-S]TryAddPem"]

-- Label & Nama Gamepass disesuaikan sama screenshot
local Unlocks = {
    { label = "x2 Power Pass",           names = { "x2 Power Pass" } },
    { label = "x2 Wins Pass",            names = { "x2 Wins Pass" } },
    { label = "Auto Throw",              names = { "Auto Throw" } },
    { label = "Training Area - PREMIUM", names = { "Training Area - PREMIUM" } },
    { label = "Training Area - OP",      names = { "Training Area - OP" } },
}

local function runUnlock(names)
    for _, name in ipairs(names) do
        ShopRF:InvokeServer(name, "Gamepass")
        TryPem:FireServer(name)
    end
end

local old = CoreGui:FindFirstChild("AutoUnlockerGUI")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "AutoUnlockerGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 320, 0, 300) -- Size gua kecilin karena tombolnya tinggal 5
main.Position = UDim2.new(0.5, -160, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
title.BorderSizePixel = 0
title.Text = "Gamepasses Auto Unlocker"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.Parent = main

local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 10)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -90)
scroll.Position = UDim2.new(0, 10, 0, 45)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

local function makeButton(text, names)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.BorderSizePixel = 0
    btn.Text = "  " .. text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = scroll

    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        runUnlock(names)
        btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        task.delay(0.3, function()
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        end)
    end)
end

for _, unlock in ipairs(Unlocks) do
    makeButton(unlock.label, unlock.names)
end

local allBtn = Instance.new("TextButton")
allBtn.Size = UDim2.new(1, -20, 0, 35)
allBtn.Position = UDim2.new(0, 10, 1, -45)
allBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
allBtn.BorderSizePixel = 0
allBtn.Text = "UNLOCK ALL"
allBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
allBtn.Font = Enum.Font.GothamBold
allBtn.TextSize = 14
allBtn.Parent = main

local allCorner = Instance.new("UICorner", allBtn)
allCorner.CornerRadius = UDim.new(0, 8)

allBtn.MouseButton1Click:Connect(function()
    -- UNLOCK ALL (Nama diganti sesuai screenshot)
    ShopRF:InvokeServer("x2 Power Pass", "Gamepass")
    ShopRF:InvokeServer("x2 Wins Pass", "Gamepass")
    ShopRF:InvokeServer("Auto Throw", "Gamepass")
    ShopRF:InvokeServer("Training Area - PREMIUM", "Gamepass")
    ShopRF:InvokeServer("Training Area - OP", "Gamepass")

    -- Tetep ngirim data ke TryPem buat jaga-jaga kalo ada sistem backup
    TryPem:FireServer("x2 Power Pass")
    TryPem:FireServer("x2 Wins Pass")
    TryPem:FireServer("Auto Throw")
    TryPem:FireServer("Training Area - PREMIUM")
    TryPem:FireServer("Training Area - OP")
end)
