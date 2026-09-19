local Workspace = game:GetService("Workspace")

local PlazaDef = {
	Name = "RaiseABeastPlaza",
	Origin = CFrame.new(0, 0, 0),
	Floor = Vector3.new(180, 0.5, 140),
	Path = Vector3.new(162, 0.25, 10),
	PlayerBase = Vector3.new(30, 1, 20),
	BoundaryThickness = 1,
	BoundaryHeight = 2,
	BoundarySpanX = 180,
	BoundarySpanZ = 140,
	Accent = Color3.fromRGB(62, 214, 165),
	FloorColor = Color3.fromRGB(93, 181, 103),
	PathColor = Color3.fromRGB(236, 205, 146),
	BaseColor = Color3.fromRGB(93, 116, 214),
	TrimColor = Color3.fromRGB(255, 214, 92),
	ConveyorColor = Color3.fromRGB(55, 62, 78),
	ConveyorAccent = Color3.fromRGB(62, 214, 165),
}

local existing = Workspace:FindFirstChild(PlazaDef.Name)
if existing then
	return
end

local plaza = Instance.new("Model")
plaza.Name = PlazaDef.Name
plaza:SetAttribute("Purpose", "MVP Monster Plaza greybox")
plaza:SetAttribute("Bounds", "180x140 studs")
	plaza:SetAttribute("Zone", 1)
	plaza:SetAttribute("PlotCapacity", 8)
	plaza:SetAttribute("PlatformsPerPlot", 10)

local origin = Instance.new("Part")
origin.Name = "Origin"
origin.Size = Vector3.new(1, 1, 1)
origin.CFrame = PlazaDef.Origin
origin.Transparency = 1
origin.Anchored = true
origin.CanCollide = false
origin.CanTouch = false
origin.CanQuery = false
origin.Parent = plaza
plaza.PrimaryPart = origin

local terrain = Instance.new("Folder")
terrain.Name = "Terrain"
terrain.Parent = plaza

local zones = Instance.new("Folder")
zones.Name = "Zone_Spawn"
zones.Parent = plaza

local landmarks = Instance.new("Folder")
landmarks.Name = "Landmarks"
landmarks.Parent = plaza

local spawns = Instance.new("Folder")
spawns.Name = "Spawns"
spawns.Parent = plaza

local function addPart(parent: Instance, name: string, size: Vector3, offset: Vector3, color: Color3, material: Enum.Material, canCollide: boolean?): BasePart
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.CFrame = PlazaDef.Origin * CFrame.new(offset)
	part.Color = color
	part.Material = material
	part.Anchored = true
	part.CanCollide = canCollide ~= false
	part.CanTouch = canCollide ~= false
	part.CanQuery = canCollide ~= false
	part.CastShadow = true
	part.Parent = parent
	return part
end

addPart(terrain, "PlazaFloor", PlazaDef.Floor, Vector3.new(0, 0.25, 0), PlazaDef.FloorColor, Enum.Material.Grass)
addPart(zones, "MainPath", PlazaDef.Path, Vector3.new(0, 0.64, 0), PlazaDef.PathColor, Enum.Material.Sand)

local plots = Instance.new("Folder")
plots.Name = "Plots"
plots:SetAttribute("Capacity", 8)
plots.Parent = zones

local plotPositions = {
	Vector3.new(-66, 0.75, 34),
	Vector3.new(-22, 0.75, 34),
	Vector3.new(22, 0.75, 34),
	Vector3.new(66, 0.75, 34),
	Vector3.new(-66, 0.75, -34),
	Vector3.new(-22, 0.75, -34),
	Vector3.new(22, 0.75, -34),
	Vector3.new(66, 0.75, -34),
}

for index, position in ipairs(plotPositions) do
	local plot = Instance.new("Folder")
	plot.Name = "Plot" .. index
	plot:SetAttribute("PlotIndex", index)
	plot:SetAttribute("Occupied", false)
	plot:SetAttribute("OwnerUserId", 0)
	plot.Parent = plots

	addPart(plot, "Base", PlazaDef.PlayerBase, position, PlazaDef.BaseColor, Enum.Material.SmoothPlastic)
	local inward = if position.Z > 0 then -1 else 1
	local outward = -inward
	local frontSignOffset = Vector3.new(0, 0.65, inward * 9.5)
	addPart(plot, "FrontTrim", Vector3.new(28, 0.25, 1), position + frontSignOffset, PlazaDef.TrimColor, Enum.Material.Neon, false)
	addPart(plot, "BackWall", Vector3.new(28, 3.5, 0.8), position + Vector3.new(0, 2.25, outward * 9.2), PlazaDef.ConveyorColor, Enum.Material.SmoothPlastic)
	addPart(plot, "GateLeft", Vector3.new(1.2, 4.5, 1.2), position + Vector3.new(-9, 2.75, inward * 9.2), PlazaDef.Accent, Enum.Material.Neon, false)
	addPart(plot, "GateRight", Vector3.new(1.2, 4.5, 1.2), position + Vector3.new(9, 2.75, inward * 9.2), PlazaDef.Accent, Enum.Material.Neon, false)
	addPart(plot, "GateHeader", Vector3.new(19, 0.8, 1.2), position + Vector3.new(0, 4.7, inward * 9.2), PlazaDef.Accent, Enum.Material.Neon, false)
	addPart(plot, "ShowcasePad", Vector3.new(6, 0.35, 2.5), position + Vector3.new(0, 0.95, inward * 7), PlazaDef.TrimColor, Enum.Material.Neon, false)

	local displaySlots = Instance.new("Folder")
	displaySlots.Name = "DisplaySlots"
	displaySlots.Parent = plot
	local slotIndex = 1
	for _, rowZ in ipairs({-4, 4}) do
		for _, x in ipairs({-10, -5, 0, 5, 10}) do
			addPart(displaySlots, "Slot" .. slotIndex, Vector3.new(4, 0.5, 3.5), position + Vector3.new(x, 0.75, rowZ), PlazaDef.TrimColor, Enum.Material.SmoothPlastic)
			slotIndex += 1
		end
	end

	local depositTrigger = addPart(plot, "DepositTrigger", Vector3.new(28, 4, 18), position + Vector3.new(0, 2.5, 0), PlazaDef.Accent, Enum.Material.ForceField, false)
	depositTrigger.Transparency = 1
	depositTrigger.CanTouch = true
	depositTrigger.CanQuery = false

	local connectorZ = inward * 11
	addPart(zones, "PlotPath" .. index, Vector3.new(8, 0.22, 36), position + Vector3.new(0, -0.05, connectorZ), PlazaDef.PathColor, Enum.Material.Sand)
end

addPart(terrain, "NorthBoundary", Vector3.new(PlazaDef.BoundarySpanX, PlazaDef.BoundaryHeight, PlazaDef.BoundaryThickness), Vector3.new(0, 1, -69.5), PlazaDef.FloorColor, Enum.Material.Grass)
addPart(terrain, "SouthBoundary", Vector3.new(PlazaDef.BoundarySpanX, PlazaDef.BoundaryHeight, PlazaDef.BoundaryThickness), Vector3.new(0, 1, 69.5), PlazaDef.FloorColor, Enum.Material.Grass)
addPart(terrain, "WestBoundary", Vector3.new(PlazaDef.BoundaryThickness, PlazaDef.BoundaryHeight, PlazaDef.BoundarySpanZ), Vector3.new(-89.5, 1, 0), PlazaDef.FloorColor, Enum.Material.Grass)
addPart(terrain, "EastBoundary", Vector3.new(PlazaDef.BoundaryThickness, PlazaDef.BoundaryHeight, PlazaDef.BoundarySpanZ), Vector3.new(89.5, 1, 0), PlazaDef.FloorColor, Enum.Material.Grass)

local environment = Instance.new("Folder")
environment.Name = "LowPolyEnvironment"
environment.Parent = landmarks

local function addMountainCluster(name: string, center: Vector3, scale: number)
	local left = Instance.new("WedgePart")
	left.Name = name .. "_Left"
	left.Size = Vector3.new(18 * scale, 16 * scale, 22 * scale)
	left.CFrame = PlazaDef.Origin * CFrame.new(center + Vector3.new(-9 * scale, 8 * scale, 0)) * CFrame.Angles(0, math.rad(90), 0)
	left.Color = Color3.fromRGB(74, 122, 91)
	left.Material = Enum.Material.Slate
	left.Anchored = true
	left.Parent = environment

	local right = Instance.new("WedgePart")
	right.Name = name .. "_Right"
	right.Size = Vector3.new(22 * scale, 20 * scale, 26 * scale)
	right.CFrame = PlazaDef.Origin * CFrame.new(center + Vector3.new(10 * scale, 10 * scale, 2 * scale)) * CFrame.Angles(0, math.rad(-90), 0)
	right.Color = Color3.fromRGB(54, 98, 78)
	right.Material = Enum.Material.Slate
	right.Anchored = true
	right.Parent = environment
end

addMountainCluster("NorthMountains", Vector3.new(-58, 1, -66), 1.2)
addMountainCluster("NorthMountainsEast", Vector3.new(46, 1, -66), 0.9)
addMountainCluster("SouthMountains", Vector3.new(-42, 1, 66), 1.1)
addMountainCluster("SouthMountainsEast", Vector3.new(58, 1, 66), 0.8)

addPart(landmarks, "CaptureGuideLeft", Vector3.new(1, 4, 1), Vector3.new(-6, 2.5, 14), PlazaDef.Accent, Enum.Material.Neon, false)
addPart(landmarks, "CaptureGuideRight", Vector3.new(1, 4, 1), Vector3.new(6, 2.5, 14), PlazaDef.Accent, Enum.Material.Neon, false)
addPart(landmarks, "CaptureGuideTop", Vector3.new(13, 1, 1), Vector3.new(0, 4.25, 14), PlazaDef.Accent, Enum.Material.Neon, false)
	addPart(landmarks, "FoodVendorSpot", Vector3.new(8, 0.4, 6), Vector3.new(0, 0.9, 9), PlazaDef.TrimColor, Enum.Material.SmoothPlastic)

local conveyorZone = Instance.new("Folder")
conveyorZone.Name = "ConveyorZone"
conveyorZone:SetAttribute("Purpose", "Wild creatures travel through the plaza")
conveyorZone.Parent = plaza

addPart(conveyorZone, "CreatureConveyor", Vector3.new(164, 0.5, 6), Vector3.new(0, 0.7, -8), PlazaDef.ConveyorColor, Enum.Material.Metal)
for index, x in ipairs({ -78, -66, -54, -42, -30, -18, -6, 6, 18, 30, 42, 54, 66, 78 }) do
	addPart(conveyorZone, "ConveyorStripe" .. index, Vector3.new(0.35, 0.08, 5.2), Vector3.new(x, 0.99, -8), PlazaDef.ConveyorAccent, Enum.Material.Neon, false)
end

local spawn = Instance.new("SpawnLocation")
spawn.Name = "PlayerSpawn"
spawn.Size = Vector3.new(6, 1, 6)
spawn.CFrame = PlazaDef.Origin * CFrame.new(0, 1.75, 59)
spawn.Color = PlazaDef.Accent
spawn.Material = Enum.Material.Neon
spawn.Anchored = true
spawn.CanCollide = true
spawn.Neutral = true
spawn.AllowTeamChangeOnTouch = false
spawn.Parent = spawns

plaza.Parent = Workspace
