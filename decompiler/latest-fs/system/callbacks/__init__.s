<lambda>: ;system/callbacks/__init__.py
	glbl hub
	attr motion
	method gesture
	str callback
	ldloc.0
	call.meth 130, 0
	ret
	
<lambda>: ;system/callbacks/__init__.py
	glbl hub
	attr motion
	method orientation
	str callback
	ldloc.0
	call.meth 130, 0
	ret
	
__init__: ;system/callbacks/__init__.py
	glbl CustomSensorCallbackManager
	call 0
	ldloc.0
	st.attr custom_sensor_callbacks
	glbl ConnectionCallbacks
	call 0
	ldloc.0
	st.attr connection
	glbl PortCallbacks
	call 0
	ldloc.0
	st.attr port_callbacks
	glbl ButtonCallbacks
	call 0
	ldloc.0
	st.attr button_callbacks
	glbl CallbackHandler
	mkfun 1
	call 1
	ldloc.0
	st.attr gesture_callback
	glbl CallbackHandler
	mkfun 2
	call 1
	ldloc.0
	st.attr orientation_callback
	none
	ret
	
hard_reset: ;system/callbacks/__init__.py
	ldloc.0
	attr custom_sensor_callbacks
	method clear_tasks
	call.meth 0
	pop
	ldloc.0
	attr port_callbacks
	method hard_reset
	call.meth 0
	pop
	ldloc.0
	attr button_callbacks
	method hard_reset
	call.meth 0
	pop
	ldloc.0
	attr gesture_callback
	method hard_reset
	call.meth 0
	pop
	ldloc.0
	attr orientation_callback
	method hard_reset
	call.meth 0
	pop
	none
	ret
	
reset: ;system/callbacks/__init__.py
	ldloc.0
	attr custom_sensor_callbacks
	method clear_tasks
	call.meth 0
	pop
	ldloc.0
	attr port_callbacks
	method reset
	call.meth 0
	pop
	ldloc.0
	attr button_callbacks
	method reset
	call.meth 0
	pop
	ldloc.0
	attr gesture_callback
	method reset
	call.meth 0
	pop
	ldloc.0
	attr orientation_callback
	method reset
	call.meth 0
	pop
	none
	ret
	
Callbacks: ;system/callbacks/__init__.py
	loadname __name__
	st.name __module__
	str Callbacks
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name hard_reset
	mkfun 2
	st.name reset
	none
	ret
	
__init__: ;system/callbacks/__init__.py
	glbl CallbackHandler
	glbl USB_VCP
	attr callback
	call 1
	ldloc.0
	st.attr usb
	glbl CallbackHandler
	glbl BT_VCP
	attr callback
	call 1
	ldloc.0
	st.attr bluetooth
	glbl CallbackHandler
	ldloc.0
	attr __unified_connection_handler
	call 1
	ldloc.0
	st.attr state
	none
	ret
	
on_change: ;system/callbacks/__init__.py
	ldloc.3
	bfalse 13
	glbl USB_VCP
	method isconnected
	call.meth 0
	st.deref 1
	jmp 10
	glbl BT_VCP
	method isconnected
	call.meth 0
	st.deref 2
	deref 0
	deref 1
	deref 2
	tuple 2
	call 1
	pop
	none
	ret
	
<lambda>: ;system/callbacks/__init__.py
	deref 0
	true
	call 1
	ret
	
<lambda>: ;system/callbacks/__init__.py
	deref 0
	false
	call 1
	ret
	
__unified_connection_handler: ;system/callbacks/__init__.py
	glbl USB_VCP
	method isconnected
	call.meth 0
	st.deref 2
	glbl BT_VCP
	method isconnected
	call.meth 0
	st.deref 3
	ldloc.1
	ldloc.2
	ldloc.3
	mkclosure 2, 3
	st.deref 4
	ldloc.0
	attr usb
	method register_persistent
	ldloc.4
	mkclosure 3, 1
	call.meth 1
	pop
	ldloc.0
	attr bluetooth
	method register_persistent
	ldloc.4
	mkclosure 4, 1
	call.meth 1
	pop
	none
	ret
	
ConnectionCallbacks: ;system/callbacks/__init__.py
	loadname __name__
	st.name __module__
	str ConnectionCallbacks
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name __unified_connection_handler
	none
	ret
	
__init__: ;system/callbacks/__init__.py
	glbl CallbackHandler
	glbl hub
	attr button
	attr center
	attr callback
	call 1
	ldloc.0
	st.attr center
	glbl CallbackHandler
	glbl hub
	attr button
	attr connect
	attr callback
	call 1
	ldloc.0
	st.attr connect
	glbl CallbackHandler
	glbl hub
	attr button
	attr right
	attr callback
	call 1
	ldloc.0
	st.attr right
	glbl CallbackHandler
	glbl hub
	attr button
	attr left
	attr callback
	call 1
	ldloc.0
	st.attr left
	none
	ret
	
callback: ;system/callbacks/__init__.py
	glbl notify_button_event
	deref 1
	deref 0
	ldloc.2
	call 3
	pop
	none
	ret
	
emitter: ;system/callbacks/__init__.py
	ldloc.1
	ldloc.0
	mkclosure 2, 2
	stloc.2
	ldloc.2
	ret
	
register_rpc_handlers: ;system/callbacks/__init__.py
	ldloc.1
	mkclosure 2, 1
	stloc.2
	ldloc.0
	attr center
	method register_persistent
	ldloc.2
	str center
	call 1
	call.meth 1
	pop
	ldloc.0
	attr connect
	method register_persistent
	ldloc.2
	str connect
	call 1
	call.meth 1
	pop
	ldloc.0
	attr right
	method register_persistent
	ldloc.2
	str right
	call 1
	call.meth 1
	pop
	ldloc.0
	attr left
	method register_persistent
	ldloc.2
	str left
	call 1
	call.meth 1
	pop
	ldloc.0
	attr center
	method callback
	128
	call.meth 1
	pop
	ldloc.0
	attr connect
	method callback
	128
	call.meth 1
	pop
	ldloc.0
	attr left
	method callback
	128
	call.meth 1
	pop
	ldloc.0
	attr right
	method callback
	128
	call.meth 1
	pop
	none
	ret
	
reset: ;system/callbacks/__init__.py
	ldloc.0
	attr center
	method reset
	call.meth 0
	pop
	ldloc.0
	attr connect
	method reset
	call.meth 0
	pop
	ldloc.0
	attr left
	method reset
	call.meth 0
	pop
	ldloc.0
	attr right
	method reset
	call.meth 0
	pop
	none
	ret
	
hard_reset: ;system/callbacks/__init__.py
	ldloc.0
	attr center
	method hard_reset
	call.meth 0
	pop
	ldloc.0
	attr connect
	method hard_reset
	call.meth 0
	pop
	ldloc.0
	attr left
	method hard_reset
	call.meth 0
	pop
	ldloc.0
	attr right
	method hard_reset
	call.meth 0
	pop
	none
	ret
	
__getitem__: ;system/callbacks/__init__.py
	glbl getattr
	ldloc.0
	ldloc.1
	none
	call 3
	ret
	
ButtonCallbacks: ;system/callbacks/__init__.py
	loadname __name__
	st.name __module__
	str ButtonCallbacks
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name register_rpc_handlers
	mkfun 2
	st.name reset
	mkfun 3
	st.name hard_reset
	mkfun 4
	st.name __getitem__
	none
	ret
	
__init__: ;system/callbacks/__init__.py
	glbl CallbackHandler
	glbl hub
	attr port
	attr A
	attr callback
	call 1
	glbl CallbackHandler
	glbl hub
	attr port
	attr B
	attr callback
	call 1
	glbl CallbackHandler
	glbl hub
	attr port
	attr C
	attr callback
	call 1
	glbl CallbackHandler
	glbl hub
	attr port
	attr D
	attr callback
	call 1
	glbl CallbackHandler
	glbl hub
	attr port
	attr E
	attr callback
	call 1
	glbl CallbackHandler
	glbl hub
	attr port
	attr F
	attr callback
	call 1
	tuple 6
	ldloc.0
	st.attr handlers
	none
	ret
	
<listcomp>: ;system/callbacks/__init__.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 12, 0
	stloc.1
	ldloc.1
	method reset
	call.meth 0
	MP_BC_STORE_COMP 20
	jmp -15
	ret
	
reset: ;system/callbacks/__init__.py
	mkfun 1
	ldloc.0
	attr handlers
	call 1
	ret
	
<listcomp>: ;system/callbacks/__init__.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 12, 0
	stloc.1
	ldloc.1
	method hard_reset
	call.meth 0
	MP_BC_STORE_COMP 20
	jmp -15
	ret
	
hard_reset: ;system/callbacks/__init__.py
	mkfun 1
	ldloc.0
	attr handlers
	call 1
	ret
	
__getitem__: ;system/callbacks/__init__.py
	ldloc.0
	attr handlers
	ldloc.1
	MP_BC_LOAD_SUBSCR
	ret
	
PortCallbacks: ;system/callbacks/__init__.py
	loadname __name__
	st.name __module__
	str PortCallbacks
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name reset
	mkfun 2
	st.name hard_reset
	mkfun 3
	st.name __getitem__
	none
	ret
	
__init__: ;system/callbacks/__init__.py
	ldloc.1
	ldloc.0
	st.attr callback_function
	list 0
	ldloc.0
	st.attr persistent_callbacks
	list 0
	ldloc.0
	st.attr callbacks
	list 0
	ldloc.0
	st.attr single_callbacks
	ldloc.1
	ldloc.0
	attr callback
	call 1
	pop
	none
	ret
	
register_persistent: ;system/callbacks/__init__.py
	ldloc.0
	attr persistent_callbacks
	method append
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
register: ;system/callbacks/__init__.py
	ldloc.0
	attr callbacks
	method append
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
register_single: ;system/callbacks/__init__.py
	ldloc.0
	attr single_callbacks
	method append
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
reset: ;system/callbacks/__init__.py
	list 0
	ldloc.0
	st.attr callbacks
	list 0
	ldloc.0
	st.attr single_callbacks
	none
	ret
	
hard_reset: ;system/callbacks/__init__.py
	list 0
	ldloc.0
	st.attr callbacks
	list 0
	ldloc.0
	st.attr single_callbacks
	list 0
	ldloc.0
	st.attr persistent_callbacks
	ldloc.0
	method callback_function
	none
	call.meth 1
	pop
	none
	ldloc.0
	st.attr callback_function
	none
	ret
	
callback: ;system/callbacks/__init__.py
	except.setup 38, 0
	ldloc.0
	attr persistent_callbacks
	ldloc.0
	attr callbacks
	add
	ldloc.0
	attr single_callbacks
	add
	stloc.2
	list 0
	ldloc.0
	st.attr single_callbacks
	ldloc.2
	ld.iterstack
	for.iter 9, 0
	stloc.3
	ldloc.3
	ldloc.1
	call 1
	pop
	jmp -12
	except.jump 32, 0
	dup
	glbl Exception
	ematch
	bfalse 23
	stloc.4
	finally.setup 11, 0
	glbl error_handler
	method handle_runtime_error
	ldloc.4
	call.meth 1
	pop
	none
	none
	stloc.4
	del.fast 4
	finally.end
	except.jump 1, 0
	finally.end
	none
	ret
	
CallbackHandler: ;system/callbacks/__init__.py
	loadname __name__
	st.name __module__
	str CallbackHandler
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name register_persistent
	mkfun 2
	st.name register
	mkfun 3
	st.name register_single
	mkfun 4
	st.name reset
	mkfun 5
	st.name hard_reset
	mkfun 6
	st.name callback
	none
	ret
	
<module>: ;system/callbacks/__init__.py
	128
	none
	import.nm hub
	st.name hub
	128
	str notify_button_event
	tuple 1
	import.nm protocol.notifications
	import.from notify_button_event
	st.name notify_button_event
	pop
	128
	str USB_VCP
	str BT_VCP
	tuple 2
	import.nm util.constants
	import.from USB_VCP
	st.name USB_VCP
	import.from BT_VCP
	st.name BT_VCP
	pop
	128
	str error_handler
	tuple 1
	import.nm util.error_handler
	import.from error_handler
	st.name error_handler
	pop
	128
	str mp_schedule
	tuple 1
	import.nm util.schedule
	import.from mp_schedule
	st.name mp_schedule
	pop
	129
	str CustomSensorCallbackManager
	tuple 1
	import.nm customcallbacks
	import.from CustomSensorCallbackManager
	st.name CustomSensorCallbackManager
	pop
	buildclass
	mkfun 0
	str Callbacks
	call 2
	st.name Callbacks
	buildclass
	mkfun 1
	str ConnectionCallbacks
	call 2
	st.name ConnectionCallbacks
	buildclass
	mkfun 2
	str ButtonCallbacks
	call 2
	st.name ButtonCallbacks
	buildclass
	mkfun 3
	str PortCallbacks
	call 2
	st.name PortCallbacks
	buildclass
	mkfun 4
	str CallbackHandler
	call 2
	st.name CallbackHandler
	none
	ret
	