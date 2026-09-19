local Workspace = game:GetService("Workspace")
local ServerStorage = game:GetService("ServerStorage")

local plaza = Workspace:WaitForChild("RaiseABeastPlaza")
local plots = plaza:WaitForChild("Zone_Spawn"):WaitForChild("Plots")
local creatorStoreAssets = ServerStorage:FindFirstChild("CreatorStoreAssets")
local brainrotBaseTemplate = creatorStoreAssets and creatorStoreAssets:FindFirstChild("StealABrainrotBaseTemplate")

local palette = {
	Color3.fromRGB(240, 90, 82),
	Color3.fromRGB(73, 153, 255),
	Color3.fromRGB(164, 92, 245),
	Color3.fromRGB(255, 165, 57),
	Color3.fromRGB(44, 211, 175),
	Color3.fromRGB(255, 218, 76),
	Color3.fromRGB(239, 100, 184),
	Color3.fromRGB(122, 226, 83),
}

local styles = {
	"WindowShowroom",
	"NeonGate",
	"StripedShop",
	"TwinWindow",
	"CornerCanopy",
	"TallSign",
	"OpenGarage",
	"DoubleFrame",
}

local function addPart(
	parent: Instance,
	name: string,
	size: Vector3,
	position: Vector3,
	color: Color3,
	material: Enum.Material,
	canCollide: boolean?
): BasePart
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = position
	part.Color = color
	part.Material = material
	part.Anchored = true
	part.CanCollide = canCollide == true
	part.CanTouch = canCollide == true
	part.CanQuery = canCollide == true
	part.CastShadow = true
	part.Parent = parent
	return part
end

local function addFacadePart(
	parent: Instance,
	name: string,
	size: Vector3,
	localOffset: Vector3,
	center: Vector3,
	color: Color3,
	material: Enum.Material,
	canCollide: boolean?
): BasePart
	local part = addPart(parent, name, size, center, color, material, canCollide)
	part.CFrame = CFrame.new(center) * CFrame.new(localOffset)
	return part
end

local function addSign(parent: Instance, center: Vector3, accent: Color3, inward: number, index: number)
	addFacadePart(parent, "SignPost" .. index, Vector3.new(0.35, 2.2, 0.35), Vector3.new(0, 4.9, 0), center + Vector3.new(0, 0, inward * 8.4), accent, Enum.Material.Metal)
	addFacadePart(parent, "SignBoard" .. index, Vector3.new(11, 2.2, 0.35), Vector3.new(0, 6.2, 0), center + Vector3.new(0, 0, inward * 8.4), accent, Enum.Material.SmoothPlastic)
end

local function addWindow(parent: Instance, center: Vector3, accent: Color3, zOffset: number, name: string)
	addFacadePart(parent, name .. "Glass", Vector3.new(9, 4.8, 0.2), Vector3.new(0, 4.8, zOffset), center, Color3.fromRGB(170, 224, 220), Enum.Material.Glass)
	addFacadePart(parent, name .. "Top", Vector3.new(10, 0.35, 0.5), Vector3.new(0, 7.35, zOffset), center, accent, Enum.Material.SmoothPlastic)
	addFacadePart(parent, name .. "Bottom", Vector3.new(10, 0.35, 0.5), Vector3.new(0, 2.25, zOffset), center, accent, Enum.Material.SmoothPlastic)
	addFacadePart(parent, name .. "Left", Vector3.new(0.35, 5.4, 0.5), Vector3.new(-5, 4.8, zOffset), center, accent, Enum.Material.SmoothPlastic)
	addFacadePart(parent, name .. "Right", Vector3.new(0.35, 5.4, 0.5), Vector3.new(5, 4.8, zOffset), center, accent, Enum.Material.SmoothPlastic)
end

local function buildFacade(plot: Folder, index: number)
	if plot:FindFirstChild("StealABrainrotBase") then
		return
	end

	if plot:FindFirstChild("LowPolyFacade") then
		return
	end

	local base = plot:FindFirstChild("Base")
	if not base or not base:IsA("BasePart") then
		return
	end

	if brainrotBaseTemplate and brainrotBaseTemplate:IsA("Model") then
		local model = brainrotBaseTemplate:Clone()
		model.Name = "StealABrainrotBase"
		model:SetAttribute("CreatorStoreAssetId", "138263847127429")
		model:SetAttribute("CreatorStoreUrl", "https://create.roblox.com/store/asset/138263847127429")
		model:SetAttribute("Style", "StealABrainrotTycoonPBR")
		model:SetAttribute("PlotIndex", index)
		model.Parent = plot
		model:ScaleTo(0.48)

		local bboxCFrame, bboxSize = model:GetBoundingBox()
		local localOffset = model:GetPivot():ToObjectSpace(bboxCFrame)
		local floorY = base.Position.Y + base.Size.Y * 0.5
		local center = Vector3.new(base.Position.X, floorY + bboxSize.Y * 0.5 + 0.02, base.Position.Z)
		local rotation = if base.Position.Z > 0 then math.pi else 0
		local target = CFrame.new(center) * CFrame.Angles(0, rotation, 0)
		model:PivotTo(target * localOffset:Inverse())
		return
	end

	local facade = Instance.new("Model")
	facade.Name = "LowPolyFacade"
	facade:SetAttribute("FacadeStyle", styles[index])
	facade:SetAttribute("PlotIndex", index)
	facade:SetAttribute("VisualOnly", true)
	facade:SetAttribute("Style", "LowPolyBlocky")
	facade.Parent = plot

	local center = base.Position
	local inward = if center.Z > 0 then -1 else 1
	local outward = -inward
	local accent = palette[index]
	local dark = Color3.fromRGB(67, 72, 88)
	local light = Color3.fromRGB(235, 237, 230)
	local rear = center + Vector3.new(0, 0, outward * 7.5)
	local wallColor = accent:Lerp(dark, 0.35)

	-- Shared shop silhouette: side walls, roof, rear wall and open entrance.
	addPart(facade, "RearWall", Vector3.new(28, 9, 0.8), rear + Vector3.new(0, 4.8, 0), wallColor, Enum.Material.SmoothPlastic)
	addPart(facade, "Roof", Vector3.new(30, 0.8, 11), center + Vector3.new(0, 9.5, outward * 3.5), light, Enum.Material.SmoothPlastic)
	addPart(facade, "RoofTrim", Vector3.new(30.5, 0.35, 0.7), center + Vector3.new(0, 9, inward * 8.5), accent, Enum.Material.Neon)
	addPart(facade, "LeftSideWall", Vector3.new(1.2, 7.6, 9), center + Vector3.new(-13, 4.4, outward * 3.5), wallColor, Enum.Material.SmoothPlastic)
	addPart(facade, "RightSideWall", Vector3.new(1.2, 7.6, 9), center + Vector3.new(13, 4.4, outward * 3.5), wallColor, Enum.Material.SmoothPlastic)
	addPart(facade, "LeftPillar", Vector3.new(1.2, 9, 1.2), center + Vector3.new(-13, 4.8, inward * 7.8), accent, Enum.Material.SmoothPlastic)
	addPart(facade, "RightPillar", Vector3.new(1.2, 9, 1.2), center + Vector3.new(13, 4.8, inward * 7.8), accent, Enum.Material.SmoothPlastic)
	addPart(facade, "FrontHeader", Vector3.new(26, 1.1, 1.2), center + Vector3.new(0, 8.6, inward * 7.8), dark, Enum.Material.SmoothPlastic)
	addPart(facade, "FrontThreshold", Vector3.new(25, 0.25, 1.2), center + Vector3.new(0, 1.35, inward * 7.7), accent, Enum.Material.Neon)

	if styles[index] == "WindowShowroom" then
		addWindow(facade, center, accent, inward * 7.9, "Showcase")
		addSign(facade, center, accent, inward, index)
	elseif styles[index] == "NeonGate" then
		addPart(facade, "GateLeft", Vector3.new(1, 6.8, 1), center + Vector3.new(-7, 4.2, inward * 7.9), accent, Enum.Material.Neon)
		addPart(facade, "GateRight", Vector3.new(1, 6.8, 1), center + Vector3.new(7, 4.2, inward * 7.9), accent, Enum.Material.Neon)
		addPart(facade, "GateTop", Vector3.new(15, 1, 1), center + Vector3.new(0, 7.6, inward * 7.9), accent, Enum.Material.Neon)
		addSign(facade, center, dark, inward, index)
	elseif styles[index] == "StripedShop" then
		for stripe = -2, 2 do
			addPart(facade, "Stripe" .. stripe, Vector3.new(4.5, 5.8, 0.25), center + Vector3.new(stripe * 5, 4.8, inward * 7.9), if stripe % 2 == 0 then accent else light, Enum.Material.SmoothPlastic)
		end
		addSign(facade, center, accent, inward, index)
	elseif styles[index] == "TwinWindow" then
		addWindow(facade, center + Vector3.new(-6, 0, 0), accent, inward * 7.9, "WindowLeft")
		addWindow(facade, center + Vector3.new(6, 0, 0), accent, inward * 7.9, "WindowRight")
	elseif styles[index] == "CornerCanopy" then
		addPart(facade, "CanopyLeft", Vector3.new(11, 0.5, 5), center + Vector3.new(-8, 8, inward * 5.2), accent, Enum.Material.SmoothPlastic)
		addPart(facade, "CanopyRight", Vector3.new(11, 0.5, 5), center + Vector3.new(8, 8, inward * 5.2), accent, Enum.Material.SmoothPlastic)
		addSign(facade, center, accent, inward, index)
	elseif styles[index] == "TallSign" then
		addPart(facade, "TallSignPole", Vector3.new(0.7, 7, 0.7), center + Vector3.new(0, 11, outward * 5), accent, Enum.Material.Metal)
		addPart(facade, "TallSign", Vector3.new(9, 3.5, 0.5), center + Vector3.new(0, 14, outward * 5), accent, Enum.Material.SmoothPlastic)
		addWindow(facade, center, light, inward * 7.9, "TallWindow")
	elseif styles[index] == "OpenGarage" then
		addPart(facade, "GarageRoofAccent", Vector3.new(23, 0.5, 2), center + Vector3.new(0, 7.5, inward * 8.5), accent, Enum.Material.Neon)
		addPart(facade, "GarageBackAccent", Vector3.new(19, 5.5, 0.25), rear + Vector3.new(0, 3.8, outward * -0.5), accent, Enum.Material.SmoothPlastic)
		addSign(facade, center, accent, inward, index)
	else
		addWindow(facade, center, accent, inward * 7.9, "DoubleFrame")
		addPart(facade, "FrameCenter", Vector3.new(0.7, 5.6, 0.6), center + Vector3.new(0, 4.8, inward * 8), accent, Enum.Material.SmoothPlastic)
		addSign(facade, center, accent, inward, index)
	end
end

for index = 1, 8 do
	local plot = plots:FindFirstChild("Plot" .. index)
	if plot and plot:IsA("Folder") then
		buildFacade(plot, index)
	end
end
