
PLUGIN.name = "Area system"
PLUGIN.author = "Kanade"
PLUGIN.description = "Adds areas and zones"
PLUGIN.license = [[meow]]

AddCSLuaFile("mapconfigs/" .. game.GetMap() .. ".lua")
include("mapconfigs/" .. game.GetMap() .. ".lua")

local player_meta = FindMetaTable("Player")

function player_meta:IsInZone(zone)
	local pos = self:GetPos()
	if zone.sub_areas then
		for k, zone2 in pairs(zone.sub_areas) do
			local pos1 = Vector(zone2[2].x, zone2[2].y, zone2[2].z)
			local pos2 = Vector(zone2[3].x, zone2[3].y, zone2[3].z)
			OrderVectors(pos1, pos2)
			if pos:WithinAABox(pos1, pos2) then return true end
		end
	end
	if zone.pos1 then
		local pos1 = Vector(zone.pos1.x, zone.pos1.y, zone.pos1.z)
		local pos2 = Vector(zone.pos2.x, zone.pos2.y, zone.pos2.z)
		OrderVectors(pos1, pos2)
		if pos:WithinAABox(pos1, pos2) then return true end
	end
	return false
end

function player_meta:IsInSleepArea()
	if MAPCONFIG and MAPCONFIG.ZONES and MAPCONFIG.SLEEPING_AREAS then
		for k,v in pairs(MAPCONFIG.SLEEPING_AREAS) do
			if self:IsInZone(v) then
				return true
			end
		end
	end
	return false
end

function GetZonePos(pos)
	if istable(MAPCONFIG) and istable(MAPCONFIG.ZONES) then
		for k,v in pairs(MAPCONFIG.ZONES) do
			for k2,zone in pairs(v) do
				if zone.sub_areas then
					for k3,zone2 in pairs(zone.sub_areas) do
						local pos1 = Vector(zone2[2].x, zone2[2].y, zone2[2].z)
						local pos2 = Vector(zone2[3].x, zone2[3].y, zone2[3].z)
						OrderVectors(pos1, pos2)
						if pos:WithinAABox(pos1, pos2) then
							return zone
						end
					end
				end
				if zone.pos1 then
					local pos1 = Vector(zone.pos1.x, zone.pos1.y, zone.pos1.z)
					local pos2 = Vector(zone.pos2.x, zone.pos2.y, zone.pos2.z)
					OrderVectors(pos1, pos2)
					if pos:WithinAABox(pos1, pos2) then return zone end
				end
			end
		end
	end
	return nil
end

function player_meta:GetSubAreaName()
	local pos = self:GetPos()
	if istable(MAPCONFIG) and istable(MAPCONFIG.ZONES) then
		for k,v in pairs(MAPCONFIG.ZONES) do
			for k2,zone in pairs(v) do
				if zone.sub_areas then
					for k3,zone2 in pairs(zone.sub_areas) do
						local pos1 = Vector(zone2[2].x, zone2[2].y, zone2[2].z)
						local pos2 = Vector(zone2[3].x, zone2[3].y, zone2[3].z)
						OrderVectors(pos1, pos2)
						if pos:WithinAABox(pos1, pos2) then return zone2[1] end
					end
				end
				if zone.pos1 then
					local pos1 = Vector(zone.pos1.x, zone.pos1.y, zone.pos1.z)
					local pos2 = Vector(zone.pos2.x, zone.pos2.y, zone.pos2.z)
					OrderVectors(pos1, pos2)
					if pos:WithinAABox(pos1, pos2) then return zone.name end
				end
			end
		end
	end
	return nil
end

function player_meta:GetZone()
	return GetZonePos(self:GetPos(), false)
end
