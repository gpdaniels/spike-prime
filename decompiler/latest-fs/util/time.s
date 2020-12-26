reset_time: ;util/time.py
	glbl ticks_ms
	call 0
	st.glbl _STARTED_AT
	true
	st.glbl _RUNNING
	none
	ret
	
get_time: ;util/time.py
	glbl _RUNNING
	bfalse 14
	glbl ticks_diff
	glbl ticks_ms
	call 0
	glbl _STARTED_AT
	call 2
	ret
	glbl _STOPPED_AT
	ret
	
start_time: ;util/time.py
	glbl _STOPPED_AT
	128
	qt
	bfalse 16
	glbl ticks_diff
	glbl ticks_ms
	call 0
	glbl _STOPPED_AT
	call 2
	st.glbl _STARTED_AT
	true
	st.glbl _RUNNING
	none
	ret
	
stop_time: ;util/time.py
	glbl _RUNNING
	bfalse 20
	glbl ticks_diff
	glbl ticks_ms
	call 0
	glbl _STARTED_AT
	call 2
	st.glbl _STOPPED_AT
	false
	st.glbl _RUNNING
	none
	ret
	
<module>: ;util/time.py
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
	loadname ticks_ms
	call 0
	st.glbl _STARTED_AT
	false
	st.glbl _RUNNING
	128
	st.glbl _STOPPED_AT
	mkfun 0
	st.name reset_time
	mkfun 1
	st.name get_time
	mkfun 2
	st.name start_time
	mkfun 3
	st.name stop_time
	none
	ret
	