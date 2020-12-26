<lambda>: ;system/motorwrapper.py
	deref 0
	method default
	str callback
	ldloc.1
	call.meth 130, 0
	ret
	
__init__: ;system/motorwrapper.py
	deref 2
	ldloc.1
	st.attr motor
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	deref 2
	bfalse.pop 4
	ldloc.2
	mkclosure 3, 1
	call.meth 1
	pop
	none
	ret
	
run_at_speed: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 35
	ldloc.0
	method _register
	ldloc.5
	call.meth 1
	pop
	ldloc.0
	attr motor
	method run_at_speed
	ldloc.1
	str stall
	ldloc.2
	str acceleration
	ldloc.3
	str deceleration
	ldloc.4
	call.meth 134, 1
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
	
run_at_speed_async: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 42
	ldloc.0
	method _register
	call.meth 0
	stloc.5
	ldloc.0
	attr motor
	method run_at_speed
	ldloc.1
	str stall
	ldloc.2
	str acceleration
	ldloc.3
	str deceleration
	ldloc.4
	call.meth 134, 1
	pop
	ldloc.0
	method await_callback
	ldloc.5
	call.meth 1
	ld.iter
	none
	yieldfrom
	ret
	glbl SUCCESS
	ret
	
run_for_time: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 40
	ldloc.0
	method _register
	ldloc.7
	call.meth 1
	pop
	ldloc.0
	attr motor
	method run_for_time
	ldloc.1
	ldloc.2
	str stall
	ldloc.3
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 136, 2
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
	
run_for_time_async: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 47
	ldloc.0
	method _register
	call.meth 0
	stloc.7
	ldloc.0
	attr motor
	method run_for_time
	ldloc.1
	ldloc.2
	str stall
	ldloc.3
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 136, 2
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
	
run_for_degrees: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 51
	ldloc.0
	method _register
	ldloc.7
	call.meth 1
	pop
	ldloc.0
	attr motor
	method run_for_degrees
	ldloc.1
	ldloc.1
	128
	qt
	bfalse 4
	ldloc.2
	jmp 2
	ldloc.2
	neg
	str stall
	ldloc.3
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 136, 2
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
	
run_for_degrees_async: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 58
	ldloc.0
	method _register
	call.meth 0
	stloc.7
	ldloc.0
	attr motor
	method run_for_degrees
	ldloc.1
	ldloc.1
	128
	qt
	bfalse 4
	ldloc.2
	jmp 2
	ldloc.2
	neg
	str stall
	ldloc.3
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 136, 2
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
	
run_to_position: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 57
	ldloc.0
	method _register
	ldloc.8
	call.meth 1
	pop
	glbl _calc_degrees
	ldloc.0
	attr motor
	method get
	call.meth 0
	ldloc.3
	ldloc.1
	call 3
	stloc.9
	ldloc.0
	attr motor
	method run_to_position
	ldloc.9
	ldloc.2
	str stall
	ldloc.4
	str stop
	ldloc.5
	str acceleration
	ldloc.6
	str deceleration
	ldloc.7
	call.meth 136, 2
	pop
	jmp 19
	glbl callable
	ldloc.8
	call 1
	bfalse 10
	ldloc.8
	glbl SUCCESS
	call 1
	pop
	jmp 0
	none
	ret
	
run_to_position_async: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 64
	ldloc.0
	method _register
	call.meth 0
	stloc.8
	glbl _calc_degrees
	ldloc.0
	attr motor
	method get
	call.meth 0
	ldloc.3
	ldloc.1
	call 3
	stloc.9
	ldloc.0
	attr motor
	method run_to_position
	ldloc.9
	ldloc.2
	str stall
	ldloc.4
	str stop
	ldloc.5
	str acceleration
	ldloc.6
	str deceleration
	ldloc.7
	call.meth 136, 2
	pop
	ldloc.0
	method await_callback
	ldloc.8
	call.meth 1
	ld.iter
	none
	yieldfrom
	ret
	glbl SUCCESS
	ret
	
run_to_relative_position: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 40
	ldloc.0
	method _register
	ldloc.7
	call.meth 1
	pop
	ldloc.0
	attr motor
	method run_to_position
	ldloc.1
	ldloc.2
	str stall
	ldloc.3
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 136, 2
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
	
run_to_relative_position_async: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 47
	ldloc.0
	method _register
	call.meth 0
	stloc.7
	ldloc.0
	attr motor
	method run_to_position
	ldloc.1
	ldloc.2
	str stall
	ldloc.3
	str stop
	ldloc.4
	str acceleration
	ldloc.5
	str deceleration
	ldloc.6
	call.meth 136, 2
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
	
pwm: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 46
	ldloc.0
	method _register
	call.meth 0
	pop
	ldloc.0
	attr motor
	method default
	call.meth 0
	stloc.3
	ldloc.2
	ldloc.3
	str stall
	MP_BC_STORE_SUBSCR
	ldloc.0
	attr motor
	method default
	null
	ldloc.3
	call.kvmeth 0
	pop
	ldloc.0
	attr motor
	method pwm
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
stop: ;system/motorwrapper.py
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
	
brake: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 17
	ldloc.0
	method _register
	call.meth 0
	pop
	ldloc.0
	attr motor
	method brake
	call.meth 0
	pop
	none
	ret
	
float: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 17
	ldloc.0
	method _register
	call.meth 0
	pop
	ldloc.0
	attr motor
	method float
	call.meth 0
	pop
	none
	ret
	
hold: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 17
	ldloc.0
	method _register
	call.meth 0
	pop
	ldloc.0
	attr motor
	method hold
	call.meth 0
	pop
	none
	ret
	
<genexpr>: ;system/motorwrapper.py
	null
	ldloc.0
	null
	null
	for.iter 10, 0
	stloc.1
	ldloc.1
	none
	is
	not
	yield
	pop
	jmp -13
	none
	ret
	
get: ;system/motorwrapper.py
	ldloc.0
	attr motor
	btrue 3
	tuple 0
	ret
	ldloc.0
	attr motor
	method get
	call.meth 0
	stloc.1
	glbl all
	mkfun 1
	ldloc.1
	ld.iter
	call 1
	call 1
	bfalse 2
	ldloc.1
	ret
	tuple 0
	ret
	
preset: ;system/motorwrapper.py
	ldloc.0
	attr motor
	bfalse 18
	ldloc.0
	method _register
	call.meth 0
	pop
	ldloc.0
	attr motor
	method preset
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
MotorWrapper: ;system/motorwrapper.py
	loadname __name__
	st.name __module__
	str MotorWrapper
	st.name __qualname__
	none
	st.name motor
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	none
	none
	none
	tuple 3
	null
	mkfun.defargs 1
	st.name run_at_speed
	none
	none
	tuple 2
	null
	mkfun.defargs 2
	st.name run_at_speed_async
	none
	none
	none
	tuple 3
	null
	mkfun.defargs 3
	st.name run_for_time
	none
	none
	tuple 2
	null
	mkfun.defargs 4
	st.name run_for_time_async
	none
	none
	none
	tuple 3
	null
	mkfun.defargs 5
	st.name run_for_degrees
	none
	none
	tuple 2
	null
	mkfun.defargs 6
	st.name run_for_degrees_async
	none
	none
	none
	tuple 3
	null
	mkfun.defargs 7
	st.name run_to_position
	none
	none
	tuple 2
	null
	mkfun.defargs 8
	st.name run_to_position_async
	none
	none
	none
	tuple 3
	null
	mkfun.defargs 9
	st.name run_to_relative_position
	none
	none
	tuple 2
	null
	mkfun.defargs 10
	st.name run_to_relative_position_async
	mkfun 11
	st.name pwm
	mkfun 12
	st.name stop
	mkfun 13
	st.name brake
	mkfun 14
	st.name float
	mkfun 15
	st.name hold
	mkfun 16
	st.name get
	mkfun 17
	st.name preset
	ldloc.0
	ret
	
_calc_degrees: ;system/motorwrapper.py
	ldloc.0
	129
	MP_BC_LOAD_SUBSCR
	stloc.3
	ldloc.0
	130
	MP_BC_LOAD_SUBSCR
	stloc.4
	none
	stloc.5
	ldloc.1
	str clockwise
	eq
	bfalse 11
	glbl _clockwise
	ldloc.4
	ldloc.2
	call 2
	stloc.5
	jmp 37
	ldloc.1
	constobj 3
	eq
	bfalse 11
	glbl _counterclockwise
	ldloc.4
	ldloc.2
	call 2
	stloc.5
	jmp 19
	ldloc.1
	str shortest
	eq
	bfalse 11
	glbl _shortest
	ldloc.4
	ldloc.2
	call 2
	stloc.5
	jmp 0
	ldloc.3
	ldloc.5
	add
	ret
	
_clockwise: ;system/motorwrapper.py
	ldloc.1
	int 130, 104
	mod
	stloc.2
	ldloc.2
	ldloc.0
	lt
	bfalse 10
	int 130, 104
	ldloc.0
	sub
	ldloc.2
	add
	jmp 3
	ldloc.2
	ldloc.0
	sub
	stloc.3
	ldloc.3
	int 130, 104
	mod
	ret
	
_counterclockwise: ;system/motorwrapper.py
	ldloc.1
	int 130, 104
	mod
	stloc.2
	ldloc.2
	ldloc.0
	lt
	bfalse 8
	128
	ldloc.2
	sub
	ldloc.0
	add
	jmp 7
	ldloc.0
	ldloc.2
	sub
	int 130, 104
	add
	stloc.3
	ldloc.3
	int 130, 104
	mod
	127
	mul
	ret
	
_shortest: ;system/motorwrapper.py
	glbl _clockwise
	ldloc.0
	ldloc.1
	call 2
	stloc.2
	glbl _counterclockwise
	ldloc.0
	ldloc.1
	call 2
	stloc.3
	glbl abs
	ldloc.2
	call 1
	glbl abs
	ldloc.3
	call 1
	qt
	bfalse 2
	ldloc.3
	ret
	ldloc.2
	ret
	
<module>: ;system/motorwrapper.py
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	str AbstractWrapper
	tuple 1
	import.nm system.abstractwrapper
	import.from AbstractWrapper
	st.name AbstractWrapper
	pop
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
	buildclass
	mkfun 0
	str MotorWrapper
	loadname AbstractWrapper
	call 3
	st.name MotorWrapper
	mkfun 1
	st.name _calc_degrees
	mkfun 2
	st.name _clockwise
	mkfun 3
	st.name _counterclockwise
	mkfun 4
	st.name _shortest
	none
	ret
	