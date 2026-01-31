
netstream.Hook("ixViewPaper", function(maxPages, startFromPage0, backgroundPhoto, itemID, pages, bEditable)
	bEditable = tobool(bEditable)

	if bEditable then
		local panel = vgui.Create("ixPaperEdit")
		panel:SetPages(pages)
		panel.maxPages = maxPages
		panel.startFromPage0 = startFromPage0
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

netstream.Hook("ixEditTitlePaper", function(itemID)
	local panel = vgui.Create("ixPaperEditTitle")
	panel:SetItemID(itemID)
end)

netstream.Hook("ixEditTitleUrn", function(itemID)
	local panel = vgui.Create("ixUrnEditTitle")
	panel:SetItemID(itemID)
end)


netstream.Hook("ixGenericItemEdit", function(itemID, dataType, maxLength)
	local panel = vgui.Create("ixGenericEdit")
	panel.itemID = itemID
	panel.dataType = dataType
	panel.maxLength = maxLength
	panel:AfterInit()
end)
