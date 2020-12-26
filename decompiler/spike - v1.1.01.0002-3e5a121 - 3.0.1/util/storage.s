undefined: ;util/storage.py
	glbl 
	method format
	glbl str
	ldloc.0
	call 1
	call.meth 1
	stloc.1
	glbl open
	ldloc.1
	str 
	call 2
	stloc.2
	ldloc.2
	ret
	
undefined: ;util/storage.py
	ldloc.0
	method 
	call.meth 0
	pop
	ldloc.0
	method close
	call.meth 0
	pop
	ldloc.4
	btrue 3
	map 0
	stloc.4
	ldloc.2
	ldloc.4
	str id
	MP_BC_STORE_SUBSCR
	ldloc.3
	ldloc.4
	str 
	MP_BC_STORE_SUBSCR
	glbl 
	call 0
	stloc.5
	except.setup 32, 0
	glbl uos
	method 
	glbl 
	method format
	glbl str
	ldloc.5
	ldloc.1
	MP_BC_LOAD_SUBSCR
	str id
	MP_BC_LOAD_SUBSCR
	call 1
	call.meth 1
	call.meth 1
	pop
	except.jump 21, 0
	dup
	glbl OSError
	glbl KeyError
	glbl ValueError
	tuple 3
	ematch
	bfalse 4
	pop
	except.jump 1, 0
	finally.end
	ldloc.4
	ldloc.5
	ldloc.1
	MP_BC_STORE_SUBSCR
	glbl 
	ldloc.5
	call 1
	pop
	glbl uos
	method 
	call.meth 0
	pop
	none
	ret
	
undefined: ;util/storage.py
	glbl 
	call 0
	stloc.1
	ldloc.0
	ldloc.1
	in
	bfalse 10
	ldloc.1
	ldloc.0
	MP_BC_LOAD_SUBSCR
	str 
	MP_BC_LOAD_SUBSCR
	jmp 3
	str 
	stloc.2
	ldloc.2
	bfalse 2
	ldloc.2
	ret
	str 
	ret
	
undefined: ;util/storage.py
	glbl 
	call 0
	stloc.1
	ldloc.0
	ldloc.1
	in
	bfalse 10
	ldloc.1
	ldloc.0
	MP_BC_LOAD_SUBSCR
	str type
	MP_BC_LOAD_SUBSCR
	jmp 3
	str 
	stloc.2
	ldloc.2
	bfalse 2
	ldloc.2
	ret
	glbl 
	ret
	
undefined: ;util/storage.py
	ldloc.0
	127
	eq
	bfalse 3
	constobj 2
	ret
	glbl 
	call 0
	stloc.2
	ldloc.0
	ldloc.2
	in
	bfalse 15
	glbl str
	ldloc.2
	ldloc.0
	MP_BC_LOAD_SUBSCR
	str id
	MP_BC_LOAD_SUBSCR
	call 1
	jmp 3
	str 
	stloc.3
	ldloc.3
	btrue 4
	str 
	ret
	except.setup 39, 0
	glbl 
	method format
	ldloc.3
	call.meth 1
	stloc.4
	glbl uos
	method 
	ldloc.4
	call.meth 1
	pop
	ldloc.1
	btrue 10
	glbl 
	method format
	ldloc.3
	call.meth 1
	ret
	ldloc.4
	ret
	except.jump 37, 0
	dup
	glbl OSError
	ematch
	bfalse 28
	stloc.5
	finally.setup 16, 0
	ldloc.5
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
	stloc.5
	del.fast 5
	finally.end
	except.jump 1, 0
	finally.end
	str 
	ret
	
undefined: ;util/storage.py
	glbl 
	ldloc.0
	str 
	true
	call 130, 1
	stloc.1
	false
	stloc.2
	except.setup 67, 0
	glbl 
	call 0
	stloc.3
	glbl str
	ldloc.3
	ldloc.0
	MP_BC_LOAD_SUBSCR
	str id
	MP_BC_LOAD_SUBSCR
	call 1
	str 
	add
	glbl uos
	method 
	glbl __STORAGE_PATH__
	call.meth 1
	in
	bfalse 10
	glbl uos
	method 
	ldloc.1
	call.meth 1
	pop
	ldloc.3
	method pop
	ldloc.0
	call.meth 1
	pop
	glbl 
	ldloc.3
	call 1
	pop
	true
	stloc.2
	except.jump 37, 0
	dup
	glbl OSError
	ematch
	bfalse 28
	stloc.4
	finally.setup 16, 0
	ldloc.4
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
	stloc.4
	del.fast 4
	finally.end
	except.jump 1, 0
	finally.end
	glbl uos
	method 
	call.meth 0
	pop
	ldloc.2
	ret
	
undefined: ;util/storage.py
	map 0
	ldloc.1
	ld.iterstack
	for.iter 16, 0
	stloc.2
	deref 0
	ldloc.2
	MP_BC_LOAD_SUBSCR
	glbl str
	ldloc.2
	call 1
	MP_BC_STORE_COMP 25
	jmp -19
	ret
	
undefined: ;util/storage.py
	glbl uos
	method 
	str 
	call.meth 1
	stloc.0
	map 1
	str 
	str 
	st.map
	stloc.1
	glbl int
	ldloc.0
	130
	MP_BC_LOAD_SUBSCR
	ldloc.0
	129
	MP_BC_LOAD_SUBSCR
	mul
	int 136, 0
	truediv
	call 1
	ldloc.1
	str 
	MP_BC_STORE_SUBSCR
	glbl int
	ldloc.0
	132
	MP_BC_LOAD_SUBSCR
	ldloc.0
	129
	MP_BC_LOAD_SUBSCR
	mul
	int 136, 0
	truediv
	call 1
	ldloc.1
	str 
	MP_BC_STORE_SUBSCR
	glbl int
	ldloc.0
	131
	MP_BC_LOAD_SUBSCR
	ldloc.0
	129
	MP_BC_LOAD_SUBSCR
	mul
	int 136, 0
	truediv
	call 1
	ldloc.1
	str 
	MP_BC_STORE_SUBSCR
	ldloc.1
	str 
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str 
	MP_BC_LOAD_SUBSCR
	sub
	stloc.2
	ldloc.2
	int 128, 100
	mul
	ldloc.2
	ldloc.1
	str 
	MP_BC_LOAD_SUBSCR
	add
	truediv
	ldloc.2
	int 128, 100
	mul
	ldloc.2
	ldloc.1
	str 
	MP_BC_LOAD_SUBSCR
	add
	mod
	128
	ne
	add
	ldloc.1
	str 
	MP_BC_STORE_SUBSCR
	glbl 
	call 0
	st.deref 4
	ldloc.4
	mkclosure 0, 1
	deref 4
	call 1
	stloc.3
	map 2
	ldloc.1
	str 
	st.map
	ldloc.3
	str 
	st.map
	ret
	
undefined: ;util/storage.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 11, 0
	stloc.1
	ldloc.1
	str id
	MP_BC_LOAD_SUBSCR
	MP_BC_STORE_COMP 20
	jmp -14
	ret
	
undefined: ;util/storage.py
	glbl 
	call 0
	stloc.0
	mkfun 0
	glbl list
	ldloc.0
	method values
	call.meth 0
	call 1
	call 1
	stloc.1
	glbl urandom
	method 
	144
	call.meth 1
	stloc.2
	jmp 10
	glbl urandom
	method 
	144
	call.meth 1
	stloc.2
	ldloc.2
	ldloc.1
	in
	btrue -16
	ldloc.2
	ret
	
undefined: ;util/storage.py
	glbl list
	glbl 
	call 0
	method keys
	call.meth 0
	call 1
	ret
	
undefined: ;util/storage.py
	glbl 
	ldloc.0
	str 
	true
	call 130, 1
	stloc.1
	except.setup 29, 0
	glbl open
	ldloc.1
	str 
	call 2
	stloc.2
	ldloc.2
	method read
	call.meth 0
	stloc.3
	ldloc.2
	method close
	call.meth 0
	pop
	ldloc.3
	ret
	except.jump 37, 0
	dup
	glbl OSError
	ematch
	bfalse 28
	stloc.4
	finally.setup 16, 0
	ldloc.4
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
	stloc.4
	del.fast 4
	finally.end
	except.jump 1, 0
	finally.end
	str 
	ret
	
undefined: ;util/storage.py
	except.setup 57, 0
	glbl open
	glbl LOCAL_NAME
	str 
	call 2
	with.setup 38, 0
	stloc.0
	ldloc.0
	method read
	call.meth 0
	method strip
	call.meth 0
	stloc.1
	ldloc.1
	glbl len
	glbl 
	call 1
	none
	slice 2
	MP_BC_LOAD_SUBSCR
	stloc.2
	ldloc.2
	bfalse 2
	ldloc.2
	ret
	str 
	ret
	none
	with.chleanup
	finally.end
	except.jump 9, 0
	pop
	str 
	ret
	except.jump 1, 0
	finally.end
	none
	ret
	
undefined: ;util/storage.py
	glbl open
	glbl LOCAL_NAME
	str 
	call 2
	with.setup 19, 0
	stloc.1
	ldloc.1
	method write
	glbl 
	ldloc.0
	method strip
	call.meth 0
	add
	call.meth 1
	pop
	none
	with.chleanup
	finally.end
	glbl uos
	method 
	call.meth 0
	pop
	none
	ret
	
undefined: ;util/storage.py
	ldloc.0
	ldloc.1
	eq
	bfalse 2
	false
	ret
	glbl 
	ldloc.0
	ldloc.1
	call 2
	stloc.2
	glbl 
	call 0
	stloc.3
	map 0
	stloc.4
	ldloc.3
	ld.iterstack
	for.iter 27, 0
	stloc.5
	ldloc.5
	ldloc.2
	in
	bfalse 11
	ldloc.3
	ldloc.5
	MP_BC_LOAD_SUBSCR
	ldloc.4
	ldloc.2
	ldloc.5
	MP_BC_LOAD_SUBSCR
	MP_BC_STORE_SUBSCR
	jmp 6
	ldloc.3
	ldloc.5
	MP_BC_LOAD_SUBSCR
	ldloc.4
	ldloc.5
	MP_BC_STORE_SUBSCR
	jmp -30
	glbl 
	ldloc.4
	call 1
	pop
	true
	ret
	
undefined: ;util/storage.py
	map 0
	ldloc.1
	ld.iterstack
	for.iter 11, 0
	stloc.2
	ldloc.2
	deref 0
	add
	ldloc.2
	MP_BC_STORE_COMP 25
	jmp -14
	ret
	
undefined: ;util/storage.py
	ldloc.0
	ldloc.1
	lt
	bfalse 4
	127
	jmp 1
	129
	st.deref 4
	glbl range
	deref 4
	127
	eq
	bfalse 9
	ldloc.0
	ldloc.1
	129
	add
	tuple 2
	jmp 6
	ldloc.1
	ldloc.0
	129
	add
	tuple 2
	null
	call.kw 0
	stloc.2
	ldloc.4
	mkclosure 2, 1
	ldloc.2
	call 1
	stloc.3
	ldloc.1
	ldloc.3
	ldloc.0
	MP_BC_STORE_SUBSCR
	ldloc.3
	ret
	
undefined: ;util/storage.py
	except.setup 15, 0
	glbl uos
	method 
	glbl __STORAGE_PATH__
	call.meth 1
	pop
	except.jump 37, 0
	dup
	glbl OSError
	ematch
	bfalse 28
	stloc.0
	finally.setup 16, 0
	ldloc.0
	attr args
	128
	MP_BC_LOAD_SUBSCR
	glbl EEXIST
	is
	not
	bfalse 1
	rethrow
	none
	none
	stloc.0
	del.fast 0
	finally.end
	except.jump 1, 0
	finally.end
	none
	ret
	
undefined: ;util/storage.py
	except.setup 27, 0
	glbl open
	glbl __META_PATH__
	str 
	call 2
	stloc.0
	glbl eval
	ldloc.0
	method read
	call.meth 0
	call 1
	ret
	except.jump 58, 0
	dup
	glbl OSError
	ematch
	bfalse 28
	stloc.1
	finally.setup 16, 0
	ldloc.1
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
	stloc.1
	del.fast 1
	finally.end
	except.jump 22, 0
	dup
	glbl SyntaxError
	ematch
	bfalse 13
	stloc.1
	finally.setup 1, 0
	none
	none
	stloc.1
	del.fast 1
	finally.end
	except.jump 1, 0
	finally.end
	map 0
	ret
	
undefined: ;util/storage.py
	glbl open
	glbl __META_PATH__
	str 
	call 2
	stloc.1
	ldloc.1
	method write
	glbl str
	ldloc.0
	call 1
	call.meth 1
	pop
	ldloc.1
	method 
	call.meth 0
	pop
	ldloc.1
	method close
	call.meth 0
	pop
	none
	ret
	
undefined: ;util/storage.py
	glbl open
	glbl 
	str 
	call 2
	stloc.1
	ldloc.1
	method write
	glbl str
	map 1
	ldloc.0
	str 
	st.map
	call 1
	call.meth 1
	pop
	ldloc.1
	method 
	call.meth 0
	pop
	ldloc.1
	method close
	call.meth 0
	pop
	none
	ret
	
undefined: ;util/storage.py
	map 0
	stloc.0
	except.setup 46, 0
	glbl open
	glbl 
	str 
	call 2
	stloc.1
	glbl eval
	ldloc.1
	method read
	call.meth 0
	call 1
	stloc.0
	ldloc.1
	method close
	call.meth 0
	pop
	glbl uos
	method 
	glbl 
	call.meth 1
	pop
	except.jump 37, 0
	dup
	glbl OSError
	ematch
	bfalse 28
	stloc.2
	finally.setup 16, 0
	ldloc.2
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
	stloc.2
	del.fast 2
	finally.end
	except.jump 1, 0
	finally.end
	ldloc.0
	ret
	
undefined: ;util/storage.py
	glbl ure
	method 
	str 
	ldloc.0
	call.meth 2
	stloc.1
	ldloc.1
	bfalse 13
	glbl int
	ldloc.1
	method 
	129
	call.meth 1
	call 1
	ret
	none
	ret
	
<module>: ;util/storage.py
	128
	none
	import.nm uos
	st.name uos
	128
	none
	import.nm ure
	st.name ure
	128
	none
	import.nm urandom
	st.name urandom
	128
	str EEXIST
	str ENOENT
	tuple 2
	import.nm uerrno
	import.from EEXIST
	st.name EEXIST
	import.from ENOENT
	st.name ENOENT
	pop
	129
	str LOCAL_NAME
	tuple 1
	import.nm constants
	import.from LOCAL_NAME
	st.name LOCAL_NAME
	pop
	str ./projects
	st.name __STORAGE_PATH__
	loadname __STORAGE_PATH__
	str /.slots
	add
	st.name __META_PATH__
	loadname __STORAGE_PATH__
	str /
	add
	st.name 
	loadname 
	str 
	add
	st.name 
	str 
	st.name 
	str 
	st.name 
	str 
	st.name 
	mkfun 0
	st.name 
	none
	tuple 1
	null
	mkfun.defargs 1
	st.name 
	mkfun 2
	st.name 
	mkfun 3
	st.name 
	null
	map 0
	false
	str 
	st.map
	mkfun.defargs 4
	st.name 
	mkfun 5
	st.name 
	mkfun 6
	st.name 
	mkfun 7
	st.name 
	mkfun 8
	st.name 
	mkfun 9
	st.name 
	str 
	st.name 
	mkfun 10
	st.name 
	mkfun 11
	st.name 
	mkfun 12
	st.name 
	mkfun 13
	st.name 
	mkfun 14
	st.name 
	mkfun 15
	st.name 
	mkfun 16
	st.name 
	mkfun 17
	st.name 
	mkfun 18
	st.name 
	mkfun 19
	st.name 
	loadname 
	call 0
	pop
	none
	ret
	