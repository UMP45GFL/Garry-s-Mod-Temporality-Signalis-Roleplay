﻿
hook.Add("InitializedConfig", "BioresonanceTelepathy", function()

    -- Telepathy around chat.
    ix.chat.Register("t", {
        format = "%s says telepathically \"%s\"",
        GetColor = function(self, speaker, text)
            local color = ix.chat.classes.ic:GetColor(speaker, text)

            return Color(color.r, color.g - 45, color.b - 45)
        end,
        CanHear = function(self, speaker, listener)
            local dist = speaker:GetPos():Distance(listener:GetPos())

            if (dist <= ix.config.Get("chatRange", 280) * 0.4) then
                return true
            end

            return false
        end,
        CanSay = function(self, speaker, text)
            return speaker:IsBioresonant()
        end,
        prefix = {"/T", "/Telepathy"},
        description = "@cmdT"
    })

    ix.chat.Register("tpm", {
        format = "[TPM] %s -> %s: %s",
        color = Color(125, 150, 75, 255),
        OnChatAdd = function(self, speaker, text, bAnonymous, data)
            chat.AddText(self.color, string.format(self.format, speaker:GetName(), data.target:GetName(), text))
        end,
        CanHear = function(self, speaker, listener)
            local dist = speaker:GetPos():Distance(listener:GetPos())

            if (dist <= ix.config.Get("chatRange", 280) * 0.4) then
                return true
            end

            return false
        end,
        CanSay = function(self, speaker, text)
            return speaker:IsBioresonant()
        end
    })

    -- Telepathy to one person
    ix.command.Add("TPM", {
        description = "@cmdTPM",
        arguments = {
            ix.type.player,
            ix.type.text
        },
        OnRun = function(self, client, target, message)
            if client != target then
			    ix.chat.Send(client, "tpm", message, false, {client, target}, {target = target})
            end
        end
    })
end)
