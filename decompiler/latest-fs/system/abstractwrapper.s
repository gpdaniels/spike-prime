__init__: ;system/abstractwrapper.py
	glbl get_event_loop
	call 0
	ldloc.0
	st.attr loop
	none
	none
	none
	tuple 3
	ldloc.0
	st.attr cb
	128
	ldloc.0
	st.attr last_id
	glbl SUCCESS
	ldloc.0
	st.attr result
	128
	ldloc.0
	st.attr skip
	ldloc.1
	bfalse 8
	ldloc.1
	ldloc.0
	attr _callback
	call 1
	pop
	none
	ret
	
await_callback: ;system/abstractwrapper.py
	none
	yield
	pop
	jmp 3
	138
	yield
	pop
	ldloc.0
	attr cb
	129
	MP_BC_LOAD_SUBSCR
	ldloc.1
	eq
	bfalse 9
	ldloc.0
	attr cb
	130
	MP_BC_LOAD_SUBSCR
	btrue -23
	ldloc.0
	attr result
	ret
	
_callback: ;system/abstractwrapper.py
	ldloc.1
	ldloc.0
	st.attr result
	ldloc.0
	attr skip
	bfalse 13
	ldloc.0
	dup
	attr skip
	129
	sub.in
	rot
	st.attr skip
	none
	ret
	ldloc.0
	attr cb
	MP_BC_UNPACK_SEQUENCE 3
	stloc.2
	stloc.3
	stloc.4
	ldloc.2
	bfalse 30
	glbl callable
	ldloc.2
	call 1
	bfalse 12
	ldloc.0
	attr loop
	method call_soon
	ldloc.2
	ldloc.1
	call.meth 2
	pop
	none
	ldloc.3
	false
	tuple 3
	ldloc.0
	st.attr cb
	none
	ret
	
_register: ;system/abstractwrapper.py
	ldloc.0
	attr last_id
	129
	add
	dup
	stloc.2
	ldloc.0
	st.attr last_id
	ldloc.0
	attr cb
	128
	MP_BC_LOAD_SUBSCR
	stloc.3
	ldloc.3
	bfalse 34
	glbl callable
	ldloc.3
	call 1
	bfalse 14
	ldloc.0
	attr loop
	method call_soon
	ldloc.3
	glbl INTERRUPTED
	call.meth 2
	pop
	ldloc.0
	dup
	attr skip
	129
	add.in
	rot
	st.attr skip
	ldloc.1
	bfalse 4
	ldloc.1
	jmp 1
	true
	ldloc.2
	true
	tuple 3
	ldloc.0
	st.attr cb
	ldloc.2
	ret
	
cancel: ;system/abstractwrapper.py
	ldloc.0
	method _callback
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
AbstractWrapper: ;system/abstractwrapper.py
	loadname __name__
	st.name __module__
	str AbstractWrapper
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name await_callback
	mkfun 2
	st.name _callback
	true
	tuple 1
	null
	mkfun.defargs 3
	st.name _register
	loadname INTERRUPTED
	tuple 1
	null
	mkfun.defargs 4
	st.name cancel
	none
	ret
	
<module>: ;system/abstractwrapper.py
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	str SUCCESS
	str INTERRUPTED
	tuple 2
	import.nm util.constants
	import.from SUCCESS
	st.name SUCCESS
	import.from INTERRUPTED
	st.name INTERRUPTED
	pop
	128
	str get_event_loop
	tuple 1
	import.nm event_loop
	import.from get_event_loop
	st.name get_event_loop
	pop
	buildclass
	mkfun 0
	str AbstractWrapper
	call 2
	st.name AbstractWrapper
	none
	ret
	