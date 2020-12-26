__init__: ;commands/motor_methods.py
	ldloc.3
	ldloc.1
	st.attr _motors
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
<lambda>: ;commands/motor_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	ldloc.2
	call.meth 2
	ret
	
handle_motor_position: ;commands/motor_methods.py
	glbl PORTS
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	MP_BC_LOAD_SUBSCR
	attr motor
	bfalse 69
	deref 0
	attr _motors
	method on_port
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	call.meth 1
	method run_to_position
	ldloc.1
	str position
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str speed
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stop
	MP_BC_LOAD_SUBSCR
	ldloc.1
	method get
	constobj 3
	call.meth 1
	ldloc.1
	method get
	constobj 4
	call.meth 1
	str callback
	ldloc.0
	ldloc.2
	mkclosure 5, 2
	call.meth 130, 6
	pop
	jmp 16
	deref 0
	attr _rpc
	method reply
	deref 2
	glbl NO_STATUS
	call.meth 2
	pop
	none
	ret
	
<lambda>: ;commands/motor_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	ldloc.2
	call.meth 2
	ret
	
handle_motor_go_direction_to_position: ;commands/motor_methods.py
	glbl PORTS
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	MP_BC_LOAD_SUBSCR
	attr motor
	bfalse 74
	deref 0
	attr _motors
	method on_port
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	call.meth 1
	method run_to_position
	ldloc.1
	str position
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str speed
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str direction
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stop
	MP_BC_LOAD_SUBSCR
	ldloc.1
	method get
	constobj 3
	call.meth 1
	ldloc.1
	method get
	constobj 4
	call.meth 1
	str callback
	ldloc.0
	ldloc.2
	mkclosure 5, 2
	call.meth 130, 7
	pop
	jmp 16
	deref 0
	attr _rpc
	method reply
	deref 2
	glbl NO_STATUS
	call.meth 2
	pop
	none
	ret
	
<lambda>: ;commands/motor_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	ldloc.2
	call.meth 2
	ret
	
handle_motor_go_to_relative_position: ;commands/motor_methods.py
	glbl PORTS
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	MP_BC_LOAD_SUBSCR
	attr motor
	bfalse 69
	deref 0
	attr _motors
	method on_port
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	call.meth 1
	method run_to_relative_position
	ldloc.1
	str position
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str speed
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stop
	MP_BC_LOAD_SUBSCR
	ldloc.1
	method get
	constobj 3
	call.meth 1
	ldloc.1
	method get
	constobj 4
	call.meth 1
	str callback
	ldloc.0
	ldloc.2
	mkclosure 5, 2
	call.meth 130, 6
	pop
	jmp 16
	deref 0
	attr _rpc
	method reply
	deref 2
	glbl NO_STATUS
	call.meth 2
	pop
	none
	ret
	
<lambda>: ;commands/motor_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	ldloc.2
	call.meth 2
	ret
	
handle_motor_run_timed: ;commands/motor_methods.py
	deref 0
	attr _motors
	method on_port
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	call.meth 1
	method run_for_time
	ldloc.1
	str time
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str speed
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stop
	MP_BC_LOAD_SUBSCR
	ldloc.1
	method get
	constobj 3
	call.meth 1
	ldloc.1
	method get
	constobj 4
	call.meth 1
	str callback
	ldloc.0
	ldloc.2
	mkclosure 5, 2
	call.meth 130, 6
	pop
	none
	ret
	
<lambda>: ;commands/motor_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	ldloc.2
	call.meth 2
	ret
	
handle_motor_run_for_degrees: ;commands/motor_methods.py
	deref 0
	attr _motors
	method on_port
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	call.meth 1
	stloc.3
	ldloc.3
	method run_for_degrees
	ldloc.1
	str degrees
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str speed
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stop
	MP_BC_LOAD_SUBSCR
	ldloc.1
	method get
	constobj 3
	call.meth 1
	ldloc.1
	method get
	constobj 4
	call.meth 1
	str callback
	ldloc.0
	ldloc.2
	mkclosure 5, 2
	call.meth 130, 6
	pop
	none
	ret
	
handle_motor_start: ;commands/motor_methods.py
	ldloc.0
	attr _motors
	method on_port
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	call.meth 1
	method run_at_speed
	ldloc.1
	str speed
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stall
	MP_BC_LOAD_SUBSCR
	ldloc.1
	method get
	constobj 3
	call.meth 1
	ldloc.1
	method get
	constobj 4
	call.meth 1
	call.meth 4
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl NO_STATUS
	call.meth 2
	pop
	none
	ret
	
handle_motor_stop: ;commands/motor_methods.py
	ldloc.0
	attr _motors
	method on_port
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	call.meth 1
	method stop
	ldloc.1
	str stop
	MP_BC_LOAD_SUBSCR
	call.meth 1
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl NO_STATUS
	call.meth 2
	pop
	none
	ret
	
handle_motor_pwm: ;commands/motor_methods.py
	ldloc.0
	attr _motors
	method on_port
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	call.meth 1
	method pwm
	ldloc.1
	str power
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str stall
	MP_BC_LOAD_SUBSCR
	call.meth 2
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl NO_STATUS
	call.meth 2
	pop
	none
	ret
	
handle_motor_set_position: ;commands/motor_methods.py
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	stloc.3
	ldloc.1
	str offset
	MP_BC_LOAD_SUBSCR
	stloc.4
	ldloc.0
	attr _motors
	method on_port
	ldloc.3
	call.meth 1
	method preset
	ldloc.4
	call.meth 1
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl NO_STATUS
	call.meth 2
	pop
	none
	ret
	
get_methods: ;commands/motor_methods.py
	map 9
	ldloc.0
	attr handle_motor_position
	constobj 1
	st.map
	ldloc.0
	attr handle_motor_go_direction_to_position
	constobj 2
	st.map
	ldloc.0
	attr handle_motor_go_to_relative_position
	constobj 3
	st.map
	ldloc.0
	attr handle_motor_run_timed
	constobj 4
	st.map
	ldloc.0
	attr handle_motor_run_for_degrees
	constobj 5
	st.map
	ldloc.0
	attr handle_motor_start
	constobj 6
	st.map
	ldloc.0
	attr handle_motor_stop
	constobj 7
	st.map
	ldloc.0
	attr handle_motor_pwm
	constobj 8
	st.map
	ldloc.0
	attr handle_motor_set_position
	constobj 9
	st.map
	ret
	
MotorMethods: ;commands/motor_methods.py
	loadname __name__
	st.name __module__
	str MotorMethods
	st.name __qualname__
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	mkfun 1
	st.name handle_motor_position
	mkfun 2
	st.name handle_motor_go_direction_to_position
	mkfun 3
	st.name handle_motor_go_to_relative_position
	mkfun 4
	st.name handle_motor_run_timed
	mkfun 5
	st.name handle_motor_run_for_degrees
	mkfun 6
	st.name handle_motor_start
	mkfun 7
	st.name handle_motor_stop
	mkfun 8
	st.name handle_motor_pwm
	mkfun 9
	st.name handle_motor_set_position
	mkfun 10
	st.name get_methods
	ldloc.0
	ret
	
<module>: ;commands/motor_methods.py
	128
	str PORTS
	str NO_STATUS
	tuple 2
	import.nm util.constants
	import.from PORTS
	st.name PORTS
	import.from NO_STATUS
	st.name NO_STATUS
	pop
	129
	str AbstractHandler
	tuple 1
	import.nm abstract_handler
	import.from AbstractHandler
	st.name AbstractHandler
	pop
	buildclass
	mkfun 0
	str MotorMethods
	loadname AbstractHandler
	call 3
	st.name MotorMethods
	none
	ret
	