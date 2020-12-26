dir_to_rotation: ;util/rotation.py
	ldloc.0
	constobj 1
	str ccw
	str 1
	list 3
	in
	bfalse 4
	int 255, 38
	ret
	int 128, 90
	ret
	
rotate_hub_display: ;util/rotation.py
	glbl _CURRENT_ROTATION
	ldloc.0
	add
	int 130, 104
	mod
	st.glbl _CURRENT_ROTATION
	glbl hub
	attr display
	method rotation
	ldloc.0
	call.meth 1
	pop
	none
	ret
	
rotate_hub_display_to_value: ;util/rotation.py
	ldloc.0
	str 2
	eq
	btrue 8
	ldloc.0
	str left
	eq
	bfalse 12
	glbl rotate_hub_display_to_orientation
	int 128, 90
	call 1
	pop
	jmp 62
	ldloc.0
	str 3
	eq
	btrue 8
	ldloc.0
	str right
	eq
	bfalse 12
	glbl rotate_hub_display_to_orientation
	int 130, 14
	call 1
	pop
	jmp 34
	ldloc.0
	str 4
	eq
	btrue 7
	ldloc.0
	constobj 1
	eq
	bfalse 12
	glbl rotate_hub_display_to_orientation
	int 129, 52
	call 1
	pop
	jmp 7
	glbl rotate_hub_display_to_orientation
	128
	call 1
	pop
	none
	ret
	
rotate_hub_display_to_orientation: ;util/rotation.py
	glbl _CURRENT_ROTATION
	ldloc.0
	ne
	bfalse 25
	glbl hub
	attr display
	method rotation
	int 130, 104
	glbl _CURRENT_ROTATION
	sub
	ldloc.0
	add
	call.meth 1
	pop
	ldloc.0
	st.glbl _CURRENT_ROTATION
	none
	ret
	
<module>: ;util/rotation.py
	128
	none
	import.nm hub
	st.name hub
	128
	st.glbl _CURRENT_ROTATION
	mkfun 0
	st.name dir_to_rotation
	mkfun 1
	st.name rotate_hub_display
	mkfun 2
	st.name rotate_hub_display_to_value
	mkfun 3
	st.name rotate_hub_display_to_orientation
	none
	ret
	