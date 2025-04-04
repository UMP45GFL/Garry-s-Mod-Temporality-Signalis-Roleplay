
local PLUGIN = PLUGIN

PLUGIN.name = "Stamina Effect"
PLUGIN.description = "Creates a Effect for when you are about and when you are out of Stamina."
PLUGIN.author = "Riggs Mackay"
PLUGIN.schema = "Any"
PLUGIN.license = [[
Copyright 2022 Riggs Mackay

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

function PLUGIN:PlayerTick(ply)
    if not ply.NextStaminaBreathe or ply.NextStaminaBreathe <= CurTime() then
        local stamina = ply:GetNetVar("stm", 100)
        if stamina <= 10 then
            local breathingSound = {
                snd = "player/breathe1.wav",
                volume = 1,
                sndLevel = 60,
                pitch = 100
            }

            local character = ply:GetCharacter()
            if character then
                local class = ix.class.GetClass(character.vars.class)
                if class and class.breathing_sound then
                    if istable(class.breathing_sound) then
                        breathingSound = class.breathing_sound

                    elseif isfunction(class.breathing_sound) and class.breathing_sound(ply) then
                        breathingSound = class.breathing_sound(ply)
                    end
                end

                if character.vars.faction == "gestalt" and isnumber(character.vars.pitch) then
                    local minPitch = breathingSound.minPitch or 90
                    local maxPitch = breathingSound.maxPitch or 110
                    breathingSound.pitch = math.Clamp(character.vars.pitch, minPitch, maxPitch)
                end
            end

            ply:EmitSound("player/heartbeat1.wav", 60)
            ply:EmitSound(breathingSound.snd, breathingSound.sndLevel, breathingSound.pitch, breathingSound.volume)
            
            ply.ixStaminaBreathe = true
            timer.Simple(3.9, function()
                if ply:IsValid() then
                    ply:StopSound("player/heartbeat1.wav")
                    ply:StopSound(breathingSound.snd)
                    ply.ixStaminaBreathe = false
                end
            end)
            ply.NextStaminaBreathe = CurTime() + 4
        end
    end
end

if (CLIENT) then
    local staminabluralpha = 0
    local staminabluramount = 0
    local staminablurmaxamount = 5
    
    function PLUGIN:HUDPaint()
        local frametime = RealFrameTime()
        
        if (ix.option.Get("cheapBlur", false)) then
            staminablurmaxamount = 10
        end
        
        if (LocalPlayer().ixStaminaBreathe) then
            staminabluralpha = Lerp(frametime / 2, staminabluralpha, 255)
            staminabluramount = Lerp(frametime / 2, staminabluramount, staminablurmaxamount)
        else
            staminabluralpha = Lerp(frametime / 2, staminabluralpha, 0)
            staminabluramount = Lerp(frametime / 2, staminabluramount, 0)
        end
        
        ix.util.DrawBlurAt(0, 0, ScrW(), ScrH(), staminabluramount, 0.2, staminabluralpha)
    end
end
