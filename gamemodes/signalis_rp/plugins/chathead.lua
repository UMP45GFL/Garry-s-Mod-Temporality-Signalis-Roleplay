local PLUGIN = PLUGIN

PLUGIN.name = "Chathead"
PLUGIN.author = "Project Revival"

ix.lang.AddTable("english", {
	optChatHeadsEnabled = "Enable chat heads",
})

if CLIENT then
	ix.option.Add("chatHeadsEnabled", ix.type.bool, true, {
		category = "Visual Effects"
	})

	surface.CreateFont("prChatFont", {
		font = altFont and "Roboto" or "Khand Regular",
		size =  altFont and (math.max(ScreenScale(7), 17) * ix.option.Get("chatFontScale", 1)) or math.max(ScreenScale(11), 32) * ix.option.Get("chatFontScale", 1),
		extended = true,
		weight = altFont and 600 or 100,
		antialias = true
	})	

	function PLUGIN:MessageReceived(client, info)
		local flexBones = {
			"jaw_drop",
			"left_part",
			"right_part",
			"left_mouth_drop",
			"right_mouth_drop",
			"lower_lip",
			"right_stretcher",
			"left_stretcher",
			"right_funneler",
			"left_funneler",
			"right_puckerer",
			"left_puckerer",
			"bite"
		}

		local hasAllBones = true

		for k, v in ipairs(flexBones) do
			if client:GetFlexIDByName(v) == nil then 
				hasAllBones = false
				break 
			end
		end

		if info.chatType == "ic" or info.chatType == "y" or info.chatType == "w" or info.chatType == "radio_eavesdrop" or info.chatType == "radio" then
			--if client == LocalPlayer() or !(ix.option.Get("chatHeadsEnabled", true)) or client:GetNoDraw() then return end
			if !(ix.option.Get("chatHeadsEnabled", true)) or client:GetNoDraw() then return end

			local typeClass = ix.chat.classes[info.chatType]
			local font = typeClass.font or "prChatFont"
			local lines = ix.util.WrapText(info.text, 500, font)

			client.TotalMsgLines = lines
			client.LastMessageTime = CurTime()

			client.CurrentMsgColor = type(typeClass) == "table" and (typeClass.GetColor and typeClass:GetColor(client, info.text) or typeClass.color) or ix.config.Get("chatColor")
			client.CurrentMsgFont = font

			local totalTime = 0

			if #client.TotalMsgLines > 3 then
				totalTime = ((#client.TotalMsgLines - #client.TotalMsgLines%3)/3)*10
				totalTime = totalTime + math.floor(math.Clamp(#table.concat(client.TotalMsgLines, "", #client.TotalMsgLines - 3)*0.1, 3, 10))
			else
				totalTime = math.floor(math.Clamp(#table.concat(client.TotalMsgLines, "")*0.1, 3, 10))
			end

			client.CurrentMsgLines = {}


			client.CurrentMsgDistance = type(typeClass.CanHear) != "function" and typeClass.CanHear or ix.config.Get("chatRange") 

			local time = client.LastMessageTime
		
			timer.Remove("MessageDisplayCycles")
			if #client.CurrentMsgLines > 3 then 
				timer.Create("MessageDisplayCycles", 10, math.ceil(#lines/3), function()
					if client.LastMessageTime != time then timer.Remove("MessageDisplayCycles") return end 
					client.CurrentMsgLines = {}
					if timer.RepsLeft("MessageDisplayCycles") == 0 then
						client.CurrentMsgLines = client.TotalMsgLines
						timer.Simple(math.floor(math.Clamp(#table.concat(client.TotalMsgLines, "")*0.1, 3, 10)), function()
							if client.LastMessageTime == time and IsValid(client) then 
								client.CurrentMsgLines = nil
							end
						end)

						client.CurrentMsgLines[1] = table.remove(client.TotalMsgLines, 1)
						client.CurrentMsgLines[2] = table.remove(client.TotalMsgLines, 1)
						client.CurrentMsgLines[3] = table.remove(client.TotalMsgLines, 1)
					else
						client.CurrentMsgLines[1] = table.remove(client.TotalMsgLines, 1)
						client.CurrentMsgLines[2] = table.remove(client.TotalMsgLines, 1)
						client.CurrentMsgLines[3] = table.remove(client.TotalMsgLines, 1)
					end
				end)
			else
				timer.Simple(math.floor(math.Clamp(#table.concat(client.TotalMsgLines, "")*0.1, 3, 10)), function()
					if client.LastMessageTime == time and IsValid(client) then 
						client.CurrentMsgLines = nil
					end
				end)
				client.CurrentMsgLines[1] = table.remove(client.TotalMsgLines, 1)
				client.CurrentMsgLines[2] = table.remove(client.TotalMsgLines, 1)
				client.CurrentMsgLines[3] = table.remove(client.TotalMsgLines, 1)

			end

			/*
			local numCycles = totalTime + math.random(5, 10)
			local closeTimes = {}

			for i=1, numCycles do
				closeTimes[i] = (totalTime/numCycles)*i

			end
			
			for i=1, numCycles - 1 do
				local negative = (math.random(2) == 2) and i != 1
				local offset = (totalTime/numCycles)*math.Rand(0, 0.2)
				closeTimes[i] = closeTimes[i] + (negative and offset*-1 or offset)
				
			end

			for i = 1, numCycles do
				closeTimes[i] = closeTimes[i] + client.LastMessageTime 
			end
			*/

			client.MsgCloseTimes = closeTimes
		end
	end

	function PLUGIN:HUDPaint()
		local localPlayer =  LocalPlayer()

		if (localPlayer:Team() == FACTION_STAFF and ix.option.Get("drawCinematicOverlays", true)) or !(ix.option.Get("chatHeadsEnabled", true)) then return end

		if localPlayer:GetNetVar("ShowBlackScreen", false) then
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawRect(0, 0, ScrW(), ScrH())
		end

		local topText = localPlayer:GetNetVar("TopText", false)

		if topText then
			draw.SimpleText(topText, "ixSubTitleFont", ScrW()/2, ScrH() /4, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		if localPlayer:GetNetVar("ScreenText", nil) then
			draw.SimpleText(localPlayer:GetNetVar("ScreenText"), "ixTitleFont", ScrW()/2, ScrH()/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if localPlayer:GetNetVar("CenterSubtitle", nil) then
			draw.SimpleText(localPlayer:GetNetVar("CenterSubtitle"), "ixSubTitleFont", ScrW()/2, ScrH()/2 + 35, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end

		if localPlayer:GetNetVar("DrawLoading", false) then
			draw.SimpleText("Loading...", "ixSubTitleFont", ScrW()/2, ScrH() - 200, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		local client = LocalPlayer()
		local char = client:GetCharacter()
		if !IsValid(localPlayer) then return end

		for num, ply in ipairs(player.GetAll()) do 
			if ply == client then continue end

			if ply.CurrentMsgLines then
				local maxDist = ix.config.Get("chatRange")
				local distance = client:GetPos():Distance(ply:GetPos())

				if distance <= ply.CurrentMsgDistance then
					local drawPos = ply:GetPos()
					local bone = ply:LookupBone("ValveBiped.Bip01_Head1")
					
					if (bone) then
						drawPos = ply:GetBonePosition(bone)
						drawPos.z = drawPos.z + 10
					else
						local bottomBound, topBound = ply:GetModelBounds()

						drawPos.z = drawPos.z + topBound.z - bottomBound.z
					end

					local screenPosition = (drawPos):ToScreen()
					local x, y = screenPosition.x, screenPosition.y

					local drawColor = ply.CurrentMsgColor
					local outlineColor = color_black
					drawColor.a = 255*(1 - (distance/ply.CurrentMsgDistance))
					outlineColor.a = drawColor.a

					--draw.SimpleTextOutlined(ply.LastMessage, "ixChatFont", x, y, ix.config.Get("chatColor"), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
					for k, text in ipairs(ply.CurrentMsgLines) do
						draw.SimpleTextOutlined(text, ply.CurrentMsgFont, x, y - #ply.CurrentMsgLines*22 + (k)*28, drawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, outlineColor)
					end
				end
			end
		end
	end
end
