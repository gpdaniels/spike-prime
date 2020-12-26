start: ;projects/standalone.py
	ldloc.0
	attr system
	glbl standalone
	st.attr system
	glbl VirtualMachine
	method start
	ldloc.0
	ldloc.1
	ldloc.2
	call.kvmeth 1
	pop
	none
	ret
	
shutdown: ;projects/standalone.py
	glbl standalone
	method on_exit
	call.meth 0
	pop
	none
	glbl standalone
	st.attr system
	glbl VirtualMachine
	method shutdown
	ldloc.0
	ldloc.1
	ldloc.2
	call.kvmeth 1
	pop
	except.setup 12, 0
	glbl gc
	method collect
	call.meth 0
	pop
	except.jump 5, 0
	pop
	except.jump 1, 0
	finally.end
	none
	ret
	
StandaloneVirtualMachine: ;projects/standalone.py
	loadname __name__
	st.name __module__
	str StandaloneVirtualMachine
	st.name __qualname__
	mkfun 0
	st.name start
	mkfun 1
	st.name shutdown
	none
	ret
	
standalone_stack: ;projects/standalone.py
	glbl standalone
	method on_enter
	call.meth 0
	pop
	none
	ret
	
on_left_button_down: ;projects/standalone.py
	glbl standalone
	method on_left_button_down
	call.meth 0
	pop
	none
	ret
	
on_left_button_up: ;projects/standalone.py
	glbl standalone
	method on_left_button_up
	str time
	128
	call.meth 130, 0
	pop
	none
	ret
	
on_right_button_down: ;projects/standalone.py
	glbl standalone
	method on_right_button_down
	call.meth 0
	pop
	none
	ret
	
on_right_button_up: ;projects/standalone.py
	glbl standalone
	method on_right_button_up
	str time
	128
	call.meth 130, 0
	pop
	none
	ret
	
on_port_callback: ;projects/standalone.py
	ldloc.1
	128
	eq
	bfalse 13
	glbl standalone
	method on_device_disconnected
	ldloc.0
	call.meth 1
	pop
	jmp 19
	ldloc.1
	129
	eq
	bfalse 13
	glbl standalone
	method on_device_connected
	ldloc.0
	call.meth 1
	pop
	jmp 0
	none
	ret
	
<lambda>: ;projects/standalone.py
	glbl on_port_callback
	glbl ALL_PORTS
	128
	MP_BC_LOAD_SUBSCR
	ldloc.0
	ldloc.1
	call.kw 1
	ret
	
<lambda>: ;projects/standalone.py
	glbl on_port_callback
	glbl ALL_PORTS
	129
	MP_BC_LOAD_SUBSCR
	ldloc.0
	ldloc.1
	call.kw 1
	ret
	
<lambda>: ;projects/standalone.py
	glbl on_port_callback
	glbl ALL_PORTS
	130
	MP_BC_LOAD_SUBSCR
	ldloc.0
	ldloc.1
	call.kw 1
	ret
	
<lambda>: ;projects/standalone.py
	glbl on_port_callback
	glbl ALL_PORTS
	131
	MP_BC_LOAD_SUBSCR
	ldloc.0
	ldloc.1
	call.kw 1
	ret
	
<lambda>: ;projects/standalone.py
	glbl on_port_callback
	glbl ALL_PORTS
	132
	MP_BC_LOAD_SUBSCR
	ldloc.0
	ldloc.1
	call.kw 1
	ret
	
<lambda>: ;projects/standalone.py
	glbl on_port_callback
	glbl ALL_PORTS
	133
	MP_BC_LOAD_SUBSCR
	ldloc.0
	ldloc.1
	call.kw 1
	ret
	
setup: ;projects/standalone.py
	glbl StandaloneVirtualMachine
	ldloc.0
	ldloc.1
	ldloc.2
	str standalone
	call 4
	stloc.3
	ldloc.3
	method register_on_start
	str standalone_
	glbl standalone_stack
	call.meth 2
	pop
	ldloc.3
	method register_on_button
	constobj 3
	glbl on_left_button_down
	str left
	str pressed
	call.meth 4
	pop
	ldloc.3
	method register_on_button
	constobj 4
	glbl on_left_button_up
	str left
	str released
	call.meth 4
	pop
	ldloc.3
	method register_on_button
	constobj 5
	glbl on_right_button_down
	str right
	str pressed
	call.meth 4
	pop
	ldloc.3
	method register_on_button
	constobj 6
	glbl on_right_button_up
	str right
	str released
	call.meth 4
	pop
	ldloc.1
	attr callbacks
	attr port_callbacks
	128
	MP_BC_LOAD_SUBSCR
	method register
	mkfun 7
	call.meth 1
	pop
	ldloc.1
	attr callbacks
	attr port_callbacks
	129
	MP_BC_LOAD_SUBSCR
	method register
	mkfun 8
	call.meth 1
	pop
	ldloc.1
	attr callbacks
	attr port_callbacks
	130
	MP_BC_LOAD_SUBSCR
	method register
	mkfun 9
	call.meth 1
	pop
	ldloc.1
	attr callbacks
	attr port_callbacks
	131
	MP_BC_LOAD_SUBSCR
	method register
	mkfun 10
	call.meth 1
	pop
	ldloc.1
	attr callbacks
	attr port_callbacks
	132
	MP_BC_LOAD_SUBSCR
	method register
	mkfun 11
	call.meth 1
	pop
	ldloc.1
	attr callbacks
	attr port_callbacks
	133
	MP_BC_LOAD_SUBSCR
	method register
	mkfun 12
	call.meth 1
	pop
	ldloc.3
	ret
	
<module>: ;projects/standalone.py
	128
	none
	import.nm gc
	st.name gc
	128
	str VirtualMachine
	tuple 1
	import.nm runtime
	import.from VirtualMachine
	st.name VirtualMachine
	pop
	128
	str Standalone
	str ALL_PORTS
	tuple 2
	import.nm projects.standalone_.program
	import.from Standalone
	st.name Standalone
	import.from ALL_PORTS
	st.name ALL_PORTS
	pop
	loadname Standalone
	call 0
	st.name standalone
	buildclass
	mkfun 0
	str StandaloneVirtualMachine
	loadname VirtualMachine
	call 3
	st.name StandaloneVirtualMachine
	mkfun 1
	st.name standalone_stack
	mkfun 2
	st.name on_left_button_down
	mkfun 3
	st.name on_left_button_up
	mkfun 4
	st.name on_right_button_down
	mkfun 5
	st.name on_right_button_up
	mkfun 6
	st.name on_port_callback
	mkfun 7
	st.name setup
	none
	ret
	