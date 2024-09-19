
DeriveGamemode("helix")

local fontSettings = {
	font = "Perfect DOS VGA 437",
	--font = "signapoke",
	extended = true,
	size = ScreenScaleH(13),
	weight = 0,
	antialias = false,
}

fontSettings.size = math.max(ScreenScaleH(13), 14)
surface.CreateFont("SignalisDocumentsFontSmall", fontSettings)

fontSettings.size = math.max(ScreenScaleH(15), 16)
surface.CreateFont("SignalisDocumentsFontMedium", fontSettings)

fontSettings.size = math.max(ScreenScaleH(18), 18)
surface.CreateFont("SignalisDocumentsFontBig", fontSettings)

-- Radio fonts
fontSettings.size = 32
surface.CreateFont("SignalisRadioFontToggle", fontSettings)

fontSettings.size = 22
surface.CreateFont("SignalisRadioReceiver", fontSettings)

fontSettings.size = 46
surface.CreateFont("SignalisRadioFrequency", fontSettings)

fontSettings.size = 54
surface.CreateFont("SignalisRadioButtons", fontSettings)

fontSettings.size = 32
surface.CreateFont("SignalisRadioTranscription", fontSettings)
