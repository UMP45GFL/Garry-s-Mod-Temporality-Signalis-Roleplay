
function BR2_ShouldDrawWeaponInfo()
	if IsValid(cameras_frame) then return false end
	
	local wep = LocalPlayer():GetActiveWeapon()
	if IsValid(wep) then
		if isnumber(wep.lastInfoDraw) then
			if (CurTime() - wep.lastInfoDraw) > 60 then
				return false
			end
		else
			wep.lastInfoDraw = CurTime()
		end
	end
	return true
end

surface.CreateFont("BR2_ItemFont", {
	font = "Tahoma",
	extended = false,
	size = 26,
	weight = 7000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})


mat_progress_bar_1 = Material("breach2/progress_bar_1_2.png")
mat_progress_bar_2 = Material("breach2/progress_bar_2.png")

progress_bar_time = nil
progress_bar_end = nil
function InitiateProgressBar(end_time)
	progress_bar_time = end_time
	progress_bar_end = CurTime() + end_time
end

progress_bar_status = 0
function DrawProgressBar()
	if progress_bar_end and progress_bar_time then
		if progress_bar_end < CurTime() then
			progress_bar_end = nil
			progress_bar_time = nil
			progress_bar_status = 0
			if progress_bar_func != nil then
				progress_bar_func()
			end
			return
		end
		progress_bar_status = (1 - ((progress_bar_end - CurTime()) / progress_bar_time)) * 100
	end
	if progress_bar_status == 0 then return end
	surface.SetDrawColor(Color(255,255,255,255))
	surface.SetMaterial(mat_progress_bar_1)
	surface.DrawTexturedRect(ScrW()/2-158.5, ScrH()/1.3, 317, 34)
	
	surface.SetDrawColor(Color(255,255,255,255))
	surface.SetMaterial(mat_progress_bar_2)
	surface.DrawTexturedRect(ScrW()/2-158.5+7, ScrH()/1.3, 303*(math.Clamp(progress_bar_status, 0, 100)/100), 34)
end

mat_progress = {}
mat_progress["mat_progress_circle_1"] = Material("breach2/progress_circle_1.png")
for i=1, 10 do
	mat_progress["mat_progress_circle_2_"..i..""] = Material("breach2/progress_circle_2_"..i..".png")
end

progress_precision_modifier = 0.5

progress_circle_time = nil
progress_circle_end = nil
progress_circle_color = Color(255,255,255,255)
function InitiateProgressCircle(end_time)
	progress_circle_time = end_time
	progress_circle_end = CurTime() + end_time
end

progress_circle_status = 0
function DrawProgressCircle()
	if progress_circle_end and progress_circle_time then
		if progress_circle_end < CurTime() then
			progress_circle_end = nil
			progress_circle_time = nil
			progress_circle_status = 0
			if progress_circle_func != nil then
				progress_circle_func()
			end
			return
		end
		progress_circle_status = (1 - (((progress_circle_end-progress_precision_modifier) - CurTime()) / progress_circle_time)) * 10
	end
	if progress_circle_status == 0 then return end
	local posx = ScrW()/2
	local posy = ScrH()/2
	local size = 64
	surface.SetDrawColor(progress_circle_color)
	for i=1, math.Clamp(progress_circle_status, 0, 10) do
		surface.SetMaterial(mat_progress["mat_progress_circle_2_"..i..""])
		surface.DrawTexturedRect(posx-(size/2), posy-(size/2), size, size)
	end
end

hook.Add("DrawOverlay", "DrawProgressBarAndCircle", function()
    DrawProgressBar()
    DrawProgressCircle()
end)

print("Loaded cl_progress.lua")
