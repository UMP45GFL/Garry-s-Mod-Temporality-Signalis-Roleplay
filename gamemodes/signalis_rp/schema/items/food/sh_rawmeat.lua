
ITEM.name = "Raw meat"
ITEM.model = Model("models/foodnhouseholditems/meat7.mdl")
ITEM.width = 2
ITEM.height = 1
ITEM.description = "A piece of cooked meat. Need to be cooked."
ITEM.category = "Consumables"
ITEM.permit = "consumables"

ITEM.functions.Eat = {
	OnRun = function(itemTable)
		local client = itemTable.player

		if ix.config.Get("hungerThirstSystemEnabled", true) then
			client:AddHunger(-15)
			client:AddThirst(10)
		end

		client:SetHealth( math.Clamp(client:Health() - 6, 0, client:GetMaxHealth()) )

		return true
	end,
}
