local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local CaptureConfig = require(ReplicatedStorage.Shared.CaptureConfig)
local FusionConfig = require(ReplicatedStorage.Shared.FusionConfig)
local DataService = require(script.Parent.DataService)

local cooldownByUserId: {[number]: number} = {}
local feedCooldownByUserId: {[number]: number} = {}
local fusionCooldownByUserId: {[number]: number} = {}

local function getOrCreateRemote(): RemoteEvent
	local remotes = ReplicatedStorage:FindFirstChild(CaptureConfig.RemoteFolderName)
	if not remotes then
		remotes = Instance.new("Folder")
		remotes.Name = CaptureConfig.RemoteFolderName
		remotes.Parent = ReplicatedStorage
	end

	local feedback = remotes:FindFirstChild(CaptureConfig.FeedbackRemoteName)
	if not feedback then
		feedback = Instance.new("RemoteEvent")
		feedback.Name = CaptureConfig.FeedbackRemoteName
		feedback.Parent = remotes
	end

	return feedback :: RemoteEvent
end

local feedbackRemote = getOrCreateRemote()

local function getOrCreateFeedRequest(): RemoteEvent
	local remotes = ReplicatedStorage:WaitForChild(CaptureConfig.RemoteFolderName)
	local request = remotes:FindFirstChild("FeedRequest")
	if not request then
		request = Instance.new("RemoteEvent")
		request.Name = "FeedRequest"
		request.Parent = remotes
	end
	return request :: RemoteEvent
end

local feedRequest = getOrCreateFeedRequest()

local function getOrCreateFusionRequest(): RemoteEvent
	local remotes = ReplicatedStorage:WaitForChild(CaptureConfig.RemoteFolderName)
	local request = remotes:FindFirstChild(FusionConfig.RemoteName)
	if not request then
		request = Instance.new("RemoteEvent")
		request.Name = FusionConfig.RemoteName
		request.Parent = remotes
	end
	return request :: RemoteEvent
end

local fusionRequest = getOrCreateFusionRequest()

local function getInventory(player: Player): (Folder, IntValue)
	local inventory = player:FindFirstChild("RaiseABeastInventory")
	if not inventory then
		inventory = Instance.new("Folder")
		inventory.Name = "RaiseABeastInventory"
		inventory.Parent = player
	end

	local captureCount = inventory:FindFirstChild("CaptureCount")
	if not captureCount then
		captureCount = Instance.new("IntValue")
		captureCount.Name = "CaptureCount"
		captureCount.Value = 0
		captureCount.Parent = inventory
	end

	local food = inventory:FindFirstChild("Food")
	if not food then
		food = Instance.new("IntValue")
		food.Name = "Food"
		food.Value = 9
		food.Parent = inventory
	end

	return inventory :: Folder, captureCount :: IntValue
end

local function hasCreature(inventory: Folder, creatureId: string): boolean
	for _, item in ipairs(inventory:GetChildren()) do
		if item:IsA("StringValue") and item.Value == creatureId then
			return true
		end
	end
	return false
end

local function discover(inventory: Folder, creatureId: string, rarity: string)
	local album = inventory:FindFirstChild("Album")
	if not album then
		album = Instance.new("Folder")
		album.Name = "Album"
		album.Parent = inventory
	end
	if not album:FindFirstChild(creatureId) then
		local entry = Instance.new("StringValue")
		entry.Name = creatureId
		entry.Value = rarity
		entry:SetAttribute("Discovered", true)
		entry.Parent = album
	end
end

local function createCreature(inventory: Folder, captureCount: IntValue, design): StringValue
	local creature = Instance.new("StringValue")
	creature.Name = string.format("Creature_%03d", captureCount.Value + 1)
	creature.Value = design.id
	creature:SetAttribute("CreatureId", design.id)
	creature:SetAttribute("Rarity", design.rarity)
	creature:SetAttribute("Protected", true)
	creature:SetAttribute("Growth", 0)
	creature:SetAttribute("MaxGrowth", 3)
	creature.Parent = inventory
	captureCount.Value += 1
	return creature
end

local function feed(player: Player, creatureName: unknown)
	if type(creatureName) ~= "string" then
		return
	end

	local now = os.clock()
	local lastFeed = feedCooldownByUserId[player.UserId] or 0
	if now - lastFeed < 0.75 then
		return
	end
	feedCooldownByUserId[player.UserId] = now

	local inventory = player:FindFirstChild("RaiseABeastInventory")
	local food = inventory and inventory:FindFirstChild("Food")
	local creature = inventory and inventory:FindFirstChild(creatureName)
	if not inventory or not food or not food:IsA("IntValue") or food.Value <= 0 then
		feedbackRemote:FireClient(player, "FeedDenied", "You need more food.", 0)
		return
	end
	if not creature or not creature:IsA("StringValue") then
		return
	end

	local growth = creature:GetAttribute("Growth")
	local maxGrowth = creature:GetAttribute("MaxGrowth")
	if type(growth) ~= "number" or type(maxGrowth) ~= "number" or growth >= maxGrowth then
		feedbackRemote:FireClient(player, "FeedDenied", "This beast is fully grown.", food.Value)
		return
	end

	food.Value -= 1
	growth += 1
	creature:SetAttribute("Growth", growth)
	creature:SetAttribute("Mature", growth >= maxGrowth)
	feedbackRemote:FireClient(player, "Fed", creature.Value, growth, food.Value)
end

local function sortedKey(ids: {string}): string
	local copy = table.clone(ids)
	table.sort(copy)
	return table.concat(copy, "|")
end

local function fusion(player: Player, requestedNames: unknown, confirmed: unknown)
	if confirmed ~= true or type(requestedNames) ~= "table" then
		return
	end

	local now = os.clock()
	local lastFusion = fusionCooldownByUserId[player.UserId] or 0
	if now - lastFusion < FusionConfig.CooldownSeconds then
		return
	end
	fusionCooldownByUserId[player.UserId] = now

	local names: {string} = {}
	for index = 1, 3 do
		if type(requestedNames[index]) ~= "string" then
			return
		end
		names[index] = requestedNames[index]
	end
	if requestedNames[4] ~= nil or #names ~= 3 then
		return
	end

	local inventory = player:FindFirstChild("RaiseABeastInventory")
	if not inventory then
		return
	end

	local creatureIds = {}
	local selected = {}
	for _, name in ipairs(names) do
		if selected[name] then
			return
		end
		selected[name] = true
		local creature = inventory:FindFirstChild(name)
		if not creature or not creature:IsA("StringValue") or creature:GetAttribute("Mature") ~= true then
			feedbackRemote:FireClient(player, "FusionDenied", "All three selected beasts must be fully grown.", 0)
			return
		end
		table.insert(creatureIds, creature.Value)
	end

	if sortedKey(creatureIds) ~= sortedKey(FusionConfig.Recipe) then
		feedbackRemote:FireClient(player, "FusionDenied", "That combination is not a known recipe.", 0)
		return
	end

	for _, name in ipairs(names) do
		local creature = inventory:FindFirstChild(name)
		if creature then
			creature:Destroy()
		end
	end

	local fusionCount = inventory:FindFirstChild("FusionCount")
	if not fusionCount then
		fusionCount = Instance.new("IntValue")
		fusionCount.Name = "FusionCount"
		fusionCount.Parent = inventory
	end
	fusionCount.Value += 1

	local result = Instance.new("StringValue")
	result.Name = string.format("Creature_%03d", #inventory:GetChildren())
	result.Value = FusionConfig.Result.id
	result:SetAttribute("CreatureId", FusionConfig.Result.id)
	result:SetAttribute("Rarity", FusionConfig.Result.rarity)
	result:SetAttribute("Protected", true)
	result:SetAttribute("Growth", 0)
	result:SetAttribute("MaxGrowth", FusionConfig.Result.maxGrowth)
	result:SetAttribute("Mature", false)
	result:SetAttribute("Fused", true)
	result.Parent = inventory

	local album = inventory:FindFirstChild("Album")
	if not album then
		album = Instance.new("Folder")
		album.Name = "Album"
		album.Parent = inventory
	end
	if not album:FindFirstChild(FusionConfig.Result.id) then
		local entry = Instance.new("StringValue")
		entry.Name = FusionConfig.Result.id
		entry.Value = FusionConfig.Result.rarity
		entry:SetAttribute("Discovered", true)
		entry.Parent = album
	end

	feedbackRemote:FireClient(player, "Fused", FusionConfig.Result.id, fusionCount.Value)
end

local function isPlayerNearPad(player: Player, pad: BasePart): boolean
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	return root ~= nil and (root.Position - pad.Position).Magnitude <= CaptureConfig.MaxActivationDistance + 3
end

local function capture(player: Player, pad: BasePart)
	local now = os.clock()
	local lastCapture = cooldownByUserId[player.UserId] or 0
	if now - lastCapture < CaptureConfig.CooldownSeconds then
		return
	end
	cooldownByUserId[player.UserId] = now

	if not isPlayerNearPad(player, pad) then
		return
	end

	local inventory, captureCount = getInventory(player)
	for _, design in ipairs(CaptureConfig.StarterCreatures) do
		if not hasCreature(inventory, design.id) then
			createCreature(inventory, captureCount, design)
			discover(inventory, design.id, design.rarity)
			feedbackRemote:FireClient(player, "Captured", design.id, captureCount.Value)
			return
		end
	end

	feedbackRemote:FireClient(player, "Complete", "All starter beasts captured", captureCount.Value)
end

local function createCaptureZone(): ProximityPrompt
	local zone = Workspace:FindFirstChild(CaptureConfig.ZoneName)
	if zone then
		local existingPad = zone:FindFirstChild(CaptureConfig.PadName)
		local existingPrompt = existingPad and existingPad:FindFirstChildOfClass("ProximityPrompt")
		assert(existingPad and existingPad:IsA("BasePart") and existingPrompt, "Invalid capture zone")
		return existingPrompt
	end

	local folder = Instance.new("Folder")
	folder.Name = CaptureConfig.ZoneName
	folder:SetAttribute("Purpose", "MVP capture interaction")

	local pad = Instance.new("Part")
	pad.Name = CaptureConfig.PadName
	pad.Size = Vector3.new(8, 1, 8)
	pad.Position = Vector3.new(0, 0.5, 14)
	pad.Anchored = true
	pad.CanCollide = true
	pad.Color = Color3.fromRGB(62, 214, 165)
	pad.Material = Enum.Material.Neon
	pad.Parent = folder

	local prompt = Instance.new("ProximityPrompt")
	prompt.ActionText = "Capture"
	prompt.ObjectText = "Mystery Habitat"
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	prompt.HoldDuration = 0.4
	prompt.MaxActivationDistance = CaptureConfig.MaxActivationDistance
	prompt.RequiresLineOfSight = false
	prompt.Parent = pad

	folder.Parent = Workspace
	return prompt
end

local prompt = createCaptureZone()
local pad = prompt.Parent :: BasePart
prompt.Triggered:Connect(function(player: Player)
	capture(player, pad)
end)

Players.PlayerAdded:Connect(function(player)
	DataService.LoadPlayer(player)
	getInventory(player)
	feedbackRemote:FireClient(player, "Welcome", "Find the green Mystery Habitat and press E to capture your first beast", 0)
end)

Players.PlayerRemoving:Connect(function(player)
	DataService.SavePlayer(player)
	DataService.ForgetPlayer(player)
	cooldownByUserId[player.UserId] = nil
	feedCooldownByUserId[player.UserId] = nil
	fusionCooldownByUserId[player.UserId] = nil
end)

for _, player in ipairs(Players:GetPlayers()) do
	DataService.LoadPlayer(player)
	getInventory(player)
end

DataService.StartAutosave()

game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		DataService.SavePlayer(player)
	end
end)

feedRequest.OnServerEvent:Connect(feed)
fusionRequest.OnServerEvent:Connect(fusion)
