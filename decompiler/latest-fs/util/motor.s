dir_to_speed: ;util/motor.py
	ldloc.1
	constobj 2
	str ccw
	str 1
	list 3
	in
	bfalse 3
	ldloc.0
	neg
	ret
	ldloc.0
	ret
	
clamp_speed: ;util/motor.py
	glbl min
	int 128, 100
	glbl max
	int 255, 28
	ldloc.0
	call 2
	call 2
	ret
	
clamp_power: ;util/motor.py
	glbl min
	int 128, 100
	glbl max
	int 255, 28
	ldloc.0
	call 2
	call 2
	ret
	
<module>: ;util/motor.py
	mkfun 0
	st.name dir_to_speed
	mkfun 1
	st.name clamp_speed
	mkfun 2
	st.name clamp_power
	none
	ret
	