-- Catálogo visual de Zona 1 - Pradera.
-- Estética: meme 3D absurda, colores saturados, ojos expresivos y siluetas claras.

export type CreatureDesign = {
	id: string,
	rarity: string,
	palette: Color3,
	archetype: string,
	feature: string,
}

local Catalog: {CreatureDesign} = {
	{ id = "AngryPotato", rarity = "Common", palette = Color3.fromRGB(214, 155, 67), archetype = "round", feature = "cejas enfadadas y hojas de patata" },
	{ id = "SleepyBlob", rarity = "Common", palette = Color3.fromRGB(107, 190, 220), archetype = "round", feature = "ojos dormidos, orejas blandas y burbuja Zzz" },
	{ id = "TinyCloud", rarity = "Common", palette = Color3.fromRGB(238, 247, 255), archetype = "cloud", feature = "cuatro bultos de nube y una chispa flotante" },
	{ id = "WobbleWorm", rarity = "Common", palette = Color3.fromRGB(202, 94, 164), archetype = "worm", feature = "cuerpo segmentado y antenas torcidas" },
	{ id = "BubbleBug", rarity = "Common", palette = Color3.fromRGB(101, 219, 190), archetype = "bug", feature = "caparazón transparente con burbujas" },
	{ id = "ToastyToad", rarity = "Common", palette = Color3.fromRGB(217, 137, 73), archetype = "round", feature = "pan tostado en la espalda y lengua larga" },
	{ id = "MiniMushroom", rarity = "Common", palette = Color3.fromRGB(235, 85, 91), archetype = "mushroom", feature = "sombrero rojo gigante con lunares crema" },
	{ id = "DustBunny", rarity = "Common", palette = Color3.fromRGB(184, 164, 142), archetype = "round", feature = "orejas enormes y remolino de polvo" },
	{ id = "ButtonBat", rarity = "Common", palette = Color3.fromRGB(112, 92, 184), archetype = "bat", feature = "alas de botón y ojos de costura" },
	{ id = "JellyBean", rarity = "Common", palette = Color3.fromRGB(255, 116, 153), archetype = "round", feature = "brillo de gelatina y envoltorio arrugado" },
	{ id = "TrashGoblin", rarity = "Uncommon", palette = Color3.fromRGB(104, 145, 107), archetype = "goblin", feature = "cubo de basura como casco y sonrisa traviesa" },
	{ id = "CactusCrab", rarity = "Uncommon", palette = Color3.fromRGB(81, 181, 111), archetype = "crab", feature = "pinzas cactus con espinas suaves" },
	{ id = "FrostyFrog", rarity = "Uncommon", palette = Color3.fromRGB(141, 220, 232), archetype = "round", feature = "corona de hielo y mejillas congeladas" },
	{ id = "RoboChick", rarity = "Uncommon", palette = Color3.fromRGB(242, 193, 65), archetype = "robot", feature = "placas metálicas, antena y ojo LED" },
	{ id = "ThunderPuff", rarity = "Uncommon", palette = Color3.fromRGB(172, 137, 239), archetype = "cloud", feature = "nube morada con rayos amarillos" },
	{ id = "SewerSlime", rarity = "Rare", palette = Color3.fromRGB(99, 193, 94), archetype = "slime", feature = "charco viscoso con burbujas tóxicas" },
	{ id = "NeonBat", rarity = "Rare", palette = Color3.fromRGB(42, 239, 205), archetype = "bat", feature = "alas neón y gafas luminosas" },
	{ id = "CrystalCroc", rarity = "Rare", palette = Color3.fromRGB(92, 177, 236), archetype = "croc", feature = "dientes de cristal y lomo facetado" },
	{ id = "LavaDuck", rarity = "Epic", palette = Color3.fromRGB(246, 82, 43), archetype = "duck", feature = "grietas de lava y pico incandescente" },
	{ id = "ShadowMecha", rarity = "Epic", palette = Color3.fromRGB(68, 73, 109), archetype = "robot", feature = "armadura oscura, visor rojo y reactor" },
	{ id = "DumpsterKing", rarity = "Legendary", palette = Color3.fromRGB(249, 188, 62), archetype = "goblin", feature = "trono de contenedor, corona torcida y aura dorada" },
}

local byId: {[string]: CreatureDesign} = {}
for _, design in ipairs(Catalog) do
	byId[design.id] = design
end

return {
	All = Catalog,
	Get = function(id: string): CreatureDesign
		local design = byId[id]
		assert(design, "Unknown Zone 1 creature: " .. id)
		return design
	end,
}
