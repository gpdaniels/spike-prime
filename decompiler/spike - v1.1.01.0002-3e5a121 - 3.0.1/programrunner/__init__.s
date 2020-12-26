setup_vm: ;programrunner/__init__.py
	except.setup 50, 0
	glbl gc
	method collect
	call.meth 0
	pop
	glbl __import__
	ldloc.0
	call 1
	stloc.4
	glbl gc
	method collect
	call.meth 0
	pop
	ldloc.4
	method setup
	ldloc.1
	ldloc.2
	ldloc.3
	call.meth 3
	stloc.5
	glbl sys
	attr modules
	ldloc.0
	null
	rot3
	MP_BC_STORE_SUBSCR
	ldloc.5
	ret
	except.jump 101, 0
	dup
	glbl NameError
	ematch
	bfalse 42
	stloc.6
	finally.setup 30, 0
	glbl gc
	method collect
	call.meth 0
	pop
	glbl error_handler
	method handle_notify_error
	glbl PROGRAM_EXECUTION_ERROR
	glbl str
	ldloc.6
	call 1
	call.meth 2
	pop
	ldloc.6
	raiseobj
	none
	none
	stloc.6
	del.fast 6
	finally.end
	except.jump 51, 0
	dup
	glbl MemoryError
	ematch
	bfalse 42
	stloc.6
	finally.setup 30, 0
	glbl gc
	method collect
	call.meth 0
	pop
	glbl error_handler
	method handle_notify_error
	glbl PROGRAM_EXECUTION_MEMORY_ERROR
	glbl str
	ldloc.6
	call 1
	call.meth 2
	pop
	ldloc.6
	raiseobj
	none
	none
	stloc.6
	del.fast 6
	finally.end
	except.jump 1, 0
	finally.end
	none
	ret
	
__init__: ;programrunner/__init__.py
	ldloc.2
	ldloc.0
	st.attr _system
	ldloc.3
	ldloc.0
	st.attr _rttimer
	none
	ldloc.0
	st.attr _vm
	glbl get_event_loop
	call 0
	ldloc.0
	st.attr loop
	ldloc.1
	ldloc.0
	st.attr _json_rpc
	glbl ProgramRunner
	attr IDLE
	ldloc.0
	st.attr state
	none
	ldloc.0
	st.attr project_id
	none
	ret
	
is_running: ;programrunner/__init__.py
	ldloc.0
	attr state
	glbl ProgramRunner
	attr RUNNING_NONBLOCKING
	glbl ProgramRunner
	attr RUNNING_BLOCKING
	tuple 2
	in
	ret
	
vm_has_extension: ;programrunner/__init__.py
	ldloc.0
	attr _vm
	none
	is
	not
	bfalse.pop 24
	ldloc.1
	ldloc.0
	attr _vm
	attr extensions
	in
	bfalse.pop 12
	ldloc.0
	attr _vm
	attr extensions
	ldloc.1
	MP_BC_LOAD_SUBSCR
	none
	is
	not
	ret
	
start_scratch: ;programrunner/__init__.py
	glbl setup_vm
	deref 2
	deref 0
	attr _json_rpc
	deref 0
	attr _system
	deref 1
	call 4
	ld.iter
	none
	yieldfrom
	deref 0
	st.attr _vm
	deref 0
	attr loop
	method call_soon
	deref 0
	method start_notify_loop
	call.meth 0
	call.meth 1
	pop
	glbl notifications
	method notify_program_running
	deref 0
	attr _json_rpc
	true
	deref 0
	attr project_id
	call.meth 3
	pop
	glbl gc
	method collect
	call.meth 0
	pop
	deref 0
	attr _vm
	method start
	call.meth 0
	pop
	glbl reset_time
	call 0
	pop
	none
	ret
	
start_program: ;programrunner/__init__.py
	deref 0
	attr state
	glbl ProgramRunner
	attr RUNNING_NONBLOCKING
	eq
	bfalse 8
	deref 0
	method stop_all
	call.meth 0
	pop
	glbl wait_until_ready_after_restart
	call 0
	pop
	deref 0
	attr _rttimer
	method start
	str period
	glbl TIMER_PACE_LOW
	call.meth 130, 0
	pop
	glbl get_path
	ldloc.1
	call 1
	st.deref 7
	glbl get_program_type
	ldloc.1
	call 1
	stloc.3
	glbl get_program_project_id
	ldloc.1
	call 1
	deref 0
	st.attr project_id
	deref 7
	bfalse 242
	ldloc.3
	glbl PROGRAM_TYPE_PYTHON
	eq
	bfalse 191
	glbl notifications
	method notify_program_running
	deref 0
	attr _json_rpc
	true
	deref 0
	attr project_id
	call.meth 3
	pop
	glbl ProgramRunner
	attr RUNNING_BLOCKING
	deref 0
	st.attr state
	finally.setup 78, 0
	except.setup 29, 0
	glbl gc
	method collect
	call.meth 0
	pop
	glbl __import__
	deref 7
	call 1
	pop
	glbl gc
	method collect
	call.meth 0
	pop
	except.jump 45, 0
	dup
	glbl KeyboardInterrupt
	ematch
	bfalse 5
	pop
	rethrow
	except.jump 32, 0
	dup
	glbl BaseException
	ematch
	bfalse 23
	stloc.4
	finally.setup 11, 0
	glbl error_handler
	method handle_user_program_error
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
	deref 7
	glbl sys
	attr modules
	in
	bfalse 11
	glbl sys
	attr modules
	deref 7
	null
	rot3
	MP_BC_STORE_SUBSCR
	glbl sys
	attr modules
	ld.iterstack
	for.iter 22, 0
	stloc.5
	str spike
	ldloc.5
	in
	bfalse 10
	glbl sys
	attr modules
	ldloc.5
	null
	rot3
	MP_BC_STORE_SUBSCR
	jmp -25
	glbl gc
	method collect
	call.meth 0
	pop
	finally.end
	glbl ProgramRunner
	attr RUNNING_NONBLOCKING
	deref 0
	st.attr state
	jmp 43
	ldloc.3
	glbl PROGRAM_TYPE_SCRATCH
	eq
	bfalse 35
	glbl ProgramRunner
	attr RUNNING_NONBLOCKING
	deref 0
	st.attr state
	ldloc.0
	ldloc.2
	ldloc.7
	mkclosure 3, 3
	stloc.6
	deref 0
	attr loop
	method call_soon
	ldloc.6
	call 0
	call.meth 1
	pop
	jmp 0
	glbl bool
	deref 7
	call 1
	ret
	
stop_all: ;programrunner/__init__.py
	ldloc.0
	attr _rttimer
	method start
	str period
	glbl TIMER_PACE_HIGH
	call.meth 130, 0
	pop
	ldloc.0
	attr _vm
	bfalse 26
	ldloc.0
	attr _vm
	method shutdown
	call.meth 0
	pop
	ldloc.0
	method notify_all_state
	ldloc.0
	attr _vm
	call.meth 1
	pop
	none
	ldloc.0
	st.attr _vm
	ldloc.0
	attr state
	glbl ProgramRunner
	attr RUNNING_BLOCKING
	eq
	bfalse 44
	ldloc.1
	none
	is
	not
	bfalse 37
	glbl notifications
	method notify_program_running
	ldloc.0
	attr _json_rpc
	false
	ldloc.0
	attr project_id
	call.meth 3
	pop
	glbl set_force_reset
	ldloc.1
	call 1
	pop
	ldloc.0
	attr _rttimer
	method repl_reset
	call.meth 0
	pop
	none
	ret
	glbl hub
	attr motion
	method align_to_model
	str top
	glbl hub
	attr TOP
	str front
	glbl hub
	attr FRONT
	call.meth 132, 0
	pop
	str A
	str B
	str C
	str D
	str E
	str F
	tuple 6
	ld.iterstack
	for.iter 89, 0
	stloc.2
	glbl getattr
	glbl hub
	attr port
	ldloc.2
	call 2
	stloc.3
	ldloc.3
	attr motor
	bfalse 23
	ldloc.3
	attr motor
	method brake
	call.meth 0
	pop
	ldloc.3
	attr motor
	method float
	call.meth 0
	pop
	jmp 32
	glbl sensors
	method is_type
	ldloc.2
	glbl LPF2_FLIPPER_DISTANCE
	call.meth 2
	bfalse 17
	ldloc.3
	attr device
	method mode
	133
	str \x00\x00\x00\x00
	call.meth 2
	pop
	jmp 0
	glbl sensors
	method reset_to_default_mode
	ldloc.3
	call.meth 1
	pop
	jmp -92
	glbl hub
	attr sound
	method beep
	128
	128
	call.meth 2
	pop
	glbl hub
	attr display
	method clear
	call.meth 0
	pop
	glbl hub
	method led
	138
	call.meth 1
	pop
	glbl hub
	attr sound
	method volume
	int 128, 100
	call.meth 1
	pop
	glbl rotate_hub_display_to_orientation
	128
	call 1
	pop
	glbl stop_time
	call 0
	pop
	glbl ProgramRunner
	attr IDLE
	ldloc.0
	st.attr state
	glbl notifications
	method notify_program_running
	ldloc.0
	attr _json_rpc
	false
	ldloc.0
	attr project_id
	call.meth 3
	pop
	none
	ldloc.0
	st.attr project_id
	none
	ret
	
start_notify_loop: ;programrunner/__init__.py
	ldloc.0
	attr _vm
	bfalse 124
	ldloc.0
	attr _vm
	attr vars
	stloc.1
	ldloc.0
	attr _vm
	attr lists
	stloc.2
	ldloc.0
	attr _vm
	attr store
	stloc.3
	jmp 73
	ldloc.1
	attr is_dirty
	btrue 14
	ldloc.2
	attr is_dirty
	btrue 7
	ldloc.3
	attr is_dirty
	bfalse 47
	glbl notifications
	method notify_vm_state
	ldloc.0
	attr _json_rpc
	ldloc.0
	attr _vm
	attr target_name
	glbl map_dirty
	ldloc.1
	glbl filter_vm_vars
	call 2
	glbl map_dirty
	ldloc.2
	glbl filter_vm_lists
	call 2
	glbl map_dirty
	ldloc.3
	glbl dict
	call 2
	call.meth 5
	pop
	int 131, 116
	yield
	pop
	ldloc.0
	attr state
	glbl ProgramRunner
	attr RUNNING_NONBLOCKING
	is
	bfalse 10
	ldloc.0
	attr _vm
	none
	is
	not
	btrue -97
	none
	ret
	
notify_all_state: ;programrunner/__init__.py
	except.setup 47, 0
	glbl notifications
	method notify_vm_state
	ldloc.0
	attr _json_rpc
	ldloc.1
	attr target_name
	glbl dict
	glbl untuple_vm_vars
	ldloc.1
	attr vars
	method items
	call.meth 0
	call 1
	call 1
	ldloc.1
	attr lists
	ldloc.1
	attr store
	call.meth 5
	pop
	except.jump 5, 0
	pop
	except.jump 1, 0
	finally.end
	none
	ret
	
ProgramRunner: ;programrunner/__init__.py
	loadname __name__
	st.name __module__
	str ProgramRunner
	st.name __qualname__
	128
	st.name IDLE
	129
	st.name RUNNING_NONBLOCKING
	130
	st.name RUNNING_BLOCKING
	mkfun 0
	st.name __init__
	mkfun 1
	st.name is_running
	mkfun 2
	st.name vm_has_extension
	mkfun 3
	st.name start_program
	none
	tuple 1
	null
	mkfun.defargs 4
	st.name stop_all
	mkfun 5
	st.name start_notify_loop
	mkfun 6
	st.name notify_all_state
	none
	ret
	
map_dirty: ;programrunner/__init__.py
	ldloc.0
	attr is_dirty
	bfalse 10
	ldloc.1
	ldloc.0
	method dirty_items
	call.meth 0
	call 1
	ret
	glbl _EMPTY_DICT
	ret
	
<genexpr>: ;programrunner/__init__.py
	null
	ldloc.0
	null
	null
	for.iter 20, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.1
	stloc.2
	ldloc.1
	glbl str
	ldloc.2
	129
	MP_BC_LOAD_SUBSCR
	call 1
	tuple 2
	yield
	pop
	jmp -23
	none
	ret
	
untuple_vm_vars: ;programrunner/__init__.py
	mkfun 1
	ldloc.0
	ld.iter
	call 1
	ld.iter
	none
	yieldfrom
	pop
	none
	ret
	
filter_vm_vars: ;programrunner/__init__.py
	glbl filter_dict_len
	glbl untuple_vm_vars
	ldloc.0
	call 1
	glbl len
	call 2
	ret
	
<genexpr>: ;programrunner/__init__.py
	null
	ldloc.0
	null
	null
	for.iter 12, 0
	stloc.1
	glbl len
	ldloc.1
	call 1
	yield
	pop
	jmp -15
	none
	ret
	
sum_list_len: ;programrunner/__init__.py
	glbl sum
	mkfun 1
	ldloc.0
	ld.iter
	call 1
	call 1
	ret
	
filter_vm_lists: ;programrunner/__init__.py
	glbl filter_dict_len
	ldloc.0
	glbl sum_list_len
	call 2
	stloc.1
	glbl len
	ldloc.1
	call 1
	131
	qt
	bfalse 4
	glbl _EMPTY_DICT
	ret
	ldloc.1
	ret
	
filter_dict_len: ;programrunner/__init__.py
	128
	stloc.2
	glbl dict
	call 0
	stloc.3
	ldloc.0
	ld.iterstack
	for.iter 28, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.4
	stloc.5
	ldloc.1
	ldloc.5
	call 1
	stloc.6
	ldloc.6
	int 132, 0
	le
	bfalse 8
	ldloc.5
	ldloc.3
	ldloc.4
	MP_BC_STORE_SUBSCR
	ldloc.2
	ldloc.6
	add.in
	stloc.2
	jmp -31
	ldloc.2
	int 136, 0
	qe
	bfalse 4
	glbl _EMPTY_DICT
	ret
	ldloc.3
	ret
	
<module>: ;programrunner/__init__.py
	128
	none
	import.nm sys
	st.name sys
	128
	none
	import.nm gc
	st.name gc
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
	str get_event_loop
	tuple 1
	import.nm event_loop
	import.from get_event_loop
	st.name get_event_loop
	pop
	128
	str notifications
	tuple 1
	import.nm protocol
	import.from notifications
	st.name notifications
	pop
	128
	str VirtualMachine
	tuple 1
	import.nm runtime.virtualmachine
	import.from VirtualMachine
	st.name VirtualMachine
	pop
	128
	none
	import.nm util.sensors
	attr sensors
	st.name sensors
	128
	str reset_time
	str stop_time
	tuple 2
	import.nm util.time
	import.from reset_time
	st.name reset_time
	import.from stop_time
	st.name stop_time
	pop
	128
	str LPF2_FLIPPER_DISTANCE
	str TIMER_PACE_HIGH
	str TIMER_PACE_LOW
	tuple 3
	import.nm util.constants
	import.from LPF2_FLIPPER_DISTANCE
	st.name LPF2_FLIPPER_DISTANCE
	import.from TIMER_PACE_HIGH
	st.name TIMER_PACE_HIGH
	import.from TIMER_PACE_LOW
	st.name TIMER_PACE_LOW
	pop
	128
	str error_handler
	str PROGRAM_EXECUTION_ERROR
	str PROGRAM_EXECUTION_MEMORY_ERROR
	tuple 3
	import.nm util.error_handler
	import.from error_handler
	st.name error_handler
	import.from PROGRAM_EXECUTION_ERROR
	st.name PROGRAM_EXECUTION_ERROR
	import.from PROGRAM_EXECUTION_MEMORY_ERROR
	st.name PROGRAM_EXECUTION_MEMORY_ERROR
	pop
	128
	str get_path
	str get_program_type
	str get_program_project_id
	str PROGRAM_TYPE_PYTHON
	str PROGRAM_TYPE_SCRATCH
	str set_force_reset
	tuple 6
	import.nm util.storage
	import.from get_path
	st.name get_path
	import.from get_program_type
	st.name get_program_type
	import.from get_program_project_id
	st.name get_program_project_id
	import.from PROGRAM_TYPE_PYTHON
	st.name PROGRAM_TYPE_PYTHON
	import.from PROGRAM_TYPE_SCRATCH
	st.name PROGRAM_TYPE_SCRATCH
	import.from set_force_reset
	st.name set_force_reset
	pop
	128
	str wait_until_ready_after_restart
	tuple 1
	import.nm util.resetter
	import.from wait_until_ready_after_restart
	st.name wait_until_ready_after_restart
	pop
	128
	str rotate_hub_display_to_orientation
	tuple 1
	import.nm util.rotation
	import.from rotate_hub_display_to_orientation
	st.name rotate_hub_display_to_orientation
	pop
	map 0
	st.name _EMPTY_DICT
	mkfun 0
	st.name setup_vm
	buildclass
	mkfun 1
	str ProgramRunner
	call 2
	st.name ProgramRunner
	mkfun 2
	st.name map_dirty
	mkfun 3
	st.name untuple_vm_vars
	mkfun 4
	st.name filter_vm_vars
	mkfun 5
	st.name sum_list_len
	mkfun 6
	st.name filter_vm_lists
	mkfun 7
	st.name filter_dict_len
	none
	ret
	