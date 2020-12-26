__init__: ;commands/sound_methods.py
	ldloc.3
	ldloc.1
	st.attr _sound
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
handle_sound_beep: ;commands/sound_methods.py
	glbl hub
	attr sound
	method volume
	ldloc.1
	str volume
	MP_BC_LOAD_SUBSCR
	call.meth 1
	pop
	ldloc.0
	attr _sound
	method beep
	ldloc.1
	str note
	MP_BC_LOAD_SUBSCR
	int 129, 255, 127
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
	
<lambda>: ;commands/sound_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	str done
	call.meth 2
	ret
	
handle_sound_beep_for_time: ;commands/sound_methods.py
	glbl hub
	attr sound
	method volume
	ldloc.1
	str volume
	MP_BC_LOAD_SUBSCR
	call.meth 1
	pop
	deref 0
	attr _sound
	method beep
	ldloc.1
	str note
	MP_BC_LOAD_SUBSCR
	ldloc.1
	str duration
	MP_BC_LOAD_SUBSCR
	str callback
	ldloc.0
	ldloc.2
	mkclosure 3, 2
	call.meth 130, 2
	pop
	none
	ret
	
handle_sound_off: ;commands/sound_methods.py
	ldloc.0
	attr _rpc
	method reply
	ldloc.2
	ldloc.0
	attr _sound
	method beep
	128
	128
	call.meth 2
	call.meth 2
	pop
	none
	ret
	
<lambda>: ;commands/sound_methods.py
	deref 0
	attr _rpc
	method reply
	deref 1
	str done
	call.meth 2
	ret
	
handle_play_sound: ;commands/sound_methods.py
	glbl hub
	attr sound
	method volume
	ldloc.1
	str volume
	MP_BC_LOAD_SUBSCR
	call.meth 1
	pop
	ldloc.1
	str wait
	MP_BC_LOAD_SUBSCR
	bfalse 36
	deref 0
	attr _sound
	method play
	ldloc.1
	str path
	MP_BC_LOAD_SUBSCR
	str freq
	ldloc.1
	str freq
	MP_BC_LOAD_SUBSCR
	str callback
	ldloc.0
	ldloc.2
	mkclosure 3, 2
	call.meth 132, 1
	pop
	jmp 41
	deref 0
	attr _sound
	method play
	ldloc.1
	str path
	MP_BC_LOAD_SUBSCR
	str freq
	ldloc.1
	str freq
	MP_BC_LOAD_SUBSCR
	call.meth 130, 1
	pop
	deref 0
	attr _rpc
	method reply
	deref 2
	str done
	call.meth 2
	pop
	none
	ret
	
get_methods: ;commands/sound_methods.py
	map 4
	ldloc.0
	attr handle_sound_beep
	constobj 1
	st.map
	ldloc.0
	attr handle_sound_beep_for_time
	constobj 2
	st.map
	ldloc.0
	attr handle_sound_off
	constobj 3
	st.map
	ldloc.0
	attr handle_play_sound
	constobj 4
	st.map
	ret
	
SoundMethods: ;commands/sound_methods.py
	loadname __name__
	st.name __module__
	str SoundMethods
	st.name __qualname__
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	mkfun 1
	st.name handle_sound_beep
	mkfun 2
	st.name handle_sound_beep_for_time
	mkfun 3
	st.name handle_sound_off
	mkfun 4
	st.name handle_play_sound
	mkfun 5
	st.name get_methods
	ldloc.0
	ret
	
<module>: ;commands/sound_methods.py
	128
	none
	import.nm hub
	st.name hub
	129
	str AbstractHandler
	tuple 1
	import.nm abstract_handler
	import.from AbstractHandler
	st.name AbstractHandler
	pop
	buildclass
	mkfun 0
	str SoundMethods
	loadname AbstractHandler
	call 3
	st.name SoundMethods
	none
	ret
	