
ITEM.name = "Kitchen knife"
ITEM.model = Model("models/eternalis/items/weapons/kitchen/longer_stronger_knife_02.mdl")
ITEM.description = "A rectangular sharp kitchen knife. Perfect for cutting vegetables and meat."
ITEM.skin = 0

ITEM.width = 2
ITEM.height = 1

ITEM.class = "kanade_tfa_signalis_knife_rectangular2"
ITEM.weaponCategory = "melee"

ITEM.weight = 0.3

ITEM.canSlice = true

ITEM.functions.Suicide = {
    icon = "icon16/cross.png",
	OnRun = SuicideItemFunction,
	OnCanRun = CanSuicide
}
