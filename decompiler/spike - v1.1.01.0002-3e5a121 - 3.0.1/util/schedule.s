mp_schedule: ;util/schedule.py
	ldloc.0
	ldloc.1
	call 1
	pop
	none
	ret
	
<module>: ;util/schedule.py
	128
	none
	import.nm micropython
	st.name micropython
	loadname hasattr
	loadname micropython
	str schedule
	call 2
	bfalse 12
	loadname micropython
	attr schedule
	st.name mp_schedule
	jmp 5
	mkfun 0
	st.name mp_schedule
	none
	ret
	