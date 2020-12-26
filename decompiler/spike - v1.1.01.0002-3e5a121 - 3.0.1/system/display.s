<listcomp>: ;system/display.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 38, 0
	stloc.1
	160
	glbl ord
	ldloc.1
	call 1
	dup
	rot3
	le
	bfalse.pop 7
	int 128, 126
	lt
	jmp 2
	rot
	pop
	bfalse 4
	ldloc.1
	jmp 3
	str ?
	MP_BC_STORE_COMP 20
	jmp -41
	ret
	
sanitize: ;system/display.py
	mkfun 1
	glbl str
	ldloc.0
	call 1
	call 1
	stloc.1
	str 
	method join
	ldloc.1
	call.meth 1
	ret
	
__init__: ;system/display.py
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	glbl hub
	attr display
	attr callback
	call.meth 1
	pop
	none
	ret
	
show: ;system/display.py
	ldloc.0
	method _register
	ldloc.7
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	ldloc.1
	str wait
	ldloc.5
	str clear
	ldloc.2
	str delay
	ldloc.3
	str fade
	ldloc.4
	str loop
	ldloc.6
	call.meth 138, 1
	pop
	none
	ret
	
show_async: ;system/display.py
	ldloc.0
	method _register
	call.meth 0
	stloc.7
	glbl hub
	attr display
	method show
	ldloc.1
	str wait
	ldloc.5
	str clear
	ldloc.2
	str delay
	ldloc.3
	str fade
	ldloc.4
	str loop
	ldloc.6
	call.meth 138, 1
	pop
	ldloc.0
	method await_callback
	ldloc.7
	call.meth 1
	ld.iter
	none
	yieldfrom
	ret
	
after_clear: ;system/display.py
	glbl sanitize
	deref 1
	call 1
	stloc.4
	ldloc.4
	bfalse 71
	glbl len
	ldloc.4
	call 1
	129
	eq
	bfalse 30
	deref 0
	method show
	ldloc.4
	str fade
	129
	str clear
	false
	str delay
	128
	str callback
	deref 2
	call.meth 136, 1
	pop
	jmp 27
	deref 0
	method show
	str  
	ldloc.4
	add
	str  
	add
	str fade
	132
	str callback
	deref 2
	call.meth 132, 1
	pop
	jmp 8
	deref 2
	glbl SUCCESS
	call 1
	pop
	none
	ret
	
write: ;system/display.py
	ldloc.0
	ldloc.1
	ldloc.2
	mkclosure 3, 3
	stloc.3
	deref 0
	method clear
	str callback
	ldloc.3
	call.meth 130, 0
	pop
	none
	ret
	
write_async: ;system/display.py
	glbl sanitize
	ldloc.1
	call 1
	stloc.2
	ldloc.0
	method clear
	call.meth 0
	pop
	ldloc.2
	bfalse 59
	glbl len
	ldloc.2
	call 1
	129
	eq
	bfalse 24
	ldloc.0
	method show_async
	ldloc.2
	str fade
	129
	str clear
	false
	str delay
	128
	call.meth 134, 1
	ld.iter
	none
	yieldfrom
	ret
	ldloc.0
	method show_async
	str  
	ldloc.2
	add
	str  
	add
	str fade
	132
	call.meth 130, 1
	ld.iter
	none
	yieldfrom
	ret
	glbl SUCCESS
	ret
	
pixel: ;system/display.py
	ldloc.0
	method _register
	call.meth 0
	pop
	glbl hub
	attr display
	method pixel
	ldloc.1
	ldloc.2
	ldloc.3
	call.meth 3
	pop
	none
	ret
	
clear: ;system/display.py
	ldloc.0
	method _register
	ldloc.1
	call.meth 1
	pop
	glbl hub
	attr display
	method clear
	call.meth 0
	pop
	none
	ret
	
DisplayWrapper: ;system/display.py
	loadname __name__
	st.name __module__
	str DisplayWrapper
	st.name __qualname__
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	false
	int 131, 116
	128
	false
	false
	none
	tuple 6
	null
	mkfun.defargs 1
	st.name show
	false
	int 131, 116
	128
	false
	false
	tuple 5
	null
	mkfun.defargs 2
	st.name show_async
	none
	tuple 1
	null
	mkfun.defargs 3
	st.name write
	mkfun 4
	st.name write_async
	mkfun 5
	st.name pixel
	none
	tuple 1
	null
	mkfun.defargs 6
	st.name clear
	ldloc.0
	ret
	
<module>: ;system/display.py
	128
	none
	import.nm hub
	st.name hub
	128
	str SUCCESS
	tuple 1
	import.nm util.constants
	import.from SUCCESS
	st.name SUCCESS
	pop
	129
	str AbstractWrapper
	tuple 1
	import.nm abstractwrapper
	import.from AbstractWrapper
	st.name AbstractWrapper
	pop
	mkfun 0
	st.name sanitize
	buildclass
	mkfun 1
	str DisplayWrapper
	loadname AbstractWrapper
	call 3
	st.name DisplayWrapper
	none
	ret
	