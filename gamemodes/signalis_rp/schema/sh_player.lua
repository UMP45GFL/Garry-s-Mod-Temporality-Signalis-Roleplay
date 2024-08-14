
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
