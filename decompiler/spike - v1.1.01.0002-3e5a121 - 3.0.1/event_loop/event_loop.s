__init__: ;event_loop/event_loop.py
	ldloc.1
	ldloc.0
	st.attr queue_length
	glbl ucollections
	method deque
	tuple 0
	ldloc.0
	attr queue_length
	call.meth 2
	ldloc.0
	st.attr run_queue
	glbl utimeq
	method utimeq
	ldloc.0
	attr queue_length
	call.meth 1
	ldloc.0
	st.attr wait_queue
	glbl set
	call 0
	ldloc.0
	st.attr active_set
	glbl set
	call 0
	ldloc.0
	st.attr stop_set
	none
	ret
	
call_soon: ;event_loop/event_loop.py
	ldloc.0
	attr run_queue
	method append
	ldloc.1
	call.meth 1
	pop
	ldloc.0
	attr active_set
	method add
	glbl id
	ldloc.1
	call 1
	call.meth 1
	pop
	glbl callable
	ldloc.1
	call 1
	bfalse 11
	ldloc.0
	attr run_queue
	method append
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
cancel: ;event_loop/event_loop.py
	glbl id
	ldloc.1
	call 1
	stloc.2
	ldloc.2
	ldloc.0
	attr active_set
	in
	bfalse 11
	ldloc.0
	attr stop_set
	method add
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
_discard: ;event_loop/event_loop.py
	ldloc.0
	attr active_set
	method discard
	ldloc.1
	call.meth 1
	pop
	ldloc.0
	attr stop_set
	method discard
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
run_forever: ;event_loop/event_loop.py
	ldloc.0
	method step
	str exc_handler
	ldloc.1
	call.meth 130, 0
	attr __next__
	stloc.2
	ldloc.2
	call 0
	pop
	jmp -7
	none
	ret
	
<lambda>: ;event_loop/event_loop.py
	none
	yield
	pop
	none
	ret
	
step: ;event_loop/event_loop.py
	128
	mkfun 2
	tuple 0
	list 3
	stloc.2
	glbl callable
	stloc.3
	glbl next
	stloc.4
	glbl id
	stloc.5
	ldloc.0
	attr run_queue
	stloc.6
	ldloc.6
	attr append
	stloc.7
	ldloc.6
	attr popleft
	stloc.8
	ldloc.0
	attr wait_queue
	stloc.9
	ldloc.9
	attr peektime
	stloc.10
	ldloc.9
	attr push
	stloc.11
	ldloc.9
	attr pop
	stloc.12
	ldloc.0
	attr stop_set
	stloc.13
	glbl utime
	attr ticks_add
	stloc.14
	glbl utime
	attr ticks_diff
	stloc.15
	glbl utime
	attr ticks_ms
	MP_BC_STORE_FAST_N 16
	ldloc.0
	attr _discard
	MP_BC_STORE_FAST_N 17
	tuple 0
	MP_BC_STORE_FAST_N 18
	jmp 52
	ldloc.15
	ldloc.10
	call 0
	MP_BC_LOAD_FAST_N 16
	call 0
	call 2
	128
	qt
	bfalse 3
	jmp 38
	ldloc.12
	ldloc.2
	call 1
	pop
	ldloc.2
	MP_BC_UNPACK_SEQUENCE 3
	MP_BC_STORE_FAST_N 19
	MP_BC_STORE_FAST_N 20
	MP_BC_STORE_FAST_N 21
	ldloc.7
	MP_BC_LOAD_FAST_N 20
	call 1
	pop
	ldloc.3
	MP_BC_LOAD_FAST_N 20
	call 1
	bfalse 6
	ldloc.7
	MP_BC_LOAD_FAST_N 21
	call 1
	pop
	ldloc.9
	btrue -56
	glbl max
	138
	glbl len
	ldloc.6
	call 1
	call 2
	MP_BC_STORE_FAST_N 22
	jmp 204
	MP_BC_LOAD_FAST_N 22
	129
	sub.in
	MP_BC_STORE_FAST_N 22
	ldloc.8
	call 0
	MP_BC_STORE_FAST_N 20
	ldloc.3
	MP_BC_LOAD_FAST_N 20
	call 1
	bfalse 22
	MP_BC_LOAD_FAST_N 22
	129
	sub.in
	MP_BC_STORE_FAST_N 22
	ldloc.8
	call 0
	MP_BC_STORE_FAST_N 21
	MP_BC_LOAD_FAST_N 20
	MP_BC_LOAD_FAST_N 21
	null
	call.kw 0
	pop
	jmp 163
	except.setup 67, 0
	ldloc.5
	MP_BC_LOAD_FAST_N 20
	call 1
	MP_BC_STORE_FAST_N 23
	MP_BC_LOAD_FAST_N 23
	ldloc.13
	in
	bfalse 11
	MP_BC_LOAD_FAST_N 17
	MP_BC_LOAD_FAST_N 23
	call 1
	pop
	jmp.unwind 136, undefined
	ldloc.4
	MP_BC_LOAD_FAST_N 20
	call 1
	MP_BC_STORE_FAST_N 24
	MP_BC_LOAD_FAST_N 24
	bfalse 21
	ldloc.11
	ldloc.14
	MP_BC_LOAD_FAST_N 16
	call 0
	MP_BC_LOAD_FAST_N 24
	call 2
	MP_BC_LOAD_FAST_N 20
	MP_BC_LOAD_FAST_N 18
	call 3
	pop
	jmp.unwind 103, undefined
	ldloc.7
	MP_BC_LOAD_FAST_N 20
	call 1
	pop
	except.jump 93, 0
	dup
	glbl StopIteration
	ematch
	bfalse 15
	pop
	MP_BC_LOAD_FAST_N 17
	MP_BC_LOAD_FAST_N 23
	call 1
	pop
	jmp.unwind 74, undefined
	except.jump 70, 0
	dup
	glbl KeyboardInterrupt
	ematch
	bfalse 12
	pop
	MP_BC_LOAD_FAST_N 17
	MP_BC_LOAD_FAST_N 23
	call 1
	pop
	rethrow
	except.jump 50, 0
	dup
	glbl BaseException
	ematch
	bfalse 41
	MP_BC_STORE_FAST_N 25
	finally.setup 27, 0
	MP_BC_LOAD_FAST_N 17
	MP_BC_LOAD_FAST_N 23
	call 1
	pop
	ldloc.3
	ldloc.1
	call 1
	bfalse 9
	ldloc.1
	MP_BC_LOAD_FAST_N 25
	call 1
	pop
	jmp 3
	MP_BC_LOAD_FAST_N 25
	raiseobj
	none
	none
	MP_BC_STORE_FAST_N 25
	del.fast 25
	finally.end
	except.jump 1, 0
	finally.end
	MP_BC_LOAD_FAST_N 22
	128
	qt
	bfalse 4
	ldloc.6
	btrue -215
	none
	yield
	pop
	jmp -297
	none
	ret
	
EventLoop: ;event_loop/event_loop.py
	loadname __name__
	st.name __module__
	str EventLoop
	st.name __qualname__
	160
	tuple 1
	null
	mkfun.defargs 0
	st.name __init__
	mkfun 1
	st.name call_soon
	mkfun 2
	st.name cancel
	mkfun 3
	st.name _discard
	none
	tuple 1
	null
	mkfun.defargs 4
	st.name run_forever
	none
	tuple 1
	null
	mkfun.defargs 5
	st.name step
	none
	ret
	
<module>: ;event_loop/event_loop.py
	128
	none
	import.nm utime
	st.name utime
	128
	none
	import.nm utimeq
	st.name utimeq
	128
	none
	import.nm ucollections
	st.name ucollections
	buildclass
	mkfun 0
	str EventLoop
	call 2
	st.name EventLoop
	none
	ret
	