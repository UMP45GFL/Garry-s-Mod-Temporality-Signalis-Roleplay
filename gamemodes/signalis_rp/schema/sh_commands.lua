do
	local COMMAND = {}
	COMMAND.arguments = ix.type.text

	function COMMAND:OnRun(client, message)
		if (!client:IsRestricted()) then
			ix.chat.Send(client, "dispatch", message)
		else
			return "@notNow"
		end
	end

	ix.command.Add("Dispatch", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.arguments = ix.type.text
	COMMAND.alias = {"r"}

	function COMMAND:OnRun(client, message)
		local character = client:GetCharacter()
		if not character then return end

		local inventory = character:GetInventory()
		if not inventory then return end

		local radios = inventory:GetItemsByUniqueID("module_radio", true)
		local item

		for k, v in ipairs(radios) do
			if v:GetData("equip", false) and v:GetData("enabled", false) then
				item = v
				break
			end
		end

		if (item) then
			if (!client:IsRestricted()) then
				ix.chat.Send(client, "radio", message)
				ix.chat.Send(client, "radio_eavesdrop", message)
			else
				return "@notNow"
			end
		elseif (#radios > 0) then
			return "@radioNotOn"
		else
			return "@radioRequired"
		end
	end

	ix.command.Add("Radio", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.arguments = ix.type.text

	function COMMAND:OnRun(client, message)
		if (!client:IsRestricted()) then
			ix.chat.Send(client, "broadcast", message)
		else
			return "@notNow"
		end
	end

	ix.command.Add("Broadcast", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.adminOnly = true
	COMMAND.arguments = {
		ix.type.character,
		ix.type.text
	}

	function COMMAND:OnRun(client, target, permit)
		local itemTable = ix.item.Get("permit_" .. permit:lower())

		if (itemTable) then
			target:GetInventory():Add(itemTable.uniqueID)
		end
	end

	ix.command.Add("PermitGive", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.adminOnly = true
	COMMAND.arguments = {
		ix.type.character,
		ix.type.text
	}
	COMMAND.syntax = "<string name> <string permit>"

	function COMMAND:OnRun(client, target, permit)
		local inventory = target:GetInventory()
		local itemTable = inventory:HasItem("permit_" .. permit:lower())

		if (itemTable) then
			inventory:Remove(itemTable.id)
		end
	end

	ix.command.Add("PermitTake", COMMAND)
end

do
	local COMMAND = {}

	function COMMAND:OnRun(client, arguments)
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:IsRestricted()) then
			if (!client:IsRestricted()) then
				Schema:SearchPlayer(client, target)
			else
				return "@notNow"
			end
		end
	end

	ix.command.Add("CharSearch", COMMAND)
end

-- make character bioresonant
do
	local COMMAND = {}
	COMMAND.adminOnly = true
	COMMAND.arguments = {
		ix.type.character
	}
	COMMAND.syntax = "<string name>"

	function COMMAND:OnRun(client, target)
		if target:GetData("bioresonance", 0) == 1 then
			return "@alreadyHasBioresonance", target:GetName()
		end

		target:SetData("bioresonance", 1)

		for _, v in ipairs(player.GetAll()) do
			if (self:OnCheckAccess(v) or v == client) then
				v:NotifyLocalized("addBioresonance", client:GetName(), target:GetName())
			end
		end
	end

	ix.command.Add("AddCharBioresonance", COMMAND)
end

-- remove character bioresonance
do
	ix.command.Add("RemoveCharBioresonance", {
		description = "@cmdRemoveCharBioresonance",
		superAdminOnly = true,
		syntax = "<string name>",
		arguments = {
			ix.type.character,
		},
		OnRun = function(self, client, target, name)
			if target:GetData("bioresonance", 0) == 0 then
				return "@noBioresonance", target:GetName()
			end

			target:SetData("bioresonance", 0)
	
			for _, v in ipairs(player.GetAll()) do
				if (self:OnCheckAccess(v) or v == client) then
					v:NotifyLocalized("removeBioresonance", client:GetName(), target:GetName())
				end
			end
		end
	})
end

/*
lua_run player.GetBySteamID64('76561198014356895'):GetCharacter():SetData("bioresonance", 1)
*/
