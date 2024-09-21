
ITEM.name = "Long kitchen knife"
ITEM.model = Model("models/eternalis/items/weapons/kitchen/longer_sharper_knife.mdl")
ITEM.description = "A long, sharp kitchen knife. Perfect for cutting vegetables and meat."
ITEM.skin = 0

ITEM.width = 2
ITEM.height = 1

ITEM.class = "kanade_tfa_signalis_knife_long"
ITEM.weaponCategory = "melee"

ITEM.weight = 0.3

ITEM.canSlice = true

ITEM.functions.Suicide = {
    icon = "icon16/cross.png",
	OnClick = function(item)
		PromptSuicide(item)
		return false
	end,
	--OnRun = SuicideItemFunction,
	OnCanRun = CanSuicide
}
