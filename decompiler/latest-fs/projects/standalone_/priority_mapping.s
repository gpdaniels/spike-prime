__init__: ;projects/standalone_/priority_mapping.py
	ldloc.1
	ldloc.0
	st.attr left
	ldloc.2
	ldloc.0
	st.attr right
	none
	ldloc.0
	st.attr left_mode
	none
	ldloc.0
	st.attr right_mode
	ldloc.0
	method get_modes
	call.meth 0
	pop
	none
	ret
	
_get_sensor_mode: ;projects/standalone_/priority_mapping.py
	128
	stloc.2
	int 128, 100
	stloc.3
	glbl len
	ldloc.1
	call 1
	129
	eq
	bfalse 8
	ldloc.1
	128
	MP_BC_LOAD_SUBSCR
	str id
	MP_BC_LOAD_SUBSCR
	ret
	ldloc.1
	ld.iterstack
	for.iter 57, 0
	stloc.4
	glbl enumerate
	glbl PRIORITY_MAP
	call 1
	ld.iterstack
	for.iter 41, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.5
	stloc.6
	ldloc.4
	str type
	MP_BC_LOAD_SUBSCR
	ldloc.6
	128
	MP_BC_LOAD_SUBSCR
	eq
	bfalse 22
	ldloc.4
	str sensor
	MP_BC_LOAD_SUBSCR
	bfalse 14
	ldloc.5
	ldloc.3
	lt
	bfalse 8
	ldloc.5
	stloc.3
	ldloc.4
	str id
	MP_BC_LOAD_SUBSCR
	stloc.2
	jmp -44
	jmp -60
	ldloc.2
	ret
	
_get_actuator_mode: ;projects/standalone_/priority_mapping.py
	128
	stloc.2
	int 128, 100
	stloc.3
	glbl len
	ldloc.1
	call 1
	129
	eq
	bfalse 8
	ldloc.1
	128
	MP_BC_LOAD_SUBSCR
	str id
	MP_BC_LOAD_SUBSCR
	ret
	ldloc.1
	ld.iterstack
	for.iter 57, 0
	stloc.4
	glbl enumerate
	glbl PRIORITY_MAP
	call 1
	ld.iterstack
	for.iter 41, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.5
	stloc.6
	ldloc.4
	str type
	MP_BC_LOAD_SUBSCR
	ldloc.6
	129
	MP_BC_LOAD_SUBSCR
	eq
	bfalse 22
	ldloc.4
	str actuator
	MP_BC_LOAD_SUBSCR
	bfalse 14
	ldloc.5
	ldloc.3
	lt
	bfalse 8
	ldloc.5
	stloc.3
	ldloc.4
	str id
	MP_BC_LOAD_SUBSCR
	stloc.2
	jmp -44
	jmp -60
	ldloc.2
	ret
	
<listcomp>: ;projects/standalone_/priority_mapping.py
	list 0
	ldloc.1
	ld.iterstack
	for.iter 29, 0
	stloc.2
	ldloc.2
	128
	MP_BC_LOAD_SUBSCR
	deref 0
	str type
	MP_BC_LOAD_SUBSCR
	is
	bfalse -17
	deref 0
	str sensor
	MP_BC_LOAD_SUBSCR
	bfalse -26
	ldloc.2
	MP_BC_STORE_COMP 20
	jmp -32
	ret
	
<listcomp>: ;projects/standalone_/priority_mapping.py
	list 0
	ldloc.1
	ld.iterstack
	for.iter 29, 0
	stloc.2
	ldloc.2
	129
	MP_BC_LOAD_SUBSCR
	deref 0
	str type
	MP_BC_LOAD_SUBSCR
	is
	bfalse -17
	deref 0
	str actuator
	MP_BC_LOAD_SUBSCR
	bfalse -26
	ldloc.2
	MP_BC_STORE_COMP 20
	jmp -32
	ret
	
_get_sensor_actuator_modes: ;projects/standalone_/priority_mapping.py
	128
	128
	tuple 2
	stloc.3
	int 128, 100
	stloc.4
	ldloc.1
	ld.iterstack
	for.iter 75, 0
	st.deref 9
	ldloc.9
	mkclosure 3, 1
	glbl PRIORITY_MAP
	call 1
	stloc.5
	ldloc.2
	ld.iterstack
	for.iter 55, 0
	st.deref 10
	ldloc.10
	mkclosure 4, 1
	ldloc.5
	call 1
	stloc.6
	ldloc.6
	ld.iterstack
	for.iter 37, 0
	stloc.7
	glbl PRIORITY_MAP
	method index
	ldloc.7
	call.meth 1
	stloc.8
	ldloc.8
	ldloc.4
	lt
	bfalse 17
	ldloc.8
	stloc.4
	deref 9
	str id
	MP_BC_LOAD_SUBSCR
	deref 10
	str id
	MP_BC_LOAD_SUBSCR
	tuple 2
	stloc.3
	jmp -40
	jmp -58
	jmp -78
	ldloc.3
	ret
	
get_modes: ;projects/standalone_/priority_mapping.py
	ldloc.0
	attr left
	bfalse 74
	ldloc.0
	attr right
	btrue 67
	ldloc.0
	attr left
	method is_sensor
	call.meth 0
	bfalse 20
	ldloc.0
	method _get_sensor_mode
	ldloc.0
	attr left
	attr modes
	call.meth 1
	ldloc.0
	st.attr left_mode
	jmp 32
	ldloc.0
	attr left
	method is_actuator
	call.meth 0
	bfalse 20
	ldloc.0
	method _get_actuator_mode
	ldloc.0
	attr left
	attr modes
	call.meth 1
	ldloc.0
	st.attr left_mode
	jmp 0
	jmp 334
	ldloc.0
	attr left
	btrue 74
	ldloc.0
	attr right
	bfalse 67
	ldloc.0
	attr right
	method is_sensor
	call.meth 0
	bfalse 20
	ldloc.0
	method _get_sensor_mode
	ldloc.0
	attr right
	attr modes
	call.meth 1
	ldloc.0
	st.attr right_mode
	jmp 32
	ldloc.0
	attr right
	method is_actuator
	call.meth 0
	bfalse 20
	ldloc.0
	method _get_actuator_mode
	ldloc.0
	attr right
	attr modes
	call.meth 1
	ldloc.0
	st.attr right_mode
	jmp 0
	jmp 253
	ldloc.0
	attr left
	bfalse 246
	ldloc.0
	attr right
	bfalse 239
	ldloc.0
	attr left
	method is_sensor
	call.meth 0
	bfalse 45
	ldloc.0
	attr right
	method is_actuator
	call.meth 0
	bfalse 33
	ldloc.0
	method _get_sensor_actuator_modes
	ldloc.0
	attr left
	attr modes
	ldloc.0
	attr right
	attr modes
	call.meth 2
	MP_BC_UNPACK_SEQUENCE 2
	ldloc.0
	st.attr left_mode
	ldloc.0
	st.attr right_mode
	jmp 179
	ldloc.0
	attr left
	method is_actuator
	call.meth 0
	bfalse 45
	ldloc.0
	attr right
	method is_sensor
	call.meth 0
	bfalse 33
	ldloc.0
	method _get_sensor_actuator_modes
	ldloc.0
	attr right
	attr modes
	ldloc.0
	attr left
	attr modes
	call.meth 2
	MP_BC_UNPACK_SEQUENCE 2
	ldloc.0
	st.attr right_mode
	ldloc.0
	st.attr left_mode
	jmp 122
	ldloc.0
	attr left
	method is_sensor
	call.meth 0
	bfalse 49
	ldloc.0
	attr right
	method is_sensor
	call.meth 0
	bfalse 37
	ldloc.0
	method _get_sensor_mode
	ldloc.0
	attr left
	attr modes
	call.meth 1
	ldloc.0
	st.attr left_mode
	ldloc.0
	method _get_sensor_mode
	ldloc.0
	attr right
	attr modes
	call.meth 1
	ldloc.0
	st.attr right_mode
	jmp 61
	ldloc.0
	attr left
	method is_actuator
	call.meth 0
	bfalse 49
	ldloc.0
	attr right
	method is_actuator
	call.meth 0
	bfalse 37
	ldloc.0
	method _get_actuator_mode
	ldloc.0
	attr left
	attr modes
	call.meth 1
	ldloc.0
	st.attr left_mode
	ldloc.0
	method _get_actuator_mode
	ldloc.0
	attr right
	attr modes
	call.meth 1
	ldloc.0
	st.attr right_mode
	jmp 0
	jmp 0
	none
	ret
	
DeviceModePriorityMap: ;projects/standalone_/priority_mapping.py
	loadname __name__
	st.name __module__
	str DeviceModePriorityMap
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name _get_sensor_mode
	mkfun 2
	st.name _get_actuator_mode
	mkfun 3
	st.name _get_sensor_actuator_modes
	mkfun 4
	st.name get_modes
	none
	ret
	
<module>: ;projects/standalone_/priority_mapping.py
	129
	str Type
	tuple 1
	import.nm util
	import.from Type
	st.name Type
	pop
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	loadname Type
	attr DSTAR
	loadname Type
	attr DSTAR
	tuple 2
	loadname Type
	attr RSTAR
	loadname Type
	attr RSTAR
	tuple 2
	loadname Type
	attr ASTAR
	loadname Type
	attr ASTAR
	tuple 2
	loadname Type
	attr RSTAR
	loadname Type
	attr DSTAR
	tuple 2
	loadname Type
	attr R
	loadname Type
	attr D
	tuple 2
	loadname Type
	attr R
	loadname Type
	attr DSTAR
	tuple 2
	loadname Type
	attr RSTAR
	loadname Type
	attr D
	tuple 2
	loadname Type
	attr D
	loadname Type
	attr D
	tuple 2
	loadname Type
	attr R
	loadname Type
	attr R
	tuple 2
	loadname Type
	attr A
	loadname Type
	attr A
	tuple 2
	loadname Type
	attr D
	loadname Type
	attr DSTAR
	tuple 2
	loadname Type
	attr R
	loadname Type
	attr RSTAR
	tuple 2
	loadname Type
	attr A
	loadname Type
	attr ASTAR
	tuple 2
	loadname Type
	attr ASTAR
	loadname Type
	attr A
	tuple 2
	loadname Type
	attr RSTAR
	loadname Type
	attr R
	tuple 2
	loadname Type
	attr DSTAR
	loadname Type
	attr D
	tuple 2
	loadname Type
	attr DSTAR
	loadname Type
	attr RSTAR
	tuple 2
	loadname Type
	attr DSTAR
	loadname Type
	attr ASTAR
	tuple 2
	loadname Type
	attr RSTAR
	loadname Type
	attr ASTAR
	tuple 2
	loadname Type
	attr ASTAR
	loadname Type
	attr DSTAR
	tuple 2
	loadname Type
	attr ASTAR
	loadname Type
	attr RSTAR
	tuple 2
	loadname Type
	attr D
	loadname Type
	attr R
	tuple 2
	loadname Type
	attr D
	loadname Type
	attr A
	tuple 2
	loadname Type
	attr R
	loadname Type
	attr A
	tuple 2
	loadname Type
	attr A
	loadname Type
	attr D
	tuple 2
	loadname Type
	attr A
	loadname Type
	attr R
	tuple 2
	loadname Type
	attr D
	loadname Type
	attr RSTAR
	tuple 2
	loadname Type
	attr D
	loadname Type
	attr ASTAR
	tuple 2
	loadname Type
	attr DSTAR
	loadname Type
	attr R
	tuple 2
	loadname Type
	attr DSTAR
	loadname Type
	attr A
	tuple 2
	loadname Type
	attr R
	loadname Type
	attr ASTAR
	tuple 2
	loadname Type
	attr RSTAR
	loadname Type
	attr A
	tuple 2
	loadname Type
	attr A
	loadname Type
	attr DSTAR
	tuple 2
	loadname Type
	attr A
	loadname Type
	attr RSTAR
	tuple 2
	loadname Type
	attr ASTAR
	loadname Type
	attr D
	tuple 2
	loadname Type
	attr ASTAR
	loadname Type
	attr R
	tuple 2
	list 36
	st.name PRIORITY_MAP
	128
	st.name INPUT
	129
	st.name OUTPUT
	buildclass
	mkfun 0
	str DeviceModePriorityMap
	loadname object
	call 3
	st.name DeviceModePriorityMap
	none
	ret
	