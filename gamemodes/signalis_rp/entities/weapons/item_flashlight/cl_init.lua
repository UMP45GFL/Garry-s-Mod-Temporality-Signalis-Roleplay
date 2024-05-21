
include("shared.lua")

function SWEP:CalcViewModelView(ent, oldPos, oldAng, pos, ang)
	local pjs = LocalPlayer():GetNWEntity("FL_Flashlight")
	if IsValid(pjs) then
		local bid = LocalPlayer():GetViewModel():LookupAttachment("light")
		local bp = LocalPlayer():GetViewModel():GetAttachment(bid)
		local ang = bp.Ang
		local pos = bp.Pos
		--ba:RotateAroundAxis(ba:Up(), -90)
		pjs:SetPos(pos +ang:Forward() * -5)
		pjs:SetAngles(ang)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
end

function SWEP:Holster()
	self:rremove()
	return (self.NextCanDrop < CurTime() and progress_circle_status == 0)
end

function SWEP:OpenMenu()
	if !IsValid(replacing_battery_frame) then
		local w = 344
		local h = 80
		replacing_battery_frame = vgui.Create("DFrame")
		replacing_battery_frame:SetDeleteOnClose(true)
		replacing_battery_frame:SetSizable(false)
		replacing_battery_frame:SetDraggable(false)
		replacing_battery_frame:SetTitle("")
		replacing_battery_frame:ShowCloseButton(true)
		replacing_battery_frame:MakePopup()
		replacing_battery_frame:SetSize(w, h)
		replacing_battery_frame:SetPos(ScrW()/2-w/2,ScrH()/2-h/2)
		replacing_battery_frame.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
			draw.Text({
				text = "Replace the batteries?",
				pos = {8,4},
				xalign = TEXT_ALIGN_LEFT,
				yalign = TEXT_ALIGN_TOP,
				font = "BR_NVG_SETTINGS_1",
				color = Color(255,255,255,200),
			})

			if input.IsKeyDown(KEY_ESCAPE) then
				gui.HideGameUI()
				self:Close()
				gui.HideGameUI()
			end
		end

		local bw = (w/2)-12
		local bh = (h/2.5)
		local button_accept = vgui.Create("DButton", replacing_battery_frame)
		button_accept:SetSize(bw, bh)
		button_accept:SetPos(8, h-bh-8)
		button_accept:SetText("")
		button_accept.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 150))
			draw.Text({
				text = "YES",
				pos = {w/2,h/2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_NVG_SETTINGS_1",
				color = Color(0,0,0,200),
			})
		end
		button_accept.DoClick = function(self, w, h)
			net.Start("ap_replace_wep_battery_2")
			net.SendToServer()
			replacing_battery_frame:Remove()
		end

		local button_deny = vgui.Create("DButton", replacing_battery_frame)
		button_deny:SetSize(bw, bh)
		button_deny:SetPos(w-bw-8, h-bh-8)
		button_deny:SetText("")
		button_deny.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 150))
			draw.Text({
				text = "NO",
				pos = {w/2,h/2},
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
				font = "BR_NVG_SETTINGS_1",
				color = Color(0,0,0,200),
			})
		end
		button_deny.DoClick = function(self, w, h)
			replacing_battery_frame:Remove()
		end
	end
end

function SWEP:Reload()
	if progress_circle_status > 0 or self.BatteryLevel > 80 or !self:KeyPressed(IN_RELOAD) then return end

	net.Start("ap_replace_wep_battery_1")
	net.SendToServer()
end

function SWEP:DrawHUD()
	if progress_circle_status > 0 then
		draw.Text({
			text = "Replacing the batteries",
			pos = {ScrW() / 2, (ScrH() / 2) + 64},
			font = "BR2_ItemFont",
			color = Color(255,255,255,255),
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_BOTTOM,
		})
	end

	if !BR2_ShouldDrawWeaponInfo() then return end
	draw.Text({
		text = "Secondary attack toggles the flashlight, Reload replaces the batteries",
		pos = {ScrW() / 2, ScrH() - 6},
		font = "BR2_ItemFont",
		color = Color(255,255,255,15),
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_BOTTOM,
	})
end

WBK_FlashlightIsActive = false
WBK_IsFlashlightOnShoulder = false
WBK_FlashlightObject = nil

hook.Add("PlayerBindPress", "FlashLight_KeyPress", function(ply, bind, pressed)
    if bind != "impulse 100" and bind != "+reload" then return end
	if bind == "+reload" and WBK_IsFlashlightOnShoulder then return end

	local VMAnimCurrentAnimIn = VManip:GetCurrentAnim() == "Flashlight_In"
	local VMAnimCurrentAnimShould = VManip:GetCurrentAnim() == "Flashlight_Shoulder_Take"
	if bind == "+reload" and !VMAnimCurrentAnimIn and !VMAnimCurrentAnimShould then return end

	local awep = ply:GetActiveWeapon()
	if !ply:HasWeapon("item_flashlight") or (IsValid(awep) and (awep:GetClass() == "item_flashlight" or !canUseSideFlashlight(awep))) then return end

	local shouldFlash = true

	local wep = LocalPlayer():GetWeapon("item_flashlight")
	if IsValid(wep) then
		if !wep:IsBatteryGood() then
			shouldFlash = false
		end
	end

	local isOnlyOnShoulder = VMAnipFlashlight_Serv_UseOnlyShoulder:GetBool()
	if isOnlyOnShoulder then
		WBK_IsFlashlightOnShoulder = true;
		local VMAnimCurrentAnimIn = VManip:GetCurrentAnim() == "Flashlight_In"
		local VMAnimCurrentAnimShould = VManip:GetCurrentAnim() == "Flashlight_Shoulder_Take"
		
		if VMAnimCurrentAnimIn || VMAnimCurrentAnimShould then
			VMAnimPlayedF = VManip:PlaySegment("Flashlight_Shoulder_Put", true)
			if VMAnimPlayedF then
				LocalPlayer():EmitSound(self.ShoulderMove_Sound)
				timer.Simple(0.1, function()
					LocalPlayer():EmitSound(self.ShoulderAttach_Sound)
				end)
				timer.Simple(0.5, function()
					WBK_IsFlashlightOnShoulder = true
				end)
			end
		end
	end

	if WBK_IsFlashlightOnShoulder == true && pressed == true then 
		VMAnimPlayedF = VManip:PlayAnim("Flashlight_EnableDisable")
		if VMAnimPlayedF then
			if WBK_FlashlightIsActive == true then 
				LocalPlayer():EmitSound(self.ShoulderMove_Sound)
				timer.Simple(0.25, function()
					LocalPlayer():EmitSound(self.On_Sound)
					if IsValid(WBK_FlashlightObject) then
						WBK_FlashlightObject:Remove()
					end
					WBK_FlashlightIsActive = false
					WBK_FlashlightObject = nil
				end)
			else
				LocalPlayer():EmitSound(self.TakeIn_Sound)
				timer.Simple(0.25, function()
					LocalPlayer():EmitSound(self.On_Sound)
					WBK_FlashlightIsActive = true

					if shouldFlash then
						WBK_FlashlightObject = ProjectedTexture()
						WBK_FlashlightObject:SetColor(Color(255, 255, 255))

						local VMAnipFlashlightActTexture = LocalPlayer():GetInfo( "cl_VMANIPFlash_texture" )
						WBK_FlashlightObject:SetTexture(VMAnipFlashlightActTexture)
						WBK_FlashlightObject:SetEnableShadows(true)
						WBK_FlashlightObject:SetShadowFilter( 0 )
						WBK_FlashlightObject:SetFOV(70)
					end
				end)
			end
		end
		return true
	else
		if WBK_IsFlashlightOnShoulder == true then return end

		local VMAnimPlayedF
		local VMAnimCurrentAnimIn = VManip:GetCurrentAnim() == "Flashlight_In"
		local VMAnimCurrentAnimShould = VManip:GetCurrentAnim() == "Flashlight_Shoulder_Take"

		if VMAnimCurrentAnimIn || VMAnimCurrentAnimShould then
			VMAnimPlayedF = VManip:PlaySegment("Flashlight_Out", true)
			if VMAnimPlayedF then
				timer.Simple(0.3, function()
					LocalPlayer():EmitSound(self.On_Sound)
					if IsValid(WBK_FlashlightObject) then
						WBK_FlashlightObject:Remove()
					end
					WBK_FlashlightIsActive = false
					WBK_FlashlightObject = nil
				end)
				timer.Simple(0.5, function()
					LocalPlayer():EmitSound(self.TakeOut_Sound)
				end)
			end
		else
			VMAnimPlayedF = VManip:PlayAnim("Flashlight_In")
			if VMAnimPlayedF then
				WBK_IsFlashlightOnShoulder = false
				LocalPlayer():EmitSound(self.TakeIn_Sound)
				
				timer.Simple(0.4, function()
					LocalPlayer():EmitSound(self.On_Sound)
					WBK_FlashlightIsActive = true

					if shouldFlash then
						WBK_FlashlightObject = ProjectedTexture()
						WBK_FlashlightObject:SetColor(Color(255, 255, 255))

						local VMAnipFlashlightActTexture = LocalPlayer():GetInfo( "cl_VMANIPFlash_texture" )
						WBK_FlashlightObject:SetTexture(VMAnipFlashlightActTexture)
						WBK_FlashlightObject:SetEnableShadows(true)
						WBK_FlashlightObject:SetShadowFilter( 0 )
						WBK_FlashlightObject:SetFOV(70)
					end
				end)
			end
		end
		VMAnimPlayedF = VMAnimPlayedF
		return true
	end
end)


local function solvetriangle(angle, dist)
    local a = angle / 2
    local b = dist
    return b * math.tan(a) * 2
end

local function WBK_SpawnFlashlight()
    if WBK_FlashlightIsActive && WBK_FlashlightObject then
        local mdl = VManip:GetVMGesture()
        if LocalPlayer():ShouldDrawLocalPlayer() or !IsValid(mdl) or WBK_IsFlashlightOnShoulder == true then
            WBK_FlashlightObject:SetPos(LocalPlayer():EyePos())
            WBK_FlashlightObject:SetAngles(LocalPlayer():EyeAngles())
			WBK_FlashlightObject:SetFarZ(654)
            WBK_FlashlightObject:Update()
        else
			local att = mdl:LookupAttachment("FlashLight")
			local posang = mdl:GetAttachment(att)
			WBK_FlashlightObject:SetPos(posang.Pos - (posang.Ang:Forward() * 10))
			WBK_FlashlightObject:SetAngles(posang.Ang + Angle(180, -10, 0))
			WBK_FlashlightObject:SetFarZ(824)
			WBK_FlashlightObject:Update()
		end
    end
end
hook.Add("Think", "FlashLight_EnableFlashlight", WBK_SpawnFlashlight)

local bannedWeapons = {
-- TODO
}

function removeSideFlashlight()
	if IsValid(WBK_FlashlightObject) then
		WBK_FlashlightObject:Remove()
	end
	if VManip then
		VManip:PlaySegment("Flashlight_Out", true)
	end
	WBK_FlashlightIsActive = false
	WBK_FlashlightObject = nil
end

function canUseSideFlashlight(wep)
	return !table.HasValue(bannedWeapons, wep:GetClass())
end

hook.Add("PlayerSwitchWeapon", "sideflashlight_switchweapons", function(ply, oldWeapon, newWeapon)
	if WBK_FlashlightIsActive and !canUseSideFlashlight(newWeapon) then
		removeSideFlashlight()
	end
end)

hook.Add("Tick", "sideflashlight_switchweapons", function()
	if WBK_FlashlightIsActive and IsValid(WBK_FlashlightObject) then
		net.Start("ap_sideflashlight")
		net.SendToServer()

		local wep = LocalPlayer():GetWeapon("item_flashlight")
		if IsValid(wep) then
			if !wep:IsBatteryGood() then
				WBK_FlashlightObject:Remove()
			end
		else
			removeSideFlashlight()
			return
		end
	end
end)
