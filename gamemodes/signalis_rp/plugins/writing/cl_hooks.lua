
netstream.Hook("ixViewPaper", function(itemID, pages, bEditable)
	bEditable = tobool(bEditable)

	if bEditable then
		local panel = vgui.Create("ixPaperEdit")
		panel.pages = pages
		panel:SetEditable(bEditable)
		panel:SetItemID(itemID)
	else
		local panel = vgui.Create("ixPaperView")
		panel.pages = pages
		panel:SetItemID(itemID)
	end
end)
