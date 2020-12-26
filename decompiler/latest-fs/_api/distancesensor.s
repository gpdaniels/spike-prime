_set_mode: ;_api/distancesensor.py
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
	ldloc.0
	attr _port
	attr device
	method mode
	call.meth 0
	ldloc.4
	ne
	bfalse 14
	ldloc.0
	attr _port
	attr device
	method mode
	ldloc.3
	call.meth 1
	pop
	ldloc.2
	bfalse 15
	ldloc.0
	attr _port
	attr device
	method mode
	ldloc.3
	ldloc.2
	call.meth 2
	pop
	none
	ret
	
_set_range_mode: ;_api/distancesensor.py
	ldloc.0
	method _set_mode
	ldloc.1
	bfalse 7
	ldloc.0
	attr _SHORT_RANGE_MODE
	jmp 4
	ldloc.0
	attr _LONG_RANGE_MODE
	call.meth 1
	pop
	none
	ret
	
_is_distance_sensor: ;_api/distancesensor.py
	glbl is_type
	ldloc.1
	none
	is
	bfalse 7
	ldloc.0
	attr _port_str
	jmp 1
	ldloc.1
	glbl LPF2_FLIPPER_DISTANCE
	call 2
	ret
	
__init__: ;_api/distancesensor.py
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
	ldloc.0
	method _is_distance_sensor
	ldloc.1
	call.meth 1
	btrue 10
	glbl RuntimeError
	constobj 4
	ldloc.1
	mod
	call 1
	raiseobj
	ldloc.1
	ldloc.0
	st.attr _port_str
	glbl PORTS
	ldloc.1
	MP_BC_LOAD_SUBSCR
	ldloc.0
	st.attr _port
	none
	ret
	
get_distance_cm: ;_api/distancesensor.py
	glbl isinstance
	ldloc.1
	glbl bool
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	ldloc.0
	method _is_distance_sensor
	call.meth 0
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_range_mode
	ldloc.1
	call.meth 1
	pop
	ldloc.0
	attr _port
	attr device
	method get
	130
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	ret
	
get_distance_inches: ;_api/distancesensor.py
	glbl isinstance
	ldloc.1
	glbl bool
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	ldloc.0
	method _is_distance_sensor
	call.meth 0
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method get_distance_cm
	ldloc.1
	call.meth 1
	stloc.2
	ldloc.2
	bfalse 10
	glbl round
	ldloc.2
	constobj 3
	truediv
	call 1
	ret
	none
	ret
	
get_distance_percentage: ;_api/distancesensor.py
	glbl isinstance
	ldloc.1
	glbl bool
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	ldloc.0
	method _is_distance_sensor
	call.meth 0
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_range_mode
	ldloc.1
	call.meth 1
	pop
	ldloc.0
	attr _port
	attr device
	method get
	129
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	ret
	
wait_for_distance_farther_than: ;_api/distancesensor.py
	glbl isinstance
	ldloc.1
	glbl int
	glbl float
	tuple 2
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 5
	call 1
	raiseobj
	glbl isinstance
	ldloc.3
	glbl bool
	call 2
	btrue 8
	glbl TypeError
	constobj 6
	call 1
	raiseobj
	ldloc.2
	str cm
	str in
	str %
	tuple 3
	in
	not
	bfalse 22
	glbl ValueError
	constobj 7
	str cm
	str in
	str %
	tuple 3
	tuple 1
	mod
	call 1
	raiseobj
	ldloc.0
	method _is_distance_sensor
	call.meth 0
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.2
	str in
	eq
	bfalse 5
	ldloc.1
	constobj 8
	mul
	stloc.1
	ldloc.0
	method _set_range_mode
	ldloc.3
	call.meth 1
	pop
	ldloc.0
	attr _port
	attr device
	method get
	ldloc.2
	str %
	eq
	bfalse 4
	129
	jmp 1
	130
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	stloc.4
	ldloc.4
	none
	is
	btrue 6
	ldloc.4
	ldloc.1
	qt
	bfalse 3
	jmp 22
	ldloc.4
	128
	eq
	bfalse 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl sleep_ms
	138
	call 1
	pop
	jmp -65
	none
	ret
	
wait_for_distance_closer_than: ;_api/distancesensor.py
	glbl isinstance
	ldloc.1
	glbl int
	glbl float
	tuple 2
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 5
	call 1
	raiseobj
	glbl isinstance
	ldloc.3
	glbl bool
	call 2
	btrue 8
	glbl TypeError
	constobj 6
	call 1
	raiseobj
	ldloc.2
	str cm
	str in
	str %
	tuple 3
	in
	not
	bfalse 22
	glbl ValueError
	constobj 7
	str cm
	str in
	str %
	tuple 3
	tuple 1
	mod
	call 1
	raiseobj
	ldloc.0
	method _is_distance_sensor
	call.meth 0
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.2
	str in
	eq
	bfalse 5
	ldloc.1
	constobj 8
	mul
	stloc.1
	ldloc.0
	method _set_range_mode
	ldloc.3
	call.meth 1
	pop
	ldloc.0
	attr _port
	attr device
	method get
	ldloc.2
	str %
	eq
	bfalse 4
	129
	jmp 1
	130
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	stloc.4
	ldloc.4
	none
	is
	btrue 21
	ldloc.4
	128
	eq
	bfalse 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.4
	ldloc.1
	lt
	bfalse 3
	jmp 10
	glbl sleep_ms
	138
	call 1
	pop
	jmp -65
	none
	ret
	
light_up_all: ;_api/distancesensor.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	ldloc.0
	method _is_distance_sensor
	call.meth 0
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	ldloc.0
	attr _LIGHT_MODE
	glbl bytes
	132
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
	
<listcomp>: ;_api/distancesensor.py
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
	
light_up: ;_api/distancesensor.py
	str left_top
	str right_top
	str left_bottom
	str right_bottom
	list 4
	stloc.5
	ldloc.2
	ldloc.1
	ldloc.4
	ldloc.3
	list 4
	stloc.6
	129
	128
	131
	130
	list 4
	ld.iterstack
	for.iter 30, 0
	stloc.7
	glbl isinstance
	ldloc.6
	ldloc.7
	MP_BC_LOAD_SUBSCR
	glbl int
	call 2
	btrue 12
	glbl TypeError
	constobj 5
	ldloc.5
	ldloc.7
	MP_BC_LOAD_SUBSCR
	mod
	call 1
	raiseobj
	jmp -33
	ldloc.0
	method _is_distance_sensor
	call.meth 0
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _set_mode
	ldloc.0
	attr _LIGHT_MODE
	glbl bytes
	mkfun 6
	ldloc.6
	call 1
	call 1
	call.meth 2
	pop
	none
	ret
	
DistanceSensor: ;_api/distancesensor.py
	loadname __name__
	st.name __module__
	str DistanceSensor
	st.name __qualname__
	128
	128
	128
	tuple 2
	list 1
	tuple 2
	st.name _LONG_RANGE_MODE
	129
	129
	128
	tuple 2
	list 1
	tuple 2
	st.name _SHORT_RANGE_MODE
	133
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
	list 4
	tuple 2
	st.name _LIGHT_MODE
	none
	tuple 1
	null
	mkfun.defargs 0
	st.name _set_mode
	mkfun 1
	st.name _set_range_mode
	none
	tuple 1
	null
	mkfun.defargs 2
	st.name _is_distance_sensor
	mkfun 3
	st.name __init__
	false
	tuple 1
	null
	mkfun.defargs 4
	st.name get_distance_cm
	false
	tuple 1
	null
	mkfun.defargs 5
	st.name get_distance_inches
	false
	tuple 1
	null
	mkfun.defargs 6
	st.name get_distance_percentage
	str cm
	st.name CM
	str in
	st.name IN
	str %
	st.name PERCENT
	str cm
	false
	tuple 2
	null
	mkfun.defargs 7
	st.name wait_for_distance_farther_than
	str cm
	false
	tuple 2
	null
	mkfun.defargs 8
	st.name wait_for_distance_closer_than
	int 128, 100
	tuple 1
	null
	mkfun.defargs 9
	st.name light_up_all
	mkfun 10
	st.name light_up
	none
	ret
	
<module>: ;_api/distancesensor.py
	128
	str sleep_ms
	tuple 1
	import.nm utime
	import.from sleep_ms
	st.name sleep_ms
	pop
	128
	str is_type
	tuple 1
	import.nm util.sensors
	import.from is_type
	st.name is_type
	pop
	128
	str PORTS
	str LPF2_FLIPPER_DISTANCE
	tuple 2
	import.nm util.constants
	import.from PORTS
	st.name PORTS
	import.from LPF2_FLIPPER_DISTANCE
	st.name LPF2_FLIPPER_DISTANCE
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
	buildclass
	mkfun 0
	str DistanceSensor
	call 2
	st.name DistanceSensor
	none
	ret
	