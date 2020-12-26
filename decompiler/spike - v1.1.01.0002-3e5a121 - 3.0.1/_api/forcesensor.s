_is_force_sensor: ;_api/forcesensor.py
	glbl is_type
	ldloc.0
	glbl LPF2_FLIPPER_FORCE
	call 2
	ret
	
_get_port_device: ;_api/forcesensor.py
	glbl PORTS
	ldloc.0
	MP_BC_LOAD_SUBSCR
	attr device
	ret
	
_is_pressed: ;_api/forcesensor.py
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method get
	130
	call.meth 1
	129
	MP_BC_LOAD_SUBSCR
	129
	eq
	ret
	
__init__: ;_api/forcesensor.py
	glbl isinstance
	ldloc.1
	glbl str
	call 2
	btrue 10
	glbl TypeError
	constobj 2
	ldloc.1
	mod
	call 1
	raiseobj
	ldloc.1
	glbl PORTS
	method keys
	call.meth 0
	in
	btrue 10
	glbl ValueError
	constobj 3
	ldloc.1
	mod
	call 1
	raiseobj
	glbl _is_force_sensor
	ldloc.1
	call 1
	btrue 10
	glbl RuntimeError
	constobj 4
	ldloc.1
	mod
	call 1
	raiseobj
	ldloc.1
	ldloc.0
	st.attr _port
	none
	ret
	
get_force_newton: ;_api/forcesensor.py
	glbl _is_force_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method get
	130
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	ret
	
get_force_percentage: ;_api/forcesensor.py
	glbl _is_force_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	glbl _get_port_device
	ldloc.0
	attr _port
	call 1
	method get
	129
	call.meth 1
	128
	MP_BC_LOAD_SUBSCR
	ret
	
is_pressed: ;_api/forcesensor.py
	glbl _is_force_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	ldloc.0
	method _is_pressed
	call.meth 0
	ret
	
wait_until_pressed: ;_api/forcesensor.py
	glbl _is_force_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	except.setup 25, 0
	ldloc.0
	method _is_pressed
	call.meth 0
	bfalse 3
	jmp 10
	glbl sleep_ms
	138
	call 1
	pop
	jmp -22
	except.jump 19, 0
	dup
	glbl AttributeError
	ematch
	bfalse 10
	pop
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	except.jump 1, 0
	finally.end
	none
	ret
	
wait_until_released: ;_api/forcesensor.py
	glbl _is_force_sensor
	ldloc.0
	attr _port
	call 1
	btrue 6
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	except.setup 25, 0
	ldloc.0
	method _is_pressed
	call.meth 0
	btrue 3
	jmp 10
	glbl sleep_ms
	138
	call 1
	pop
	jmp -22
	except.jump 19, 0
	dup
	glbl AttributeError
	ematch
	bfalse 10
	pop
	glbl newSensorDisconnectedError
	call 0
	raiseobj
	except.jump 1, 0
	finally.end
	none
	ret
	
ForceSensor: ;_api/forcesensor.py
	loadname __name__
	st.name __module__
	str ForceSensor
	st.name __qualname__
	mkfun 0
	st.name _is_pressed
	mkfun 1
	st.name __init__
	mkfun 2
	st.name get_force_newton
	mkfun 3
	st.name get_force_percentage
	mkfun 4
	st.name is_pressed
	mkfun 5
	st.name wait_until_pressed
	mkfun 6
	st.name wait_until_released
	none
	ret
	
<module>: ;_api/forcesensor.py
	128
	str sleep_ms
	tuple 1
	import.nm utime
	import.from sleep_ms
	st.name sleep_ms
	pop
	128
	str is_type
	tuple 1
	import.nm util.sensors
	import.from is_type
	st.name is_type
	pop
	128
	str PORTS
	str LPF2_FLIPPER_FORCE
	tuple 2
	import.nm util.constants
	import.from PORTS
	st.name PORTS
	import.from LPF2_FLIPPER_FORCE
	st.name LPF2_FLIPPER_FORCE
	pop
	129
	str newSensorDisconnectedError
	tuple 1
	import.nm util
	import.from newSensorDisconnectedError
	st.name newSensorDisconnectedError
	pop
	mkfun 0
	st.name _is_force_sensor
	mkfun 1
	st.name _get_port_device
	buildclass
	mkfun 2
	str ForceSensor
	call 2
	st.name ForceSensor
	none
	ret
	