__init__: ;projects/standalone_/program.py
	none
	ldloc.0
	st.attr system
	none
	ldloc.0
	st.attr heartbeat
	glbl tuple
	call 0
	ldloc.0
	st.attr rows
	none
	ret
	
get_image: ;projects/standalone_/program.py
	glbl hub
	attr Image
	attr HEART
	ret
	
on_enter: ;projects/standalone_/program.py
	glbl RowController
	128
	ldloc.0
	attr system
	call 2
	glbl RowController
	130
	ldloc.0
	attr system
	call 2
	glbl RowController
	132
	ldloc.0
	attr system
	call 2
	tuple 3
	ldloc.0
	st.attr rows
	glbl hub
	attr display
	method clear
	call.meth 0
	pop
	ldloc.0
	attr rows
	ld.iterstack
	for.iter 11, 0
	stloc.1
	ldloc.1
	method on_enter
	call.meth 0
	pop
	jmp -14
	ldloc.0
	method _any_devices_connected
	call.meth 0
	btrue 14
	ldloc.0
	method _enable_advertise_ports
	call.meth 0
	pop
	ldloc.0
	method _start_heartbeat
	call.meth 0
	pop
	glbl ALL_PORTS
	ld.iterstack
	for.iter 22, 0
	stloc.2
	ldloc.0
	method _has_device_connected
	ldloc.2
	call.meth 1
	bfalse 8
	ldloc.0
	method on_device_connected
	ldloc.2
	call.meth 1
	pop
	jmp -25
	none
	ret
	
on_exit: ;projects/standalone_/program.py
	ldloc.0
	attr heartbeat
	bfalse 7
	ldloc.0
	method _stop_heartbeat
	call.meth 0
	pop
	ldloc.0
	attr rows
	ld.iterstack
	for.iter 11, 0
	stloc.1
	ldloc.1
	method on_exit
	call.meth 0
	pop
	jmp -14
	glbl tuple
	call 0
	ldloc.0
	st.attr rows
	none
	ret
	
_on_connected_async: ;projects/standalone_/program.py
	none
	stloc.2
	glbl utime
	method ticks_ms
	call.meth 0
	stloc.3
	int 151, 56
	stloc.4
	jmp 22
	glbl Device
	method from_port
	deref 1
	call.meth 1
	stloc.2
	ldloc.2
	none
	is
	bfalse 5
	int 128, 100
	yield
	pop
	ldloc.2
	none
	is
	bfalse 22
	glbl utime
	method ticks_diff
	glbl utime
	method ticks_ms
	call.meth 0
	ldloc.3
	call.meth 2
	ldloc.4
	lt
	btrue -50
	ldloc.2
	bfalse 163
	deref 0
	method _disable_advertise_ports
	call.meth 0
	pop
	deref 0
	method _stop_heartbeat
	call.meth 0
	pop
	deref 0
	method _get_row
	deref 1
	call.meth 1
	stloc.5
	deref 0
	method _get_side
	deref 1
	call.meth 1
	stloc.6
	ldloc.2
	method on_connect
	call.meth 0
	pop
	ldloc.5
	method get_opposite_device
	ldloc.6
	call.meth 1
	stloc.7
	ldloc.6
	glbl HubSide
	attr LEFT
	is
	bfalse 45
	glbl DeviceModePriorityMap
	ldloc.2
	ldloc.7
	call 2
	stloc.8
	ldloc.2
	method set_mode
	ldloc.8
	attr left_mode
	call.meth 1
	pop
	ldloc.7
	bfalse 11
	ldloc.7
	method set_mode
	ldloc.8
	attr right_mode
	call.meth 1
	pop
	ldloc.5
	method on_connected_left
	ldloc.2
	call.meth 1
	pop
	jmp 56
	ldloc.6
	glbl HubSide
	attr RIGHT
	is
	bfalse 45
	glbl DeviceModePriorityMap
	ldloc.7
	ldloc.2
	call 2
	stloc.8
	ldloc.2
	method set_mode
	ldloc.8
	attr right_mode
	call.meth 1
	pop
	ldloc.7
	bfalse 11
	ldloc.7
	method set_mode
	ldloc.8
	attr left_mode
	call.meth 1
	pop
	ldloc.5
	method on_connected_right
	ldloc.2
	call.meth 1
	pop
	jmp 0
	none
	ret
	
on_device_connected: ;projects/standalone_/program.py
	ldloc.0
	ldloc.1
	mkclosure 2, 2
	stloc.2
	deref 0
	attr system
	attr loop
	method call_soon
	ldloc.2
	call 0
	call.meth 1
	pop
	none
	ret
	
on_device_disconnected: ;projects/standalone_/program.py
	none
	stloc.2
	ldloc.0
	method _any_devices_connected
	call.meth 0
	btrue 14
	ldloc.0
	method _enable_advertise_ports
	call.meth 0
	pop
	ldloc.0
	method _start_heartbeat
	call.meth 0
	pop
	ldloc.0
	method _get_row
	ldloc.1
	call.meth 1
	stloc.3
	ldloc.0
	method _get_side
	ldloc.1
	call.meth 1
	stloc.4
	ldloc.3
	method get_opposite_device
	ldloc.4
	call.meth 1
	stloc.5
	ldloc.4
	glbl HubSide
	attr LEFT
	is
	bfalse 33
	glbl DeviceModePriorityMap
	ldloc.2
	ldloc.5
	call 2
	stloc.6
	ldloc.5
	bfalse 11
	ldloc.5
	method set_mode
	ldloc.6
	attr right_mode
	call.meth 1
	pop
	ldloc.3
	method on_disconnected_left
	call.meth 0
	pop
	jmp 44
	ldloc.4
	glbl HubSide
	attr RIGHT
	is
	bfalse 33
	glbl DeviceModePriorityMap
	ldloc.5
	ldloc.2
	call 2
	stloc.6
	ldloc.5
	bfalse 11
	ldloc.5
	method set_mode
	ldloc.6
	attr left_mode
	call.meth 1
	pop
	ldloc.3
	method on_disconnected_right
	call.meth 0
	pop
	jmp 0
	none
	ret
	
on_left_button_down: ;projects/standalone_/program.py
	ldloc.0
	attr rows
	ld.iterstack
	for.iter 11, 0
	stloc.1
	ldloc.1
	method on_left_button_down
	call.meth 0
	pop
	jmp -14
	none
	ret
	
on_left_button_up: ;projects/standalone_/program.py
	ldloc.0
	attr rows
	ld.iterstack
	for.iter 11, 0
	stloc.2
	ldloc.2
	method on_left_button_up
	call.meth 0
	pop
	jmp -14
	none
	ret
	
on_right_button_down: ;projects/standalone_/program.py
	ldloc.0
	attr rows
	ld.iterstack
	for.iter 11, 0
	stloc.1
	ldloc.1
	method on_right_button_down
	call.meth 0
	pop
	jmp -14
	none
	ret
	
on_right_button_up: ;projects/standalone_/program.py
	ldloc.0
	attr rows
	ld.iterstack
	for.iter 11, 0
	stloc.2
	ldloc.2
	method on_right_button_up
	call.meth 0
	pop
	jmp -14
	none
	ret
	
_get_row: ;projects/standalone_/program.py
	ldloc.1
	glbl hub
	attr port
	attr A
	glbl hub
	attr port
	attr B
	tuple 2
	in
	bfalse 7
	ldloc.0
	attr rows
	128
	MP_BC_LOAD_SUBSCR
	ret
	ldloc.1
	glbl hub
	attr port
	attr C
	glbl hub
	attr port
	attr D
	tuple 2
	in
	bfalse 7
	ldloc.0
	attr rows
	129
	MP_BC_LOAD_SUBSCR
	ret
	ldloc.1
	glbl hub
	attr port
	attr E
	glbl hub
	attr port
	attr F
	tuple 2
	in
	bfalse 7
	ldloc.0
	attr rows
	130
	MP_BC_LOAD_SUBSCR
	ret
	glbl RuntimeError
	constobj 2
	call 1
	raiseobj
	none
	ret
	
_get_side: ;projects/standalone_/program.py
	ldloc.1
	glbl hub
	attr port
	attr A
	glbl hub
	attr port
	attr C
	glbl hub
	attr port
	attr E
	tuple 3
	in
	bfalse 7
	glbl HubSide
	attr LEFT
	ret
	ldloc.1
	glbl hub
	attr port
	attr B
	glbl hub
	attr port
	attr D
	glbl hub
	attr port
	attr F
	tuple 3
	in
	bfalse 7
	glbl HubSide
	attr RIGHT
	ret
	glbl RuntimeError
	constobj 2
	call 1
	raiseobj
	none
	ret
	
<genexpr>: ;projects/standalone_/program.py
	null
	ldloc.1
	null
	null
	for.iter 14, 0
	stloc.2
	deref 0
	method _has_device_connected
	ldloc.2
	call.meth 1
	yield
	pop
	jmp -17
	none
	ret
	
_any_devices_connected: ;projects/standalone_/program.py
	glbl any
	ldloc.0
	mkclosure 1, 1
	glbl ALL_PORTS
	ld.iter
	call 1
	call 1
	ret
	
_has_device_connected: ;projects/standalone_/program.py
	ldloc.1
	method info
	call.meth 0
	str type
	MP_BC_LOAD_SUBSCR
	none
	is
	not
	ret
	
_enable_advertise_ports: ;projects/standalone_/program.py
	ldloc.0
	attr rows
	ld.iterstack
	for.iter 12, 0
	stloc.1
	ldloc.1
	method set_advertise_ports
	true
	call.meth 1
	pop
	jmp -15
	none
	ret
	
_disable_advertise_ports: ;projects/standalone_/program.py
	ldloc.0
	attr rows
	ld.iterstack
	for.iter 12, 0
	stloc.1
	ldloc.1
	method set_advertise_ports
	false
	call.meth 1
	pop
	jmp -15
	none
	ret
	
_start_heartbeat: ;projects/standalone_/program.py
	ldloc.0
	attr heartbeat
	btrue 27
	ldloc.0
	method _run_heartbeat_loop
	call.meth 0
	ldloc.0
	st.attr heartbeat
	ldloc.0
	attr system
	attr loop
	method call_soon
	ldloc.0
	attr heartbeat
	call.meth 1
	pop
	none
	ret
	
_stop_heartbeat: ;projects/standalone_/program.py
	ldloc.0
	attr heartbeat
	bfalse 15
	glbl cancel
	ldloc.0
	attr heartbeat
	call 1
	pop
	none
	ldloc.0
	st.attr heartbeat
	none
	ret
	
_run_heartbeat_loop: ;projects/standalone_/program.py
	jmp 101
	except.setup 8, 0
	int 167, 8
	yield
	pop
	except.jump 17, 0
	dup
	glbl AttributeError
	ematch
	bfalse 8
	pop
	jmp.unwind 85, undefined
	except.jump 1, 0
	finally.end
	ldloc.0
	attr rows
	ld.iterstack
	for.iter 65, 0
	stloc.1
	except.setup 13, 0
	ldloc.1
	method run_heartbeat
	call.meth 0
	ld.iter
	none
	yieldfrom
	pop
	except.jump 17, 0
	dup
	glbl AttributeError
	ematch
	bfalse 8
	pop
	jmp.unwind 36, undefined
	except.jump 1, 0
	finally.end
	except.setup 8, 0
	int 135, 104
	yield
	pop
	except.jump 17, 0
	dup
	glbl AttributeError
	ematch
	bfalse 8
	pop
	jmp.unwind 8, undefined
	except.jump 1, 0
	finally.end
	jmp -68
	ldloc.0
	attr heartbeat
	btrue -108
	none
	ret
	
Standalone: ;projects/standalone_/program.py
	loadname __name__
	st.name __module__
	str Standalone
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name get_image
	mkfun 2
	st.name on_enter
	mkfun 3
	st.name on_exit
	mkfun 4
	st.name on_device_connected
	mkfun 5
	st.name on_device_disconnected
	mkfun 6
	st.name on_left_button_down
	mkfun 7
	st.name on_left_button_up
	mkfun 8
	st.name on_right_button_down
	mkfun 9
	st.name on_right_button_up
	mkfun 10
	st.name _get_row
	mkfun 11
	st.name _get_side
	mkfun 12
	st.name _any_devices_connected
	mkfun 13
	st.name _has_device_connected
	mkfun 14
	st.name _enable_advertise_ports
	mkfun 15
	st.name _disable_advertise_ports
	mkfun 16
	st.name _start_heartbeat
	mkfun 17
	st.name _stop_heartbeat
	mkfun 18
	st.name _run_heartbeat_loop
	none
	ret
	
<module>: ;projects/standalone_/program.py
	128
	none
	import.nm utime
	st.name utime
	128
	none
	import.nm hub
	st.name hub
	129
	str RowController
	tuple 1
	import.nm row
	import.from RowController
	st.name RowController
	pop
	129
	str Device
	tuple 1
	import.nm devices
	import.from Device
	st.name Device
	pop
	129
	str cancel
	tuple 1
	import.nm util
	import.from cancel
	st.name cancel
	pop
	129
	str HubSide
	tuple 1
	import.nm util
	import.from HubSide
	st.name HubSide
	pop
	129
	str DeviceModePriorityMap
	tuple 1
	import.nm priority_mapping
	import.from DeviceModePriorityMap
	st.name DeviceModePriorityMap
	pop
	loadname hub
	attr port
	attr A
	loadname hub
	attr port
	attr B
	loadname hub
	attr port
	attr C
	loadname hub
	attr port
	attr D
	loadname hub
	attr port
	attr E
	loadname hub
	attr port
	attr F
	tuple 6
	st.name ALL_PORTS
	buildclass
	mkfun 0
	str Standalone
	loadname object
	call 3
	st.name Standalone
	none
	ret
	