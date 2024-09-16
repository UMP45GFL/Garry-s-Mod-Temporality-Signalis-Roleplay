ITEM.name = "Disposable stun prod"
ITEM.description = [[Short-range high-voltage electroshock weapon. Can be used one-handed. Non-lethal weapon that instantly incapacitates the target with arcing electricity.]]

ITEM.model = "models/eternalis/items/weapons/eig2.mdl"
ITEM.class = "kanade_tfa_signalis_stunprod"

ITEM.weaponCategory = "melee"

ITEM.width = 2
ITEM.height = 1

ITEM.weight = 0.9

ITEM.forceRender = false

function ITEM:GetName()
    if self:GetData("usedup", false) then
        return "Used up stun prod"
    end

	return (CLIENT and L(self.name) or self.name)
end

function ITEM:GetDescription()
	return self:GetData("usedup", false)
		and self.description
		or "A disposable stun prod that has been used up. It's no longer functional."
end
