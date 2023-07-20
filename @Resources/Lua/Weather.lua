function Initialize()
	dofile( SKIN:GetVariable( '@' )..'Lua\\json.lua' )
	measure = SKIN:GetMeasure( "MeasureGetData" )
	print( measure:GetOption('URL', 'API Url error') )
	
	first_run = true
end


function Update()
	-- We have no data to parse on first run, 
	-- because WebParser(MeasureGetData) doesn't retrive API data yet on first run (Initilize also started)
	if first_run then
		first_run = false
		print( 'First run...')
		return
	end

	json_string = measure:GetStringValue()

	if not json_string or string.len( json_string ) == 0 then
		print( "Error: Weather API returned: " .. json_string )
		return
	end

	local success, weather = pcall( decode_json, json_string )
	if not success then
		print( "Error from weather API: " .. ret )
		return
	end

	SKIN:Bang( '!SetVariable', 'weather_icon', weather.weather[1].icon )
	SKIN:Bang( '!SetVariable', 'weather_description', weather.weather[1].description )
	SKIN:Bang( '!SetVariable', 'current_temperature', weather.main.temp )
	SKIN:Bang( '!SetVariable', 'wind_speed', weather.wind.speed )
	SKIN:Bang( '!SetVariable', 'pressure', weather.main.grnd_level )
	SKIN:Bang( '!SetVariable', 'humidity', weather.main.humidity )
	SKIN:Bang( '!SetVariable', 'cloudiness', weather.clouds.all )
	SKIN:Bang( '!SetOption', 'MeasureSunrise', 'TimeStamp', weather.sys.sunrise + weather.timezone)
	SKIN:Bang( '!SetOption', 'MeasureSunset', 'TimeStamp', weather.sys.sunset + weather.timezone)

	-- return tostring( weather.main.temp ) .. '  ' .. tostring( weather.main.grnd_level ) .. '  ' .. tostring( weather.wind.speed )
end


function decode_json( json_string )
	print( json_string )
	return json_decode( json_string )
end