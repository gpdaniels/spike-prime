initialize: ;util/error_handler.py
	ldloc.1
	ldloc.0
	st.attr _hubui
	ldloc.2
	ldloc.0
	st.attr _communication
	glbl get_event_loop
	call 0
	ldloc.0
	st.attr _loop
	none
	ret
	
<listcomp>: ;util/error_handler.py
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
	
_emit_runtime_error: ;util/error_handler.py
	ldloc.0
	attr _communication
	bfalse 297
	glbl uio
	method StringIO
	call.meth 0
	stloc.3
	glbl sys
	method print_exception
	ldloc.1
	ldloc.3
	call.meth 2
	pop
	ldloc.3
	method getvalue
	call.meth 0
	stloc.4
	glbl hub
	attr __version__
	method split
	str -
	call.meth 1
	MP_BC_UNPACK_SEQUENCE 2
	stloc.5
	stloc.6
	mkfun 8
	ldloc.5
	129
	none
	slice 2
	MP_BC_LOAD_SUBSCR
	method split
	str .
	call.meth 1
	call 1
	stloc.5
	constobj 3
	stloc.7
	str 
	stloc.8
	ldloc.7
	ldloc.4
	in
	bfalse 164
	glbl ure
	method search
	constobj 4
	ldloc.4
	call.meth 2
	method group
	129
	call.meth 1
	stloc.9
	glbl ure
	method search
	constobj 5
	method format
	ldloc.9
	call.meth 1
	ldloc.4
	call.meth 2
	stloc.10
	ldloc.10
	none
	is
	bfalse 18
	glbl ure
	method search
	constobj 6
	method format
	ldloc.9
	call.meth 1
	ldloc.4
	call.meth 2
	stloc.10
	glbl int
	ldloc.10
	method group
	129
	call.meth 1
	call 1
	stloc.11
	glbl open
	constobj 7
	method format
	ldloc.9
	call.meth 1
	call 1
	with.setup 73, 0
	stloc.12
	glbl enumerate
	ldloc.12
	call 1
	ld.iterstack
	for.iter 61, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.13
	stloc.14
	ldloc.11
	132
	sub
	ldloc.13
	dup
	rot3
	le
	bfalse.pop 7
	ldloc.11
	130
	add
	le
	jmp 2
	rot
	pop
	bfalse 17
	ldloc.8
	glbl str
	ldloc.13
	129
	add
	call 1
	str \x09
	add
	ldloc.14
	add
	add.in
	stloc.8
	ldloc.13
	ldloc.11
	130
	add
	qt
	bfalse 7
	pop
	pop
	pop
	pop
	jmp 3
	jmp -64
	none
	with.chleanup
	finally.end
	ldloc.0
	attr _communication
	attr json_rpc
	method emit
	ldloc.2
	ldloc.5
	ldloc.6
	glbl version
	attr __version__
	glbl b2a_base64
	ldloc.4
	call 1
	method decode
	call.meth 0
	method strip
	call.meth 0
	glbl b2a_base64
	ldloc.8
	call 1
	method decode
	call.meth 0
	method strip
	call.meth 0
	list 5
	call.meth 2
	pop
	none
	ret
	
_show_ui_error: ;util/error_handler.py
	glbl hub
	method led
	call.meth 0
	stloc.1
	glbl hub
	method led
	glbl RED
	call.meth 1
	pop
	128
	jmp 35
	dup
	stloc.2
	glbl hub
	method led
	ldloc.2
	130
	mod
	128
	eq
	bfalse 6
	glbl BLACK
	jmp 3
	glbl RED
	call.meth 1
	pop
	int 128, 100
	yield
	pop
	129
	add.in
	dup
	135
	lt
	btrue -41
	pop
	glbl hub
	method led
	ldloc.1
	null
	call.kvmeth 0
	pop
	deref 0
	attr _hubui
	bfalse 11
	deref 0
	attr _hubui
	method stop_all
	call.meth 0
	pop
	none
	ret
	
_handle_error: ;util/error_handler.py
	ldloc.0
	mkclosure 3, 1
	stloc.3
	glbl log_critical_error
	ldloc.1
	call 1
	pop
	deref 0
	method _emit_runtime_error
	ldloc.1
	ldloc.2
	call.meth 2
	pop
	deref 0
	attr _loop
	method call_soon
	ldloc.3
	call 0
	call.meth 1
	pop
	none
	ret
	
handle_runtime_error: ;util/error_handler.py
	ldloc.0
	method _handle_error
	ldloc.1
	constobj 2
	call.meth 2
	pop
	none
	ret
	
handle_user_program_error: ;util/error_handler.py
	ldloc.0
	method _handle_error
	ldloc.1
	constobj 2
	call.meth 2
	pop
	none
	ret
	
handle_notify_error: ;util/error_handler.py
	ldloc.0
	attr _communication
	bfalse 18
	glbl notifications
	method notify_error_event
	ldloc.0
	attr _communication
	attr json_rpc
	ldloc.1
	ldloc.2
	call.meth 3
	pop
	none
	ret
	
ErrorHandler: ;util/error_handler.py
	loadname __name__
	st.name __module__
	str ErrorHandler
	st.name __qualname__
	mkfun 0
	st.name initialize
	mkfun 1
	st.name _emit_runtime_error
	mkfun 2
	st.name _handle_error
	mkfun 3
	st.name handle_runtime_error
	mkfun 4
	st.name handle_user_program_error
	mkfun 5
	st.name handle_notify_error
	none
	ret
	
<module>: ;util/error_handler.py
	128
	none
	import.nm sys
	st.name sys
	128
	none
	import.nm ure
	st.name ure
	128
	none
	import.nm uio
	st.name uio
	128
	none
	import.nm hub
	st.name hub
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
	str b2a_base64
	tuple 1
	import.nm ubinascii
	import.from b2a_base64
	st.name b2a_base64
	pop
	128
	str RED
	str BLACK
	tuple 2
	import.nm util.color
	import.from RED
	st.name RED
	import.from BLACK
	st.name BLACK
	pop
	128
	str log_critical_error
	tuple 1
	import.nm util.log
	import.from log_critical_error
	st.name log_critical_error
	pop
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
	st.name PROGRAM_EXECUTION_ERROR
	129
	st.name PROGRAM_EXECUTION_MEMORY_ERROR
	buildclass
	mkfun 0
	str ErrorHandler
	call 2
	st.name ErrorHandler
	loadname ErrorHandler
	call 0
	st.name error_handler
	none
	ret
	