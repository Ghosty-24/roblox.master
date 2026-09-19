local TransportConfig = {
	ConveyorFolderName = "ConveyorZone",
	CreatureFolderName = "ConveyorCreatures",
	RemoteFolderName = "RaiseABeastRemotes",
	FeedbackRemoteName = "CaptureFeedback",
	SpawnPosition = Vector3.new(-81, 1.2, -8),
	EndPosition = Vector3.new(81, 1.2, -8),
	-- 1.25x relative to the previous 20-second travel time.
	ConveyorSpeedMultiplier = 1.25,
	TravelSeconds = 16,
	-- Higher traffic keeps the conveyor populated without spawning every frame.
	SpawnIntervalSeconds = 3,
	InitialCreatureCount = 6,
	MaxConveyorCreatures = 8,
	CarryMaxActivationDistance = 9,
	-- Centered in front of the torso so the character holds it with both hands.
	CarryOffset = CFrame.new(0, -0.8, -2.3),
	CreatureIds = { "AngryPotato", "SleepyBlob", "TinyCloud" },
}

return TransportConfig
