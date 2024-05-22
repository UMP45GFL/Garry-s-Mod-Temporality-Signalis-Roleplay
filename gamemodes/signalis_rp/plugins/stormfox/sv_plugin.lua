
hook.Add("StormFox.PostEntity", "ixStormFox", function()
	RunConsoleCommand("sf_timespeed", 60 / (ix.date.timeScale or ix.config.Get("secondsPerMinute", 1)))

	if StormFox2 then
		StormFox2.Time.Set(StormFox2.Time.StringToTime(ix.date.GetFormatted("%H:%M %p")))
	elseif StormFox then
		StormFox.SetTime(ix.date.GetFormatted("%H:%M %p"))
	end
end)

-- Override for changing timescale mid-game.
local oldUpdate = ix.date.UpdateTimescale
function ix.date.UpdateTimescale(value)
	oldUpdate(value)

	RunConsoleCommand("sf_timespeed", 60 / (ix.date.timeScale or ix.config.Get("secondsPerMinute", 1)))
end

local oldSend = ix.date.Send
function ix.date.Send(client)
	oldSend(client)

	if StormFox2 then
		StormFox2.Time.Set(StormFox2.Time.StringToTime(ix.date.GetFormatted("%H:%M %p")))
	elseif StormFox then
		StormFox.SetTime(ix.date.GetFormatted("%H:%M %p"))
	end
end
