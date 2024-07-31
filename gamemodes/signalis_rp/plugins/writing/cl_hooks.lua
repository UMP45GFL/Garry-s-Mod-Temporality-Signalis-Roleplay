
netstream.Hook("ixViewPaper", function(maxPages, startFromPage0, backgroundPhoto, itemID, pages, bEditable)
	bEditable = tobool(bEditable)

	if bEditable then
		local panel = vgui.Create("ixPaperEdit")
		panel.pages = pages
		panel.maxPages = maxPages
		panel.startFromPage0 = startFromPage0
		if backgroundPhoto then
			panel.img_bg:SetImage(backgroundPhoto)
		end
		panel:SetEditable(bEditable)
		panel:SetItemID(itemID)
	else
		local panel = vgui.Create("ixPaperView")
		panel.pages = pages
		panel.maxPages = maxPages
		panel.startFromPage0 = startFromPage0
		if backgroundPhoto then
			panel.img_bg:SetImage(backgroundPhoto)
		end
		panel:SetItemID(itemID)
	end
end)
