
-- data saving
function Schema:SaveRationDispensers()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_rationdispenser")) do
		data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetEnabled()}
	end

	ix.data.Set("rationDispensers", data)
end

function Schema:SaveVendingMachines()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_vendingmachine")) do
		data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetAllStock()}
	end

	ix.data.Set("vendingMachines", data)
end

function Schema:SaveForceFields()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_forcefield")) do
		data[#data + 1] = {v:GetPos(), v:GetAngles(), v:GetMode()}
	end

	ix.data.Set("forceFields", data)
end

-- data loading
function Schema:LoadRationDispensers()
	for _, v in ipairs(ix.data.Get("rationDispensers") or {}) do
		local dispenser = ents.Create("ix_rationdispenser")

		dispenser:SetPos(v[1])
		dispenser:SetAngles(v[2])
		dispenser:Spawn()
		dispenser:SetEnabled(v[3])
	end
end

function Schema:LoadVendingMachines()
	for _, v in ipairs(ix.data.Get("vendingMachines") or {}) do
		local vendor = ents.Create("ix_vendingmachine")

		vendor:SetPos(v[1])
		vendor:SetAngles(v[2])
		vendor:Spawn()
		vendor:SetStock(v[3])
	end
end

function Schema:LoadForceFields()
	for _, v in ipairs(ix.data.Get("forceFields") or {}) do
		local field = ents.Create("ix_forcefield")

		field:SetPos(v[1])
		field:SetAngles(v[2])
		field:Spawn()
		field:SetMode(v[3])
	end
end

function Schema:SearchPlayer(client, target)
	if (!target:GetCharacter() or !target:GetCharacter():GetInventory()) then
		return false
	end

	local name = hook.Run("GetDisplayedName", target) or target:Name()
	local inventory = target:GetCharacter():GetInventory()

	ix.storage.Open(client, inventory, {
		entity = target,
		name = name
	})

	return true
end

function Schema:ScalePlayerDamage(ply, hitgroup, dmginfo)
	if IsValid(ply) and ply:Team() != TEAM_SPECTATOR then
		local dmg_mul = 1

		if hitgroup == HITGROUP_HEAD then
			dmg_mul = dmg_mul * 1.5
			-- Headshot sound effects
			local bone = ply:LookupBone("ValveBiped.Bip01_Head1")
			if bone and SIGNALIS_HEADSHOT_SOUNDS then
				local headpos = ply:GetBonePosition(bone)
				if isvector(headpos) then
					local snd = table.Random(SIGNALIS_HEADSHOT_SOUNDS)
					if snd then
						EmitSound(snd, headpos, 0, CHAN_BODY, 1, 75)
						ply:SendPlaySound(snd)
					end
				end
			end
		end

		local character = ply:GetCharacter()
		if character then
			local class = ix.class.GetClass(character.vars.class)
			if class and class.bullet_damage_taken then
				dmg_mul = dmg_mul * class.bullet_damage_taken
			end
		end
		
		dmginfo:ScaleDamage(dmg_mul)
	end
end

function Schema:GetPlayerDeathSound(ply)
	local character = ply:GetCharacter()
	if character then
		local class = ix.class.GetClass(character.vars.class)
		if class and class.death_sounds then
			local sndTable

			if istable(class.death_sounds) then
				sndTable = table.Random(class.death_sounds)

			elseif isfunction(class.death_sounds) then
				sndTable = class.death_sounds(ply)
			end

			if sndTable then
				local pitch = sndTable.pitch or 100
				pitch = math.random(pitch - 5, pitch + 5)

				ply:EmitSound(sndTable.snd, sndTable.sndLevel, pitch, sndTable.volume)

				if ply:IsReplika() then
					ply:SendPlaySound("eternalis/player/death/flatline.wav")
				end
				return false
			end
		end
	end
end
