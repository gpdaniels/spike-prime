__init__: ;protocol/rpc_protocol.py
	list 0
	ldloc.0
	st.attr messages
	glbl JSONRPC
	ldloc.1
	call 1
	ldloc.0
	st.attr json_rpc
	none
	ret
	
stream: ;protocol/rpc_protocol.py
	ldloc.0
	attr json_rpc
	attr stream
	ret
	
stream: ;protocol/rpc_protocol.py
	ldloc.1
	ldloc.0
	attr json_rpc
	st.attr stream
	none
	ret
	
register_method_handlers: ;protocol/rpc_protocol.py
	ldloc.1
	ld.iterstack
	for.iter 12, 0
	stloc.2
	ldloc.0
	method _register_method_handler
	ldloc.2
	call.meth 1
	pop
	jmp -15
	none
	ret
	
_register_method_handler: ;protocol/rpc_protocol.py
	ldloc.1
	method get_methods
	call.meth 0
	stloc.2
	ldloc.2
	ld.iterstack
	for.iter 18, 0
	stloc.3
	ldloc.0
	attr json_rpc
	method add_method
	ldloc.3
	ldloc.2
	ldloc.3
	MP_BC_LOAD_SUBSCR
	call.meth 2
	pop
	jmp -21
	none
	ret
	
looper: ;protocol/rpc_protocol.py
	glbl bytearray
	int 136, 0
	call 1
	stloc.1
	glbl memoryview
	ldloc.1
	call 1
	stloc.2
	glbl get_event_loop
	call 0
	stloc.3
	128
	stloc.4
	ldloc.0
	attr json_rpc
	method resume_suspended_msg
	call.meth 0
	pop
	ldloc.0
	attr stream
	method any
	call.meth 0
	bfalse 27
	ldloc.0
	attr stream
	method readinto
	ldloc.1
	call.meth 1
	stloc.5
	ldloc.0
	attr json_rpc
	method parse_chunk
	ldloc.2
	none
	ldloc.5
	slice 2
	MP_BC_LOAD_SUBSCR
	call.meth 1
	pop
	ldloc.4
	131
	mod
	128
	eq
	bfalse 16
	glbl update_sensor_data
	call 0
	pop
	glbl notify_sensor_data
	ldloc.0
	attr json_rpc
	call 1
	pop
	ldloc.4
	int 60
	mod
	128
	eq
	bfalse 16
	glbl update_battery_status
	call 0
	pop
	glbl notify_battery_status
	ldloc.0
	attr json_rpc
	call 1
	pop
	ldloc.4
	129
	add.in
	stloc.4
	none
	yield
	pop
	jmp -98
	none
	ret
	
RPCProtocol: ;protocol/rpc_protocol.py
	loadname __name__
	st.name __module__
	str RPCProtocol
	st.name __qualname__
	mkfun 0
	st.name __init__
	loadname property
	mkfun 1
	call 1
	st.name stream
	loadname stream
	attr setter
	mkfun 2
	call 1
	st.name stream
	mkfun 3
	st.name register_method_handlers
	mkfun 4
	st.name _register_method_handler
	mkfun 5
	st.name looper
	none
	ret
	
<module>: ;protocol/rpc_protocol.py
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	str get_event_loop
	tuple 1
	import.nm event_loop
	import.from get_event_loop
	st.name get_event_loop
	pop
	128
	str update_sensor_data
	str update_battery_status
	tuple 2
	import.nm util.sensors
	import.from update_sensor_data
	st.name update_sensor_data
	import.from update_battery_status
	st.name update_battery_status
	pop
	129
	str JSONRPC
	tuple 1
	import.nm ujsonrpc
	import.from JSONRPC
	st.name JSONRPC
	pop
	129
	str notify_battery_status
	str notify_sensor_data
	str notify_debug_event
	tuple 3
	import.nm notifications
	import.from notify_battery_status
	st.name notify_battery_status
	import.from notify_sensor_data
	st.name notify_sensor_data
	import.from notify_debug_event
	st.name notify_debug_event
	pop
	buildclass
	mkfun 0
	str RPCProtocol
	call 2
	st.name RPCProtocol
	none
	ret
	