
PLUGIN.name = "Pixelation effect"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds a pixelation effect to the screen"
PLUGIN.license = [[meow]]

ix.lang.AddTable("english", {
	pixelationEffectEnable = "Enable pixelation effect",
})

ix.config.Add("pixelationEffectEnable", true, "Whether or to enable the pixelation effect", nil, {
	category = "Visual Effects"
})

ix.config.Add("pixelationEffectPixelSize", 2, "Changes the size of pixels in the pixelation effect", nil, {
	data = {min = 1, max = 16},
	category = "Visual Effects"
})

-- Define the post process table
local post_process = {
	Materials = {
		RT = nil,
		Mat = nil
	},
	Wait = 0
}

-- Function to rebuild materials
post_process.RebuildMaterials = function()
	if post_process.Wait > SysTime() then return end
	local w, h = ScrW(), ScrH()

	post_process.Materials.RT = GetRenderTarget("pixelation_rt", w, h, RT_SIZE_NO_CHANGE, MATERIAL_RT_DEPTH_SEPARATE, 1, 0, IMAGE_FORMAT_BGRA8888)
	post_process.Materials.Mat = CreateMaterial("pixelation_material", "UnlitGeneric", {
		["$basetexture"] = post_process.Materials.RT:GetName()
	})
	post_process.Materials.Mat:SetInt("$flags", bit.bor(post_process.Materials.Mat:GetInt("$flags"), 32768))
	post_process.Wait = SysTime() + 1 
end

-- Function to draw the pixelation effect
post_process.Draw = function()
	local mat, rt = post_process.Materials.Mat, post_process.Materials.RT
	
	if not mat or not rt then return post_process.RebuildMaterials() end

	local pixelLevel = ix.config.Get("pixelationEffectPixelSize", 2)  -- Fixed pixelation level
	local w, h = ScrW(), ScrH()

	if pixelLevel < 2 then return end

	render.CopyRenderTargetToTexture(render.GetScreenEffectTexture())

	local wDiv, hDiv = math.ceil(w / pixelLevel), math.ceil(h / pixelLevel)
	render.PushRenderTarget(post_process.Materials.RT, 0, 0, wDiv, hDiv)
		render.DrawTextureToScreenRect(render.GetScreenEffectTexture(), 0, 0, wDiv, hDiv)
	render.PopRenderTarget()

	surface.SetDrawColor(255, 255, 255)
	surface.SetMaterial(post_process.Materials.Mat)

	render.PushFilterMag(1)
		surface.DrawTexturedRect(0, 0, math.ceil(w * pixelLevel), math.ceil(h * pixelLevel))
	render.PopFilterMag()
end

function PLUGIN:RenderScreenspaceEffects()
    if ix.config.Get("pixelationEffectEnable", true) then
        post_process.Draw()
    end
end

-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=2874593084&searchtext=pixel
-- Creator: https://steamcommunity.com/id/NotSoKodya
