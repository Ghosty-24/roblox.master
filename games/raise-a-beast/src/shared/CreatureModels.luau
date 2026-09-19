-- Constructores de criaturas low-poly para Raise a Beast.
-- No dependen de meshes externos: son ligeros, editables y aptos para móvil.

local CreatureModels = {}
local Zone1Catalog = require(script.Parent.Zone1CreatureCatalog)

local function part(parent: Instance, name: string, size: Vector3, color: Color3, shape: Enum.PartType?, cf: CFrame?): BasePart
	local p = Instance.new("Part")
	p.Name = name
	p.Size = size
	p.Color = color
	p.Material = Enum.Material.SmoothPlastic
	p.Shape = shape or Enum.PartType.Block
	p.Anchored = true
	p.CanCollide = false
	p.CanTouch = false
	p.CanQuery = false
	p.CFrame = cf or CFrame.identity
	p.Parent = parent
	return p
end

local function sphere(parent: Instance, name: string, size: Vector3, color: Color3, cf: CFrame): BasePart
	return part(parent, name, size, color, Enum.PartType.Ball, cf)
end

local function eye(parent: Instance, name: string, cf: CFrame, sleepy: boolean?): BasePart
	local e = sphere(parent, name, Vector3.new(0.16, 0.12, 0.08), Color3.fromRGB(30, 25, 35), cf)
	e:SetAttribute("Sleepy", sleepy == true)
	return e
end

local function label(model: Model, title: string, rarity: string)
	model:SetAttribute("CreatureId", title)
	model:SetAttribute("Rarity", rarity)
	model:SetAttribute("ModelVersion", 1)
end

local function finish(model: Model, root: BasePart): Model
	model.PrimaryPart = root
	return model
end

function CreatureModels.AngryPotato(origin: CFrame, mutated: boolean?): Model
	local model = Instance.new("Model")
	model.Name = mutated and "AngryPotato_Mutated" or "AngryPotato"
	label(model, "AngryPotato", mutated and "Mutated" or "Common")
	local bodyColor = mutated and Color3.fromRGB(255, 105, 70) or Color3.fromRGB(214, 155, 67)
	local root = sphere(model, "Root", Vector3.new(2.8, 2.2, 2.4), bodyColor, origin * CFrame.new(0, 1.25, 0))
	part(model, "Leaf", Vector3.new(0.35, 1.0, 0.22), Color3.fromRGB(76, 177, 83), Enum.PartType.Block, origin * CFrame.new(0, 2.7, 0) * CFrame.Angles(0, 0, math.rad(-25)))
	part(model, "LeafTip", Vector3.new(0.28, 0.65, 0.2), Color3.fromRGB(103, 205, 92), Enum.PartType.Block, origin * CFrame.new(0.28, 2.85, 0) * CFrame.Angles(0, 0, math.rad(30)))
	eye(model, "EyeLeft", origin * CFrame.new(-0.48, 1.5, -1.06))
	eye(model, "EyeRight", origin * CFrame.new(0.48, 1.5, -1.06))
	part(model, "BrowLeft", Vector3.new(0.62, 0.13, 0.12), Color3.fromRGB(55, 36, 26), Enum.PartType.Block, origin * CFrame.new(-0.48, 1.82, -1.12) * CFrame.Angles(0, 0, math.rad(-18)))
	part(model, "BrowRight", Vector3.new(0.62, 0.13, 0.12), Color3.fromRGB(55, 36, 26), Enum.PartType.Block, origin * CFrame.new(0.48, 1.82, -1.12) * CFrame.Angles(0, 0, math.rad(18)))
	part(model, "Mouth", Vector3.new(0.62, 0.1, 0.08), Color3.fromRGB(55, 25, 30), Enum.PartType.Block, origin * CFrame.new(0, 0.98, -1.1))
	return finish(model, root)
end

function CreatureModels.SleepyBlob(origin: CFrame, mutated: boolean?): Model
	local model = Instance.new("Model")
	model.Name = mutated and "SleepyBlob_Mutated" or "SleepyBlob"
	label(model, "SleepyBlob", mutated and "Mutated" or "Common")
	local bodyColor = mutated and Color3.fromRGB(151, 118, 255) or Color3.fromRGB(107, 190, 220)
	local root = sphere(model, "Root", Vector3.new(2.7, 2.35, 2.25), bodyColor, origin * CFrame.new(0, 1.2, 0))
	sphere(model, "EarLeft", Vector3.new(0.65, 0.82, 0.45), bodyColor, origin * CFrame.new(-1.05, 1.9, 0))
	sphere(model, "EarRight", Vector3.new(0.65, 0.82, 0.45), bodyColor, origin * CFrame.new(1.05, 1.9, 0))
	eye(model, "EyeLeft", origin * CFrame.new(-0.45, 1.35, -0.98), true)
	eye(model, "EyeRight", origin * CFrame.new(0.45, 1.35, -0.98), true)
	part(model, "SleepLineLeft", Vector3.new(0.42, 0.08, 0.08), Color3.fromRGB(35, 45, 75), Enum.PartType.Block, origin * CFrame.new(-0.5, 1.34, -1.04) * CFrame.Angles(0, 0, math.rad(-15)))
	part(model, "SleepLineRight", Vector3.new(0.42, 0.08, 0.08), Color3.fromRGB(35, 45, 75), Enum.PartType.Block, origin * CFrame.new(0.5, 1.34, -1.04) * CFrame.Angles(0, 0, math.rad(15)))
	part(model, "Mouth", Vector3.new(0.28, 0.08, 0.08), Color3.fromRGB(35, 45, 75), Enum.PartType.Block, origin * CFrame.new(0, 0.95, -1.02))
	local z = sphere(model, "Zzz", Vector3.new(0.34, 0.34, 0.34), Color3.fromRGB(232, 245, 255), origin * CFrame.new(1.0, 2.75, -0.1))
	z.Transparency = 0.1
	return finish(model, root)
end

function CreatureModels.TinyCloud(origin: CFrame, mutated: boolean?): Model
	local model = Instance.new("Model")
	model.Name = mutated and "TinyCloud_Mutated" or "TinyCloud"
	label(model, "TinyCloud", mutated and "Mutated" or "Common")
	local bodyColor = mutated and Color3.fromRGB(255, 196, 91) or Color3.fromRGB(238, 247, 255)
	local root = sphere(model, "Root", Vector3.new(2.9, 1.55, 2.0), bodyColor, origin * CFrame.new(0, 1.35, 0))
	for i, x in ipairs({-0.85, -0.25, 0.4, 0.95}) do
		sphere(model, "Puff" .. i, Vector3.new(1.25, 1.2, 1.25), bodyColor, origin * CFrame.new(x, 1.65 + ((i % 2) * 0.18), 0))
	end
	eye(model, "EyeLeft", origin * CFrame.new(-0.42, 1.35, -0.92))
	eye(model, "EyeRight", origin * CFrame.new(0.42, 1.35, -0.92))
	part(model, "Smile", Vector3.new(0.42, 0.08, 0.08), Color3.fromRGB(70, 85, 110), Enum.PartType.Block, origin * CFrame.new(0, 1.0, -0.96))
	local sparkle = sphere(model, "Sparkle", Vector3.new(0.28, 0.28, 0.28), mutated and Color3.fromRGB(255, 239, 110) or Color3.fromRGB(151, 226, 255), origin * CFrame.new(1.25, 2.5, -0.15))
	sparkle.Material = Enum.Material.Neon
	return finish(model, root)
end

function CreatureModels.PrismBloom(origin: CFrame, mutated: boolean?): Model
	local model = Instance.new("Model")
	model.Name = mutated and "PrismBloom_Mutated" or "PrismBloom"
	label(model, "PrismBloom", mutated and "Mutated" or "Rare")
	local bodyColor = mutated and Color3.fromRGB(255, 168, 245) or Color3.fromRGB(177, 106, 255)
	local petalColor = mutated and Color3.fromRGB(255, 244, 126) or Color3.fromRGB(84, 231, 255)
	local root = sphere(model, "Root", Vector3.new(2.4, 2.15, 2.25), bodyColor, origin * CFrame.new(0, 1.25, 0))
	root.Material = Enum.Material.Neon

	for index = 1, 5 do
		local angle = (index - 1) * (math.pi * 2 / 5)
		local offset = Vector3.new(math.cos(angle) * 1.0, 2.15, math.sin(angle) * 1.0)
		local petal = part(
			model,
			"Petal" .. index,
			Vector3.new(0.55, 1.35, 0.28),
			petalColor,
			Enum.PartType.Block,
			origin * CFrame.new(offset) * CFrame.Angles(0, -angle, math.rad(24))
		)
		petal.Material = Enum.Material.Neon
	end

	eye(model, "EyeLeft", origin * CFrame.new(-0.4, 1.45, -1.0))
	eye(model, "EyeRight", origin * CFrame.new(0.4, 1.45, -1.0))
	local core = sphere(model, "BloomCore", Vector3.new(0.5, 0.5, 0.5), Color3.fromRGB(255, 242, 112), origin * CFrame.new(0, 2.25, -0.15))
	core.Material = Enum.Material.Neon
	return finish(model, root)
end

local function genericCreature(design, origin: CFrame, mutated: boolean?): Model
	local model = Instance.new("Model")
	model.Name = mutated and design.id .. "_Mutated" or design.id
	label(model, design.id, mutated and "Mutated" or design.rarity)
	local bodyColor = mutated and design.palette:Lerp(Color3.fromRGB(255, 255, 255), 0.22) or design.palette
	local root = sphere(model, "Root", Vector3.new(2.35, 2.05, 2.1), bodyColor, origin * CFrame.new(0, 1.2, 0))

	-- Una silueta base compartida mantiene bajo el coste de instancias en móvil.
	if design.archetype == "worm" then
		for i = 1, 3 do
			sphere(model, "Segment" .. i, Vector3.new(1.1, 0.95, 1.1), bodyColor, origin * CFrame.new((i - 2) * 0.72, 1.0, 0.1))
		end
	elseif design.archetype == "cloud" then
		for i, x in ipairs({-0.7, 0, 0.7}) do
			sphere(model, "Puff" .. i, Vector3.new(1.2, 1.1, 1.2), bodyColor, origin * CFrame.new(x, 1.55, 0))
		end
	elseif design.archetype == "bat" then
		part(model, "WingLeft", Vector3.new(1.5, 0.16, 0.9), bodyColor, Enum.PartType.Block, origin * CFrame.new(-1.15, 1.35, 0))
		part(model, "WingRight", Vector3.new(1.5, 0.16, 0.9), bodyColor, Enum.PartType.Block, origin * CFrame.new(1.15, 1.35, 0))
	elseif design.archetype == "robot" then
		part(model, "ChestPlate", Vector3.new(1.45, 0.6, 0.18), Color3.fromRGB(45, 48, 65), Enum.PartType.Block, origin * CFrame.new(0, 1.2, -1.0))
		local reactor = sphere(model, "Reactor", Vector3.new(0.3, 0.3, 0.12), Color3.fromRGB(255, 70, 90), origin * CFrame.new(0, 1.2, -1.12))
		reactor.Material = Enum.Material.Neon
	elseif design.archetype == "mushroom" then
		sphere(model, "Cap", Vector3.new(2.9, 0.85, 2.45), bodyColor, origin * CFrame.new(0, 2.2, 0))
	elseif design.archetype == "crab" then
		sphere(model, "ClawLeft", Vector3.new(0.7, 0.7, 0.7), bodyColor, origin * CFrame.new(-1.35, 1.15, -0.1))
		sphere(model, "ClawRight", Vector3.new(0.7, 0.7, 0.7), bodyColor, origin * CFrame.new(1.35, 1.15, -0.1))
	elseif design.archetype == "croc" then
		part(model, "Snout", Vector3.new(1.7, 0.55, 0.75), bodyColor, Enum.PartType.Block, origin * CFrame.new(0, 1.0, -1.1))
	elseif design.archetype == "duck" then
		part(model, "Beak", Vector3.new(0.75, 0.35, 0.5), Color3.fromRGB(255, 186, 52), Enum.PartType.Block, origin * CFrame.new(0, 1.25, -1.2))
	elseif design.archetype == "slime" then
		root.Transparency = 0.18
		root.Material = Enum.Material.Glass
	end

	eye(model, "EyeLeft", origin * CFrame.new(-0.4, 1.42, -0.95))
	eye(model, "EyeRight", origin * CFrame.new(0.4, 1.42, -0.95))
	local accent = sphere(model, "Feature", Vector3.new(0.28, 0.28, 0.28), mutated and Color3.fromRGB(255, 244, 116) or Color3.fromRGB(255, 255, 255), origin * CFrame.new(0.95, 2.35, -0.2))
	accent.Material = (design.rarity == "Rare" or design.rarity == "Epic" or design.rarity == "Legendary") and Enum.Material.Neon or Enum.Material.SmoothPlastic
	model:SetAttribute("DesignFeature", design.feature)
	return finish(model, root)
end

function CreatureModels.Build(creatureId: string, origin: CFrame, mutated: boolean?): Model
	if creatureId == "AngryPotato" then
		return CreatureModels.AngryPotato(origin, mutated)
	elseif creatureId == "SleepyBlob" then
		return CreatureModels.SleepyBlob(origin, mutated)
	elseif creatureId == "TinyCloud" then
		return CreatureModels.TinyCloud(origin, mutated)
	elseif creatureId == "PrismBloom" then
		return CreatureModels.PrismBloom(origin, mutated)
	end
	return genericCreature(Zone1Catalog.Get(creatureId), origin, mutated)
end

return CreatureModels
