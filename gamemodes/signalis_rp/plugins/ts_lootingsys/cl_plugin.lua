
ix.option.Add("lootingESP", ix.type.bool, true, {
	category = "observer",
	hidden = function()
		return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Observer", nil)
	end
})

ix.lang.AddTable("english", {
	optLootingESP = "Show Loot Entity ESP",
	optdLootingESP = "Shows the locations of all loot entities in the server."
})
