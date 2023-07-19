function Initialize()
	jsonLibPath = SKIN:GetVariable('@')..'Lua\\json.lua'
	JSON = assert(loadfile(SKIN:GetVariable('@')..'Lua\\json.lua'))()
    JSON.strictTypes = false
    JSON.strictParsing = false
end


function Update()
	measureJson = SKIN:GetMeasure('measureGetJson')
	-- measureJsonValue = measureJson:GetStringValue()
	key = JSON:decode(measureJson:GetStringValue())

	SKIN:Bang( '!SetVariable', 'temperature', key.current_weather.temperature )
	SKIN:Bang( '!SetVariable', 'windSpeed', key.current_weather.windspeed )
	SKIN:Bang( '!SetVariable', 'weatherCode', key.current_weather.weathercode )
	-- return tostring(key.current_weather.temperature)
end