local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local remotes = ReplicatedStorage:WaitForChild("RaiseABeastRemotes")
local feedbackRemote = remotes:WaitForChild("CaptureFeedback")
local feedRequest = remotes:WaitForChild("FeedRequest")
local fusionRequest = remotes:WaitForChild("FusionRequest")
local carryRequest = remotes:WaitForChild("CarryRequest")
local inventory = player:WaitForChild("RaiseABeastInventory")
local CreatureModels = require(ReplicatedStorage.Shared.CreatureModels)

local function findJoint(character: Model, names: {string}): Instance?
	for _, descendant in ipairs(character:GetDescendants()) do
		if descendant:IsA("Motor6D") or descendant:IsA("AnimationConstraint") then
			for _, name in ipairs(names) do
				if descendant.Name == name then
					return descendant :: Instance
				end
			end
		end
	end
	return nil
end

local function applyCarryPose(character: Model, carrying: boolean)
	local rightShoulder = findJoint(character, { "RightShoulder", "Right Shoulder" })
	local leftShoulder = findJoint(character, { "LeftShoulder", "Left Shoulder" })
	local rightElbow = findJoint(character, { "RightElbow" })
	local leftElbow = findJoint(character, { "LeftElbow" })
	local shoulderPose = if carrying then CFrame.Angles(math.rad(-68), 0, 0) else CFrame.identity
	local elbowPose = if carrying then CFrame.Angles(math.rad(-18), 0, 0) else CFrame.identity
	if rightShoulder then
		(rightShoulder :: any).Transform = shoulderPose
	end
	if leftShoulder then
		(leftShoulder :: any).Transform = shoulderPose
	end
	if rightElbow then
		(rightElbow :: any).Transform = elbowPose
	end
	if leftElbow then
		(leftElbow :: any).Transform = elbowPose
	end
end

local carryPoseActive = false
local function refreshCarryPose()
	local character = player.Character
	local carrying = player:GetAttribute("CarryingCreature") == true
	if character and (carrying or carryPoseActive) then
		applyCarryPose(character, carrying)
	end
	carryPoseActive = carrying
end

player:GetAttributeChangedSignal("CarryingCreature"):Connect(refreshCarryPose)
player.CharacterAdded:Connect(function()
		task.defer(refreshCarryPose)
end)
RunService.RenderStepped:Connect(refreshCarryPose)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
		carryRequest:FireServer()
	end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "RaiseABeastHUD"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local message = Instance.new("TextLabel")
message.Name = "ObjectiveMessage"
message.AnchorPoint = Vector2.new(0.5, 0)
message.Position = UDim2.fromScale(0.5, 0.06)
message.Size = UDim2.new(0.82, 0, 0, 58)
message.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
message.BackgroundTransparency = 0.12
message.TextColor3 = Color3.fromRGB(255, 255, 255)
message.Font = Enum.Font.GothamBold
message.TextSize = 22
message.TextWrapped = true
message.Text = "Find the green Mystery Habitat and press E."
message.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = message

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(62, 214, 165)
stroke.Thickness = 2
stroke.Parent = message

local discoveryPreview = Instance.new("ViewportFrame")
discoveryPreview.Name = "DiscoveryPreview"
discoveryPreview.AnchorPoint = Vector2.new(1, 0)
discoveryPreview.Position = UDim2.fromScale(0.97, 0.04)
discoveryPreview.Size = UDim2.fromOffset(180, 180)
discoveryPreview.BackgroundColor3 = Color3.fromRGB(30, 20, 55)
discoveryPreview.Visible = false
discoveryPreview.Parent = gui

local previewLabel = Instance.new("TextLabel")
previewLabel.Name = "Title"
previewLabel.Size = UDim2.new(1, 0, 0, 28)
previewLabel.BackgroundTransparency = 1
previewLabel.TextColor3 = Color3.fromRGB(255, 244, 126)
previewLabel.Font = Enum.Font.GothamBold
previewLabel.TextSize = 16
previewLabel.Text = "New Discovery"
previewLabel.Parent = discoveryPreview

local previewCamera = Instance.new("Camera")
previewCamera.Parent = discoveryPreview
discoveryPreview.CurrentCamera = previewCamera

local function showDiscovery(creatureId: string)
	for _, child in ipairs(discoveryPreview:GetChildren()) do
		if child:IsA("WorldModel") then
			child:Destroy()
		end
	end

	local worldModel = Instance.new("WorldModel")
	worldModel.Parent = discoveryPreview
	local model = CreatureModels.Build(creatureId, CFrame.new(0, -1, 0), false)
	model.Parent = worldModel
	previewCamera.CFrame = CFrame.lookAt(Vector3.new(0, 2.5, 7), Vector3.new(0, 1.2, 0))
	discoveryPreview.Visible = true
	task.delay(8, function()
		if discoveryPreview.Visible then
			discoveryPreview.Visible = false
		end
	end)
end

local inventoryPanel = Instance.new("Frame")
inventoryPanel.Name = "InventoryPanel"
inventoryPanel.AnchorPoint = Vector2.new(0, 1)
inventoryPanel.Position = UDim2.fromScale(0.03, 0.96)
inventoryPanel.Size = UDim2.fromOffset(340, 280)
inventoryPanel.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
inventoryPanel.BackgroundTransparency = 0.08
inventoryPanel.Parent = gui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 12)
panelCorner.Parent = inventoryPanel

local panelTitle = Instance.new("TextLabel")
panelTitle.Name = "Title"
panelTitle.Size = UDim2.new(1, -20, 0, 34)
panelTitle.Position = UDim2.fromOffset(10, 8)
panelTitle.BackgroundTransparency = 1
panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
panelTitle.Font = Enum.Font.GothamBold
panelTitle.TextSize = 18
panelTitle.TextXAlignment = Enum.TextXAlignment.Left
panelTitle.Text = "Your Beasts"
panelTitle.Parent = inventoryPanel

local foodLabel = Instance.new("TextLabel")
foodLabel.Name = "Food"
foodLabel.Size = UDim2.new(1, -20, 0, 24)
foodLabel.Position = UDim2.fromOffset(10, 72)
foodLabel.BackgroundTransparency = 1
foodLabel.TextColor3 = Color3.fromRGB(255, 220, 100)
foodLabel.Font = Enum.Font.Gotham
foodLabel.TextSize = 16
foodLabel.TextXAlignment = Enum.TextXAlignment.Left
foodLabel.Parent = inventoryPanel

local inventoryTab = Instance.new("TextButton")
inventoryTab.Name = "InventoryTab"
inventoryTab.Size = UDim2.fromOffset(150, 28)
inventoryTab.Position = UDim2.fromOffset(10, 40)
inventoryTab.BackgroundColor3 = Color3.fromRGB(62, 214, 165)
inventoryTab.TextColor3 = Color3.fromRGB(20, 30, 35)
inventoryTab.Font = Enum.Font.GothamBold
inventoryTab.TextSize = 14
inventoryTab.Text = "Inventory"
inventoryTab.Parent = inventoryPanel

local albumTab = Instance.new("TextButton")
albumTab.Name = "AlbumTab"
albumTab.Size = UDim2.fromOffset(150, 28)
albumTab.Position = UDim2.fromOffset(180, 40)
albumTab.BackgroundColor3 = Color3.fromRGB(55, 68, 90)
albumTab.TextColor3 = Color3.fromRGB(255, 255, 255)
albumTab.Font = Enum.Font.GothamBold
albumTab.TextSize = 14
albumTab.Text = "Album"
albumTab.Parent = inventoryPanel

local list = Instance.new("ScrollingFrame")
list.Name = "BeastList"
list.Position = UDim2.fromOffset(10, 108)
list.Size = UDim2.new(1, -20, 1, -118)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 4
list.Parent = inventoryPanel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = list

local albumList = Instance.new("ScrollingFrame")
albumList.Name = "AlbumList"
albumList.Position = UDim2.fromOffset(10, 108)
albumList.Size = UDim2.new(1, -20, 1, -118)
albumList.BackgroundTransparency = 1
albumList.BorderSizePixel = 0
albumList.ScrollBarThickness = 4
albumList.Visible = false
albumList.Parent = inventoryPanel

local albumLayout = Instance.new("UIListLayout")
albumLayout.Padding = UDim.new(0, 6)
albumLayout.Parent = albumList

local fuseButton = Instance.new("TextButton")
fuseButton.Name = "FuseMatureTrio"
fuseButton.Size = UDim2.new(1, -20, 0, 34)
fuseButton.Position = UDim2.fromOffset(10, 0)
fuseButton.BackgroundColor3 = Color3.fromRGB(180, 100, 230)
fuseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
fuseButton.Font = Enum.Font.GothamBold
fuseButton.TextSize = 15
fuseButton.Text = "Fuse 3 mature beasts"
fuseButton.Visible = false
fuseButton.Parent = inventoryPanel

local confirmModal = Instance.new("Frame")
confirmModal.Name = "FusionConfirmation"
confirmModal.AnchorPoint = Vector2.new(0.5, 0.5)
confirmModal.Position = UDim2.fromScale(0.5, 0.5)
confirmModal.Size = UDim2.fromOffset(420, 190)
confirmModal.BackgroundColor3 = Color3.fromRGB(30, 24, 48)
confirmModal.Visible = false
confirmModal.ZIndex = 10
confirmModal.Parent = gui

-- Keep the core HUD readable on narrow screens while preserving the desktop layout.
-- UIScale also scales the modal's buttons together with the panel, avoiding overlap
-- when the viewport is smaller than the desktop authoring size.
local responsiveScale = math.clamp((Workspace.CurrentCamera and Workspace.CurrentCamera.ViewportSize.X or 1280) / 900, 0.75, 1)
local inventoryScale = Instance.new("UIScale")
inventoryScale.Scale = responsiveScale
inventoryScale.Parent = inventoryPanel

local modalScale = Instance.new("UIScale")
modalScale.Scale = responsiveScale
modalScale.Parent = confirmModal

local function refreshResponsiveHud()
	local camera = Workspace.CurrentCamera
	local viewportWidth = camera and camera.ViewportSize.X or 1280
	local scale = math.clamp(viewportWidth / 900, 0.75, 1)
	responsiveScale = scale
	inventoryScale.Scale = scale
	modalScale.Scale = scale
end

local function bindResponsiveCamera(camera: Camera?)
	if camera then
		camera:GetPropertyChangedSignal("ViewportSize"):Connect(refreshResponsiveHud)
	end
	refreshResponsiveHud()
end

Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	bindResponsiveCamera(Workspace.CurrentCamera)
end)
bindResponsiveCamera(Workspace.CurrentCamera)

local modalCorner = Instance.new("UICorner")
modalCorner.CornerRadius = UDim.new(0, 14)
modalCorner.Parent = confirmModal

local modalTitle = Instance.new("TextLabel")
modalTitle.Name = "Title"
modalTitle.Size = UDim2.new(1, -32, 0, 34)
modalTitle.Position = UDim2.fromOffset(16, 14)
modalTitle.BackgroundTransparency = 1
modalTitle.TextColor3 = Color3.fromRGB(255, 244, 126)
modalTitle.Font = Enum.Font.GothamBold
modalTitle.TextSize = 22
modalTitle.Text = "Confirm fusion"
modalTitle.ZIndex = 11
modalTitle.Parent = confirmModal

local modalMessage = Instance.new("TextLabel")
modalMessage.Name = "Message"
modalMessage.Size = UDim2.new(1, -32, 0, 54)
modalMessage.Position = UDim2.fromOffset(16, 52)
modalMessage.BackgroundTransparency = 1
modalMessage.TextColor3 = Color3.fromRGB(255, 255, 255)
modalMessage.Font = Enum.Font.Gotham
modalMessage.TextSize = 17
modalMessage.TextWrapped = true
modalMessage.Text = "Consume 3 mature beasts to discover PrismBloom?"
modalMessage.ZIndex = 11
modalMessage.Parent = confirmModal

local cancelButton = Instance.new("TextButton")
cancelButton.Name = "Cancel"
cancelButton.Size = UDim2.fromOffset(170, 42)
cancelButton.Position = UDim2.fromOffset(28, 126)
cancelButton.BackgroundColor3 = Color3.fromRGB(70, 78, 100)
cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
cancelButton.Font = Enum.Font.GothamBold
cancelButton.TextSize = 16
cancelButton.Text = "Cancel"
cancelButton.ZIndex = 11
cancelButton.Parent = confirmModal

local confirmButton = Instance.new("TextButton")
confirmButton.Name = "Confirm"
confirmButton.Size = UDim2.fromOffset(170, 42)
confirmButton.Position = UDim2.fromOffset(222, 126)
confirmButton.BackgroundColor3 = Color3.fromRGB(180, 100, 230)
confirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmButton.Font = Enum.Font.GothamBold
confirmButton.TextSize = 16
confirmButton.Text = "Fuse"
confirmButton.ZIndex = 11
confirmButton.Parent = confirmModal

local function showMessage(text: string)
	message.Text = text
	message.Visible = true
	task.delay(6, function()
		if message.Text == text then
			message.Visible = false
		end
	end)
end

local function showAssignedPlot()
	local plotName = player:GetAttribute("PlotName")
	if type(plotName) == "string" then
		showMessage(string.format("Your base is %s. Bring carried beasts here to place them.", plotName))
	end
end

player:GetAttributeChangedSignal("PlotName"):Connect(showAssignedPlot)
task.defer(showAssignedPlot)

local function refreshInventory()
	foodLabel.Text = string.format("Food: %d", inventory:FindFirstChild("Food") and inventory.Food.Value or 0)
	for _, child in ipairs(list:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	local matureNames = {}
	for _, item in ipairs(inventory:GetChildren()) do
		if item:IsA("StringValue") then
			local growth = item:GetAttribute("Growth") or 0
			local maxGrowth = item:GetAttribute("MaxGrowth") or 3
			local button = Instance.new("TextButton")
			button.Name = item.Name
			button.Size = UDim2.new(1, -4, 0, 34)
			button.BackgroundColor3 = Color3.fromRGB(55, 68, 90)
			button.TextColor3 = Color3.fromRGB(255, 255, 255)
			button.Font = Enum.Font.GothamSemibold
			button.TextSize = 15
			button.Text = string.format("Feed %s  [%d/%d]", item.Value, growth, maxGrowth)
			button.Parent = list
			button.Activated:Connect(function()
				feedRequest:FireServer(item.Name)
			end)
			if item:GetAttribute("Mature") == true then
				table.insert(matureNames, item.Name)
			end
		end
	end
	fuseButton.Visible = #matureNames >= 3
end

local function refreshAlbum()
	for _, child in ipairs(albumList:GetChildren()) do
		if child:IsA("TextLabel") then
			child:Destroy()
		end
	end

	local album = inventory:FindFirstChild("Album")
	local discoveries = {}
	if album then
		for _, entry in ipairs(album:GetChildren()) do
			if entry:IsA("StringValue") then
				table.insert(discoveries, entry)
			end
		end
	end
	table.sort(discoveries, function(a, b)
		return a.Name < b.Name
	end)

	if #discoveries == 0 then
		local empty = Instance.new("TextLabel")
		empty.Name = "EmptyAlbum"
		empty.Size = UDim2.new(1, -4, 0, 42)
		empty.BackgroundTransparency = 1
		empty.TextColor3 = Color3.fromRGB(190, 205, 225)
		empty.Font = Enum.Font.Gotham
		empty.TextSize = 15
		empty.TextWrapped = true
		empty.Text = "Discover creatures to fill your album."
		empty.Parent = albumList
		return
	end

	for _, entry in ipairs(discoveries) do
		local row = Instance.new("TextLabel")
		row.Name = entry.Name
		row.Size = UDim2.new(1, -4, 0, 38)
		row.BackgroundColor3 = Color3.fromRGB(55, 68, 90)
		row.TextColor3 = Color3.fromRGB(255, 244, 126)
		row.Font = Enum.Font.GothamSemibold
		row.TextSize = 15
		row.TextXAlignment = Enum.TextXAlignment.Left
		row.Text = string.format("  %s  •  %s", entry.Name, entry.Value)
		row.Parent = albumList
	end
end

local function setInventoryTab(active: boolean)
	list.Visible = active
	albumList.Visible = not active
	foodLabel.Visible = active
	panelTitle.Text = if active then "Your Beasts" else "Creature Album"
	if not active then
		fuseButton.Visible = false
	else
		refreshInventory()
	end
	inventoryTab.BackgroundColor3 = if active then Color3.fromRGB(62, 214, 165) else Color3.fromRGB(55, 68, 90)
	albumTab.BackgroundColor3 = if active then Color3.fromRGB(55, 68, 90) else Color3.fromRGB(62, 214, 165)
	refreshAlbum()
end

inventoryTab.Activated:Connect(function()
	setInventoryTab(true)
end)

albumTab.Activated:Connect(function()
	setInventoryTab(false)
end)

local function connectInventorySignals()
	local food = inventory:WaitForChild("Food")
	food.Changed:Connect(refreshInventory)
	inventory.ChildAdded:Connect(function(child)
		if child:IsA("StringValue") then
			child.AttributeChanged:Connect(refreshInventory)
		end
		refreshInventory()
	end)
	inventory.ChildRemoved:Connect(refreshInventory)
	inventory.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("StringValue") then
			refreshInventory()
			refreshAlbum()
		end
	end)
	inventory.DescendantRemoving:Connect(function(descendant)
		if descendant:IsA("StringValue") then
			refreshInventory()
			refreshAlbum()
		end
	end)
	for _, child in ipairs(inventory:GetChildren()) do
		if child:IsA("StringValue") then
			child.AttributeChanged:Connect(refreshInventory)
		end
	end
	refreshInventory()
	refreshAlbum()
end

connectInventorySignals()

fuseButton.Activated:Connect(function()
	confirmModal.Visible = true
end)

cancelButton.Activated:Connect(function()
	confirmModal.Visible = false
end)

confirmButton.Activated:Connect(function()
	local matureNames = {}
	for _, item in ipairs(inventory:GetChildren()) do
		if item:IsA("StringValue") and item:GetAttribute("Mature") == true then
			table.insert(matureNames, item.Name)
		end
	end
	confirmModal.Visible = false
	if #matureNames >= 3 then
		fusionRequest:FireServer({matureNames[1], matureNames[2], matureNames[3]}, true)
	end
end)

feedbackRemote.OnClientEvent:Connect(function(kind: string, value: string, count: number, foodLeft: number)
	if kind == "Welcome" then
		showMessage(value)
	elseif kind == "Captured" then
		showMessage(string.format("Captured %s! Beasts collected: %d/3", value, count))
	elseif kind == "Fed" then
		showMessage(string.format("Fed %s! Growth: %d/3. Food left: %d", value, count, foodLeft))
	elseif kind == "FeedDenied" then
		showMessage(value)
	elseif kind == "FusionDenied" then
		showMessage(value)
	elseif kind == "Fused" then
		showMessage(string.format("Fusion complete! You discovered %s. Total fusions: %d", value, count))
		showDiscovery(value)
	elseif kind == "Complete" then
		showMessage("All starter beasts captured. Your next step is to feed and fuse them.")
	elseif kind == "Conveyor" then
		showMessage(string.format("A wild %s is passing on the conveyor. Get close and press E to carry it.", value))
	elseif kind == "Carrying" then
		showMessage(string.format("Carrying %s. Take it to your base to place it.", value))
	elseif kind == "Delivered" then
		showMessage(string.format("%s placed on platform %d in your base.", value, count))
	elseif kind == "TransportDenied" then
		showMessage(value)
	end
end)
