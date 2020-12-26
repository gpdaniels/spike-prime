wait_for_seconds: ;_api/control.py
	glbl isinstance
	ldloc.0
	glbl int
	glbl float
	tuple 2
	call 2
	btrue 8
	glbl TypeError
	constobj 1
	call 1
	raiseobj
	ldloc.0
	128
	lt
	bfalse 8
	glbl ValueError
	constobj 2
	call 1
	raiseobj
	glbl sleep
	ldloc.0
	call 1
	pop
	none
	ret
	
wait_until: ;_api/control.py
	glbl callable
	ldloc.0
	call 1
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	glbl callable
	ldloc.1
	call 1
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	jmp 0
	ldloc.1
	ldloc.0
	call 0
	ldloc.2
	call 2
	bfalse -10
	none
	ret
	
__init__: ;_api/control.py
	glbl ticks_ms
	call 0
	ldloc.0
	st.attr _started_at
	none
	ret
	
reset: ;_api/control.py
	glbl ticks_ms
	call 0
	ldloc.0
	st.attr _started_at
	none
	ret
	
now: ;_api/control.py
	glbl round
	glbl ticks_diff
	glbl ticks_ms
	call 0
	ldloc.0
	attr _started_at
	call 2
	int 135, 104
	truediv
	call 1
	ret
	
Timer: ;_api/control.py
	loadname __name__
	st.name __module__
	str Timer
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name reset
	mkfun 2
	st.name now
	none
	ret
	
<module>: ;_api/control.py
	128
	str sleep
	tuple 1
	import.nm time
	import.from sleep
	st.name sleep
	pop
	128
	str ticks_ms
	str ticks_diff
	tuple 2
	import.nm utime
	import.from ticks_ms
	st.name ticks_ms
	import.from ticks_diff
	st.name ticks_diff
	pop
	129
	str equal_to
	tuple 1
	import.nm operator
	import.from equal_to
	st.name equal_to
	pop
	mkfun 0
	st.name wait_for_seconds
	loadname equal_to
	true
	tuple 2
	null
	mkfun.defargs 1
	st.name wait_until
	buildclass
	mkfun 2
	str Timer
	call 2
	st.name Timer
	none
	ret
	