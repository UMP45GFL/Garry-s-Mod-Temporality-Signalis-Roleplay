
DEFINE_BASECLASS("DModelPanel")

local PANEL = {}
local MODEL_ANGLE = Angle(0, 45, 0)

function PANEL:Init()
	self.brightness = 1
	self:SetCursor("none")
end

function PANEL:SetModel(model)
	if (IsValid(self.Entity)) then
		self.Entity:Remove()
		self.Entity = nil
	end

	if (!ClientsideModel) then
		return
	end

	if isstring(model) then
		model = {mdl = model}
	end

	local entity = ClientsideModel(model.mdl, RENDERGROUP_OPAQUE)

	if (!IsValid(entity)) then
		return
	end

	entity:SetNoDraw(true)
	entity:SetIK(false)

	if (model.skin) then
		entity:SetSkin(model.skin)
	end

	if (model.bodygroups) then
		entity:SetBodyGroups(model.bodygroups)
	end

	local sequence = entity:LookupSequence("idle_unarmed")

	if (sequence <= 0) then
		sequence = entity:SelectWeightedSequence(ACT_IDLE)
	end

	if (sequence > 0) then
		entity:ResetSequence(sequence)
	else
		local found = false

		for _, v in ipairs(entity:GetSequenceList()) do
			if ((v:lower():find("idle") or v:lower():find("fly")) and v != "idlenoise") then
				entity:ResetSequence(v)
				found = true

				break
			end
		end

		if (!found) then
			entity:ResetSequence(4)
		end
	end
	
	/*
	entity:SetPos(Vector(0, 0, 0))
	if SIGNALIS_MODEL_HEIGHT_FIXES[model] then
		entity:SetPos(Vector(0, 0, SIGNALIS_MODEL_HEIGHT_FIXES[model]))
	end
	*/

	if model.mdl == "models/error.mdl" then
		entity:SetPos(Vector(0, 0, -300))
	else
		entity:SetPos(Vector(0, 0, 0))
		local bone = entity:LookupBone("ValveBiped.Bip01_Neck1")
		if bone then
			height = entity:GetBonePosition(bone).z + 5
			if height > 60 then
				entity:SetPos(entity:GetPos() - Vector(0, 0, height - 60))
			end
		end
	end

	self.Entity = entity
end

function PANEL:LayoutEntity()
	local scrW, scrH = ScrW(), ScrH()
	local xRatio = gui.MouseX() / scrW
	local yRatio = gui.MouseY() / scrH
	local x, _ = self:LocalToScreen(self:GetWide() / 2)
	local xRatio2 = x / scrW
	local entity = self.Entity

	entity:SetPoseParameter("head_pitch", yRatio * 90 - 30)
	entity:SetPoseParameter("head_yaw", (xRatio - xRatio2) * 90 - 5)
	entity:SetAngles(MODEL_ANGLE)
	entity:SetIK(false)

	if (self.copyLocalSequence) then
		entity:SetSequence(LocalPlayer():GetSequence())
		entity:SetPoseParameter("move_yaw", 360 * LocalPlayer():GetPoseParameter("move_yaw") - 180)
	end

	self:RunAnimation()
end

function PANEL:DrawModel()
	local brightness = self.brightness * 0.4
	local brightness2 = self.brightness * 1.5

	render.SetStencilEnable(false)
	render.SetColorMaterial()
	render.SetColorModulation(1, 1, 1)
	render.SetModelLighting(0, brightness2, brightness2, brightness2)

	for i = 1, 4 do
		render.SetModelLighting(i, brightness, brightness, brightness)
	end

	local fraction = (brightness / 1) * 0.1

	render.SetModelLighting(5, fraction, fraction, fraction)

	-- Excecute Some stuffs
	if (self.enableHook) then
		hook.Run("DrawHelixModelView", self, self.Entity)
	end

	self.Entity:DrawModel()

	if (self.enableHook) then
		hook.Run("PostDrawHelixModelView", self, self.Entity)
	end
end

function PANEL:OnMousePressed()
end

vgui.Register("ixModelPanel", PANEL, "DModelPanel")
