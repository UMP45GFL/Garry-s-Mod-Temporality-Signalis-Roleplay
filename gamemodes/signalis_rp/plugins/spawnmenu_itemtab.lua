PLUGIN.name = "Spawn Menu: Items"; 
PLUGIN.author = "Rune Knight";
PLUGIN.description = "Adds a tab to the spawn menu which players can use to spawn items.";
PLUGIN.license = [[Copyright 2021 Rune Knight

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.]];

--[[
	STEAM: https://steamcommunity.com/profiles/76561198028996329/
	DISCORD: Rune Knight#5972
]]

CAMI.RegisterPrivilege({
	Name = "Spawn Menu: Items - Spawning",
	MinAccess = "admin"
})

local iconTab = {
	[1] = {"Ammunition", "icon16/tab.png"}, -- :shrug:
	[2] = {"Weapons", "icon16/gun.png"},

	[10] = {"Clothing", "icon16/user_suit.png"},
	[11] = {"Consumables", "icon16/pill.png"},
	[12] = {"Medical", "icon16/heart.png"},

	[20] = {"Storage", "icon16/package.png"},

	[30] = {"Permits", "icon16/note.png"},
	[31] = {"Documents", "icon16/newspaper_delete.png"},
	[32] = {"Writing", "icon16/newspaper_add.png"},
	[33] = {"Photos", "icon16/photo.png"},
	[34] = {"Cards", "icon16/vcard.png"},

	[40] = {"Keys", "icon16/key.png"},
	[41] = {"Tools", "icon16/wrench.png"},
	[42] = {"Technical", "icon16/cog.png"},
	
	[50] = {"Miscellaneous", "icon16/error.png"},
};

function PLUGIN:GetExpectedIcon(s)
	for k,v in pairs(iconTab) do
		if v[1] == s then
			return v[2];
		end
	end

	return hook.Run("GetIconsForSpawnMenuItems", s) or "icon16/folder.png";
end

if(SERVER) then
	util.AddNetworkString("spawnmenuspawnitem");

	ix.log.AddType("spawnmenuspawnitem", function(client, name)
		return string.format("%s has spawned \"%s\".", client:GetCharacter():GetName(), tostring(name))
	end);

	net.Receive("spawnmenuspawnitem", function(len, client)
		local u = net.ReadString();
		if(!CAMI.PlayerHasAccess(client, "Spawn Menu: Items - Spawning", nil)) then return end;
		for _, t in pairs(ix.item.list) do
			if(t.uniqueID == u) then
				ix.item.Spawn(t.uniqueID, client:GetShootPos() + client:GetAimVector() * 84 + Vector(0, 0, 16));
				ix.log.Add(client, "spawnmenuspawnitem", t.name)
				break;
			end
		end
	end);
else
	function PLUGIN:InitializedPlugins()
		if(SERVER) then return end;
		RunConsoleCommand("spawnmenu_reload"); -- If someone legit knows how to insert stuff into the spawn menu without breaking it or doing it before the spawn menu is created, please tell me. Otherwise, this is the best I got.
	end

	local PLUGIN = PLUGIN;

	spawnmenu.AddCreationTab("Items", function()
		local p = vgui.Create("SpawnmenuContentPanel");
		local t, n = p.ContentNavBar.Tree, p.OldSpawnlists;
	
		local categoryList = {};

		local miscPriority = nil;
		for i, v in pairs(iconTab) do
			if v[1] == "Miscellaneous" then
				miscPriority = i;
			end
		end

		for uid, item in pairs(ix.item.list) do
			local found = false

			for i, v in pairs(iconTab) do
				if v[1] == item.category then
					categoryList[i] = categoryList[i] or {};
					table.ForceInsert(categoryList[i], item);
					found = true;
					break;
				end
			end

			if !found then
				categoryList[miscPriority] = categoryList[miscPriority] or {};
				table.ForceInsert(categoryList[miscPriority], item);
			end
		end

		for priority, itemList in SortedPairs(categoryList) do
			local categ = iconTab[priority][1];

			local icon16 = PLUGIN:GetExpectedIcon(categ);
			local node = t:AddNode(L(categ), icon16)
			node.DoClick = function(self)
				if(self.PropPanel and IsValid(self.PropPanel)) then 
					self.PropPanel:Remove()
					self.PropPanel = nil;
				end;

				self.PropPanel = vgui.Create("ContentContainer", p);
				self.PropPanel:SetVisible(false);
				self.PropPanel:SetTriggerSpawnlistChange(false);
	
				for k, item in SortedPairsByMemberValue(itemList, "name") do
					spawnmenu.CreateContentIcon("item", self.PropPanel, {
						nicename = (item.GetName and item:GetName()) or item.name,
						spawnname = item.uniqueID,
					})
				end
	
				p:SwitchPanel(self.PropPanel);
			end
		end
	
		local FirstNode = t:Root():GetChildNode(0);
		if (IsValid(FirstNode)) then
			FirstNode:InternalDoClick();
		end
	
		return p;
	
	end, "icon16/cog_add.png", 201);

	spawnmenu.AddContentType("item", function(p, data)
		local n = data.nicename;
		local u = data.spawnname;
		
		local icon = vgui.Create("SpawnIcon", p);
		icon:SetWide(128);
		icon:SetTall(128);
		icon:InvalidateLayout(true);

		local t = ix.item.list;
		local i = t[u];

		local mdl = (i.GetModel and i:GetModel()) or i.model;
		local skin = (i.GetSkin and i:GetSkin()) or i.skin or 0;
		local bdgroups = (i.GetBodyGroups and i:GetBodyGroups()) or i.bodyGroups;

		icon:SetModel(mdl, skin, bdgroups);
		icon:SetTooltip(n);

		icon.DoClick = function(s) 
			surface.PlaySound("ui/buttonclickrelease.wav");
			if(!CAMI.PlayerHasAccess(LocalPlayer(), "Spawn Menu: Items - Spawning", nil)) then 
				return;
			end

			net.Start("spawnmenuspawnitem");
				net.WriteString(u);
			net.SendToServer();
		end

		icon:InvalidateLayout(true);

		if (IsValid(p)) then
			p:Add(icon)
		end

		return icon;
	end);
end
