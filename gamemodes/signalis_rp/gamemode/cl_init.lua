
DeriveGamemode("helix")

local fontSettings = {
	font = "Perfect DOS VGA 437",
	--font = "Pokémon DP Pro",
	extended = true,
	size = 32,
	weight = 0,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
}
surface.CreateFont("SignalisDocumentsFontMedium", fontSettings)
fontSettings.size = 38
surface.CreateFont("SignalisDocumentsFontBig", fontSettings)

fontSettings.size = 32
surface.CreateFont("SignalisRadioFontToggle", fontSettings)

fontSettings.size = 22
surface.CreateFont("SignalisRadioReceiver", fontSettings)

fontSettings.size = 44
surface.CreateFont("SignalisRadioFrequency", fontSettings)

fontSettings.size = 32
surface.CreateFont("SignalisRadioTranscription", fontSettings)
