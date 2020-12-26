reset: ;runtime/timer.py
	glbl utime
	method ticks_ms
	call.meth 0
	st.glbl START_TIME
	none
	ret
	
get: ;runtime/timer.py
	glbl utime
	method ticks_diff
	glbl utime
	method ticks_ms
	call.meth 0
	glbl START_TIME
	call.meth 2
	constobj 0
	truediv
	ret
	
<module>: ;runtime/timer.py
	128
	none
	import.nm utime
	st.name utime
	128
	st.glbl START_TIME
	mkfun 0
	st.name reset
	mkfun 1
	st.name get
	none
	ret
	