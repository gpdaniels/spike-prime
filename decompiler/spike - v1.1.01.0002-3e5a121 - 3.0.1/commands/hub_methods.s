__init__: ;commands/hub_methods.py
	ldloc.3
	ldloc.1
	st.attr _program_runner
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_trigger_current_state: ;commands/hub_methods.py
	glbl notifications
	method notify_battery_status
	ldloc.0
	attr _rpc
	call.meth 1
	pop
	glbl notifications
	method notify_sensor_data
	ldloc.0
	attr _rpc
	call.meth 1
	pop
	glbl notifications
	method notify_storage_status
	ldloc.0
	attr _rpc
	call.meth 1
	pop
	glbl notifications
	method notify_orientation_status
	ldloc.0
	attr _rpc
	call.meth 1
	pop
	glbl notifications
	method notify_info_status
	ldloc.0
	attr _rpc
	call.meth 1
	pop
	glbl notifications
	method notify_program_running
	ldloc.0
	attr _rpc
	ldloc.0
	attr _program_runner
	method is_running
	call.meth 0
	ldloc.0
	attr _program_runner
	attr project_id
	call.meth 3
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_set_hub_name: ;commands/hub_methods.py
	glbl a2b_base64
	ldloc.1
	str name
	MP_BC_LOAD_SUBSCR
	call 1
	method decode
	str utf-8
	call.meth 1
	stloc.3
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl write_local_name
	ldloc.3
	call 1
	call.meth 2
	pop
	none
	ret
	
handle_reset_yaw: ;commands/hub_methods.py
	glbl hub
	attr motion
	method yaw_pitch_roll
	128
	call.meth 1
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_set_orientation: ;commands/hub_methods.py
	ldloc.1
	str up
	MP_BC_LOAD_SUBSCR
	stloc.3
	ldloc.1
	str front
	MP_BC_LOAD_SUBSCR
	stloc.4
	glbl align_to_model
	ldloc.3
	ldloc.4
	call 2
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_set_port_mode: ;commands/hub_methods.py
	glbl getattr
	glbl hub
	attr port
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	call 2
	stloc.3
	ldloc.3
	bfalse 7
	ldloc.3
	attr device
	jmp 1
	none
	stloc.4
	ldloc.4
	bfalse 12
	ldloc.4
	method mode
	ldloc.1
	str mode
	MP_BC_LOAD_SUBSCR
	call.meth 1
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
<listcomp>: ;commands/hub_methods.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 12, 0
	stloc.1
	glbl int
	ldloc.1
	call 1
	MP_BC_STORE_COMP 20
	jmp -15
	ret
	
<genexpr>: ;commands/hub_methods.py
	null
	ldloc.0
	null
	null
	for.iter 15, 0
	stloc.1
	ldloc.1
	method split
	str .
	call.meth 1
	yield
	pop
	jmp -18
	none
	ret
	
<listcomp>: ;commands/hub_methods.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 21, 0
	stloc.1
	ldloc.1
	method isdigit
	call.meth 0
	bfalse -13
	glbl int
	ldloc.1
	call 1
	MP_BC_STORE_COMP 20
	jmp -24
	ret
	
handle_get_hub_info: ;commands/hub_methods.py
	map 0
	stloc.3
	glbl hub
	attr __version__
	method split
	str -
	call.meth 1
	stloc.4
	glbl len
	ldloc.4
	call 1
	130
	qe
	bfalse 61
	mkfun 6
	ldloc.4
	128
	MP_BC_LOAD_SUBSCR
	129
	none
	slice 2
	MP_BC_LOAD_SUBSCR
	method split
	str .
	call.meth 1
	call 1
	stloc.5
	map 2
	ldloc.5
	str version
	st.map
	ldloc.4
	129
	MP_BC_LOAD_SUBSCR
	str checksum
	st.map
	ldloc.3
	str firmware
	MP_BC_STORE_SUBSCR
	glbl str
	glbl hub
	method info
	call.meth 0
	constobj 3
	MP_BC_LOAD_SUBSCR
	call 1
	ldloc.3
	str variant
	MP_BC_STORE_SUBSCR
	mkfun 7
	glbl version
	attr __version__
	method split
	str -
	call.meth 1
	130
	str 
	list 1
	mul
	add
	none
	130
	slice 2
	MP_BC_LOAD_SUBSCR
	ld.iter
	call 1
	MP_BC_UNPACK_SEQUENCE 2
	stloc.6
	stloc.7
	mkfun 8
	ldloc.6
	ldloc.7
	add
	call 1
	stloc.8
	ldloc.8
	bfalse 12
	map 1
	ldloc.8
	str version
	st.map
	ldloc.3
	str runtime
	MP_BC_STORE_SUBSCR
	except.setup 30, 0
	glbl open
	constobj 4
	str r
	call 2
	with.setup 12, 0
	stloc.9
	ldloc.9
	method read
	call.meth 0
	ldloc.3
	constobj 5
	MP_BC_STORE_SUBSCR
	none
	with.chleanup
	finally.end
	except.jump 37, 0
	dup
	glbl OSError
	ematch
	bfalse 28
	stloc.10
	finally.setup 16, 0
	ldloc.10
	attr args
	128
	MP_BC_LOAD_SUBSCR
	glbl ENOENT
	is
	not
	bfalse 1
	rethrow
	none
	none
	stloc.10
	del.fast 10
	finally.end
	except.jump 1, 0
	finally.end
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	ldloc.3
	call.meth 2
	pop
	none
	ret
	
get_methods: ;commands/hub_methods.py
	map 6
	ldloc.0
	attr handle_trigger_current_state
	constobj 1
	st.map
	ldloc.0
	attr handle_set_hub_name
	constobj 2
	st.map
	ldloc.0
	attr handle_reset_yaw
	constobj 3
	st.map
	ldloc.0
	attr handle_set_orientation
	constobj 4
	st.map
	ldloc.0
	attr handle_set_port_mode
	constobj 5
	st.map
	ldloc.0
	attr handle_get_hub_info
	constobj 6
	st.map
	ret
	
HubMethods: ;commands/hub_methods.py
	loadname __name__
	st.name __module__
	str HubMethods
	st.name __qualname__
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	mkfun 1
	st.name handle_trigger_current_state
	mkfun 2
	st.name handle_set_hub_name
	mkfun 3
	st.name handle_reset_yaw
	mkfun 4
	st.name handle_set_orientation
	mkfun 5
	st.name handle_set_port_mode
	mkfun 6
	st.name handle_get_hub_info
	mkfun 7
	st.name get_methods
	ldloc.0
	ret
	
<module>: ;commands/hub_methods.py
	128
	none
	import.nm hub
	st.name hub
	128
	str ENOENT
	tuple 1
	import.nm uerrno
	import.from ENOENT
	st.name ENOENT
	pop
	128
	none
	import.nm version
	st.name version
	128
	str notifications
	tuple 1
	import.nm protocol
	import.from notifications
	st.name notifications
	pop
	128
	str write_local_name
	tuple 1
	import.nm util.storage
	import.from write_local_name
	st.name write_local_name
	pop
	128
	str align_to_model
	tuple 1
	import.nm util.motion
	import.from align_to_model
	st.name align_to_model
	pop
	128
	str a2b_base64
	tuple 1
	import.nm ubinascii
	import.from a2b_base64
	st.name a2b_base64
	pop
	129
	str AbstractHandler
	tuple 1
	import.nm abstract_handler
	import.from AbstractHandler
	st.name AbstractHandler
	pop
	buildclass
	mkfun 0
	str HubMethods
	loadname AbstractHandler
	call 3
	st.name HubMethods
	none
	ret
	