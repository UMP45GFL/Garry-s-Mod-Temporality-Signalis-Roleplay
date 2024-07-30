
ITEM.name = "Medical Base"
ITEM.model = "models/eternalis/items/medical/bandage.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Medical"
ITEM.description = "Base medical item"

ITEM.addHealth = 50
ITEM.applySound = "items/medshot4.wav"

ITEM.functions.Apply = {
	OnRun = function(itemTable)
		local addHealth = itemTable:GetData("addHealth", itemTable.addHealth)
		local applySound = itemTable:GetData("applySound", itemTable.applySound)

		local client = itemTable.player

		if applySound then
			client:EmitSound(applySound)
		end

		client:SetHealth(math.min(client:Health() + addHealth, 100))
	end
}
