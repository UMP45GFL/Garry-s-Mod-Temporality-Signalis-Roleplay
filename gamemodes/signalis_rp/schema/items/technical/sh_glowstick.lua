
ITEM.name = "Glowstick"
ITEM.model = Model("models/eternalis/items/technical/glowstick.mdl")
ITEM.description = "A small, disposable light source that can be activated by bending the stick."
ITEM.skin = 0

local glowstickLife = 3600
glowstickLife = 30

-- Inventory drawing
if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if item:GetData("activated") then
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

ITEM.functions.Activate = {
	name = "Activate",
	tip = "activateTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		item:SetData("activated", true)
		item:SetData("stopIn", CurTime() + glowstickLife)
		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and IsValid(item.player) and item:GetData("activated") != true and item:GetData("usedup", false) != true
	end
}

if CLIENT then
    hook.Add("Think", "GlowstickLights", function()
        for _, entity in ipairs(ents.FindByClass("ix_item")) do
            local itemTable = entity:GetItemTable()
            if entity.GetItemTable and entity:GetData("activated") then
                if itemTable.uniqueID == "glowstick" then
                    local dist = LocalPlayer():GetPos():Distance(entity:GetPos())
                    local dlight = DynamicLight(entity:EntIndex())

                    local lifeTimePerc = (entity:GetData("stopIn") - CurTime()) / glowstickLife
                    local size = (220 - (dist / 9)) * lifeTimePerc

                    if dlight then
                        dlight.pos = entity:GetPos()
                        dlight.r = 255
                        dlight.g = 255
                        dlight.b = 255
                        dlight.brightness = 3
                        dlight.decay = 1000
                        dlight.size = 220 - (dist / 9)
                        dlight.dietime = CurTime() + 1
                    end
                end
            end
        end
    end)
else
    timer.Create("GlowstickChecks", 1, 0, function()
        for _, entity in ipairs(ents.FindByClass("ix_item")) do
            if entity.GetItemTable and entity:GetData("activated") then
                local itemTable = entity:GetItemTable()
                if itemTable.uniqueID == "glowstick" and entity:GetData("stopIn",  0) < CurTime() then
                    entity:SetData("activated", false)
                    entity:SetData("usedup", false)
                end
            end
        end
    end)
end
