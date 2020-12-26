__init__: ;runtime/stack.py
	ldloc.3
	ldloc.0
	st.attr event
	ldloc.4
	ldloc.0
	st.attr make_coro
	ldloc.5
	ldloc.0
	st.attr restart_existing
	glbl Stack
	attr STATUS_IDLE
	ldloc.0
	st.attr status
	ldloc.2
	ldloc.0
	st.attr stackid
	ldloc.6
	ldloc.0
	st.attr condition
	ldloc.1
	ldloc.0
	st.attr vm
	none
	ldloc.0
	st.attr _coro
	ldloc.0
	method _check_condition
	call.meth 0
	ldloc.0
	st.attr _condition_gen
	none
	ret
	
coro: ;runtime/stack.py
	glbl notify_stack_start
	deref 0
	attr vm
	attr json_rpc
	deref 0
	attr stackid
	call 2
	pop
	deref 0
	method make_coro
	deref 0
	attr vm
	deref 0
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	glbl Stack
	attr STATUS_IDLE
	deref 0
	st.attr status
	none
	yield
	pop
	glbl notify_stack_stop
	deref 0
	attr vm
	attr json_rpc
	deref 0
	attr stackid
	call 2
	pop
	none
	ret
	
start: ;runtime/stack.py
	deref 0
	attr restart_existing
	bfalse 18
	deref 0
	method is_active
	call.meth 0
	bfalse 8
	deref 0
	method stop
	call.meth 0
	pop
	deref 0
	attr status
	glbl Stack
	attr STATUS_IDLE
	eq
	bfalse 40
	glbl Stack
	attr STATUS_RUNNING
	deref 0
	st.attr status
	ldloc.0
	mkclosure 1, 1
	stloc.1
	ldloc.1
	call 0
	deref 0
	st.attr _coro
	deref 0
	attr vm
	method schedule_coroutine
	deref 0
	attr _coro
	call.meth 1
	pop
	deref 0
	ret
	
stop: ;runtime/stack.py
	ldloc.0
	attr status
	glbl Stack
	attr STATUS_RUNNING
	eq
	bfalse 54
	ldloc.0
	attr _coro
	bfalse 47
	ldloc.0
	attr vm
	attr system
	attr loop
	method cancel
	ldloc.0
	attr _coro
	call.meth 1
	pop
	glbl notify_stack_stop
	ldloc.0
	attr vm
	attr json_rpc
	ldloc.0
	attr stackid
	call 2
	pop
	glbl Stack
	attr STATUS_IDLE
	ldloc.0
	st.attr status
	none
	ret
	
restart: ;runtime/stack.py
	glbl Stack
	attr STATUS_IDLE
	ldloc.0
	st.attr status
	ldloc.0
	method start
	call.meth 0
	pop
	none
	ret
	
is_active: ;runtime/stack.py
	ldloc.0
	attr status
	glbl Stack
	attr STATUS_RUNNING
	eq
	ret
	
should_start: ;runtime/stack.py
	ldloc.0
	method is_active
	call.meth 0
	not
	bfalse.pop 9
	glbl next
	ldloc.0
	attr _condition_gen
	call 1
	ret
	
_check_condition: ;runtime/stack.py
	false
	stloc.1
	glbl bool
	ldloc.0
	method condition
	ldloc.0
	attr vm
	ldloc.0
	call.meth 2
	call 1
	stloc.2
	ldloc.1
	ldloc.2
	xor
	bfalse.pop 1
	ldloc.2
	yield
	pop
	ldloc.2
	stloc.1
	glbl bool
	ldloc.0
	method condition
	ldloc.0
	attr vm
	ldloc.0
	call.meth 2
	call 1
	stloc.2
	jmp -31
	none
	ret
	
Stack: ;runtime/stack.py
	loadname __name__
	st.name __module__
	str Stack
	st.name __qualname__
	128
	st.name ON_START
	129
	st.name ON_BROADCAST
	130
	st.name ON_BUTTON
	131
	st.name ON_GESTURE
	132
	st.name ON_CONDITION
	133
	st.name ON_ORIENTATION
	138
	st.name STATUS_RUNNING
	148
	st.name STATUS_IDLE
	158
	st.name STATUS_WAITING
	null
	map 0
	false
	str restart_existing
	st.map
	none
	str condition
	st.map
	mkfun.defargs 0
	st.name __init__
	mkfun 1
	st.name start
	mkfun 2
	st.name stop
	mkfun 3
	st.name restart
	mkfun 4
	st.name is_active
	mkfun 5
	st.name should_start
	mkfun 6
	st.name _check_condition
	none
	ret
	
<module>: ;runtime/stack.py
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	str notify_stack_start
	str notify_stack_stop
	tuple 2
	import.nm protocol.notifications
	import.from notify_stack_start
	st.name notify_stack_start
	import.from notify_stack_stop
	st.name notify_stack_stop
	pop
	buildclass
	mkfun 0
	str Stack
	call 2
	st.name Stack
	none
	ret
	