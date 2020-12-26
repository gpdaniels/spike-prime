notify_sensor_data: ;protocol/notifications.py
	ldloc.0
	method emit
	128
	glbl sensor_data
	call.meth 2
	pop
	none
	ret
	
notify_storage_status: ;protocol/notifications.py
	ldloc.0
	method emit
	129
	glbl get_storage_information
	call 0
	call.meth 2
	pop
	none
	ret
	
notify_battery_status: ;protocol/notifications.py
	ldloc.0
	method emit
	130
	glbl battery_status
	call.meth 2
	pop
	none
	ret
	
notify_orientation_status: ;protocol/notifications.py
	glbl hub
	attr motion
	method orientation
	call.meth 0
	stloc.1
	ldloc.1
	none
	is
	not
	bfalse 9
	ldloc.0
	method emit
	142
	ldloc.1
	call.meth 2
	pop
	none
	ret
	
notify_info_status: ;protocol/notifications.py
	glbl b2a_base64
	glbl read_local_name
	call 0
	call 1
	method strip
	call.meth 0
	stloc.1
	ldloc.0
	method emit
	137
	ldloc.1
	list 1
	call.meth 2
	pop
	none
	ret
	
notify_button_event: ;protocol/notifications.py
	ldloc.0
	method emit
	131
	ldloc.1
	ldloc.2
	list 2
	call.meth 2
	pop
	none
	ret
	
notify_stack_start: ;protocol/notifications.py
	ldloc.0
	method emit
	135
	ldloc.1
	call.meth 2
	pop
	none
	ret
	
notify_stack_stop: ;protocol/notifications.py
	ldloc.0
	method emit
	136
	ldloc.1
	call.meth 2
	pop
	none
	ret
	
notify_gesture_event: ;protocol/notifications.py
	ldloc.0
	method emit
	132
	ldloc.1
	call.meth 2
	pop
	none
	ret
	
notify_orientation_event: ;protocol/notifications.py
	ldloc.0
	method emit
	142
	ldloc.1
	call.meth 2
	pop
	none
	ret
	
notify_vm_state: ;protocol/notifications.py
	ldloc.0
	method emit
	139
	ldloc.1
	ldloc.2
	ldloc.3
	ldloc.4
	list 4
	call.meth 2
	pop
	none
	ret
	
notify_error_event: ;protocol/notifications.py
	ldloc.0
	method emit
	138
	ldloc.1
	ldloc.2
	list 2
	call.meth 2
	pop
	none
	ret
	
notify_program_running: ;protocol/notifications.py
	ldloc.0
	method emit
	140
	ldloc.2
	ldloc.1
	list 2
	call.meth 2
	pop
	none
	ret
	
notify_linegraph_timer_reset: ;protocol/notifications.py
	ldloc.0
	method emit
	141
	list 0
	call.meth 2
	pop
	none
	ret
	
notify_debug_event: ;protocol/notifications.py
	glbl len
	ldloc.0
	attr run_queue
	call 1
	glbl _DEBUG_PAYLOAD
	glbl _RQ_LEN
	MP_BC_STORE_SUBSCR
	glbl len
	ldloc.0
	attr wait_queue
	call 1
	glbl _DEBUG_PAYLOAD
	glbl _WQ_LEN
	MP_BC_STORE_SUBSCR
	glbl mem_alloc
	call 0
	stloc.2
	ldloc.2
	glbl _DEBUG_PAYLOAD
	glbl _MEM
	MP_BC_LOAD_SUBSCR
	sub
	glbl _DEBUG_PAYLOAD
	glbl _D
	MP_BC_STORE_SUBSCR
	ldloc.2
	glbl _DEBUG_PAYLOAD
	glbl _MEM
	MP_BC_STORE_SUBSCR
	ldloc.1
	method emit
	str debug
	glbl _DEBUG_PAYLOAD
	call.meth 2
	pop
	none
	ret
	
<module>: ;protocol/notifications.py
	128
	str mem_alloc
	tuple 1
	import.nm gc
	import.from mem_alloc
	st.name mem_alloc
	pop
	128
	none
	import.nm hub
	st.name hub
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	str get_storage_information
	str read_local_name
	tuple 2
	import.nm util.storage
	import.from get_storage_information
	st.name get_storage_information
	import.from read_local_name
	st.name read_local_name
	pop
	128
	str battery_status
	str sensor_data
	tuple 2
	import.nm util.sensors
	import.from battery_status
	st.name battery_status
	import.from sensor_data
	st.name sensor_data
	pop
	128
	str b2a_base64
	tuple 1
	import.nm ubinascii
	import.from b2a_base64
	st.name b2a_base64
	pop
	mkfun 2
	st.name notify_sensor_data
	mkfun 3
	st.name notify_storage_status
	mkfun 4
	st.name notify_battery_status
	mkfun 5
	st.name notify_orientation_status
	mkfun 6
	st.name notify_info_status
	mkfun 7
	st.name notify_button_event
	mkfun 8
	st.name notify_stack_start
	mkfun 9
	st.name notify_stack_stop
	mkfun 10
	st.name notify_gesture_event
	mkfun 11
	st.name notify_orientation_event
	mkfun 12
	st.name notify_vm_state
	mkfun 13
	st.name notify_error_event
	none
	tuple 1
	null
	mkfun.defargs 14
	st.name notify_program_running
	mkfun 15
	st.name notify_linegraph_timer_reset
	constobj 0
	st.name _RQ_LEN
	constobj 1
	st.name _WQ_LEN
	str mem_alloc
	st.name _MEM
	str mem_delta
	st.name _D
	map 4
	128
	loadname _RQ_LEN
	st.map
	128
	loadname _WQ_LEN
	st.map
	128
	loadname _MEM
	st.map
	128
	loadname _D
	st.map
	st.name _DEBUG_PAYLOAD
	mkfun 16
	st.name notify_debug_event
	none
	ret
	