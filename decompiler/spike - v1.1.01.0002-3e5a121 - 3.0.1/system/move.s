<listcomp>: ;system/move.py
	list 0
	ldloc.1
	ld.iterstack
	for.iter 34, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.2
	stloc.3
	glbl set
	deref 0
	call 1
	method intersection
	glbl set
	ldloc.2
	call 1
	call.meth 1
	bfalse -28
	ldloc.2
	ldloc.3
	tuple 2
	MP_BC_STORE_COMP 20
	jmp -37
	ret
	
on_pair: ;system/move.py
	glbl str
	ldloc.1
	call 1
	method upper
	call.meth 0
	stloc.1
	glbl str
	ldloc.2
	call 1
	method upper
	call.meth 0
	stloc.2
	ldloc.1
	ldloc.2
	add
	st.deref 8
	ldloc.0
	attr _pairs
	method get
	deref 8
	call.meth 1
	stloc.3
	ldloc.3
	bfalse 11
	ldloc.3
	method is_valid
	call.meth 0
	bfalse 2
	ldloc.3
	ret
	ldloc.8
	mkclosure 3, 1
	ldloc.0
	attr _pairs
	method items
	call.meth 0
	call 1
	stloc.4
	ldloc.4
	ld.iterstack
	for.iter 22, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.5
	stloc.6
	ldloc.6
	method unpair
	call.meth 0
	pop
	ldloc.0
	attr _pairs
	ldloc.5
	null
	rot3
	MP_BC_STORE_SUBSCR
	jmp -25
	glbl PORTS
	ldloc.1
	MP_BC_LOAD_SUBSCR
	attr motor
	bfalse 36
	glbl PORTS
	ldloc.2
	MP_BC_LOAD_SUBSCR
	attr motor
	bfalse 25
	glbl PORTS
	ldloc.1
	MP_BC_LOAD_SUBSCR
	attr motor
	method pair
	glbl PORTS
	ldloc.2
	MP_BC_LOAD_SUBSCR
	attr motor
	call.meth 1
	stloc.7
	jmp 2
	none
	stloc.7
	glbl MoveWrapper
	ldloc.7
	call 1
	ldloc.0
	attr _pairs
	deref 8
	MP_BC_STORE_SUBSCR
	ldloc.0
	attr _pairs
	deref 8
	MP_BC_LOAD_SUBSCR
	ret
	
Movement: ;system/move.py
	loadname __name__
	st.name __module__
	str Movement
	st.name __qualname__
	map 0
	st.name _pairs
	mkfun 0
	st.name on_pair
	none
	ret
	
<module>: ;system/move.py
	128
	str PORTS
	tuple 1
	import.nm util.constants
	import.from PORTS
	st.name PORTS
	pop
	129
	str MoveWrapper
	tuple 1
	import.nm movewrapper
	import.from MoveWrapper
	st.name MoveWrapper
	pop
	buildclass
	mkfun 0
	str Movement
	call 2
	st.name Movement
	none
	ret
	