__init__: ;commands/wait_methods.py
	ldloc.3
	ldloc.1
	st.attr _callbacks
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
<lambda>: ;commands/wait_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	str done
	call.meth 2
	ret
	
handle_when_sensor_changed: ;commands/wait_methods.py
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	method upper
	call.meth 0
	stloc.3
	deref 0
	attr _callbacks
	attr custom_sensor_callbacks
	method wait_until_changed
	ldloc.3
	ldloc.1
	str mode
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str default
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str types
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str delta
	MP_BC_LOAD_SUBSCR
	ldloc.0
	ldloc.2
	mkclosure 3, 2
	call.meth 6
	pop
	none
	ret
	
<lambda>: ;commands/wait_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	str done
	call.meth 2
	ret
	
handle_when_sensor_force_released: ;commands/wait_methods.py
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	method upper
	call.meth 0
	stloc.3
	deref 0
	attr _callbacks
	attr custom_sensor_callbacks
	method wait_until_less_than
	ldloc.3
	128
	129
	ldloc.0
	ldloc.2
	mkclosure 3, 2
	call.meth 4
	pop
	none
	ret
	
<lambda>: ;commands/wait_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	str done
	call.meth 2
	ret
	
handle_when_sensor_force_bumped: ;commands/wait_methods.py
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	method upper
	call.meth 0
	stloc.3
	deref 0
	attr _callbacks
	attr custom_sensor_callbacks
	method wait_until_force_bumped
	ldloc.3
	ldloc.0
	ldloc.2
	mkclosure 3, 2
	call.meth 2
	pop
	none
	ret
	
callback: ;commands/wait_methods.py
	ldloc.4
	deref 1
	str gesture
	MP_BC_LOAD_SUBSCR
	eq
	bfalse 19
	deref 0
	attr _rpc
	method reply
	deref 2
	str done
	call.meth 2
	pop
	jmp 16
	deref 0
	attr _callbacks
	attr gesture_callback
	method register_single
	deref 3
	call.meth 1
	pop
	none
	ret
	
handle_wait_gesture: ;commands/wait_methods.py
	ldloc.0
	ldloc.1
	ldloc.2
	ldloc.3
	mkclosure 3, 4
	st.deref 3
	deref 0
	attr _callbacks
	attr gesture_callback
	method register_single
	deref 3
	call.meth 1
	pop
	none
	ret
	
get_methods: ;commands/wait_methods.py
	map 4
	ldloc.0
	attr handle_when_sensor_changed
	constobj 1
	st.map
	ldloc.0
	attr handle_when_sensor_force_released
	constobj 2
	st.map
	ldloc.0
	attr handle_when_sensor_force_bumped
	constobj 3
	st.map
	ldloc.0
	attr handle_wait_gesture
	constobj 4
	st.map
	ret
	
WaitMethods: ;commands/wait_methods.py
	loadname __name__
	st.name __module__
	str WaitMethods
	st.name __qualname__
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	mkfun 1
	st.name handle_when_sensor_changed
	mkfun 2
	st.name handle_when_sensor_force_released
	mkfun 3
	st.name handle_when_sensor_force_bumped
	mkfun 4
	st.name handle_wait_gesture
	mkfun 5
	st.name get_methods
	ldloc.0
	ret
	
<module>: ;commands/wait_methods.py
	129
	str AbstractHandler
	tuple 1
	import.nm abstract_handler
	import.from AbstractHandler
	st.name AbstractHandler
	pop
	buildclass
	mkfun 0
	str WaitMethods
	loadname AbstractHandler
	call 3
	st.name WaitMethods
	none
	ret
	