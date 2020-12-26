to_number: ;util/scratch.py
	except.setup 55, 0
	ldloc.0
	str nan
	ne
	bfalse 9
	glbl float
	ldloc.0
	call 1
	jmp 2
	constobj 1
	stloc.1
	glbl math
	method isfinite
	ldloc.1
	call.meth 1
	btrue 3
	constobj 2
	ret
	glbl int
	ldloc.1
	call 1
	stloc.2
	ldloc.2
	ldloc.1
	eq
	bfalse 2
	ldloc.2
	ret
	ldloc.1
	ret
	except.jump 30, 0
	dup
	glbl ValueError
	ematch
	bfalse 7
	pop
	constobj 3
	ret
	except.jump 15, 0
	dup
	glbl OverflowError
	ematch
	bfalse 6
	pop
	ldloc.1
	ret
	except.jump 1, 0
	finally.end
	none
	ret
	
to_boolean: ;util/scratch.py
	glbl isinstance
	ldloc.0
	glbl bool
	call 2
	bfalse 2
	ldloc.0
	ret
	glbl isinstance
	ldloc.0
	glbl str
	call 2
	bfalse 33
	ldloc.0
	str 
	eq
	btrue 21
	ldloc.0
	str 0
	eq
	btrue 13
	ldloc.0
	method lower
	call.meth 0
	str false
	eq
	bfalse 2
	false
	ret
	true
	ret
	glbl bool
	ldloc.0
	call 1
	ret
	
is_int: ;util/scratch.py
	glbl isinstance
	ldloc.0
	glbl int
	call 2
	bfalse 2
	true
	ret
	glbl isinstance
	ldloc.0
	glbl float
	call 2
	bfalse 23
	glbl math
	method isnan
	ldloc.0
	call.meth 1
	bfalse 2
	true
	ret
	ldloc.0
	glbl int
	ldloc.0
	call 1
	eq
	ret
	glbl isinstance
	ldloc.0
	glbl bool
	call 2
	bfalse 2
	true
	ret
	glbl isinstance
	ldloc.0
	glbl str
	call 2
	bfalse 6
	str .
	ldloc.0
	in
	ret
	false
	ret
	
compare: ;util/scratch.py
	except.setup 21, 0
	glbl float
	ldloc.0
	call 1
	stloc.2
	glbl float
	ldloc.1
	call 1
	stloc.3
	ldloc.2
	ldloc.3
	sub
	ret
	except.jump 13, 0
	dup
	glbl ValueError
	ematch
	bfalse 4
	pop
	except.jump 1, 0
	finally.end
	glbl str
	ldloc.0
	call 1
	method lower
	call.meth 0
	stloc.4
	glbl str
	ldloc.1
	call 1
	method lower
	call.meth 0
	stloc.5
	ldloc.4
	ldloc.5
	qt
	ldloc.4
	ldloc.5
	lt
	sub
	ret
	
tan: ;util/scratch.py
	ldloc.0
	int 130, 104
	mod
	stloc.0
	ldloc.0
	int 253, 114
	int 128, 90
	tuple 2
	in
	bfalse 9
	glbl float
	str inf
	call 1
	ret
	ldloc.0
	int 255, 38
	int 130, 14
	tuple 2
	in
	bfalse 10
	glbl float
	str inf
	call 1
	neg
	ret
	glbl math
	method tan
	glbl math
	attr pi
	ldloc.0
	mul
	call.meth 1
	int 129, 52
	truediv
	ret
	
convert_brightness: ;util/scratch.py
	glbl clamp
	ldloc.0
	128
	int 128, 100
	call 3
	stloc.1
	glbl round
	ldloc.1
	137
	mul
	int 128, 100
	truediv
	call 1
	ret
	
adjust_brightness: ;util/scratch.py
	glbl math
	method floor
	constobj 2
	ldloc.0
	ldloc.1
	mul
	constobj 3
	truediv
	add
	call.meth 1
	stloc.2
	glbl clamp
	ldloc.2
	128
	137
	call 3
	ret
	
<genexpr>: ;util/scratch.py
	null
	ldloc.1
	null
	null
	for.iter 15, 0
	stloc.2
	deref 0
	ldloc.2
	ldloc.2
	133
	add
	slice 2
	MP_BC_LOAD_SUBSCR
	yield
	pop
	jmp -18
	none
	ret
	
partition_image_str: ;util/scratch.py
	str :
	method join
	ldloc.0
	mkclosure 1, 1
	glbl range
	128
	glbl len
	deref 0
	call 1
	133
	call 3
	ld.iter
	call 1
	call.meth 1
	ret
	
undefined: ;util/scratch.py
	str 0
	ldloc.0
	dup
	rot3
	le
	bfalse.pop 7
	str 9
	le
	jmp 2
	rot
	pop
	ret
	
convert_image: ;util/scratch.py
	ldloc.0
	method lower
	call.meth 0
	method replace
	str x
	str 9
	call.meth 2
	stloc.0
	str 
	method join
	glbl filter
	mkfun 2
	ldloc.0
	call 2
	call.meth 1
	stloc.0
	str
	method format
	ldloc.0
	call.meth 1
	none
	153
	slice 2
	MP_BC_LOAD_SUBSCR
	stloc.0
	glbl convert_animation_frame
	ldloc.0
	ldloc.1
	call 2
	ret
	
undefined: ;util/scratch.py
	list 0
	ldloc.1
	ld.iterstack
	for.iter 24, 0
	stloc.2
	glbl str
	glbl adjust_brightness
	glbl int
	ldloc.2
	call 1
	deref 0
	call 2
	call 1
	MP_BC_STORE_COMP 20
	jmp -27
	ret
	
convert_animation_frame: ;util/scratch.py
	ldloc.1
	mkclosure 2, 1
	ldloc.0
	call 1
	stloc.2
	glbl partition_image_str
	str 
	method join
	ldloc.2
	call.meth 1
	call 1
	ret
	
clamp: ;util/scratch.py
	glbl 
	glbl 
	ldloc.0
	ldloc.1
	call 2
	ldloc.2
	call 2
	ret
	
wrap_clamp: ;util/scratch.py
	ldloc.2
	ldloc.1
	sub
	129
	add
	stloc.3
	ldloc.0
	glbl math
	method floor
	ldloc.0
	ldloc.1
	sub
	ldloc.3
	truediv
	call.meth 1
	ldloc.3
	mul
	sub
	ret
	
orientation_to_number: ;util/scratch.py
	except.setup 13, 0
	glbl ORIENTATIONS
	method index
	ldloc.0
	call.meth 1
	ret
	except.jump 15, 0
	dup
	glbl ValueError
	ematch
	bfalse 6
	pop
	127
	ret
	except.jump 1, 0
	finally.end
	none
	ret
	
number_to_orientation: ;util/scratch.py
	except.setup 9, 0
	glbl ORIENTATIONS
	ldloc.0
	MP_BC_LOAD_SUBSCR
	ret
	except.jump 17, 0
	dup
	glbl IndexError
	ematch
	bfalse 8
	pop
	str up
	ret
	except.jump 1, 0
	finally.end
	none
	ret
	
undefined: ;util/scratch.py
	MP_BC_BUILD_SET 0
	ldloc.0
	ld.iterstack
	for.iter 25, 0
	stloc.1
	ldloc.1
	method upper
	call.meth 0
	str 
	in
	bfalse -17
	ldloc.1
	method upper
	call.meth 0
	MP_BC_STORE_COMP 22
	jmp -28
	ret
	
sanitize_ports: ;util/scratch.py
	glbl list
	mkfun 1
	ldloc.0
	call 1
	call 1
	stloc.1
	ldloc.1
	method sort
	call.meth 0
	pop
	ldloc.1
	ret
	
sanitize_movement_ports: ;util/scratch.py
	glbl PAIR_REGEX
	method 
	ldloc.0
	method upper
	call.meth 0
	none
	131
	slice 2
	MP_BC_LOAD_SUBSCR
	call.meth 1
	stloc.1
	ldloc.1
	bfalse 27
	ldloc.1
	method 
	129
	call.meth 1
	stloc.2
	ldloc.1
	method 
	130
	call.meth 1
	stloc.3
	ldloc.2
	ldloc.3
	ne
	bfalse 5
	ldloc.2
	ldloc.3
	tuple 2
	ret
	none
	ret
	
percent_to_int: ;util/scratch.py
	glbl round
	ldloc.0
	ldloc.1
	mul
	int 128, 100
	truediv
	call 1
	ret
	
percent_to_frequency: ;util/scratch.py
	ldloc.0
	int 128, 100
	truediv
	stloc.4
	ldloc.4
	129
	qt
	bfalse 8
	ldloc.4
	ldloc.3
	ldloc.2
	sub
	mul
	jmp 7
	ldloc.4
	ldloc.2
	ldloc.1
	sub
	mul
	ldloc.1
	add
	stloc.5
	glbl clamp
	glbl int
	ldloc.5
	call 1
	ldloc.1
	ldloc.3
	call 3
	ret
	
note_to_frequency: ;util/scratch.py
	glbl clamp
	ldloc.0
	128
	int 129, 4
	call 3
	stloc.0
	glbl math
	method pow
	130
	ldloc.0
	int 128, 69
	sub
	140
	truediv
	call.meth 2
	int 131, 56
	mul
	stloc.1
	glbl int
	ldloc.1
	call 1
	ret
	
get_variable: ;util/scratch.py
	ldloc.0
	attr 
	method get
	ldloc.2
	glbl NO_KEY
	glbl VAR_DEFAULTS
	ldloc.1
	MP_BC_LOAD_SUBSCR
	tuple 2
	call.meth 2
	MP_BC_UNPACK_SEQUENCE 2
	stloc.3
	stloc.4
	ldloc.3
	ldloc.1
	is
	btrue 8
	ldloc.3
	glbl NO_KEY
	is
	bfalse 2
	ldloc.4
	ret
	ldloc.1
	glbl NUMBER
	eq
	bfalse 7
	glbl to_number
	ldloc.4
	call 1
	ret
	ldloc.1
	glbl BOOLEAN
	eq
	bfalse 7
	glbl to_boolean
	ldloc.4
	call 1
	ret
	glbl str
	ldloc.4
	call 1
	ret
	
pitch_to_freq: ;util/scratch.py
	ldloc.0
	int 128, 100
	truediv
	stloc.4
	ldloc.2
	ldloc.4
	ldloc.4
	128
	lt
	bfalse 6
	ldloc.2
	ldloc.1
	sub
	jmp 3
	ldloc.3
	ldloc.2
	sub
	mul
	add
	stloc.5
	glbl clamp
	glbl int
	ldloc.5
	call 1
	ldloc.1
	ldloc.3
	call 3
	ret
	
<module>: ;util/scratch.py
	128
	none
	import.nm math
	st.name math
	128
	none
	import.nm ure
	st.name ure
	129
	str BOOLEAN
	str NUMBER
	str NO_KEY
	str VAR_DEFAULTS
	tuple 4
	import.nm constants
	import.from BOOLEAN
	st.name BOOLEAN
	import.from NUMBER
	st.name NUMBER
	import.from NO_KEY
	st.name NO_KEY
	import.from VAR_DEFAULTS
	st.name VAR_DEFAULTS
	pop
	mkfun 1
	st.name to_number
	mkfun 2
	st.name to_boolean
	mkfun 3
	st.name is_int
	mkfun 4
	st.name compare
	mkfun 5
	st.name tan
	mkfun 6
	st.name convert_brightness
	mkfun 7
	st.name adjust_brightness
	mkfun 8
	st.name partition_image_str
	int 128, 100
	tuple 1
	null
	mkfun.defargs 9
	st.name convert_image
	int 128, 100
	tuple 1
	null
	mkfun.defargs 10
	st.name convert_animation_frame
	128
	int 128, 100
	tuple 2
	null
	mkfun.defargs 11
	st.name clamp
	128
	int 128, 100
	tuple 2
	null
	mkfun.defargs 12
	st.name wrap_clamp
	str up
	str front
	str leftside
	str down
	str back
	str rightside
	tuple 6
	st.name ORIENTATIONS
	mkfun 13
	st.name orientation_to_number
	mkfun 14
	st.name number_to_orientation
	mkfun 15
	st.name sanitize_ports
	loadname ure
	method compile
	constobj 0
	call.meth 1
	st.name PAIR_REGEX
	mkfun 16
	st.name sanitize_movement_ports
	mkfun 17
	st.name percent_to_int
	mkfun 18
	st.name percent_to_frequency
	mkfun 19
	st.name note_to_frequency
	mkfun 20
	st.name get_variable
	mkfun 21
	st.name pitch_to_freq
	none
	ret
	