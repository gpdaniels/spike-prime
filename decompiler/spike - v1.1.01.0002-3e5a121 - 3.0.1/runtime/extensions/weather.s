update: ;runtime/extensions/weather.py
	ldloc.0
	method _call
	constobj 4
	map 3
	ldloc.2
	str hours
	st.map
	ldloc.1
	str location
	st.map
	ldloc.3
	str days
	st.map
	str timeout
	int 167, 8
	call.meth 130, 2
	ld.iter
	none
	yieldfrom
	stloc.4
	true
	ldloc.0
	st.attr _has_updated
	ldloc.4
	bfalse 15
	ldloc.4
	method get
	str weather
	glbl DEFAULT
	call.meth 2
	jmp 3
	glbl DEFAULT
	ldloc.0
	st.attr _forecast
	ldloc.4
	bfalse 13
	ldloc.4
	method get
	str location
	ldloc.1
	call.meth 2
	jmp 1
	ldloc.1
	stloc.5
	ldloc.4
	bfalse 12
	ldloc.4
	method get
	str offset
	call.meth 1
	jmp 1
	none
	stloc.6
	ldloc.0
	method _reschedule
	ldloc.1
	ldloc.6
	call.meth 2
	pop
	ldloc.5
	ldloc.6
	tuple 2
	ret
	
get_precipitation: ;runtime/extensions/weather.py
	ldloc.0
	method _validate
	ldloc.1
	ldloc.2
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	ldloc.0
	method _get
	constobj 3
	call.meth 1
	ret
	
get_pressure: ;runtime/extensions/weather.py
	ldloc.0
	method _validate
	ldloc.1
	ldloc.2
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	ldloc.0
	method _get
	str pressure
	call.meth 1
	ret
	
get_condition: ;runtime/extensions/weather.py
	ldloc.0
	method _validate
	ldloc.1
	ldloc.2
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	ldloc.0
	method _get
	str condition
	call.meth 1
	ret
	
get_temperature: ;runtime/extensions/weather.py
	ldloc.0
	method _validate
	ldloc.1
	ldloc.2
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	ldloc.0
	method _get
	constobj 3
	call.meth 1
	ret
	
get_wind_direction: ;runtime/extensions/weather.py
	ldloc.0
	method _validate
	ldloc.1
	ldloc.2
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	ldloc.0
	method _get
	constobj 3
	call.meth 1
	ret
	
get_wind_speed: ;runtime/extensions/weather.py
	ldloc.0
	method _validate
	ldloc.1
	ldloc.2
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	ldloc.0
	method _get
	str windSpeed
	call.meth 1
	ret
	
stop: ;runtime/extensions/weather.py
	ldloc.0
	attr _update_task
	bfalse 39
	except.setup 17, 0
	ldloc.0
	attr _loop
	method cancel
	ldloc.0
	attr _update_task
	call.meth 1
	pop
	except.jump 13, 0
	dup
	glbl TypeError
	ematch
	bfalse 4
	pop
	except.jump 1, 0
	finally.end
	ldloc.0
	null
	rot
	st.attr _update_task
	none
	ret
	
coro: ;runtime/extensions/weather.py
	128
	stloc.3
	jmp 11
	ldloc.3
	int 131, 116
	add.in
	stloc.3
	int 131, 116
	yield
	pop
	ldloc.3
	int 146, 167, 96
	lt
	btrue -20
	deref 0
	method update
	ldloc.1
	ldloc.2
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	none
	ret
	
_reschedule: ;runtime/extensions/weather.py
	deref 0
	method stop
	call.meth 0
	pop
	ldloc.1
	ldloc.2
	tuple 2
	null
	ldloc.0
	mkclosure.defargs 3, 1
	stloc.3
	ldloc.3
	call 0
	deref 0
	st.attr _update_task
	deref 0
	attr _loop
	method call_soon
	deref 0
	attr _update_task
	call.meth 1
	pop
	none
	ret
	
_validate: ;runtime/extensions/weather.py
	ldloc.0
	attr _has_updated
	btrue 12
	ldloc.0
	method update
	ldloc.1
	ldloc.2
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	none
	ret
	
_get: ;runtime/extensions/weather.py
	ldloc.0
	attr _forecast
	method get
	ldloc.1
	glbl DEFAULT
	ldloc.1
	MP_BC_LOAD_SUBSCR
	call.meth 2
	ret
	
WeatherExtension: ;runtime/extensions/weather.py
	loadname __name__
	st.name __module__
	str WeatherExtension
	st.name __qualname__
	loadname DEFAULT
	st.name _forecast
	none
	st.name _update_task
	false
	st.name _has_updated
	null
	map 0
	none
	str day_offset
	st.map
	mkfun.defargs 0
	st.name update
	mkfun 1
	st.name get_precipitation
	mkfun 2
	st.name get_pressure
	mkfun 3
	st.name get_condition
	mkfun 4
	st.name get_temperature
	mkfun 5
	st.name get_wind_direction
	mkfun 6
	st.name get_wind_speed
	mkfun 7
	st.name stop
	mkfun 8
	st.name _reschedule
	mkfun 9
	st.name _validate
	mkfun 10
	st.name _get
	none
	ret
	
<module>: ;runtime/extensions/weather.py
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	129
	str AbstractExtension
	tuple 1
	import.nm abstract_extension
	import.from AbstractExtension
	st.name AbstractExtension
	pop
	map 6
	128
	constobj 0
	st.map
	str 
	str condition
	st.map
	128
	constobj 1
	st.map
	str N
	constobj 2
	st.map
	128
	str windSpeed
	st.map
	128
	str pressure
	st.map
	st.name DEFAULT
	int 146, 167, 96
	st.name UPDATE_RATE
	int 131, 116
	st.name UPDATE_POLL_DELAY
	buildclass
	mkfun 3
	str WeatherExtension
	loadname AbstractExtension
	call 3
	st.name WeatherExtension
	none
	ret
	