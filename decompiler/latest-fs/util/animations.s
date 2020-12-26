chain_animations: ;util/animations.py
	ldloc.0
	ld.iterstack
	for.iter 9, 0
	stloc.1
	ldloc.1
	ld.iter
	none
	yieldfrom
	pop
	jmp -12
	none
	ret
	
shift_out_to_left: ;util/animations.py
	glbl DISPLAY_WIDTH
	129
	add
	128
	jmp 16
	dup
	stloc.1
	glbl Image
	method shift_left
	ldloc.0
	ldloc.1
	call.meth 2
	yield
	pop
	129
	add.in
	dup2
	rot
	lt
	btrue -22
	pop
	pop
	none
	ret
	
shift_out_to_right: ;util/animations.py
	glbl DISPLAY_WIDTH
	129
	add
	128
	jmp 16
	dup
	stloc.1
	glbl Image
	method shift_right
	ldloc.0
	ldloc.1
	call.meth 2
	yield
	pop
	129
	add.in
	dup2
	rot
	lt
	btrue -22
	pop
	pop
	none
	ret
	
shift_out_to_top: ;util/animations.py
	glbl DISPLAY_WIDTH
	129
	add
	128
	jmp 16
	dup
	stloc.1
	glbl Image
	method shift_up
	ldloc.0
	ldloc.1
	call.meth 2
	yield
	pop
	129
	add.in
	dup2
	rot
	lt
	btrue -22
	pop
	pop
	none
	ret
	
shift_out_to_bottom: ;util/animations.py
	glbl DISPLAY_WIDTH
	129
	add
	128
	jmp 16
	dup
	stloc.1
	glbl Image
	method shift_down
	ldloc.0
	ldloc.1
	call.meth 2
	yield
	pop
	129
	add.in
	dup2
	rot
	lt
	btrue -22
	pop
	pop
	none
	ret
	
shift_in_from_left: ;util/animations.py
	glbl reversed
	glbl range
	glbl DISPLAY_WIDTH
	129
	add
	call 1
	call 1
	ld.iterstack
	for.iter 16, 0
	stloc.1
	glbl Image
	method shift_left
	ldloc.0
	ldloc.1
	call.meth 2
	yield
	pop
	jmp -19
	none
	ret
	
shift_in_from_right: ;util/animations.py
	glbl reversed
	glbl range
	glbl DISPLAY_WIDTH
	129
	add
	call 1
	call 1
	ld.iterstack
	for.iter 16, 0
	stloc.1
	glbl Image
	method shift_right
	ldloc.0
	ldloc.1
	call.meth 2
	yield
	pop
	jmp -19
	none
	ret
	
shift_in_from_top: ;util/animations.py
	glbl reversed
	glbl range
	glbl DISPLAY_WIDTH
	129
	add
	call 1
	call 1
	ld.iterstack
	for.iter 16, 0
	stloc.1
	glbl Image
	method shift_up
	ldloc.0
	ldloc.1
	call.meth 2
	yield
	pop
	jmp -19
	none
	ret
	
shift_in_from_bottom: ;util/animations.py
	glbl reversed
	glbl range
	glbl DISPLAY_WIDTH
	129
	add
	call 1
	call 1
	ld.iterstack
	for.iter 16, 0
	stloc.1
	glbl Image
	method shift_down
	ldloc.0
	ldloc.1
	call.meth 2
	yield
	pop
	jmp -19
	none
	ret
	
shift_in_from_bottom_left: ;util/animations.py
	glbl reversed
	glbl range
	glbl DISPLAY_WIDTH
	129
	add
	call 1
	call 1
	ld.iterstack
	for.iter 25, 0
	stloc.1
	glbl Image
	method shift_left
	glbl Image
	method shift_down
	ldloc.0
	ldloc.1
	call.meth 2
	ldloc.1
	call.meth 2
	yield
	pop
	jmp -28
	none
	ret
	
shift_in_from_top_right: ;util/animations.py
	glbl reversed
	glbl range
	glbl DISPLAY_WIDTH
	129
	add
	call 1
	call 1
	ld.iterstack
	for.iter 25, 0
	stloc.1
	glbl Image
	method shift_right
	glbl Image
	method shift_up
	ldloc.0
	ldloc.1
	call.meth 2
	ldloc.1
	call.meth 2
	yield
	pop
	jmp -28
	none
	ret
	
shift_left: ;util/animations.py
	glbl chain_animations
	glbl shift_out_to_left
	ldloc.0
	call 1
	glbl shift_in_from_right
	ldloc.1
	call 1
	call 2
	ret
	
shift_right: ;util/animations.py
	glbl chain_animations
	glbl shift_out_to_right
	ldloc.0
	call 1
	glbl shift_in_from_left
	ldloc.1
	call 1
	call 2
	ret
	
streaming_animation: ;util/animations.py
	glbl hub
	method Image
	constobj 0
	call.meth 1
	stloc.0
	glbl hub
	method Image
	constobj 1
	call.meth 1
	stloc.1
	glbl hub
	method Image
	constobj 2
	call.meth 1
	stloc.2
	glbl tuple
	glbl chain_animations
	glbl shift_in_from_bottom_left
	ldloc.0
	call 1
	glbl shift_in_from_top_right
	ldloc.1
	call 1
	glbl shift_in_from_bottom_left
	ldloc.2
	call 1
	call 3
	call 1
	ldloc.2
	tuple 1
	add
	ret
	
<genexpr>: ;util/animations.py
	null
	ldloc.0
	null
	null
	for.iter 7, 0
	stloc.1
	ldloc.1
	yield
	pop
	jmp -10
	none
	ret
	
download_animation: ;util/animations.py
	glbl hub
	method Image
	constobj 0
	call.meth 1
	stloc.0
	glbl hub
	method Image
	constobj 1
	call.meth 1
	glbl hub
	method Image
	constobj 2
	call.meth 1
	tuple 2
	stloc.1
	glbl list
	glbl chain_animations
	glbl shift_in_from_top
	ldloc.0
	call 1
	mkfun 3
	ldloc.1
	ld.iter
	call 1
	call 2
	call 1
	stloc.2
	ldloc.2
	ldloc.2
	none
	none
	127
	slice 3
	MP_BC_LOAD_SUBSCR
	add
	ret
	
bootup_animation: ;util/animations.py
	glbl hub
	method led
	call.meth 0
	stloc.0
	int 128, 100
	jmp 31
	dup
	stloc.1
	glbl hub
	method led
	glbl color_percentage
	ldloc.0
	ldloc.1
	call 2
	null
	call.kvmeth 0
	pop
	glbl utime
	method sleep_ms
	158
	call.meth 1
	pop
	118
	add.in
	dup
	128
	qt
	btrue -37
	pop
	glbl hub
	method led
	glbl BLACK
	null
	call.kvmeth 0
	pop
	glbl hub
	attr sound
	method play
	constobj 0
	int 128, 253, 0
	call.meth 2
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	128
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	153
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	129
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	int 128, 82
	call.meth 132, 1
	pop
	glbl utime
	method sleep_ms
	int 129, 32
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	130
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	143
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	131
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	int 128, 64
	call.meth 132, 1
	pop
	glbl utime
	method sleep_ms
	int 129, 12
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	132
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	137
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	133
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	int 49
	call.meth 132, 1
	pop
	glbl utime
	method sleep_ms
	int 128, 110
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	134
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	134
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	135
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	int 52
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	136
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	132
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	137
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	173
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	138
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	169
	call.meth 132, 1
	pop
	glbl utime
	method sleep_ms
	int 128, 80
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	139
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	165
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	140
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	162
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	141
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	159
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	142
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	157
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	143
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	155
	call.meth 132, 1
	pop
	glbl utime
	method sleep_ms
	int 60
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	144
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	153
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	145
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	151
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	146
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	149
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	147
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	147
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	148
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	145
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	149
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	143
	call.meth 132, 1
	pop
	glbl utime
	method sleep_ms
	int 60
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	150
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	142
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	151
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	141
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	152
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	140
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	153
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	139
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	154
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	138
	call.meth 132, 1
	pop
	glbl utime
	method sleep_ms
	int 50
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	155
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	137
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	156
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	136
	call.meth 132, 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	157
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	136
	call.meth 132, 1
	pop
	glbl utime
	method sleep_ms
	148
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	glbl BOOTUP_FRAMES
	158
	MP_BC_LOAD_SUBSCR
	str fade
	130
	str delay
	int 129, 72
	call.meth 132, 1
	pop
	glbl utime
	method sleep_ms
	143
	call.meth 1
	pop
	glbl hub
	attr display
	method show
	glbl hub
	method Image
	constobj 1
	call.meth 1
	str fade
	130
	str wait
	false
	str delay
	int 130, 44
	call.meth 134, 1
	pop
	128
	jmp 33
	dup
	stloc.1
	glbl hub
	method led
	glbl color_percentage
	glbl DIM_WHITE
	ldloc.1
	call 2
	null
	call.kvmeth 0
	pop
	glbl utime
	method sleep_ms
	158
	call.meth 1
	pop
	138
	add.in
	dup
	int 128, 100
	lt
	btrue -41
	pop
	glbl hub
	method led
	glbl DIM_WHITE
	null
	call.kvmeth 0
	pop
	none
	ret
	
shutdown_animation: ;util/animations.py
	glbl hub
	attr display
	method show
	glbl SHUTDOWN_FRAMES
	str fade
	130
	str wait
	true
	str delay
	168
	call.meth 134, 1
	pop
	none
	ret
	
led_fade_to: ;util/animations.py
	glbl hub
	method led
	call.meth 0
	stloc.3
	glbl get_color_percentage
	ldloc.3
	ldloc.0
	call 2
	stloc.4
	ldloc.4
	ldloc.1
	lt
	bfalse 5
	138
	stloc.5
	jmp 13
	ldloc.4
	ldloc.1
	qt
	bfalse 5
	118
	stloc.5
	jmp 2
	none
	ret
	glbl range
	ldloc.4
	ldloc.1
	ldloc.5
	call 3
	ld.iterstack
	for.iter 45, 0
	stloc.6
	glbl hub
	method led
	glbl color_percentage
	ldloc.0
	ldloc.6
	call 2
	null
	call.kvmeth 0
	pop
	except.setup 6, 0
	ldloc.2
	yield
	pop
	except.jump 15, 0
	dup
	glbl AttributeError
	ematch
	bfalse 6
	pop
	none
	ret
	except.jump 1, 0
	finally.end
	jmp -48
	glbl hub
	method led
	glbl color_percentage
	ldloc.0
	ldloc.1
	call 2
	null
	call.kvmeth 0
	pop
	none
	ret
	
led_fade_in_out: ;util/animations.py
	except.setup 31, 0
	glbl led_fade_to
	glbl DIM_WHITE
	int 128, 100
	call 2
	ld.iter
	none
	yieldfrom
	pop
	glbl led_fade_to
	glbl DIM_WHITE
	128
	call 2
	ld.iter
	none
	yieldfrom
	pop
	except.jump 17, 0
	dup
	glbl AttributeError
	ematch
	bfalse 8
	pop
	jmp.unwind 8, undefined
	except.jump 1, 0
	finally.end
	jmp -54
	none
	ret
	
<module>: ;util/animations.py
	128
	none
	import.nm hub
	st.name hub
	128
	str Image
	tuple 1
	import.nm hub
	import.from Image
	st.name Image
	pop
	128
	none
	import.nm utime
	st.name utime
	129
	str get_color_percentage
	str color_percentage
	str DIM_WHITE
	str BLACK
	tuple 4
	import.nm color
	import.from get_color_percentage
	st.name get_color_percentage
	import.from color_percentage
	st.name color_percentage
	import.from DIM_WHITE
	st.name DIM_WHITE
	import.from BLACK
	st.name BLACK
	pop
	133
	st.name DISPLAY_WIDTH
	133
	st.name DISPLAY_HEIGHT
	mkfun 44
	st.name chain_animations
	mkfun 45
	st.name shift_out_to_left
	mkfun 46
	st.name shift_out_to_right
	mkfun 47
	st.name shift_out_to_top
	mkfun 48
	st.name shift_out_to_bottom
	mkfun 49
	st.name shift_in_from_left
	mkfun 50
	st.name shift_in_from_right
	mkfun 51
	st.name shift_in_from_top
	mkfun 52
	st.name shift_in_from_bottom
	mkfun 53
	st.name shift_in_from_bottom_left
	mkfun 54
	st.name shift_in_from_top_right
	mkfun 55
	st.name shift_left
	mkfun 56
	st.name shift_right
	mkfun 57
	st.name streaming_animation
	mkfun 58
	st.name download_animation
	loadname hub
	method Image
	constobj 0
	call.meth 1
	loadname hub
	method Image
	constobj 1
	call.meth 1
	loadname hub
	method Image
	constobj 2
	call.meth 1
	loadname hub
	method Image
	constobj 3
	call.meth 1
	loadname hub
	method Image
	constobj 4
	call.meth 1
	loadname hub
	method Image
	constobj 5
	call.meth 1
	loadname hub
	method Image
	constobj 6
	call.meth 1
	loadname hub
	method Image
	constobj 7
	call.meth 1
	loadname hub
	method Image
	constobj 8
	call.meth 1
	loadname hub
	method Image
	constobj 9
	call.meth 1
	loadname hub
	method Image
	constobj 10
	call.meth 1
	loadname hub
	method Image
	constobj 11
	call.meth 1
	loadname hub
	method Image
	constobj 12
	call.meth 1
	loadname hub
	method Image
	constobj 13
	call.meth 1
	loadname hub
	method Image
	constobj 14
	call.meth 1
	loadname hub
	method Image
	constobj 15
	call.meth 1
	loadname hub
	method Image
	constobj 16
	call.meth 1
	loadname hub
	method Image
	constobj 17
	call.meth 1
	loadname hub
	method Image
	constobj 18
	call.meth 1
	loadname hub
	method Image
	constobj 19
	call.meth 1
	loadname hub
	method Image
	constobj 20
	call.meth 1
	loadname hub
	method Image
	constobj 21
	call.meth 1
	loadname hub
	method Image
	constobj 22
	call.meth 1
	loadname hub
	method Image
	constobj 23
	call.meth 1
	loadname hub
	method Image
	constobj 24
	call.meth 1
	loadname hub
	method Image
	constobj 25
	call.meth 1
	loadname hub
	method Image
	constobj 26
	call.meth 1
	loadname hub
	method Image
	constobj 27
	call.meth 1
	loadname hub
	method Image
	constobj 28
	call.meth 1
	loadname hub
	method Image
	constobj 29
	call.meth 1
	loadname hub
	method Image
	constobj 30
	call.meth 1
	loadname hub
	method Image
	constobj 31
	call.meth 1
	loadname hub
	method Image
	constobj 32
	call.meth 1
	loadname hub
	method Image
	constobj 33
	call.meth 1
	loadname hub
	method Image
	constobj 34
	call.meth 1
	loadname hub
	method Image
	constobj 35
	call.meth 1
	loadname hub
	method Image
	constobj 36
	call.meth 1
	tuple 37
	st.name BOOTUP_FRAMES
	mkfun 59
	st.name bootup_animation
	loadname hub
	method Image
	constobj 37
	call.meth 1
	loadname hub
	method Image
	constobj 38
	call.meth 1
	loadname hub
	method Image
	constobj 39
	call.meth 1
	loadname hub
	method Image
	constobj 40
	call.meth 1
	loadname hub
	method Image
	constobj 41
	call.meth 1
	loadname hub
	method Image
	constobj 42
	call.meth 1
	loadname hub
	method Image
	constobj 43
	call.meth 1
	tuple 7
	st.name SHUTDOWN_FRAMES
	mkfun 60
	st.name shutdown_animation
	132
	tuple 1
	null
	mkfun.defargs 61
	st.name led_fade_to
	mkfun 62
	st.name led_fade_in_out
	none
	ret
	