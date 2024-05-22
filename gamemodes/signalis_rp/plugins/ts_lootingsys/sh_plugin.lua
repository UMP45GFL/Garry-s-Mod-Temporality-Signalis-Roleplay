
PLUGIN.name = "TS | Looting System"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Adds a configurable looting system."

ix.util.Include("cl_hooks.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

for x = 1, 12 do
	for y = 1, 12 do
		ix.inventory.Register("lootent:" .. x .. "x" .. y, x, y)
	end
end

properties.Add("lootent_edit", {
	MenuLabel = "Edit Properties",
	Order = 400,
	MenuIcon = "icon16/page_white_edit.png",
	Filter = function(self, entity, client)
		if (entity:GetClass() != "ix_lootent") then return false end
		if (!gamemode.Call("CanProperty", client, "lootent_edit", entity)) then return false end

		return true
	end,
	Action = function(self, entity)
		ix.lootEntEditor = vgui.Create("ixLootentEditor")

		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,
	Receive = function(self, length, client)
		local entity = net.ReadEntity()

		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		client.lootent = entity

		local lootTable = entity.lootTable or ""

		net.Start("ixPopulateLootentEditor")
			net.WriteEntity(entity)
			net.WriteData(lootTable, #lootTable)
		net.Send(client)
	end
})
