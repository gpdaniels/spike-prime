play: ;runtime/extensions/sound.py
	ldloc.0
	method _call
	constobj 6
	map 5
	ldloc.1
	str sound
	st.map
	ldloc.2
	str volume
	st.map
	ldloc.3
	str pitch
	st.map
	ldloc.4
	str pan
	st.map
	ldloc.5
	str wait
	st.map
	int 129, 196, 12
	call.meth 3
	ld.iter
	none
	yieldfrom
	ret
	
stop_all: ;runtime/extensions/sound.py
	ldloc.0
	method _call
	constobj 1
	call.meth 1
	ld.iter
	none
	yieldfrom
	ret
	
stop: ;runtime/extensions/sound.py
	ldloc.0
	method _call_sync
	constobj 1
	call.meth 1
	pop
	none
	ret
	
SoundExtension: ;runtime/extensions/sound.py
	loadname __name__
	st.name __module__
	str SoundExtension
	st.name __qualname__
	int 128, 100
	128
	128
	true
	tuple 4
	null
	mkfun.defargs 0
	st.name play
	mkfun 1
	st.name stop_all
	mkfun 2
	st.name stop
	none
	ret
	
<module>: ;runtime/extensions/sound.py
	129
	str AbstractExtension
	tuple 1
	import.nm abstract_extension
	import.from AbstractExtension
	st.name AbstractExtension
	pop
	buildclass
	mkfun 0
	str SoundExtension
	loadname AbstractExtension
	call 3
	st.name SoundExtension
	none
	ret
	