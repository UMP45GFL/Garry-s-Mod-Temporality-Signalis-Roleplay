
ITEM.name = "Small kitchen chopper"
ITEM.model = Model("models/eternalis/items/weapons/kitchen/chopper_smaller.mdl")
ITEM.description = "A sharp kitchen chopper. Perfect for cutting vegetables and meat."
ITEM.skin = 0

ITEM.width = 2
ITEM.height = 1

ITEM.class = "kanade_tfa_signalis_chopper"
ITEM.weaponCategory = "melee"

ITEM.weight = 0.3

ITEM.canSlice = true

ITEM.functions.Suicide = {
    icon = "icon16/cross.png",
	OnRun = SuicideItemFunction,
	OnCanRun = CanSuicide
}
