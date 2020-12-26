show_image: ;_api/lightmatrix.py
	glbl isinstance
	ldloc.1
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	except.setup 16, 0
	glbl getattr
	glbl hub
	attr Image
	ldloc.1
	call 2
	stloc.3
	except.jump 21, 0
	dup
	glbl AttributeError
	ematch
	bfalse 12
	pop
	glbl ValueError
	constobj 5
	call 1
	raiseobj
	except.jump 1, 0
	finally.end
	glbl max
	128
	ldloc.2
	int 128, 100
	truediv
	call 2
	stloc.4
	glbl isinstance
	ldloc.3
	glbl hub
	attr Image
	call 2
	bfalse 73
	ldloc.4
	129
	lt
	bfalse 67
	glbl hub
	method Image
	133
	133
	call.meth 2
	stloc.5
	128
	jmp 43
	dup
	stloc.6
	128
	jmp 28
	dup
	stloc.7
	ldloc.5
	method set_pixel
	ldloc.6
	ldloc.7
	glbl round
	ldloc.3
	method get_pixel
	ldloc.6
	ldloc.7
	call.meth 2
	ldloc.4
	mul
	call 1
	call.meth 3
	pop
	129
	add.in
	dup
	133
	lt
	btrue -34
	pop
	129
	add.in
	dup
	133
	lt
	btrue -49
	pop
	ldloc.5
	stloc.3
	glbl hub
	attr display
	method show
	ldloc.3
	call.meth 1
	pop
	none
	ret
	
set_pixel: ;_api/lightmatrix.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 5
	call 1
	raiseobj
	glbl isinstance
	ldloc.3
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 6
	call 1
	raiseobj
	ldloc.1
	128
	lt
	btrue 6
	ldloc.1
	132
	qt
	bfalse 8
	glbl ValueError
	constobj 7
	call 1
	raiseobj
	ldloc.2
	128
	lt
	btrue 6
	ldloc.2
	132
	qt
	bfalse 8
	glbl ValueError
	constobj 8
	call 1
	raiseobj
	glbl hub
	attr display
	method pixel
	ldloc.1
	ldloc.2
	glbl round
	ldloc.3
	128
	lt
	bfalse 4
	128
	jmp 15
	ldloc.3
	int 128, 100
	qt
	bfalse 6
	int 128, 100
	jmp 1
	ldloc.3
	137
	mul
	int 128, 100
	truediv
	call 1
	call.meth 3
	pop
	none
	ret
	
write: ;_api/lightmatrix.py
	glbl str
	ldloc.1
	call 1
	stloc.1
	glbl hub
	attr display
	method clear
	call.meth 0
	pop
	glbl len
	ldloc.1
	call 1
	129
	eq
	bfalse 33
	glbl hub
	attr display
	method show
	ldloc.1
	str fade
	129
	str clear
	false
	str delay
	128
	str wait
	false
	call.meth 136, 1
	pop
	jmp 50
	glbl len
	ldloc.1
	call 1
	129
	qt
	bfalse 39
	glbl hub
	attr display
	method show
	str  
	ldloc.1
	add
	str  
	add
	str delay
	int 131, 116
	str fade
	132
	str wait
	true
	call.meth 134, 1
	pop
	jmp 0
	none
	ret
	
off: ;_api/lightmatrix.py
	glbl hub
	attr display
	method clear
	call.meth 0
	pop
	none
	ret
	
LightMatrix: ;_api/lightmatrix.py
	loadname __name__
	st.name __module__
	str LightMatrix
	st.name __qualname__
	int 128, 100
	tuple 1
	null
	mkfun.defargs 0
	st.name show_image
	int 128, 100
	tuple 1
	null
	mkfun.defargs 1
	st.name set_pixel
	mkfun 2
	st.name write
	mkfun 3
	st.name off
	none
	ret
	
<module>: ;_api/lightmatrix.py
	128
	none
	import.nm hub
	st.name hub
	buildclass
	mkfun 0
	str LightMatrix
	call 2
	st.name LightMatrix
	none
	ret
	