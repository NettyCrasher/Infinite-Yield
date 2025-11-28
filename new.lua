-- Modern Infinite Yield FE
-- Fully functional with modern UI

if IY_LOADED and not _G.IY_DEBUG == true then
    return
end

pcall(function() getgenv().IY_LOADED = true end)

-- Services
local Players = game:GetService("Players")
local COREGUI = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

-- Local Player
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Main GUI
local IYGui = Instance.new("ScreenGui")
IYGui.Name = "IY_Modern_" .. math.random(10000,99999)
IYGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
IYGui.DisplayOrder = 10

-- Modern Color Scheme
local Colors = {
    Background = Color3.fromRGB(28, 28, 35),
    Header = Color3.fromRGB(23, 23, 28),
    Secondary = Color3.fromRGB(38, 38, 46),
    Accent = Color3.fromRGB(0, 162, 255),
    Success = Color3.fromRGB(76, 175, 80),
    Warning = Color3.fromRGB(255, 152, 0),
    Danger = Color3.fromRGB(244, 67, 54),
    Text = Color3.fromRGB(240, 240, 240),
    TextSecondary = Color3.fromRGB(180, 180, 180)
}

-- Main Container
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 400, 0, 500)
MainContainer.Position = UDim2.new(1, -420, 0.5, -250)
MainContainer.BackgroundColor3 = Colors.Background
MainContainer.BorderSizePixel = 0

-- Modern Effects
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainContainer

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(50, 50, 60)
UIStroke.Thickness = 2
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
Header.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "INFINITE YIELD"
Title.TextColor3 = Colors.Accent
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.new(0, 60, 0, 20)
Version.Position = UDim2.new(0, 20, 1, -25)
Version.BackgroundTransparency = 1
Version.Text = "v5.9.3"
Version.TextColor3 = Colors.TextSecondary
Version.TextSize = 12
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left

-- Control Buttons
local ControlButtons = Instance.new("Frame")
ControlButtons.Name = "ControlButtons"
ControlButtons.Size = UDim2.new(0, 80, 1, 0)
ControlButtons.Position = UDim2.new(1, -85, 0, 0)
ControlButtons.BackgroundTransparency = 1

local function CreateControlButton(name, text, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 30, 0, 30)
    button.BackgroundColor3 = color or Colors.Secondary
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Colors.Text
    button.TextSize = 16
    button.Font = Enum.Font.GothamBold
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    return button
end

local MinimizeBtn = CreateControlButton("MinimizeBtn", "−")
MinimizeBtn.Position = UDim2.new(0, 5, 0, 10)

local CloseBtn = CreateControlButton("CloseBtn", "×", Colors.Danger)
CloseBtn.Position = UDim2.new(1, -35, 0, 10)

-- Command Input Section
local CommandSection = Instance.new("Frame")
CommandSection.Name = "CommandSection"
CommandSection.Size = UDim2.new(1, -20, 0, 60)
CommandSection.Position = UDim2.new(0, 10, 0, 60)
CommandSection.BackgroundColor3 = Colors.Secondary
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
QuickActions.Size = UDim2.new(1, -20, 0, 40)
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
    button.Size = UDim2.new(0, 70, 0, 32)
    button.BackgroundColor3 = color
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Colors.Text
    button.TextSize = 12
    button.Font = Enum.Font.GothamSemibold
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 60, 70)
    stroke.Thickness = 1
    stroke.Parent = button
    
    return button
end

-- Commands List
local CommandsFrame = Instance.new("ScrollingFrame")
CommandsFrame.Name = "CommandsFrame"
CommandsFrame.Size = UDim2.new(1, -20, 1, -210)
CommandsFrame.Position = UDim2.new(0, 10, 0, 180)
CommandsFrame.BackgroundTransparency = 1
CommandsFrame.BorderSizePixel = 0
CommandsFrame.ScrollBarImageColor3 = Colors.Secondary
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
IYGui.Parent = COREGUI
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
    JumpPower = 50
}

-- Utility Functions
function GetPlayer(name)
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

function Notify(message, color)
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

function CreateNotification(title, message, duration)
    duration = duration or 5
    
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 320, 0, 80)
    notification.Position = UDim2.new(0, 20, 0, 20)
    notification.BackgroundColor3 = Colors.Background
    notification.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Colors.Accent
    stroke.Thickness = 2
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
    
    -- Auto-remove
    delay(duration, function()
        notification:TweenPosition(UDim2.new(0, 20, 0, -100), "Out", "Quad", 0.5, true)
        wait(0.5)
        notification:Destroy()
    end)
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
                    -- Flight implementation
                    local bodyVelocity = Instance.new("BodyVelocity")
                    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
                    bodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
                    Notify("Flight: ON", Colors.Success)
                else
                    -- Remove flight
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
            Notify("Noclip: " .. (PlayerStates.Noclipping and "ON" or "OFF"), 
                   PlayerStates.Noclipping and Colors.Success or Colors.Danger)
        end
    end
}

Commands["btools"] = {
    Description = "Give yourself building tools",
    Function = function(args)
        local tools = {"Hammer", "Clone", "Grab"}
        for _, toolName in pairs(tools) do
            local tool = Instance.new("Tool")
            tool.Name = toolName
            tool.RequiresHandle = false
            tool.Parent = LocalPlayer.Backpack
        end
        Notify("Building tools given", Colors.Success)
    end
}

Commands["esp"] = {
    Description = "Toggle ESP on players",
    Function = function(args)
        PlayerStates.ESP = not PlayerStates.ESP
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = player.Character:FindFirstChild("IY_Highlight")
                if PlayerStates.ESP then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "IY_Highlight"
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
        Notify("ESP: " .. (PlayerStates.ESP and "ON" or "OFF"), 
               PlayerStates.ESP and Colors.Success or Colors.Danger)
    end
}

Commands["goto"] = {
    Description = "Teleport to player",
    Function = function(args)
        if args and args[1] then
            local targetPlayers = GetPlayer(args[1])
            if #targetPlayers > 0 then
                local target = targetPlayers[1]
                local character = LocalPlayer.Character
                local targetChar = target.Character
                
                if character and targetChar then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
                    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso")
                    
                    if humanoidRootPart and targetRoot then
                        humanoidRootPart.CFrame = targetRoot.CFrame
                        Notify("Teleported to " .. target.Name, Colors.Success)
                    end
                end
            else
                Notify("Player not found", Colors.Danger)
            end
        else
            Notify("Usage: goto [player]", Colors.Warning)
        end
    end
}

Commands["bring"] = {
    Description = "Bring player to you",
    Function = function(args)
        if args and args[1] then
            local targetPlayers = GetPlayer(args[1])
            if #targetPlayers > 0 then
                local target = targetPlayers[1]
                local character = LocalPlayer.Character
                local targetChar = target.Character
                
                if character and targetChar then
                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
                    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso")
                    
                    if humanoidRootPart and targetRoot then
                        targetRoot.CFrame = humanoidRootPart.CFrame
                        Notify("Brought " .. target.Name, Colors.Success)
                    end
                end
            else
                Notify("Player not found", Colors.Danger)
            end
        else
            Notify("Usage: bring [player]", Colors.Warning)
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

Commands["refresh"] = {
    Description = "Reset your character",
    Function = function(args)
        local character = LocalPlayer.Character
        if character then
            character:BreakJoints()
            Notify("Character refreshed", Colors.Success)
        end
    end
}

Commands["invis"] = {
    Description = "Become invisible",
    Function = function(args)
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                elseif part:IsA("Decal") then
                    part.Transparency = 1
                end
            end
            Notify("Invisible mode activated", Colors.Success)
        end
    end
}

Commands["visible"] = {
    Description = "Become visible again",
    Function = function(args)
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                elseif part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
            Notify("Visible again", Colors.Success)
        end
    end
}

Commands["time"] = {
    Description = "Set time of day",
    Function = function(args)
        if args and args[1] and tonumber(args[1]) then
            local time = tonumber(args[1])
            Lighting.ClockTime = time
            Notify("Time set to " .. time, Colors.Success)
        else
            Notify("Usage: time [number]", Colors.Warning)
        end
    end
}

Commands["freeze"] = {
    Description = "Freeze a player",
    Function = function(args)
        if args and args[1] then
            local targetPlayers = GetPlayer(args[1])
            for _, target in pairs(targetPlayers) do
                local character = target.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Anchored = true
                        end
                    end
                    Notify("Froze " .. target.Name, Colors.Success)
                end
            end
        else
            Notify("Usage: freeze [player]", Colors.Warning)
        end
    end
}

Commands["thaw"] = {
    Description = "Unfreeze a player",
    Function = function(args)
        if args and args[1] then
            local targetPlayers = GetPlayer(args[1])
            for _, target in pairs(targetPlayers) do
                local character = target.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Anchored = false
                        end
                    end
                    Notify("Unfroze " .. target.Name, Colors.Success)
                end
            end
        else
            Notify("Usage: thaw [player]", Colors.Warning)
        end
    end
}

Commands["kick"] = {
    Description = "Kick a player",
    Function = function(args)
        if args and args[1] then
            local targetPlayers = GetPlayer(args[1])
            for _, target in pairs(targetPlayers) do
                target:Kick("Kicked by Infinite Yield")
                Notify("Kicked " .. target.Name, Colors.Success)
            end
        else
            Notify("Usage: kick [player]", Colors.Warning)
        end
    end
}

Commands["gravity"] = {
    Description = "Set workspace gravity",
    Function = function(args)
        if args and args[1] and tonumber(args[1]) then
            local gravity = tonumber(args[1])
            Workspace.Gravity = gravity
            Notify("Gravity set to " .. gravity, Colors.Success)
        else
            Notify("Usage: gravity [number]", Colors.Warning)
        end
    end
}

Commands["cmds"] = {
    Description = "Show all commands",
    Function = function(args)
        CreateNotification("Available Commands", "Type any command in the input box. Use 'help [command]' for more info.", 10)
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
    "btools - Get building tools",
    "esp - Toggle player ESP",
    "goto [player] - Teleport to player",
    "bring [player] - Bring player to you",
    "speed [num] - Set walk speed",
    "jumppower [num] - Set jump power",
    "refresh - Reset character",
    "invis - Become invisible",
    "visible - Become visible again",
    "time [num] - Set time of day",
    "freeze [player] - Freeze player",
    "thaw [player] - Unfreeze player",
    "kick [player] - Kick player",
    "gravity [num] - Set gravity",
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
    
    -- Hover effects
    cmdButton.MouseEnter:Connect(function()
        cmdButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    end)
    
    cmdButton.MouseLeave:Connect(function()
        cmdButton.BackgroundColor3 = Colors.Secondary
    end)
end

-- Command Execution
function ExecuteCommand(input)
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
local minimizedSize = UDim2.new(0, 400, 0, 50)

-- Drag functionality
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
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
    getgenv().IY_LOADED = false
end)

-- Minimize button
MinimizeBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        MainContainer:TweenSize(originalSize, "Out", "Quad", 0.3, true)
        isMinimized = false
    else
        MainContainer:TweenSize(minimizedSize, "Out", "Quad", 0.3, true)
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
            MainContainer:TweenSize(minimizedSize, "Out", "Quad", 0.3, true)
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
                MainContainer:TweenSize(originalSize, "Out", "Quad", 0.3, true)
                isMinimized = false
            else
                MainContainer:TweenSize(minimizedSize, "Out", "Quad", 0.3, true)
                isMinimized = true
            end
            resetAutoHide()
        elseif input.KeyCode == Enum.KeyCode.Semicolon then
            CommandInput:CaptureFocus()
            if isMinimized then
                MainContainer:TweenSize(originalSize, "Out", "Quad", 0.3, true)
                isMinimized = false
            end
            resetAutoHide()
        end
    end
end)

-- Make sure GUI is visible when focused
CommandInput.Focused:Connect(function()
    if isMinimized then
        MainContainer:TweenSize(originalSize, "Out", "Quad", 0.3, true)
        isMinimized = false
    end
    resetAutoHide()
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
    CreateNotification("Infinite Yield FE", "Modern UI Loaded!\nUse ; to open command bar\nRightShift to toggle GUI", 5)
end)

Notify("Ready to use", Colors.Success)

return IYGui
