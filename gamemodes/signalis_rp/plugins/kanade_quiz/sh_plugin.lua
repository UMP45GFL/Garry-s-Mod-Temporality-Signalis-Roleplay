
PLUGIN.name = "Quiz Module"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds a configurable quiz after a player joins."
PLUGIN.license = [[meow]]

if SERVER then
    include("sv_answers.lua")
    AddCSLuaFile("cl_questions.lua")

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
end

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

    function OpenQuizFailedPanel()
        local quizFailedPopup = vgui.Create("DFrame")
        quizFailedPopup:SetSize(ScrW() / 2, ScrH() / 4)
        quizFailedPopup:SetTitle("")
        quizFailedPopup:SetDraggable(true)
        quizFailedPopup:ShowCloseButton(true)
        quizFailedPopup:SetDeleteOnClose(true)
        quizFailedPopup:MakePopup()
        quizFailedPopup:Center()

        local labelPanel = vgui.Create("DPanel", quizFailedPopup)
        labelPanel:Dock(FILL)
        labelPanel.Paint = function(self, w, h)
            draw.Text({
                text = "You have failed the quiz. Try again.",
                font = "quizFailedFont",
                pos = {w / 2, h / 2},
                color = color_white,
                xalign = TEXT_ALIGN_CENTER,
                yalign = TEXT_ALIGN_CENTER
            })
        end

        surface.PlaySound("eternalis/signalis_ui/no.wav")
    end

    function OpenQuizModule()
        if quizPanel then
            quizPanel:Remove()
        end

        for k,v in pairs(KANADE_QUIZ_QUESTIONS) do
            v.answer = nil
        end

        local submitAvailable = false

        quizPanel = vgui.Create("DFrame")
        quizPanel:SetSize(ScrW(), ScrH())
        quizPanel:SetTitle("Quiz")
        quizPanel:SetDraggable(false)
        quizPanel:ShowCloseButton(false)
        quizPanel:SetDeleteOnClose(true)
        quizPanel:MakePopup()
        quizPanel.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
        end

        local scrollPanel = vgui.Create("DScrollPanel", quizPanel)
        scrollPanel:Dock(FILL)
        scrollPanel:GetCanvas():DockPadding(16, 32, 16, 32)

        local questionPanel = vgui.Create("DPanel", scrollPanel)
        questionPanel:Dock(FILL)
        questionPanel:DockPadding(16, 64, 16, 32)

        for questionNum, questionTable in ipairs(KANADE_QUIZ_QUESTIONS) do
			local questionLabel = vgui.Create("DPanel", questionPanel)
            questionLabel:Dock(TOP)
            questionLabel:DockPadding(4, 4, 4, 8)
            questionLabel:SetHeight(draw.GetFontHeight("quizQuestionFont") + 4)
            questionLabel.Paint = function(self, w, h)
                draw.Text({
                    text = questionNum .. ". " ..  questionTable.question,
                    font = "quizQuestionFont",
                    pos = {w / 2, h / 2},
                    color = color_white,
                    xalign = TEXT_ALIGN_CENTER,
                    yalign = TEXT_ALIGN_CENTER
                })
            end
            scrollPanel:AddItem(questionLabel)

            local options = table.Copy(questionTable.options)
            table.Shuffle(options)

            for i, option in ipairs(options) do
                local optionButtonPanel = vgui.Create("DPanel", questionPanel)
                optionButtonPanel:SetHeight(draw.GetFontHeight("quizOptionFont") + 8)
                optionButtonPanel:Dock(TOP)
                optionButtonPanel:DockPadding(8, 8, 8, 8)
                optionButtonPanel.Paint = function() end

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
                    if questionTable.answer == option then
                        questionTable.answer = nil
                    else
                        questionTable.answer = option
                    end

                    submitAvailable = true
                    for _, qst in pairs(KANADE_QUIZ_QUESTIONS) do
                        if qst.answer == nil then
                            submitAvailable = false
                        end
                    end
                end
                optionButton.Paint = function(self, w, h)
                    if questionTable.answer == option then
                        draw.RoundedBox(4, 0, 0, w, h, Color(255, 0, 0, 100))
                    elseif self:IsHovered() then
                        draw.RoundedBox(4, 0, 0, w, h, Color(35, 35, 35, 150))
                    else
                        draw.RoundedBox(4, 0, 0, w, h, Color(25, 25, 25, 100))
                    end
                end

                scrollPanel:AddItem(optionButtonPanel)
            end

            local space = vgui.Create("DPanel", questionPanel)
            space:Dock(TOP)
            space:SetHeight(80)
            space.Paint = function() end
            scrollPanel:AddItem(space)
        end

        local space = vgui.Create("DPanel", questionPanel)
        space:Dock(TOP)
        space:SetHeight(16)
        space.Paint = function() end
        scrollPanel:AddItem(space)

        local submitButton = vgui.Create("DButton", questionPanel)
        submitButton:SetWidth(ScrW() * 0.6)
        submitButton:SetHeight(draw.GetFontHeight("quizSubmitFont") + 16)
        submitButton:DockPadding(8, 8, 8, 8)
        submitButton:DockMargin(4, 32, 4, 32)
        submitButton:Dock(TOP)
        submitButton:SetText("Submit")
        submitButton:SetFont("quizSubmitFont")
        submitButton:SetTextColor(color_white)

        submitButton.OnCursorEntered = function()
            --surface.PlaySound("Helix.Rollover")
            LocalPlayer():EmitSound("Helix.Rollover")
        end

        submitButton.DoClick = function()
            if not submitAvailable then
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

            quizPanel:Close()
        end
        submitButton.Paint = function(self, w, h)
            if submitAvailable then
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

        local space = vgui.Create("DPanel", questionPanel)
        space:Dock(TOP)
        space:SetHeight(64)
        space.Paint = function() end
        scrollPanel:AddItem(space)
    end

    net.Receive("quizcompleted", function()
        surface.PlaySound("eternalis/signalis_ui/save.wav")
    end)

    net.Receive("openquiz", function()
        OpenQuizModule()
    end)

    net.Receive("openquizfailed", function()
        OpenQuizModule()
        OpenQuizFailedPanel()
    end)
end
