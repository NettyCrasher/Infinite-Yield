-- MyzkaHub

if getgenv().IY_REVAMPED_LOADED and not _G.IY_DEBUG then return end
pcall(function() getgenv().IY_REVAMPED_LOADED = true end)

-- Services
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Local Player
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Modern Color Scheme
local Colors = {
    Background = Color3.fromRGB(20, 20, 25),
    Header = Color3.fromRGB(25, 25, 30),
    Secondary = Color3.fromRGB(35, 35, 40),
    Accent = Color3.fromRGB(0, 170, 255),
    Success = Color3.fromRGB(76, 175, 80),
    Warning = Color3.fromRGB(255, 152, 0),
    Danger = Color3.fromRGB(244, 67, 54),
    Text = Color3.fromRGB(230, 230, 230),
    TextSecondary = Color3.fromRGB(150, 150, 150),
    Glass = Color3.fromRGB(10, 10, 15)
}

-- Main GUI
local IYGui = Instance.new("ScreenGui")
IYGui.Name = "IY_Revamped_" .. math.random(10000, 99999)
IYGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
IYGui.DisplayOrder = 100

-- Main Container
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 500, 0, 600)
MainContainer.Position = UDim2.new(0.5, -250, 0.5, -300)
MainContainer.BackgroundColor3 = Colors.Background
MainContainer.BackgroundTransparency = 0.1
MainContainer.BorderSizePixel = 0

-- Glassmorphism Effect
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainContainer

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Colors.Accent
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.5
UIStroke.Parent = MainContainer

-- Drop Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.8
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
Shadow.Parent = MainContainer

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Colors.Header
Header.BackgroundTransparency = 0.2
Header.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "INFINITE YIELD REVAMPED"
Title.TextColor3 = Colors.Accent
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.new(0, 80, 0, 20)
Version.Position = UDim2.new(0, 20, 1, -25)
Version.BackgroundTransparency = 1
Version.Text = "v6.0.0 (Revamped)"
Version.TextColor3 = Colors.TextSecondary
Version.TextSize = 12
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left

-- Control Buttons
local ControlButtons = Instance.new("Frame")
ControlButtons.Name = "ControlButtons"
ControlButtons.Size = UDim2.new(0, 100, 1, 0)
ControlButtons.Position = UDim2.new(1, -105, 0, 0)
ControlButtons.BackgroundTransparency = 1

local function CreateControlButton(name, text, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 35, 0, 35)
    button.BackgroundColor3 = color or Colors.Secondary
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Colors.Text
    button.TextSize = 16
    button.Font = Enum.Font.GothamBold

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
    end)

    return button
end

local MinimizeBtn = CreateControlButton("MinimizeBtn", "−")
MinimizeBtn.Position = UDim2.new(0, 5, 0, 7)

local CloseBtn = CreateControlButton("CloseBtn", "×", Colors.Danger)
CloseBtn.Position = UDim2.new(1, -40, 0, 7)

-- Command Input Section
local CommandSection = Instance.new("Frame")
CommandSection.Name = "CommandSection"
CommandSection.Size = UDim2.new(1, -20, 0, 60)
CommandSection.Position = UDim2.new(0, 10, 0, 60)
CommandSection.BackgroundColor3 = Colors.Secondary
CommandSection.BackgroundTransparency = 0.2
CommandSection.BorderSizePixel = 0

local SectionCorner = Instance.new("UICorner")
SectionCorner.CornerRadius = UDim.new(0, 8)
SectionCorner.Parent = CommandSection

local PrefixLabel = Instance.new("TextLabel")
PrefixLabel.Name = "PrefixLabel"
PrefixLabel.Size = UDim2.new(0, 30, 1, 0)
PrefixLabel.BackgroundTransparency = 1
PrefixLabel.Text = ";"
PrefixLabel.TextColor3 = Colors.Accent
PrefixLabel.TextSize = 16
PrefixLabel.Font = Enum.Font.GothamBold
PrefixLabel.TextXAlignment = Enum.TextXAlignment.Center

local CommandInput = Instance.new("TextBox")
CommandInput.Name = "CommandInput"
CommandInput.Size = UDim2.new(1, -40, 1, -10)
CommandInput.Position = UDim2.new(0, 35, 0, 5)
CommandInput.BackgroundTransparency = 1
CommandInput.Text = ""
CommandInput.PlaceholderText = "Type command here..."
CommandInput.PlaceholderColor3 = Colors.TextSecondary
CommandInput.TextColor3 = Colors.Text
CommandInput.TextSize = 14
CommandInput.TextXAlignment = Enum.TextXAlignment.Left
CommandInput.Font = Enum.Font.Gotham
CommandInput.ClearTextOnFocus = false

-- Quick Actions
local QuickActions = Instance.new("Frame")
QuickActions.Name = "QuickActions"
QuickActions.Size = UDim2.new(1, -20, 0, 50)
QuickActions.Position = UDim2.new(0, 10, 0, 130)
QuickActions.BackgroundTransparency = 1

local QuickLayout = Instance.new("UIListLayout")
QuickLayout.Parent = QuickActions
QuickLayout.FillDirection = Enum.FillDirection.Horizontal
QuickLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
QuickLayout.SortOrder = Enum.SortOrder.LayoutOrder
QuickLayout.Padding = UDim.new(0, 8)

local function CreateQuickAction(text, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 80, 0, 35)
    button.BackgroundColor3 = color
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Colors.Text
    button.TextSize = 12
    button.Font = Enum.Font.GothamSemibold

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = button

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
    end)

    return button
end

-- Commands List (ScrollingFrame)
local CommandsFrame = Instance.new("ScrollingFrame")
CommandsFrame.Name = "CommandsFrame"
CommandsFrame.Size = UDim2.new(1, -20, 0, 300)
CommandsFrame.Position = UDim2.new(0, 10, 0, 190)
CommandsFrame.BackgroundTransparency = 1
CommandsFrame.BorderSizePixel = 0
CommandsFrame.ScrollBarImageColor3 = Colors.Accent
CommandsFrame.ScrollBarThickness = 4
CommandsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
CommandsFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

local CommandsLayout = Instance.new("UIListLayout")
CommandsLayout.Parent = CommandsFrame
CommandsLayout.SortOrder = Enum.SortOrder.LayoutOrder
CommandsLayout.Padding = UDim.new(0, 6)

-- Command Template
local CommandTemplate = Instance.new("TextButton")
CommandTemplate.Name = "CommandTemplate"
CommandTemplate.Size = UDim2.new(1, 0, 0, 36)
CommandTemplate.BackgroundColor3 = Colors.Secondary
CommandTemplate.BackgroundTransparency = 0.3
CommandTemplate.BorderSizePixel = 0
CommandTemplate.Text = "command - description"
CommandTemplate.TextColor3 = Colors.Text
CommandTemplate.TextSize = 13
CommandTemplate.Font = Enum.Font.Gotham
CommandTemplate.TextXAlignment = Enum.TextXAlignment.Left
CommandTemplate.Visible = false

local TemplateCorner = Instance.new("UICorner")
TemplateCorner.CornerRadius = UDim.new(0, 6)
TemplateCorner.Parent = CommandTemplate

local TemplatePadding = Instance.new("UIPadding")
TemplatePadding.Parent = CommandTemplate
TemplatePadding.PaddingLeft = UDim.new(0, 12)
TemplatePadding.PaddingRight = UDim.new(0, 12)

-- Status Bar
local StatusBar = Instance.new("Frame")
StatusBar.Name = "StatusBar"
StatusBar.Size = UDim2.new(1, -20, 0, 25)
StatusBar.Position = UDim2.new(0, 10, 1, -30)
StatusBar.BackgroundColor3 = Colors.Header
StatusBar.BackgroundTransparency = 0.2
StatusBar.BorderSizePixel = 0

local StatusCorner = Instance.new("UICorner")
StatusCorner.CornerRadius = UDim.new(0, 6)
StatusCorner.Parent = StatusBar

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -10, 1, 0)
StatusLabel.Position = UDim2.new(0, 10, 0, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Ready"
StatusLabel.TextColor3 = Colors.Success
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Parent everything
IYGui.Parent = CoreGui
MainContainer.Parent = IYGui
Header.Parent = MainContainer
Title.Parent = Header
Version.Parent = Header
ControlButtons.Parent = Header
MinimizeBtn.Parent = ControlButtons
CloseBtn.Parent = ControlButtons
CommandSection.Parent = MainContainer
PrefixLabel.Parent = CommandSection
CommandInput.Parent = CommandSection
QuickActions.Parent = MainContainer
CommandsFrame.Parent = MainContainer
StatusBar.Parent = MainContainer
StatusLabel.Parent = StatusBar

-- Create Quick Action Buttons
local FlyBtn = CreateQuickAction("FLY", Colors.Accent)
FlyBtn.LayoutOrder = 1
FlyBtn.Parent = QuickActions

local NoclipBtn = CreateQuickAction("NOCLIP", Colors.Warning)
NoclipBtn.LayoutOrder = 2
NoclipBtn.Parent = QuickActions

local ToolsBtn = CreateQuickAction("TOOLS", Colors.Success)
ToolsBtn.LayoutOrder = 3
ToolsBtn.Parent = QuickActions

local EspBtn = CreateQuickAction("ESP", Colors.Danger)
EspBtn.LayoutOrder = 4
EspBtn.Parent = QuickActions

-- Command System
local Commands = {}
local Aliases = {}
local PlayerStates = {
    Flying = false,
    Noclipping = false,
    ESP = false,
    Speed = 16,
    JumpPower = 50,
    GodMode = false,
    Invisible = false,
    AutoFarm = false,
    InfiniteJump = false,
    FullBright = false,
    NightVision = false,
    Chams = false,
    Tracers = false,
    Nametags = false,
    Crosshair = false,
    NoRecoil = false,
    AntiAFK = false,
    FOV = 70,
    Gravity = 196.2,
    FogEnd = 100000,
    Ambient = Color3.fromRGB(0, 0, 0),
    ClockTime = 12,
    Atmosphere = {Density = 0, Offset = 0, Color = Color3.fromRGB(0, 0, 0)},
    Skybox = "rbxassetid://7013747443",
    Shader = "Default"
}

-- Utility Functions
local function Notify(message, color)
    color = color or Colors.Accent
    StatusLabel.Text = message
    StatusLabel.TextColor3 = color
    delay(3, function()
        if StatusLabel.Text == message then
            StatusLabel.Text = "Ready"
            StatusLabel.TextColor3 = Colors.Success
        end
    end)
end

local function CreateNotification(title, message, duration)
    duration = duration or 5
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 320, 0, 80)
    notification.Position = UDim2.new(0, 20, 0, 20)
    notification.BackgroundColor3 = Colors.Background
    notification.BackgroundTransparency = 0.2
    notification.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification

    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.Accent
    stroke.Thickness = 1.5
    stroke.Transparency = 0.5
    stroke.Parent = notification

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Colors.Accent
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local messageLabel = Instance.new("TextLabel")
    messageLabel.Size = UDim2.new(1, -20, 1, -40)
    messageLabel.Position = UDim2.new(0, 10, 0, 35)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Text = message
    messageLabel.TextColor3 = Colors.Text
    messageLabel.TextSize = 14
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.TextWrapped = true

    notification.Parent = IYGui
    titleLabel.Parent = notification
    messageLabel.Parent = notification

    TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 20, 0, 20)}):Play()

    delay(duration, function()
        TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 20, 0, -100)}):Play()
        wait(0.3)
        notification:Destroy()
    end)
end

local function GetPlayer(name)
    local players = {}
    name = name:lower()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if player.Name:lower():find(name) or player.DisplayName:lower():find(name) then
                table.insert(players, player)
            end
        end
    end
    return players
end

-- Command Definitions
Commands["fly"] = {
    Description = "Toggle flight mode",
    Function = function(args)
        PlayerStates.Flying = not PlayerStates.Flying
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if PlayerStates.Flying then
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
                    bodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
                    Notify("Flight: ON", Colors.Success)
                else
                    for _, v in pairs(character:GetChildren()) do
                        if v:IsA("BodyVelocity") then
                            v:Destroy()
                        end
                    end
                    Notify("Flight: OFF", Colors.Danger)
                end
            end
        end
    end
}

Commands["noclip"] = {
    Description = "Toggle noclip mode",
    Function = function(args)
        PlayerStates.Noclipping = not PlayerStates.Noclipping
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not PlayerStates.Noclipping
                end
            end
            Notify("Noclip: " .. (PlayerStates.Noclipping and "ON" or "OFF"), PlayerStates.Noclipping and Colors.Success or Colors.Danger)
        end
    end
}

Commands["god"] = {
    Description = "Toggle god mode",
    Function = function(args)
        PlayerStates.GodMode = not PlayerStates.GodMode
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.MaxHealth = PlayerStates.GodMode and math.huge or 100
                humanoid.Health = PlayerStates.GodMode and math.huge or 100
                Notify("God Mode: " .. (PlayerStates.GodMode and "ON" or "OFF"), PlayerStates.GodMode and Colors.Success or Colors.Danger)
            end
        end
    end
}

Commands["invis"] = {
    Description = "Toggle invisibility",
    Function = function(args)
        PlayerStates.Invisible = not PlayerStates.Invisible
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = PlayerStates.Invisible and 1 or 0
                elseif part:IsA("Decal") then
                    part.Transparency = PlayerStates.Invisible and 1 or 0
                end
            end
            Notify("Invisibility: " .. (PlayerStates.Invisible and "ON" or "OFF"), PlayerStates.Invisible and Colors.Success or Colors.Danger)
        end
    end
}

Commands["speed"] = {
    Description = "Set walk speed",
    Function = function(args)
        if args and args[1] and tonumber(args[1]) then
            local speed = tonumber(args[1])
            PlayerStates.Speed = speed
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = speed
                    Notify("Speed set to " .. speed, Colors.Success)
                end
            end
        else
            Notify("Usage: speed [number]", Colors.Warning)
        end
    end
}

Commands["jumppower"] = {
    Description = "Set jump power",
    Function = function(args)
        if args and args[1] and tonumber(args[1]) then
            local power = tonumber(args[1])
            PlayerStates.JumpPower = power
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.JumpPower = power
                    Notify("Jump power set to " .. power, Colors.Success)
                end
            end
        else
            Notify("Usage: jumppower [number]", Colors.Warning)
        end
    end
}

Commands["fov"] = {
    Description = "Set field of view",
    Function = function(args)
        if args and args[1] and tonumber(args[1]) then
            local fov = tonumber(args[1])
            PlayerStates.FOV = fov
            Workspace.CurrentCamera.FieldOfView = fov
            Notify("FOV set to " .. fov, Colors.Success)
        else
            Notify("Usage: fov [number]", Colors.Warning)
        end
    end
}

Commands["gravity"] = {
    Description = "Set workspace gravity",
    Function = function(args)
        if args and args[1] and tonumber(args[1]) then
            local gravity = tonumber(args[1])
            PlayerStates.Gravity = gravity
            Workspace.Gravity = gravity
            Notify("Gravity set to " .. gravity, Colors.Success)
        else
            Notify("Usage: gravity [number]", Colors.Warning)
        end
    end
}

Commands["time"] = {
    Description = "Set time of day",
    Function = function(args)
        if args and args[1] and tonumber(args[1]) then
            local time = tonumber(args[1])
            PlayerStates.ClockTime = time
            Lighting.ClockTime = time
            Notify("Time set to " .. time, Colors.Success)
        else
            Notify("Usage: time [number]", Colors.Warning)
        end
    end
}

Commands["fog"] = {
    Description = "Set fog distance",
    Function = function(args)
        if args and args[1] and tonumber(args[1]) then
            local fog = tonumber(args[1])
            PlayerStates.FogEnd = fog
            Lighting.FogEnd = fog
            Notify("Fog set to " .. fog, Colors.Success)
        else
            Notify("Usage: fog [number]", Colors.Warning)
        end
    end
}

Commands["ambient"] = {
    Description = "Set ambient color (R G B)",
    Function = function(args)
        if args and args[1] and args[2] and args[3] and tonumber(args[1]) and tonumber(args[2]) and tonumber(args[3]) then
            local r, g, b = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
            PlayerStates.Ambient = Color3.fromRGB(r, g, b)
            Lighting.Ambient = PlayerStates.Ambient
            Notify("Ambient set to " .. r .. ", " .. g .. ", " .. b, Colors.Success)
        else
            Notify("Usage: ambient [R] [G] [B]", Colors.Warning)
        end
    end
}

Commands["skybox"] = {
    Description = "Set skybox (asset ID)",
    Function = function(args)
        if args and args[1] then
            local skyboxId = args[1]
            PlayerStates.Skybox = skyboxId
            Lighting.Sky.SkyboxBk = skyboxId
            Lighting.Sky.SkyboxDn = skyboxId
            Lighting.Sky.SkyboxFt = skyboxId
            Lighting.Sky.SkyboxLf = skyboxId
            Lighting.Sky.SkyboxRt = skyboxId
            Lighting.Sky.SkyboxUp = skyboxId
            Notify("Skybox set to " .. skyboxId, Colors.Success)
        else
            Notify("Usage: skybox [assetid]", Colors.Warning)
        end
    end
}

Commands["fullbright"] = {
    Description = "Toggle fullbright",
    Function = function(args)
        PlayerStates.FullBright = not PlayerStates.FullBright
        if PlayerStates.FullBright then
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.Brightness = 2
            Lighting.ClockTime = 12
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        else
            Lighting.Ambient = PlayerStates.Ambient
            Lighting.Brightness = 1
            Lighting.ClockTime = PlayerStates.ClockTime
            Lighting.FogEnd = PlayerStates.FogEnd
            Lighting.GlobalShadows = true
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
        Notify("Fullbright: " .. (PlayerStates.FullBright and "ON" or "OFF"), PlayerStates.FullBright and Colors.Success or Colors.Danger)
    end
}

Commands["nightvision"] = {
    Description = "Toggle night vision",
    Function = function(args)
        PlayerStates.NightVision = not PlayerStates.NightVision
        if PlayerStates.NightVision then
            Lighting.Ambient = Color3.fromRGB(0, 255, 0)
            Lighting.ColorShift_Bottom = Color3.fromRGB(0, 255, 0)
            Lighting.ColorShift_Top = Color3.fromRGB(0, 255, 0)
            Lighting.Brightness = 1
        else
            Lighting.Ambient = PlayerStates.Ambient
            Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
            Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
            Lighting.Brightness = 1
        end
        Notify("Night Vision: " .. (PlayerStates.NightVision and "ON" or "OFF"), PlayerStates.NightVision and Colors.Success or Colors.Danger)
    end
}

Commands["chams"] = {
    Description = "Toggle chams on players",
    Function = function(args)
        PlayerStates.Chams = not PlayerStates.Chams
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local chams = player.Character:FindFirstChild("IY_Chams")
                if PlayerStates.Chams then
                    if not chams then
                        chams = Instance.new("Highlight")
                        chams.Name = "IY_Chams"
                        chams.FillColor = Color3.fromRGB(255, 0, 0)
                        chams.OutlineColor = Color3.fromRGB(255, 255, 255)
                        chams.FillTransparency = 0.5
                        chams.Parent = player.Character
                    end
                else
                    if chams then
                        chams:Destroy()
                    end
                end
            end
        end
        Notify("Chams: " .. (PlayerStates.Chams and "ON" or "OFF"), PlayerStates.Chams and Colors.Success or Colors.Danger)
    end
}

Commands["tracers"] = {
    Description = "Toggle tracers on players",
    Function = function(args)
        PlayerStates.Tracers = not PlayerStates.Tracers
        if PlayerStates.Tracers then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local tracer = Instance.new("Part")
                    tracer.Name = "IY_Tracer"
                    tracer.Anchored = true
                    tracer.CanCollide = false
                    tracer.Size = Vector3.new(0.1, 0.1, 1000)
                    tracer.Color = Color3.fromRGB(255, 0, 0)
                    tracer.Material = Enum.Material.Neon
                    tracer.Transparency = 0.5
                    tracer.Parent = Workspace
                    local attach = Instance.new("Attachment", tracer)
                    attach.Position = Vector3.new(0, 0, -500)
                    local attach2 = Instance.new("Attachment", player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso"))
                    local beam = Instance.new("Beam")
                    beam.Attachment0 = attach
                    beam.Attachment1 = attach2
                    beam.Color = Color3.fromSequence(ColorSequence.new(Color3.fromRGB(255, 0, 0)))
                    beam.Parent = tracer
                end
            end
        else
            for _, obj in pairs(Workspace:GetChildren()) do
                if obj.Name == "IY_Tracer" then
                    obj:Destroy()
                end
            end
        end
        Notify("Tracers: " .. (PlayerStates.Tracers and "ON" or "OFF"), PlayerStates.Tracers and Colors.Success or Colors.Danger)
    end
}

Commands["nametags"] = {
    Description = "Toggle nametags on players",
    Function = function(args)
        PlayerStates.Nametags = not PlayerStates.Nametags
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    local tag = head:FindFirstChild("IY_Nametag")
                    if PlayerStates.Nametags then
                        if not tag then
                            tag = Instance.new("BillboardGui")
                            tag.Name = "IY_Nametag"
                            tag.Size = UDim2.new(0, 200, 0, 50)
                            tag.StudsOffset = Vector3.new(0, 2, 0)
                            tag.AlwaysOnTop = true
                            tag.Adornee = head
                            tag.Parent = head
                            local nameTag = Instance.new("TextLabel")
                            nameTag.Size = UDim2.new(1, 0, 1, 0)
                            nameTag.BackgroundTransparency = 1
                            nameTag.Text = player.Name
                            nameTag.TextColor3 = Color3.fromRGB(255, 255, 255)
                            nameTag.TextSize = 14
                            nameTag.Font = Enum.Font.GothamBold
                            nameTag.TextStrokeTransparency = 0
                            nameTag.Parent = tag
                        end
                    else
                        if tag then
                            tag:Destroy()
                        end
                    end
                end
            end
        end
        Notify("Nametags: " .. (PlayerStates.Nametags and "ON" or "OFF"), PlayerStates.Nametags and Colors.Success or Colors.Danger)
    end
}

Commands["crosshair"] = {
    Description = "Toggle custom crosshair",
    Function = function(args)
        PlayerStates.Crosshair = not PlayerStates.Crosshair
        if PlayerStates.Crosshair then
            local crosshair = Instance.new("Frame")
            crosshair.Name = "IY_Crosshair"
            crosshair.Size = UDim2.new(0, 20, 0, 20)
            crosshair.Position = UDim2.new(0.5, -10, 0.5, -10)
            crosshair.BackgroundTransparency = 1
            crosshair.Parent = IYGui
            local line1 = Instance.new("Frame")
            line1.Size = UDim2.new(0, 10, 0, 1)
            line1.Position = UDim2.new(0.5, -5, 0.5, 0)
            line1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            line1.BorderSizePixel = 0
            line1.Parent = crosshair
            local line2 = Instance.new("Frame")
            line2.Size = UDim2.new(0, 1, 0, 10)
            line2.Position = UDim2.new(0.5, 0, 0.5, -5)
            line2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            line2.BorderSizePixel = 0
            line2.Parent = crosshair
        else
            local crosshair = IYGui:FindFirstChild("IY_Crosshair")
            if crosshair then
                crosshair:Destroy()
            end
        end
        Notify("Crosshair: " .. (PlayerStates.Crosshair and "ON" or "OFF"), PlayerStates.Crosshair and Colors.Success or Colors.Danger)
    end
}

Commands["infinitejump"] = {
    Description = "Toggle infinite jump",
    Function = function(args)
        PlayerStates.InfiniteJump = not PlayerStates.InfiniteJump
        if PlayerStates.InfiniteJump then
            local connection
            connection = UserInputService.JumpRequest:Connect(function()
                if LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
            table.insert(PlayerStates.Connections, connection)
        else
            for i, v in pairs(PlayerStates.Connections) do
                if v then
                    v:Disconnect()
                    table.remove(PlayerStates.Connections, i)
                end
            end
        end
        Notify("Infinite Jump: " .. (PlayerStates.InfiniteJump and "ON" or "OFF"), PlayerStates.InfiniteJump and Colors.Success or Colors.Danger)
    end
}

Commands["norecoil"] = {
    Description = "Toggle no recoil",
    Function = function(args)
        PlayerStates.NoRecoil = not PlayerStates.NoRecoil
        if PlayerStates.NoRecoil then
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if LocalPlayer.Character then
                    local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool and tool:FindFirstChild("Recoil") then
                        tool.Recoil.Value = 0
                    end
                end
            end)
            table.insert(PlayerStates.Connections, connection)
        else
            for i, v in pairs(PlayerStates.Connections) do
                if v then
                    v:Disconnect()
                    table.remove(PlayerStates.Connections, i)
                end
            end
        end
        Notify("No Recoil: " .. (PlayerStates.NoRecoil and "ON" or "OFF"), PlayerStates.NoRecoil and Colors.Success or Colors.Danger)
    end
}

Commands["antiafk"] = {
    Description = "Toggle anti-AFK",
    Function = function(args)
        PlayerStates.AntiAFK = not PlayerStates.AntiAFK
        if PlayerStates.AntiAFK then
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if LocalPlayer and LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:Move(Vector3.new(0, 1, 0), false)
                    end
                end
            end)
            table.insert(PlayerStates.Connections, connection)
        else
            for i, v in pairs(PlayerStates.Connections) do
                if v then
                    v:Disconnect()
                    table.remove(PlayerStates.Connections, i)
                end
            end
        end
        Notify("Anti-AFK: " .. (PlayerStates.AntiAFK and "ON" or "OFF"), PlayerStates.AntiAFK and Colors.Success or Colors.Danger)
    end
}

Commands["autofarm"] = {
    Description = "Toggle auto-farm (experimental)",
    Function = function(args)
        PlayerStates.AutoFarm = not PlayerStates.AutoFarm
        if PlayerStates.AutoFarm then
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 0, 5))
                    end
                end
            end)
            table.insert(PlayerStates.Connections, connection)
        else
            for i, v in pairs(PlayerStates.Connections) do
                if v then
                    v:Disconnect()
                    table.remove(PlayerStates.Connections, i)
                end
            end
        end
        Notify("Auto-Farm: " .. (PlayerStates.AutoFarm and "ON" or "OFF"), PlayerStates.AutoFarm and Colors.Success or Colors.Danger)
    end
}

Commands["reach"] = {
    Description = "Set tool reach distance",
    Function = function(args)
        if args and args[1] and tonumber(args[1]) then
            local reach = tonumber(args[1])
            for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Handle.Size = Vector3.new(1, 1, reach)
                end
            end
            for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    tool.Handle.Size = Vector3.new(1, 1, reach)
                end
            end
            Notify("Reach set to " .. reach, Colors.Success)
        else
            Notify("Usage: reach [number]", Colors.Warning)
        end
    end
}

Commands["clicktp"] = {
    Description = "Teleport to mouse position on click",
    Function = function(args)
        PlayerStates.ClickTP = not PlayerStates.ClickTP
        if PlayerStates.ClickTP then
            local connection
            connection = UserInputService.InputBegan:Connect(function(input, processed)
                if not processed and input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local character = LocalPlayer.Character
                    if character then
                        local root = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
                        if root then
                            root.CFrame = CFrame.new(Mouse.Hit.p)
                        end
                    end
                end
            end)
            table.insert(PlayerStates.Connections, connection)
        else
            for i, v in pairs(PlayerStates.Connections) do
                if v then
                    v:Disconnect()
                    table.remove(PlayerStates.Connections, i)
                end
            end
        end
        Notify("Click TP: " .. (PlayerStates.ClickTP and "ON" or "OFF"), PlayerStates.ClickTP and Colors.Success or Colors.Danger)
    end
}

Commands["bringall"] = {
    Description = "Bring all players to you",
    Function = function(args)
        local character = LocalPlayer.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
            if root then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
                        if targetRoot then
                            targetRoot.CFrame = root.CFrame * CFrame.new(0, 0, 5)
                        end
                    end
                end
                Notify("Brought all players", Colors.Success)
            end
        end
    end
}

Commands["gotoall"] = {
    Description = "Teleport to all players",
    Function = function(args)
        local character = LocalPlayer.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
            if root then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
                        if targetRoot then
                            root.CFrame = targetRoot.CFrame
                            wait(0.5)
                        end
                    end
                end
                Notify("Teleported to all players", Colors.Success)
            end
        end
    end
}

Commands["copyoutfit"] = {
    Description = "Copy a player's outfit",
    Function = function(args)
        if args and args[1] then
            local targetPlayers = GetPlayer(args[1])
            if #targetPlayers > 0 then
                local target = targetPlayers[1]
                local character = target.Character
                if character then
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("Accessory") then
                            local clone = part:Clone()
                            clone.Parent = LocalPlayer.Character
                        end
                    end
                    Notify("Copied " .. target.Name .. "'s outfit", Colors.Success)
                end
            else
                Notify("Player not found", Colors.Danger)
            end
        else
            Notify("Usage: copyoutfit [player]", Colors.Warning)
        end
    end
}

Commands["stealoutfit"] = {
    Description = "Steal a player's outfit (removes theirs)",
    Function = function(args)
        if args and args[1] then
            local targetPlayers = GetPlayer(args[1])
            if #targetPlayers > 0 then
                local target = targetPlayers[1]
                local character = target.Character
                if character then
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("Accessory") then
                            local clone = part:Clone()
                            clone.Parent = LocalPlayer.Character
                            part:Destroy()
                        end
                    end
                    Notify("Stole " .. target.Name .. "'s outfit", Colors.Success)
                end
            else
                Notify("Player not found", Colors.Danger)
            end
        else
            Notify("Usage: stealoutfit [player]", Colors.Warning)
        end
    end
}

Commands["follow"] = {
    Description = "Follow a player",
    Function = function(args)
        if args and args[1] then
            local targetPlayers = GetPlayer(args[1])
            if #targetPlayers > 0 then
                local target = targetPlayers[1]
                PlayerStates.Following = target
                local connection
                connection = RunService.Heartbeat:Connect(function()
                    if PlayerStates.Following and PlayerStates.Following.Character and LocalPlayer.Character then
                        local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character:FindFirstChild("Torso")
                        local targetRoot = PlayerStates.Following.Character:FindFirstChild("HumanoidRootPart") or PlayerStates.Following.Character:FindFirstChild("Torso")
                        if root and targetRoot then
                            root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 5)
                        end
                    else
                        connection:Disconnect()
                    end
                end)
                table.insert(PlayerStates.Connections, connection)
                Notify("Following " .. target.Name, Colors.Success)
            else
                Notify("Player not found", Colors.Danger)
            end
        else
            Notify("Usage: follow [player]", Colors.Warning)
        end
    end
}

Commands["unfollow"] = {
    Description = "Stop following a player",
    Function = function(args)
        PlayerStates.Following = nil
        for i, v in pairs(PlayerStates.Connections) do
            if v then
                v:Disconnect()
                table.remove(PlayerStates.Connections, i)
            end
        end
        Notify("Stopped following", Colors.Success)
    end
}

Commands["loopkill"] = {
    Description = "Loop kill a player",
    Function = function(args)
        if args and args[1] then
            local targetPlayers = GetPlayer(args[1])
            if #targetPlayers > 0 then
                local target = targetPlayers[1]
                local connection
                connection = RunService.Heartbeat:Connect(function()
                    if target and target.Character then
                        local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid.Health = 0
                        end
                    else
                        connection:Disconnect()
                    end
                end)
                table.insert(PlayerStates.Connections, connection)
                Notify("Loop killing " .. target.Name, Colors.Success)
            else
                Notify("Player not found", Colors.Danger)
            end
        else
            Notify("Usage: loopkill [player]", Colors.Warning)
        end
    end
}

Commands["serverhop"] = {
    Description = "Rejoin the game (server hop)",
    Function = function(args)
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
}

Commands["rejoin"] = {
    Description = "Rejoin the game",
    Function = function(args)
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
}

Commands["copyid"] = {
    Description = "Copy your user ID to clipboard",
    Function = function(args)
        setclipboard(LocalPlayer.UserId)
        Notify("Copied User ID: " .. LocalPlayer.UserId, Colors.Success)
    end
}

Commands["copypos"] = {
    Description = "Copy your position to clipboard",
    Function = function(args)
        if LocalPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character:FindFirstChild("Torso")
            if root then
                setclipboard(tostring(root.Position))
                Notify("Copied Position: " .. tostring(root.Position), Colors.Success)
            end
        end
    end
}

Commands["invisibleothers"] = {
    Description = "Make all players invisible except you",
    Function = function(args)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                    elseif part:IsA("Decal") then
                        part.Transparency = 1
                    end
                end
            end
        end
        Notify("Made others invisible", Colors.Success)
    end
}

Commands["visibleothers"] = {
    Description = "Make all players visible again",
    Function = function(args)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0
                    elseif part:IsA("Decal") then
                        part.Transparency = 0
                    end
                end
            end
        end
        Notify("Made others visible", Colors.Success)
    end
}

Commands["cmds"] = {
    Description = "Show all commands",
    Function = function(args)
        local cmdList = {}
        for cmd, _ in pairs(Commands) do
            table.insert(cmdList, cmd)
        end
        table.sort(cmdList)
        local message = "Available Commands:\n" .. table.concat(cmdList, ", ")
        CreateNotification("Commands", message, 20)
        Notify("Commands list shown", Colors.Success)
    end
}

Commands["help"] = {
    Description = "Get help for a command",
    Function = function(args)
        if args and args[1] then
            local cmd = args[1]:lower()
            if Commands[cmd] then
                CreateNotification("Help: " .. cmd, Commands[cmd].Description, 5)
            else
                Notify("Command not found: " .. cmd, Colors.Danger)
            end
        else
            Notify("Usage: help [command]", Colors.Warning)
        end
    end
}

-- Populate Commands List
local commandList = {
    "fly - Toggle flight mode",
    "noclip - Toggle noclip mode",
    "god - Toggle god mode",
    "invis - Toggle invisibility",
    "speed [num] - Set walk speed",
    "jumppower [num] - Set jump power",
    "fov [num] - Set field of view",
    "gravity [num] - Set workspace gravity",
    "time [num] - Set time of day",
    "fog [num] - Set fog distance",
    "ambient [R] [G] [B] - Set ambient color",
    "skybox [assetid] - Set skybox",
    "fullbright - Toggle fullbright",
    "nightvision - Toggle night vision",
    "chams - Toggle chams on players",
    "tracers - Toggle tracers on players",
    "nametags - Toggle nametags on players",
    "crosshair - Toggle custom crosshair",
    "infinitejump - Toggle infinite jump",
    "norecoil - Toggle no recoil",
    "antiafk - Toggle anti-AFK",
    "autofarm - Toggle auto-farm",
    "reach [num] - Set tool reach distance",
    "clicktp - Teleport to mouse position on click",
    "bringall - Bring all players to you",
    "gotoall - Teleport to all players",
    "copyoutfit [player] - Copy a player's outfit",
    "stealoutfit [player] - Steal a player's outfit",
    "follow [player] - Follow a player",
    "unfollow - Stop following a player",
    "loopkill [player] - Loop kill a player",
    "serverhop - Rejoin the game",
    "rejoin - Rejoin the game",
    "copyid - Copy your user ID to clipboard",
    "copypos - Copy your position to clipboard",
    "invisibleothers - Make all players invisible except you",
    "visibleothers - Make all players visible again",
    "cmds - Show all commands",
    "help [cmd] - Get command help"
}

for i, cmdText in ipairs(commandList) do
    local cmdButton = CommandTemplate:Clone()
    cmdButton.Name = "Cmd_" .. i
    cmdButton.Text = cmdText
    cmdButton.Visible = true
    cmdButton.LayoutOrder = i
    cmdButton.Parent = CommandsFrame

    cmdButton.MouseEnter:Connect(function()
        TweenService:Create(cmdButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
    end)

    cmdButton.MouseLeave:Connect(function()
        TweenService:Create(cmdButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
    end)
end

-- Command Execution
local commandHistory = {}
local historyIndex = 0

function ExecuteCommand(input)
    table.insert(commandHistory, input)
    historyIndex = #commandHistory + 1

    local args = {}
    for arg in input:gmatch("%S+") do
        table.insert(args, arg)
    end

    if #args == 0 then return end

    local commandName = args[1]:lower()
    table.remove(args, 1)

    if Commands[commandName] then
        pcall(function()
            Commands[commandName].Function(args)
        end)
    else
        Notify("Unknown command: " .. commandName, Colors.Danger)
    end
end

-- GUI Functionality
local isMinimized = false
local originalSize = MainContainer.Size
local minimizedSize = UDim2.new(0, 500, 0, 50)

-- Drag functionality
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainContainer.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainContainer.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Close button
CloseBtn.MouseButton1Click:Connect(function()
    IYGui:Destroy()
    getgenv().IY_REVAMPED_LOADED = false
end)

-- Minimize button
MinimizeBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = originalSize}):Play()
        isMinimized = false
    else
        TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = minimizedSize}):Play()
        isMinimized = true
    end
end)

-- Command input
CommandInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local command = CommandInput.Text
        if command ~= "" then
            ExecuteCommand(command)
            CommandInput.Text = ""
        end
    end
end)

-- Command history navigation
CommandInput:CaptureFocus()
CommandInput:GetPropertyChangedSignal("Text"):Connect(function()
    if CommandInput:IsFocused() then
        CommandInput:ReleaseFocus()
        CommandInput:CaptureFocus()
    end
end)

CommandInput.Focused:Connect(function()
    CommandInput:GetPropertyChangedSignal("Text"):Connect(function()
        if CommandInput.Text:sub(1, 1) == ";" then
            CommandInput.Text = CommandInput.Text:sub(2)
        end
    end)
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and CommandInput:IsFocused() then
        if input.KeyCode == Enum.KeyCode.Up then
            if historyIndex > 1 then
                historyIndex = historyIndex - 1
                CommandInput.Text = commandHistory[historyIndex]
                CommandInput.CursorPosition = #CommandInput.Text + 1
            end
        elseif input.KeyCode == Enum.KeyCode.Down then
            if historyIndex < #commandHistory then
                historyIndex = historyIndex + 1
                CommandInput.Text = commandHistory[historyIndex] or ""
                CommandInput.CursorPosition = #CommandInput.Text + 1
            end
        end
    end
end)

-- Quick action buttons
FlyBtn.MouseButton1Click:Connect(function()
    ExecuteCommand("fly")
end)

NoclipBtn.MouseButton1Click:Connect(function()
    ExecuteCommand("noclip")
end)

ToolsBtn.MouseButton1Click:Connect(function()
    ExecuteCommand("btools")
end)

EspBtn.MouseButton1Click:Connect(function()
    ExecuteCommand("esp")
end)

-- Command list buttons
for _, cmdButton in pairs(CommandsFrame:GetChildren()) do
    if cmdButton:IsA("TextButton") and cmdButton ~= CommandTemplate then
        cmdButton.MouseButton1Click:Connect(function()
            local cmdText = cmdButton.Text:match("^(.-)%-") or cmdButton.Text
            CommandInput.Text = cmdText:gsub("^%s*(.-)%s*$", "%1")
            CommandInput:CaptureFocus()
        end)
    end
end

-- Auto-hide functionality
local lastInteraction = tick()
local autoHideConnection

local function resetAutoHide()
    lastInteraction = tick()
end

local function setupAutoHide()
    MainContainer.MouseEnter:Connect(resetAutoHide)
    CommandInput.Focused:Connect(resetAutoHide)

    autoHideConnection = RunService.Heartbeat:Connect(function()
        if tick() - lastInteraction > 15 and not CommandInput:IsFocused() and not isMinimized then
            TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = minimizedSize}):Play()
            isMinimized = true
        end
    end)
end

setupAutoHide()

-- Keybinds
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed then
        if input.KeyCode == Enum.KeyCode.RightShift then
            if isMinimized then
                TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = originalSize}):Play()
                isMinimized = false
            else
                TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = minimizedSize}):Play()
                isMinimized = true
            end
            resetAutoHide()
        elseif input.KeyCode == Enum.KeyCode.Semicolon then
            CommandInput:CaptureFocus()
            if isMinimized then
                TweenService:Create(MainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = originalSize}):Play()
                isMinimized = false
            end
            resetAutoHide()
        end
    end
end)

-- Noclip loop
RunService.Stepped:Connect(function()
    if PlayerStates.Noclipping then
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Welcome message
delay(1, function()
    CreateNotification(
        "Infinite Yield Revamped",
        "Modern UI Loaded!\nUse ; to open command bar\nRightShift to toggle GUI\n30+ New Commands Added!",
        10
    )
end)

Notify("Ready to use", Colors.Success)
return IYGui
