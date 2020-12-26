__init__: ;_api/motionsensor.py
	none
	ldloc.0
	st.attr _last_orientation
	none
	ldloc.0
	st.attr _orientation
	none
	ldloc.0
	st.attr _gesture
	map 6
	str front
	glbl hub
	attr TOP
	st.map
	str back
	glbl hub
	attr BOTTOM
	st.map
	str up
	glbl hub
	attr FRONT
	st.map
	str down
	glbl hub
	attr BACK
	st.map
	str leftside
	glbl hub
	attr LEFT
	st.map
	str rightside
	glbl hub
	attr RIGHT
	st.map
	ldloc.0
	st.attr _orientation_dict
	map 4
	str shaken
	glbl hub
	attr motion
	attr SHAKE
	st.map
	str tapped
	glbl hub
	attr motion
	attr TAPPED
	st.map
	constobj 1
	glbl hub
	attr motion
	attr DOUBLETAPPED
	st.map
	str falling
	glbl hub
	attr motion
	attr FREEFALL
	st.map
	ldloc.0
	st.attr _gesture_dict
	none
	ret
	
_orientation_from_string: ;_api/motionsensor.py
	ldloc.0
	attr _orientation_dict
	method items
	call.meth 0
	ld.iterstack
	for.iter 15, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.2
	stloc.3
	ldloc.3
	ldloc.1
	eq
	bfalse 2
	ldloc.2
	ret
	jmp -18
	none
	ret
	
get_pitch_angle: ;_api/motionsensor.py
	glbl hub
	attr motion
	method yaw_pitch_roll
	call.meth 0
	129
	MP_BC_LOAD_SUBSCR
	ret
	
get_roll_angle: ;_api/motionsensor.py
	glbl hub
	attr motion
	method yaw_pitch_roll
	call.meth 0
	130
	MP_BC_LOAD_SUBSCR
	ret
	
get_yaw_angle: ;_api/motionsensor.py
	glbl hub
	attr motion
	method yaw_pitch_roll
	call.meth 0
	128
	MP_BC_LOAD_SUBSCR
	ret
	
reset_yaw_angle: ;_api/motionsensor.py
	glbl hub
	attr motion
	method yaw_pitch_roll
	128
	call.meth 1
	pop
	glbl sleep_ms
	int 128, 100
	call 1
	pop
	none
	ret
	
align_to_model: ;_api/motionsensor.py
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
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	ldloc.1
	ldloc.0
	attr _orientation_dict
	method values
	call.meth 0
	in
	btrue 20
	glbl ValueError
	constobj 5
	ldloc.0
	attr _orientation_dict
	method values
	call.meth 0
	tuple 1
	mod
	call 1
	raiseobj
	ldloc.2
	ldloc.0
	attr _orientation_dict
	method values
	call.meth 0
	in
	btrue 20
	glbl ValueError
	constobj 6
	ldloc.0
	attr _orientation_dict
	method values
	call.meth 0
	tuple 1
	mod
	call 1
	raiseobj
	ldloc.2
	ldloc.1
	eq
	bfalse 8
	glbl ValueError
	constobj 7
	call 1
	raiseobj
	ldloc.0
	method _orientation_from_string
	ldloc.2
	call.meth 1
	stloc.3
	ldloc.0
	method _orientation_from_string
	ldloc.1
	call.meth 1
	stloc.4
	glbl hub
	attr motion
	method align_to_model
	str top
	ldloc.3
	str front
	ldloc.4
	call.meth 132, 0
	pop
	glbl sleep_ms
	int 143, 80
	call 1
	pop
	none
	ret
	
get_orientation: ;_api/motionsensor.py
	glbl hub
	attr motion
	method orientation
	call.meth 0
	stloc.1
	ldloc.1
	none
	is
	bfalse 12
	ldloc.0
	attr _orientation_dict
	glbl hub
	attr TOP
	MP_BC_LOAD_SUBSCR
	ret
	ldloc.0
	attr _orientation_dict
	ldloc.1
	MP_BC_LOAD_SUBSCR
	ret
	
new_orientation: ;_api/motionsensor.py
	deref 0
	attr _orientation_dict
	ldloc.1
	MP_BC_LOAD_SUBSCR
	deref 0
	st.attr _orientation
	none
	ret
	
wait_for_new_orientation: ;_api/motionsensor.py
	deref 0
	method get_orientation
	call.meth 0
	deref 0
	st.attr _orientation
	deref 0
	attr _orientation
	deref 0
	st.attr _last_orientation
	ldloc.0
	mkclosure 1, 1
	stloc.1
	glbl hub
	attr motion
	method orientation
	str callback
	ldloc.1
	call.meth 130, 0
	pop
	deref 0
	attr _orientation
	deref 0
	attr _last_orientation
	ne
	bfalse 16
	deref 0
	attr _orientation
	deref 0
	st.attr _last_orientation
	deref 0
	attr _orientation
	ret
	glbl sleep_ms
	138
	call 1
	pop
	jmp -40
	none
	ret
	
get_gesture: ;_api/motionsensor.py
	glbl hub
	attr motion
	method gesture
	call.meth 0
	stloc.1
	ldloc.1
	ldloc.0
	attr _gesture_dict
	in
	bfalse 7
	ldloc.0
	attr _gesture_dict
	ldloc.1
	MP_BC_LOAD_SUBSCR
	ret
	none
	ret
	none
	ret
	
was_gesture: ;_api/motionsensor.py
	glbl isinstance
	ldloc.1
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	ldloc.1
	str shaken
	str tapped
	constobj 3
	str falling
	tuple 4
	in
	btrue 24
	glbl ValueError
	constobj 4
	str shaken
	str tapped
	constobj 5
	str falling
	tuple 4
	tuple 1
	mod
	call 1
	raiseobj
	ldloc.1
	ldloc.0
	method get_gesture
	call.meth 0
	eq
	ret
	
new_gesture: ;_api/motionsensor.py
	deref 0
	attr _gesture_dict
	ldloc.1
	MP_BC_LOAD_SUBSCR
	deref 0
	st.attr _gesture
	none
	ret
	
wait_for_new_gesture: ;_api/motionsensor.py
	none
	deref 0
	st.attr _gesture
	ldloc.0
	mkclosure 1, 1
	stloc.1
	glbl hub
	attr motion
	method gesture
	str callback
	ldloc.1
	call.meth 130, 0
	pop
	deref 0
	attr _gesture
	none
	is
	not
	bfalse 6
	deref 0
	attr _gesture
	ret
	glbl sleep_ms
	138
	call 1
	pop
	jmp -27
	none
	ret
	
MotionSensor: ;_api/motionsensor.py
	loadname __name__
	st.name __module__
	str MotionSensor
	st.name __qualname__
	mkfun 1
	st.name __init__
	mkfun 2
	st.name _orientation_from_string
	mkfun 3
	st.name get_pitch_angle
	mkfun 4
	st.name get_roll_angle
	mkfun 5
	st.name get_yaw_angle
	mkfun 6
	st.name reset_yaw_angle
	str front
	st.name FRONT
	str back
	st.name BACK
	str up
	st.name UP
	str down
	st.name DOWN
	str leftside
	st.name LEFT_SIDE
	str rightside
	st.name RIGHT_SIDE
	mkfun 7
	st.name align_to_model
	mkfun 8
	st.name get_orientation
	mkfun 9
	st.name wait_for_new_orientation
	str shaken
	st.name SHAKEN
	str tapped
	st.name TAPPED
	constobj 0
	st.name DOUBLE_TAPPED
	str falling
	st.name FALLING
	mkfun 10
	st.name get_gesture
	mkfun 11
	st.name was_gesture
	mkfun 12
	st.name wait_for_new_gesture
	none
	ret
	
<module>: ;_api/motionsensor.py
	128
	none
	import.nm hub
	st.name hub
	128
	str sleep_ms
	tuple 1
	import.nm utime
	import.from sleep_ms
	st.name sleep_ms
	pop
	buildclass
	mkfun 0
	str MotionSensor
	call 2
	st.name MotionSensor
	none
	ret
	