
-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

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

-- 🔴 STATUS DOT (SEPARATE GUI - ALWAYS VISIBLE)

local DotGui = Instance.new("ScreenGui")
DotGui.Name = "GolfDotUI"
DotGui.Parent = PlayerGui
DotGui.ResetOnSpawn = false
DotGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
DotGui.IgnoreGuiInset = true

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.new(0,6,0,6) -- SMALLER
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

-- Title
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
Credit.TextTransparency = 0.2
Credit.Parent = Frame

-- Power Label
local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1,0,0,20)
Label.Position = UDim2.new(0,0,0,50)
Label.BackgroundTransparency = 1
Label.Font = Enum.Font.Gotham
Label.TextSize = 14
Label.TextColor3 = Color3.fromRGB(200,200,200)
Label.Text = "Power: " .. POWER_MULTIPLIER
Label.Parent = Frame

-- Distance Label
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

--================ DRAG =================--

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
		Frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

--================ BUTTON LOGIC =================--

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

-- Bind UI
MenuBindBtn.MouseButton1Click:Connect(function()
	bindingMenu = true
	MenuBindBtn.Text = "Press key..."
end)

GreenBindBtn.MouseButton1Click:Connect(function()
	bindingGreen = true
	GreenBindBtn.Text = "Press key..."
end)

AceBindBtn.MouseButton1Click:Connect(function()
	bindingAce = true
	AceBindBtn.Text = "Press key..."
end)

-- Slider
local sliding = false
Knob.MouseButton1Down:Connect(function() sliding = true end)

UIS.InputChanged:Connect(function(input)
	if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
		local relative = (input.Position.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X
		relative = math.clamp(relative, 0, 1)

		Fill.Size = UDim2.new(relative,0,1,0)
		Knob.Position = UDim2.new(relative,-8,0.5,-8)

		POWER_MULTIPLIER = math.floor((1 + relative * 2) * 100) / 100
		Label.Text = "Power: " .. POWER_MULTIPLIER
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		sliding = false
	end
end)

--================ KEYBINDS =================--

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end

	if bindingMenu then
		MenuKey = input.KeyCode
		MenuBindBtn.Text = "Menu Key: " .. input.KeyCode.Name
		bindingMenu = false
		return
	end

	if bindingGreen then
		GreenKey = input.KeyCode
		GreenBindBtn.Text = "Green Key: " .. input.KeyCode.Name
		bindingGreen = false
		return
	end

	if bindingAce then
		AceKey = input.KeyCode
		AceBindBtn.Text = "Auto Ace Key: " .. input.KeyCode.Name
		bindingAce = false
		return
	end

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

--================ COURSE + DISTANCE =================--

local function GetCourseModel()
	for _, v in pairs(workspace:GetChildren()) do
		if v:IsA("Model") and v.Name:lower():find("course") then
			return v
		end
	end
end

task.spawn(function()
	while true do
		local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
		if leaderstats and leaderstats:FindFirstChild("Hole") then
			local hole = string.format("%03d", leaderstats.Hole.Value)
			local course = GetCourseModel()

			local success, pos = pcall(function()
				return GetCupLocation:InvokeServer(hole, course and course.Name or nil)
			end)

			if success and typeof(pos) == "Vector3" then
				TargetCupPos = pos
			end
		end
		task.wait(0.75)
	end
end)

task.spawn(function()
	while true do
		local char = LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") and TargetCupPos then
			local yards = (TargetCupPos - char.HumanoidRootPart.Position).Magnitude / 3
			DistanceLabel.Text = "Distance: " .. math.floor(yards) .. " yards"
		else
			DistanceLabel.Text = "Distance: ..."
		end
		task.wait(0.2)
	end
end)

--================ HOOK =================--

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

		if GreenAssistEnabled and TargetCupPos then
			local toHole = TargetCupPos - self.Position
			local dist = toHole.Magnitude

			if speed > 0.05 then
				local dir = value.Unit
				local holeDir = toHole.Unit
				local align = dir:Dot(holeDir)

				if align < 0.75 then
					if dist < 12 then value *= 0.6 end
					if dist < 6 then value *= 0.3 end
					if dist < 3 then value = Vector3.zero end
				else
					local strength = math.clamp(0.15 + (1-align) + (dist/200), 0.15, 0.4)
					value = dir:Lerp(holeDir, strength) * speed
				end
			end
		end

		if AutoAceEnabled and TargetCupPos then
			local delta = TargetCupPos - self.Position
			local dist = Vector3.new(delta.X,0,delta.Z).Magnitude

			if dist > 0.5 then
				local t = math.clamp(dist/30, 0.4, 1.2)
				local g = 35.037

				return OldNewIndex(self, index, Vector3.new(
					delta.X/t,
					(delta.Y + 0.5*g*t*t)/t,
					delta.Z/t
				))
			end
		end
	end

	return OldNewIndex(self, index, value)
end)
