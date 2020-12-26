from_port: ;projects/standalone_/devices.py
	glbl Device
	method from_device_type
	ldloc.0
	method info
	call.meth 0
	str type
	MP_BC_LOAD_SUBSCR
	ldloc.0
	ldloc.1
	ldloc.2
	call.kvmeth 2
	ret
	
from_device_type: ;projects/standalone_/devices.py
	none
	stloc.3
	ldloc.0
	136
	137
	138
	tuple 3
	in
	bfalse 11
	glbl TechnicLight
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 265
	ldloc.0
	130
	is
	bfalse 11
	glbl TrainMotor
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 248
	ldloc.0
	162
	is
	bfalse 11
	glbl TiltSensor
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 231
	ldloc.0
	163
	is
	bfalse 11
	glbl DistanceSensor
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 214
	ldloc.0
	int 62
	is
	bfalse 11
	glbl UltraSoundSensor
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 196
	ldloc.0
	165
	is
	bfalse 11
	glbl ColorSensor1
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 179
	ldloc.0
	129
	131
	139
	tuple 3
	in
	bfalse 11
	glbl OpenLoopMotorPwm
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 158
	ldloc.0
	134
	135
	140
	tuple 3
	in
	bfalse 11
	glbl OpenLoopMotorPwm
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 137
	ldloc.0
	141
	is
	bfalse 11
	glbl ClosedLoopMotorSpeed
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 120
	ldloc.0
	166
	is
	bfalse 11
	glbl ClosedLoopMotorSpeed
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 103
	ldloc.0
	174
	175
	tuple 2
	in
	bfalse 11
	glbl ClosedLoopMotorSpeed
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 83
	ldloc.0
	int 48
	int 49
	tuple 2
	in
	bfalse 11
	glbl ClosedLoopMotorSpeed
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 61
	ldloc.0
	132
	is
	bfalse 11
	glbl GenericPwm
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 44
	ldloc.0
	133
	is
	bfalse 11
	glbl TouchButton
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 27
	ldloc.0
	int 128, 64
	is
	bfalse 11
	glbl MatrixLED
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	jmp 8
	glbl GenericDevice
	ldloc.1
	ldloc.2
	call.kw 0
	stloc.3
	ldloc.3
	ret
	
__init__: ;projects/standalone_/devices.py
	ldloc.1
	ldloc.0
	st.attr port
	list 0
	ldloc.0
	st.attr modes
	none
	ldloc.0
	st.attr current_mode
	128
	ldloc.0
	st.attr value
	false
	ldloc.0
	st.attr legacy_device
	none
	ret
	
get_port: ;projects/standalone_/devices.py
	ldloc.0
	attr port
	ret
	
on_connect: ;projects/standalone_/devices.py
	ldloc.0
	method setup
	call.meth 0
	pop
	none
	ret
	
is_sensor: ;projects/standalone_/devices.py
	false
	ret
	
is_actuator: ;projects/standalone_/devices.py
	false
	ret
	
setup: ;projects/standalone_/devices.py
	none
	ret
	
set_mode: ;projects/standalone_/devices.py
	ldloc.1
	none
	is
	btrue 6
	ldloc.1
	128
	lt
	bfalse 2
	none
	ret
	ldloc.0
	attr modes
	ld.iterstack
	for.iter 19, 0
	stloc.2
	ldloc.2
	str id
	MP_BC_LOAD_SUBSCR
	ldloc.1
	is
	bfalse 5
	ldloc.2
	ldloc.0
	st.attr current_mode
	jmp -22
	ldloc.0
	attr legacy_device
	btrue 69
	ldloc.0
	method get_port
	call.meth 0
	stloc.3
	ldloc.0
	attr current_mode
	bfalse 55
	ldloc.0
	method is_actuator
	call.meth 0
	bfalse 46
	ldloc.0
	attr current_mode
	str interface
	MP_BC_LOAD_SUBSCR
	stloc.4
	ldloc.0
	method type
	call.meth 0
	glbl Type
	attr ASTAR
	is
	bfalse 21
	ldloc.4
	glbl Interface
	attr MOTOR
	is
	bfalse 10
	glbl DeviceOutputWrapper
	method reset_motor_position
	ldloc.3
	call.meth 1
	pop
	none
	ret
	
get_value: ;projects/standalone_/devices.py
	128
	ret
	
set_value: ;projects/standalone_/devices.py
	none
	ret
	
set_value_delta: ;projects/standalone_/devices.py
	ldloc.0
	method set_value
	ldloc.0
	attr value
	ldloc.1
	add
	call.meth 1
	pop
	none
	ret
	
invert: ;projects/standalone_/devices.py
	ldloc.0
	attr current_mode
	str invert
	MP_BC_LOAD_SUBSCR
	ret
	
type: ;projects/standalone_/devices.py
	ldloc.0
	attr current_mode
	str type
	MP_BC_LOAD_SUBSCR
	ret
	
scale: ;projects/standalone_/devices.py
	ldloc.0
	attr current_mode
	str max
	MP_BC_LOAD_SUBSCR
	stloc.1
	ldloc.1
	constobj 1
	qt
	bfalse 5
	constobj 2
	ldloc.1
	truediv
	ret
	constobj 3
	ret
	
Device: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str Device
	st.name __qualname__
	loadname staticmethod
	mkfun 0
	call 1
	st.name from_port
	loadname staticmethod
	mkfun 1
	call 1
	st.name from_device_type
	mkfun 2
	st.name __init__
	mkfun 3
	st.name get_port
	mkfun 4
	st.name on_connect
	mkfun 5
	st.name is_sensor
	mkfun 6
	st.name is_actuator
	mkfun 7
	st.name setup
	mkfun 8
	st.name set_mode
	mkfun 9
	st.name get_value
	mkfun 10
	st.name set_value
	mkfun 11
	st.name set_value_delta
	mkfun 12
	st.name invert
	mkfun 13
	st.name type
	mkfun 14
	st.name scale
	none
	ret
	
__init__: ;projects/standalone_/devices.py
	glbl super
	glbl GenericDevice
	ldloc.0
	call 2
	method __init__
	ldloc.1
	ldloc.2
	call.kvmeth 0
	pop
	false
	ldloc.0
	st.attr is_sensor_device
	false
	ldloc.0
	st.attr is_actuator_device
	none
	ret
	
setup: ;projects/standalone_/devices.py
	ldloc.0
	method get_port
	call.meth 0
	stloc.1
	glbl DeviceHelper
	method read_device_metadata
	ldloc.1
	call.meth 1
	ldloc.0
	st.attr modes
	ldloc.0
	method _set_device_io_type
	call.meth 0
	pop
	none
	ret
	
<genexpr>: ;projects/standalone_/devices.py
	null
	ldloc.0
	null
	null
	for.iter 11, 0
	stloc.1
	ldloc.1
	str sensor
	MP_BC_LOAD_SUBSCR
	yield
	pop
	jmp -14
	none
	ret
	
<genexpr>: ;projects/standalone_/devices.py
	null
	ldloc.0
	null
	null
	for.iter 11, 0
	stloc.1
	ldloc.1
	str actuator
	MP_BC_LOAD_SUBSCR
	yield
	pop
	jmp -14
	none
	ret
	
_set_device_io_type: ;projects/standalone_/devices.py
	glbl sum
	mkfun 1
	ldloc.0
	attr modes
	ld.iter
	call 1
	call 1
	stloc.1
	glbl sum
	mkfun 2
	ldloc.0
	attr modes
	ld.iter
	call 1
	call 1
	stloc.2
	ldloc.1
	ldloc.2
	qt
	ldloc.0
	st.attr is_sensor_device
	ldloc.0
	attr is_sensor_device
	not
	ldloc.0
	st.attr is_actuator_device
	none
	ret
	
is_sensor: ;projects/standalone_/devices.py
	ldloc.0
	attr is_sensor_device
	ret
	
is_actuator: ;projects/standalone_/devices.py
	ldloc.0
	attr is_actuator_device
	ret
	
_to_percentage: ;projects/standalone_/devices.py
	none
	stloc.2
	ldloc.1
	ldloc.0
	method scale
	call.meth 0
	mul
	stloc.3
	ldloc.0
	method type
	call.meth 0
	glbl Type
	attr A
	glbl Type
	attr ASTAR
	tuple 2
	in
	bfalse 22
	ldloc.0
	method invert
	call.meth 0
	bfalse 8
	int 128, 100
	ldloc.3
	sub
	jmp 1
	ldloc.3
	stloc.2
	jmp 157
	ldloc.0
	method type
	call.meth 0
	glbl Type
	attr D
	glbl Type
	attr DSTAR
	tuple 2
	in
	bfalse 13
	glbl DeviceHelper
	method to_discrete
	ldloc.3
	call.meth 1
	stloc.2
	jmp 120
	ldloc.0
	method type
	call.meth 0
	glbl Type
	attr R
	is
	bfalse 43
	ldloc.1
	ldloc.0
	attr value
	sub
	stloc.4
	ldloc.1
	ldloc.0
	st.attr value
	ldloc.4
	ldloc.0
	method scale
	call.meth 0
	mul
	stloc.3
	ldloc.0
	method invert
	call.meth 0
	bfalse 8
	int 128, 100
	ldloc.3
	sub
	jmp 1
	ldloc.3
	stloc.2
	jmp 61
	ldloc.0
	method type
	call.meth 0
	glbl Type
	attr RSTAR
	is
	bfalse 45
	glbl min
	int 128, 100
	glbl max
	int 255, 28
	glbl int
	ldloc.2
	call 1
	call 2
	call 2
	stloc.2
	ldloc.0
	method invert
	call.meth 0
	bfalse 8
	int 128, 100
	ldloc.3
	sub
	jmp 1
	ldloc.3
	stloc.2
	jmp 0
	ldloc.2
	ret
	
get_value: ;projects/standalone_/devices.py
	ldloc.0
	attr current_mode
	bfalse 93
	ldloc.0
	method is_sensor
	call.meth 0
	bfalse 84
	except.setup 30, 0
	ldloc.0
	method get_port
	call.meth 0
	attr device
	stloc.1
	ldloc.1
	method get
	ldloc.0
	attr current_mode
	str id
	MP_BC_LOAD_SUBSCR
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	stloc.2
	except.jump 15, 0
	dup
	glbl AttributeError
	ematch
	bfalse 6
	pop
	none
	ret
	except.jump 34, 0
	finally.end
	ldloc.2
	none
	is
	bfalse 2
	128
	ret
	ldloc.2
	ldloc.0
	attr current_mode
	str min
	MP_BC_LOAD_SUBSCR
	lt
	bfalse 2
	128
	ret
	ldloc.0
	method _to_percentage
	ldloc.2
	call.meth 1
	stloc.3
	ldloc.3
	ret
	jmp 2
	none
	ret
	none
	ret
	
set_value: ;projects/standalone_/devices.py
	ldloc.0
	attr current_mode
	bfalse 110
	ldloc.0
	method is_actuator
	call.meth 0
	bfalse 101
	ldloc.0
	attr current_mode
	str interface
	MP_BC_LOAD_SUBSCR
	stloc.2
	none
	stloc.3
	ldloc.2
	glbl Interface
	attr MOTOR
	eq
	bfalse 35
	glbl DeviceOutputWrapper
	method motor_output
	ldloc.0
	method get_port
	call.meth 0
	ldloc.0
	method type
	call.meth 0
	ldloc.0
	attr current_mode
	ldloc.0
	method scale
	call.meth 0
	ldloc.1
	call.meth 5
	stloc.3
	jmp 32
	glbl DeviceOutputWrapper
	method generic_output
	ldloc.0
	method get_port
	call.meth 0
	ldloc.0
	method type
	call.meth 0
	ldloc.0
	attr current_mode
	ldloc.0
	method scale
	call.meth 0
	ldloc.1
	call.meth 5
	stloc.3
	ldloc.3
	none
	is
	not
	bfalse 5
	ldloc.3
	ldloc.0
	st.attr value
	none
	ret
	
GenericDevice: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str GenericDevice
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name setup
	mkfun 2
	st.name _set_device_io_type
	mkfun 3
	st.name is_sensor
	mkfun 4
	st.name is_actuator
	mkfun 5
	st.name _to_percentage
	mkfun 6
	st.name get_value
	mkfun 7
	st.name set_value
	none
	ret
	
is_sensor: ;projects/standalone_/devices.py
	true
	ret
	
setup: ;projects/standalone_/devices.py
	map 8
	129
	str id
	st.map
	str DISTS
	str name
	st.map
	false
	str actuator
	st.map
	true
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	true
	str invert
	st.map
	constobj 1
	str min
	st.map
	constobj 2
	str max
	st.map
	list 1
	ldloc.0
	st.attr modes
	none
	ret
	
get_value: ;projects/standalone_/devices.py
	except.setup 23, 0
	ldloc.0
	method get_port
	call.meth 0
	attr device
	stloc.1
	ldloc.1
	method get
	129
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	stloc.2
	except.jump 15, 0
	dup
	glbl AttributeError
	ematch
	bfalse 6
	pop
	none
	ret
	except.jump 18, 0
	finally.end
	ldloc.2
	127
	none
	tuple 2
	in
	bfalse 2
	128
	ret
	int 128, 100
	ldloc.2
	sub
	ret
	none
	ret
	
UltraSoundSensor: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str UltraSoundSensor
	st.name __qualname__
	mkfun 0
	st.name is_sensor
	mkfun 1
	st.name setup
	mkfun 2
	st.name get_value
	none
	ret
	
is_sensor: ;projects/standalone_/devices.py
	true
	ret
	
setup: ;projects/standalone_/devices.py
	map 8
	128
	str id
	st.map
	str NA
	str name
	st.map
	false
	str actuator
	st.map
	true
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	constobj 1
	str min
	st.map
	constobj 2
	str max
	st.map
	stloc.1
	ldloc.0
	attr modes
	method append
	ldloc.1
	call.meth 1
	pop
	true
	ldloc.0
	st.attr legacy_device
	none
	ret
	
get_value: ;projects/standalone_/devices.py
	except.setup 30, 0
	ldloc.0
	method get_port
	call.meth 0
	attr device
	stloc.1
	ldloc.1
	method get
	128
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	ldloc.0
	method scale
	call.meth 0
	mul
	stloc.2
	except.jump 15, 0
	dup
	glbl AttributeError
	ematch
	bfalse 6
	pop
	none
	ret
	except.jump 3, 0
	finally.end
	ldloc.2
	ret
	none
	ret
	
TouchButton: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str TouchButton
	st.name __qualname__
	mkfun 0
	st.name is_sensor
	mkfun 1
	st.name setup
	mkfun 2
	st.name get_value
	none
	ret
	
is_sensor: ;projects/standalone_/devices.py
	true
	ret
	
setup: ;projects/standalone_/devices.py
	map 8
	128
	str id
	st.map
	str NA
	str name
	st.map
	false
	str actuator
	st.map
	true
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	int 255, 28
	str min
	st.map
	int 128, 100
	str max
	st.map
	stloc.1
	ldloc.0
	attr modes
	method append
	ldloc.1
	call.meth 1
	pop
	true
	ldloc.0
	st.attr legacy_device
	none
	ret
	
get_value: ;projects/standalone_/devices.py
	except.setup 23, 0
	ldloc.0
	method get_port
	call.meth 0
	attr device
	stloc.1
	ldloc.1
	method get
	128
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	stloc.2
	except.jump 15, 0
	dup
	glbl AttributeError
	ematch
	bfalse 6
	pop
	none
	ret
	except.jump 43, 0
	finally.end
	ldloc.2
	none
	is
	bfalse 5
	128
	stloc.2
	jmp 23
	126
	ldloc.2
	dup
	rot3
	le
	bfalse.pop 5
	130
	le
	jmp 2
	rot
	pop
	bfalse 5
	128
	stloc.2
	jmp 0
	ldloc.2
	173
	truediv
	int 128, 100
	mul
	ret
	none
	ret
	
TiltSensor: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str TiltSensor
	st.name __qualname__
	mkfun 0
	st.name is_sensor
	mkfun 1
	st.name setup
	mkfun 2
	st.name get_value
	none
	ret
	
is_sensor: ;projects/standalone_/devices.py
	true
	ret
	
setup: ;projects/standalone_/devices.py
	map 8
	128
	str id
	st.map
	str NA
	str name
	st.map
	false
	str actuator
	st.map
	true
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	128
	str min
	st.map
	int 128, 100
	str max
	st.map
	stloc.1
	ldloc.0
	attr modes
	method append
	ldloc.1
	call.meth 1
	pop
	true
	ldloc.0
	st.attr legacy_device
	none
	ret
	
get_value: ;projects/standalone_/devices.py
	except.setup 23, 0
	ldloc.0
	method get_port
	call.meth 0
	attr device
	stloc.1
	ldloc.1
	method get
	129
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	stloc.2
	except.jump 15, 0
	dup
	glbl AttributeError
	ematch
	bfalse 6
	pop
	none
	ret
	except.jump 18, 0
	finally.end
	ldloc.2
	127
	none
	tuple 2
	in
	bfalse 2
	128
	ret
	int 128, 100
	ldloc.2
	sub
	ret
	none
	ret
	
DistanceSensor: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str DistanceSensor
	st.name __qualname__
	mkfun 0
	st.name is_sensor
	mkfun 1
	st.name setup
	mkfun 2
	st.name get_value
	none
	ret
	
is_sensor: ;projects/standalone_/devices.py
	true
	ret
	
setup: ;projects/standalone_/devices.py
	map 8
	128
	str id
	st.map
	str NA
	str name
	st.map
	false
	str actuator
	st.map
	true
	str sensor
	st.map
	glbl Type
	attr D
	str type
	st.map
	false
	str invert
	st.map
	128
	str min
	st.map
	138
	str max
	st.map
	stloc.1
	ldloc.0
	attr modes
	method append
	ldloc.1
	call.meth 1
	pop
	true
	ldloc.0
	st.attr legacy_device
	none
	ret
	
get_value: ;projects/standalone_/devices.py
	except.setup 23, 0
	ldloc.0
	method get_port
	call.meth 0
	attr device
	stloc.1
	ldloc.1
	method get
	128
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	stloc.2
	except.jump 15, 0
	dup
	glbl AttributeError
	ematch
	bfalse 6
	pop
	none
	ret
	except.jump 22, 0
	finally.end
	ldloc.2
	none
	is
	bfalse 2
	128
	stloc.2
	ldloc.2
	ldloc.0
	attr modes
	128
	MP_BC_LOAD_SUBSCR
	str max
	MP_BC_LOAD_SUBSCR
	mul
	ret
	none
	ret
	
ColorSensor1: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str ColorSensor1
	st.name __qualname__
	mkfun 0
	st.name is_sensor
	mkfun 1
	st.name setup
	mkfun 2
	st.name get_value
	none
	ret
	
setup: ;projects/standalone_/devices.py
	map 10
	128
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	128
	str min
	st.map
	int 128, 100
	str max
	st.map
	glbl Interface
	attr PWM
	str interface
	st.map
	129
	str datasets
	st.map
	list 1
	ldloc.0
	st.attr modes
	true
	ldloc.0
	st.attr legacy_device
	none
	ret
	
is_actuator: ;projects/standalone_/devices.py
	true
	ret
	
set_value: ;projects/standalone_/devices.py
	glbl DeviceOutputWrapper
	method generic_output
	ldloc.0
	method get_port
	call.meth 0
	ldloc.0
	method type
	call.meth 0
	ldloc.0
	attr current_mode
	ldloc.0
	method scale
	call.meth 0
	ldloc.1
	call.meth 5
	stloc.2
	ldloc.2
	none
	is
	not
	bfalse 5
	ldloc.2
	ldloc.0
	st.attr value
	none
	ret
	
TechnicLight: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str TechnicLight
	st.name __qualname__
	mkfun 0
	st.name setup
	mkfun 1
	st.name is_actuator
	mkfun 2
	st.name set_value
	none
	ret
	
setup: ;projects/standalone_/devices.py
	map 10
	128
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	int 255, 28
	str min
	st.map
	int 128, 100
	str max
	st.map
	glbl Interface
	attr PWM
	str interface
	st.map
	129
	str datasets
	st.map
	list 1
	ldloc.0
	st.attr modes
	true
	ldloc.0
	st.attr legacy_device
	none
	ret
	
is_actuator: ;projects/standalone_/devices.py
	true
	ret
	
set_value: ;projects/standalone_/devices.py
	glbl DeviceOutputWrapper
	method generic_output
	ldloc.0
	method get_port
	call.meth 0
	ldloc.0
	method type
	call.meth 0
	ldloc.0
	attr current_mode
	ldloc.0
	method scale
	call.meth 0
	ldloc.1
	call.meth 5
	stloc.2
	ldloc.2
	none
	is
	not
	bfalse 5
	ldloc.2
	ldloc.0
	st.attr value
	none
	ret
	
OpenLoopMotorPwm: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str OpenLoopMotorPwm
	st.name __qualname__
	mkfun 0
	st.name setup
	mkfun 1
	st.name is_actuator
	mkfun 2
	st.name set_value
	none
	ret
	
setup: ;projects/standalone_/devices.py
	map 10
	128
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	int 255, 28
	str min
	st.map
	int 128, 100
	str max
	st.map
	glbl Interface
	attr MOTOR
	str interface
	st.map
	129
	str datasets
	st.map
	map 10
	129
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr ASTAR
	str type
	st.map
	false
	str invert
	st.map
	int 253, 24
	str min
	st.map
	int 130, 104
	str max
	st.map
	glbl Interface
	attr MOTOR
	str interface
	st.map
	129
	str datasets
	st.map
	list 2
	ldloc.0
	st.attr modes
	none
	ret
	
is_actuator: ;projects/standalone_/devices.py
	true
	ret
	
set_value: ;projects/standalone_/devices.py
	glbl DeviceOutputWrapper
	method motor_output
	ldloc.0
	method get_port
	call.meth 0
	ldloc.0
	method type
	call.meth 0
	ldloc.0
	attr current_mode
	ldloc.0
	method scale
	call.meth 0
	ldloc.1
	call.meth 5
	stloc.2
	ldloc.2
	none
	is
	not
	bfalse 5
	ldloc.2
	ldloc.0
	st.attr value
	none
	ret
	
ClosedLoopMotorSpeedPosition: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str ClosedLoopMotorSpeedPosition
	st.name __qualname__
	mkfun 0
	st.name setup
	mkfun 1
	st.name is_actuator
	mkfun 2
	st.name set_value
	none
	ret
	
setup: ;projects/standalone_/devices.py
	map 10
	128
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	int 255, 28
	str min
	st.map
	int 128, 100
	str max
	st.map
	glbl Interface
	attr MOTOR
	str interface
	st.map
	129
	str datasets
	st.map
	list 1
	ldloc.0
	st.attr modes
	none
	ret
	
is_actuator: ;projects/standalone_/devices.py
	true
	ret
	
set_value: ;projects/standalone_/devices.py
	glbl DeviceOutputWrapper
	method motor_output
	ldloc.0
	method get_port
	call.meth 0
	ldloc.0
	method type
	call.meth 0
	ldloc.0
	attr current_mode
	ldloc.0
	method scale
	call.meth 0
	ldloc.1
	call.meth 5
	stloc.2
	ldloc.2
	none
	is
	not
	bfalse 5
	ldloc.2
	ldloc.0
	st.attr value
	none
	ret
	
ClosedLoopMotorSpeed: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str ClosedLoopMotorSpeed
	st.name __qualname__
	mkfun 0
	st.name setup
	mkfun 1
	st.name is_actuator
	mkfun 2
	st.name set_value
	none
	ret
	
setup: ;projects/standalone_/devices.py
	map 10
	128
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	int 255, 28
	str min
	st.map
	int 128, 100
	str max
	st.map
	glbl Interface
	attr PWM
	str interface
	st.map
	129
	str datasets
	st.map
	map 10
	129
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr RSTAR
	str type
	st.map
	false
	str invert
	st.map
	int 255, 28
	str min
	st.map
	int 128, 100
	str max
	st.map
	glbl Interface
	attr PWM
	str interface
	st.map
	129
	str datasets
	st.map
	list 2
	ldloc.0
	st.attr modes
	true
	ldloc.0
	st.attr legacy_device
	none
	ret
	
is_actuator: ;projects/standalone_/devices.py
	true
	ret
	
set_value: ;projects/standalone_/devices.py
	glbl DeviceOutputWrapper
	method generic_output
	ldloc.0
	method get_port
	call.meth 0
	ldloc.0
	method type
	call.meth 0
	ldloc.0
	attr current_mode
	ldloc.0
	method scale
	call.meth 0
	ldloc.1
	call.meth 5
	stloc.2
	ldloc.2
	none
	is
	not
	bfalse 5
	ldloc.2
	ldloc.0
	st.attr value
	none
	ret
	
TrainMotor: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str TrainMotor
	st.name __qualname__
	mkfun 0
	st.name setup
	mkfun 1
	st.name is_actuator
	mkfun 2
	st.name set_value
	none
	ret
	
setup: ;projects/standalone_/devices.py
	map 10
	128
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	int 255, 28
	str min
	st.map
	int 128, 100
	str max
	st.map
	glbl Interface
	attr PWM
	str interface
	st.map
	129
	str datasets
	st.map
	map 10
	129
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr RSTAR
	str type
	st.map
	false
	str invert
	st.map
	int 255, 28
	str min
	st.map
	int 128, 100
	str max
	st.map
	glbl Interface
	attr PWM
	str interface
	st.map
	129
	str datasets
	st.map
	list 2
	ldloc.0
	st.attr modes
	true
	ldloc.0
	st.attr legacy_device
	none
	ret
	
is_actuator: ;projects/standalone_/devices.py
	true
	ret
	
set_value: ;projects/standalone_/devices.py
	glbl DeviceOutputWrapper
	method generic_output
	ldloc.0
	method get_port
	call.meth 0
	ldloc.0
	method type
	call.meth 0
	ldloc.0
	attr current_mode
	ldloc.0
	method scale
	call.meth 0
	ldloc.1
	call.meth 5
	stloc.2
	ldloc.2
	none
	is
	not
	bfalse 5
	ldloc.2
	ldloc.0
	st.attr value
	none
	ret
	
GenericPwm: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str GenericPwm
	st.name __qualname__
	mkfun 0
	st.name setup
	mkfun 1
	st.name is_actuator
	mkfun 2
	st.name set_value
	none
	ret
	
setup: ;projects/standalone_/devices.py
	map 10
	128
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr A
	str type
	st.map
	false
	str invert
	st.map
	constobj 1
	neg
	str min
	st.map
	constobj 2
	str max
	st.map
	glbl Interface
	attr MODE
	str interface
	st.map
	129
	str datasets
	st.map
	map 10
	129
	str id
	st.map
	str NA
	str name
	st.map
	true
	str actuator
	st.map
	false
	str sensor
	st.map
	glbl Type
	attr D
	str type
	st.map
	false
	str invert
	st.map
	constobj 3
	str min
	st.map
	constobj 4
	str max
	st.map
	glbl Interface
	attr MODE
	str interface
	st.map
	130
	str datasets
	st.map
	list 2
	ldloc.0
	st.attr modes
	none
	ret
	
is_actuator: ;projects/standalone_/devices.py
	true
	ret
	
set_value: ;projects/standalone_/devices.py
	glbl DeviceOutputWrapper
	method generic_output
	ldloc.0
	method get_port
	call.meth 0
	ldloc.0
	method type
	call.meth 0
	ldloc.0
	attr current_mode
	ldloc.0
	method scale
	call.meth 0
	ldloc.1
	call.meth 5
	stloc.2
	ldloc.2
	none
	is
	not
	bfalse 5
	ldloc.2
	ldloc.0
	st.attr value
	none
	ret
	
MatrixLED: ;projects/standalone_/devices.py
	loadname __name__
	st.name __module__
	str MatrixLED
	st.name __qualname__
	mkfun 0
	st.name setup
	mkfun 1
	st.name is_actuator
	mkfun 2
	st.name set_value
	none
	ret
	
<module>: ;projects/standalone_/devices.py
	128
	none
	import.nm hub
	st.name hub
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	129
	str Type
	tuple 1
	import.nm util
	import.from Type
	st.name Type
	pop
	129
	str Interface
	tuple 1
	import.nm util
	import.from Interface
	st.name Interface
	pop
	129
	str DeviceHelper
	tuple 1
	import.nm device_helper
	import.from DeviceHelper
	st.name DeviceHelper
	pop
	129
	str DeviceOutputWrapper
	tuple 1
	import.nm device_helper
	import.from DeviceOutputWrapper
	st.name DeviceOutputWrapper
	pop
	129
	st.name SID_MOTOR_LINEAR_MED
	130
	st.name SID_MOTOR_TRAIN
	131
	st.name SID_TURNTABLE_MOTOR
	132
	st.name SID_GENERIC_PWM
	133
	st.name SID_BUTTON_TOUCH
	134
	st.name SID_TECHNIC_LARGE_MOTOR
	135
	st.name SID_TECHNIC_XLARGE_MOTOR
	136
	st.name SID_TECHNIC_LIGHT
	137
	st.name SID_TECHNIC_LIGHT_2
	138
	st.name SID_TECHNIC_LIGHT_3
	139
	st.name SID_GENERIC_ACTUATOR
	140
	st.name SID_TECHNIC_ACTUATOR
	141
	st.name SID_GENERIC_PWM_2
	166
	st.name MOTOR_LINEAR_LARGE
	174
	st.name MOTOR_TECHNIC_MED
	175
	st.name MOTOR_TECHNIC_LARGE
	int 48
	st.name MOTOR_ANG_MED
	int 49
	st.name MOTOR_ANG_LARGE
	int 61
	st.name COLOR_SENSOR_2
	int 62
	st.name ULTRASOUND_SENSOR
	int 63
	st.name TOUCH_SENSOR
	int 128, 64
	st.name MATRIX_LED
	162
	st.name TILT_SENSOR
	163
	st.name DIST_SENSOR
	165
	st.name COLOR_SENSOR_1
	128
	st.name RAW
	129
	st.name PCT
	130
	st.name SI
	buildclass
	mkfun 0
	str Device
	loadname object
	call 3
	st.name Device
	buildclass
	mkfun 1
	str GenericDevice
	loadname Device
	call 3
	st.name GenericDevice
	buildclass
	mkfun 2
	str UltraSoundSensor
	loadname Device
	call 3
	st.name UltraSoundSensor
	buildclass
	mkfun 3
	str TouchButton
	loadname Device
	call 3
	st.name TouchButton
	buildclass
	mkfun 4
	str TiltSensor
	loadname Device
	call 3
	st.name TiltSensor
	buildclass
	mkfun 5
	str DistanceSensor
	loadname Device
	call 3
	st.name DistanceSensor
	buildclass
	mkfun 6
	str ColorSensor1
	loadname Device
	call 3
	st.name ColorSensor1
	buildclass
	mkfun 7
	str TechnicLight
	loadname Device
	call 3
	st.name TechnicLight
	buildclass
	mkfun 8
	str OpenLoopMotorPwm
	loadname Device
	call 3
	st.name OpenLoopMotorPwm
	buildclass
	mkfun 9
	str ClosedLoopMotorSpeedPosition
	loadname Device
	call 3
	st.name ClosedLoopMotorSpeedPosition
	buildclass
	mkfun 10
	str ClosedLoopMotorSpeed
	loadname Device
	call 3
	st.name ClosedLoopMotorSpeed
	buildclass
	mkfun 11
	str TrainMotor
	loadname Device
	call 3
	st.name TrainMotor
	buildclass
	mkfun 12
	str GenericPwm
	loadname Device
	call 3
	st.name GenericPwm
	buildclass
	mkfun 13
	str MatrixLED
	loadname Device
	call 3
	st.name MatrixLED
	none
	ret
	