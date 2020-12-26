new_func: ;ui/hubui.py
	glbl utime
	method ticks_ms
	call.meth 0
	st.glbl _latest_activity
	deref 0
	ldloc.1
	ldloc.2
	call.kw 0
	pop
	none
	ret
	
user_interaction: ;ui/hubui.py
	ldloc.0
	mkclosure 1, 1
	stloc.1
	ldloc.1
	ret
	
<lambda>: ;ui/hubui.py
	deref 0
	method __change_slot
	true
	call.meth 1
	ret
	
<lambda>: ;ui/hubui.py
	deref 0
	method __change_slot
	false
	call.meth 1
	ret
	
__init__: ;ui/hubui.py
	ldloc.1
	deref 0
	st.attr _system
	ldloc.2
	deref 0
	st.attr _programrunner
	glbl get_event_loop
	call 0
	deref 0
	st.attr _loop
	glbl hub
	method info
	call.meth 0
	method get
	constobj 4
	128
	call.meth 2
	deref 0
	st.attr _product_variant
	ldloc.3
	none
	is
	bfalse 4
	127
	jmp 1
	ldloc.3
	deref 0
	st.attr _current_slot
	false
	deref 0
	st.attr _is_play_mode
	false
	deref 0
	st.attr _is_bt
	false
	deref 0
	st.attr _is_shutdown
	none
	deref 0
	st.attr _shutdown_task
	none
	deref 0
	st.attr _in_out_task
	none
	deref 0
	st.attr _transition_task
	none
	deref 0
	st.attr _execmode_task
	none
	deref 0
	st.attr _connmode_task
	none
	deref 0
	st.attr _notify_task
	ldloc.3
	none
	is
	bfalse 50
	glbl bootup_animation
	call 0
	pop
	deref 0
	attr _system
	attr display
	method show
	deref 0
	method __get_slot_image
	deref 0
	attr _current_slot
	call.meth 1
	str delay
	int 129, 122
	str fade
	132
	str wait
	true
	call.meth 134, 1
	pop
	jmp 111
	ldloc.3
	127
	eq
	bfalse 38
	deref 0
	attr _system
	attr display
	method show
	deref 0
	method __get_slot_image
	127
	call.meth 1
	str delay
	128
	str fade
	128
	str wait
	true
	call.meth 134, 1
	pop
	jmp 67
	deref 0
	attr _system
	attr sound
	method play
	glbl Sounds
	attr PROGRAM_STOP
	call.meth 1
	pop
	glbl tuple
	glbl shift_in_from_bottom
	deref 0
	method __get_slot_image
	deref 0
	attr _current_slot
	call.meth 1
	call 1
	call 1
	stloc.4
	deref 0
	attr _system
	attr display
	method show
	ldloc.4
	str delay
	172
	str wait
	false
	call.meth 132, 1
	pop
	deref 0
	attr _system
	attr callbacks
	attr button_callbacks
	attr center
	method register_persistent
	deref 0
	attr __on_center_button
	call.meth 1
	pop
	deref 0
	attr _system
	attr callbacks
	attr button_callbacks
	attr right
	method register_persistent
	ldloc.0
	mkclosure 5, 1
	call.meth 1
	pop
	deref 0
	attr _system
	attr callbacks
	attr button_callbacks
	attr left
	method register_persistent
	ldloc.0
	mkclosure 6, 1
	call.meth 1
	pop
	deref 0
	attr _system
	attr callbacks
	attr button_callbacks
	attr connect
	method register_persistent
	deref 0
	attr __on_connect_button
	call.meth 1
	pop
	deref 0
	attr _system
	attr callbacks
	attr connection
	attr state
	method register_persistent
	deref 0
	attr __on_connection
	call.meth 1
	pop
	deref 0
	method __start_autoshutdown
	call.meth 0
	pop
	none
	ret
	
__get_slot_image: ;ui/hubui.py
	ldloc.1
	127
	eq
	bfalse 9
	glbl DEFAULT_IMAGE
	ldloc.0
	attr _product_variant
	MP_BC_LOAD_SUBSCR
	ret
	glbl SLOTS_IMAGE
	ldloc.1
	MP_BC_LOAD_SUBSCR
	ret
	
start_program: ;ui/hubui.py
	ldloc.0
	attr _current_slot
	stloc.2
	ldloc.0
	attr _programrunner
	method is_running
	call.meth 0
	stloc.3
	ldloc.1
	ldloc.0
	st.attr _current_slot
	ldloc.0
	attr _programrunner
	method stop_all
	ldloc.0
	attr _current_slot
	call.meth 1
	pop
	ldloc.0
	method __cancel_animations
	call.meth 0
	pop
	ldloc.0
	method __toggle_program
	str overlay_slot
	ldloc.2
	str overwrite
	ldloc.3
	call.meth 132, 0
	pop
	none
	ret
	
stop_all: ;ui/hubui.py
	ldloc.0
	attr _programrunner
	method is_running
	call.meth 0
	bfalse 15
	ldloc.0
	method __toggle_program
	str callback
	ldloc.1
	call.meth 130, 0
	pop
	jmp 71
	ldloc.0
	attr _is_play_mode
	bfalse 41
	ldloc.0
	attr _programrunner
	method stop_all
	call.meth 0
	pop
	ldloc.0
	attr _system
	attr display
	method show
	glbl hub
	method Image
	constobj 2
	call.meth 1
	str callback
	ldloc.1
	call.meth 130, 1
	pop
	jmp 23
	glbl callable
	ldloc.1
	call 1
	bfalse 14
	ldloc.0
	attr _loop
	method call_soon
	ldloc.1
	call.meth 1
	pop
	jmp 0
	none
	ret
	
on_done: ;ui/hubui.py
	true
	st.deref 0
	none
	ret
	
_mode_change: ;ui/hubui.py
	deref 0
	attr _system
	attr sound
	method play
	deref 1
	bfalse 9
	glbl Sounds
	attr PROGRAM_START
	jmp 6
	glbl Sounds
	attr PROGRAM_STOP
	call.meth 1
	pop
	false
	st.deref 4
	ldloc.4
	mkclosure 2, 1
	stloc.2
	deref 1
	bfalse 48
	glbl tuple
	glbl streaming_animation
	call 0
	call 1
	stloc.3
	deref 0
	attr _system
	attr display
	method show
	ldloc.3
	str delay
	int 128, 80
	str fade
	128
	str clear
	true
	str callback
	ldloc.2
	call.meth 136, 1
	pop
	jmp 51
	glbl download_animation
	call 0
	deref 0
	method __get_slot_image
	deref 0
	attr _current_slot
	call.meth 1
	list 1
	add
	stloc.3
	deref 0
	attr _system
	attr display
	method show
	ldloc.3
	str delay
	int 128, 80
	str fade
	130
	str callback
	ldloc.2
	call.meth 134, 1
	pop
	glbl led_fade_to
	deref 1
	bfalse 6
	glbl WHITE
	jmp 3
	glbl DIM_WHITE
	int 128, 100
	133
	call 3
	ld.iter
	none
	yieldfrom
	pop
	jmp 3
	138
	yield
	pop
	deref 4
	bfalse -8
	none
	deref 0
	st.attr _execmode_task
	none
	ret
	
change_execution_mode: ;ui/hubui.py
	ldloc.0
	ldloc.1
	mkclosure 2, 2
	stloc.2
	deref 0
	attr _is_play_mode
	deref 1
	ne
	bfalse 55
	deref 1
	deref 0
	st.attr _is_play_mode
	deref 0
	method __cancel_animations
	call.meth 0
	pop
	deref 0
	attr _programrunner
	method stop_all
	deref 0
	attr _current_slot
	call.meth 1
	pop
	ldloc.2
	call 0
	deref 0
	st.attr _execmode_task
	deref 0
	attr _loop
	method call_soon
	deref 0
	attr _execmode_task
	call.meth 1
	pop
	none
	ret
	
change_communication_mode: ;ui/hubui.py
	ldloc.1
	ldloc.0
	st.attr _is_bt
	ldloc.0
	attr _shutdown_task
	btrue 8
	ldloc.0
	method __on_bluetooth
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
idle: ;ui/hubui.py
	ldloc.0
	attr _shutdown_task
	btrue.pop 25
	ldloc.0
	attr _in_out_task
	btrue.pop 18
	ldloc.0
	attr _transition_task
	btrue.pop 11
	ldloc.0
	attr _execmode_task
	btrue.pop 4
	ldloc.0
	attr _connmode_task
	not
	ret
	
will_stop_restart: ;ui/hubui.py
	ldloc.0
	attr _programrunner
	attr state
	glbl ProgramRunner
	attr RUNNING_BLOCKING
	eq
	ret
	
test: ;ui/hubui.py
	int 167, 8
	yield
	pop
	glbl utime
	method ticks_diff
	glbl utime
	method ticks_ms
	call.meth 0
	glbl _latest_activity
	call.meth 2
	stloc.1
	glbl hub
	attr battery
	method charger_detect
	call.meth 0
	btrue 78
	deref 0
	attr _is_play_mode
	btrue 70
	deref 0
	attr _programrunner
	attr state
	glbl ProgramRunner
	attr IDLE
	is
	bfalse 52
	deref 0
	attr _is_bt
	btrue 8
	ldloc.1
	glbl INACTIVE_SHUTDOWN_MS
	qt
	btrue 16
	deref 0
	attr _is_bt
	bfalse 28
	ldloc.1
	glbl INACTIVE_SHUTDOWN_BT_MS
	qt
	bfalse 20
	deref 0
	method __cancel_animations
	call.meth 0
	pop
	glbl shutdown_animation
	call 0
	pop
	glbl reset
	call 0
	pop
	jmp -120
	none
	ret
	
__start_autoshutdown: ;ui/hubui.py
	ldloc.0
	mkclosure 1, 1
	stloc.1
	deref 0
	attr _loop
	method call_soon
	ldloc.1
	call 0
	call.meth 1
	pop
	none
	ret
	
__on_connection: ;ui/hubui.py
	glbl any
	ldloc.1
	call 1
	btrue 15
	ldloc.0
	attr _is_play_mode
	bfalse 8
	ldloc.0
	method change_execution_mode
	false
	call.meth 1
	pop
	none
	ret
	
transition: ;ui/hubui.py
	glbl hub
	method Image
	glbl hub
	method status
	call.meth 0
	str display
	MP_BC_LOAD_SUBSCR
	call.meth 1
	stloc.2
	deref 1
	bfalse 49
	deref 0
	attr _system
	attr sound
	method beep_async
	int 128, 77
	int 128, 100
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	deref 0
	attr _system
	attr sound
	method beep_async
	int 128, 78
	int 128, 80
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	jmp 46
	deref 0
	attr _system
	attr sound
	method beep_async
	int 128, 78
	int 128, 80
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	deref 0
	attr _system
	attr sound
	method beep_async
	int 128, 77
	int 128, 100
	call.meth 2
	ld.iter
	none
	yieldfrom
	pop
	int 131, 116
	yield
	pop
	deref 0
	attr _system
	attr display
	method show
	ldloc.2
	str fade
	130
	str delay
	int 130, 44
	call.meth 132, 1
	pop
	none
	deref 0
	st.attr _connmode_task
	none
	ret
	
__on_bluetooth: ;ui/hubui.py
	ldloc.0
	ldloc.1
	mkclosure 2, 2
	stloc.2
	deref 0
	method __cancel_animations
	call.meth 0
	pop
	ldloc.2
	call 0
	deref 0
	st.attr _connmode_task
	deref 0
	attr _loop
	method call_soon
	deref 0
	attr _connmode_task
	call.meth 1
	pop
	none
	ret
	
__cancel_animations: ;ui/hubui.py
	ldloc.0
	attr _transition_task
	ldloc.0
	attr _in_out_task
	ldloc.0
	attr _execmode_task
	ldloc.0
	attr _connmode_task
	ldloc.0
	attr _notify_task
	tuple 5
	stloc.1
	ldloc.1
	ld.iterstack
	for.iter 22, 0
	stloc.2
	ldloc.2
	none
	is
	not
	bfalse 11
	ldloc.0
	attr _loop
	method cancel
	ldloc.2
	call.meth 1
	pop
	jmp -25
	none
	dup
	ldloc.0
	st.attr _transition_task
	dup
	ldloc.0
	st.attr _in_out_task
	dup
	ldloc.0
	st.attr _execmode_task
	dup
	ldloc.0
	st.attr _connmode_task
	ldloc.0
	st.attr _notify_task
	none
	ret
	
__on_center_button: ;ui/hubui.py
	glbl hub
	attr button
	attr center
	method is_pressed
	call.meth 0
	stloc.2
	ldloc.0
	method __shutdown_timer
	ldloc.2
	call.meth 1
	pop
	ldloc.2
	btrue 44
	ldloc.1
	128
	qt
	bfalse 38
	ldloc.0
	attr _is_play_mode
	btrue 31
	ldloc.0
	attr idle
	btrue 17
	ldloc.0
	attr _programrunner
	attr state
	glbl ProgramRunner
	attr RUNNING_BLOCKING
	eq
	bfalse 7
	ldloc.0
	method __toggle_program
	call.meth 0
	pop
	none
	ret
	
beep_seq: ;ui/hubui.py
	glbl hub
	attr sound
	stloc.1
	128
	jmp 120
	dup
	stloc.2
	int 137, 8
	yield
	pop
	deref 0
	attr _shutdown_task
	btrue 8
	deref 0
	attr _is_bt
	bfalse 2
	none
	ret
	ldloc.1
	method volume
	call.meth 0
	stloc.3
	ldloc.1
	method volume
	133
	call.meth 1
	pop
	deref 0
	attr _system
	attr sound
	method beep
	int 128, 88
	int 50
	call.meth 2
	pop
	ldloc.1
	method volume
	ldloc.3
	call.meth 1
	pop
	int 129, 82
	yield
	pop
	ldloc.1
	method volume
	call.meth 0
	stloc.3
	ldloc.1
	method volume
	133
	call.meth 1
	pop
	deref 0
	attr _system
	attr sound
	method beep
	int 128, 88
	int 50
	call.meth 2
	pop
	ldloc.1
	method volume
	ldloc.3
	call.meth 1
	pop
	int 50
	yield
	pop
	129
	add.in
	dup
	136
	lt
	btrue -126
	pop
	glbl hub
	attr bluetooth
	method discoverable
	call.meth 0
	int 135, 104
	mul
	yield
	pop
	none
	deref 0
	st.attr _notify_task
	none
	ret
	
__on_connect_button: ;ui/hubui.py
	glbl hub
	attr button
	attr connect
	method is_pressed
	call.meth 0
	bfalse 37
	deref 0
	attr _notify_task
	btrue 29
	ldloc.0
	mkclosure 2, 1
	stloc.2
	ldloc.2
	call 0
	deref 0
	st.attr _notify_task
	deref 0
	attr _loop
	method call_soon
	deref 0
	attr _notify_task
	call.meth 1
	pop
	none
	ret
	
on_done: ;ui/hubui.py
	deref 0
	129
	add.in
	st.deref 0
	none
	ret
	
_program_stop: ;ui/hubui.py
	ldloc.0
	attr _programrunner
	method stop_all
	ldloc.0
	attr _current_slot
	call.meth 1
	pop
	ldloc.0
	attr _is_shutdown
	btrue 112
	128
	st.deref 4
	ldloc.4
	mkclosure 2, 1
	stloc.2
	138
	yield
	pop
	ldloc.0
	attr _system
	attr sound
	method play
	glbl Sounds
	attr PROGRAM_STOP
	str callback
	ldloc.2
	call.meth 130, 1
	pop
	glbl tuple
	glbl shift_in_from_bottom
	ldloc.0
	method __get_slot_image
	ldloc.0
	attr _current_slot
	call.meth 1
	call 1
	call 1
	stloc.3
	ldloc.0
	attr _system
	attr display
	method show
	ldloc.3
	str delay
	172
	str wait
	false
	str callback
	ldloc.2
	call.meth 134, 1
	pop
	glbl led_fade_to
	glbl DIM_WHITE
	int 128, 100
	133
	call 3
	ld.iter
	none
	yieldfrom
	pop
	jmp 3
	138
	yield
	pop
	deref 4
	130
	lt
	btrue -10
	none
	ldloc.0
	st.attr _in_out_task
	glbl callable
	ldloc.1
	call 1
	bfalse 11
	ldloc.0
	attr _loop
	method call_soon
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
on_done: ;ui/hubui.py
	true
	st.deref 0
	none
	ret
	
_program_start: ;ui/hubui.py
	ldloc.0
	attr _is_shutdown
	btrue 166
	false
	st.deref 6
	ldloc.6
	mkclosure 4, 1
	stloc.4
	138
	yield
	pop
	ldloc.0
	attr _system
	attr sound
	method play
	glbl Sounds
	attr PROGRAM_START
	str callback
	ldloc.4
	call.meth 130, 1
	pop
	ldloc.2
	btrue 34
	glbl tuple
	glbl shift_out_to_bottom
	ldloc.0
	method __get_slot_image
	ldloc.1
	none
	is
	bfalse 7
	ldloc.0
	attr _current_slot
	jmp 1
	ldloc.1
	call.meth 1
	call 1
	call 1
	stloc.5
	jmp 3
	tuple 0
	stloc.5
	ldloc.0
	attr _system
	attr display
	method show
	ldloc.5
	str delay
	172
	str wait
	false
	call.meth 132, 1
	pop
	glbl led_fade_to
	glbl WHITE
	int 128, 100
	133
	call 3
	ld.iter
	none
	yieldfrom
	pop
	jmp 3
	138
	yield
	pop
	deref 6
	bfalse -8
	none
	ldloc.0
	st.attr _in_out_task
	ldloc.0
	attr _programrunner
	method start_program
	ldloc.0
	attr _current_slot
	ldloc.0
	attr stop_all
	call.meth 2
	btrue 15
	127
	ldloc.0
	st.attr _current_slot
	ldloc.0
	method _program_stop
	call.meth 0
	ld.iter
	none
	yieldfrom
	pop
	glbl callable
	ldloc.3
	call 1
	bfalse 11
	ldloc.0
	attr _loop
	method call_soon
	ldloc.3
	call.meth 1
	pop
	none
	ret
	
__toggle_program: ;ui/hubui.py
	ldloc.0
	attr _programrunner
	attr state
	glbl ProgramRunner
	attr RUNNING_BLOCKING
	eq
	bfalse 37
	ldloc.0
	attr _programrunner
	method stop_all
	ldloc.0
	attr _current_slot
	call.meth 1
	pop
	glbl callable
	ldloc.3
	call 1
	bfalse 11
	ldloc.0
	attr _loop
	method call_soon
	ldloc.3
	call.meth 1
	pop
	jmp 80
	ldloc.0
	attr _programrunner
	attr state
	glbl ProgramRunner
	attr RUNNING_NONBLOCKING
	eq
	bfalse 32
	ldloc.0
	method _program_stop
	str callback
	ldloc.3
	call.meth 130, 0
	ldloc.0
	st.attr _in_out_task
	ldloc.0
	attr _loop
	method call_soon
	ldloc.0
	attr _in_out_task
	call.meth 1
	pop
	jmp 31
	ldloc.0
	method _program_start
	ldloc.1
	ldloc.2
	str callback
	ldloc.3
	call.meth 130, 2
	ldloc.0
	st.attr _in_out_task
	ldloc.0
	attr _loop
	method call_soon
	ldloc.0
	attr _in_out_task
	call.meth 1
	pop
	none
	ret
	
shutdown_task: ;ui/hubui.py
	none
	yield
	pop
	int 138, 120
	yield
	pop
	deref 0
	attr _system
	attr sound
	method play
	glbl Sounds
	attr SHUTDOWN
	call.meth 1
	pop
	int 138, 120
	yield
	pop
	true
	deref 0
	st.attr _is_shutdown
	glbl shutdown_animation
	call 0
	pop
	none
	deref 0
	st.attr _shutdown_task
	int 138, 120
	yield
	pop
	false
	deref 0
	st.attr _is_shutdown
	none
	ret
	
__shutdown_timer: ;ui/hubui.py
	ldloc.1
	bfalse 53
	deref 0
	attr _shutdown_task
	none
	is
	bfalse 43
	ldloc.0
	mkclosure 2, 1
	stloc.2
	ldloc.2
	call 0
	deref 0
	st.attr _shutdown_task
	glbl next
	deref 0
	attr _shutdown_task
	call 1
	pop
	deref 0
	attr _loop
	method call_soon
	deref 0
	attr _shutdown_task
	call.meth 1
	pop
	jmp 72
	ldloc.1
	btrue 68
	deref 0
	attr _shutdown_task
	bfalse 60
	except.setup 19, 0
	deref 0
	attr _loop
	method cancel
	deref 0
	attr _shutdown_task
	call.meth 1
	pop
	except.jump 13, 0
	dup
	glbl TypeError
	ematch
	bfalse 4
	pop
	except.jump 1, 0
	finally.end
	deref 0
	attr _system
	attr sound
	method beep
	128
	128
	call.meth 2
	pop
	none
	deref 0
	st.attr _shutdown_task
	jmp 0
	none
	ret
	
<lambda>: ;ui/hubui.py
	ldloc.0
	bfalse 12
	glbl hub
	attr button
	attr right
	jmp 9
	glbl hub
	attr button
	attr left
	method is_pressed
	call.meth 0
	ret
	
on_done: ;ui/hubui.py
	true
	st.deref 0
	none
	ret
	
slot_looper: ;ui/hubui.py
	jmp 205
	except.setup 68, 0
	deref 3
	method index
	deref 0
	attr _current_slot
	call.meth 1
	stloc.4
	deref 1
	bfalse 25
	ldloc.4
	129
	add
	glbl len
	deref 3
	call 1
	ne
	bfalse 6
	ldloc.4
	129
	add
	jmp 1
	128
	stloc.4
	jmp 22
	ldloc.4
	128
	qt
	bfalse 6
	ldloc.4
	129
	sub
	jmp 9
	glbl len
	deref 3
	call 1
	129
	sub
	stloc.4
	except.jump 22, 0
	dup
	glbl ValueError
	ematch
	bfalse 13
	pop
	deref 3
	method index
	127
	call.meth 1
	stloc.4
	except.jump 1, 0
	finally.end
	deref 3
	ldloc.4
	MP_BC_LOAD_SUBSCR
	deref 0
	st.attr _current_slot
	false
	st.deref 6
	ldloc.6
	mkclosure 4, 1
	stloc.5
	deref 0
	attr _system
	attr sound
	method play
	glbl Sounds
	attr NAVIGATION
	call.meth 1
	pop
	deref 0
	attr _system
	attr display
	method show
	glbl hub
	method Image
	call.meth 0
	deref 0
	method __get_slot_image
	deref 0
	attr _current_slot
	call.meth 1
	tuple 2
	str wait
	false
	str fade
	deref 1
	bfalse 4
	132
	jmp 1
	131
	str delay
	int 129, 122
	str callback
	ldloc.5
	call.meth 136, 1
	pop
	jmp 3
	138
	yield
	pop
	deref 6
	bfalse -8
	deref 2
	call 0
	btrue -212
	none
	deref 0
	st.attr _transition_task
	none
	ret
	
__change_slot: ;ui/hubui.py
	deref 1
	tuple 1
	null
	mkfun.defargs 2
	st.deref 3
	deref 0
	attr idle
	bfalse 89
	deref 3
	call 0
	bfalse 82
	deref 0
	attr _is_play_mode
	btrue 74
	deref 0
	attr _programrunner
	attr state
	glbl ProgramRunner
	attr IDLE
	is
	bfalse 56
	glbl get_used_slots
	call 0
	st.deref 4
	deref 4
	method append
	127
	call.meth 1
	pop
	deref 4
	method sort
	call.meth 0
	pop
	ldloc.0
	ldloc.1
	ldloc.3
	ldloc.4
	mkclosure 3, 4
	stloc.2
	ldloc.2
	call 0
	deref 0
	st.attr _transition_task
	deref 0
	attr _loop
	method call_soon
	deref 0
	attr _transition_task
	call.meth 1
	pop
	none
	ret
	
HubUI: ;ui/hubui.py
	loadname __name__
	st.name __module__
	str HubUI
	st.name __qualname__
	none
	tuple 1
	null
	mkfun.defargs 0
	st.name __init__
	mkfun 1
	st.name __get_slot_image
	loadname user_interaction
	mkfun 2
	call 1
	st.name start_program
	loadname user_interaction
	none
	tuple 1
	null
	mkfun.defargs 3
	call 1
	st.name stop_all
	loadname user_interaction
	mkfun 4
	call 1
	st.name change_execution_mode
	loadname user_interaction
	mkfun 5
	call 1
	st.name change_communication_mode
	loadname property
	mkfun 6
	call 1
	st.name idle
	mkfun 7
	st.name will_stop_restart
	mkfun 8
	st.name __start_autoshutdown
	loadname user_interaction
	mkfun 9
	call 1
	st.name __on_connection
	mkfun 10
	st.name __on_bluetooth
	mkfun 11
	st.name __cancel_animations
	loadname user_interaction
	mkfun 12
	call 1
	st.name __on_center_button
	loadname user_interaction
	mkfun 13
	call 1
	st.name __on_connect_button
	none
	tuple 1
	null
	mkfun.defargs 14
	st.name _program_stop
	none
	tuple 1
	null
	mkfun.defargs 15
	st.name _program_start
	null
	map 0
	none
	str overlay_slot
	st.map
	false
	str overwrite
	st.map
	none
	str callback
	st.map
	mkfun.defargs 16
	st.name __toggle_program
	mkfun 17
	st.name __shutdown_timer
	loadname user_interaction
	mkfun 18
	call 1
	st.name __change_slot
	none
	ret
	
<module>: ;ui/hubui.py
	128
	none
	import.nm hub
	st.name hub
	128
	none
	import.nm utime
	st.name utime
	128
	str reset
	tuple 1
	import.nm machine
	import.from reset
	st.name reset
	pop
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	str get_event_loop
	tuple 1
	import.nm event_loop
	import.from get_event_loop
	st.name get_event_loop
	pop
	128
	str System
	tuple 1
	import.nm system
	import.from System
	st.name System
	pop
	128
	str ProgramRunner
	tuple 1
	import.nm programrunner
	import.from ProgramRunner
	st.name ProgramRunner
	pop
	128
	str SLOTS_IMAGE
	str DEFAULT_IMAGE
	str Sounds
	tuple 3
	import.nm util.constants
	import.from SLOTS_IMAGE
	st.name SLOTS_IMAGE
	import.from DEFAULT_IMAGE
	st.name DEFAULT_IMAGE
	import.from Sounds
	st.name Sounds
	pop
	128
	str bootup_animation
	str shutdown_animation
	str led_fade_to
	str shift_in_from_bottom
	str shift_out_to_bottom
	str streaming_animation
	str download_animation
	tuple 7
	import.nm util.animations
	import.from bootup_animation
	st.name bootup_animation
	import.from shutdown_animation
	st.name shutdown_animation
	import.from led_fade_to
	st.name led_fade_to
	import.from shift_in_from_bottom
	st.name shift_in_from_bottom
	import.from shift_out_to_bottom
	st.name shift_out_to_bottom
	import.from streaming_animation
	st.name streaming_animation
	import.from download_animation
	st.name download_animation
	pop
	128
	str DIM_WHITE
	str WHITE
	tuple 2
	import.nm util.color
	import.from DIM_WHITE
	st.name DIM_WHITE
	import.from WHITE
	st.name WHITE
	pop
	128
	str INACTIVE_SHUTDOWN_MS
	str INACTIVE_SHUTDOWN_BT_MS
	tuple 2
	import.nm util.constants
	import.from INACTIVE_SHUTDOWN_MS
	st.name INACTIVE_SHUTDOWN_MS
	import.from INACTIVE_SHUTDOWN_BT_MS
	st.name INACTIVE_SHUTDOWN_BT_MS
	pop
	128
	str get_used_slots
	tuple 1
	import.nm util.storage
	import.from get_used_slots
	st.name get_used_slots
	pop
	loadname utime
	method ticks_ms
	call.meth 0
	st.glbl _latest_activity
	mkfun 0
	st.name user_interaction
	buildclass
	mkfun 1
	str HubUI
	call 2
	st.name HubUI
	none
	ret
	