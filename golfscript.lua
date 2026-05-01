--================ KEY SYSTEM =================--

local REQUIRED_KEY = "Golf" -- change this

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KeySystem"
KeyGui.Parent = PlayerGui
KeyGui.ResetOnSpawn = false

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 260, 0, 140)
KeyFrame.Position = UDim2.new(0.5, -130, 0.5, -70)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyFrame.Parent = KeyGui
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,10)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1,0,0,30)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔐 Enter Key"
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 16
KeyTitle.TextColor3 = Color3.new(1,1,1)
KeyTitle.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8,0,0,30)
KeyBox.Position = UDim2.new(0.1,0,0.4,0)
KeyBox.PlaceholderText = "Enter key..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
KeyBox.Parent = KeyFrame
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,6)

local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(0.5,0,0,30)
Submit.Position = UDim2.new(0.25,0,0.7,0)
Submit.Text = "Unlock"
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 14
Submit.TextColor3 = Color3.new(1,1,1)
Submit.BackgroundColor3 = Color3.fromRGB(0,170,100)
Submit.Parent = KeyFrame
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0,6)

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1,0,0,20)
Status.Position = UDim2.new(0,0,1,-20)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.Font = Enum.Font.Gotham
Status.TextSize = 13
Status.TextColor3 = Color3.fromRGB(255,80,80)
Status.Parent = KeyFrame

local Unlocked = false

Submit.MouseButton1Click:Connect(function()
	if KeyBox.Text == REQUIRED_KEY then
		Unlocked = true

		-- properly remove UI
		KeyGui.Enabled = false
		KeyFrame.Visible = false
		
		task.wait() -- small yield to ensure it disappears
		
		KeyGui:Destroy()
	else
		Status.Text = "Invalid key"
	end
end)

repeat task.wait() until Unlocked

--================ ORIGINAL SCRIPT =================--

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

-- // Vars
local POWER_MULTIPLIER = 1.35
local boostedBalls = {}

local GetCupLocation = ReplicatedStorage:WaitForChild("Functions"):WaitForChild("GetCupLocationFunction")
local TargetCupPos = nil

local GreenAssistEnabled = false
local AutoAceEnabled = false

-- Keybinds
local MenuKey = Enum.KeyCode.LeftControl
local GreenKey = Enum.KeyCode.G
local AceKey = Enum.KeyCode.H

local bindingMenu = false
local bindingGreen = false
local bindingAce = false

--================ UI =================--

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GolfUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- DOT
local DotGui = Instance.new("ScreenGui")
DotGui.Name = "GolfDotUI"
DotGui.Parent = PlayerGui
DotGui.ResetOnSpawn = false
DotGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
DotGui.IgnoreGuiInset = true

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.new(0,6,0,6)
StatusDot.Position = UDim2.new(0,6,0,6)
StatusDot.BackgroundColor3 = Color3.fromRGB(120,0,0)
StatusDot.BorderSizePixel = 0
StatusDot.ZIndex = 999
StatusDot.Parent = DotGui
Instance.new("UICorner", StatusDot).CornerRadius = UDim.new(1,0)

local function UpdateDot()
	if GreenAssistEnabled then
		StatusDot.BackgroundColor3 = Color3.fromRGB(0,200,100)
	else
		StatusDot.BackgroundColor3 = Color3.fromRGB(120,0,0)
	end
end

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 240, 0, 300)
Frame.Position = UDim2.new(0, 20, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
Frame.Parent = ScreenGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", Frame).Color = Color3.fromRGB(60,60,60)

local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1,0,0,30)
TitleBar.BackgroundTransparency = 1
TitleBar.Text = "⛳ Golf Assist"
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 16
TitleBar.TextColor3 = Color3.new(1,1,1)
TitleBar.Parent = Frame

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1,0,0,14)
Credit.Position = UDim2.new(0,0,0,28)
Credit.BackgroundTransparency = 1
Credit.Text = "made by R10TSypher"
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 14
Credit.TextColor3 = Color3.fromRGB(140,140,140)
Credit.Parent = Frame

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1,0,0,20)
Label.Position = UDim2.new(0,0,0,50)
Label.BackgroundTransparency = 1
Label.Font = Enum.Font.Gotham
Label.TextSize = 14
Label.TextColor3 = Color3.fromRGB(200,200,200)
Label.Text = "Power: " .. POWER_MULTIPLIER
Label.Parent = Frame

local DistanceLabel = Instance.new("TextLabel")
DistanceLabel.Size = UDim2.new(1,0,0,20)
DistanceLabel.Position = UDim2.new(0,0,0,70)
DistanceLabel.BackgroundTransparency = 1
DistanceLabel.Font = Enum.Font.Gotham
DistanceLabel.TextSize = 14
DistanceLabel.TextColor3 = Color3.fromRGB(200,200,200)
DistanceLabel.Text = "Distance: ..."
DistanceLabel.Parent = Frame

-- Slider
local Slider = Instance.new("Frame")
Slider.Size = UDim2.new(0.85,0,0,12)
Slider.Position = UDim2.new(0.075,0,0,95)
Slider.BackgroundColor3 = Color3.fromRGB(40,40,40)
Slider.Parent = Frame
Instance.new("UICorner", Slider).CornerRadius = UDim.new(1,0)

local Fill = Instance.new("Frame")
Fill.Size = UDim2.new(0.35,0,1,0)
Fill.BackgroundColor3 = Color3.fromRGB(0,200,255)
Fill.Parent = Slider
Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)

local Knob = Instance.new("TextButton")
Knob.Size = UDim2.new(0,16,0,16)
Knob.Position = UDim2.new(0.35,-8,0.5,-8)
Knob.BackgroundColor3 = Color3.new(1,1,1)
Knob.Text = ""
Knob.Parent = Slider
Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0)

-- Buttons
local function createButton(text, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.85,0,0,35)
	btn.Position = UDim2.new(0.075,0,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.Text = text
	btn.Parent = Frame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
	return btn
end

local GreenButton = createButton("Green Assist: OFF", 120)
local AceButton = createButton("Auto Ace: OFF", 160)

-- Bind buttons
local function createBind(text, y)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.85,0,0,28)
	btn.Position = UDim2.new(0.075,0,0,y)
	btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 13
	btn.Text = text
	btn.Parent = Frame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
	return btn
end

local MenuBindBtn = createBind("Menu Key: CTRL", 200)
local GreenBindBtn = createBind("Green Key: G", 232)
local AceBindBtn = createBind("Auto Ace Key: H", 264)

-- DRAG
local dragging = false
local dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset + delta.X,startPos.Y.Scale,startPos.Y.Offset + delta.Y)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- BUTTON LOGIC
GreenButton.MouseButton1Click:Connect(function()
	GreenAssistEnabled = not GreenAssistEnabled
	GreenButton.Text = "Green Assist: " .. (GreenAssistEnabled and "ON" or "OFF")
	GreenButton.BackgroundColor3 = GreenAssistEnabled and Color3.fromRGB(0,170,100) or Color3.fromRGB(30,30,30)
	UpdateDot()
end)

AceButton.MouseButton1Click:Connect(function()
	AutoAceEnabled = not AutoAceEnabled
	AceButton.Text = "Auto Ace: " .. (AutoAceEnabled and "ON" or "OFF")
	AceButton.BackgroundColor3 = AutoAceEnabled and Color3.fromRGB(200,120,0) or Color3.fromRGB(30,30,30)
end)

-- KEYBINDS
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end

	if input.KeyCode == MenuKey then
		ScreenGui.Enabled = not ScreenGui.Enabled
	end

	if input.KeyCode == GreenKey then
		GreenAssistEnabled = not GreenAssistEnabled
		GreenButton.Text = "Green Assist: " .. (GreenAssistEnabled and "ON" or "OFF")
		GreenButton.BackgroundColor3 = GreenAssistEnabled and Color3.fromRGB(0,170,100) or Color3.fromRGB(30,30,30)
		UpdateDot()
	end

	if input.KeyCode == AceKey then
		AutoAceEnabled = not AutoAceEnabled
		AceButton.Text = "Auto Ace: " .. (AutoAceEnabled and "ON" or "OFF")
		AceButton.BackgroundColor3 = AutoAceEnabled and Color3.fromRGB(200,120,0) or Color3.fromRGB(30,30,30)
	end
end)

UpdateDot()

--================ HOOK (UNCHANGED) =================--

local OldNewIndex
OldNewIndex = hookmetamethod(game, "__newindex", function(self, index, value)
	if not checkcaller()
	and (index == "AssemblyLinearVelocity" or index == "Velocity")
	and self:IsA("BasePart")
	and self.Name:lower():find("ball") then

		local speed = value.Magnitude

		if speed > 5 and not boostedBalls[self] then
			boostedBalls[self] = true
			value = value * POWER_MULTIPLIER
		end

		if speed < 2 then
			boostedBalls[self] = nil
		end
	end

	return OldNewIndex(self, index, value)
end)
