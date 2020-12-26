_is_color_sensor: ;_api/colorsensor.py
	glbl is_type
	ldloc.0
	glbl LPF2_FLIPPER_COLOR
	call 2
	ret
	
_get_port_device: ;_api/colorsensor.py
	glbl PORTS
	ldloc.0
	MP_BC_LOAD_SUBSCR
	attr device
	ret
	
_set_mode: ;_api/colorsensor.py
	ldloc.1
	128
	MP_BC_LOAD_SUBSCR
	stloc.3
	glbl len
	ldloc.1
	call 1
	129
	qt
	bfalse 6
	ldloc.1
	129
	MP_BC_LOAD_SUBSCR
	jmp 1
	ldloc.3
	stloc.4
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method mode
	call.meth 0
	ldloc.4
	ne
	bfalse 16
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method mode
	ldloc.3
	call.meth 1
	pop
	ldloc.2
	bfalse 17
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method mode
	ldloc.3
	ldloc.2
	call.meth 2
	pop
	none
	ret
	
_get_color: ;_api/colorsensor.py
	ldloc.0
	method _set_mode
	glbl _COMBI_MODE
	call.meth 1
	pop
	glbl get_sensor_value
	ldloc.0
	attr _port
	128
	none
	call 3
	stloc.1
	ldloc.1
	none
	is
	not
	bfalse 6
	glbl _COLORLIST
	ldloc.1
	MP_BC_LOAD_SUBSCR
	ret
	none
	ret
	
__init__: ;_api/colorsensor.py
	glbl isinstance
	ldloc.1
	glbl str
	call 2
	btrue 10
	glbl TypeError
	constobj 2
	ldloc.1
	mod
	call 1
	raiseobj
	ldloc.1
	glbl PORTS
	method keys
	call.meth 0
	in
	btrue 10
	glbl ValueError
	constobj 3
	ldloc.1
	mod
	call 1
	raiseobj
	glbl _is_color_sensor
	ldloc.1
	call 1
	btrue 10
	glbl RuntimeError
	constobj 4
	ldloc.1
	mod
	call 1
	raiseobj
	ldloc.1
	ldloc.0
	st.attr _port
	constobj 5
	ldloc.0
	st.attr _last_color
	ldloc.0
	method _set_mode
	glbl _COMBI_MODE
	call.meth 1
	pop
	none
	ret
	
get_color: ;_api/colorsensor.py
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _get_color
	call.meth 0
	ret
	
get_reflected_light: ;_api/colorsensor.py
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	glbl _COMBI_MODE
	call.meth 1
	pop
	glbl get_sensor_value
	ldloc.0
	attr _port
	129
	128
	call 3
	ret
	
get_rgb_intensity: ;_api/colorsensor.py
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	glbl _COMBI_MODE
	call.meth 1
	pop
	glbl tuple
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method get
	128
	call.meth 1
	130
	134
	slice 2
	MP_BC_LOAD_SUBSCR
	call 1
	ret
	
get_red: ;_api/colorsensor.py
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	glbl _COMBI_MODE
	call.meth 1
	pop
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method get
	128
	call.meth 1
	130
	MP_BC_LOAD_SUBSCR
	ret
	
get_green: ;_api/colorsensor.py
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	glbl _COMBI_MODE
	call.meth 1
	pop
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method get
	128
	call.meth 1
	131
	MP_BC_LOAD_SUBSCR
	ret
	
get_blue: ;_api/colorsensor.py
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	glbl _COMBI_MODE
	call.meth 1
	pop
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method get
	128
	call.meth 1
	132
	MP_BC_LOAD_SUBSCR
	ret
	
get_ambient_light: ;_api/colorsensor.py
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	glbl _AMBIENT_MODE
	call.meth 1
	pop
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method get
	call.meth 0
	128
	MP_BC_LOAD_SUBSCR
	ret
	
wait_until_color: ;_api/colorsensor.py
	ldloc.1
	none
	is
	btrue 20
	glbl isinstance
	ldloc.1
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	ldloc.1
	none
	is
	btrue 21
	ldloc.1
	glbl _COLORLIST
	in
	not
	bfalse 12
	glbl ValueError
	constobj 3
	glbl _COLORLIST
	mod
	call 1
	raiseobj
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _get_color
	call.meth 0
	ldloc.1
	eq
	bfalse 3
	jmp 10
	glbl sleep_ms
	138
	call 1
	pop
	jmp -42
	none
	ret
	
wait_for_new_color: ;_api/colorsensor.py
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _get_color
	call.meth 0
	stloc.1
	ldloc.1
	ldloc.0
	attr _last_color
	ne
	bfalse 7
	ldloc.1
	ldloc.0
	st.attr _last_color
	ldloc.1
	ret
	glbl sleep_ms
	138
	call 1
	pop
	jmp -51
	none
	ret
	
light_up_all: ;_api/colorsensor.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	glbl _LIGHT_MODE
	glbl bytes
	131
	glbl clamp
	ldloc.1
	128
	int 128, 100
	call 3
	list 1
	mul
	call 1
	call.meth 2
	pop
	none
	ret
	
<listcomp>: ;_api/colorsensor.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 16, 0
	stloc.1
	glbl clamp
	ldloc.1
	128
	int 128, 100
	call 3
	MP_BC_STORE_COMP 20
	jmp -19
	ret
	
light_up: ;_api/colorsensor.py
	ldloc.1
	ldloc.2
	ldloc.3
	tuple 3
	stloc.4
	128
	jmp 30
	dup
	stloc.5
	glbl isinstance
	ldloc.4
	ldloc.5
	MP_BC_LOAD_SUBSCR
	glbl int
	call 2
	btrue 12
	glbl TypeError
	constobj 4
	ldloc.5
	129
	add
	mod
	call 1
	raiseobj
	129
	add.in
	dup
	131
	lt
	btrue -36
	pop
	glbl _is_color_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	glbl _LIGHT_MODE
	glbl bytes
	mkfun 5
	ldloc.4
	call 1
	call 1
	call.meth 2
	pop
	none
	ret
	
ColorSensor: ;_api/colorsensor.py
	loadname __name__
	st.name __module__
	str ColorSensor
	st.name __qualname__
	none
	tuple 1
	null
	mkfun.defargs 0
	st.name _set_mode
	mkfun 1
	st.name _get_color
	mkfun 2
	st.name __init__
	mkfun 3
	st.name get_color
	mkfun 4
	st.name get_reflected_light
	mkfun 5
	st.name get_rgb_intensity
	mkfun 6
	st.name get_red
	mkfun 7
	st.name get_green
	mkfun 8
	st.name get_blue
	mkfun 9
	st.name get_ambient_light
	mkfun 10
	st.name wait_until_color
	mkfun 11
	st.name wait_for_new_color
	int 128, 100
	tuple 1
	null
	mkfun.defargs 12
	st.name light_up_all
	mkfun 13
	st.name light_up
	none
	ret
	
<module>: ;_api/colorsensor.py
	128
	str sleep_ms
	tuple 1
	import.nm utime
	import.from sleep_ms
	st.name sleep_ms
	pop
	128
	str is_type
	str get_sensor_value
	tuple 2
	import.nm util.sensors
	import.from is_type
	st.name is_type
	import.from get_sensor_value
	st.name get_sensor_value
	pop
	128
	str PORTS
	str LPF2_FLIPPER_COLOR
	tuple 2
	import.nm util.constants
	import.from PORTS
	st.name PORTS
	import.from LPF2_FLIPPER_COLOR
	st.name LPF2_FLIPPER_COLOR
	pop
	128
	str clamp
	tuple 1
	import.nm util.scratch
	import.from clamp
	st.name clamp
	pop
	129
	str newSensorDisconnectedError
	tuple 1
	import.nm util
	import.from newSensorDisconnectedError
	st.name newSensorDisconnectedError
	pop
	str black
	str violet
	none
	str blue
	str cyan
	str green
	none
	str yellow
	none
	str red
	str white
	list 11
	st.name _COLORLIST
	129
	128
	tuple 2
	128
	128
	tuple 2
	133
	128
	tuple 2
	133
	129
	tuple 2
	133
	130
	tuple 2
	133
	131
	tuple 2
	list 6
	tuple 1
	st.name _COMBI_MODE
	131
	131
	128
	tuple 2
	131
	129
	tuple 2
	131
	130
	tuple 2
	list 3
	tuple 2
	st.name _LIGHT_MODE
	130
	130
	128
	tuple 2
	list 1
	tuple 2
	st.name _AMBIENT_MODE
	mkfun 0
	st.name _is_color_sensor
	mkfun 1
	st.name _get_port_device
	buildclass
	mkfun 2
	str ColorSensor
	call 2
	st.name ColorSensor
	none
	ret
	