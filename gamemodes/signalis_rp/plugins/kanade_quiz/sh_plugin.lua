
PLUGIN.name = "Quiz Module"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds a configurable quiz after a player joins."
PLUGIN.license = [[meow]]

if SERVER then
    include("sv_answers.lua")
    AddCSLuaFile("cl_questions.lua")
end

ix.config.Add("QuizModuleEnabled", true, "Whether or to enable the quiz module.", nil, {
    category = "Quiz Module"
})

ix.config.Add("QuizModuleBanLength", 120, "Length of the ban after player fails the quiz, 0 is permanent", nil, {
    data = {min = 0, max = 3600},
    category = "Quiz Module"
})

ix.config.Add("QuizModuleFiledAttempts", 3, "How many attempts until a ban", nil, {
    data = {min = 1, max = 10},
    category = "Quiz Module"
})

ix.config.Add("QuizModuleMaxSpentTimeAnswering", 100, "Max time a player can be answering the quiz until ban (in seconds)", nil, {
    data = {min = 1, max = 360},
    category = "Quiz Module"
})

ix.config.Add("QuizModuleMaxNoQuizAfkTime", 200, "Max time a player can be afk not in the quiz (in seconds)", nil, {
    data = {min = 1, max = 360},
    category = "Quiz Module"
})

ix.config.Add("QuizModuleAfkBanTime", 15, "Time in minutes the player gets banned for after being afk in the quiz (in minutes)", nil, {
    data = {min = 1, max = 360},
    category = "Quiz Module"
})

if CLIENT then
    include("cl_questions.lua")

    local quizPanel = nil
    local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

	surface.CreateFont("quizQuestionFont", {
		font = "Roboto",
		size = math.max(ScreenScale(12), 28),
		extended = true,
		weight = 500
	})

	surface.CreateFont("quizOptionFont", {
		font = "Roboto",
		size = math.max(ScreenScale(9), 18),
		extended = false,
		weight = 500
	})

	surface.CreateFont("quizFirstInfoFont", {
		font = "Roboto",
		size = math.max(ScreenScale(9), 18),
		extended = false,
		weight = 500
	})

	surface.CreateFont("quizSubmitFont", {
		font = "Roboto",
		size = math.max(ScreenScale(10), 24),
		extended = false,
		weight = 500
	})

	surface.CreateFont("quizFailedFont", {
		font = "Roboto",
		size = math.max(ScreenScale(11), 26),
		extended = false,
		weight = 500
	})

    if quizFrame then
        quizFrame:Remove()
    end

    local sentNoFocus = 0
    local submitAvailable = false
    local currentQuestion = 0
    local optionList = {}

    local scrollPanel = nil
    local questionPanel = nil
    local leaveButton = nil

    function ShowQuizFailedNotification()
        sentNoFocus = 0
        submitAvailable = false
        currentQuestion = 1
        optionList = {}
        OpenQuizModule()

        local nextDeletePopup = CurTime() + 5

        local quizFailedPopup = vgui.Create("DFrame")
        quizFailedPopup:SetSize(ScrW() / 2, ScrH() / 8)
        quizFailedPopup:SetPos((ScrW() - (ScrW() / 2)) / 2, ScrH() / 9)
        quizFailedPopup:SetTitle("")
        quizFailedPopup:SetDraggable(false)
        quizFailedPopup:ShowCloseButton(false)
        quizFailedPopup:SetDeleteOnClose(true)
        quizFailedPopup:MakePopup()
        quizFailedPopup.Think = function(self)
            if nextDeletePopup < CurTime() then
                self:Remove()
            end
        end
        quizFailedPopup.Paint = function(self, w, h)
        end

        local labelPanel = vgui.Create("DPanel", quizFailedPopup)
        labelPanel:Dock(FILL)
        labelPanel.Paint = function(self, w, h)
            draw.Text({
                text = "You have failed the quiz. Try again.",
                font = "quizFailedFont",
                pos = {w / 2, h / 2 - 20},
                color = Color(255, 0, 0, 255),
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER
            })
            draw.Text({
                text = "The clock is ticking.",
                font = "quizFailedFont",
                pos = {w / 2, h / 2 + 20},
                color = Color(255, 0, 0, 255),
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER
            })
        end

        surface.PlaySound("eternalis/signalis_ui/no.wav")
    end

    function OpenAreYouSureToStartPanel()
        local quizConfirmationFrame = vgui.Create("DFrame")
        quizConfirmationFrame:SetSize(ScrW() / 2, ScrH() / 4)
        quizConfirmationFrame:SetTitle("")
        quizConfirmationFrame:SetDraggable(true)
        quizConfirmationFrame:ShowCloseButton(true)
        quizConfirmationFrame:SetDeleteOnClose(true)
        quizConfirmationFrame:MakePopup()
        quizConfirmationFrame:Center()

        local labelPanel = vgui.Create("DPanel", quizConfirmationFrame)
        labelPanel:Dock(FILL)
        labelPanel.Paint = function(self, w, h)
            draw.Text({
                text = "Are you sure that you want to start the quiz?",
                font = "quizFailedFont",
                pos = {w / 2, h / 2},
                color = color_white,
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER
            })
        end

        local yesButton = vgui.Create("DButton", quizConfirmationFrame)
        yesButton:SetWidth(ScrW() / 4)
        yesButton:SetHeight(draw.GetFontHeight("quizSubmitFont") + 16)
        yesButton:DockPadding(8, 8, 8, 8)
        yesButton:DockMargin(4, 32, 4, 32)
        yesButton:Dock(BOTTOM)
        yesButton:SetText("Yes")
        yesButton:SetFont("quizSubmitFont")
        yesButton:SetTextColor(color_white)
        yesButton.OnCursorEntered = function()
            LocalPlayer():EmitSound("Helix.Rollover")
        end
        yesButton.DoClick = function()
            quizConfirmationFrame:Remove()
            if IsValid(leaveButton) then
                leaveButton:Remove()
            end
            currentQuestion = 1
            generateButtons()
            net.Start("quizstarted")
            net.SendToServer()
        end
        yesButton.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(255, 0, 0, 100))
        end
    end

    function generateButtons()
        for k,v in pairs(optionList) do
            v:Remove()
        end

        local space = vgui.Create("DPanel", questionPanel)
        space:Dock(TOP)
        space:SetHeight(32)
        space.Paint = function() end
        scrollPanel:AddItem(space)
        table.insert(optionList, space)

        if currentQuestion > 0 then
            local options = table.Copy(KANADE_QUIZ_QUESTIONS[currentQuestion].options)
            table.Shuffle(options)

            for i, option in ipairs(options) do
                local optionButtonPanel = vgui.Create("DPanel", questionPanel)
                optionButtonPanel:SetHeight(draw.GetFontHeight("quizOptionFont") + 8)
                optionButtonPanel:Dock(TOP)
                optionButtonPanel:DockPadding(8, 8, 8, 8)
                optionButtonPanel.Paint = function() end
                table.insert(optionList, optionButtonPanel)
    
                local buttonWidth = ScrW() * 0.3
    
                local optionButton = vgui.Create("DButton", optionButtonPanel)
                optionButton:SetText(alphabet[i] .. ") " .. option)
                optionButton:SetFont("quizOptionFont")
                optionButton:SetTextColor(color_white)
                optionButton:SizeToContents()
                optionButton:SetWidth(buttonWidth)
                optionButton:SetPos(ScrW() / 2 - ((buttonWidth) / 2) - 32, 0)
                optionButton.OnCursorEntered = function()
                    --surface.PlaySound("Helix.Rollover")
                    LocalPlayer():EmitSound("Helix.Rollover")
                end
                optionButton.DoClick = function(self)
                    if KANADE_QUIZ_QUESTIONS[currentQuestion].answer == option then
                        KANADE_QUIZ_QUESTIONS[currentQuestion].answer = nil
                        if submitAvailable then
                            submitAvailable = false
                        end
                    else
                        KANADE_QUIZ_QUESTIONS[currentQuestion].answer = option
                    end
                end
                optionButton.Paint = function(self, w, h)
                    if KANADE_QUIZ_QUESTIONS[currentQuestion].answer == option then
                        draw.RoundedBox(4, 0, 0, w, h, Color(255, 0, 0, 100))
                    elseif self:IsHovered() then
                        draw.RoundedBox(4, 0, 0, w, h, Color(35, 35, 35, 150))
                    else
                        draw.RoundedBox(4, 0, 0, w, h, Color(25, 25, 25, 100))
                    end
                end
                table.insert(optionList, optionButton)
    
                scrollPanel:AddItem(optionButtonPanel)
            end
        else
            local fontHeight = draw.GetFontHeight("quizFirstInfoFont") + 6

            local firstInfoPanel = vgui.Create("DPanel", questionPanel)
            firstInfoPanel:SetHeight(300)
            firstInfoPanel:Dock(TOP)
            firstInfoPanel:DockPadding(8, 8, 8, 8)
            firstInfoPanel:SetHeight(300)
            firstInfoPanel.Paint = function(self, w, h)
                --draw.RoundedBox(4, 0, 0, w, h, Color(100, 0, 0, 150))

                for k,v in ipairs(KANADE_QUIZ_FIRSTINFO) do
                    if k > 1 then
                        draw.Text({
                            text = v,
                            font = "quizFirstInfoFont",
                            pos = {w / 2, ((k - 1) * fontHeight)},
                            color = color_white,
                            xalign = TEXT_ALIGN_CENTER,
                            yalign = TEXT_ALIGN_CENTER
                        })
                    end
                end
            end
            table.insert(optionList, firstInfoPanel)
            scrollPanel:AddItem(firstInfoPanel)
        end
        
        local space = vgui.Create("DPanel", questionPanel)
        space:Dock(TOP)
        space:SetHeight(64)
        space.Paint = function() end
        scrollPanel:AddItem(space)
        table.insert(optionList, space)

        local submitButton = vgui.Create("DButton", questionPanel)
        submitButton:SetWidth(ScrW() * 0.6)
        submitButton:SetHeight(draw.GetFontHeight("quizSubmitFont") + 16)
        submitButton:DockPadding(8, 8, 8, 8)
        submitButton:DockMargin(4, 32, 4, 32)
        submitButton:Dock(TOP)
        submitButton:SetText("Start the quiz!")
        submitButton:SetFont("quizSubmitFont")
        submitButton:SetTextColor(color_white)
        submitButton.OnCursorEntered = function()
            LocalPlayer():EmitSound("Helix.Rollover")
        end
        submitButton.Think = function(self)
            if currentQuestion > 0 then
                if submitAvailable != true then
                    if self:GetText() != "Next" then
                        self:SetText("Next")
                    end
                    submitAvailable = true
                    for _, questionTable in ipairs(KANADE_QUIZ_QUESTIONS) do
                        if questionTable.answer == nil then
                            submitAvailable = false
                            break
                        end
                    end
    
                elseif self:GetText() != "Submit" then
                    self:SetText("Submit")
                end
            end
        end
        submitButton.DoClick = function()
            if currentQuestion == 0 then
                OpenAreYouSureToStartPanel()
                return
            end

            if not submitAvailable then
                if currentQuestion < #KANADE_QUIZ_QUESTIONS and KANADE_QUIZ_QUESTIONS[currentQuestion].answer then
                    currentQuestion = currentQuestion + 1
                    generateButtons()
                end
                return
            end

            local answers = {}

            for _, questionTable in ipairs(KANADE_QUIZ_QUESTIONS) do
                if questionTable.answer == nil then
                    return
                end
                table.insert(answers, {
                    question = questionTable.question,
                    answer = questionTable.answer
                })
            end

            net.Start("quizsubmit")
            net.WriteTable(answers)
            net.SendToServer()
        end
        submitButton.Paint = function(self, w, h)
            if currentQuestion == 0 or submitAvailable or KANADE_QUIZ_QUESTIONS[currentQuestion].answer then
                if self:IsHovered() then
                    draw.RoundedBox(4, 0, 0, w, h, Color(255, 0, 0, 150))
                else
                    draw.RoundedBox(4, 0, 0, w, h, Color(245, 0, 0, 100))
                end
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(25, 25, 25, 100))
            end
        end
        scrollPanel:AddItem(submitButton)
        table.insert(optionList, submitButton)

        if currentQuestion == 0 then
            leaveButton = vgui.Create("DButton", questionPanel)
            leaveButton:SetWidth(ScrW() * 0.6)
            leaveButton:SetHeight(draw.GetFontHeight("quizSubmitFont") + 16)
            leaveButton:DockPadding(8, 8, 8, 8)
            leaveButton:DockMargin(4, 32, 4, 32)
            leaveButton:Dock(TOP)
            leaveButton:SetText("Leave")
            leaveButton:SetFont("quizSubmitFont")
            leaveButton:SetTextColor(color_white)
            leaveButton.OnCursorEntered = function()
                LocalPlayer():EmitSound("Helix.Rollover")
            end
            leaveButton.DoClick = function()
                RunConsoleCommand("disconnect")
            end
            scrollPanel:AddItem(leaveButton)
            table.insert(optionList, leaveButton)
        end
    end

    local startedDoingSomething = false
    local lastMouseX = nil
    local lastMouseY = nil

    function OpenQuizModule()
        if quizFrame then
            quizFrame:Remove()
        end

        for k,v in pairs(KANADE_QUIZ_QUESTIONS) do
            v.answer = nil
        end

        quizFrame = vgui.Create("DFrame")
        quizFrame:SetSize(ScrW(), ScrH())
        quizFrame:SetTitle("")
        quizFrame:SetDraggable(false)
        quizFrame:ShowCloseButton(false)
        quizFrame:SetDeleteOnClose(true)
        quizFrame:MakePopup()
        quizFrame.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
        end

        hook.Add("Tick", "QuizModule_Tick", function(ply, text)
            if !IsValid(quizFrame) then
                hook.Remove("Tick", "QuizModule_Tick")
                return
            end

            if !startedDoingSomething and system.UpTime() > 1 then
                if lastMouseX == nil then
                    lastMouseX = gui.MouseX()
                elseif lastMouseX != gui.MouseX() then
                    lastMouseX = gui.MouseX()
                    print("client started doing something")
                    startedDoingSomething = true
                    net.Start("startedbeingactive")
                    net.SendToServer()
                end
            end

            if currentQuestion > 0 and not system.HasFocus() and sentNoFocus == 0 then
                sentNoFocus = 1
                net.Start("quiznofocus")
                net.SendToServer()
            end

            if !quizFrame:HasFocus() then
                quizFrame:RequestFocus()
            end
        end)

        local quizPanel = vgui.Create("DPanel", quizFrame)
        quizPanel:SetPos(0, ScrH() / 3)
        quizPanel:SetSize(ScrW(), ScrH() / 2)

        scrollPanel = vgui.Create("DScrollPanel", quizPanel)
        scrollPanel:Dock(FILL)
        scrollPanel:GetCanvas():DockPadding(16, 32, 16, 32)

        questionPanel = vgui.Create("DPanel", scrollPanel)
        questionPanel:Dock(FILL)
        questionPanel:DockPadding(16, 64, 16, 32)

        local questionLabel = vgui.Create("DPanel", questionPanel)
        questionLabel:Dock(TOP)
        questionLabel:DockPadding(4, 4, 4, 8)
        questionLabel:SetHeight(draw.GetFontHeight("quizQuestionFont") + 4)
        questionLabel.Paint = function(self, w, h)
            local txt = KANADE_QUIZ_FIRSTINFO[1]
            if currentQuestion > 0 then
                txt = currentQuestion .. ". " ..  KANADE_QUIZ_QUESTIONS[currentQuestion].question
            end
            draw.Text({
                text = txt,
                font = "quizQuestionFont",
                pos = {w / 2, h / 2},
                color = color_white,
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER
            })
        end
        scrollPanel:AddItem(questionLabel)

        generateButtons()
    end

    net.Receive("quizcompleted", function()
        if quizFrame then
            quizFrame:Remove()
        end
        surface.PlaySound("eternalis/signalis_ui/save.wav")
    end)

    net.Receive("openquiz", function()
        OpenQuizModule()
    end)

    net.Receive("openquizfailed", function()
        ShowQuizFailedNotification()
    end)
end
