local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local DataService = {}

local SCHEMA_VERSION = 1
local AUTOSAVE_SECONDS = 60
local MAX_ATTEMPTS = 3
local STORE_NAME = if RunService:IsStudio() then "RaiseABeast_MVP_Studio_v1" else "RaiseABeast_MVP_v1"
local store = DataStoreService:GetDataStore(STORE_NAME)
-- true = loaded safely, false = defaults only because the load failed.
local sessions: {[Player]: boolean} = {}
local saving: {[Player]: boolean} = {}

local function defaultData()
	return {
		schemaVersion = SCHEMA_VERSION,
		food = 9,
		captureCount = 0,
		fusionCount = 0,
		creatures = {},
		album = {},
	}
end

local function retry<T>(operation: () -> T): (boolean, T?)
	local lastError
	for attempt = 1, MAX_ATTEMPTS do
		local success, result = pcall(operation)
		if success then
			return true, result
		end
		lastError = result
		if attempt < MAX_ATTEMPTS then
			task.wait(attempt)
		end
	end
	warn("DataStore operation failed after retries:", lastError)
	return false, nil
end

local function getOrCreateFolder(player: Player): Folder
	local inventory = player:FindFirstChild("RaiseABeastInventory")
	if not inventory then
		inventory = Instance.new("Folder")
		inventory.Name = "RaiseABeastInventory"
		inventory.Parent = player
	end
	return inventory :: Folder
end

local function getOrCreateInt(parent: Instance, name: string, value: number): IntValue
	local existing = parent:FindFirstChild(name)
	if existing and existing:IsA("IntValue") then
		return existing
	end
	local result = Instance.new("IntValue")
	result.Name = name
	result.Value = value
	result.Parent = parent
	return result
end

local function readAttribute(instance: Instance, name: string, fallback: any): any
	local value = instance:GetAttribute(name)
	return if value == nil then fallback else value
end

local function buildInventory(player: Player, data: {[string]: any}): Folder
	local inventory = getOrCreateFolder(player)
	local food = getOrCreateInt(inventory, "Food", 9)
	food.Value = math.max(0, math.floor(tonumber(data.food) or 9))
	local captureCount = getOrCreateInt(inventory, "CaptureCount", 0)
	captureCount.Value = math.max(0, math.floor(tonumber(data.captureCount) or 0))
	local fusionCount = getOrCreateInt(inventory, "FusionCount", 0)
	fusionCount.Value = math.max(0, math.floor(tonumber(data.fusionCount) or 0))

	for _, child in ipairs(inventory:GetChildren()) do
		if child:IsA("StringValue") or child:IsA("Folder") then
			child:Destroy()
		end
	end

	for index, saved in ipairs(data.creatures or {}) do
		if type(saved) == "table" and type(saved.id) == "string" then
			local creature = Instance.new("StringValue")
			creature.Name = if type(saved.name) == "string" then saved.name else string.format("Creature_%03d", index)
			creature.Value = saved.id
			creature:SetAttribute("CreatureId", saved.id)
			creature:SetAttribute("Rarity", saved.rarity or "Common")
			creature:SetAttribute("Protected", saved.protected ~= false)
			creature:SetAttribute("Growth", math.max(0, math.floor(tonumber(saved.growth) or 0)))
			creature:SetAttribute("MaxGrowth", math.max(1, math.floor(tonumber(saved.maxGrowth) or 3)))
			creature:SetAttribute("Mature", saved.mature == true)
			creature:SetAttribute("Fused", saved.fused == true)
			creature:SetAttribute("Transported", saved.transported == true)
			if type(saved.slotIndex) == "number" then
				creature:SetAttribute("SlotIndex", math.floor(saved.slotIndex))
			end
			creature.Parent = inventory
		end
	end

	if type(data.album) == "table" and next(data.album) ~= nil then
		local album = Instance.new("Folder")
		album.Name = "Album"
		album.Parent = inventory
		for creatureId, rarity in pairs(data.album) do
			if type(creatureId) == "string" and type(rarity) == "string" then
				local entry = Instance.new("StringValue")
				entry.Name = creatureId
				entry.Value = rarity
				entry:SetAttribute("Discovered", true)
				entry.Parent = album
			end
		end
	end

	return inventory
end

local function snapshot(player: Player): {[string]: any}
	local data = defaultData()
	local inventory = player:FindFirstChild("RaiseABeastInventory")
	if not inventory then
		return data
	end

	local food = inventory:FindFirstChild("Food")
	local captureCount = inventory:FindFirstChild("CaptureCount")
	local fusionCount = inventory:FindFirstChild("FusionCount")
	data.food = if food and food:IsA("IntValue") then food.Value else data.food
	data.captureCount = if captureCount and captureCount:IsA("IntValue") then captureCount.Value else data.captureCount
	data.fusionCount = if fusionCount and fusionCount:IsA("IntValue") then fusionCount.Value else data.fusionCount

	for _, item in ipairs(inventory:GetChildren()) do
		if item:IsA("StringValue") and item:GetAttribute("CreatureId") then
			table.insert(data.creatures, {
				name = item.Name,
				id = item.Value,
				rarity = readAttribute(item, "Rarity", "Common"),
				protected = readAttribute(item, "Protected", true),
				growth = readAttribute(item, "Growth", 0),
				maxGrowth = readAttribute(item, "MaxGrowth", 3),
				mature = readAttribute(item, "Mature", false),
				fused = readAttribute(item, "Fused", false),
				transported = readAttribute(item, "Transported", false),
				slotIndex = item:GetAttribute("SlotIndex"),
			})
		elseif item:IsA("Folder") and item.Name == "Album" then
			for _, entry in ipairs(item:GetChildren()) do
				if entry:IsA("StringValue") then
					data.album[entry.Name] = entry.Value
				end
			end
		end
	end

	return data
end

function DataService.LoadPlayer(player: Player): Folder
	if sessions[player] ~= nil then
		return getOrCreateFolder(player)
	end

	local data = defaultData()
	local success, result = retry(function()
		return store:GetAsync(tostring(player.UserId))
	end)
	if success and type(result) == "table" then
		data = result
		if data.schemaVersion ~= SCHEMA_VERSION then
			warn("Unsupported data schema for", player.Name, "using safe defaults")
			data = defaultData()
		end
	elseif not success then
		warn("Using session defaults for", player.Name)
	end

	sessions[player] = success
	return buildInventory(player, data)
end

function DataService.SavePlayer(player: Player): boolean
	if sessions[player] ~= true or saving[player] then
		if sessions[player] == false then
			warn("Skipping save because the initial load failed for", player.Name)
		end
		return false
	end
	saving[player] = true
	local data = snapshot(player)
	local success = retry(function()
		store:UpdateAsync(tostring(player.UserId), function()
			return data
		end)
		return true
	end)
	saving[player] = nil
	return success == true
end

function DataService.StartAutosave()
	task.spawn(function()
		while true do
			task.wait(AUTOSAVE_SECONDS)
			for player in pairs(sessions) do
				if player.Parent == Players then
					DataService.SavePlayer(player)
				end
			end
		end
	end)
end

function DataService.ForgetPlayer(player: Player)
	sessions[player] = nil
	saving[player] = nil
end

return DataService
