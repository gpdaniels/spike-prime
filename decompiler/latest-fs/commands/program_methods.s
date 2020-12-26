__init__: ;commands/program_methods.py
	ldloc.3
	ldloc.1
	st.attr _hubui
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_storage_status: ;commands/program_methods.py
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl storage
	method get_storage_information
	call.meth 0
	call.meth 2
	pop
	none
	ret
	
callback: ;commands/program_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	map 2
	deref 2
	str transferid
	st.map
	int 132, 0
	str blocksize
	st.map
	call.meth 2
	pop
	none
	ret
	
handle_start_write_program: ;commands/program_methods.py
	glbl storage
	method get_storage_information
	call.meth 0
	stloc.3
	ldloc.1
	str size
	MP_BC_LOAD_SUBSCR
	ldloc.3
	str storage
	MP_BC_LOAD_SUBSCR
	str free
	MP_BC_LOAD_SUBSCR
	int 136, 0
	mul
	qt
	bfalse 56
	deref 0
	attr _rpc
	method error
	deref 2
	str error
	map 4
	str ENOSPC
	str type
	st.map
	constobj 3
	str message
	st.map
	ldloc.3
	str storage
	MP_BC_LOAD_SUBSCR
	str free
	MP_BC_LOAD_SUBSCR
	str free_space
	st.map
	ldloc.1
	str size
	MP_BC_LOAD_SUBSCR
	constobj 4
	st.map
	call.meth 130, 1
	pop
	jmp 182
	deref 0
	attr _hubui
	method will_stop_restart
	call.meth 0
	bfalse 35
	deref 0
	attr _rpc
	method suspend_current_message
	call.meth 0
	pop
	deref 0
	attr _hubui
	attr _programrunner
	method stop_all
	deref 0
	attr _hubui
	attr _current_slot
	call.meth 1
	pop
	none
	ret
	glbl str
	glbl urandom
	method getrandbits
	144
	call.meth 1
	call 1
	st.deref 10
	ldloc.1
	str slotid
	MP_BC_LOAD_SUBSCR
	stloc.4
	ldloc.1
	str size
	MP_BC_LOAD_SUBSCR
	stloc.5
	ldloc.1
	method get
	str meta
	map 0
	call.meth 2
	stloc.6
	glbl storage
	method generate_project_id
	call.meth 0
	stloc.7
	glbl storage
	method open_program
	ldloc.7
	call.meth 1
	stloc.8
	map 7
	ldloc.4
	str slotid
	st.map
	ldloc.7
	str projectid
	st.map
	ldloc.5
	str size
	st.map
	ldloc.6
	str meta
	st.map
	ldloc.8
	str fs
	st.map
	128
	constobj 5
	st.map
	128
	str type
	st.map
	glbl _TRANSFER_HANDLE
	deref 10
	MP_BC_STORE_SUBSCR
	deref 0
	method _handle_write_print_override
	deref 10
	call.meth 1
	pop
	ldloc.0
	ldloc.2
	ldloc.10
	mkclosure 6, 3
	stloc.9
	deref 0
	attr _hubui
	method stop_all
	str callback
	ldloc.9
	call.meth 130, 0
	pop
	none
	ret
	
_handle_write_print_override: ;commands/program_methods.py
	ldloc.1
	glbl _TRANSFER_HANDLE
	in
	bfalse 8
	glbl _TRANSFER_HANDLE
	ldloc.1
	MP_BC_LOAD_SUBSCR
	jmp 1
	none
	stloc.2
	ldloc.2
	btrue 6
	glbl Exception
	call 0
	raiseobj
	ldloc.2
	str fs
	MP_BC_LOAD_SUBSCR
	stloc.3
	glbl bytearray
	call 0
	stloc.4
	ldloc.4
	method extend
	glbl _PRINT_OVERRIDE
	call.meth 1
	pop
	ldloc.3
	method write
	ldloc.4
	call.meth 1
	stloc.5
	ldloc.3
	method flush
	call.meth 0
	pop
	ldloc.2
	constobj 2
	dup2
	MP_BC_LOAD_SUBSCR
	ldloc.5
	add.in
	rot3
	MP_BC_STORE_SUBSCR
	none
	ret
	
handle_write_package: ;commands/program_methods.py
	ldloc.1
	str transferid
	MP_BC_LOAD_SUBSCR
	stloc.3
	ldloc.1
	str data
	MP_BC_LOAD_SUBSCR
	stloc.4
	ldloc.3
	glbl _TRANSFER_HANDLE
	in
	bfalse 8
	glbl _TRANSFER_HANDLE
	ldloc.3
	MP_BC_LOAD_SUBSCR
	jmp 1
	none
	stloc.5
	ldloc.5
	btrue 6
	glbl Exception
	call 0
	raiseobj
	ldloc.5
	str fs
	MP_BC_LOAD_SUBSCR
	stloc.6
	ldloc.5
	str slotid
	MP_BC_LOAD_SUBSCR
	stloc.7
	ldloc.5
	str size
	MP_BC_LOAD_SUBSCR
	stloc.8
	glbl bytearray
	call 0
	stloc.9
	ldloc.9
	method extend
	ldloc.4
	call.meth 1
	pop
	ldloc.6
	method write
	glbl a2b_base64
	ldloc.9
	call 1
	call.meth 1
	stloc.10
	ldloc.6
	method flush
	call.meth 0
	pop
	ldloc.5
	constobj 3
	dup2
	MP_BC_LOAD_SUBSCR
	ldloc.10
	add.in
	rot3
	MP_BC_STORE_SUBSCR
	ldloc.5
	str bytes_written
	MP_BC_LOAD_SUBSCR
	stloc.11
	ldloc.11
	ldloc.8
	glbl len
	glbl _PRINT_OVERRIDE
	call 1
	add
	qe
	bfalse 50
	glbl storage
	method close_program
	ldloc.6
	ldloc.7
	ldloc.5
	str projectid
	MP_BC_LOAD_SUBSCR
	ldloc.8
	str meta
	ldloc.5
	str meta
	MP_BC_LOAD_SUBSCR
	call.meth 130, 4
	pop
	glbl _TRANSFER_HANDLE
	method pop
	ldloc.3
	none
	call.meth 2
	pop
	glbl notifications
	method notify_storage_status
	ldloc.0
	attr _rpc
	call.meth 1
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	map 1
	ldloc.11
	ldloc.8
	ne
	bfalse 4
	ldloc.11
	jmp 1
	none
	str next_ptr
	st.map
	call.meth 2
	pop
	none
	ret
	
handle_move_project: ;commands/program_methods.py
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl storage
	method move_slot
	ldloc.1
	str old_slotid
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str new_slotid
	MP_BC_LOAD_SUBSCR
	call.meth 2
	call.meth 2
	pop
	glbl notifications
	method notify_storage_status
	ldloc.0
	attr _rpc
	call.meth 1
	pop
	none
	ret
	
handle_remove_project: ;commands/program_methods.py
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl storage
	method clear_slot
	ldloc.1
	str slotid
	MP_BC_LOAD_SUBSCR
	call.meth 1
	call.meth 2
	pop
	glbl notifications
	method notify_storage_status
	ldloc.0
	attr _rpc
	call.meth 1
	pop
	none
	ret
	
handle_program_execute: ;commands/program_methods.py
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	ldloc.0
	attr _hubui
	method start_program
	ldloc.1
	str slotid
	MP_BC_LOAD_SUBSCR
	call.meth 1
	call.meth 2
	pop
	none
	ret
	
handle_program_terminate: ;commands/program_methods.py
	ldloc.0
	attr _hubui
	method will_stop_restart
	call.meth 0
	bfalse 33
	ldloc.0
	attr _rpc
	method suspend_current_message
	call.meth 0
	pop
	ldloc.0
	attr _hubui
	attr _programrunner
	method stop_all
	ldloc.0
	attr _hubui
	attr _current_slot
	call.meth 1
	pop
	jmp 21
	ldloc.0
	attr _hubui
	method stop_all
	call.meth 0
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_program_modechange: ;commands/program_methods.py
	ldloc.1
	str mode
	MP_BC_LOAD_SUBSCR
	str play
	eq
	stloc.3
	ldloc.0
	attr _hubui
	method change_execution_mode
	ldloc.3
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
	
handle_program_get_time: ;commands/program_methods.py
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	map 1
	glbl get_time
	call 0
	constobj 3
	st.map
	call.meth 2
	pop
	none
	ret
	
handle_program_reset_time: ;commands/program_methods.py
	glbl reset_time
	call 0
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	true
	call.meth 2
	pop
	none
	ret
	
handle_program_start_time: ;commands/program_methods.py
	glbl start_time
	call 0
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	true
	call.meth 2
	pop
	none
	ret
	
handle_soft_reset: ;commands/program_methods.py
	glbl sys
	method exit
	call.meth 0
	pop
	none
	ret
	
get_methods: ;commands/program_methods.py
	map 11
	ldloc.0
	attr handle_storage_status
	constobj 1
	st.map
	ldloc.0
	attr handle_remove_project
	constobj 2
	st.map
	ldloc.0
	attr handle_program_terminate
	constobj 3
	st.map
	ldloc.0
	attr handle_program_execute
	constobj 4
	st.map
	ldloc.0
	attr handle_program_modechange
	constobj 5
	st.map
	ldloc.0
	attr handle_start_write_program
	constobj 6
	st.map
	ldloc.0
	attr handle_write_package
	constobj 7
	st.map
	ldloc.0
	attr handle_move_project
	constobj 8
	st.map
	ldloc.0
	attr handle_program_get_time
	constobj 9
	st.map
	ldloc.0
	attr handle_program_reset_time
	constobj 10
	st.map
	ldloc.0
	attr handle_program_start_time
	constobj 11
	st.map
	ret
	
ProgramMethods: ;commands/program_methods.py
	loadname __name__
	st.name __module__
	str ProgramMethods
	st.name __qualname__
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	mkfun 1
	st.name handle_storage_status
	mkfun 2
	st.name handle_start_write_program
	mkfun 3
	st.name _handle_write_print_override
	mkfun 4
	st.name handle_write_package
	mkfun 5
	st.name handle_move_project
	mkfun 6
	st.name handle_remove_project
	mkfun 7
	st.name handle_program_execute
	mkfun 8
	st.name handle_program_terminate
	mkfun 9
	st.name handle_program_modechange
	mkfun 10
	st.name handle_program_get_time
	mkfun 11
	st.name handle_program_reset_time
	mkfun 12
	st.name handle_program_start_time
	mkfun 13
	st.name handle_soft_reset
	mkfun 14
	st.name get_methods
	ldloc.0
	ret
	
<module>: ;commands/program_methods.py
	128
	none
	import.nm sys
	st.name sys
	128
	str a2b_base64
	tuple 1
	import.nm ubinascii
	import.from a2b_base64
	st.name a2b_base64
	pop
	128
	none
	import.nm urandom
	st.name urandom
	128
	none
	import.nm utime
	st.name utime
	128
	none
	import.nm util.storage
	attr storage
	st.name storage
	128
	str get_time
	str reset_time
	str start_time
	tuple 3
	import.nm util.time
	import.from get_time
	st.name get_time
	import.from reset_time
	st.name reset_time
	import.from start_time
	st.name start_time
	pop
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	none
	import.nm protocol.notifications
	attr notifications
	st.name notifications
	129
	str AbstractHandler
	tuple 1
	import.nm abstract_handler
	import.from AbstractHandler
	st.name AbstractHandler
	pop
	map 0
	st.name _TRANSFER_HANDLE
	constobj 0
	st.name _PRINT_OVERRIDE
	buildclass
	mkfun 1
	str ProgramMethods
	loadname AbstractHandler
	call 3
	st.name ProgramMethods
	none
	ret
	