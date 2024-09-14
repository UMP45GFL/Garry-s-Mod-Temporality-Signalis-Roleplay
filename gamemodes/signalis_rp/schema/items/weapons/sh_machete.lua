
ITEM.name = "Machete"
ITEM.model = Model("models/eternalis/items/weapons/machete.mdl")
ITEM.description = "A machete. It's sharp and can be used to cut things."
ITEM.skin = 0

ITEM.width = 2
ITEM.height = 1

ITEM.class = "kanade_tfa_signalis_machete"
ITEM.weaponCategory = "melee"

ITEM.weight = 0.3

ITEM.canSlice = true

ITEM.functions.Suicide = {
    icon = "icon16/cross.png",
	OnRun = SuicideItemFunction,
	OnCanRun = CanSuicide
}
