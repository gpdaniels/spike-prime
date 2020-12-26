__init__: ;runtime/virtualmachine.py
	ldloc.1
	ldloc.0
	st.attr json_rpc
	ldloc.2
	ldloc.0
	st.attr system
	ldloc.3
	ldloc.0
	st.attr stop
	ldloc.4
	ldloc.0
	st.attr target_name
	false
	ldloc.0
	st.attr running
	list 0
	ldloc.0
	st.attr _stacks
	list 0
	ldloc.0
	st.attr _on_start
	list 0
	ldloc.0
	st.attr _on_condition
	map 0
	ldloc.0
	st.attr _on_broadcast
	glbl DirtyDict
	call 0
	ldloc.0
	st.attr vars
	glbl DirtyDict
	call 0
	ldloc.0
	st.attr lists
	glbl VMStore
	call 0
	ldloc.0
	st.attr store
	map 0
	ldloc.0
	st.attr extensions
	ldloc.0
	method check_all_conditions
	call.meth 0
	ldloc.0
	st.attr _condition_test_coro
	ldloc.0
	attr system
	attr callbacks
	method reset
	call.meth 0
	pop
	none
	ret
	
register_on_start: ;runtime/virtualmachine.py
	glbl Stack
	ldloc.0
	ldloc.1
	glbl Stack
	attr ON_START
	ldloc.2
	call 4
	stloc.3
	ldloc.0
	attr _stacks
	method append
	ldloc.3
	call.meth 1
	pop
	ldloc.0
	attr _on_start
	method append
	ldloc.3
	call.meth 1
	pop
	ldloc.3
	ret
	
register_on_condition: ;runtime/virtualmachine.py
	glbl Stack
	ldloc.0
	ldloc.1
	glbl Stack
	attr ON_CONDITION
	ldloc.2
	str condition
	ldloc.3
	call 130, 4
	stloc.4
	ldloc.0
	attr _stacks
	method append
	ldloc.4
	call.meth 1
	pop
	ldloc.0
	attr _on_condition
	method append
	ldloc.4
	call.meth 1
	pop
	ldloc.4
	ret
	
register_on_broadcast: ;runtime/virtualmachine.py
	glbl Stack
	ldloc.0
	ldloc.1
	glbl Stack
	attr ON_BROADCAST
	ldloc.2
	str restart_existing
	true
	call 130, 4
	stloc.4
	ldloc.0
	attr _stacks
	method append
	ldloc.4
	call.meth 1
	pop
	ldloc.0
	attr _on_broadcast
	method setdefault
	ldloc.3
	list 0
	call.meth 2
	method append
	ldloc.4
	call.meth 1
	pop
	ldloc.4
	ret
	
callback: ;runtime/virtualmachine.py
	ldloc.2
	deref 0
	eq
	bfalse 8
	deref 1
	method start
	call.meth 0
	pop
	none
	ret
	
register_on_gesture: ;runtime/virtualmachine.py
	glbl Stack
	ldloc.0
	ldloc.1
	glbl Stack
	attr ON_GESTURE
	ldloc.2
	call 4
	st.deref 5
	ldloc.0
	attr _stacks
	method append
	deref 5
	call.meth 1
	pop
	ldloc.3
	ldloc.5
	mkclosure 4, 2
	stloc.4
	ldloc.0
	attr system
	attr callbacks
	attr gesture_callback
	method register
	ldloc.4
	call.meth 1
	pop
	deref 5
	ret
	
callback: ;runtime/virtualmachine.py
	ldloc.2
	deref 0
	eq
	bfalse 8
	deref 1
	method start
	call.meth 0
	pop
	none
	ret
	
register_on_orientation: ;runtime/virtualmachine.py
	glbl Stack
	ldloc.0
	ldloc.1
	glbl Stack
	attr ON_ORIENTATION
	ldloc.2
	call 4
	st.deref 5
	ldloc.0
	attr _stacks
	method append
	deref 5
	call.meth 1
	pop
	ldloc.3
	ldloc.5
	mkclosure 4, 2
	stloc.4
	ldloc.0
	attr system
	attr callbacks
	attr orientation_callback
	method register
	ldloc.4
	call.meth 1
	pop
	deref 5
	ret
	
callback: ;runtime/virtualmachine.py
	ldloc.1
	128
	eq
	bfalse 8
	deref 0
	method start
	call.meth 0
	pop
	none
	ret
	
callback: ;runtime/virtualmachine.py
	ldloc.1
	128
	qt
	bfalse 8
	deref 0
	method start
	call.meth 0
	pop
	none
	ret
	
register_on_button: ;runtime/virtualmachine.py
	glbl Stack
	ldloc.0
	ldloc.1
	glbl Stack
	attr ON_BUTTON
	ldloc.2
	call 4
	st.deref 6
	ldloc.0
	attr _stacks
	method append
	deref 6
	call.meth 1
	pop
	ldloc.4
	str pressed
	eq
	bfalse 8
	ldloc.6
	mkclosure 5, 1
	stloc.5
	jmp 5
	ldloc.6
	mkclosure 6, 1
	stloc.5
	ldloc.0
	attr system
	attr callbacks
	attr button_callbacks
	ldloc.3
	MP_BC_LOAD_SUBSCR
	method register
	ldloc.5
	call.meth 1
	pop
	none
	ret
	
register_callback: ;runtime/virtualmachine.py
	ldloc.0
	attr system
	attr callbacks
	attr port_callbacks
	ldloc.1
	MP_BC_LOAD_SUBSCR
	stloc.3
	ldloc.3
	bfalse 8
	ldloc.3
	method register_single
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
<listcomp>: ;runtime/virtualmachine.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 12, 0
	stloc.1
	ldloc.1
	method start
	call.meth 0
	MP_BC_STORE_COMP 20
	jmp -15
	ret
	
broadcast: ;runtime/virtualmachine.py
	mkfun 2
	ldloc.0
	attr _on_broadcast
	method get
	ldloc.1
	list 0
	call.meth 2
	call 1
	ret
	
check_all_conditions: ;runtime/virtualmachine.py
	none
	yield
	pop
	ldloc.0
	attr _on_condition
	ld.iterstack
	for.iter 20, 0
	stloc.1
	ldloc.1
	method should_start
	call.meth 0
	bfalse 7
	ldloc.1
	method start
	call.meth 0
	pop
	jmp -23
	jmp -34
	none
	ret
	
<listcomp>: ;runtime/virtualmachine.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 12, 0
	stloc.1
	ldloc.1
	method start
	call.meth 0
	MP_BC_STORE_COMP 20
	jmp -15
	ret
	
start: ;runtime/virtualmachine.py
	true
	ldloc.0
	st.attr running
	ldloc.0
	method schedule_coroutine
	glbl timer
	attr reset
	call.meth 1
	pop
	glbl PORTS
	method values
	call.meth 0
	ld.iterstack
	for.iter 22, 0
	stloc.1
	ldloc.1
	attr motor
	bfalse 11
	ldloc.1
	attr motor
	method preset
	128
	call.meth 1
	pop
	jmp -25
	mkfun 1
	ldloc.0
	attr _on_start
	call 1
	stloc.2
	ldloc.0
	attr _on_condition
	bfalse 11
	ldloc.0
	method schedule_coroutine
	ldloc.0
	attr _condition_test_coro
	call.meth 1
	pop
	ldloc.2
	ret
	
schedule_coroutine: ;runtime/virtualmachine.py
	ldloc.0
	attr running
	bfalse 14
	ldloc.0
	attr system
	attr loop
	method call_soon
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
stop_stacks: ;runtime/virtualmachine.py
	ldloc.0
	attr _stacks
	ld.iterstack
	for.iter 17, 0
	stloc.2
	ldloc.2
	ldloc.1
	ne
	bfalse 7
	ldloc.2
	method stop
	call.meth 0
	pop
	jmp -20
	none
	ret
	
shutdown: ;runtime/virtualmachine.py
	ldloc.0
	attr _on_condition
	bfalse 17
	ldloc.0
	attr system
	attr loop
	method cancel
	ldloc.0
	attr _condition_test_coro
	call.meth 1
	pop
	ldloc.0
	method stop_stacks
	call.meth 0
	pop
	ldloc.0
	attr system
	attr callbacks
	method reset
	call.meth 0
	pop
	false
	ldloc.0
	st.attr running
	ldloc.0
	attr extensions
	ld.iterstack
	for.iter 16, 0
	stloc.1
	ldloc.0
	attr extensions
	ldloc.1
	MP_BC_LOAD_SUBSCR
	method stop
	call.meth 0
	pop
	jmp -19
	none
	ret
	
reset_timer: ;runtime/virtualmachine.py
	glbl timer
	method reset
	call.meth 0
	pop
	none
	ret
	
reset_time: ;runtime/virtualmachine.py
	glbl reset_time
	call 0
	pop
	none
	ret
	
get_time: ;runtime/virtualmachine.py
	glbl get_time
	call 0
	ret
	
VirtualMachine: ;runtime/virtualmachine.py
	loadname __name__
	st.name __module__
	str VirtualMachine
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name register_on_start
	mkfun 2
	st.name register_on_condition
	mkfun 3
	st.name register_on_broadcast
	mkfun 4
	st.name register_on_gesture
	mkfun 5
	st.name register_on_orientation
	mkfun 6
	st.name register_on_button
	mkfun 7
	st.name register_callback
	mkfun 8
	st.name broadcast
	mkfun 9
	st.name check_all_conditions
	mkfun 10
	st.name start
	mkfun 11
	st.name schedule_coroutine
	null
	map 0
	none
	str except_stack
	st.map
	mkfun.defargs 12
	st.name stop_stacks
	mkfun 13
	st.name shutdown
	mkfun 14
	st.name reset_timer
	mkfun 15
	st.name reset_time
	mkfun 16
	st.name get_time
	none
	ret
	
<module>: ;runtime/virtualmachine.py
	128
	none
	import.nm hub
	st.name hub
	128
	str timer
	tuple 1
	import.nm runtime
	import.from timer
	st.name timer
	pop
	128
	str DirtyDict
	tuple 1
	import.nm runtime.dirty_dict
	import.from DirtyDict
	st.name DirtyDict
	pop
	128
	str VMStore
	tuple 1
	import.nm runtime.vm_store
	import.from VMStore
	st.name VMStore
	pop
	128
	str Stack
	tuple 1
	import.nm runtime.stack
	import.from Stack
	st.name Stack
	pop
	128
	str JSONRPC
	tuple 1
	import.nm protocol.ujsonrpc
	import.from JSONRPC
	st.name JSONRPC
	pop
	128
	str System
	tuple 1
	import.nm system
	import.from System
	st.name System
	pop
	128
	str PORTS
	tuple 1
	import.nm util.constants
	import.from PORTS
	st.name PORTS
	pop
	128
	str get_time
	str reset_time
	tuple 2
	import.nm util.time
	import.from get_time
	st.name get_time
	import.from reset_time
	st.name reset_time
	pop
	buildclass
	mkfun 0
	str VirtualMachine
	call 2
	st.name VirtualMachine
	none
	ret
	