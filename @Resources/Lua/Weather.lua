function Initialize()
	dofile( SKIN:GetVariable( '@' )..'Lua\\json.lua' )
	measure = SKIN:GetMeasure( "MeasureGetCurrentData" )
	print( '[Current] ' .. measure:GetOption('URL', 'API Url error') )
	
end


function Update()

	json_string = measure:GetStringValue()

	if not json_string or string.len( json_string ) == 0 then
		print( "[Current] Error: Weather API returned: " .. json_string )
		return
	end

	local success, weather = pcall( decode_json, json_string )
	if not success then
		print( "[Current] Error from weather API: " .. ret )
		return
	end

	SKIN:Bang( '!SetVariable', 'weather_icon', weather.weather[1].icon )
	SKIN:Bang( '!SetVariable', 'weather_description1', weather.weather[1].description:sub(1,1) )
	SKIN:Bang( '!SetVariable', 'weather_description2', weather.weather[1].description:sub(2) )
	SKIN:Bang( '!SetVariable', 'current_temperature', weather.main.temp )
	SKIN:Bang( '!SetVariable', 'wind_speed', weather.wind.speed )
	SKIN:Bang( '!SetVariable', 'pressure', weather.main.grnd_level )
	SKIN:Bang( '!SetVariable', 'humidity', weather.main.humidity )
	SKIN:Bang( '!SetVariable', 'cloudiness', weather.clouds.all )
	SKIN:Bang( '!SetOption', 'MeasureSunrise', 'TimeStamp', weather.sys.sunrise + weather.timezone)
	SKIN:Bang( '!SetOption', 'MeasureSunset', 'TimeStamp', weather.sys.sunset + weather.timezone)

	return weather.weather[1].icon
end


function decode_json( json_string )
	print( json_string )
	return json_decode( json_string )
end