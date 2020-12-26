wait_until_ready_after_restart: ;util/resetter.py
	jmp 9
	glbl sleep_ms
	int 135, 104
	call 1
	pop
	128
	glbl ticks_diff
	glbl ticks_ms
	call 0
	glbl _STARTED_AT
	call 2
	int 135, 104
	truediv
	dup
	rot3
	lt
	bfalse.pop 5
	136
	lt
	jmp 2
	rot
	pop
	btrue -43
	none
	ret
	
__init__: ;util/resetter.py
	ldloc.1
	ldloc.0
	st.attr timer
	ldloc.2
	ldloc.0
	st.attr _cb
	ldloc.0
	attr __repl_reset
	ldloc.0
	st.attr repl_restart_ref
	none
	ret
	
start: ;util/resetter.py
	ldloc.0
	attr timer
	method deinit
	call.meth 0
	pop
	ldloc.0
	attr timer
	method init
	str callback
	ldloc.0
	attr _cb
	str period
	ldloc.1
	call.meth 132, 0
	pop
	none
	ret
	
repl_reset: ;util/resetter.py
	ldloc.0
	attr timer
	method deinit
	call.meth 0
	pop
	ldloc.0
	method repl_restart_ref
	call.meth 0
	pop
	glbl schedule
	ldloc.0
	attr repl_restart_ref
	list 0
	call 2
	pop
	none
	ret
	
__repl_reset: ;util/resetter.py
	glbl hub
	method repl_restart
	true
	call.meth 1
	pop
	none
	ret
	
RTTimer: ;util/resetter.py
	loadname __name__
	st.name __module__
	str RTTimer
	st.name __qualname__
	mkfun 0
	st.name __init__
	144
	tuple 1
	null
	mkfun.defargs 1
	st.name start
	mkfun 2
	st.name repl_reset
	mkfun 3
	st.name __repl_reset
	none
	ret
	
<module>: ;util/resetter.py
	128
	none
	import.nm hub
	st.name hub
	128
	str schedule
	tuple 1
	import.nm micropython
	import.from schedule
	st.name schedule
	pop
	128
	str ticks_ms
	str ticks_diff
	str sleep_ms
	tuple 3
	import.nm utime
	import.from ticks_ms
	st.name ticks_ms
	import.from ticks_diff
	st.name ticks_diff
	import.from sleep_ms
	st.name sleep_ms
	pop
	loadname ticks_ms
	call 0
	st.name _STARTED_AT
	mkfun 0
	st.name wait_until_ready_after_restart
	buildclass
	mkfun 1
	str RTTimer
	call 2
	st.name RTTimer
	none
	ret
	