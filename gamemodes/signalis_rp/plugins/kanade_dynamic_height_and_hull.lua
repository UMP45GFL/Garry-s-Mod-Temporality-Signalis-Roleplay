
PLUGIN.name = "Dynamic height and hull"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds dynamic height and hull."
PLUGIN.license = [[meow]]

ix.config.Add("DynamicHeightAndHullEnabled", true, "Whether or to enable dynamic height and hull.", nil, {
	category = "Dynamic Height And Hull"
})

ix.config.Add("DynamicHeightAndHullAffectNPCs", true, "Whether or to affect NPCs.", nil, {
	category = "Dynamic Height And Hull"
})

ix.config.Add("DynamicHeightAndHullMinHeight", 10, "Minimum height.", nil, {
	data = {min = 10, max = 33},
	category = "Dynamic Height And Hull"
})

ix.config.Add("DynamicHeightAndHullMaxHeight", 200, "Max height.", nil, {
	data = {min = 72, max = 200},
	category = "Dynamic Height And Hull"
})

ix.config.Add("DynamicHeightAndHullMaxSize", 16, "Max hull size for playermodels.", nil, {
	data = {min = 1, max = 100},
	category = "Dynamic Height And Hull"
})

local function CLAMPSIZE(value)
	local maxsize = ix.config.Get("DynamicHeightAndHullMaxSize", true)
	if value < 0 and value < -maxsize then
		value = -maxsize
	end
	if value > 0 and value > maxsize then
		value = maxsize
	end

	return value
end
local function CLAMPHEIGHT(value)
	return math.Clamp(value, ix.config.Get("DynamicHeightAndHullMinHeight", true), ix.config.Get("DynamicHeightAndHullMaxHeight", true))
end
local function CLAMPCAMHEIGHT(value)
	return math.Clamp(value * 1.09121366, ix.config.Get("DynamicHeightAndHullMinHeight", true), ix.config.Get("DynamicHeightAndHullMaxHeight", true)) / 1.09121366
end
local function CLAMPCROUCHCAMHEIGHT(ccamheight, height)
	if ccamheight > height / 1.83214558 then
		return math.Clamp(ccamheight + 3, ix.config.Get("DynamicHeightAndHullMinHeight", true), ix.config.Get("DynamicHeightAndHullMaxHeight", true)) - 3
	else
		return math.Clamp(height / 1.83214558, ix.config.Get("DynamicHeightAndHullMinHeight", true), ix.config.Get("DynamicHeightAndHullMaxHeight", true)) * 1.83214558
	end
end

if SERVER then
	util.AddNetworkString("DynamicCameraHullViewSetup")
	util.AddNetworkString("DynamicCameraOutfitterConnectHelp")
	
	function DynamicCameraUpdateView(ply)
		-- Find the height by spawning a dummy entity
		if !ply:IsPlayer() or ply:GetModel() == "models/player.mdl" then return end
		
		if !ix.config.Get("DynamicHeightAndHullEnabled", true) then
			ply:SetHull(Vector(-16,-16,0), Vector(16,16,72))
			ply:SetHullDuck(Vector(-16,-16,0), Vector(16,16,36))
			ply:SetViewOffset(Vector(0, 0, 64))
			ply:SetViewOffsetDucked(Vector(0, 0, 28))
			
			net.Start("DynamicCameraHullViewSetup")
				net.WriteFloat(-1)
				net.WriteFloat(-1)
				net.WriteFloat(-1)
				net.WriteFloat(-1)
			net.Send(ply)
			
			return
		end
		
		local height = 64
		local camheight = -1
		local entity = ents.Create("base_anim")
		entity:SetModel((ply.outfitter_mdl_help or ply:GetModel()))
		entity:ResetSequence(entity:LookupSequence("idle_all_01"))
		
		bone = entity:LookupBone("ValveBiped.Bip01_Neck1")
		if bone then
			height = entity:GetBonePosition(bone).z + 5
		end
		attach = entity:LookupAttachment("eyes")
		if attach > 0 then
			camheight = entity:GetAttachment(entity:LookupAttachment("eyes")).Pos.z
		end
		
		height = CLAMPCAMHEIGHT(height)
		if attach > 0 then
			camheight = CLAMPHEIGHT(camheight)
		end
		
		entity:Remove()
		--if height == 64 then return end
		ply:SetNWFloat("DynamicCamera:StandHeight", height)
		ply:SetNWFloat("DynamicCamera:StandCamHeight", camheight)
		
		local cheight = 36
		local ccamheight = -1
		local entity = ents.Create("base_anim")
		entity:SetModel((ply.outfitter_mdl_help or ply:GetModel()))
		entity:ResetSequence(entity:LookupSequence("cidle_all"))
		bone = entity:LookupBone("ValveBiped.Bip01_Neck1")
		
		if bone then
			cheight = entity:GetBonePosition(bone).z + 5
		end
		attach = entity:LookupAttachment("eyes")
		if attach > 0 then
			ccamheight = math.Clamp(entity:GetAttachment(entity:LookupAttachment("eyes")).Pos.z, ix.config.Get("DynamicHeightAndHullMinHeight", true), 33)
		end
		
		if attach > 0 then
			ccamheight = CLAMPCROUCHCAMHEIGHT(ccamheight, -1)
		end
		
		entity:Remove()
		cheight = math.Clamp(cheight, ix.config.Get("DynamicHeightAndHullMinHeight", true), height / 1.83214558 - 1)
		ply:SetNWFloat("DynamicCamera:CrouchHeight", cheight)
		ply:SetNWFloat("DynamicCamera:CrouchCamHeight", ccamheight)

		net.Start("DynamicCameraHullViewSetup")
			net.WriteFloat(height)
			net.WriteFloat(cheight)
			net.WriteFloat(camheight)
			net.WriteFloat(ccamheight)
		net.Send(ply)

		ply:SetViewOffset(Vector(0, 0, camheight > 0 and camheight or height))
		ply:SetViewOffsetDucked(Vector(0, 0, ccamheight > 0 and ccamheight or cheight))

		local hullmin = Vector(math.Round(CLAMPSIZE(height / -4.5)), math.Round(CLAMPSIZE(height / -4.5)), 0)
		local hullmax = Vector(math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPHEIGHT(height * 1.09121366)))
		local hullcrouch = Vector(math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPHEIGHT(ccamheight > height / 1.83214558 and ccamheight + 3 or height / 1.83214558)))

		ply:SetHull(hullmin, hullmax)
		ply:SetHullDuck(hullmin, hullcrouch)
	end

end

local PLY_META = FindMetaTable("Player")

function PLY_META.GetBodygroupsAsNumber(self)
	local num = 0
	local bodys = self:GetNumBodyGroups()
	for i=0, bodys - 1 do
		num = num + (self:GetBodygroup(i) < 10 and self:GetBodygroup(i) or 0) * math.pow(10, bodys - 1 - i)
	end
	return num
end

function PLY_META.GetBodygroupsAsString(self)
	local num = ""
	local bodys = self:GetNumBodyGroups()
	local digits = "0123456789abcdefghijklmnopqrstuvwxyz"
	for i=0, bodys - 1 do
		num = num .. string.sub(digits, self:GetBodygroup(i)+1,self:GetBodygroup(i)+1)
	end
	return num
end

-- CAUTION : OVERRIDE
function PLY_META.ResetHull(self)
	if ix.config.Get("DynamicHeightAndHullEnabled", true) == false then
		self:SetHull(Vector(-16,-16,0), Vector(16,16,72))
		self:SetHullDuck(Vector(-16,-16,0), Vector(16,16,36))
		return
	end
	
	if SERVER then 
		if self:GetNWFloat("DynamicCamera:StandHeight", -1) == -1 then
			DynamicCameraUpdateView(self)
			return
		end
		local height = self:GetNWFloat("DynamicCamera:StandHeight")
		local camheight = self:GetNWFloat("DynamicCamera:StandCamHeight")
		local cheight = self:GetNWFloat("DynamicCamera:CrouchHeight")
		local ccamheight = self:GetNWFloat("DynamicCamera:CrouchCamHeight")

		local hullmin = Vector(math.Round(CLAMPSIZE(height / -4.5)), math.Round(CLAMPSIZE(height / -4.5)), 0)
		local hullmax = Vector(math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPHEIGHT(height * 1.09121366)))
		local hullcrouch = Vector(math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPHEIGHT(ccamheight > height / 1.83214558 and ccamheight + 3 or height / 1.83214558)))

		self:SetHull(hullmin, hullmax)
		self:SetHullDuck(hullmin, hullcrouch)
	else
		if self:GetNWFloat("DynamicCamera:StandHeight", -1) == -1 then
			net.Start("DynamicCameraHullViewSetup")
				net.WriteInt(LocalPlayer():EntIndex(), 17)
			net.SendToServer()
			return
		end
		local height = self:GetNWFloat("DynamicCamera:StandHeight")
		local cheight = self:GetNWFloat("DynamicCamera:CrouchHeight")
		local cheight = self:GetNWFloat("DynamicCamera:CrouchHeight")
		local ccamheight = self:GetNWFloat("DynamicCamera:CrouchCamHeight")

		local hullmin = Vector(math.Round(CLAMPSIZE(height / -4.5)), math.Round(CLAMPSIZE(height / -4.5)), 0)
		local hullmax = Vector(math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPHEIGHT(height * 1.09121366)))
		local hullcrouch = Vector(math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPHEIGHT(ccamheight > height / 1.83214558 and ccamheight + 3 or height / 1.83214558)))

		self:SetHull(hullmin, hullmax)
		self:SetHullDuck(hullmin, hullcrouch)
	end
end

if SERVER then
	function DynamicCameraUpdateTrueModel(ply)
		local testString = ply.outfitter_mdl_help and (ply.outfitter_mdl_help ~= "" and ply.outfitter_mdl_help) or ply:GetModel()
		if ply:GetNWString("DynamicCamera:TrueModel") ~= testString then
			ply:SetNWString("DynamicCamera:TrueModel", testString)
			DynamicCameraUpdateView(ply)
			return
		end
	end
	
	hook.Add("PlayerSpawn", "DynamicCamera:PlayerSpawn", function(ply)
		DynamicCameraUpdateView(ply)
	end)
	
	local ECPlayerTickRate = 5
	local ECPlayerTickTime = CurTime()
	hook.Add("PlayerTick", "DynamicCamera:PlayerTick", function(ply)
		if ECPlayerTickTime > CurTime() then return end
		ECPlayerTickTime = CurTime() + ECPlayerTickRate
		
		DynamicCameraUpdateTrueModel(ply)
	end)
	
	net.Receive("DynamicCameraHullViewSetup", function()
		DynamicCameraUpdateView(Entity(net.ReadInt(17)))
	end)
	
	net.Receive("DynamicCameraOutfitterConnectHelp", function(len, ply)
		if (IsValid(ply) and ply:IsPlayer()) then
			local testString = net.ReadString()
			if testString == "" then testString = nil end
			ply.outfitter_mdl_help = testString
		end
	end)
	
	function DynamicCameraNPCCreate(ent)
		timer.Simple(0.25, function()
			if not IsValid(ent) or not ent:IsNPC() then return end
			if not ix.config.Get("DynamicHeightAndHullAffectNPCs", true) then return end
			if ent.IsVJBaseSNPC then return end
			if string.find(ent:GetClass(), "_torso") ~= nil then return end
			if string.find(ent:GetClass(), "zombie") ~= nil then return end
			
			if ent:GetModel() == nil or ent:GetModel() == "" then
				DynamicCameraNPCCreate(ent)
				return
			end
			
			local entity = ents.Create("base_anim")
			entity:SetModel(ent:GetModel())
			if entity:LookupSequence("idle_all_01") then
				entity:ResetSequence(entity:LookupSequence("idle_all_01"))
			end
			if entity:LookupSequence("reference") then
				entity:ResetSequence(entity:LookupSequence("reference"))
			end
			
			local bone = entity:LookupBone("ValveBiped.Bip01_Neck1")
			local height = 72
			if bone then
				local BONEPOS = entity:GetBonePosition(bone)
				height = entity:GetBonePosition(bone).z + 5
				if math.abs(BONEPOS.x) > 10 or math.abs(BONEPOS.y) > 10 then
					entity:Remove()
					return
				end
			else
			
				entity:Remove()
				return
			end
			
			local hullmin = Vector(-height/4.5, -height/4.5, 0)
			local hullmax = Vector(height/4.5, height/4.5, height * 1.09121366)
			
			ent:SetCollisionBounds(hullmin, hullmax)
			
			entity:Remove()
		end)
	end
	hook.Add("OnEntityCreated", "DynamicCamera:OnEntityCreated", DynamicCameraNPCCreate)

end

if CLIENT then
	local function DynamicCameraSetup(height, cheight, camheight, ccamheight)
		if LocalPlayer().SetViewOffset then 
		else
			timer.Simple(2, function()
				DynamicCameraSetup(height, cheight, camheight, ccamheight)
			end)
			return
		end
		
		if ix.config.Get("DynamicHeightAndHullEnabled", true) == false then
			LocalPlayer():SetHull(Vector(-16,-16,0), Vector(16,16,72))
			LocalPlayer():SetHullDuck(Vector(-16,-16,0), Vector(16,16,36))
			LocalPlayer():SetViewOffset(Vector(0, 0, 64))
			LocalPlayer():SetViewOffsetDucked(Vector(0, 0, 28))
			return
		end
		
		LocalPlayer():SetViewOffset(Vector(0, 0, camheight > 0 and camheight or height))
		LocalPlayer():SetViewOffsetDucked(Vector(0, 0, ccamheight > 0 and ccamheight or cheight))

		local hullmin = Vector(math.Round(CLAMPSIZE(height / -4.5)), math.Round(CLAMPSIZE(height / -4.5)), 0)
		local hullmax = Vector(math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPSIZE(height / 4.5)), math.Round(height * 1.09121366))
		local hullcrouch = Vector(math.Round(CLAMPSIZE(height / 4.5)), math.Round(CLAMPSIZE(height / 4.5)), math.Round(ccamheight > height / 1.83214558 and ccamheight + 3 or height / 1.83214558))
		
		if timer.Exists("DynamicCameraSetupHullFix"..LocalPlayer():EntIndex()) then
			timer.Destroy("DynamicCameraSetupHullFix"..LocalPlayer():EntIndex())
		end
		timer.Create("DynamicCameraSetupHullFix"..LocalPlayer():EntIndex(), 2.5, 1, function()
			LocalPlayer():SetHull(hullmin, hullmax)
			LocalPlayer():SetHullDuck(hullmin, hullcrouch)
		end)
	end
	net.Receive("DynamicCameraHullViewSetup", function()
		local height = net.ReadFloat()
		local cheight = net.ReadFloat()
		local camheight = net.ReadFloat()
		local ccamheight = net.ReadFloat()
		DynamicCameraSetup(height, cheight, camheight, ccamheight)
	end)
	
	local ECPostDrawViewModelRate = 0.5
	local ECPostDrawViewModelTime = CurTime()
	hook.Add("PostDrawViewModel", "DynamicCamera:PostDrawViewModel", function(vm, ply, weapon)
		if ECPostDrawViewModelTime > CurTime() then return end
		ECPostDrawViewModelTime = CurTime() + ECPostDrawViewModelRate
		if weapon.UseHands then
			local hands = LocalPlayer():GetHands()
			if IsValid(hands) then 
				hands:DrawModel()
				if ply:SkinCount() == ply:GetHands():SkinCount() then
					hands:SetSkin(LocalPlayer():GetSkin())
				end
				if ply:GetNumBodyGroups() > 0 then
					if ply:GetNumBodyGroups() == ply:GetHands():GetNumBodyGroups() then
						hands:SetBodyGroups(ply:GetBodygroupsAsString())
					end
				end
			end

		end
	end)
end

-- Addon: https://steamcommunity.com/sharedfiles/filedetails/?id=2887450478
-- Creator: https://steamcommunity.com/id/Xaxidoro
