play_drum: ;runtime/extensions/music.py
	ldloc.0
	method _call_sync
	constobj 2
	map 1
	ldloc.1
	str drum
	st.map
	call.meth 2
	pop
	none
	ret
	
play_note: ;runtime/extensions/music.py
	ldloc.0
	method _call_sync
	constobj 4
	map 3
	ldloc.1
	str instrument
	st.map
	ldloc.2
	str note
	st.map
	ldloc.3
	str duration
	st.map
	call.meth 2
	pop
	none
	ret
	
MusicExtension: ;runtime/extensions/music.py
	loadname __name__
	st.name __module__
	str MusicExtension
	st.name __qualname__
	mkfun 0
	st.name play_drum
	mkfun 1
	st.name play_note
	none
	ret
	
<module>: ;runtime/extensions/music.py
	129
	str AbstractExtension
	tuple 1
	import.nm abstract_extension
	import.from AbstractExtension
	st.name AbstractExtension
	pop
	buildclass
	mkfun 0
	str MusicExtension
	loadname AbstractExtension
	call 3
	st.name MusicExtension
	none
	ret
	