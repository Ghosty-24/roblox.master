local Workspace = game:GetService("Workspace")

local plaza = Workspace:WaitForChild("RaiseABeastPlaza")
if plaza:FindFirstChild("TycoonPerimeter") then
	return
end

local perimeter = Instance.new("Folder")
perimeter.Name = "TycoonPerimeter"
perimeter:SetAttribute("Style", "LowPolyTycoonGrassWalls")
perimeter:SetAttribute("VisualOnly", true)

local grass = Color3.fromRGB(68, 155, 76)
local grassTop = Color3.fromRGB(103, 206, 83)
local soil = Color3.fromRGB(126, 82, 55)
local trim = Color3.fromRGB(53, 113, 60)

local function addPart(parent: Instance, name: string, size: Vector3, position: Vector3, color: Color3, material: Enum.Material, canCollide: boolean?): BasePart
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = position
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

local function addWall(name: string, size: Vector3, position: Vector3, topSize: Vector3, topPosition: Vector3)
	addPart(perimeter, name .. "Soil", size, position, soil, Enum.Material.Ground)
	addPart(perimeter, name .. "GrassFace", Vector3.new(size.X, 2, size.Z), position + Vector3.new(0, size.Y * 0.5 - 1, 0), grass, Enum.Material.Grass)
	addPart(perimeter, name .. "GrassTop", topSize, topPosition, grassTop, Enum.Material.Grass)
	addPart(perimeter, name .. "Trim", Vector3.new(size.X, 0.25, size.Z), position + Vector3.new(0, size.Y * 0.5 + 0.15, 0), trim, Enum.Material.SmoothPlastic, false)
end

-- The playable plaza remains 180x140; the walls frame it without moving spawns or plots.
addWall("NorthWall", Vector3.new(184, 8, 4), Vector3.new(0, 4, -74), Vector3.new(184, 1, 6), Vector3.new(0, 8.4, -74))
addWall("SouthWall", Vector3.new(184, 8, 4), Vector3.new(0, 4, 74), Vector3.new(184, 1, 6), Vector3.new(0, 8.4, 74))
addWall("WestWall", Vector3.new(4, 8, 144), Vector3.new(-92, 4, 0), Vector3.new(6, 1, 144), Vector3.new(-92, 8.4, 0))
addWall("EastWall", Vector3.new(4, 8, 144), Vector3.new(92, 4, 0), Vector3.new(6, 1, 144), Vector3.new(92, 8.4, 0))

-- Low-poly grass mounds soften the corners without entering the conveyor lane.
for index, position in ipairs({
	Vector3.new(-82, 2, -62),
	Vector3.new(82, 2, -62),
	Vector3.new(-82, 2, 62),
	Vector3.new(82, 2, 62),
}) do
	local mound = Instance.new("WedgePart")
	mound.Name = "GrassMound" .. index
	mound.Size = Vector3.new(18, 10, 18)
	mound.Position = position
	mound.Color = grass
	mound.Material = Enum.Material.Grass
	mound.Anchored = true
	mound.CanCollide = true
	mound.Parent = perimeter
end

perimeter.Parent = plaza
