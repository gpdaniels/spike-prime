__init__: ;projects/standalone_/row.py
	ldloc.2
	ldloc.0
	st.attr system
	glbl DisplayController
	ldloc.1
	ldloc.2
	call 2
	ldloc.0
	st.attr display
	false
	ldloc.0
	st.attr running
	none
	ldloc.0
	st.attr adjust
	none
	ldloc.0
	st.attr heartbeat
	true
	ldloc.0
	st.attr advertise_ports
	none
	ldloc.0
	st.attr left
	none
	ldloc.0
	st.attr left_read
	128
	ldloc.0
	st.attr left_value
	none
	ldloc.0
	st.attr right
	none
	ldloc.0
	st.attr right_read
	128
	ldloc.0
	st.attr right_value
	none
	ret
	
get_opposite_device: ;projects/standalone_/row.py
	ldloc.1
	glbl HubSide
	attr LEFT
	is
	bfalse 5
	ldloc.0
	attr right
	ret
	ldloc.0
	attr left
	ret
	
on_enter: ;projects/standalone_/row.py
	true
	ldloc.0
	st.attr running
	none
	ret
	
on_exit: ;projects/standalone_/row.py
	false
	ldloc.0
	st.attr running
	ldloc.0
	attr display
	attr animation
	method stop
	call.meth 0
	pop
	ldloc.0
	attr left_read
	bfalse 15
	glbl cancel
	ldloc.0
	attr left_read
	call 1
	pop
	none
	ldloc.0
	st.attr left_read
	ldloc.0
	attr right_read
	bfalse 15
	glbl cancel
	ldloc.0
	attr right_read
	call 1
	pop
	none
	ldloc.0
	st.attr right_read
	ldloc.0
	attr adjust
	bfalse 15
	glbl cancel
	ldloc.0
	attr adjust
	call 1
	pop
	none
	ldloc.0
	st.attr adjust
	ldloc.0
	attr left
	bfalse 16
	ldloc.0
	attr left
	method set_value
	128
	call.meth 1
	pop
	none
	ldloc.0
	st.attr left
	ldloc.0
	attr right
	bfalse 16
	ldloc.0
	attr right
	method set_value
	128
	call.meth 1
	pop
	none
	ldloc.0
	st.attr right
	128
	ldloc.0
	st.attr left_value
	128
	ldloc.0
	st.attr right_value
	none
	ret
	
on_connected_left: ;projects/standalone_/row.py
	ldloc.1
	ldloc.0
	st.attr left
	ldloc.1
	method is_sensor
	call.meth 0
	bfalse 31
	glbl read_sensor_input
	ldloc.1
	ldloc.0
	attr on_left_value_changed
	call 2
	ldloc.0
	st.attr left_read
	ldloc.0
	attr system
	attr loop
	method call_soon
	ldloc.0
	attr left_read
	call.meth 1
	pop
	ldloc.1
	method is_actuator
	call.meth 0
	bfalse 11
	ldloc.1
	method set_value
	ldloc.0
	attr right_value
	call.meth 1
	pop
	ldloc.0
	method _update_display
	call.meth 0
	pop
	none
	ret
	
on_connected_right: ;projects/standalone_/row.py
	ldloc.1
	ldloc.0
	st.attr right
	ldloc.1
	method is_sensor
	call.meth 0
	bfalse 31
	glbl read_sensor_input
	ldloc.1
	ldloc.0
	attr on_right_value_changed
	call 2
	ldloc.0
	st.attr right_read
	ldloc.0
	attr system
	attr loop
	method call_soon
	ldloc.0
	attr right_read
	call.meth 1
	pop
	ldloc.1
	method is_actuator
	call.meth 0
	bfalse 11
	ldloc.1
	method set_value
	ldloc.0
	attr left_value
	call.meth 1
	pop
	ldloc.0
	method _update_display
	call.meth 0
	pop
	none
	ret
	
on_disconnected_left: ;projects/standalone_/row.py
	ldloc.0
	attr left
	btrue 2
	none
	ret
	ldloc.0
	attr left_read
	bfalse 15
	glbl cancel
	ldloc.0
	attr left_read
	call 1
	pop
	none
	ldloc.0
	st.attr left_read
	ldloc.0
	attr left
	method is_sensor
	call.meth 0
	bfalse 18
	ldloc.0
	attr right
	bfalse 11
	ldloc.0
	attr right
	method set_value
	128
	call.meth 1
	pop
	none
	ldloc.0
	st.attr left
	128
	ldloc.0
	st.attr left_value
	ldloc.0
	method _update_display
	call.meth 0
	pop
	except.setup 12, 0
	glbl gc
	method collect
	call.meth 0
	pop
	except.jump 5, 0
	pop
	except.jump 1, 0
	finally.end
	none
	ret
	
on_disconnected_right: ;projects/standalone_/row.py
	ldloc.0
	attr right
	btrue 2
	none
	ret
	ldloc.0
	attr right_read
	bfalse 15
	glbl cancel
	ldloc.0
	attr right_read
	call 1
	pop
	none
	ldloc.0
	st.attr right_read
	ldloc.0
	attr right
	method is_sensor
	call.meth 0
	bfalse 18
	ldloc.0
	attr left
	bfalse 11
	ldloc.0
	attr left
	method set_value
	128
	call.meth 1
	pop
	none
	ldloc.0
	st.attr right
	128
	ldloc.0
	st.attr right_value
	ldloc.0
	method _update_display
	call.meth 0
	pop
	except.setup 12, 0
	glbl gc
	method collect
	call.meth 0
	pop
	except.jump 5, 0
	pop
	except.jump 1, 0
	finally.end
	none
	ret
	
_predicate: ;projects/standalone_/row.py
	glbl hub
	attr button
	attr left
	method is_pressed
	call.meth 0
	bfalse.pop 15
	glbl hub
	attr button
	attr right
	method is_pressed
	call.meth 0
	not
	ret
	
on_left_button_down: ;projects/standalone_/row.py
	glbl hub
	attr button
	attr right
	method is_pressed
	call.meth 0
	bfalse 9
	ldloc.0
	method _reset_values
	call.meth 0
	pop
	none
	ret
	mkfun 1
	stloc.1
	ldloc.0
	method _update_display
	call.meth 0
	pop
	ldloc.0
	method _adjust_actuator_value
	ldloc.1
	118
	call.meth 2
	ldloc.0
	st.attr adjust
	ldloc.0
	attr system
	attr loop
	method call_soon
	ldloc.0
	attr adjust
	call.meth 1
	pop
	none
	ret
	
on_left_button_up: ;projects/standalone_/row.py
	ldloc.0
	attr adjust
	bfalse 15
	glbl cancel
	ldloc.0
	attr adjust
	call 1
	pop
	none
	ldloc.0
	st.attr adjust
	ldloc.0
	method _update_display
	call.meth 0
	pop
	none
	ret
	
_predicate: ;projects/standalone_/row.py
	glbl hub
	attr button
	attr right
	method is_pressed
	call.meth 0
	bfalse.pop 15
	glbl hub
	attr button
	attr left
	method is_pressed
	call.meth 0
	not
	ret
	
on_right_button_down: ;projects/standalone_/row.py
	glbl hub
	attr button
	attr left
	method is_pressed
	call.meth 0
	bfalse 9
	ldloc.0
	method _reset_values
	call.meth 0
	pop
	none
	ret
	mkfun 1
	stloc.1
	ldloc.0
	method _update_display
	call.meth 0
	pop
	ldloc.0
	method _adjust_actuator_value
	ldloc.1
	138
	call.meth 2
	ldloc.0
	st.attr adjust
	ldloc.0
	attr system
	attr loop
	method call_soon
	ldloc.0
	attr adjust
	call.meth 1
	pop
	none
	ret
	
on_right_button_up: ;projects/standalone_/row.py
	ldloc.0
	attr adjust
	bfalse 15
	glbl cancel
	ldloc.0
	attr adjust
	call 1
	pop
	none
	ldloc.0
	st.attr adjust
	ldloc.0
	method _update_display
	call.meth 0
	pop
	none
	ret
	
_should_update_value: ;projects/standalone_/row.py
	ldloc.1
	bfalse.pop 21
	ldloc.1
	method is_actuator
	call.meth 0
	bfalse.pop 12
	ldloc.2
	not
	btrue.pop 7
	ldloc.2
	method is_sensor
	call.meth 0
	not
	ret
	
_reset_values: ;projects/standalone_/row.py
	ldloc.0
	method _should_update_value
	ldloc.0
	attr left
	ldloc.0
	attr right
	call.meth 2
	bfalse 11
	ldloc.0
	attr left
	method set_value
	128
	call.meth 1
	pop
	ldloc.0
	method _should_update_value
	ldloc.0
	attr right
	ldloc.0
	attr left
	call.meth 2
	bfalse 11
	ldloc.0
	attr right
	method set_value
	128
	call.meth 1
	pop
	none
	ret
	
_adjust_actuator_value: ;projects/standalone_/row.py
	int 131, 116
	stloc.3
	jmp 126
	ldloc.0
	method _should_update_value
	ldloc.0
	attr left
	ldloc.0
	attr right
	call.meth 2
	bfalse 29
	ldloc.0
	attr left
	method set_value_delta
	ldloc.2
	call.meth 1
	pop
	glbl hub
	attr sound
	method play
	glbl Sounds
	attr NAVIGATION_FAST
	call.meth 1
	pop
	ldloc.0
	method _should_update_value
	ldloc.0
	attr right
	ldloc.0
	attr left
	call.meth 2
	bfalse 29
	ldloc.0
	attr right
	method set_value_delta
	ldloc.2
	call.meth 1
	pop
	glbl hub
	attr sound
	method play
	glbl Sounds
	attr NAVIGATION_FAST
	call.meth 1
	pop
	int 128, 100
	ldloc.3
	add
	stloc.4
	128
	stloc.3
	except.setup 6, 0
	ldloc.4
	yield
	pop
	except.jump 17, 0
	dup
	glbl AttributeError
	ematch
	bfalse 8
	pop
	jmp.unwind 18, undefined
	except.jump 1, 0
	finally.end
	ldloc.1
	call 0
	bfalse 7
	ldloc.0
	attr running
	btrue -139
	none
	ret
	
on_left_value_changed: ;projects/standalone_/row.py
	ldloc.0
	attr running
	bfalse 71
	glbl int
	glbl round
	glbl min
	int 128, 100
	glbl max
	int 255, 28
	ldloc.1
	call 2
	call 2
	call 1
	call 1
	ldloc.0
	st.attr left_value
	ldloc.0
	attr right
	bfalse 26
	ldloc.0
	attr right
	method is_actuator
	call.meth 0
	bfalse 14
	ldloc.0
	attr right
	method set_value
	ldloc.0
	attr left_value
	call.meth 1
	pop
	ldloc.0
	method _update_display
	call.meth 0
	pop
	none
	ret
	
on_right_value_changed: ;projects/standalone_/row.py
	ldloc.0
	attr running
	bfalse 71
	glbl int
	glbl round
	glbl min
	int 128, 100
	glbl max
	int 255, 28
	ldloc.1
	call 2
	call 2
	call 1
	call 1
	ldloc.0
	st.attr right_value
	ldloc.0
	attr left
	bfalse 26
	ldloc.0
	attr left
	method is_actuator
	call.meth 0
	bfalse 14
	ldloc.0
	attr left
	method set_value
	ldloc.0
	attr right_value
	call.meth 1
	pop
	ldloc.0
	method _update_display
	call.meth 0
	pop
	none
	ret
	
set_advertise_ports: ;projects/standalone_/row.py
	ldloc.1
	ldloc.0
	st.attr advertise_ports
	ldloc.0
	method _update_display
	call.meth 0
	pop
	none
	ret
	
run_heartbeat: ;projects/standalone_/row.py
	128
	128
	128
	128
	137
	tuple 5
	137
	128
	128
	128
	137
	tuple 5
	137
	128
	128
	128
	128
	tuple 5
	137
	128
	128
	128
	137
	tuple 5
	tuple 4
	stloc.1
	int 128, 100
	int 128, 100
	int 128, 100
	128
	tuple 4
	stloc.2
	glbl zip
	ldloc.1
	ldloc.2
	call 2
	ld.iterstack
	for.iter 49, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.3
	stloc.4
	ldloc.0
	attr display
	method draw
	ldloc.3
	null
	call.kvmeth 0
	pop
	ldloc.4
	bfalse 26
	except.setup 8, 0
	int 128, 100
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
	jmp -52
	none
	ret
	
_update_display: ;projects/standalone_/row.py
	ldloc.0
	attr left
	bfalse 199
	ldloc.0
	attr right
	bfalse 192
	ldloc.0
	attr left
	method is_sensor
	call.meth 0
	bfalse 25
	ldloc.0
	attr right
	method is_sensor
	call.meth 0
	bfalse 13
	ldloc.0
	attr display
	method sensor_sensor
	call.meth 0
	pop
	jmp 152
	ldloc.0
	attr left
	method is_actuator
	call.meth 0
	bfalse 56
	ldloc.0
	attr right
	method is_actuator
	call.meth 0
	bfalse 44
	ldloc.0
	attr display
	method actuator_actuator
	glbl hub
	attr button
	attr left
	method is_pressed
	call.meth 0
	btrue.pop 14
	glbl hub
	attr button
	attr right
	method is_pressed
	call.meth 0
	call.meth 1
	pop
	jmp 84
	ldloc.0
	attr left
	method is_sensor
	call.meth 0
	bfalse 25
	ldloc.0
	attr right
	method is_actuator
	call.meth 0
	bfalse 13
	ldloc.0
	attr display
	method sensor_left_actuator_right
	call.meth 0
	pop
	jmp 47
	ldloc.0
	attr left
	method is_actuator
	call.meth 0
	bfalse 25
	ldloc.0
	attr right
	method is_sensor
	call.meth 0
	bfalse 13
	ldloc.0
	attr display
	method sensor_right_actuator_left
	call.meth 0
	pop
	jmp 10
	ldloc.0
	attr display
	method clear
	call.meth 0
	pop
	jmp 240
	ldloc.0
	attr left
	bfalse 98
	ldloc.0
	attr left
	method is_sensor
	call.meth 0
	bfalse 17
	ldloc.0
	attr display
	method sensor_left
	ldloc.0
	attr left_value
	call.meth 1
	pop
	jmp 66
	ldloc.0
	attr left
	method is_actuator
	call.meth 0
	bfalse 44
	ldloc.0
	attr display
	method actuator_left
	glbl hub
	attr button
	attr left
	method is_pressed
	call.meth 0
	btrue.pop 14
	glbl hub
	attr button
	attr right
	method is_pressed
	call.meth 0
	call.meth 1
	pop
	jmp 10
	ldloc.0
	attr display
	method clear
	call.meth 0
	pop
	jmp 135
	ldloc.0
	attr right
	bfalse 98
	ldloc.0
	attr right
	method is_sensor
	call.meth 0
	bfalse 17
	ldloc.0
	attr display
	method sensor_right
	ldloc.0
	attr right_value
	call.meth 1
	pop
	jmp 66
	ldloc.0
	attr right
	method is_actuator
	call.meth 0
	bfalse 44
	ldloc.0
	attr display
	method actuator_right
	glbl hub
	attr button
	attr left
	method is_pressed
	call.meth 0
	btrue.pop 14
	glbl hub
	attr button
	attr right
	method is_pressed
	call.meth 0
	call.meth 1
	pop
	jmp 10
	ldloc.0
	attr display
	method clear
	call.meth 0
	pop
	jmp 30
	ldloc.0
	attr advertise_ports
	bfalse 13
	ldloc.0
	attr display
	method advertise_ports
	call.meth 0
	pop
	jmp 10
	ldloc.0
	attr display
	method clear
	call.meth 0
	pop
	none
	ret
	
RowController: ;projects/standalone_/row.py
	loadname __name__
	st.name __module__
	str RowController
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name get_opposite_device
	mkfun 2
	st.name on_enter
	mkfun 3
	st.name on_exit
	mkfun 4
	st.name on_connected_left
	mkfun 5
	st.name on_connected_right
	mkfun 6
	st.name on_disconnected_left
	mkfun 7
	st.name on_disconnected_right
	mkfun 8
	st.name on_left_button_down
	mkfun 9
	st.name on_left_button_up
	mkfun 10
	st.name on_right_button_down
	mkfun 11
	st.name on_right_button_up
	mkfun 12
	st.name _should_update_value
	mkfun 13
	st.name _reset_values
	mkfun 14
	st.name _adjust_actuator_value
	mkfun 15
	st.name on_left_value_changed
	mkfun 16
	st.name on_right_value_changed
	mkfun 17
	st.name set_advertise_ports
	mkfun 18
	st.name run_heartbeat
	mkfun 19
	st.name _update_display
	none
	ret
	
read_sensor_input: ;projects/standalone_/row.py
	none
	stloc.2
	ldloc.0
	method get_value
	call.meth 0
	stloc.3
	ldloc.3
	none
	is
	not
	bfalse 13
	ldloc.3
	ldloc.2
	ne
	bfalse 7
	ldloc.1
	ldloc.3
	call 1
	pop
	ldloc.3
	stloc.2
	except.setup 7, 0
	int 50
	yield
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
	jmp -57
	none
	ret
	
<module>: ;projects/standalone_/row.py
	128
	none
	import.nm hub
	st.name hub
	129
	str DisplayController
	tuple 1
	import.nm display
	import.from DisplayController
	st.name DisplayController
	pop
	129
	str cancel
	tuple 1
	import.nm util
	import.from cancel
	st.name cancel
	pop
	129
	str HubSide
	tuple 1
	import.nm util
	import.from HubSide
	st.name HubSide
	pop
	128
	str Sounds
	tuple 1
	import.nm util.constants
	import.from Sounds
	st.name Sounds
	pop
	128
	none
	import.nm gc
	st.name gc
	buildclass
	mkfun 0
	str RowController
	loadname object
	call 3
	st.name RowController
	mkfun 1
	st.name read_sensor_input
	none
	ret
	