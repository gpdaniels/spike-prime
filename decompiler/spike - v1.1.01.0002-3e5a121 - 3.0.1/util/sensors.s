<listcomp>: ;util/sensors.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 13, 0
	stloc.1
	ldloc.1
	str map_in
	MP_BC_LOAD_SUBSCR
	132
	eq
	MP_BC_STORE_COMP 20
	jmp -16
	ret
	
_port_type_update: ;util/sensors.py
	glbl _PORTS
	ldloc.0
	MP_BC_LOAD_SUBSCR
	method info
	call.meth 0
	stloc.1
	ldloc.1
	str type
	MP_BC_LOAD_SUBSCR
	btrue.pop 1
	128
	stloc.2
	glbl hasattr
	ldloc.1
	str modes
	call 2
	bfalse 12
	mkfun 1
	ldloc.1
	str modes
	MP_BC_LOAD_SUBSCR
	call 1
	jmp 2
	list 0
	stloc.3
	ldloc.2
	glbl _PORT_TYPE
	ldloc.0
	MP_BC_STORE_SUBSCR
	ldloc.3
	glbl _EVENT_MODE
	ldloc.0
	MP_BC_STORE_SUBSCR
	glbl _PORTS
	ldloc.0
	MP_BC_LOAD_SUBSCR
	attr device
	stloc.4
	ldloc.4
	bfalse 24
	glbl _DEFAULT_MODE
	method get
	ldloc.2
	128
	128
	tuple 2
	list 1
	call.meth 2
	stloc.5
	ldloc.4
	method mode
	ldloc.5
	call.meth 1
	pop
	none
	ret
	
register_ports: ;util/sensors.py
	glbl len
	glbl _PORTS
	call 1
	128
	jmp 19
	dup
	stloc.1
	ldloc.0
	ldloc.1
	MP_BC_LOAD_SUBSCR
	method register_persistent
	glbl _type_change_handler
	ldloc.1
	call 1
	call.meth 1
	pop
	129
	add.in
	dup2
	rot
	lt
	btrue -25
	pop
	pop
	none
	ret
	
update_sensor_data: ;util/sensors.py
	glbl hub
	method status
	call.meth 0
	stloc.0
	ldloc.0
	str port
	MP_BC_LOAD_SUBSCR
	stloc.1
	glbl sensor_data
	stloc.2
	glbl _NO_DATA
	stloc.3
	glbl _PORT_TYPE
	128
	MP_BC_LOAD_SUBSCR
	ldloc.2
	128
	MP_BC_LOAD_SUBSCR
	128
	MP_BC_STORE_SUBSCR
	ldloc.1
	str A
	MP_BC_LOAD_SUBSCR
	bfalse 8
	ldloc.1
	str A
	MP_BC_LOAD_SUBSCR
	jmp 1
	ldloc.3
	ldloc.2
	128
	MP_BC_LOAD_SUBSCR
	129
	MP_BC_STORE_SUBSCR
	glbl _PORT_TYPE
	129
	MP_BC_LOAD_SUBSCR
	ldloc.2
	129
	MP_BC_LOAD_SUBSCR
	128
	MP_BC_STORE_SUBSCR
	ldloc.1
	str B
	MP_BC_LOAD_SUBSCR
	bfalse 8
	ldloc.1
	str B
	MP_BC_LOAD_SUBSCR
	jmp 1
	ldloc.3
	ldloc.2
	129
	MP_BC_LOAD_SUBSCR
	129
	MP_BC_STORE_SUBSCR
	glbl _PORT_TYPE
	130
	MP_BC_LOAD_SUBSCR
	ldloc.2
	130
	MP_BC_LOAD_SUBSCR
	128
	MP_BC_STORE_SUBSCR
	ldloc.1
	str C
	MP_BC_LOAD_SUBSCR
	bfalse 8
	ldloc.1
	str C
	MP_BC_LOAD_SUBSCR
	jmp 1
	ldloc.3
	ldloc.2
	130
	MP_BC_LOAD_SUBSCR
	129
	MP_BC_STORE_SUBSCR
	glbl _PORT_TYPE
	131
	MP_BC_LOAD_SUBSCR
	ldloc.2
	131
	MP_BC_LOAD_SUBSCR
	128
	MP_BC_STORE_SUBSCR
	ldloc.1
	str D
	MP_BC_LOAD_SUBSCR
	bfalse 8
	ldloc.1
	str D
	MP_BC_LOAD_SUBSCR
	jmp 1
	ldloc.3
	ldloc.2
	131
	MP_BC_LOAD_SUBSCR
	129
	MP_BC_STORE_SUBSCR
	glbl _PORT_TYPE
	132
	MP_BC_LOAD_SUBSCR
	ldloc.2
	132
	MP_BC_LOAD_SUBSCR
	128
	MP_BC_STORE_SUBSCR
	ldloc.1
	str E
	MP_BC_LOAD_SUBSCR
	bfalse 8
	ldloc.1
	str E
	MP_BC_LOAD_SUBSCR
	jmp 1
	ldloc.3
	ldloc.2
	132
	MP_BC_LOAD_SUBSCR
	129
	MP_BC_STORE_SUBSCR
	glbl _PORT_TYPE
	133
	MP_BC_LOAD_SUBSCR
	ldloc.2
	133
	MP_BC_LOAD_SUBSCR
	128
	MP_BC_STORE_SUBSCR
	ldloc.1
	str F
	MP_BC_LOAD_SUBSCR
	bfalse 8
	ldloc.1
	str F
	MP_BC_LOAD_SUBSCR
	jmp 1
	ldloc.3
	ldloc.2
	133
	MP_BC_LOAD_SUBSCR
	129
	MP_BC_STORE_SUBSCR
	ldloc.0
	constobj 0
	MP_BC_LOAD_SUBSCR
	ldloc.2
	134
	MP_BC_STORE_SUBSCR
	ldloc.0
	str gyroscope
	MP_BC_LOAD_SUBSCR
	ldloc.2
	135
	MP_BC_STORE_SUBSCR
	ldloc.0
	str position
	MP_BC_LOAD_SUBSCR
	ldloc.2
	136
	MP_BC_STORE_SUBSCR
	glbl _SYNC_DISPLAY
	bfalse 8
	ldloc.0
	str display
	MP_BC_LOAD_SUBSCR
	jmp 3
	str 
	ldloc.2
	137
	MP_BC_STORE_SUBSCR
	glbl get_time
	call 0
	ldloc.2
	138
	MP_BC_STORE_SUBSCR
	none
	ret
	
_is_motor: ;util/sensors.py
	ldloc.0
	glbl _MOTOR_TYPES
	in
	ret
	
get_sensor_value: ;util/sensors.py
	ldloc.3
	bfalse 13
	glbl is_type
	ldloc.0
	ldloc.3
	null
	call.kw 1
	btrue 2
	ldloc.2
	ret
	except.setup 163, 0
	glbl _PORT_INDEX_MAP
	method index
	ldloc.0
	method upper
	call.meth 0
	call.meth 1
	stloc.4
	ldloc.4
	134
	lt
	bfalse 53
	glbl _PORT_TYPE
	ldloc.4
	MP_BC_LOAD_SUBSCR
	stloc.5
	glbl _REVERSE_MODES
	method get
	ldloc.5
	call.meth 1
	stloc.6
	ldloc.6
	btrue 2
	ldloc.2
	ret
	ldloc.6
	ldloc.1
	MP_BC_LOAD_SUBSCR
	stloc.7
	glbl _PORTS
	ldloc.4
	MP_BC_LOAD_SUBSCR
	attr device
	method get
	call.meth 0
	ldloc.7
	MP_BC_LOAD_SUBSCR
	stloc.8
	ldloc.8
	none
	is
	not
	bfalse 2
	ldloc.8
	ret
	ldloc.2
	ret
	ldloc.4
	134
	eq
	bfalse 12
	glbl hub
	attr motion
	method accelerometer
	call.meth 0
	ret
	ldloc.4
	135
	eq
	bfalse 12
	glbl hub
	attr motion
	method gyroscope
	call.meth 0
	ret
	ldloc.4
	136
	eq
	bfalse 12
	glbl hub
	attr motion
	method yaw_pitch_roll
	call.meth 0
	ret
	ldloc.4
	137
	eq
	bfalse 12
	glbl hub
	attr motion
	method orientation
	call.meth 0
	ret
	ldloc.4
	138
	eq
	bfalse 6
	glbl get_time
	call 0
	ret
	ldloc.2
	ret
	except.jump 7, 0
	pop
	ldloc.2
	ret
	except.jump 1, 0
	finally.end
	none
	ret
	
is_type: ;util/sensors.py
	except.setup 45, 0
	glbl isinstance
	ldloc.0
	glbl str
	call 2
	bfalse 15
	glbl _PORT_INDEX_MAP
	method index
	ldloc.0
	method upper
	call.meth 0
	call.meth 1
	stloc.0
	ldloc.1
	method index
	glbl _PORT_TYPE
	ldloc.0
	MP_BC_LOAD_SUBSCR
	call.meth 1
	none
	is
	not
	ret
	except.jump 20, 0
	dup
	glbl ValueError
	glbl IndexError
	tuple 2
	ematch
	bfalse 6
	pop
	false
	ret
	except.jump 1, 0
	finally.end
	none
	ret
	
update_battery_status: ;util/sensors.py
	glbl hub
	attr battery
	stloc.0
	glbl battery_status
	stloc.1
	ldloc.0
	method voltage
	call.meth 0
	int 135, 104
	truediv
	ldloc.1
	128
	MP_BC_STORE_SUBSCR
	ldloc.0
	method capacity_left
	call.meth 0
	ldloc.1
	129
	MP_BC_STORE_SUBSCR
	none
	ret
	
callback: ;util/sensors.py
	ldloc.1
	glbl hub
	attr port
	attr ATTACHED
	is
	bfalse 8
	glbl _port_type_update
	deref 0
	call 1
	pop
	ldloc.1
	glbl hub
	attr port
	attr DETACHED
	is
	bfalse 15
	128
	glbl _PORT_TYPE
	deref 0
	MP_BC_STORE_SUBSCR
	list 0
	glbl _EVENT_MODE
	deref 0
	MP_BC_STORE_SUBSCR
	none
	ret
	
_type_change_handler: ;util/sensors.py
	ldloc.0
	mkclosure 1, 1
	stloc.1
	ldloc.1
	ret
	
reset_to_default_mode: ;util/sensors.py
	ldloc.0
	method info
	call.meth 0
	str type
	MP_BC_LOAD_SUBSCR
	stloc.1
	ldloc.0
	attr device
	stloc.2
	ldloc.1
	bfalse 28
	ldloc.2
	bfalse 24
	glbl _DEFAULT_MODE
	method get
	ldloc.1
	128
	128
	tuple 2
	list 1
	call.meth 2
	stloc.3
	ldloc.2
	method mode
	ldloc.3
	call.meth 1
	pop
	none
	ret
	
set_display_sync: ;util/sensors.py
	ldloc.0
	st.glbl _SYNC_DISPLAY
	none
	ret
	
current_motion: ;util/sensors.py
	glbl hub
	attr motion
	method gesture
	call.meth 0
	ret
	
<module>: ;util/sensors.py
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	str get_time
	tuple 1
	import.nm util.time
	import.from get_time
	st.name get_time
	pop
	128
	none
	import.nm hub
	st.name hub
	129
	str LPF2_FLIPPER_COLOR
	str LPF2_FLIPPER_DISTANCE
	str LPF2_FLIPPER_FORCE
	str LPF2_FLIPPER_MOTOR_LARGE
	str LPF2_FLIPPER_MOTOR_MEDIUM
	str LPF2_FLIPPER_MOTOR_SMALL
	str LPF2_STONE_GREY_MOTOR_LARGE
	str LPF2_STONE_GREY_MOTOR_MEDIUM
	tuple 8
	import.nm constants
	import.from LPF2_FLIPPER_COLOR
	st.name LPF2_FLIPPER_COLOR
	import.from LPF2_FLIPPER_DISTANCE
	st.name LPF2_FLIPPER_DISTANCE
	import.from LPF2_FLIPPER_FORCE
	st.name LPF2_FLIPPER_FORCE
	import.from LPF2_FLIPPER_MOTOR_LARGE
	st.name LPF2_FLIPPER_MOTOR_LARGE
	import.from LPF2_FLIPPER_MOTOR_MEDIUM
	st.name LPF2_FLIPPER_MOTOR_MEDIUM
	import.from LPF2_FLIPPER_MOTOR_SMALL
	st.name LPF2_FLIPPER_MOTOR_SMALL
	import.from LPF2_STONE_GREY_MOTOR_LARGE
	st.name LPF2_STONE_GREY_MOTOR_LARGE
	import.from LPF2_STONE_GREY_MOTOR_MEDIUM
	st.name LPF2_STONE_GREY_MOTOR_MEDIUM
	pop
	map 8
	129
	128
	tuple 2
	130
	130
	tuple 2
	131
	129
	tuple 2
	129
	128
	tuple 2
	list 4
	loadname LPF2_FLIPPER_MOTOR_SMALL
	st.map
	129
	128
	tuple 2
	130
	130
	tuple 2
	131
	129
	tuple 2
	128
	128
	tuple 2
	list 4
	loadname LPF2_FLIPPER_MOTOR_MEDIUM
	st.map
	129
	128
	tuple 2
	130
	130
	tuple 2
	131
	129
	tuple 2
	128
	128
	tuple 2
	list 4
	loadname LPF2_FLIPPER_MOTOR_LARGE
	st.map
	129
	128
	tuple 2
	130
	130
	tuple 2
	131
	129
	tuple 2
	128
	128
	tuple 2
	list 4
	loadname LPF2_STONE_GREY_MOTOR_MEDIUM
	st.map
	129
	128
	tuple 2
	130
	130
	tuple 2
	131
	129
	tuple 2
	128
	128
	tuple 2
	list 4
	loadname LPF2_STONE_GREY_MOTOR_LARGE
	st.map
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
	list 5
	loadname LPF2_FLIPPER_COLOR
	st.map
	128
	128
	tuple 2
	list 1
	loadname LPF2_FLIPPER_DISTANCE
	st.map
	128
	128
	tuple 2
	129
	128
	tuple 2
	132
	128
	tuple 2
	list 3
	loadname LPF2_FLIPPER_FORCE
	st.map
	st.name _DEFAULT_MODE
	map 8
	131
	128
	129
	130
	list 4
	loadname LPF2_FLIPPER_MOTOR_SMALL
	st.map
	131
	128
	129
	130
	list 4
	loadname LPF2_FLIPPER_MOTOR_MEDIUM
	st.map
	131
	128
	129
	130
	list 4
	loadname LPF2_FLIPPER_MOTOR_LARGE
	st.map
	129
	128
	130
	131
	132
	list 5
	loadname LPF2_FLIPPER_COLOR
	st.map
	128
	list 1
	loadname LPF2_FLIPPER_DISTANCE
	st.map
	128
	129
	127
	127
	130
	list 5
	loadname LPF2_FLIPPER_FORCE
	st.map
	131
	128
	129
	130
	list 4
	loadname LPF2_STONE_GREY_MOTOR_MEDIUM
	st.map
	131
	128
	129
	130
	list 4
	loadname LPF2_STONE_GREY_MOTOR_LARGE
	st.map
	st.name _REVERSE_MODES
	loadname hub
	attr port
	attr A
	loadname hub
	attr port
	attr B
	loadname hub
	attr port
	attr C
	loadname hub
	attr port
	attr D
	loadname hub
	attr port
	attr E
	loadname hub
	attr port
	attr F
	list 6
	st.name _PORTS
	mkfun 3
	st.name _port_type_update
	128
	list 1
	loadname len
	loadname _PORTS
	call 1
	mul
	st.name _PORT_TYPE
	list 0
	list 1
	loadname len
	loadname _PORTS
	call 1
	mul
	st.name _EVENT_MODE
	loadname len
	loadname _PORTS
	call 1
	128
	jmp 15
	dup
	st.name indx
	loadname _port_type_update
	loadname indx
	call 1
	pop
	129
	add.in
	dup2
	rot
	lt
	btrue -21
	pop
	pop
	mkfun 4
	st.name register_ports
	false
	st.glbl _SYNC_DISPLAY
	loadname tuple
	call 0
	st.name _NO_DATA
	none
	loadname _NO_DATA
	list 2
	none
	loadname _NO_DATA
	list 2
	none
	loadname _NO_DATA
	list 2
	none
	loadname _NO_DATA
	list 2
	none
	loadname _NO_DATA
	list 2
	none
	loadname _NO_DATA
	list 2
	list 6
	128
	128
	128
	tuple 3
	list 1
	131
	mul
	add
	str 
	128
	list 2
	add
	st.name sensor_data
	mkfun 5
	st.name update_sensor_data
	loadname LPF2_FLIPPER_MOTOR_SMALL
	loadname LPF2_FLIPPER_MOTOR_MEDIUM
	loadname LPF2_FLIPPER_MOTOR_LARGE
	loadname LPF2_STONE_GREY_MOTOR_MEDIUM
	loadname LPF2_STONE_GREY_MOTOR_LARGE
	list 5
	st.name _MOTOR_TYPES
	mkfun 6
	st.name _is_motor
	str A
	str B
	str C
	str D
	str E
	str F
	constobj 0
	str GYROSCOPE
	str POSITION
	constobj 1
	str TIMER
	list 11
	st.name _PORT_INDEX_MAP
	none
	tuple 0
	tuple 2
	null
	mkfun.defargs 7
	st.name get_sensor_value
	mkfun 8
	st.name is_type
	constobj 2
	128
	list 2
	st.name battery_status
	mkfun 9
	st.name update_battery_status
	mkfun 10
	st.name _type_change_handler
	mkfun 11
	st.name reset_to_default_mode
	mkfun 12
	st.name set_display_sync
	mkfun 13
	st.name current_motion
	none
	ret
	