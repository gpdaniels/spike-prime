__init__: ;system/callbacks/customcallbacks.py
	glbl get_event_loop
	call 0
	ldloc.0
	st.attr _loop
	none
	ret
	
clear_tasks: ;system/callbacks/customcallbacks.py
	ldloc.0
	attr _active_tasks
	ld.iterstack
	for.iter 38, 0
	stloc.1
	finally.setup 19, 0
	except.setup 10, 0
	ldloc.1
	method stop
	call.meth 0
	pop
	except.jump 5, 0
	pop
	except.jump 1, 0
	finally.end
	none
	ldloc.0
	attr _active_tasks
	method remove
	ldloc.1
	call.meth 1
	pop
	finally.end
	jmp -41
	none
	ret
	
did_bump: ;system/callbacks/customcallbacks.py
	none
	stloc.1
	128
	stloc.2
	glbl get_sensor_value
	ldloc.0
	128
	str types
	glbl LPF2_FLIPPER_FORCE
	tuple 1
	call 130, 2
	stloc.3
	ldloc.3
	none
	is
	bfalse 3
	false
	yield
	pop
	ldloc.2
	128
	eq
	bfalse 16
	ldloc.3
	128
	eq
	bfalse 4
	ldloc.2
	129
	add.in
	stloc.2
	false
	yield
	pop
	jmp 81
	ldloc.2
	129
	eq
	bfalse 25
	ldloc.3
	128
	qt
	bfalse 13
	glbl utime
	method ticks_ms
	call.meth 0
	stloc.1
	ldloc.2
	129
	add.in
	stloc.2
	false
	yield
	pop
	jmp 50
	ldloc.2
	130
	eq
	bfalse 44
	glbl utime
	method ticks_diff
	glbl utime
	method ticks_ms
	call.meth 0
	ldloc.1
	call.meth 2
	int 131, 116
	qt
	bfalse 5
	128
	stloc.2
	jmp 12
	ldloc.3
	128
	eq
	bfalse 6
	true
	yield
	pop
	jmp 0
	jmp 0
	jmp -132
	none
	ret
	
until: ;system/callbacks/customcallbacks.py
	ldloc.1
	ldloc.2
	null
	call.kw 0
	stloc.3
	none
	stloc.4
	except.setup 10, 0
	glbl next
	ldloc.3
	call 1
	stloc.4
	except.jump 15, 0
	dup
	glbl StopIteration
	ematch
	bfalse 6
	pop
	false
	stloc.4
	except.jump 1, 0
	finally.end
	ldloc.4
	bfalse 3
	jmp 6
	128
	yield
	pop
	jmp -43
	none
	ret
	
until_force_bumped: ;system/callbacks/customcallbacks.py
	ldloc.0
	method until
	ldloc.0
	attr did_bump
	ldloc.1
	call.meth 2
	ld.iter
	none
	yieldfrom
	ret
	
wait_until_force_bumped: ;system/callbacks/customcallbacks.py
	ldloc.0
	method until_force_bumped
	ldloc.1
	call.meth 1
	stloc.3
	ldloc.0
	method _start_test_task
	ldloc.3
	ldloc.2
	call.meth 2
	pop
	none
	ret
	
is_less_than: ;system/callbacks/customcallbacks.py
	128
	stloc.5
	glbl get_sensor_value
	ldloc.0
	ldloc.1
	ldloc.2
	ldloc.3
	call 4
	stloc.6
	ldloc.6
	ldloc.4
	dup
	rot3
	lt
	bfalse.pop 5
	ldloc.5
	le
	jmp 2
	rot
	pop
	yield
	pop
	ldloc.6
	stloc.5
	jmp -32
	none
	ret
	
until_less_than: ;system/callbacks/customcallbacks.py
	ldloc.0
	method until
	ldloc.0
	attr is_less_than
	ldloc.1
	ldloc.2
	ldloc.3
	ldloc.4
	ldloc.5
	call.meth 6
	ld.iter
	none
	yieldfrom
	ret
	
wait_until_less_than: ;system/callbacks/customcallbacks.py
	ldloc.0
	method until_less_than
	ldloc.1
	ldloc.2
	ldloc.3
	ldloc.4
	ldloc.5
	call.meth 5
	stloc.7
	ldloc.0
	method _start_test_task
	ldloc.7
	ldloc.6
	call.meth 2
	pop
	none
	ret
	
did_change: ;system/callbacks/customcallbacks.py
	glbl get_sensor_value
	ldloc.0
	ldloc.1
	ldloc.2
	ldloc.3
	call 4
	stloc.5
	glbl get_sensor_value
	ldloc.0
	ldloc.1
	ldloc.2
	ldloc.3
	call 4
	stloc.6
	glbl abs
	ldloc.6
	ldloc.5
	sub
	call 1
	ldloc.4
	qt
	yield
	pop
	jmp -25
	none
	ret
	
until_changed: ;system/callbacks/customcallbacks.py
	ldloc.0
	method until
	ldloc.0
	attr did_change
	ldloc.1
	ldloc.2
	ldloc.3
	ldloc.4
	ldloc.5
	call.meth 6
	ld.iter
	none
	yieldfrom
	ret
	
wait_until_changed: ;system/callbacks/customcallbacks.py
	ldloc.0
	method until_changed
	ldloc.1
	ldloc.2
	ldloc.3
	ldloc.4
	ldloc.5
	call.meth 5
	stloc.7
	ldloc.0
	method _start_test_task
	ldloc.7
	ldloc.6
	call.meth 2
	pop
	none
	ret
	
sensor_test_task: ;system/callbacks/customcallbacks.py
	none
	yield
	pop
	deref 1
	ld.iter
	none
	yieldfrom
	pop
	glbl callable
	deref 2
	call 1
	bfalse 5
	deref 2
	call 0
	pop
	deref 0
	method remove_task
	deref 3
	call.meth 1
	pop
	none
	ret
	
_start_test_task: ;system/callbacks/customcallbacks.py
	ldloc.0
	ldloc.1
	ldloc.2
	ldloc.4
	mkclosure 3, 4
	stloc.3
	ldloc.3
	call 0
	st.deref 4
	deref 0
	attr _active_tasks
	method append
	deref 4
	call.meth 1
	pop
	deref 0
	attr _loop
	method call_soon
	deref 4
	call.meth 1
	pop
	none
	ret
	
<listcomp>: ;system/callbacks/customcallbacks.py
	list 0
	ldloc.1
	ld.iterstack
	for.iter 24, 0
	stloc.2
	glbl id
	deref 0
	call 1
	glbl id
	ldloc.2
	call 1
	ne
	bfalse -21
	ldloc.2
	MP_BC_STORE_COMP 20
	jmp -27
	ret
	
remove_task: ;system/callbacks/customcallbacks.py
	ldloc.1
	mkclosure 2, 1
	ldloc.0
	attr _active_tasks
	call 1
	ret
	
CustomSensorCallbackManager: ;system/callbacks/customcallbacks.py
	loadname __name__
	st.name __module__
	str CustomSensorCallbackManager
	st.name __qualname__
	list 0
	st.name _active_tasks
	mkfun 0
	st.name __init__
	mkfun 1
	st.name clear_tasks
	loadname staticmethod
	mkfun 2
	call 1
	st.name did_bump
	mkfun 3
	st.name until
	mkfun 4
	st.name until_force_bumped
	none
	tuple 1
	null
	mkfun.defargs 5
	st.name wait_until_force_bumped
	loadname staticmethod
	mkfun 6
	call 1
	st.name is_less_than
	mkfun 7
	st.name until_less_than
	none
	tuple 1
	null
	mkfun.defargs 8
	st.name wait_until_less_than
	loadname staticmethod
	mkfun 9
	call 1
	st.name did_change
	mkfun 10
	st.name until_changed
	128
	none
	tuple 2
	null
	mkfun.defargs 11
	st.name wait_until_changed
	mkfun 12
	st.name _start_test_task
	mkfun 13
	st.name remove_task
	none
	ret
	
<module>: ;system/callbacks/customcallbacks.py
	128
	none
	import.nm utime
	st.name utime
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	str get_event_loop
	tuple 1
	import.nm event_loop
	import.from get_event_loop
	st.name get_event_loop
	pop
	128
	str get_sensor_value
	tuple 1
	import.nm util.sensors
	import.from get_sensor_value
	st.name get_sensor_value
	pop
	128
	str LPF2_FLIPPER_FORCE
	tuple 1
	import.nm util.constants
	import.from LPF2_FLIPPER_FORCE
	st.name LPF2_FLIPPER_FORCE
	pop
	buildclass
	mkfun 0
	str CustomSensorCallbackManager
	call 2
	st.name CustomSensorCallbackManager
	none
	ret
	