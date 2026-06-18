### SALTYCHAT

saltychat/config.jso
```json
 "VoiceRanges": [ 3.0, 7.0, 15.0, 32.0 ],
```

### PMA-VOICE
- pma-voice/client/init/main.lua line 292.
```lua
if gameVersion == 'redm' then
	CreateThread(function()
		while true do
			if IsControlJustPressed(0, 0x80F28E95 --[[ "L" ]]) then ---- CHANGE VOICE RANGE PRESS KEY EXAMPLE "l"
				ExecuteCommand('cycleproximity')
			end
			if IsControlJustPressed(0, 0x430593AA --[[ Left Bracket ]]) then
				ExecuteCommand('+radiotalk')
			elseif IsControlJustReleased(0, 0x430593AA --[[ Left Bracket ]]) then
				ExecuteCommand('-radiotalk')
			end

			Wait(0)
		end
	end)
end
```

- pma-voice/shared.lua settings voice range
```lua
if GetConvar('voice_useNativeAudio', 'false') == 'true' then
	-- native audio distance seems to be larger then regular gta units
	Cfg.voiceModes = {
		{ 3.0,  "Whisper" }, -- Whisper speech distance in gta distance units
		{ 7.0,  "Normal" },  -- Normal speech distance in gta distance units
		{ 15.0,  "Shouting" },  -- Normal speech distance in gta distance units
		{ 32.0, "Shouting" } -- Shout speech distance in gta distance units
	}
else
	Cfg.voiceModes = {
		{ 3.0,  "Whisper" }, -- Whisper speech distance in gta distance units
		{ 7.0,  "Normal" },  -- Normal speech distance in gta distance units
		{ 15.0,  "Shouting" },  -- Normal speech distance in gta distance units
		{ 32.0, "Shouting" } -- Shout speech distance in gta distance units
	}
end
```