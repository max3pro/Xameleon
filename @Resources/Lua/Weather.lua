function Initialize()
	dofile( SKIN:GetVariable( '@' )..'Lua\\json.lua' )
	measure = SKIN:GetMeasure( "MeasureGetData" )
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

	local success, weather_data = pcall( decodeData, json_string )
	if not success then
		print( "Error from weather API: " .. ret )
		return
	end

	return tostring( weather_data.current_weather.temperature ) .. '  ' .. tostring( weather_data.current_weather.windspeed )
end


function decodeData( json_string )
	print( json_string )
	return json_decode( json_string )
end