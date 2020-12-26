_is_motor: ;_api/motor.py
	glbl PORTS
	ldloc.0
	MP_BC_LOAD_SUBSCR
	attr motor
	ret
	
__init__: ;_api/motor.py
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
	glbl _is_motor
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
	int 128, 75
	ldloc.0
	st.attr _default_speed
	none
	ldloc.0
	st.attr _last_event
	glbl system
	attr motors
	method on_port
	ldloc.0
	attr _port
	call.meth 1
	ldloc.0
	st.attr _motor_wrapper
	none
	ret
	
get_position: ;_api/motor.py
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method get
	call.meth 0
	130
	MP_BC_LOAD_SUBSCR
	stloc.1
	ldloc.1
	128
	lt
	bfalse 6
	int 130, 104
	ldloc.1
	add
	ret
	ldloc.1
	ret
	none
	ret
	
get_speed: ;_api/motor.py
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method get
	call.meth 0
	128
	MP_BC_LOAD_SUBSCR
	ret
	
get_degrees_counted: ;_api/motor.py
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method get
	call.meth 0
	129
	MP_BC_LOAD_SUBSCR
	ret
	
set_degrees_counted: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method preset
	ldloc.1
	call.meth 1
	stloc.2
	glbl sleep_ms
	int 129, 72
	call 1
	pop
	ldloc.2
	ret
	
get_default_speed: ;_api/motor.py
	ldloc.0
	attr _default_speed
	ret
	
set_default_speed: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	glbl clamp_speed
	ldloc.1
	call 1
	ldloc.0
	st.attr _default_speed
	none
	ret
	
set_stop_action: ;_api/motor.py
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
	str coast
	str brake
	str hold
	tuple 3
	in
	not
	bfalse 22
	glbl ValueError
	constobj 3
	str coast
	str brake
	str hold
	tuple 3
	tuple 1
	mod
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	128
	stloc.2
	ldloc.1
	ldloc.0
	attr BRAKE
	eq
	bfalse 2
	129
	stloc.2
	ldloc.1
	ldloc.0
	attr HOLD
	eq
	bfalse 2
	130
	stloc.2
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method default
	call.meth 0
	stloc.3
	ldloc.2
	ldloc.3
	str stop
	MP_BC_STORE_SUBSCR
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method default
	null
	ldloc.3
	call.kvmeth 0
	pop
	none
	ret
	
set_stall_detection: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl bool
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method default
	call.meth 0
	stloc.2
	ldloc.1
	ldloc.2
	str stall
	MP_BC_STORE_SUBSCR
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method default
	null
	ldloc.2
	call.kvmeth 0
	pop
	none
	ret
	
run_to_degrees_counted: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl int
	call 2
	btrue 14
	ldloc.2
	none
	is
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl abs
	glbl clamp_speed
	ldloc.2
	btrue.pop 4
	ldloc.0
	attr _default_speed
	call 1
	call 1
	stloc.3
	ldloc.1
	ldloc.0
	method get_degrees_counted
	call.meth 0
	sub
	stloc.4
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method default
	call.meth 0
	stloc.5
	glbl wait_for_async
	ldloc.0
	attr _motor_wrapper
	method run_for_degrees_async
	ldloc.4
	ldloc.3
	ldloc.5
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.5
	str stop
	MP_BC_LOAD_SUBSCR
	call.meth 4
	call 1
	ldloc.0
	st.attr _last_event
	none
	ret
	
run_to_position: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl isinstance
	ldloc.3
	glbl int
	call 2
	btrue 14
	ldloc.3
	none
	is
	btrue 8
	glbl TypeError
	constobj 5
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 6
	call 1
	raiseobj
	ldloc.1
	int 130, 103
	qt
	btrue 6
	ldloc.1
	128
	lt
	bfalse 8
	glbl ValueError
	constobj 7
	call 1
	raiseobj
	ldloc.2
	constobj 8
	str clockwise
	constobj 9
	tuple 3
	in
	not
	bfalse 20
	glbl ValueError
	constobj 10
	constobj 11
	str clockwise
	constobj 12
	tuple 3
	tuple 1
	mod
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.2
	constobj 13
	eq
	bfalse 4
	str shortest
	stloc.2
	glbl abs
	glbl clamp_speed
	ldloc.3
	btrue.pop 4
	ldloc.0
	attr _default_speed
	call 1
	call 1
	stloc.4
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method default
	call.meth 0
	stloc.5
	glbl wait_for_async
	ldloc.0
	attr _motor_wrapper
	method run_to_position_async
	ldloc.1
	ldloc.4
	ldloc.2
	ldloc.5
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.5
	str stop
	MP_BC_LOAD_SUBSCR
	call.meth 5
	call 1
	ldloc.0
	st.attr _last_event
	none
	ret
	
run_for_degrees: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl int
	call 2
	btrue 14
	ldloc.2
	none
	is
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl clamp_speed
	ldloc.2
	none
	is
	bfalse 7
	ldloc.0
	attr _default_speed
	jmp 1
	ldloc.2
	call 1
	stloc.3
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method default
	call.meth 0
	stloc.4
	glbl wait_for_async
	ldloc.0
	attr _motor_wrapper
	method run_for_degrees_async
	glbl abs
	ldloc.1
	call 1
	ldloc.1
	128
	qe
	bfalse 4
	ldloc.3
	jmp 3
	ldloc.3
	127
	mul
	ldloc.4
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.4
	str stop
	MP_BC_LOAD_SUBSCR
	call.meth 4
	call 1
	ldloc.0
	st.attr _last_event
	none
	ret
	
run_for_rotations: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl int
	glbl float
	tuple 2
	call 2
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl int
	call 2
	btrue 14
	ldloc.2
	none
	is
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method run_for_degrees
	glbl int
	ldloc.1
	int 130, 104
	mul
	call 1
	str speed
	ldloc.2
	call.meth 130, 1
	pop
	none
	ret
	
run_for_seconds: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl int
	glbl float
	tuple 2
	call 2
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	ldloc.1
	128
	lt
	bfalse 8
	glbl ValueError
	constobj 4
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl int
	call 2
	btrue 14
	ldloc.2
	none
	is
	btrue 8
	glbl TypeError
	constobj 5
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl clamp_speed
	ldloc.2
	btrue.pop 4
	ldloc.0
	attr _default_speed
	call 1
	stloc.3
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method default
	call.meth 0
	stloc.4
	glbl wait_for_async
	ldloc.0
	attr _motor_wrapper
	method run_for_time_async
	glbl int
	ldloc.1
	int 135, 104
	mul
	call 1
	ldloc.3
	ldloc.4
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.4
	str stop
	MP_BC_LOAD_SUBSCR
	call.meth 4
	call 1
	ldloc.0
	st.attr _last_event
	none
	ret
	
start: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 14
	ldloc.1
	none
	is
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl clamp_speed
	ldloc.1
	none
	is
	bfalse 7
	ldloc.0
	attr _default_speed
	jmp 1
	ldloc.1
	call 1
	stloc.2
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method run_at_speed
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
start_at_power: ;_api/motor.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl clamp_power
	ldloc.1
	call 1
	stloc.2
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method pwm
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
stop: ;_api/motor.py
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method default
	call.meth 0
	str stop
	MP_BC_LOAD_SUBSCR
	stloc.1
	ldloc.1
	128
	eq
	bfalse 20
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method float
	call.meth 0
	pop
	jmp 52
	ldloc.1
	129
	eq
	bfalse 20
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method brake
	call.meth 0
	pop
	jmp 26
	ldloc.1
	130
	eq
	bfalse 20
	glbl PORTS
	ldloc.0
	attr _port
	MP_BC_LOAD_SUBSCR
	attr motor
	method hold
	call.meth 0
	pop
	jmp 0
	none
	ret
	
was_interrupted: ;_api/motor.py
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	attr _last_event
	129
	eq
	stloc.1
	none
	ldloc.0
	st.attr _last_event
	ldloc.1
	ret
	
was_stalled: ;_api/motor.py
	glbl _is_motor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	attr _last_event
	130
	eq
	stloc.1
	none
	ldloc.0
	st.attr _last_event
	ldloc.1
	ret
	
Motor: ;_api/motor.py
	loadname __name__
	st.name __module__
	str Motor
	st.name __qualname__
	mkfun 1
	st.name __init__
	mkfun 2
	st.name get_position
	mkfun 3
	st.name get_speed
	mkfun 4
	st.name get_degrees_counted
	mkfun 5
	st.name set_degrees_counted
	mkfun 6
	st.name get_default_speed
	mkfun 7
	st.name set_default_speed
	str coast
	st.name COAST
	str brake
	st.name BRAKE
	str hold
	st.name HOLD
	mkfun 8
	st.name set_stop_action
	mkfun 9
	st.name set_stall_detection
	none
	tuple 1
	null
	mkfun.defargs 10
	st.name run_to_degrees_counted
	constobj 0
	none
	tuple 2
	null
	mkfun.defargs 11
	st.name run_to_position
	none
	tuple 1
	null
	mkfun.defargs 12
	st.name run_for_degrees
	none
	tuple 1
	null
	mkfun.defargs 13
	st.name run_for_rotations
	none
	tuple 1
	null
	mkfun.defargs 14
	st.name run_for_seconds
	none
	tuple 1
	null
	mkfun.defargs 15
	st.name start
	mkfun 16
	st.name start_at_power
	mkfun 17
	st.name stop
	mkfun 18
	st.name was_interrupted
	mkfun 19
	st.name was_stalled
	none
	ret
	
<module>: ;_api/motor.py
	128
	none
	import.nm hub
	st.name hub
	128
	str is_type
	tuple 1
	import.nm util.sensors
	import.from is_type
	st.name is_type
	pop
	128
	str clamp_speed
	str clamp_power
	tuple 2
	import.nm util.motor
	import.from clamp_speed
	st.name clamp_speed
	import.from clamp_power
	st.name clamp_power
	pop
	128
	str PORTS
	str MOTOR_TYPES
	tuple 2
	import.nm util.constants
	import.from PORTS
	st.name PORTS
	import.from MOTOR_TYPES
	st.name MOTOR_TYPES
	pop
	129
	str newSensorDisconnectedError
	str wait_for_async
	tuple 2
	import.nm util
	import.from newSensorDisconnectedError
	st.name newSensorDisconnectedError
	import.from wait_for_async
	st.name wait_for_async
	pop
	128
	str sleep_ms
	tuple 1
	import.nm utime
	import.from sleep_ms
	st.name sleep_ms
	pop
	128
	str system
	tuple 1
	import.nm system
	import.from system
	st.name system
	pop
	none
	tuple 1
	null
	mkfun.defargs 0
	st.name _is_motor
	buildclass
	mkfun 1
	str Motor
	call 2
	st.name Motor
	none
	ret
	