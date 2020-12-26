on_port: ;system/motors.py
	ldloc.0
	attr wrappers
	method get
	ldloc.1
	glbl MotorWrapper
	none
	call 1
	call.meth 2
	ret
	
is_motor: ;system/motors.py
	ldloc.1
	ldloc.0
	attr wrappers
	in
	ret
	
handler: ;system/motors.py
	ldloc.2
	glbl hub
	attr port
	attr ATTACHED
	is
	bfalse 37
	glbl PORTS
	deref 1
	MP_BC_LOAD_SUBSCR
	attr motor
	bfalse 22
	glbl MotorWrapper
	glbl PORTS
	deref 1
	MP_BC_LOAD_SUBSCR
	attr motor
	call 1
	deref 0
	attr wrappers
	deref 1
	MP_BC_STORE_SUBSCR
	jmp 41
	deref 1
	deref 0
	attr wrappers
	in
	bfalse 30
	deref 0
	attr wrappers
	deref 1
	MP_BC_LOAD_SUBSCR
	method cancel
	call.meth 0
	pop
	deref 0
	attr wrappers
	method pop
	deref 1
	call.meth 1
	pop
	jmp 0
	none
	ret
	
_update: ;system/motors.py
	ldloc.0
	ldloc.1
	mkclosure 2, 2
	stloc.2
	ldloc.2
	ret
	
register_port_callback_handlers: ;system/motors.py
	glbl len
	glbl PORTS
	call 1
	128
	jmp 24
	dup
	stloc.2
	ldloc.1
	ldloc.2
	MP_BC_LOAD_SUBSCR
	method register_persistent
	ldloc.0
	method _update
	glbl _PORT_TO_IDX
	ldloc.2
	MP_BC_LOAD_SUBSCR
	call.meth 1
	call.meth 1
	pop
	129
	add.in
	dup2
	rot
	lt
	btrue -30
	pop
	pop
	none
	ret
	
Motors: ;system/motors.py
	loadname __name__
	st.name __module__
	str Motors
	st.name __qualname__
	map 0
	st.name wrappers
	mkfun 0
	st.name on_port
	mkfun 1
	st.name is_motor
	mkfun 2
	st.name _update
	mkfun 3
	st.name register_port_callback_handlers
	none
	ret
	
<module>: ;system/motors.py
	128
	none
	import.nm hub
	st.name hub
	128
	str PORTS
	tuple 1
	import.nm util.constants
	import.from PORTS
	st.name PORTS
	pop
	128
	str MotorWrapper
	tuple 1
	import.nm system.motorwrapper
	import.from MotorWrapper
	st.name MotorWrapper
	pop
	str A
	str B
	str C
	str D
	str E
	str F
	list 6
	st.name _PORT_TO_IDX
	buildclass
	mkfun 0
	str Motors
	call 2
	st.name Motors
	none
	ret
	