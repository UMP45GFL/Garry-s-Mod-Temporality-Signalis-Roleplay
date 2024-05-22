
function PLUGIN:HUDPaint()
	local client = LocalPlayer()

	if (ix.option.Get("observerESP", true) and ix.option.Get("lootingESP", true) and client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle() and CAMI.PlayerHasAccess(client, "Helix - Observer", nil)) then
		local scrW, scrH = ScrW(), ScrH()

		for _, v in ipairs(ents.FindByClass("ix_lootent")) do
			if (client:GetAimVector():Dot((v:GetPos() - client:GetPos()):GetNormal()) < 0.65) then continue end

			local screenPosition = v:GetPos():ToScreen()

			local marginX, marginY = scrH * .1, scrH * .1
			local x, y = math.Clamp(screenPosition.x, marginX, scrW - marginX), math.Clamp(screenPosition.y, marginY, scrH - marginY)

			local color = Color(175, 175, 50)
			local distance = client:GetPos():Distance(v:GetPos())
			local factor = 1 - math.Clamp(distance / 1024, 0, 1)
			local size = math.max(10, 32 * factor)
			local alpha = math.max(255 * factor, 80)

			surface.SetDrawColor(color.r, color.g, color.b, alpha)
			surface.SetFont("ixGenericFont")

			local text = "Loot Entity"

			surface.DrawRect(x - size / 2, y - size / 2, size, size)

			surface.SetDrawColor(color.r * 1.6, color.g * 1.6, color.b * 1.6, alpha)

			ix.util.DrawText(text, x, y - size, ColorAlpha(color, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
		end
	end
end

net.Receive("ixPopulateLootentEditor", function(length)
	local entity = net.ReadEntity()
	local lootTable = net.ReadData(length / 8)

	lootTable = util.Decompress(lootTable)

	entity.lootTable = lootTable

	ix.lootEntEditor:Populate(entity)
end)
