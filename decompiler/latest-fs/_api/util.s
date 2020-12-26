newSensorDisconnectedError: ;_api/util.py
	glbl RuntimeError
	constobj 0
	call 1
	ret
	
wait_for_async: ;_api/util.py
	except.setup 27, 0
	ldloc.0
	method __next__
	call.meth 0
	stloc.1
	ldloc.1
	bfalse 10
	glbl utime
	method sleep_ms
	ldloc.1
	call.meth 1
	pop
	jmp -24
	except.jump 27, 0
	dup
	glbl StopIteration
	ematch
	bfalse 18
	stloc.2
	finally.setup 6, 0
	ldloc.2
	attr value
	ret
	none
	none
	stloc.2
	del.fast 2
	finally.end
	except.jump 1, 0
	finally.end
	none
	ret
	
<module>: ;_api/util.py
	128
	none
	import.nm utime
	st.name utime
	mkfun 0
	st.name newSensorDisconnectedError
	mkfun 1
	st.name wait_for_async
	none
	ret
	