local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local CreatureModels = require(ReplicatedStorage.Shared.CreatureModels)

local plaza = Workspace:WaitForChild("RaiseABeastPlaza")
local plotsFolder = plaza:WaitForChild("Zone_Spawn"):WaitForChild("Plots")

local function getPlots(): {Folder}
	local plots = {}
	for _, item in ipairs(plotsFolder:GetChildren()) do
		if item:IsA("Folder") then
			table.insert(plots, item)
		end
	end
	table.sort(plots, function(a, b)
		return a.Name < b.Name
	end)
	return plots
end

local function getSlots(plot: Folder): {BasePart}
	local slots = {}
	local slotsFolder = plot:WaitForChild("DisplaySlots")
	for _, item in ipairs(slotsFolder:GetChildren()) do
		if item:IsA("BasePart") then
			table.insert(slots, item)
		end
	end
	table.sort(slots, function(a, b)
		return a.Name < b.Name
	end)
	return slots
end

local function getDisplayModels(plot: Folder): Folder
	local displayModels = plot:FindFirstChild("DisplayModels")
	if not displayModels then
		displayModels = Instance.new("Folder")
		displayModels.Name = "DisplayModels"
		displayModels.Parent = plot
	end
	return displayModels :: Folder
end

local function updateOwnerSign(plot: Folder, ownerName: string)
	local base = plot:FindFirstChild("Base")
	if not base or not base:IsA("BasePart") then
		return
	end

	local sign = base:FindFirstChild("OwnerSign")
	if not sign then
		local billboard = Instance.new("BillboardGui")
		billboard.Name = "OwnerSign"
		billboard.Adornee = base
		billboard.Size = UDim2.fromOffset(220, 54)
		billboard.StudsOffset = Vector3.new(0, 3.2, 0)
		billboard.AlwaysOnTop = true
		billboard.Parent = base

		local label = Instance.new("TextLabel")
		label.Name = "OwnerLabel"
		label.Size = UDim2.fromScale(1, 1)
		label.BackgroundColor3 = Color3.fromRGB(25, 30, 45)
		label.BackgroundTransparency = 0.12
		label.TextColor3 = Color3.fromRGB(255, 244, 126)
		label.Font = Enum.Font.GothamBold
		label.TextScaled = true
		label.TextStrokeTransparency = 0.35
		label.Parent = billboard
		sign = billboard
	end

	local label = sign:FindFirstChild("OwnerLabel")
	if label and label:IsA("TextLabel") then
		label.Text = if ownerName == "" then "Available Plot" else ownerName .. "'s Base"
		label.TextColor3 = if ownerName == "" then Color3.fromRGB(210, 220, 235) else Color3.fromRGB(255, 244, 126)
	end
end

local function refreshDisplay(inventory: Folder, plot: Folder)
	local displayModels = getDisplayModels(plot)
	for _, model in ipairs(displayModels:GetChildren()) do
		model:Destroy()
	end

	local slots = getSlots(plot)
	local usedSlots: {[number]: boolean} = {}
	local nextFallbackSlot = 1
	for _, item in ipairs(inventory:GetChildren()) do
		if item:IsA("StringValue") and item:GetAttribute("CreatureId") then
			local requestedSlot = item:GetAttribute("SlotIndex")
			local slotIndex = if type(requestedSlot) == "number" and slots[requestedSlot] and not usedSlots[requestedSlot]
				then requestedSlot
				else nil
			if not slotIndex then
				while usedSlots[nextFallbackSlot] and nextFallbackSlot <= #slots do
					nextFallbackSlot += 1
				end
				slotIndex = nextFallbackSlot
			end
			if slots[slotIndex] then
				usedSlots[slotIndex] = true
				local model = CreatureModels.Build(item.Value, slots[slotIndex].CFrame, false)
				model.Name = item.Name .. "_Display"
				model:SetAttribute("InventoryEntry", item.Name)
				model:SetAttribute("PlotName", plot.Name)
				model.Parent = displayModels
			end
		end
	end
end

local function assignPlot(player: Player): Folder?
	for _, plot in ipairs(getPlots()) do
		if plot:GetAttribute("Occupied") ~= true then
			plot:SetAttribute("Occupied", true)
			plot:SetAttribute("OwnerUserId", player.UserId)
			plot:SetAttribute("OwnerName", player.Name)
			updateOwnerSign(plot, player.Name)
			player:SetAttribute("PlotName", plot.Name)
			return plot
		end
	end
	warn("No available plot for player", player.Name)
	return nil
end

local function clearPlot(player: Player)
	local plotName = player:GetAttribute("PlotName")
	if type(plotName) ~= "string" then
		return
	end

	local plot = plotsFolder:FindFirstChild(plotName)
	if not plot or not plot:IsA("Folder") then
		return
	end

	local displayModels = plot:FindFirstChild("DisplayModels")
	if displayModels then
		for _, model in ipairs(displayModels:GetChildren()) do
			model:Destroy()
		end
	end
	plot:SetAttribute("Occupied", false)
	plot:SetAttribute("OwnerUserId", 0)
	plot:SetAttribute("OwnerName", "")
	updateOwnerSign(plot, "")
	player:SetAttribute("PlotName", nil)
end

local function bindPlayer(player: Player)
	local plot = assignPlot(player)
	if not plot then
		return
	end

	local inventory = player:WaitForChild("RaiseABeastInventory") :: Folder
	inventory.ChildAdded:Connect(function(child)
		if child:IsA("StringValue") then
			refreshDisplay(inventory, plot)
		end
	end)
	inventory.ChildRemoved:Connect(function(child)
		if child:IsA("StringValue") then
			refreshDisplay(inventory, plot)
		end
	end)
	refreshDisplay(inventory, plot)
end

Players.PlayerAdded:Connect(bindPlayer)
Players.PlayerRemoving:Connect(clearPlot)
for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(bindPlayer, player)
end
