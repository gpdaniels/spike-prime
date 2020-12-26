cancel: ;projects/standalone_/util.py
	glbl get_event_loop
	call 0
	method cancel
	ldloc.0
	call.meth 1
	pop
	none
	ret
	
__getattr__: ;projects/standalone_/util.py
	ldloc.1
	ldloc.0
	in
	bfalse 2
	ldloc.1
	ret
	glbl AttributeError
	raiseobj
	none
	ret
	
Enum: ;projects/standalone_/util.py
	loadname __name__
	st.name __module__
	str Enum
	st.name __qualname__
	mkfun 0
	st.name __getattr__
	none
	ret
	
<module>: ;projects/standalone_/util.py
	128
	str get_event_loop
	tuple 1
	import.nm event_loop
	import.from get_event_loop
	st.name get_event_loop
	pop
	mkfun 0
	st.name cancel
	buildclass
	mkfun 1
	str Enum
	loadname set
	call 3
	st.name Enum
	loadname Enum
	str NA
	str DSTAR
	str ASTAR
	str RSTAR
	str D
	str A
	str R
	list 7
	call 1
	st.name Type
	loadname Enum
	str LEFT
	str RIGHT
	list 2
	call 1
	st.name HubSide
	loadname Enum
	str NA
	str MODE
	str PWM
	str MOTOR
	list 4
	call 1
	st.name Interface
	none
	ret
	