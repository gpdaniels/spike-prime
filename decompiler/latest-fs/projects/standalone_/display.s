__init__: ;projects/standalone_/display.py
	ldloc.1
	ldloc.0
	st.attr index
	glbl AnimationController
	ldloc.0
	ldloc.2
	call 2
	ldloc.0
	st.attr animation
	glbl SingleSensorAnimation
	call 0
	ldloc.0
	st.attr sensor_animation
	glbl SingleActuatorAnimation
	call 0
	ldloc.0
	st.attr actuator_animation
	glbl SensorActuatorAnimation
	call 0
	ldloc.0
	st.attr sensor_actuator_animation
	none
	ret
	
draw: ;projects/standalone_/display.py
	glbl enumerate
	ldloc.1
	none
	133
	slice 2
	MP_BC_LOAD_SUBSCR
	call 1
	ld.iterstack
	for.iter 32, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.2
	stloc.3
	ldloc.3
	none
	is
	not
	bfalse 18
	glbl hub
	attr display
	method pixel
	ldloc.2
	ldloc.0
	attr index
	ldloc.3
	call.meth 3
	pop
	jmp -35
	none
	ret
	
clear: ;projects/standalone_/display.py
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	method draw
	128
	128
	128
	128
	128
	call.meth 5
	pop
	none
	ret
	
advertise_ports: ;projects/standalone_/display.py
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	method draw
	137
	128
	128
	128
	137
	call.meth 5
	pop
	none
	ret
	
sensor_left: ;projects/standalone_/display.py
	ldloc.1
	128
	ne
	bfalse 27
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	method draw
	glbl _pct_to_pixels
	ldloc.1
	call 1
	null
	call.kvmeth 0
	pop
	jmp 69
	ldloc.0
	attr sensor_animation
	method is_running
	call.meth 0
	btrue 57
	ldloc.0
	attr sensor_animation
	method forward
	call.meth 0
	pop
	ldloc.0
	attr sensor_animation
	method reset
	call.meth 0
	pop
	ldloc.0
	attr animation
	method start
	ldloc.0
	attr sensor_animation
	int 135, 104
	call.meth 2
	pop
	ldloc.0
	method draw
	ldloc.0
	attr sensor_animation
	attr images
	128
	MP_BC_LOAD_SUBSCR
	null
	call.kvmeth 0
	pop
	jmp 0
	none
	ret
	
sensor_right: ;projects/standalone_/display.py
	ldloc.1
	128
	ne
	bfalse 32
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	method draw
	glbl reverse_image
	glbl _pct_to_pixels
	ldloc.1
	call 1
	call 1
	null
	call.kvmeth 0
	pop
	jmp 69
	ldloc.0
	attr sensor_animation
	method is_running
	call.meth 0
	btrue 57
	ldloc.0
	attr sensor_animation
	method backward
	call.meth 0
	pop
	ldloc.0
	attr sensor_animation
	method reset
	call.meth 0
	pop
	ldloc.0
	attr animation
	method start
	ldloc.0
	attr sensor_animation
	int 135, 104
	call.meth 2
	pop
	ldloc.0
	method draw
	ldloc.0
	attr sensor_animation
	attr images
	128
	MP_BC_LOAD_SUBSCR
	null
	call.kvmeth 0
	pop
	jmp 0
	none
	ret
	
actuator_left: ;projects/standalone_/display.py
	ldloc.0
	method draw
	ldloc.1
	bfalse 4
	134
	jmp 1
	137
	call.meth 1
	pop
	ldloc.0
	attr actuator_animation
	method is_running
	call.meth 0
	btrue 34
	ldloc.0
	attr actuator_animation
	method forward
	call.meth 0
	pop
	ldloc.0
	attr actuator_animation
	method reset
	call.meth 0
	pop
	ldloc.0
	attr animation
	method start
	ldloc.0
	attr actuator_animation
	call.meth 1
	pop
	none
	ret
	
actuator_right: ;projects/standalone_/display.py
	ldloc.0
	method draw
	none
	none
	none
	none
	ldloc.1
	bfalse 4
	134
	jmp 1
	137
	call.meth 5
	pop
	ldloc.0
	attr actuator_animation
	method is_running
	call.meth 0
	btrue 34
	ldloc.0
	attr actuator_animation
	method backward
	call.meth 0
	pop
	ldloc.0
	attr actuator_animation
	method reset
	call.meth 0
	pop
	ldloc.0
	attr animation
	method start
	ldloc.0
	attr actuator_animation
	call.meth 1
	pop
	none
	ret
	
sensor_sensor: ;projects/standalone_/display.py
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	method draw
	137
	137
	128
	137
	137
	call.meth 5
	pop
	none
	ret
	
actuator_actuator: ;projects/standalone_/display.py
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.1
	bfalse 15
	ldloc.0
	method draw
	134
	134
	128
	134
	134
	call.meth 5
	pop
	jmp 12
	ldloc.0
	method draw
	137
	137
	128
	137
	137
	call.meth 5
	pop
	none
	ret
	
actuator_actuator_left_button_down: ;projects/standalone_/display.py
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	method draw
	133
	133
	128
	137
	137
	call.meth 5
	pop
	none
	ret
	
actuator_actuator_right_button_down: ;projects/standalone_/display.py
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	method draw
	137
	137
	128
	133
	133
	call.meth 5
	pop
	none
	ret
	
sensor_left_actuator_right: ;projects/standalone_/display.py
	ldloc.0
	attr sensor_actuator_animation
	method is_running
	call.meth 0
	btrue 44
	ldloc.0
	attr sensor_actuator_animation
	method forward
	call.meth 0
	pop
	ldloc.0
	attr sensor_actuator_animation
	method reset
	call.meth 0
	pop
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	attr animation
	method start
	ldloc.0
	attr sensor_actuator_animation
	call.meth 1
	pop
	none
	ret
	
sensor_right_actuator_left: ;projects/standalone_/display.py
	ldloc.0
	attr sensor_actuator_animation
	method is_running
	call.meth 0
	btrue 44
	ldloc.0
	attr sensor_actuator_animation
	method backward
	call.meth 0
	pop
	ldloc.0
	attr sensor_actuator_animation
	method reset
	call.meth 0
	pop
	ldloc.0
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	attr animation
	method start
	ldloc.0
	attr sensor_actuator_animation
	call.meth 1
	pop
	none
	ret
	
DisplayController: ;projects/standalone_/display.py
	loadname __name__
	st.name __module__
	str DisplayController
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name draw
	mkfun 2
	st.name clear
	mkfun 3
	st.name advertise_ports
	mkfun 4
	st.name sensor_left
	mkfun 5
	st.name sensor_right
	mkfun 6
	st.name actuator_left
	mkfun 7
	st.name actuator_right
	mkfun 8
	st.name sensor_sensor
	mkfun 9
	st.name actuator_actuator
	mkfun 10
	st.name actuator_actuator_left_button_down
	mkfun 11
	st.name actuator_actuator_right_button_down
	mkfun 12
	st.name sensor_left_actuator_right
	mkfun 13
	st.name sensor_right_actuator_left
	none
	ret
	
_pct_to_pixels: ;projects/standalone_/display.py
	glbl abs
	ldloc.0
	call 1
	stloc.1
	ldloc.1
	int 128, 90
	qt
	bfalse 11
	137
	137
	137
	137
	137
	tuple 5
	stloc.2
	jmp 167
	ldloc.1
	int 128, 80
	qt
	bfalse 11
	137
	137
	137
	137
	134
	tuple 5
	stloc.2
	jmp 148
	ldloc.1
	int 128, 70
	qt
	bfalse 11
	137
	137
	137
	137
	128
	tuple 5
	stloc.2
	jmp 129
	ldloc.1
	int 60
	qt
	bfalse 11
	137
	137
	137
	134
	128
	tuple 5
	stloc.2
	jmp 111
	ldloc.1
	int 50
	qt
	bfalse 11
	137
	137
	137
	128
	128
	tuple 5
	stloc.2
	jmp 93
	ldloc.1
	168
	qt
	bfalse 11
	137
	137
	134
	128
	128
	tuple 5
	stloc.2
	jmp 76
	ldloc.1
	158
	qt
	bfalse 11
	137
	137
	128
	128
	128
	tuple 5
	stloc.2
	jmp 59
	ldloc.1
	148
	qt
	bfalse 11
	137
	134
	128
	128
	128
	tuple 5
	stloc.2
	jmp 42
	ldloc.1
	138
	qt
	bfalse 11
	137
	128
	128
	128
	128
	tuple 5
	stloc.2
	jmp 25
	ldloc.1
	128
	qt
	bfalse 11
	137
	128
	128
	128
	128
	tuple 5
	stloc.2
	jmp 8
	137
	128
	128
	128
	128
	tuple 5
	stloc.2
	ldloc.0
	128
	lt
	bfalse 12
	glbl tuple
	glbl reversed
	ldloc.2
	call 1
	call 1
	stloc.2
	ldloc.2
	ret
	
<module>: ;projects/standalone_/display.py
	128
	none
	import.nm hub
	st.name hub
	129
	str AnimationController
	str SingleSensorAnimation
	str SingleActuatorAnimation
	str SensorActuatorAnimation
	str reverse_image
	tuple 5
	import.nm animation
	import.from AnimationController
	st.name AnimationController
	import.from SingleSensorAnimation
	st.name SingleSensorAnimation
	import.from SingleActuatorAnimation
	st.name SingleActuatorAnimation
	import.from SensorActuatorAnimation
	st.name SensorActuatorAnimation
	import.from reverse_image
	st.name reverse_image
	pop
	buildclass
	mkfun 0
	str DisplayController
	loadname object
	call 3
	st.name DisplayController
	mkfun 1
	st.name _pct_to_pixels
	none
	ret
	