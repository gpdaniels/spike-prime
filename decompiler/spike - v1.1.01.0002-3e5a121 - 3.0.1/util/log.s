cat_log: ;util/log.py
	glbl open
	glbl _LOG_FILE
	str r
	call 2
	stloc.0
	ldloc.0
	method readlines
	call.meth 0
	ld.iterstack
	for.iter 18, 0
	stloc.1
	glbl print
	ldloc.1
	str end
	str 
	call 130, 1
	pop
	jmp -21
	ldloc.0
	method close
	call.meth 0
	pop
	none
	ret
	
clear_log: ;util/log.py
	except.setup 15, 0
	glbl uos
	method unlink
	glbl _LOG_FILE
	call.meth 1
	pop
	except.jump 5, 0
	pop
	except.jump 1, 0
	finally.end
	none
	ret
	
log_to_file: ;util/log.py
	glbl _write_to_log
	glbl repr
	ldloc.0
	call 1
	str \x0a
	add
	call 1
	pop
	none
	ret
	
log_critical_error: ;util/log.py
	glbl uio
	method StringIO
	call.meth 0
	stloc.1
	glbl sys
	method print_exception
	ldloc.0
	ldloc.1
	call.meth 2
	pop
	ldloc.1
	method getvalue
	call.meth 0
	stloc.2
	glbl _write_to_log
	ldloc.2
	call 1
	pop
	none
	ret
	
_write_to_log: ;util/log.py
	glbl open
	glbl _LOG_FILE
	str w
	call 2
	stloc.1
	ldloc.1
	method write
	ldloc.0
	call.meth 1
	pop
	ldloc.1
	method write
	constobj 1
	glbl str
	glbl gc
	method mem_free
	call.meth 0
	call 1
	add
	constobj 2
	add
	glbl str
	glbl gc
	method mem_alloc
	call.meth 0
	call 1
	add
	str \x0a
	add
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
	
new_func: ;util/log.py
	glbl utime
	method ticks_us
	call.meth 0
	stloc.4
	deref 0
	ldloc.2
	ldloc.3
	call.kw 0
	stloc.5
	glbl utime
	method ticks_diff
	glbl utime
	method ticks_us
	call.meth 0
	ldloc.4
	call.meth 2
	stloc.6
	glbl timed_fn_buffer
	method append
	deref 1
	ldloc.6
	tuple 2
	call.meth 1
	pop
	ldloc.5
	ret
	
timed_function: ;util/log.py
	glbl str
	deref 0
	call 1
	st.deref 4
	ldloc.0
	ldloc.4
	mkclosure 1, 2
	stloc.3
	ldloc.3
	ret
	
<module>: ;util/log.py
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
	import.nm uio
	st.name uio
	128
	none
	import.nm uos
	st.name uos
	128
	none
	import.nm utime
	st.name utime
	constobj 0
	st.name _LOG_FILE
	mkfun 1
	st.name cat_log
	mkfun 2
	st.name clear_log
	mkfun 3
	st.name log_to_file
	mkfun 4
	st.name log_critical_error
	mkfun 5
	st.name _write_to_log
	list 0
	st.name timed_fn_buffer
	mkfun 6
	st.name timed_function
	none
	ret
	