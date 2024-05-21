
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("flashlight_dropped")

SWEP.BatteryLevel = math.random(40,96)
SWEP.BatterySpeed = 2.5

function SWEP:Reload()
end

function SWEP:CanDrop()
	return (self.NextCanDrop < CurTime() and self.Owner.ap_replacing_batteries < CurTime())
end

function SWEP:Holster()
	local can = self:CanDrop()
	if can then
		self:rremove()
	end
	return can
end

function SWEP:AfterPickup()
	if self.Active and self:IsBatteryGood() then
		timer.Simple(0.5,function()
			self:BuildLight(false)
			--self.Owner:PrintMessage(HUD_PRINTTALK, tostring(CurTime()))
		end)
	end
end

function SWEP:SaveVariablesTo(ent)
	ent.BatteryLevel = self.BatteryLevel
end

function SWEP:OnDrop()
    self.Owner:SetNWEntity("FL_Flashlight", nil)
    self.BatteryLevel = self.BatteryLevel - 1
end

SWEP.Broken = false
SWEP.HP = 100
function SWEP:DamagedWeapon()
	if self.Broken then return end

	self.HP = self.HP - math.random(4,9)
	self.BatteryLevel = math.Clamp(self.BatteryLevel - math.random(1,2), 0, 100)
	--print("damaged flashlight ", self.HP, self.BatteryLevel)
	if self.HP < 1 or !self:IsBatteryGood() then
		self:rremove()
		self.Broken = true
		--print(self, " flashlight broken")
	end
end

if dropped_flashlights == nil then
    dropped_flashlights = {}
end

SWEP.KV_Farz = math.random(1250,1550) -- 1477
SWEP.KV_Fov = math.random(63,80)
SWEP.KV_A = math.random(215,255)

function SWEP:BuildLight(dropped)
	if !self:IsBatteryGood() or self.Broken then return end
	--if !dropped and (CLIENT or !IsValid(self.Owner) or !self.Owner:GetActiveWeapon() or self.Owner:GetActiveWeapon() != self) then return end

	self.projectedLight = ents.Create("env_projectedtexture")
	self.projectedLight:SetLagCompensated(true)
	
	if !dropped then
		self.projectedLight:SetPos(self.Owner:EyePos())
		self.projectedLight:SetAngles(self.Owner:EyeAngles())
	end
	
	self.projectedLight:SetKeyValue("enableshadows", 1)
	self.projectedLight:SetKeyValue("farz", self.KV_Farz)
	self.projectedLight:SetKeyValue("nearz", 1)
	self.projectedLight:SetKeyValue("lightfov", self.KV_Fov)
	self.projectedLight:SetKeyValue("lightcolor", "255 255 255 "..self.KV_A.."")

	if self.BatteryLevel < 12 then
		self.projectedLight:SetKeyValue("style", "8")
	end

	self.projectedLight:Spawn()
	self.projectedLight:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001")

	if !dropped then
		self.Owner:SetNWEntity("FL_Flashlight", self.projectedLight)
		--local vmodel = self.Owner:GetViewModel()
		--self.projectedLight:SetParent(vmodel, vmodel:LookupAttachment("light"))
	end
	--self:SetNWEntity("FL_Flashlight", self.projectedLight)

	self.Active = true
end

util.AddNetworkString("ap_sideflashlight")
net.Receive("ap_sideflashlight", function(len, ply)
	ply.SideFlashlightTil = CurTime() + 1
end)

SWEP.NextBatteryCheck = 0
function SWEP:ThinkFunc(dropped)
	if !IsValid(self.Owner) then return end
	self.NextBatteryCheck = self.NextBatteryCheck or 0
	self.Owner.SideFlashlightTil = self.Owner.SideFlashlightTil or 0

	if !dropped and IsValid(self.projectedLight) then
		self.projectedLight:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector() * 2)
		self.projectedLight:SetAngles(self.Owner:EyeAngles())
	end

	if self.NextBatteryCheck < CurTime() then
		self.NextBatteryCheck = CurTime() + self.BatterySpeed

		local isSided = self.Owner.SideFlashlightTil > CurTime()

		if self.Active or isSided then
			self.BatteryLevel = self.BatteryLevel - 1

			if !self:IsBatteryGood() then
				self.BatteryLevel = 0
				self:rremove()
				
			/*
			elseif self.BatteryLevel == 12 then
				SafeRemoveEntity(self.projectedLight)
				if dropped then
					self:SetNWEntity("FL_Flashlight", nil)
				else
					self.Owner:SetNWEntity("FL_Flashlight", nil)
				end
				self:BuildLight(dropped)

				if IsValid(self.projectedLight) then
					self.projectedLight:SetKeyValue("style", "8")
					table.ForceInsert(dropped_flashlights, {self, self.projectedLight})
				end
			*/
			end
		end

		--Entity(1):PrintMessage(HUD_PRINTCENTER, "BatteryLevel: " .. tostring(self.BatteryLevel) .. "")

		if !dropped or isSided then
			net.Start("updatebattery")
				net.WriteInt(self.BatteryLevel, 8)
				net.WriteString(self:GetClass())
			net.Send(self.Owner)
		end
	end
end

function SWEP:Think()
    self:ThinkFunc(false)
end

function SWEP:AfterDrop(new_ent)
    if self.Active and self:IsBatteryGood() and IsValid(self.projectedLight) then
        new_ent:BuildLight(true)
        table.ForceInsert(dropped_flashlights, {new_ent, new_ent.projectedLight})
        new_ent.projectedLight:SetParent(new_ent)

        local ang = new_ent:GetAngles()
        new_ent.projectedLight:SetPos(new_ent:GetPos() + ang:Forward() * 8)
        new_ent.projectedLight:SetAngles(ang)
        --net.Start("flashlight_dropped")
        --	net.WriteEntity(new_ent, new_ent.projectedLight)
        --net.Broadcast()
    end
    SafeRemoveEntity(self.projectedLight)
end

hook.Add("Tick", "AP_DroppedFlashlightTick", function()
	for k,v in pairs(player.GetAll()) do
		local awep = v:GetActiveWeapon()
		if !(IsValid(awep) and awep:GetClass() == "item_flashlight") then
			local wep = v:GetWeapon("item_flashlight")
			if IsValid(wep) then
				wep:ThinkFunc(false)
			end
		end
	end

    local i = 0
    for k,v in pairs(dropped_flashlights) do
        i = i + 1
        local ent = v[1]
        local pjs = v[2]
        if !IsValid(ent) or !IsValid(pjs) or IsValid(ent:GetOwner()) then
            table.remove(dropped_flashlights, i)
            if IsValid(pjs) then
				--print("cleaned", pjs)
                pjs:Remove()
            end
            break
        end

        ent:ThinkFunc(true)
    end
end)

function SWEP:SecondaryAttack()
	if !IsValid(self) or !IsValid(self.Owner) or !self.Owner:GetActiveWeapon() or self.Owner:GetActiveWeapon() != self then return end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if !IsValid(self.projectedLight) then
		self:BuildLight(false)
		self.Owner:EmitSound(self.On_Sound, 90, 100, 1)
		return
	end

	self.Active = !self.Active
	self.projectedLight:Fire(Either(self.Active, "TurnOn", "TurnOff"))
	self.Owner:EmitSound(Either(self.Active, self.On_Sound, self.Off_Sound), 75, 100, 1)
end
