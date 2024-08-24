
local meta = FindMetaTable("Player")

function meta:IsFemale()
	local character = self:GetCharacter()
	if character then
		local class = ix.class.GetClass(character.vars.class)
		if class then
			for k,v in pairs(class.models) do
				if v.mdl == self:GetModel() then
					if v.gender then
						return v.gender == "female"
					end
					break
				end
			end
		end
	end

	return false
end

function meta:IsReplika()
	return self:Team() == FACTION_REPLIKA
end

if SERVER then
	util.AddNetworkString("sendErrorSound")
	util.AddNetworkString("sendPlaySound")

	function meta:SendErrorSound()
		net.Start("sendErrorSound")
		net.Send(self)
	end

	function meta:SendPlaySound(snd)
		net.Start("sendPlaySound")
		net.WriteString(snd)
		net.Send(self)
	end
end

if CLIENT then
	net.Receive("sendErrorSound", function()
		surface.PlaySound("eternalis/signalis_ui/no.wav")
	end)

	net.Receive("sendPlaySound", function()
		local snd = net.ReadString()
		if snd then
			surface.PlaySound(snd)
		end
	end)
end
