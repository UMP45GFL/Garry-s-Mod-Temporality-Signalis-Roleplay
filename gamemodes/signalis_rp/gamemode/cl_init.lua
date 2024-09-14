
DeriveGamemode("helix")

local fontSettings = {
	font = "Perfect DOS VGA 437",
	--font = "Pokémon DP Pro",
	extended = true,
	size = ScreenScaleH(15),
	weight = 0,
	antialias = false,
}
surface.CreateFont("SignalisDocumentsFontMedium", fontSettings)

fontSettings.size = ScreenScaleH(18)
surface.CreateFont("SignalisDocumentsFontBig", fontSettings)

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
