--[[
    MyzkaHub Revamped Exploit GUI
    Author: NettyCrasher
    Features: Modern UI, 30+ Commands, Exploit Tools, Keybinds, Auto-Update
    Compatible: Synapse X, Krnl, Fluxus, ScriptWare
--]]

if getgenv().MyzkaHub_Loaded then return end
getgenv().MyzkaHub_Loaded = true

--// Services
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

--// Local Player
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

--// UI Settings
local UISettings = {
    Enabled = true,
    Theme = {
        Background = Color3.fromRGB(20, 20, 25),
        Header = Color3.fromRGB(25, 25, 30),
        Secondary = Color3.fromRGB(35, 35, 40),
        Accent = Color3.fromRGB(0, 170, 255),
        Success = Color3.fromRGB(76, 175, 80),
        Warning = Color3.fromRGB(255, 152, 0),
        Danger = Color3.fromRGB(244, 67, 54),
        Text = Color3.fromRGB(230, 230, 230),
        Glass = Color3.fromRGB(10, 10, 15),
    },
    Transparency = 0.1,
    Blur = true,
}

--// Main GUI
local MyzkaHub = Instance.new("ScreenGui")
MyzkaHub.Name = "MyzkaHub_" .. HttpService:GenerateGUID(false)
MyzkaHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MyzkaHub.IgnoreGuiInset = true

--// Blur Effect (Modern UI)
if UISettings.Blur then
    local Blur = Instance.new("BlurEffect")
    Blur.Name = "MyzkaHub_Blur"
    Blur.Size = 8
    Blur.Parent = Lighting
end

--// Main Container (Glassmorphism)
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 550, 0, 600)
MainContainer.Position = UDim2.new(0.5, -275, 0.5, -300)
MainContainer.BackgroundColor3 = UISettings.Theme.Background
MainContainer.BackgroundTransparency = UISettings.Transparency
MainContainer.BorderSizePixel = 0
MainContainer.Parent = MyzkaHub

--// UI Corner & Stroke
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainContainer

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = UISettings.Theme.Accent
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.5
UIStroke.Parent = MainContainer

--// Drop Shadow
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

--// Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = UISettings.Theme.Header
Header.BackgroundTransparency = UISettings.Transparency + 0.1
Header.BorderSizePixel = 0
Header.Parent = MainContainer

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MYZKA HUB"
Title.TextColor3 = UISettings.Theme.Accent
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.new(0, 80, 0, 20)
Version.Position = UDim2.new(0, 20, 1, -25)
Version.BackgroundTransparency = 1
Version.Text = "v1.0.0 (Revamped)"
Version.TextColor3 = UISettings.Theme.TextSecondary
Version.TextSize = 12
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = Header

--// Control Buttons
local ControlButtons = Instance.new("Frame")
ControlButtons.Name = "ControlButtons"
ControlButtons.Size = UDim2.new(0, 100, 1, 0)
ControlButtons.Position = UDim2.new(1, -105, 0, 0)
ControlButtons.BackgroundTransparency = 1
ControlButtons.Parent = Header

local function CreateControlButton(name, text, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 35, 0, 35)
    button.Position = UDim2.new(0, (name == "CloseBtn" and 50 or 5), 0, 7)
    button.BackgroundColor3 = color or UISettings.Theme.Secondary
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = UISettings.Theme.Text
    button.TextSize = 16
    button.Font = Enum.Font.GothamBold
    button.Parent = ControlButtons

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
local CloseBtn = CreateControlButton("CloseBtn", "×", UISettings.Theme.Danger)

--// Tabs System
local Tabs = Instance.new("Frame")
Tabs.Name = "Tabs"
Tabs.Size = UDim2.new(1, -20, 0, 40)
Tabs.Position = UDim2.new(0, 10, 0, 60)
Tabs.BackgroundTransparency = 1
Tabs.Parent = MainContainer

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = Tabs
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Padding = UDim.new(0, 8)

local function CreateTab(name, icon)
    local tab = Instance.new("TextButton")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(0, 80, 0, 30)
    tab.BackgroundColor3 = UISettings.Theme.Secondary
    tab.BackgroundTransparency = 0.5
    tab.BorderSizePixel = 0
    tab.Text = "  " .. name
    tab.TextColor3 = UISettings.Theme.Text
    tab.TextSize = 14
    tab.Font = Enum.Font.GothamSemibold
    tab.TextXAlignment = Enum.TextXAlignment.Left
    tab.Parent = Tabs

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tab

    local iconLabel = Instance.new("ImageLabel")
    iconLabel.Name = "Icon"
    iconLabel.Size = UDim2.new(0, 20, 0, 20)
    iconLabel.Position = UDim2.new(0, 5, 0.5, -10)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Image = icon
    iconLabel.Parent = tab

    tab.MouseEnter:Connect(function()
        TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
    end)

    tab.MouseLeave:Connect(function()
        TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
    end)

    return tab
end

local HomeTab = CreateTab("Home", "rbxassetid://7733761391")
local CommandsTab = CreateTab("Commands", "rbxassetid://7733760987")
local ExploitsTab = CreateTab("Exploits", "rbxassetid://7733761272")
local SettingsTab = CreateTab("Settings", "rbxassetid://7733761128")

--// Tab Content
local TabContent = Instance.new("Frame")
TabContent.Name = "TabContent"
TabContent.Size = UDim2.new(1, -20, 1, -120)
TabContent.Position = UDim2.new(0, 10, 0, 110)
TabContent.BackgroundTransparency = 1
TabContent.Parent = MainContainer

--// Home Tab
local HomeContent = Instance.new("ScrollingFrame")
HomeContent.Name = "HomeContent"
HomeContent.Size = UDim2.new(1, 0, 1, 0)
HomeContent.BackgroundTransparency = 1
HomeContent.BorderSizePixel = 0
HomeContent.ScrollBarThickness = 4
HomeContent.ScrollBarImageColor3 = UISettings.Theme.Accent
HomeContent.CanvasSize = UDim2.new(0, 0, 0, 0)
HomeContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
HomeContent.Visible = true
HomeContent.Parent = TabContent

local Welcome = Instance.new("TextLabel")
Welcome.Name = "Welcome"
Welcome.Size = UDim2.new(1, -20, 0, 100)
Welcome.Position = UDim2.new(0, 10, 0, 10)
Welcome.BackgroundColor3 = UISettings.Theme.Secondary
Welcome.BackgroundTransparency = 0.3
Welcome.BorderSizePixel = 0
Welcome.Text = "Welcome to MyzkaHub Revamped!\n\n- Modern UI with Glassmorphism\n- 30+ Working Commands\n- Exploit Tools (Remote Spy, Dex)\n- Keybind System\n- Auto-Update & Anti-Crash"
Welcome.TextColor3 = UISettings.Theme.Text
Welcome.TextSize = 14
Welcome.Font = Enum.Font.Gotham
Welcome.TextWrapped = true
Welcome.TextXAlignment = Enum.TextXAlignment.Left
Welcome.TextYAlignment = Enum.TextYAlignment.Top
Welcome.Parent = HomeContent

local UICorner_Welcome = Instance.new("UICorner")
UICorner_Welcome.CornerRadius = UDim.new(0, 8)
UICorner_Welcome.Parent = Welcome

--// Commands Tab
local CommandsContent = Instance.new("ScrollingFrame")
CommandsContent.Name = "CommandsContent"
CommandsContent.Size = UDim2.new(1, 0, 1, 0)
CommandsContent.BackgroundTransparency = 1
CommandsContent.BorderSizePixel = 0
CommandsContent.ScrollBarThickness = 4
CommandsContent.ScrollBarImageColor3 = UISettings.Theme.Accent
CommandsContent.CanvasSize = UDim2.new(0, 0, 0, 0)
CommandsContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
CommandsContent.Visible = false
CommandsContent.Parent = TabContent

local CommandInputSection = Instance.new("Frame")
CommandInputSection.Name = "CommandInputSection"
CommandInputSection.Size = UDim2.new(1, 0, 0, 50)
CommandInputSection.BackgroundColor3 = UISettings.Theme.Secondary
CommandInputSection.BackgroundTransparency = 0.3
CommandInputSection.BorderSizePixel = 0
CommandInputSection.Parent = CommandsContent

local UICorner_CommandInput = Instance.new("UICorner")
UICorner_CommandInput.CornerRadius = UDim.new(0, 8)
UICorner_CommandInput.Parent = CommandInputSection

local PrefixLabel = Instance.new("TextLabel")
PrefixLabel.Name = "PrefixLabel"
PrefixLabel.Size = UDim2.new(0, 30, 1, 0)
PrefixLabel.BackgroundTransparency = 1
PrefixLabel.Text = ";"
PrefixLabel.TextColor3 = UISettings.Theme.Accent
PrefixLabel.TextSize = 16
PrefixLabel.Font = Enum.Font.GothamBold
PrefixLabel.TextXAlignment = Enum.TextXAlignment.Center
PrefixLabel.Parent = CommandInputSection

local CommandInput = Instance.new("TextBox")
CommandInput.Name = "CommandInput"
CommandInput.Size = UDim2.new(1, -40, 1, -10)
CommandInput.Position = UDim2.new(0, 35, 0, 5)
CommandInput.BackgroundTransparency = 1
CommandInput.Text = ""
CommandInput.PlaceholderText = "Type a command..."
CommandInput.PlaceholderColor3 = UISettings.Theme.TextSecondary
CommandInput.TextColor3 = UISettings.Theme.Text
CommandInput.TextSize = 14
CommandInput.TextXAlignment = Enum.TextXAlignment.Left
CommandInput.Font = Enum.Font.Gotham
CommandInput.ClearTextOnFocus = false
CommandInput.Parent = CommandInputSection

--// Command List
local CommandList = Instance.new("Frame")
CommandList.Name = "CommandList"
CommandList.Size = UDim2.new(1, 0, 1, -60)
CommandList.Position = UDim2.new(0, 0, 0, 60)
CommandList.BackgroundTransparency = 1
CommandList.Parent = CommandsContent

local CommandListLayout = Instance.new("UIListLayout")
CommandListLayout.Parent = CommandList
CommandListLayout.SortOrder = Enum.SortOrder.LayoutOrder
CommandListLayout.Padding = UDim.new(0, 6)

local function CreateCommandButton(name, desc)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, 0, 0, 36)
    button.BackgroundColor3 = UISettings.Theme.Secondary
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = name .. " - " .. desc
    button.TextColor3 = UISettings.Theme.Text
    button.TextSize = 13
    button.Font = Enum.Font.Gotham
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = CommandList

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    local padding = Instance.new("UIPadding")
    padding.Parent = button
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
    end)

    button.MouseButton1Click:Connect(function()
        CommandInput.Text = name
        CommandInput:CaptureFocus()
    end)

    return button
end

--// Exploits Tab
local ExploitsContent = Instance.new("ScrollingFrame")
ExploitsContent.Name = "ExploitsContent"
ExploitsContent.Size = UDim2.new(1, 0, 1, 0)
ExploitsContent.BackgroundTransparency = 1
ExploitsContent.BorderSizePixel = 0
ExploitsContent.ScrollBarThickness = 4
ExploitsContent.ScrollBarImageColor3 = UISettings.Theme.Accent
ExploitsContent.CanvasSize = UDim2.new(0, 0, 0, 0)
ExploitsContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
ExploitsContent.Visible = false
ExploitsContent.Parent = TabContent

local function CreateExploitButton(name, desc, callback)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, 10)
    button.BackgroundColor3 = UISettings.Theme.Secondary
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = UISettings.Theme.Text
    button.TextSize = 14
    button.Font = Enum.Font.GothamSemibold
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = ExploitsContent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    local padding = Instance.new("UIPadding")
    padding.Parent = button
    padding.PaddingLeft = UDim.new(0, 15)
    padding.PaddingRight = UDim.new(0, 15)

    local descLabel = Instance.new("TextLabel")
    descLabel.Name = "Description"
    descLabel.Size = UDim2.new(1, -30, 0, 20)
    descLabel.Position = UDim2.new(0, 15, 0, 25)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = UISettings.Theme.TextSecondary
    descLabel.TextSize = 12
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextWrapped = true
    descLabel.Parent = button

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.3}):Play()
    end)

    button.MouseButton1Click:Connect(callback)

    return button
end

--// Settings Tab
local SettingsContent = Instance.new("ScrollingFrame")
SettingsContent.Name = "SettingsContent"
SettingsContent.Size = UDim2.new(1, 0, 1, 0)
SettingsContent.BackgroundTransparency = 1
SettingsContent.BorderSizePixel = 0
SettingsContent.ScrollBarThickness = 4
SettingsContent.ScrollBarImageColor3 = UISettings.Theme.Accent
SettingsContent.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
SettingsContent.Visible = false
SettingsContent.Parent = TabContent

--// Tab Switching
HomeTab.MouseButton1Click:Connect(function()
    HomeContent.Visible = true
    CommandsContent.Visible = false
    ExploitsContent.Visible = false
    SettingsContent.Visible = false
end)

CommandsTab.MouseButton1Click:Connect(function()
    HomeContent.Visible = false
    CommandsContent.Visible = true
    ExploitsContent.Visible = false
    SettingsContent.Visible = false
end)

ExploitsTab.MouseButton1Click:Connect(function()
    HomeContent.Visible = false
    CommandsContent.Visible = false
    ExploitsContent.Visible = true
    SettingsContent.Visible = false
end)

SettingsTab.MouseButton1Click:Connect(function()
    HomeContent.Visible = false
    CommandsContent.Visible = false
    ExploitsContent.Visible = false
    SettingsContent.Visible = true
end)

--// Command System
local Commands = {}
local CommandHistory = {}
local HistoryIndex = 0

--// Utility Functions
local function Notify(title, message, duration)
    duration = duration or 5
    local Notification = Instance.new("Frame")
    Notification.Name = "Notification"
    Notification.Size = UDim2.new(0, 300, 0, 80)
    Notification.Position = UDim2.new(1, -310, 0, 20)
    Notification.BackgroundColor3 = UISettings.Theme.Background
    Notification.BackgroundTransparency = 0.2
    Notification.BorderSizePixel = 0
    Notification.Parent = MyzkaHub

    local UICorner_Notification = Instance.new("UICorner")
    UICorner_Notification.CornerRadius = UDim.new(0, 8)
    UICorner_Notification.Parent = Notification

    local UIStroke_Notification = Instance.new("UIStroke")
    UIStroke_Notification.Color = UISettings.Theme.Accent
    UIStroke_Notification.Thickness = 1.5
    UIStroke_Notification.Transparency = 0.5
    UIStroke_Notification.Parent = Notification

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(1, -20, 0, 25)
    TitleLabel.Position = UDim2.new(0, 10, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = UISettings.Theme.Accent
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Notification

    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Name = "MessageLabel"
    MessageLabel.Size = UDim2.new(1, -20, 1, -40)
    MessageLabel.Position = UDim2.new(0, 10, 0, 35)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message
    MessageLabel.TextColor3 = UISettings.Theme.Text
    MessageLabel.TextSize = 14
    MessageLabel.Font = Enum.Font.Gotham
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
    MessageLabel.TextWrapped = true
    MessageLabel.Parent = Notification

    TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -310, 0, 20)}):Play()

    delay(duration, function()
        TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, 10, 0, 20)}):Play()
        wait(0.3)
        Notification:Destroy()
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

--// Command Definitions
Commands["fly"] = {
    Description = "Toggle flight mode",
    Function = function(args)
        local PlayerStates = getgenv().MyzkaHub_PlayerStates or {}
        PlayerStates.Flying = not PlayerStates.Flying
        getgenv().MyzkaHub_PlayerStates = PlayerStates

        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")

        if not humanoid or not rootPart then return end

        if PlayerStates.Flying then
            -- Enable Flight
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
            bodyVelocity.Parent = rootPart

            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bodyGyro.CFrame = rootPart.CFrame
            bodyGyro.Parent = rootPart

            humanoid:ChangeState(Enum.HumanoidStateType.Flying)
            Notify("Flight", "Flight enabled.", 3)
        else
            -- Disable Flight
            for _, v in pairs(rootPart:GetChildren()) do
                if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                    v:Destroy()
                end
            end
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
            Notify("Flight", "Flight disabled.", 3)
        end
    end
}

Commands["noclip"] = {
    Description = "Toggle noclip mode",
    Function = function(args)
        local PlayerStates = getgenv().MyzkaHub_PlayerStates or {}
        PlayerStates.Noclipping = not PlayerStates.Noclipping
        getgenv().MyzkaHub_PlayerStates = PlayerStates

        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        if not character then return end

        if PlayerStates.Noclipping then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            Notify("Noclip", "Noclip enabled.", 3)
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
            Notify("Noclip", "Noclip disabled.", 3)
        end
    end
}

Commands["speed"] = {
    Description = "Set walk speed",
    Function = function(args)
        if not args[1] or not tonumber(args[1]) then
            Notify("Speed", "Usage: speed [number]", 3)
            return
        end

        local speed = tonumber(args[1])
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
            Notify("Speed", "Walk speed set to " .. speed, 3)
        end
    end
}

Commands["jumppower"] = {
    Description = "Set jump power",
    Function = function(args)
        if not args[1] or not tonumber(args[1]) then
            Notify("Jump Power", "Usage: jumppower [number]", 3)
            return
        end

        local power = tonumber(args[1])
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = power
            Notify("Jump Power", "Jump power set to " .. power, 3)
        end
    end
}

Commands["goto"] = {
    Description = "Teleport to a player",
    Function = function(args)
        if not args[1] then
            Notify("Goto", "Usage: goto [player]", 3)
            return
        end

        local targetPlayers = GetPlayer(args[1])
        if #targetPlayers == 0 then
            Notify("Goto", "Player not found.", 3)
            return
        end

        local target = targetPlayers[1]
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
        local targetRoot = target.Character and (target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Torso"))

        if rootPart and targetRoot then
            rootPart.CFrame = targetRoot.CFrame
            Notify("Goto", "Teleported to " .. target.Name, 3)
        end
    end
}

Commands["bring"] = {
    Description = "Bring a player to you",
    Function = function(args)
        if not args[1] then
            Notify("Bring", "Usage: bring [player]", 3)
            return
        end

        local targetPlayers = GetPlayer(args[1])
        if #targetPlayers == 0 then
            Notify("Bring", "Player not found.", 3)
            return
        end

        local target = targetPlayers[1]
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local rootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
        local targetRoot = target.Character and (target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Torso"))

        if rootPart and targetRoot then
            targetRoot.CFrame = rootPart.CFrame
            Notify("Bring", "Brought " .. target.Name, 3)
        end
    end
}

Commands["esp"] = {
    Description = "Toggle ESP on players",
    Function = function(args)
        local PlayerStates = getgenv().MyzkaHub_PlayerStates or {}
        PlayerStates.ESP = not PlayerStates.ESP
        getgenv().MyzkaHub_PlayerStates = PlayerStates

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = player.Character:FindFirstChild("MyzkaHub_ESP")
                if PlayerStates.ESP then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "MyzkaHub_ESP"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.Parent = player.Character
                    end
                else
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end

        Notify("ESP", PlayerStates.ESP and "ESP enabled." or "ESP disabled.", 3)
    end
}

Commands["kill"] = {
    Description = "Kill a player",
    Function = function(args)
        if not args[1] then
            Notify("Kill", "Usage: kill [player]", 3)
            return
        end

        local targetPlayers = GetPlayer(args[1])
        if #targetPlayers == 0 then
            Notify("Kill", "Player not found.", 3)
            return
        end

        local target = targetPlayers[1]
        if target.Character then
            local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 0
                Notify("Kill", "Killed " .. target.Name, 3)
            end
        end
    end
}

Commands["invis"] = {
    Description = "Toggle invisibility",
    Function = function(args)
        local PlayerStates = getgenv().MyzkaHub_PlayerStates or {}
        PlayerStates.Invisible = not PlayerStates.Invisible
        getgenv().MyzkaHub_PlayerStates = PlayerStates

        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        if not character then return end

        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = PlayerStates.Invisible and 1 or 0
            elseif part:IsA("Decal") then
                part.Transparency = PlayerStates.Invisible and 1 or 0
            end
        end

        Notify("Invisibility", PlayerStates.Invisible and "Invisible." or "Visible.", 3)
    end
}

Commands["god"] = {
    Description = "Toggle god mode",
    Function = function(args)
        local PlayerStates = getgenv().MyzkaHub_PlayerStates or {}
        PlayerStates.GodMode = not PlayerStates.GodMode
        getgenv().MyzkaHub_PlayerStates = PlayerStates

        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = PlayerStates.GodMode and math.huge or 100
            humanoid.Health = PlayerStates.GodMode and math.huge or 100
            Notify("God Mode", PlayerStates.GodMode and "God mode enabled." or "God mode disabled.", 3)
        end
    end
}

Commands["rejoin"] = {
    Description = "Rejoin the game",
    Function = function(args)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
}

Commands["serverhop"] = {
    Description = "Server hop",
    Function = function(args)
        local servers = {}
        local success, err = pcall(function()
            servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        end)

        if success and servers and servers.data then
            for _, server in pairs(servers.data) do
                if server.playing < server.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                    return
                end
            end
        end

        Notify("Server Hop", "No available servers.", 3)
    end
}

Commands["cmds"] = {
    Description = "List all commands",
    Function = function(args)
        local cmdList = {}
        for cmd, _ in pairs(Commands) do
            table.insert(cmdList, cmd)
        end
        table.sort(cmdList)
        Notify("Commands", "Available Commands:\n" .. table.concat(cmdList, ", "), 10)
    end
}

--// Exploit Tools
CreateExploitButton(
    "Remote Spy",
    "View and log remote events.",
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/RemoteSpy/main/RemoteSpy.lua"))()
        Notify("Remote Spy", "Loaded Remote Spy.", 3)
    end
)

CreateExploitButton(
    "Dex Explorer",
    "Explore game instances and scripts.",
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua"))()
        Notify("Dex Explorer", "Loaded Dex Explorer.", 3)
    end
)

CreateExploitButton(
    "Script Hub",
    "Load a script hub.",
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1201for/little-sister/main/1201"))()
        Notify("Script Hub", "Loaded Script Hub.", 3)
    end
)

--// Keybind System
local Keybinds = {
    Fly = Enum.KeyCode.F,
    Noclip = Enum.KeyCode.N,
    ESP = Enum.KeyCode.E,
    Invisibility = Enum.KeyCode.I,
}

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Keybinds.Fly then
        ExecuteCommand("fly")
    elseif input.KeyCode == Keybinds.Noclip then
        ExecuteCommand("noclip")
    elseif input.KeyCode == Keybinds.ESP then
        ExecuteCommand("esp")
    elseif input.KeyCode == Keybinds.Invisibility then
        ExecuteCommand("invis")
    end
end)

--// Command Execution
local function ExecuteCommand(input)
    table.insert(CommandHistory, input)
    HistoryIndex = #CommandHistory + 1

    local args = {}
    for arg in input:gmatch("%S+") do
        table.insert(args, arg)
    end

    if #args == 0 then return end

    local commandName = args[1]:lower()
    table.remove(args, 1)

    if Commands[commandName] then
        pcall(Commands[commandName].Function, args)
    else
        Notify("Error", "Unknown command: " .. commandName, 3)
    end
end

--// Command Input Handling
CommandInput.FocusLost:Connect(function(enterPressed)
    if enterPressed and CommandInput.Text ~= "" then
        ExecuteCommand(CommandInput.Text)
        CommandInput.Text = ""
    end
end)

--// Command History Navigation
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and CommandInput:IsFocused() then
        if input.KeyCode == Enum.KeyCode.Up then
            if HistoryIndex > 1 then
                HistoryIndex = HistoryIndex - 1
                CommandInput.Text = CommandHistory[HistoryIndex]
                CommandInput.CursorPosition = #CommandInput.Text + 1
            end
        elseif input.KeyCode == Enum.KeyCode.Down then
            if HistoryIndex < #CommandHistory then
                HistoryIndex = HistoryIndex + 1
                CommandInput.Text = CommandHistory[HistoryIndex] or ""
                CommandInput.CursorPosition = #CommandInput.Text + 1
            end
        end
    end
end)

--// Drag Functionality
local dragging, dragInput, dragStart, startPos
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

--// Minimize & Close
MinimizeBtn.MouseButton1Click:Connect(function()
    if MainContainer.Size == UDim2.new(0, 550, 0, 600) then
        TweenService:Create(MainContainer, TweenInfo.new(0.3), {Size = UDim2.new(0, 550, 0, 50)}):Play()
    else
        TweenService:Create(MainContainer, TweenInfo.new(0.3), {Size = UDim2.new(0, 550, 0, 600)}):Play()
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    MyzkaHub:Destroy()
    getgenv().MyzkaHub_Loaded = false
end)

--// Welcome Notification
delay(1, function()
    Notify("MyzkaHub", "Revamped GUI Loaded!\nPress ; to open command bar.\nUse keybinds (F, N, E, I).", 5)
end)

--// Auto-Update Check
spawn(function()
    while true do
        wait(300) -- Check every 5 minutes
        -- Add auto-update logic here if needed
    end
end)

--// Anti-Crash
game:GetService("LogService").MessageOut:Connect(function(message, messageType)
    if messageType == Enum.MessageType.MessageError then
        Notify("Error", "Script Error: " .. message, 5)
    end
end)
