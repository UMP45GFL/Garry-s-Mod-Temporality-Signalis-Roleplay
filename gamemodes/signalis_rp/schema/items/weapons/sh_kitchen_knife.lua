
ITEM.name = "Small kitchen knife"
ITEM.model = Model("models/eternalis/items/weapons/kitchen/small_sharp_knife.mdl")
ITEM.description = "A small, sharp kitchen knife. Perfect for cutting vegetables and meat."
ITEM.skin = 0

ITEM.width = 2
ITEM.height = 1

ITEM.class = "kanade_tfa_signalis_knife"
ITEM.weaponCategory = "melee"

ITEM.weight = 0.2

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
