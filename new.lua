-- Redesigned Infinite Yield GUI
-- Cleaner, more modern interface

if IY_LOADED and not _G.IY_DEBUG == true then
	return
end

pcall(function() getgenv().IY_LOADED = true end)

-- Services
local Players = game:GetService("Players")
local COREGUI = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Create main GUI container
local IYGui = Instance.new("ScreenGui")
IYGui.Name = "IY_ModernUI_" .. math.random(10000,99999)
IYGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
IYGui.DisplayOrder = 10

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(1, -360, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

-- Modern rounded corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Drop shadow
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(20, 20, 25)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Header.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Infinite Yield FE v5.9.3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamSemibold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Minimize button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18
MinimizeButton.Font = Enum.Font.GothamBold

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 6)
MinimizeCorner.Parent = MinimizeButton

-- Command input
local CommandContainer = Instance.new("Frame")
CommandContainer.Name = "CommandContainer"
CommandContainer.Size = UDim2.new(1, -20, 0, 45)
CommandContainer.Position = UDim2.new(0, 10, 0, 50)
CommandContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
CommandContainer.BorderSizePixel = 0

local CommandCorner = Instance.new("UICorner")
CommandCorner.CornerRadius = UDim.new(0, 6)
CommandCorner.Parent = CommandContainer

local PrefixLabel = Instance.new("TextLabel")
PrefixLabel.Name = "PrefixLabel"
PrefixLabel.Size = UDim2.new(0, 30, 1, 0)
PrefixLabel.BackgroundTransparency = 1
PrefixLabel.Text = ";"
PrefixLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PrefixLabel.TextSize = 16
PrefixLabel.Font = Enum.Font.GothamMedium

local CommandInput = Instance.new("TextBox")
CommandInput.Name = "CommandInput"
CommandInput.Size = UDim2.new(1, -40, 1, 0)
CommandInput.Position = UDim2.new(0, 35, 0, 0)
CommandInput.BackgroundTransparency = 1
CommandInput.Text = ""
CommandInput.PlaceholderText = "Enter command..."
CommandInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandInput.TextSize = 14
CommandInput.TextXAlignment = Enum.TextXAlignment.Left
CommandInput.Font = Enum.Font.Gotham
CommandInput.ClearTextOnFocus = false

-- Command list
local CommandsFrame = Instance.new("ScrollingFrame")
CommandsFrame.Name = "CommandsFrame"
CommandsFrame.Size = UDim2.new(1, -20, 1, -120)
CommandsFrame.Position = UDim2.new(0, 10, 0, 105)
CommandsFrame.BackgroundTransparency = 1
CommandsFrame.BorderSizePixel = 0
CommandsFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 110)
CommandsFrame.ScrollBarThickness = 4
CommandsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local CommandsLayout = Instance.new("UIListLayout")
CommandsLayout.Parent = CommandsFrame
CommandsLayout.SortOrder = Enum.SortOrder.LayoutOrder
CommandsLayout.Padding = UDim.new(0, 5)

-- Quick actions bar
local QuickActions = Instance.new("Frame")
QuickActions.Name = "QuickActions"
QuickActions.Size = UDim2.new(1, -20, 0, 40)
QuickActions.Position = UDim2.new(0, 10, 1, -50)
QuickActions.BackgroundTransparency = 1

local QuickLayout = Instance.new("UIListLayout")
QuickLayout.Parent = QuickActions
QuickLayout.FillDirection = Enum.FillDirection.Horizontal
QuickLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
QuickLayout.SortOrder = Enum.SortOrder.LayoutOrder
QuickLayout.Padding = UDim.new(0, 10)

-- Quick action buttons
local function CreateQuickButton(text, color)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 80, 0, 30)
	button.BackgroundColor3 = color or Color3.fromRGB(50, 120, 220)
	button.BorderSizePixel = 0
	button.Text = text
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 12
	button.Font = Enum.Font.GothamSemibold
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = button
	
	return button
end

-- Command template
local CommandTemplate = Instance.new("TextButton")
CommandTemplate.Name = "CommandTemplate"
CommandTemplate.Size = UDim2.new(1, 0, 0, 30)
CommandTemplate.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
CommandTemplate.BorderSizePixel = 0
CommandTemplate.Text = "Command Name"
CommandTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandTemplate.TextSize = 13
CommandTemplate.Font = Enum.Font.Gotham
CommandTemplate.TextXAlignment = Enum.TextXAlignment.Left
CommandTemplate.Visible = false

local TemplateCorner = Instance.new("UICorner")
TemplateCorner.CornerRadius = UDim.new(0, 4)
TemplateCorner.Parent = CommandTemplate

local TemplatePadding = Instance.new("UIPadding")
TemplatePadding.Parent = CommandTemplate
TemplatePadding.PaddingLeft = UDim.new(0, 10)

-- Parent everything
IYGui.Parent = COREGUI
MainFrame.Parent = IYGui
Header.Parent = MainFrame
Title.Parent = Header
CloseButton.Parent = Header
MinimizeButton.Parent = Header
CommandContainer.Parent = MainFrame
PrefixLabel.Parent = CommandContainer
CommandInput.Parent = CommandContainer
CommandsFrame.Parent = MainFrame
QuickActions.Parent = MainFrame
CommandTemplate.Parent = CommandsFrame

-- Add quick action buttons
local FlyButton = CreateQuickButton("Fly", Color3.fromRGB(220, 80, 60))
FlyButton.Parent = QuickActions

local NoclipButton = CreateQuickButton("Noclip", Color3.fromRGB(80, 180, 80))
NoclipButton.Parent = QuickActions

local ToolsButton = CreateQuickButton("Tools", Color3.fromRGB(60, 140, 220))
ToolsButton.Parent = QuickActions

local SettingsButton = CreateQuickButton("Settings", Color3.fromRGB(150, 100, 220))
SettingsButton.Parent = QuickActions

-- Sample commands for demonstration
local sampleCommands = {
	"fly - Toggle flight mode",
	"noclip - Toggle noclip",
	"btools - Get building tools",
	"esp - Toggle player ESP",
	"goto [player] - Teleport to player",
	"bring [player] - Bring player to you",
	"kill [player] - Kill player",
	"refresh - Reset character",
	"invis - Become invisible",
	"speed [number] - Set walk speed",
	"jumppower [number] - Set jump power",
	"gravity [number] - Set gravity",
	"time [number] - Set time of day",
	"freeze [player] - Freeze player",
	"thaw [player] - Unfreeze player",
	"annoy [player] - Annoy player",
	"unannoy - Stop annoying",
	"loopgoto [player] - Loop teleport to player",
	"unloopgoto - Stop loop teleport"
}

-- Populate commands list
for i, cmd in ipairs(sampleCommands) do
	local cmdButton = CommandTemplate:Clone()
	cmdButton.Name = "Cmd_" .. i
	cmdButton.Text = cmd
	cmdButton.Visible = true
	cmdButton.LayoutOrder = i
	cmdButton.Parent = CommandsFrame
	
	-- Update canvas size
	CommandsFrame.CanvasSize = UDim2.new(0, 0, 0, CommandsLayout.AbsoluteContentSize.Y)
end

-- GUI functionality
local isMinimized = false
local originalSize = MainFrame.Size
local minimizedSize = UDim2.new(0, 350, 0, 40)

-- Drag functionality
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		
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

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
	IYGui:Destroy()
	getgenv().IY_LOADED = false
end)

-- Minimize functionality
MinimizeButton.MouseButton1Click:Connect(function()
	if isMinimized then
		-- Restore
		MainFrame:TweenSize(originalSize, "Out", "Quad", 0.3, true)
		isMinimized = false
	else
		-- Minimize
		MainFrame:TweenSize(minimizedSize, "Out", "Quad", 0.3, true)
		isMinimized = true
	end
end)

-- Command input functionality
CommandInput.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local command = CommandInput.Text
		if command ~= "" then
			-- Here you would execute the command
			print("Executing command:", command)
			CommandInput.Text = ""
		end
	end
end)

-- Quick action button functionality
FlyButton.MouseButton1Click:Connect(function()
	CommandInput.Text = "fly"
	CommandInput:CaptureFocus()
end)

NoclipButton.MouseButton1Click:Connect(function()
	CommandInput.Text = "noclip"
	CommandInput:CaptureFocus()
end)

ToolsButton.MouseButton1Click:Connect(function()
	CommandInput.Text = "btools"
	CommandInput:CaptureFocus()
end)

SettingsButton.MouseButton1Click:Connect(function()
	CommandInput.Text = "settings"
	CommandInput:CaptureFocus()
end)

-- Command button functionality
for _, cmdButton in pairs(CommandsFrame:GetChildren()) do
	if cmdButton:IsA("TextButton") and cmdButton ~= CommandTemplate then
		cmdButton.MouseButton1Click:Connect(function()
			local cmdText = cmdButton.Text:match("^(.-)%-") or cmdButton.Text
			CommandInput.Text = cmdText:gsub("^%s*(.-)%s*$", "%1")
			CommandInput:CaptureFocus()
		end)
		
		-- Hover effects
		cmdButton.MouseEnter:Connect(function()
			cmdButton.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
		end)
		
		cmdButton.MouseLeave:Connect(function()
			cmdButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
		end)
	end
end

-- Auto-hide when not in use
local lastInteraction = tick()
local autoHideConnection

local function resetAutoHide()
	lastInteraction = tick()
end

local function setupAutoHide()
	-- Reset timer on any interaction
	MainFrame.MouseEnter:Connect(resetAutoHide)
	CommandInput.Focused:Connect(resetAutoHide)
	
	autoHideConnection = game:GetService("RunService").Heartbeat:Connect(function()
		if tick() - lastInteraction > 10 and not CommandInput:IsFocused() and not isMinimized then
			-- Auto-minimize
			MainFrame:TweenSize(minimizedSize, "Out", "Quad", 0.3, true)
			isMinimized = true
		end
	end)
end

setupAutoHide()

-- Keybind to open/close (F3)
UserInputService.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.F3 then
		if isMinimized then
			MainFrame:TweenSize(originalSize, "Out", "Quad", 0.3, true)
			isMinimized = false
		else
			MainFrame:TweenSize(minimizedSize, "Out", "Quad", 0.3, true)
			isMinimized = true
		end
		resetAutoHide()
	end
end)

-- Make sure GUI is visible when focused
CommandInput.Focused:Connect(function()
	if isMinimized then
		MainFrame:TweenSize(originalSize, "Out", "Quad", 0.3, true)
		isMinimized = false
	end
	resetAutoHide()
end)

-- Notification system
local function showNotification(title, message, duration)
	duration = duration or 3
	
	local notification = Instance.new("Frame")
	notification.Size = UDim2.new(0, 300, 0, 80)
	notification.Position = UDim2.new(0.5, -150, 0, 10)
	notification.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
	notification.BorderSizePixel = 0
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = notification
	
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(20, 20, 25)
	stroke.Thickness = 2
	stroke.Parent = notification
	
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, -20, 0, 25)
	titleLabel.Position = UDim2.new(0, 10, 0, 10)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = title
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.TextSize = 16
	titleLabel.Font = Enum.Font.GothamSemibold
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	
	local messageLabel = Instance.new("TextLabel")
	messageLabel.Size = UDim2.new(1, -20, 1, -40)
	messageLabel.Position = UDim2.new(0, 10, 0, 35)
	messageLabel.BackgroundTransparency = 1
	messageLabel.Text = message
	messageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	messageLabel.TextSize = 14
	messageLabel.Font = Enum.Font.Gotham
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.TextYAlignment = Enum.TextYAlignment.Top
	messageLabel.TextWrapped = true
	
	notification.Parent = IYGui
	titleLabel.Parent = notification
	messageLabel.Parent = notification
	
	-- Auto-remove after duration
	delay(duration, function()
		notification:TweenPosition(UDim2.new(0.5, -150, 0, -100), "Out", "Quad", 0.5, true)
		wait(0.5)
		notification:Destroy()
	end)
end

-- Show welcome notification
showNotification("Infinite Yield", "Modern UI Loaded! Press F3 to toggle visibility.")

-- Return the GUI for external access
return IYGui
