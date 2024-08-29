
function Schema:LoadData()
	self:LoadRationDispensers()
	self:LoadVendingMachines()
	self:LoadForceFields()
end

function Schema:SaveData()
	self:SaveRationDispensers()
	self:SaveVendingMachines()
	self:SaveForceFields()
end

function Schema:PlayerUse(client, entity)
	if (IsValid(client.ixScanner)) then
		return false
	end

	if ((client:Team() == FACTION_ADMIN) and entity:IsDoor() and IsValid(entity.ixLock) and client:KeyDown(IN_SPEED)) then
		entity.ixLock:Toggle(client)
		return false
	end

	if (!client:IsRestricted() and entity:IsPlayer() and entity:IsRestricted() and !entity:GetNetVar("untying")) then
		entity:SetAction("@beingUntied", 5)
		entity:SetNetVar("untying", true)

		client:SetAction("@unTying", 5)

		client:DoStaredAction(entity, function()
			entity:SetRestricted(false)
			entity:SetNetVar("untying")
		end, 5, function()
			if (IsValid(entity)) then
				entity:SetNetVar("untying")
				entity:SetAction()
			end

			if (IsValid(client)) then
				client:SetAction()
			end
		end)
	end
end

function Schema:GetFallDamage(client, speed)
	local mul = 1

	local character = client:GetCharacter()
	if character then
		local class = ix.class.GetClass(character.vars.class)
		if class then
			mul = class.physical_damage_taken
		end
	end

	return (speed - 480) * 0.4 * mul
end

function Schema:PlayerLoadout(client)
	client:SetNetVar("restricted")
end

function Schema:PrePlayerLoadedCharacter(client, character, oldCharacter)
	if (IsValid(client.ixScanner)) then
		client.ixScanner:Remove()
	end
end

function Schema:CharacterVarChanged(character, key, oldValue, value)
	local client = character:GetPlayer()
	if (key == "name") then
		local factionTable = ix.faction.Get(client:Team())

		if (factionTable.OnNameChanged) then
			factionTable:OnNameChanged(client, oldValue, value)
		end
	end
end

function Schema:PlayerNoClip(client)
end

function Schema:EntityTakeDamage(entity, dmgInfo)
    if IsValid(entity) and entity:IsPlayer() then

		local dmg_type = dmgInfo:GetDamageType()
		-- only apply the damage multiplier to physical attacks
		if dmg_type == DMG_CRUSH or dmg_type == DMG_FALL or dmg_type == DMG_CLUB or dmg_type == DMG_SLASH or dmg_type == DMG_CRUSH or dmg_type == DMG_PHYSGUN then
			local dmg_mul = 1
			local character = entity:GetCharacter()
			if character then
				local class = ix.class.GetClass(entity:GetCharacter().vars.class)
				if class and class.physical_damage_taken then
					dmg_mul = dmg_mul * class.physical_damage_taken
				end
			end

			dmgInfo:ScaleDamage(dmg_mul)
		end
    end
end

function Schema:OnNPCKilled(npc, attacker, inflictor)
	if (IsValid(npc.ixPlayer)) then
		hook.Run("PlayerDeath", npc.ixPlayer, inflictor, attacker)
	end
end

function Schema:PlayerMessageSend(speaker, chatType, text, anonymous, receivers, rawText)
	if (chatType == "ic" or chatType == "w" or chatType == "y" or chatType == "dispatch") then
		local class = self.voices.GetClass(speaker)

		for k, v in ipairs(class) do
			local info = self.voices.Get(v, rawText)

			if (info) then
				local volume = 80

				if (chatType == "w") then
					volume = 60
				elseif (chatType == "y") then
					volume = 150
				end

				if (info.sound) then
					if (info.global) then
						netstream.Start(nil, "PlaySound", info.sound)
					else
						local sounds = {info.sound}

						ix.util.EmitQueuedSounds(speaker, sounds, nil, nil, volume)
					end
				end

				return info.text
			end
		end
	end
end

function Schema:CanPlayerJoinClass(client, class, info)
	if (client:IsRestricted()) then
		client:Notify("You cannot change classes when you are restrained!")

		return false
	end
end

function Schema:PlayerSpawnObject(client)
	if client:IsRestricted() then
		return false
	end
end

function Schema:PlayerSpray(client)
	return true
end
