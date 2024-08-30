
ITEM.name = "Flashlight module"
ITEM.model = Model("models/eternalis/items/equipment/flashlight.mdl")
ITEM.description = "Shoulder-mounted flashlight module. Powered by internal Replika power supply when installed."
ITEM.skin = 0

-- Inventory drawing
if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

if CLIENT then
	function CreateCalcViewHook()
		hook.Remove("CalcView", "FlashlightModule_CalcView")
		/*
		hook.Add("CalcView", "FlashlightModule_CalcView", function(client, position, angles, fov)
			for k,ply in pairs(player.GetAll()) do
				local flashlight3d = ply:GetNWEntity("flashlight3d")
				if flashlight3d:IsValid() then
					flashlight3d:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 15)
					flashlight3d:SetAngles(ply:EyeAngles())
				end
			end
		end)
		*/
	end

	net.Receive("ixFlashlightModuleEquip", function()
		CreateCalcViewHook()
	end)

	net.Receive("ixFlashlightModuleUnequip", function()
		hook.Remove("CalcView", "FlashlightModule_CalcView")
	end)
else
	util.AddNetworkString("ixFlashlightModuleEquip")
	util.AddNetworkString("ixFlashlightModuleUnequip")

	function Remove3DFlashlight(ply)
		if IsValid(ply.flashlight3d) then
			ply.flashlight3d:Remove()
		end
	end

	hook.Add("PlayerDisconnected", "FlashlightModule_PlayerDisconnected", function(ply)
		Remove3DFlashlight(ply)
	end)

	hook.Add("PlayerSpawn", "FlashlightModule_PlayerSpawn",function(ply)
		Remove3DFlashlight(ply)
	end)

	hook.Add("PlayerDeath", "FlashlightModule_PlayerDeath", function(victim, inflictor, attacker)
		Remove3DFlashlight(victim)
	end)

	function Create3DFlashlight(ply)
		Remove3DFlashlight(ply)
		ply.flashlight3d = ents.Create("env_projectedtexture")

		ply.flashlight3d:SetKeyValue("enableshadows", 1)
		ply.flashlight3d:SetKeyValue("farz", 550)
		ply.flashlight3d:SetKeyValue("nearz", 8)
		ply.flashlight3d:SetKeyValue("lightfov", 60)
		ply.flashlight3d:SetKeyValue("lightcolor", "230, 230, 200")
		ply.flashlight3d:SetColor(Color(255, 255, 255))
		ply.flashlight3d:Fire("SpotlightTexture", "eternalis/flashlight/flashlight3")

        -- Parent the flashlight to the player's model
        local attachID = ply:LookupAttachment("eyes") -- Attach to eyes if possible
		
        if attachID > 0 then
            ply.flashlight3d:SetParent(ply)
            ply.flashlight3d:Fire("SetParentAttachment", "eyes") -- Attach to the eyes
        else
            -- Fallback to parenting to a bone, like the head
            if ply:LookupBone("ValveBiped.Bip01_L_Clavicle") then
                ply.flashlight3d:SetParent(ply)
                ply.flashlight3d:FollowBone(ply, ply:LookupBone("ValveBiped.Bip01_L_Clavicle"))
				
			elseif ply:LookupBone("ValveBiped.Bip01_R_Clavicle") then
				ply.flashlight3d:SetParent(ply)
				ply.flashlight3d:FollowBone(ply, ply:LookupBone("ValveBiped.Bip01_R_Clavicle"))
				
			elseif ply:LookupBone("ValveBiped.Bip01_Head") then
				ply.flashlight3d:SetParent(ply)
				ply.flashlight3d:FollowBone(ply, ply:LookupBone("ValveBiped.Bip01_Head"))

            else
                -- Default positioning if no suitable bone or attachment found
                ply.flashlight3d:SetPos(ply:EyePos() + ply:EyeAngles():Forward() * 15)
                ply.flashlight3d:SetAngles(ply:EyeAngles())
            end
        end

		ply:SetNWEntity("flashlight3d", ply.flashlight3d)
	end

	hook.Add("PlayerSwitchFlashlight", "BlockFlashLight", function(ply, enabled)
		local items = ply:GetItems()
		if not items then return end

		for k,v in pairs(items) do
			if v.uniqueID == "module_flashlight" and v:GetData("equip") then
				if IsValid(ply.flashlight3d) then
					Remove3DFlashlight(ply)
					net.Start("ixFlashlightModuleEquip")
					net.Send(ply)
				else
					Create3DFlashlight(ply)
					net.Start("ixFlashlightModuleEquip")
					net.Send(ply)
				end
				return false
			end
		end

		return false
	end)
end

function ITEM:EquipFlashlightModule(client)
	self:SetData("equip", true)

	Create3DFlashlight(client)

	net.Start("ixFlashlightModuleEquip")
	net.Send(client)
end

function ITEM:UnequipFlashlightModule(client)
	self:SetData("equip", false)

    Remove3DFlashlight(client)
	net.Start("ixFlashlightModuleUnequip")
	net.Send(client)
end

ITEM:Hook("drop", function(item)
	if (item:GetData("equip")) then
		local character = ix.char.loaded[item.owner]
		local client = character and character:GetPlayer() or item:GetOwner()

		item.player = client
        item:UnequipFlashlightModule(client)
	end
end)

ITEM.functions.EquipUn = {
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	OnRun = function(item)
		local character = ix.char.loaded[item.owner]
		local client = character and character:GetPlayer() or item:GetOwner()

        item:UnequipFlashlightModule(client)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		if client:Team() != FACTION_REPLIKA then
			return false
		end

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false
	end
}

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	OnRun = function(item)
		local client = item.player
		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.uniqueID and v.uniqueID == "module_flashlight" and v.id != item.id and v.data.equip) then
                return false
			end
		end

		item:EquipFlashlightModule(client)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		if client:Team() != FACTION_REPLIKA then
			return false
		end

		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.uniqueID and v.uniqueID == "module_flashlight" and v.id != item.id and v.data.equip) then
                return false
			end
		end

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false
	end
}

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

function ITEM:OnRemoved()
	if (self.invID != 0 and self:GetData("equip")) then
		self.player = self:GetOwner()
		Remove3DFlashlight(self.player)
		self.player = nil
	end
end
