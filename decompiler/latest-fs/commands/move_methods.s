__init__: ;commands/move_methods.py
	ldloc.3
	ldloc.1
	st.attr _move
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
<lambda>: ;commands/move_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	ldloc.2
	call.meth 2
	ret
	
handle_move_tank_time: ;commands/move_methods.py
	glbl int
	ldloc.1
	str time
	MP_BC_LOAD_SUBSCR
	call 1
	stloc.3
	glbl int
	ldloc.1
	str lspeed
	MP_BC_LOAD_SUBSCR
	call 1
	glbl int
	ldloc.1
	str rspeed
	MP_BC_LOAD_SUBSCR
	call 1
	rot
	stloc.4
	stloc.5
	ldloc.1
	str lmotor
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str rmotor
	MP_BC_LOAD_SUBSCR
	rot
	stloc.6
	stloc.7
	deref 0
	attr _move
	method on_pair
	ldloc.6
	ldloc.7
	call.meth 2
	method move_for_time
	ldloc.3
	ldloc.4
	ldloc.5
	neg
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
	ldloc.0
	ldloc.2
	mkclosure 5, 2
	call.meth 7
	pop
	none
	ret
	
<lambda>: ;commands/move_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	ldloc.2
	call.meth 2
	ret
	
handle_move_tank_degrees: ;commands/move_methods.py
	glbl int
	ldloc.1
	str degrees
	MP_BC_LOAD_SUBSCR
	call 1
	stloc.3
	glbl int
	ldloc.1
	str lspeed
	MP_BC_LOAD_SUBSCR
	call 1
	glbl int
	ldloc.1
	str rspeed
	MP_BC_LOAD_SUBSCR
	call 1
	rot
	stloc.4
	stloc.5
	ldloc.1
	str lmotor
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str rmotor
	MP_BC_LOAD_SUBSCR
	rot
	stloc.6
	stloc.7
	deref 0
	attr _move
	method on_pair
	ldloc.6
	ldloc.7
	call.meth 2
	method move_differential_speed
	ldloc.3
	ldloc.4
	ldloc.5
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
	ldloc.0
	ldloc.2
	mkclosure 5, 2
	call.meth 7
	pop
	none
	ret
	
<lambda>: ;commands/move_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	ldloc.2
	call.meth 2
	ret
	
handle_move_start_speeds: ;commands/move_methods.py
	glbl int
	ldloc.1
	str lspeed
	MP_BC_LOAD_SUBSCR
	call 1
	glbl int
	ldloc.1
	str rspeed
	MP_BC_LOAD_SUBSCR
	call 1
	rot
	stloc.3
	stloc.4
	ldloc.1
	str lmotor
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str rmotor
	MP_BC_LOAD_SUBSCR
	rot
	stloc.5
	stloc.6
	deref 0
	attr _move
	method on_pair
	ldloc.5
	ldloc.6
	call.meth 2
	method start_at_speeds
	ldloc.3
	ldloc.4
	neg
	ldloc.1
	method get
	constobj 3
	call.meth 1
	ldloc.1
	method get
	constobj 4
	call.meth 1
	ldloc.0
	ldloc.2
	mkclosure 5, 2
	call.meth 5
	pop
	none
	ret
	
<lambda>: ;commands/move_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	ldloc.2
	call.meth 2
	ret
	
handle_move_start_powers: ;commands/move_methods.py
	glbl int
	ldloc.1
	str lpower
	MP_BC_LOAD_SUBSCR
	call 1
	glbl int
	ldloc.1
	str rpower
	MP_BC_LOAD_SUBSCR
	call 1
	rot
	stloc.3
	stloc.4
	ldloc.1
	str lmotor
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str rmotor
	MP_BC_LOAD_SUBSCR
	rot
	stloc.5
	stloc.6
	deref 0
	attr _move
	method on_pair
	ldloc.5
	ldloc.6
	call.meth 2
	method start_at_powers
	ldloc.3
	ldloc.4
	neg
	ldloc.0
	ldloc.2
	mkclosure 3, 2
	call.meth 3
	pop
	none
	ret
	
handle_move_stop: ;commands/move_methods.py
	ldloc.1
	str lmotor
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str rmotor
	MP_BC_LOAD_SUBSCR
	rot
	stloc.3
	stloc.4
	ldloc.0
	attr _move
	method on_pair
	ldloc.3
	ldloc.4
	call.meth 2
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
	
get_methods: ;commands/move_methods.py
	map 5
	ldloc.0
	attr handle_move_tank_time
	constobj 1
	st.map
	ldloc.0
	attr handle_move_tank_degrees
	constobj 2
	st.map
	ldloc.0
	attr handle_move_start_speeds
	constobj 3
	st.map
	ldloc.0
	attr handle_move_start_powers
	constobj 4
	st.map
	ldloc.0
	attr handle_move_stop
	constobj 5
	st.map
	ret
	
MoveMethods: ;commands/move_methods.py
	loadname __name__
	st.name __module__
	str MoveMethods
	st.name __qualname__
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	mkfun 1
	st.name handle_move_tank_time
	mkfun 2
	st.name handle_move_tank_degrees
	mkfun 3
	st.name handle_move_start_speeds
	mkfun 4
	st.name handle_move_start_powers
	mkfun 5
	st.name handle_move_stop
	mkfun 6
	st.name get_methods
	ldloc.0
	ret
	
<module>: ;commands/move_methods.py
	128
	str NO_STATUS
	tuple 1
	import.nm util.constants
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
	str MoveMethods
	loadname AbstractHandler
	call 3
	st.name MoveMethods
	none
	ret
	