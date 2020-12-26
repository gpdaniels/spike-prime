__init__: ;system/sound.py
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	glbl hub
	attr sound
	attr callback
	call.meth 1
	pop
	none
	ret
	
beep: ;system/sound.py
	ldloc.0
	method _register
	ldloc.3
	call.meth 1
	pop
	glbl hub
	attr sound
	method beep
	glbl note_to_frequency
	ldloc.1
	call 1
	ldloc.2
	call.meth 2
	pop
	none
	ret
	
beep_async: ;system/sound.py
	ldloc.0
	method _register
	call.meth 0
	stloc.3
	glbl hub
	attr sound
	method beep
	glbl note_to_frequency
	ldloc.1
	call 1
	ldloc.2
	call.meth 2
	pop
	ldloc.0
	method await_callback
	ldloc.3
	call.meth 1
	ld.iter
	none
	yieldfrom
	ret
	
play: ;system/sound.py
	ldloc.0
	method _register
	ldloc.3
	call.meth 1
	pop
	glbl hub
	attr sound
	method play
	ldloc.1
	ldloc.2
	call.meth 2
	pop
	none
	ret
	
play_async: ;system/sound.py
	ldloc.0
	method _register
	call.meth 0
	stloc.3
	glbl hub
	attr sound
	method play
	ldloc.1
	ldloc.2
	call.meth 2
	pop
	ldloc.0
	method await_callback
	ldloc.3
	call.meth 1
	ld.iter
	none
	yieldfrom
	ret
	
SoundWrapper: ;system/sound.py
	loadname __name__
	st.name __module__
	str SoundWrapper
	st.name __qualname__
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	none
	tuple 1
	null
	mkfun.defargs 1
	st.name beep
	mkfun 2
	st.name beep_async
	int 128, 253, 0
	none
	tuple 2
	null
	mkfun.defargs 3
	st.name play
	int 128, 253, 0
	tuple 1
	null
	mkfun.defargs 4
	st.name play_async
	ldloc.0
	ret
	
<module>: ;system/sound.py
	128
	none
	import.nm hub
	st.name hub
	128
	str note_to_frequency
	tuple 1
	import.nm util.scratch
	import.from note_to_frequency
	st.name note_to_frequency
	pop
	129
	str AbstractWrapper
	tuple 1
	import.nm abstractwrapper
	import.from AbstractWrapper
	st.name AbstractWrapper
	pop
	buildclass
	mkfun 0
	str SoundWrapper
	loadname AbstractWrapper
	call 3
	st.name SoundWrapper
	none
	ret
	