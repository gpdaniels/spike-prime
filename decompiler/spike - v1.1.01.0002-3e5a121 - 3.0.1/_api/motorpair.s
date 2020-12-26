_is_motor: ;_api/motorpair.py
	glbl PORTS
	ldloc.0
	MP_BC_LOAD_SUBSCR
	attr motor
	ret
	
__init__: ;_api/motorpair.py
	glbl isinstance
	ldloc.1
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	ldloc.1
	glbl PORTS
	method keys
	call.meth 0
	in
	btrue 10
	glbl ValueError
	constobj 5
	ldloc.1
	mod
	call 1
	raiseobj
	ldloc.2
	glbl PORTS
	method keys
	call.meth 0
	in
	btrue 10
	glbl ValueError
	constobj 6
	ldloc.2
	mod
	call 1
	raiseobj
	ldloc.1
	ldloc.2
	eq
	bfalse 8
	glbl ValueError
	constobj 7
	call 1
	raiseobj
	glbl _is_motor
	ldloc.1
	call 1
	bfalse 9
	glbl _is_motor
	ldloc.2
	call 1
	btrue 8
	glbl RuntimeError
	constobj 8
	call 1
	raiseobj
	glbl system
	attr move
	method on_pair
	ldloc.1
	ldloc.2
	call.meth 2
	ldloc.0
	st.attr _move_wrapper
	ldloc.0
	attr _move_wrapper
	method is_valid
	call.meth 0
	btrue 4
	glbl _MOTOR_PAIRING_ERROR
	raiseobj
	ldloc.1
	ldloc.0
	st.attr _left_port
	ldloc.2
	ldloc.0
	st.attr _right_port
	int 128, 75
	ldloc.0
	st.attr _default_speed
	constobj 9
	ldloc.0
	st.attr _rotation_length_cm
	129
	ldloc.0
	st.attr _stop_action
	none
	ldloc.0
	st.attr _last_event
	none
	ret
	
_move_with_speed: ;_api/motorpair.py
	ldloc.4
	str seconds
	eq
	bfalse 44
	glbl wait_for_async
	ldloc.0
	attr _move_wrapper
	method move_for_time_async
	glbl max
	128
	glbl int
	int 135, 104
	ldloc.1
	mul
	call 1
	call 2
	ldloc.2
	ldloc.3
	neg
	ldloc.0
	attr _stop_action
	call.meth 4
	call 1
	ldloc.0
	st.attr _last_event
	jmp 127
	none
	stloc.5
	ldloc.4
	str rotations
	eq
	bfalse 14
	glbl int
	int 130, 104
	ldloc.1
	mul
	call 1
	stloc.5
	jmp 49
	ldloc.4
	str degrees
	eq
	bfalse 10
	glbl int
	ldloc.1
	call 1
	stloc.5
	jmp 31
	glbl int
	int 130, 104
	ldloc.1
	mul
	ldloc.4
	str cm
	eq
	bfalse 4
	129
	jmp 2
	constobj 5
	mul
	ldloc.0
	attr _rotation_length_cm
	truediv
	call 1
	stloc.5
	glbl wait_for_async
	ldloc.0
	attr _move_wrapper
	method move_differential_speed_async
	glbl abs
	ldloc.5
	call 1
	ldloc.5
	128
	qe
	bfalse 4
	ldloc.2
	jmp 3
	127
	ldloc.2
	mul
	ldloc.5
	128
	qe
	bfalse 4
	ldloc.3
	jmp 3
	127
	ldloc.3
	mul
	ldloc.0
	attr _stop_action
	call.meth 4
	call 1
	ldloc.0
	st.attr _last_event
	none
	ret
	
move: ;_api/motorpair.py
	glbl isinstance
	ldloc.1
	glbl int
	glbl float
	tuple 2
	call 2
	btrue 8
	glbl TypeError
	constobj 5
	call 1
	raiseobj
	glbl isinstance
	ldloc.3
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 6
	call 1
	raiseobj
	glbl isinstance
	ldloc.4
	glbl int
	call 2
	btrue 14
	ldloc.4
	none
	is
	btrue 8
	glbl TypeError
	constobj 7
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 8
	call 1
	raiseobj
	ldloc.2
	ldloc.0
	attr CM
	ldloc.0
	attr IN
	ldloc.0
	attr ROTATIONS
	ldloc.0
	attr DEGREES
	ldloc.0
	attr SECONDS
	tuple 5
	in
	not
	bfalse 33
	glbl ValueError
	constobj 9
	ldloc.0
	attr CM
	ldloc.0
	attr IN
	ldloc.0
	attr ROTATIONS
	ldloc.0
	attr DEGREES
	ldloc.0
	attr SECONDS
	tuple 5
	tuple 1
	mod
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _left_port
	call 1
	bfalse 12
	glbl _is_motor
	ldloc.0
	attr _right_port
	call 1
	btrue 4
	glbl _DISCONNECTED_ERROR
	raiseobj
	glbl clamp_steering
	ldloc.3
	call 1
	stloc.5
	glbl clamp_speed
	ldloc.4
	none
	is
	bfalse 7
	ldloc.0
	attr _default_speed
	jmp 1
	ldloc.4
	call 1
	stloc.6
	glbl from_steering
	ldloc.5
	ldloc.6
	call 2
	stloc.7
	ldloc.0
	method _move_with_speed
	ldloc.1
	ldloc.7
	128
	MP_BC_LOAD_SUBSCR
	ldloc.7
	129
	MP_BC_LOAD_SUBSCR
	ldloc.2
	call.meth 4
	pop
	none
	ret
	
start: ;_api/motorpair.py
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
	attr _left_port
	call 1
	bfalse 12
	glbl _is_motor
	ldloc.0
	attr _right_port
	call 1
	btrue 4
	glbl _DISCONNECTED_ERROR
	raiseobj
	glbl clamp_steering
	ldloc.1
	call 1
	stloc.3
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
	stloc.4
	glbl from_steering
	ldloc.3
	ldloc.4
	call 2
	stloc.5
	ldloc.0
	attr _move_wrapper
	method start_at_speeds
	ldloc.5
	128
	MP_BC_LOAD_SUBSCR
	ldloc.5
	129
	MP_BC_LOAD_SUBSCR
	neg
	call.meth 2
	pop
	none
	ret
	
stop: ;_api/motorpair.py
	glbl _is_motor
	ldloc.0
	attr _left_port
	call 1
	bfalse 12
	glbl _is_motor
	ldloc.0
	attr _right_port
	call 1
	btrue 4
	glbl _DISCONNECTED_ERROR
	raiseobj
	ldloc.0
	attr _move_wrapper
	method stop
	ldloc.0
	attr _stop_action
	call.meth 1
	pop
	none
	ret
	
set_motor_rotation: ;_api/motorpair.py
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
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	ldloc.2
	ldloc.0
	attr CM
	ldloc.0
	attr IN
	tuple 2
	in
	not
	bfalse 21
	glbl ValueError
	constobj 5
	ldloc.0
	attr CM
	ldloc.0
	attr IN
	tuple 2
	tuple 1
	mod
	call 1
	raiseobj
	ldloc.2
	str cm
	eq
	bfalse 4
	ldloc.1
	jmp 4
	ldloc.1
	constobj 6
	mul
	ldloc.0
	st.attr _rotation_length_cm
	none
	ret
	
get_default_speed: ;_api/motorpair.py
	ldloc.0
	attr _default_speed
	ret
	
set_default_speed: ;_api/motorpair.py
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
	
set_stop_action: ;_api/motorpair.py
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
	ldloc.0
	attr COAST
	ldloc.0
	attr BRAKE
	ldloc.0
	attr HOLD
	tuple 3
	in
	not
	bfalse 25
	glbl ValueError
	constobj 3
	ldloc.0
	attr COAST
	ldloc.0
	attr BRAKE
	ldloc.0
	attr HOLD
	tuple 3
	tuple 1
	mod
	call 1
	raiseobj
	ldloc.1
	ldloc.0
	attr COAST
	eq
	bfalse 8
	128
	ldloc.0
	st.attr _stop_action
	jmp 34
	ldloc.1
	ldloc.0
	attr BRAKE
	eq
	bfalse 8
	129
	ldloc.0
	st.attr _stop_action
	jmp 17
	ldloc.1
	ldloc.0
	attr HOLD
	eq
	bfalse 8
	130
	ldloc.0
	st.attr _stop_action
	jmp 0
	none
	ret
	
was_interrupted: ;_api/motorpair.py
	glbl _is_motor
	ldloc.0
	attr _left_port
	call 1
	bfalse 12
	glbl _is_motor
	ldloc.0
	attr _right_port
	call 1
	btrue 4
	glbl _DISCONNECTED_ERROR
	raiseobj
	ldloc.0
	attr _move_wrapper
	method is_valid
	call.meth 0
	btrue 4
	glbl _MOTOR_PAIRING_ERROR
	raiseobj
	ldloc.0
	attr _last_event
	129
	eq
	btrue.pop 6
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
	
move_tank: ;_api/motorpair.py
	glbl isinstance
	ldloc.1
	glbl int
	glbl float
	tuple 2
	call 2
	btrue 8
	glbl TypeError
	constobj 5
	call 1
	raiseobj
	glbl isinstance
	ldloc.3
	glbl int
	call 2
	btrue 12
	ldloc.3
	bfalse 8
	glbl TypeError
	constobj 6
	call 1
	raiseobj
	glbl isinstance
	ldloc.4
	glbl int
	call 2
	btrue 12
	ldloc.4
	bfalse 8
	glbl TypeError
	constobj 7
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 8
	call 1
	raiseobj
	ldloc.2
	ldloc.0
	attr CM
	ldloc.0
	attr IN
	ldloc.0
	attr ROTATIONS
	ldloc.0
	attr DEGREES
	ldloc.0
	attr SECONDS
	tuple 5
	in
	not
	bfalse 33
	glbl ValueError
	constobj 9
	ldloc.0
	attr CM
	ldloc.0
	attr IN
	ldloc.0
	attr ROTATIONS
	ldloc.0
	attr DEGREES
	ldloc.0
	attr SECONDS
	tuple 5
	tuple 1
	mod
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _left_port
	call 1
	bfalse 12
	glbl _is_motor
	ldloc.0
	attr _right_port
	call 1
	btrue 4
	glbl _DISCONNECTED_ERROR
	raiseobj
	ldloc.0
	attr _move_wrapper
	method is_valid
	call.meth 0
	btrue 4
	glbl _MOTOR_PAIRING_ERROR
	raiseobj
	glbl clamp_speed
	ldloc.3
	none
	is
	bfalse 7
	ldloc.0
	attr _default_speed
	jmp 1
	ldloc.3
	call 1
	stloc.5
	glbl clamp_speed
	ldloc.4
	none
	is
	bfalse 7
	ldloc.0
	attr _default_speed
	jmp 1
	ldloc.4
	call 1
	stloc.6
	ldloc.0
	method _move_with_speed
	ldloc.1
	ldloc.5
	ldloc.6
	ldloc.2
	call.meth 4
	pop
	none
	ret
	
start_tank: ;_api/motorpair.py
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
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _left_port
	call 1
	bfalse 12
	glbl _is_motor
	ldloc.0
	attr _right_port
	call 1
	btrue 4
	glbl _DISCONNECTED_ERROR
	raiseobj
	ldloc.0
	attr _move_wrapper
	method is_valid
	call.meth 0
	btrue 4
	glbl _MOTOR_PAIRING_ERROR
	raiseobj
	ldloc.0
	attr _move_wrapper
	method start_at_speeds
	glbl clamp_speed
	ldloc.1
	call 1
	glbl clamp_speed
	ldloc.2
	call 1
	neg
	call.meth 2
	pop
	none
	ret
	
start_at_power: ;_api/motorpair.py
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
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _left_port
	call 1
	bfalse 12
	glbl _is_motor
	ldloc.0
	attr _right_port
	call 1
	btrue 4
	glbl _DISCONNECTED_ERROR
	raiseobj
	ldloc.0
	attr _move_wrapper
	method is_valid
	call.meth 0
	btrue 4
	glbl _MOTOR_PAIRING_ERROR
	raiseobj
	glbl clamp_steering
	ldloc.2
	call 1
	stloc.3
	glbl clamp_power
	ldloc.1
	call 1
	stloc.4
	glbl from_steering
	ldloc.3
	ldloc.4
	call 2
	stloc.5
	ldloc.0
	attr _move_wrapper
	method start_at_powers
	ldloc.5
	128
	MP_BC_LOAD_SUBSCR
	ldloc.5
	129
	MP_BC_LOAD_SUBSCR
	neg
	call.meth 2
	pop
	none
	ret
	
start_tank_at_power: ;_api/motorpair.py
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
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl _is_motor
	ldloc.0
	attr _left_port
	call 1
	bfalse 12
	glbl _is_motor
	ldloc.0
	attr _right_port
	call 1
	btrue 4
	glbl _DISCONNECTED_ERROR
	raiseobj
	ldloc.0
	attr _move_wrapper
	method is_valid
	call.meth 0
	btrue 4
	glbl _MOTOR_PAIRING_ERROR
	raiseobj
	ldloc.0
	attr _move_wrapper
	method start_at_powers
	glbl clamp_power
	ldloc.1
	call 1
	glbl clamp_power
	ldloc.2
	call 1
	neg
	call.meth 2
	pop
	none
	ret
	
MotorPair: ;_api/motorpair.py
	loadname __name__
	st.name __module__
	str MotorPair
	st.name __qualname__
	mkfun 0
	st.name __init__
	str cm
	st.name CM
	str in
	st.name IN
	str rotations
	st.name ROTATIONS
	str degrees
	st.name DEGREES
	str seconds
	st.name SECONDS
	str cm
	tuple 1
	null
	mkfun.defargs 1
	st.name _move_with_speed
	str cm
	128
	none
	tuple 3
	null
	mkfun.defargs 2
	st.name move
	128
	none
	tuple 2
	null
	mkfun.defargs 3
	st.name start
	mkfun 4
	st.name stop
	str cm
	tuple 1
	null
	mkfun.defargs 5
	st.name set_motor_rotation
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
	st.name was_interrupted
	str cm
	none
	none
	tuple 3
	null
	mkfun.defargs 10
	st.name move_tank
	mkfun 11
	st.name start_tank
	128
	tuple 1
	null
	mkfun.defargs 12
	st.name start_at_power
	mkfun 13
	st.name start_tank_at_power
	none
	ret
	
clamp_steering: ;_api/motorpair.py
	glbl min
	int 128, 100
	glbl max
	int 255, 28
	ldloc.0
	call 2
	call 2
	ret
	
<module>: ;_api/motorpair.py
	128
	str PORTS
	tuple 1
	import.nm util.constants
	import.from PORTS
	st.name PORTS
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
	str system
	tuple 1
	import.nm system
	import.from system
	st.name system
	pop
	128
	str from_steering
	tuple 1
	import.nm system.movewrapper
	import.from from_steering
	st.name from_steering
	pop
	129
	str wait_for_async
	tuple 1
	import.nm util
	import.from wait_for_async
	st.name wait_for_async
	pop
	mkfun 2
	st.name _is_motor
	loadname RuntimeError
	constobj 0
	call 1
	st.name _DISCONNECTED_ERROR
	loadname RuntimeError
	constobj 1
	call 1
	st.name _MOTOR_PAIRING_ERROR
	buildclass
	mkfun 3
	str MotorPair
	call 2
	st.name MotorPair
	mkfun 4
	st.name clamp_steering
	none
	ret
	