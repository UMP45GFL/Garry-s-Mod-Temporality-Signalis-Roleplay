ATTRIBUTE.name = "Stamina"
ATTRIBUTE.description = "Affects how fast you can run."

function ATTRIBUTE:OnSetup(client, value)
	local class = ix.class.GetClass(client:GetCharacter().vars.class)
	local speed_mul = 1
	if (class and class.speed) then
		speed_mul = class.speed
	end

	client:SetRunSpeed((ix.config.Get("runSpeed") * speed_mul) + value)
end
