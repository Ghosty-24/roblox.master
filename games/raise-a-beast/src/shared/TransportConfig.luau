local TransportConfig = {
	ConveyorFolderName = "ConveyorZone",
	CreatureFolderName = "ConveyorCreatures",
	RemoteFolderName = "RaiseABeastRemotes",
	FeedbackRemoteName = "CaptureFeedback",
	SpawnPosition = Vector3.new(-81, 1.2, -8),
	EndPosition = Vector3.new(81, 1.2, -8),
	TravelSeconds = 20,
	SpawnIntervalSeconds = 5,
	InitialCreatureCount = 4,
	MaxConveyorCreatures = 5,
	CarryMaxActivationDistance = 9,
	-- Centered in front of the torso so the character holds it with both hands.
	CarryOffset = CFrame.new(0, -0.8, -2.3),
	CreatureIds = { "AngryPotato", "SleepyBlob", "TinyCloud" },
}

return TransportConfig
