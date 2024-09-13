
ITEM.name = "Kitchen knife"
ITEM.model = Model("models/eternalis/items/weapons/kitchen/small_sharp_knife.mdl")
ITEM.description = "A small, sharp kitchen knife. Perfect for cutting vegetables and meat."
ITEM.skin = 0

ITEM.width = 2
ITEM.height = 1

ITEM.canSlice = true

ITEM.functions.Suicide = {
    icon = "icon16/cross.png",
	OnRun = SuicideItemFunction,
	OnCanRun = CanSuicide
}
