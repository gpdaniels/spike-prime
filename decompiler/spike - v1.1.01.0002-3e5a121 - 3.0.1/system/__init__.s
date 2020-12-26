__init__: ;system/__init__.py
	glbl get_event_loop
	call 0
	ldloc.0
	st.attr loop
	glbl Callbacks
	call 0
	ldloc.0
	st.attr callbacks
	glbl Motors
	call 0
	ldloc.0
	st.attr motors
	ldloc.0
	attr motors
	method register_port_callback_handlers
	ldloc.0
	attr callbacks
	attr port_callbacks
	call.meth 1
	pop
	glbl Movement
	call 0
	ldloc.0
	st.attr move
	glbl SoundWrapper
	call 0
	ldloc.0
	st.attr sound
	glbl DisplayWrapper
	call 0
	ldloc.0
	st.attr display
	none
	ret
	
reset: ;system/__init__.py
	ldloc.0
	attr callbacks
	method hard_reset
	call.meth 0
	pop
	none
	ret
	
System: ;system/__init__.py
	loadname __name__
	st.name __module__
	str System
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name reset
	none
	ret
	
<module>: ;system/__init__.py
	128
	none
	import.nm hub
	st.name hub
	128
	str get_event_loop
	tuple 1
	import.nm event_loop
	import.from get_event_loop
	st.name get_event_loop
	pop
	129
	str Callbacks
	tuple 1
	import.nm callbacks
	import.from Callbacks
	st.name Callbacks
	pop
	129
	str Motors
	tuple 1
	import.nm motors
	import.from Motors
	st.name Motors
	pop
	129
	str Movement
	tuple 1
	import.nm move
	import.from Movement
	st.name Movement
	pop
	129
	str SoundWrapper
	tuple 1
	import.nm sound
	import.from SoundWrapper
	st.name SoundWrapper
	pop
	129
	str DisplayWrapper
	tuple 1
	import.nm display
	import.from DisplayWrapper
	st.name DisplayWrapper
	pop
	buildclass
	mkfun 0
	str System
	call 2
	st.name System
	loadname System
	call 0
	st.name system
	none
	ret
	