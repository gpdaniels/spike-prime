align_to_model: ;util/motion.py
	glbl hub
	attr motion
	method align_to_model
	ldloc.0
	ldloc.1
	call.meth 2
	pop
	glbl sleep_ms
	int 143, 80
	call 1
	pop
	none
	ret
	
<module>: ;util/motion.py
	128
	none
	import.nm hub
	st.name hub
	128
	str sleep_ms
	tuple 1
	import.nm utime
	import.from sleep_ms
	st.name sleep_ms
	pop
	mkfun 0
	st.name align_to_model
	none
	ret
	