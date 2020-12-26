__init__: ;protocol/ujsonrpc.py
	ldloc.1
	ldloc.0
	st.attr _stream
	str 
	ldloc.0
	st.attr _current_msg
	constobj 2
	ldloc.0
	st.attr buf
	none
	ret
	
stream: ;protocol/ujsonrpc.py
	ldloc.0
	attr _stream
	ret
	
stream: ;protocol/ujsonrpc.py
	ldloc.1
	method read
	call.meth 0
	pop
	ldloc.1
	ldloc.0
	st.attr _stream
	none
	ret
	
parse_chunk: ;protocol/ujsonrpc.py
	ldloc.0
	dup
	attr buf
	ldloc.1
	add.in
	rot
	st.attr buf
	glbl _CARRIAGE_RETURN
	ldloc.0
	attr buf
	in
	bfalse 7
	ldloc.0
	method parse_buffer
	call.meth 0
	pop
	none
	ret
	
parse_buffer: ;protocol/ujsonrpc.py
	ldloc.0
	attr buf
	method split
	glbl _CARRIAGE_RETURN
	call.meth 1
	stloc.1
	glbl len
	ldloc.1
	call 1
	129
	le
	bfalse 2
	none
	ret
	ldloc.1
	none
	127
	slice 2
	MP_BC_LOAD_SUBSCR
	ld.iterstack
	for.iter 16, 0
	stloc.2
	ldloc.2
	bfalse 8
	ldloc.0
	method _handle_message
	ldloc.2
	call.meth 1
	pop
	jmp -19
	ldloc.1
	127
	MP_BC_LOAD_SUBSCR
	ldloc.0
	st.attr buf
	none
	ret
	
resume_suspended_msg: ;protocol/ujsonrpc.py
	ldloc.0
	method _pop_suspend_message
	call.meth 0
	stloc.1
	ldloc.1
	bfalse 8
	ldloc.0
	method _handle_message
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
reply: ;protocol/ujsonrpc.py
	ldloc.0
	attr _stream
	method write
	glbl _ID_PREFIX
	call.meth 1
	pop
	glbl ujson
	method dump
	ldloc.1
	ldloc.0
	attr _stream
	call.meth 2
	pop
	ldloc.0
	attr _stream
	method write
	glbl _RESPONSE
	call.meth 1
	pop
	glbl ujson
	method dump
	ldloc.2
	ldloc.0
	attr _stream
	call.meth 2
	pop
	ldloc.0
	attr _stream
	method write
	glbl _SUFFIX
	call.meth 1
	pop
	none
	ret
	
error: ;protocol/ujsonrpc.py
	glbl b2a_base64
	glbl ujson
	method dumps
	ldloc.2
	call.meth 1
	call 1
	method strip
	call.meth 0
	stloc.3
	ldloc.0
	attr _stream
	method write
	glbl _ID_PREFIX
	call.meth 1
	pop
	glbl ujson
	method dump
	ldloc.1
	ldloc.0
	attr _stream
	call.meth 2
	pop
	ldloc.0
	attr _stream
	method write
	glbl _ERROR
	call.meth 1
	pop
	glbl ujson
	method dump
	ldloc.3
	ldloc.0
	attr _stream
	call.meth 2
	pop
	ldloc.0
	attr _stream
	method write
	glbl _SUFFIX
	call.meth 1
	pop
	none
	ret
	
_handle_message: ;protocol/ujsonrpc.py
	none
	stloc.2
	except.setup 141, 0
	ldloc.1
	ldloc.0
	st.attr _current_msg
	glbl ujson
	method loads
	ldloc.1
	call.meth 1
	stloc.1
	ldloc.1
	method get
	str i
	none
	call.meth 2
	stloc.2
	ldloc.1
	method get
	str m
	none
	call.meth 2
	stloc.3
	ldloc.3
	none
	is
	not
	bfalse 59
	ldloc.3
	ldloc.0
	attr methods
	in
	not
	bfalse 26
	map 2
	constobj 2
	str type
	st.map
	ldloc.3
	str message
	st.map
	stloc.4
	ldloc.0
	method error
	ldloc.2
	ldloc.4
	call.meth 2
	pop
	jmp 20
	ldloc.0
	attr methods
	ldloc.3
	MP_BC_LOAD_SUBSCR
	ldloc.1
	method get
	str p
	none
	call.meth 2
	ldloc.2
	call 2
	pop
	jmp 35
	ldloc.2
	ldloc.0
	attr pending
	in
	bfalse 26
	ldloc.0
	attr pending
	method pop
	ldloc.2
	call.meth 1
	ldloc.1
	method get
	str r
	none
	call.meth 2
	call 1
	pop
	jmp 0
	except.jump 118, 0
	dup
	glbl Exception
	ematch
	bfalse 109
	stloc.5
	finally.setup 97, 0
	128
	none
	import.nm sys
	stloc.6
	128
	none
	import.nm uio
	stloc.7
	128
	none
	import.nm util.log
	stloc.8
	128
	str error_handler
	tuple 1
	import.nm util.error_handler
	import.from error_handler
	stloc.9
	pop
	ldloc.7
	method StringIO
	call.meth 0
	stloc.10
	ldloc.6
	method print_exception
	ldloc.5
	ldloc.10
	call.meth 2
	pop
	map 2
	str STACKTRACE
	str type
	st.map
	ldloc.10
	method getvalue
	call.meth 0
	str message
	st.map
	stloc.11
	ldloc.0
	method error
	ldloc.2
	ldloc.11
	call.meth 2
	pop
	ldloc.9
	method handle_runtime_error
	ldloc.5
	call.meth 1
	pop
	ldloc.8
	attr log
	method log_to_file
	ldloc.1
	call.meth 1
	pop
	none
	none
	stloc.5
	del.fast 5
	finally.end
	except.jump 1, 0
	finally.end
	none
	ret
	
suspend_current_message: ;protocol/ujsonrpc.py
	glbl open
	glbl _SUSPENDED_MSG_PATH_
	str w
	call 2
	stloc.1
	ldloc.1
	method write
	ldloc.0
	attr _current_msg
	call.meth 1
	pop
	ldloc.1
	method flush
	call.meth 0
	pop
	ldloc.1
	method close
	call.meth 0
	pop
	none
	ret
	
_pop_suspend_message: ;protocol/ujsonrpc.py
	none
	stloc.1
	except.setup 41, 0
	glbl open
	glbl _SUSPENDED_MSG_PATH_
	str r
	call 2
	stloc.2
	ldloc.2
	method read
	call.meth 0
	stloc.1
	ldloc.2
	method close
	call.meth 0
	pop
	glbl uos
	method unlink
	glbl _SUSPENDED_MSG_PATH_
	call.meth 1
	pop
	except.jump 37, 0
	dup
	glbl OSError
	ematch
	bfalse 28
	stloc.3
	finally.setup 16, 0
	ldloc.3
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
	stloc.3
	del.fast 3
	finally.end
	except.jump 1, 0
	finally.end
	ldloc.1
	ret
	
add_method: ;protocol/ujsonrpc.py
	ldloc.2
	ldloc.0
	attr methods
	ldloc.1
	MP_BC_STORE_SUBSCR
	none
	ret
	
clear_methods: ;protocol/ujsonrpc.py
	ldloc.0
	attr methods
	method clear
	call.meth 0
	pop
	none
	ret
	
emit: ;protocol/ujsonrpc.py
	ldloc.0
	attr _stream
	method write
	glbl _METHOD_PREFIX
	call.meth 1
	pop
	glbl ujson
	method dump
	ldloc.1
	ldloc.0
	attr _stream
	call.meth 2
	pop
	ldloc.0
	attr _stream
	method write
	glbl _PARAMS
	call.meth 1
	pop
	glbl ujson
	method dump
	ldloc.2
	ldloc.0
	attr _stream
	call.meth 2
	pop
	ldloc.0
	attr _stream
	method write
	glbl _SUFFIX
	call.meth 1
	pop
	none
	ret
	
call: ;protocol/ujsonrpc.py
	glbl urandom
	method getrandbits
	144
	call.meth 1
	stloc.4
	ldloc.3
	ldloc.0
	attr pending
	ldloc.4
	MP_BC_STORE_SUBSCR
	ldloc.0
	attr _stream
	method write
	glbl _METHOD_PREFIX
	call.meth 1
	pop
	glbl ujson
	method dump
	ldloc.1
	ldloc.0
	attr _stream
	call.meth 2
	pop
	ldloc.0
	attr _stream
	method write
	glbl _PARAMS
	call.meth 1
	pop
	glbl ujson
	method dump
	ldloc.2
	ldloc.0
	attr _stream
	call.meth 2
	pop
	ldloc.0
	attr _stream
	method write
	glbl _ID
	call.meth 1
	pop
	glbl ujson
	method dump
	ldloc.4
	ldloc.0
	attr _stream
	call.meth 2
	pop
	ldloc.0
	attr _stream
	method write
	glbl _SUFFIX
	call.meth 1
	pop
	ldloc.4
	ret
	
cancel_call: ;protocol/ujsonrpc.py
	ldloc.1
	ldloc.0
	attr pending
	in
	bfalse 14
	ldloc.0
	attr pending
	method pop
	ldloc.1
	call.meth 1
	none
	call 1
	pop
	none
	ret
	
JSONRPC: ;protocol/ujsonrpc.py
	loadname __name__
	st.name __module__
	str JSONRPC
	st.name __qualname__
	map 0
	st.name methods
	map 0
	st.name pending
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
	st.name parse_chunk
	mkfun 4
	st.name parse_buffer
	mkfun 5
	st.name resume_suspended_msg
	loadname NO_RESPONSE
	tuple 1
	null
	mkfun.defargs 6
	st.name reply
	mkfun 7
	st.name error
	mkfun 8
	st.name _handle_message
	mkfun 9
	st.name suspend_current_message
	mkfun 10
	st.name _pop_suspend_message
	mkfun 11
	st.name add_method
	mkfun 12
	st.name clear_methods
	none
	tuple 1
	null
	mkfun.defargs 13
	st.name emit
	mkfun 14
	st.name call
	mkfun 15
	st.name cancel_call
	none
	ret
	
<module>: ;protocol/ujsonrpc.py
	128
	str b2a_base64
	tuple 1
	import.nm ubinascii
	import.from b2a_base64
	st.name b2a_base64
	pop
	128
	none
	import.nm ujson
	st.name ujson
	128
	none
	import.nm urandom
	st.name urandom
	128
	none
	import.nm uos
	st.name uos
	128
	str ENOENT
	tuple 1
	import.nm uerrno
	import.from ENOENT
	st.name ENOENT
	pop
	constobj 0
	st.name _SUSPENDED_MSG_PATH_
	constobj 1
	st.name _METHOD_PREFIX
	constobj 2
	st.name _ID_PREFIX
	constobj 3
	st.name _ERROR
	constobj 4
	st.name _PARAMS
	constobj 5
	st.name _RESPONSE
	constobj 6
	st.name _ID
	constobj 7
	st.name _SUFFIX
	constobj 8
	st.name _CARRIAGE_RETURN
	map 0
	st.name NO_RESPONSE
	buildclass
	mkfun 9
	str JSONRPC
	call 2
	st.name JSONRPC
	none
	ret
	