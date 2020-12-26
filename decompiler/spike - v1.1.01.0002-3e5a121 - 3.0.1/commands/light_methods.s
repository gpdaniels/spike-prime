__init__: ;commands/light_methods.py
	ldloc.3
	ldloc.1
	st.attr _display
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_display_clear: ;commands/light_methods.py
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl hub
	attr display
	method clear
	call.meth 0
	call.meth 2
	pop
	none
	ret
	
handle_display_set_pixel: ;commands/light_methods.py
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl hub
	attr display
	method pixel
	glbl int
	ldloc.1
	str x
	MP_BC_LOAD_SUBSCR
	call 1
	glbl int
	ldloc.1
	str y
	MP_BC_LOAD_SUBSCR
	call 1
	ldloc.1
	str brightness
	MP_BC_LOAD_SUBSCR
	call.meth 3
	call.meth 2
	pop
	none
	ret
	
<dictcomp>: ;commands/light_methods.py
	map 0
	ldloc.1
	ld.iterstack
	for.iter 19, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.2
	stloc.3
	deref 0
	method get
	ldloc.2
	ldloc.3
	call.meth 2
	ldloc.2
	MP_BC_STORE_COMP 25
	jmp -22
	ret
	
_merge_display_params: ;commands/light_methods.py
	ldloc.0
	mkclosure 2, 1
	ldloc.1
	method items
	call.meth 0
	call 1
	ret
	
<listcomp>: ;commands/light_methods.py
	list 0
	ldloc.0
	ld.iterstack
	for.iter 15, 0
	stloc.1
	glbl hub
	method Image
	ldloc.1
	call.meth 1
	MP_BC_STORE_COMP 20
	jmp -18
	ret
	
show_frames: ;commands/light_methods.py
	ldloc.0
	method _merge_display_params
	ldloc.2
	glbl LightMethods
	attr DEFAULT_DISPLAY_PARAMS
	call.meth 2
	stloc.4
	mkfun 4
	ldloc.1
	call 1
	stloc.5
	ldloc.0
	attr _display
	method show
	ldloc.5
	str callback
	ldloc.3
	null
	ldloc.4
	call.kvmeth 130, 1
	pop
	none
	ret
	
handle_display_image: ;commands/light_methods.py
	ldloc.0
	method show_frames
	ldloc.1
	str image
	MP_BC_LOAD_SUBSCR
	list 1
	map 1
	false
	str clear
	st.map
	call.meth 2
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	str done
	call.meth 2
	pop
	none
	ret
	
<lambda>: ;commands/light_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	str done
	call.meth 2
	ret
	
handle_display_image_for: ;commands/light_methods.py
	ldloc.0
	ldloc.2
	mkclosure 3, 2
	stloc.3
	deref 0
	method show_frames
	ldloc.1
	str image
	MP_BC_LOAD_SUBSCR
	list 1
	map 2
	true
	str clear
	st.map
	ldloc.1
	str duration
	MP_BC_LOAD_SUBSCR
	str delay
	st.map
	ldloc.3
	call.meth 3
	pop
	none
	ret
	
<lambda>: ;commands/light_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	str done
	call.meth 2
	ret
	
handle_display_animation: ;commands/light_methods.py
	ldloc.1
	method get
	str async
	false
	call.meth 2
	bfalse 22
	deref 0
	method show_frames
	ldloc.1
	str frames
	MP_BC_LOAD_SUBSCR
	ldloc.1
	ldloc.0
	ldloc.2
	mkclosure 3, 2
	call.meth 3
	pop
	jmp 27
	deref 0
	method show_frames
	ldloc.1
	str frames
	MP_BC_LOAD_SUBSCR
	ldloc.1
	call.meth 2
	pop
	deref 0
	attr _rpc
	method reply
	deref 2
	call.meth 1
	pop
	none
	ret
	
handle_display_rotate_direction: ;commands/light_methods.py
	glbl rotate_hub_display
	ldloc.1
	method get
	str direction
	constobj 3
	call.meth 2
	constobj 4
	eq
	bfalse 6
	int 255, 38
	jmp 3
	int 128, 90
	call 1
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_display_rotate_orientation: ;commands/light_methods.py
	glbl rotate_hub_display_to_value
	ldloc.1
	method get
	constobj 3
	str 1
	call.meth 2
	call 1
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
<lambda>: ;commands/light_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	glbl NO_STATUS
	call.meth 2
	ret
	
handle_display_text: ;commands/light_methods.py
	deref 0
	attr _display
	method write
	ldloc.1
	str text
	MP_BC_LOAD_SUBSCR
	str callback
	ldloc.0
	ldloc.2
	mkclosure 3, 2
	call.meth 130, 1
	pop
	none
	ret
	
handle_center_button_lights: ;commands/light_methods.py
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	glbl hub
	method led
	glbl int
	ldloc.1
	str color
	MP_BC_LOAD_SUBSCR
	call 1
	call.meth 1
	call.meth 2
	pop
	none
	ret
	
encode_percent: ;commands/light_methods.py
	glbl int
	str 127
	136
	call 2
	stloc.1
	glbl percent_to_int
	ldloc.0
	ldloc.1
	call 2
	stloc.2
	glbl chr
	ldloc.2
	call 1
	ret
	
<listcomp>: ;commands/light_methods.py
	list 0
	ldloc.1
	ld.iterstack
	for.iter 11, 0
	stloc.2
	deref 0
	ldloc.2
	call 1
	MP_BC_STORE_COMP 20
	jmp -14
	ret
	
handle_ultrasonic_light_up: ;commands/light_methods.py
	ldloc.1
	str port
	MP_BC_LOAD_SUBSCR
	stloc.3
	ldloc.1
	str lights
	MP_BC_LOAD_SUBSCR
	stloc.4
	mkfun 3
	st.deref 6
	glbl PORTS
	ldloc.3
	MP_BC_LOAD_SUBSCR
	attr device
	bfalse 40
	glbl bytes
	str 
	method join
	ldloc.6
	mkclosure 4, 1
	ldloc.4
	call 1
	call.meth 1
	str utf-8
	call 2
	stloc.5
	glbl PORTS
	ldloc.3
	MP_BC_LOAD_SUBSCR
	attr device
	method mode
	133
	ldloc.5
	call.meth 2
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_display_sync: ;commands/light_methods.py
	glbl set_display_sync
	glbl bool
	ldloc.1
	str sync
	MP_BC_LOAD_SUBSCR
	call 1
	call 1
	pop
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
get_methods: ;commands/light_methods.py
	map 11
	ldloc.0
	attr handle_ultrasonic_light_up
	constobj 1
	st.map
	ldloc.0
	attr handle_display_clear
	constobj 2
	st.map
	ldloc.0
	attr handle_display_set_pixel
	constobj 3
	st.map
	ldloc.0
	attr handle_display_image
	constobj 4
	st.map
	ldloc.0
	attr handle_display_image_for
	constobj 5
	st.map
	ldloc.0
	attr handle_display_animation
	constobj 6
	st.map
	ldloc.0
	attr handle_display_text
	constobj 7
	st.map
	ldloc.0
	attr handle_display_rotate_direction
	constobj 8
	st.map
	ldloc.0
	attr handle_display_rotate_orientation
	constobj 9
	st.map
	ldloc.0
	attr handle_center_button_lights
	constobj 10
	st.map
	ldloc.0
	attr handle_display_sync
	constobj 11
	st.map
	ret
	
LightMethods: ;commands/light_methods.py
	loadname __name__
	st.name __module__
	str LightMethods
	st.name __qualname__
	map 5
	false
	str clear
	st.map
	int 131, 116
	str delay
	st.map
	128
	str fade
	st.map
	false
	str wait
	st.map
	false
	str loop
	st.map
	st.name DEFAULT_DISPLAY_PARAMS
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	mkfun 1
	st.name handle_display_clear
	mkfun 2
	st.name handle_display_set_pixel
	loadname staticmethod
	mkfun 3
	call 1
	st.name _merge_display_params
	none
	tuple 1
	null
	mkfun.defargs 4
	st.name show_frames
	mkfun 5
	st.name handle_display_image
	mkfun 6
	st.name handle_display_image_for
	mkfun 7
	st.name handle_display_animation
	mkfun 8
	st.name handle_display_rotate_direction
	mkfun 9
	st.name handle_display_rotate_orientation
	mkfun 10
	st.name handle_display_text
	mkfun 11
	st.name handle_center_button_lights
	mkfun 12
	st.name handle_ultrasonic_light_up
	mkfun 13
	st.name handle_display_sync
	mkfun 14
	st.name get_methods
	ldloc.0
	ret
	
<module>: ;commands/light_methods.py
	128
	none
	import.nm hub
	st.name hub
	128
	str percent_to_int
	tuple 1
	import.nm util.scratch
	import.from percent_to_int
	st.name percent_to_int
	pop
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
	128
	str set_display_sync
	tuple 1
	import.nm util.sensors
	import.from set_display_sync
	st.name set_display_sync
	pop
	128
	str rotate_hub_display
	str rotate_hub_display_to_value
	tuple 2
	import.nm util.rotation
	import.from rotate_hub_display
	st.name rotate_hub_display
	import.from rotate_hub_display_to_value
	st.name rotate_hub_display_to_value
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
	str LightMethods
	loadname AbstractHandler
	call 3
	st.name LightMethods
	none
	ret
	