local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local CreatureModels = require(ReplicatedStorage.Shared.CreatureModels)
local TransportConfig = require(ReplicatedStorage.Shared.TransportConfig)

local activeCreatures: {[Model]: number} = {}
local carrierByPlayer: {[Player]: Model} = {}
local carryCooldownByUserId: {[number]: number} = {}
local depositAttemptByUserId: {[number]: number} = {}
local promptConnections: {[Model]: RBXScriptConnection} = {}

local remotes = ReplicatedStorage:WaitForChild(TransportConfig.RemoteFolderName)
local feedbackRemote = remotes:WaitForChild(TransportConfig.FeedbackRemoteName) :: RemoteEvent
local carryRequest = remotes:FindFirstChild("CarryRequest")
if not carryRequest then
	carryRequest = Instance.new("RemoteEvent")
	carryRequest.Name = "CarryRequest"
	carryRequest.Parent = remotes
end
carryRequest = carryRequest :: RemoteEvent

local function getConveyorFolder(): Folder
	local plaza = Workspace:WaitForChild("RaiseABeastPlaza")
	local folder = plaza:FindFirstChild(TransportConfig.ConveyorFolderName)
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = TransportConfig.ConveyorFolderName
		folder.Parent = plaza
	end
	return folder :: Folder
end

local function getCreatureFolder(): Folder
	local conveyor = getConveyorFolder()
	local folder = conveyor:FindFirstChild(TransportConfig.CreatureFolderName)
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = TransportConfig.CreatureFolderName
		folder.Parent = conveyor
	end
	return folder :: Folder
end

local function getPlayerRoot(player: Player): BasePart?
	local character = player.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	return if root and root:IsA("BasePart") then root else nil
end

local function getCarryPart(character: Model): BasePart?
	for _, name in ipairs({ "HumanoidRootPart", "UpperTorso", "Torso" }) do
		local part = character:FindFirstChild(name)
		if part and part:IsA("BasePart") then
			return part
		end
	end
	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function disconnectPrompt(model: Model)
	local connection = promptConnections[model]
	if connection then
		connection:Disconnect()
		promptConnections[model] = nil
	end
	local root = model.PrimaryPart
	local prompt = root and root:FindFirstChildOfClass("ProximityPrompt")
	if prompt then
		prompt.Enabled = false
	end
end

local function clearActiveCreature(model: Model?)
	if model then
		activeCreatures[model] = nil
	end
end

local function prepareForCarry(model: Model, player: Player): boolean
	local character = player.Character
	local carryPart = character and getCarryPart(character)
	local root = model.PrimaryPart
	if not character or not carryPart or not root then
		return false
	end

	model:PivotTo(carryPart.CFrame * TransportConfig.CarryOffset)
	for _, descendant in ipairs(model:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Anchored = false
			descendant.CanCollide = false
			descendant.CanTouch = false
			descendant.CanQuery = false
			if descendant ~= root then
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = root
				weld.Part1 = descendant
				weld.Parent = root
			end
		end
	end

	local carrierWeld = Instance.new("WeldConstraint")
	carrierWeld.Name = "CarriedByPlayer"
	carrierWeld.Part0 = root
	carrierWeld.Part1 = carryPart
	carrierWeld.Parent = root
	model:SetAttribute("CarriedByUserId", player.UserId)
	model:SetAttribute("TransportState", "Carried")
	model.Parent = character
	return true
end

local function getPlayerInventory(player: Player): Folder?
	local inventory = player:FindFirstChild("RaiseABeastInventory")
	return if inventory and inventory:IsA("Folder") then inventory else nil
end

local function getPlayerPlot(player: Player): Folder?
	local plotName = player:GetAttribute("PlotName")
	if type(plotName) ~= "string" then
		return nil
	end
	local plaza = Workspace:FindFirstChild("RaiseABeastPlaza")
	local zone = plaza and plaza:FindFirstChild("Zone_Spawn")
	local plots = zone and zone:FindFirstChild("Plots")
	local plot = plots and plots:FindFirstChild(plotName)
	return if plot and plot:IsA("Folder") then plot else nil
end

local function getFreeSlotIndices(player: Player, plot: Folder): {number}
	local slotsFolder = plot:FindFirstChild("DisplaySlots")
	local used: {[number]: boolean} = {}
	local inventory = getPlayerInventory(player)
	if inventory then
		for _, item in ipairs(inventory:GetChildren()) do
			if item:IsA("StringValue") then
				local slotIndex = item:GetAttribute("SlotIndex")
				if type(slotIndex) == "number" then
					used[slotIndex] = true
				end
			end
		end
	end

	local free = {}
	if slotsFolder then
		local slots = slotsFolder:GetChildren()
		table.sort(slots, function(a, b)
			return a.Name < b.Name
		end)
		for index, slot in ipairs(slots) do
			if slot:IsA("BasePart") and not used[index] then
				table.insert(free, index)
			end
		end
	end
	return free
end

local function deposit(player: Player, model: Model)
	if carrierByPlayer[player] ~= model then
		return
	end

	local creatureId = model:GetAttribute("CreatureId")
	local plot = getPlayerPlot(player)
	local inventory = getPlayerInventory(player)
	if type(creatureId) ~= "string" or not plot or not inventory then
		return
	end

	local freeSlots = getFreeSlotIndices(player, plot)
	if #freeSlots == 0 then
		local now = os.clock()
		if now - (depositAttemptByUserId[player.UserId] or 0) > 1 then
			depositAttemptByUserId[player.UserId] = now
			feedbackRemote:FireClient(player, "TransportDenied", "Your base has no free platform.", 0)
		end
		return
	end

	local slotIndex = freeSlots[math.random(1, #freeSlots)]
	local countValue = inventory:FindFirstChild("CaptureCount")
	local nextIndex = if countValue and countValue:IsA("IntValue") then countValue.Value + 1 else #inventory:GetChildren() + 1
	local entry = Instance.new("StringValue")
	entry.Name = string.format("Creature_%03d", nextIndex)
	entry.Value = creatureId
	entry:SetAttribute("CreatureId", creatureId)
	entry:SetAttribute("Rarity", model:GetAttribute("Rarity") or "Common")
	entry:SetAttribute("Protected", true)
	entry:SetAttribute("Transported", true)
	entry:SetAttribute("Growth", 0)
	entry:SetAttribute("MaxGrowth", 3)
	entry:SetAttribute("Mature", false)
	entry:SetAttribute("SlotIndex", slotIndex)
	entry.Parent = inventory
	local album = inventory:FindFirstChild("Album")
	if not album then
		album = Instance.new("Folder")
		album.Name = "Album"
		album.Parent = inventory
	end
	if not album:FindFirstChild(creatureId) then
		local albumEntry = Instance.new("StringValue")
		albumEntry.Name = creatureId
		albumEntry.Value = tostring(model:GetAttribute("Rarity") or "Common")
		albumEntry:SetAttribute("Discovered", true)
		albumEntry.Parent = album
	end
	if countValue and countValue:IsA("IntValue") then
		countValue.Value += 1
	end

	carrierByPlayer[player] = nil
	player:SetAttribute("CarryingCreature", false)
	model:Destroy()
	feedbackRemote:FireClient(player, "Delivered", creatureId, slotIndex)
end

local function onDepositTouched(plot: Folder, hit: BasePart)
	local character = hit:FindFirstAncestorOfClass("Model")
	local player = character and Players:GetPlayerFromCharacter(character)
	if not player or player:GetAttribute("PlotName") ~= plot.Name then
		return
	end
	local carried = carrierByPlayer[player]
	if carried then
		deposit(player, carried)
	end
end

local function isInsideDepositTrigger(player: Player): boolean
	local plot = getPlayerPlot(player)
	local trigger = plot and plot:FindFirstChild("DepositTrigger")
	local root = getPlayerRoot(player)
	if not trigger or not trigger:IsA("BasePart") or not root then
		return false
	end
	local localPosition = trigger.CFrame:PointToObjectSpace(root.Position)
	local halfSize = trigger.Size * 0.5
	return math.abs(localPosition.X) <= halfSize.X
		and math.abs(localPosition.Y) <= halfSize.Y
		and math.abs(localPosition.Z) <= halfSize.Z
end

local function tryDepositCarriers()
	for player, model in pairs(carrierByPlayer) do
		if model.Parent and isInsideDepositTrigger(player) then
			deposit(player, model)
		end
	end
end

local function wireDepositTriggers()
	local plaza = Workspace:WaitForChild("RaiseABeastPlaza")
	local plots = plaza:WaitForChild("Zone_Spawn"):WaitForChild("Plots")
	for _, plot in ipairs(plots:GetChildren()) do
		if plot:IsA("Folder") then
			local trigger = plot:FindFirstChild("DepositTrigger")
			if trigger and trigger:IsA("BasePart") then
				trigger.Touched:Connect(function(hit)
					onDepositTouched(plot, hit)
				end)
			end
		end
	end
end

local function carryCreature(player: Player, model: Model)
	local now = os.clock()
	if now - (carryCooldownByUserId[player.UserId] or 0) < 0.5 then
		return
	end
	carryCooldownByUserId[player.UserId] = now
	if activeCreatures[model] == nil or carrierByPlayer[player] ~= nil then
		return
	end
	local root = getPlayerRoot(player)
	local creatureRoot = model.PrimaryPart
	if not root or not creatureRoot or (root.Position - creatureRoot.Position).Magnitude > TransportConfig.CarryMaxActivationDistance then
		return
	end
	if not prepareForCarry(model, player) then
		return
	end

	disconnectPrompt(model)
	clearActiveCreature(model)
	carrierByPlayer[player] = model
	player:SetAttribute("CarryingCreature", true)
	feedbackRemote:FireClient(player, "Carrying", model:GetAttribute("CreatureId"), 0)
end

local function carryNearestCreature(player: Player)
	local playerRoot = getPlayerRoot(player)
	if not playerRoot then
		return
	end

	local nearest: Model? = nil
	local nearestDistance = math.huge
	for model in pairs(activeCreatures) do
		local root = model.PrimaryPart
		if root then
			local distance = (playerRoot.Position - root.Position).Magnitude
			if distance < nearestDistance then
				nearest = model
				nearestDistance = distance
			end
		end
	end
	if nearest then
		carryCreature(player, nearest)
	end
end

local function spawnCreature(initialProgress: number?)
	local activeCount = 0
	for _ in pairs(activeCreatures) do
		activeCount += 1
	end
	if activeCount >= TransportConfig.MaxConveyorCreatures then
		return
	end

	local creatureId = TransportConfig.CreatureIds[math.random(1, #TransportConfig.CreatureIds)]
	local model = CreatureModels.Build(creatureId, CFrame.new(TransportConfig.SpawnPosition), false)
	model.Name = "ConveyorCreature"
	model:SetAttribute("CreatureId", creatureId)
	model:SetAttribute("Rarity", "Common")
	model:SetAttribute("TransportState", "OnConveyor")
	model.Parent = getCreatureFolder()

	local root = model.PrimaryPart
	if not root then
		model:Destroy()
		return
	end
	-- CreatureModels are intentionally non-queryable for display performance;
	-- the carry prompt needs one queryable interaction root.
	root.CanQuery = true
	local prompt = Instance.new("ProximityPrompt")
	prompt.Name = "CarryPrompt"
	prompt.ActionText = "Carry"
	prompt.ObjectText = creatureId
	prompt.KeyboardKeyCode = Enum.KeyCode.E
	prompt.HoldDuration = 0.25
	prompt.MaxActivationDistance = TransportConfig.CarryMaxActivationDistance
	prompt.RequiresLineOfSight = false
	prompt.Parent = root

	local progress = math.clamp(initialProgress or 0, 0, 0.95)
	activeCreatures[model] = progress
	model:PivotTo(CFrame.new(TransportConfig.SpawnPosition:Lerp(TransportConfig.EndPosition, progress)) * CFrame.Angles(0, math.rad(90), 0))
	promptConnections[model] = prompt.Triggered:Connect(function(player)
		carryCreature(player, model)
	end)
	feedbackRemote:FireAllClients("Conveyor", creatureId, 0)
end

local function releaseCarriedCreature(player: Player)
	local carried = carrierByPlayer[player]
	if carried then
		carrierByPlayer[player] = nil
		player:SetAttribute("CarryingCreature", false)
		carried:Destroy()
	end
end

wireDepositTriggers()
carryRequest.OnServerEvent:Connect(carryNearestCreature)
task.delay(1, function()
	for index = 0, TransportConfig.InitialCreatureCount - 1 do
		spawnCreature(index / TransportConfig.InitialCreatureCount)
	end
end)

RunService.Heartbeat:Connect(function(deltaTime)
	tryDepositCarriers()
	local finishedModels = {}
	for model, progress in pairs(activeCreatures) do
		if not model.Parent or not model.PrimaryPart then
			table.insert(finishedModels, model)
		else
			local nextProgress = progress + deltaTime / TransportConfig.TravelSeconds
			if nextProgress >= 1 then
				table.insert(finishedModels, model)
			else
				activeCreatures[model] = nextProgress
				local position = TransportConfig.SpawnPosition:Lerp(TransportConfig.EndPosition, nextProgress)
				model:PivotTo(CFrame.new(position) * CFrame.Angles(0, math.rad(90), 0))
			end
		end
	end
	for _, finished in ipairs(finishedModels) do
		disconnectPrompt(finished)
		clearActiveCreature(finished)
		if finished.Parent then
			finished:Destroy()
		end
	end
end)

task.spawn(function()
	while true do
		task.wait(TransportConfig.SpawnIntervalSeconds)
		spawnCreature()
	end
end)

Players.PlayerRemoving:Connect(releaseCarriedCreature)
Players.PlayerAdded:Connect(function(player)
	player.CharacterRemoving:Connect(function()
			releaseCarriedCreature(player)
	end)
end)
for _, player in ipairs(Players:GetPlayers()) do
	player.CharacterRemoving:Connect(function()
		releaseCarriedCreature(player)
	end)
end
