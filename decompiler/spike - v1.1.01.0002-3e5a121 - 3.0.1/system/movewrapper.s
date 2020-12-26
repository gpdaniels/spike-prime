__init__: ;system/movewrapper.py
	ldloc.2
	ldloc.1
	st.attr pair
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	ldloc.2
	bfalse.pop 4
	ldloc.2
	attr callback
	call.meth 1
	pop
	none
	ret
	
unpair: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse.pop 9
	ldloc.0
	attr pair
	method unpair
	call.meth 0
	ret
	
is_valid: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse.pop 13
	ldloc.0
	attr pair
	method id
	call.meth 0
	int 129, 127
	ne
	ret
	
move_for_time: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 50
	ldloc.0
	method _register
	ldloc.7
	call.meth 1
	pop
	ldloc.0
	attr pair
	method run_for_time
	ldloc.1
	ldloc.2
	neg
	ldloc.3
	neg
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 134, 3
	false
	is
	bfalse 7
	ldloc.0
	method cancel
	call.meth 0
	pop
	jmp 19
	glbl callable
	ldloc.7
	call 1
	bfalse 10
	ldloc.7
	glbl SUCCESS
	call 1
	pop
	jmp 0
	none
	ret
	
move_for_time_async: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 57
	ldloc.0
	method _register
	call.meth 0
	stloc.7
	ldloc.0
	attr pair
	method run_for_time
	ldloc.1
	ldloc.2
	neg
	ldloc.3
	neg
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 134, 3
	false
	is
	bfalse 7
	ldloc.0
	method cancel
	call.meth 0
	pop
	ldloc.0
	method await_callback
	ldloc.7
	call.meth 1
	ld.iter
	none
	yieldfrom
	ret
	glbl SUCCESS
	ret
	
start_at_speeds: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 45
	ldloc.0
	method _register
	ldloc.5
	call.meth 1
	pop
	ldloc.0
	attr pair
	method run_at_speed
	ldloc.1
	neg
	ldloc.2
	neg
	str acceleration
	ldloc.3
	str deceleration
	ldloc.4
	call.meth 132, 2
	false
	is
	bfalse 7
	ldloc.0
	method cancel
	call.meth 0
	pop
	jmp 19
	glbl callable
	ldloc.5
	call 1
	bfalse 10
	ldloc.5
	glbl SUCCESS
	call 1
	pop
	jmp 0
	none
	ret
	
start_at_powers: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 36
	ldloc.0
	method _register
	ldloc.3
	call.meth 1
	pop
	ldloc.0
	attr pair
	method pwm
	ldloc.1
	neg
	ldloc.2
	neg
	call.meth 2
	false
	is
	bfalse 7
	ldloc.0
	method cancel
	call.meth 0
	pop
	jmp 19
	glbl callable
	ldloc.3
	call 1
	bfalse 10
	ldloc.3
	glbl SUCCESS
	call 1
	pop
	jmp 0
	none
	ret
	
move_differential_speed: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 49
	ldloc.0
	method _register
	ldloc.7
	call.meth 1
	pop
	ldloc.0
	attr pair
	method run_for_degrees
	ldloc.1
	ldloc.2
	neg
	ldloc.3
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 134, 3
	false
	is
	bfalse 7
	ldloc.0
	method cancel
	call.meth 0
	pop
	jmp 19
	glbl callable
	ldloc.7
	call 1
	bfalse 10
	ldloc.7
	glbl SUCCESS
	call 1
	pop
	jmp 0
	none
	ret
	
move_differential_speed_async: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 56
	ldloc.0
	method _register
	call.meth 0
	stloc.7
	ldloc.0
	attr pair
	method run_for_degrees
	ldloc.1
	ldloc.2
	neg
	ldloc.3
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 134, 3
	false
	is
	bfalse 7
	ldloc.0
	method cancel
	call.meth 0
	pop
	ldloc.0
	method await_callback
	ldloc.7
	call.meth 1
	ld.iter
	none
	yieldfrom
	ret
	glbl SUCCESS
	ret
	
move_at_power: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 19
	ldloc.0
	method _register
	call.meth 0
	pop
	ldloc.0
	attr pair
	method pwm
	ldloc.1
	ldloc.2
	call.meth 2
	pop
	none
	ret
	
stop: ;system/movewrapper.py
	ldloc.1
	glbl FLOAT
	eq
	bfalse 10
	ldloc.0
	method float
	call.meth 0
	pop
	jmp 36
	ldloc.1
	glbl BRAKE
	eq
	bfalse 10
	ldloc.0
	method brake
	call.meth 0
	pop
	jmp 18
	ldloc.1
	glbl HOLD
	eq
	bfalse 10
	ldloc.0
	method hold
	call.meth 0
	pop
	jmp 0
	none
	ret
	
brake: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 17
	ldloc.0
	method _register
	call.meth 0
	pop
	ldloc.0
	attr pair
	method brake
	call.meth 0
	pop
	none
	ret
	
float: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 17
	ldloc.0
	method _register
	call.meth 0
	pop
	ldloc.0
	attr pair
	method float
	call.meth 0
	pop
	none
	ret
	
hold: ;system/movewrapper.py
	ldloc.0
	attr pair
	bfalse 17
	ldloc.0
	method _register
	call.meth 0
	pop
	ldloc.0
	attr pair
	method hold
	call.meth 0
	pop
	none
	ret
	
_direction_to_steering: ;system/movewrapper.py
	ldloc.1
	str fw
	str fwd
	str forward
	list 3
	in
	bfalse 5
	128
	ldloc.2
	tuple 2
	ret
	ldloc.1
	str bw
	str back
	str backward
	str backwards
	str rev
	str reverse
	list 6
	in
	bfalse 6
	128
	ldloc.2
	neg
	tuple 2
	ret
	ldloc.1
	str cw
	str clock
	str clockwise
	list 3
	in
	bfalse 7
	int 128, 100
	ldloc.2
	tuple 2
	ret
	ldloc.1
	str ccw
	str counter
	constobj 3
	list 3
	in
	bfalse 7
	int 255, 28
	ldloc.2
	tuple 2
	ret
	except.setup 29, 0
	glbl max
	int 255, 28
	glbl min
	int 128, 100
	glbl int
	ldloc.1
	call 1
	call 2
	call 2
	ldloc.2
	tuple 2
	ret
	except.jump 27, 0
	dup
	glbl Exception
	ematch
	bfalse 18
	stloc.3
	finally.setup 6, 0
	128
	128
	tuple 2
	ret
	none
	none
	stloc.3
	del.fast 3
	finally.end
	except.jump 1, 0
	finally.end
	none
	ret
	
from_direction: ;system/movewrapper.py
	ldloc.0
	method _direction_to_steering
	ldloc.1
	ldloc.2
	call.meth 2
	MP_BC_UNPACK_SEQUENCE 2
	stloc.3
	stloc.4
	glbl from_steering
	ldloc.3
	ldloc.4
	call 2
	ret
	
from_steering: ;system/movewrapper.py
	glbl from_steering
	ldloc.1
	ldloc.2
	call 2
	ret
	
MoveWrapper: ;system/movewrapper.py
	loadname __name__
	st.name __module__
	str MoveWrapper
	st.name __qualname__
	none
	st.name pair
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	mkfun 1
	st.name unpair
	mkfun 2
	st.name is_valid
	none
	none
	none
	tuple 3
	null
	mkfun.defargs 3
	st.name move_for_time
	none
	none
	tuple 2
	null
	mkfun.defargs 4
	st.name move_for_time_async
	none
	none
	none
	tuple 3
	null
	mkfun.defargs 5
	st.name start_at_speeds
	none
	tuple 1
	null
	mkfun.defargs 6
	st.name start_at_powers
	none
	none
	none
	tuple 3
	null
	mkfun.defargs 7
	st.name move_differential_speed
	none
	none
	tuple 2
	null
	mkfun.defargs 8
	st.name move_differential_speed_async
	mkfun 9
	st.name move_at_power
	mkfun 10
	st.name stop
	mkfun 11
	st.name brake
	mkfun 12
	st.name float
	mkfun 13
	st.name hold
	mkfun 14
	st.name _direction_to_steering
	mkfun 15
	st.name from_direction
	int 128, 100
	tuple 1
	null
	mkfun.defargs 16
	st.name from_steering
	ldloc.0
	ret
	
from_steering: ;system/movewrapper.py
	ldloc.1
	int 128, 100
	truediv
	stloc.2
	ldloc.0
	int 128, 100
	int 255, 28
	tuple 2
	in
	bfalse 8
	ldloc.0
	stloc.3
	ldloc.0
	neg
	stloc.4
	jmp 46
	glbl min
	int 128, 100
	glbl max
	int 255, 28
	int 255, 28
	ldloc.0
	sub
	call 2
	call 2
	neg
	stloc.3
	glbl min
	int 128, 100
	glbl max
	int 255, 28
	int 255, 28
	ldloc.0
	add
	call 2
	call 2
	neg
	stloc.4
	glbl int
	ldloc.3
	ldloc.2
	mul
	call 1
	glbl int
	ldloc.4
	ldloc.2
	mul
	call 1
	tuple 2
	ret
	
<module>: ;system/movewrapper.py
	128
	str SUCCESS
	str FLOAT
	str BRAKE
	str HOLD
	tuple 4
	import.nm util.constants
	import.from SUCCESS
	st.name SUCCESS
	import.from FLOAT
	st.name FLOAT
	import.from BRAKE
	st.name BRAKE
	import.from HOLD
	st.name HOLD
	pop
	129
	str AbstractWrapper
	tuple 1
	import.nm abstractwrapper
	import.from AbstractWrapper
	st.name AbstractWrapper
	pop
	buildclass
	mkfun 0
	str MoveWrapper
	loadname AbstractWrapper
	call 3
	st.name MoveWrapper
	int 128, 100
	tuple 1
	null
	mkfun.defargs 1
	st.name from_steering
	none
	ret
	