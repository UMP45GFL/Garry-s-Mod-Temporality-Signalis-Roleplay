
include("shared.lua")

function ENT:OnPopulateEntityInfo(tooltip)
	local title = tooltip:AddRow("name")
	title:SetImportant()
	title:SetText(self:GetToolDisplayAttribute().displayName)
	title:SetBackgroundColor(ix.config.Get("color"))
	title:SizeToContents()

	local description = tooltip:AddRow("description")
	description:SetText(self:GetDescAttribute().description)
	description:SizeToContents()
end
