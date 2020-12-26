beep: ;_api/speaker.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl int
	glbl float
	tuple 2
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	ldloc.1
	172
	lt
	btrue 8
	ldloc.1
	int 128, 123
	qt
	bfalse 8
	glbl ValueError
	constobj 5
	call 1
	raiseobj
	glbl wait_for_async
	glbl system
	attr sound
	method beep_async
	ldloc.1
	glbl round
	glbl max
	128
	glbl min
	int 135, 4
	ldloc.2
	call 2
	call 2
	int 135, 104
	mul
	call 1
	call.meth 2
	call 1
	pop
	none
	ret
	
start_beep: ;_api/speaker.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	ldloc.1
	172
	lt
	btrue 8
	ldloc.1
	int 128, 123
	qt
	bfalse 8
	glbl ValueError
	constobj 3
	call 1
	raiseobj
	glbl system
	attr sound
	method beep
	ldloc.1
	int 182, 247, 32
	call.meth 2
	pop
	none
	ret
	
stop: ;_api/speaker.py
	glbl hub
	attr sound
	method beep
	128
	128
	call.meth 2
	pop
	none
	ret
	
get_volume: ;_api/speaker.py
	glbl round
	glbl hub
	attr sound
	method volume
	call.meth 0
	138
	mul
	call 1
	ret
	
set_volume: ;_api/speaker.py
	glbl isinstance
	ldloc.1
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	glbl hub
	attr sound
	method volume
	glbl round
	glbl min
	int 128, 100
	glbl max
	128
	ldloc.1
	call 2
	call 2
	138
	truediv
	call 1
	call.meth 1
	pop
	none
	ret
	
Speaker: ;_api/speaker.py
	loadname __name__
	st.name __module__
	str Speaker
	st.name __qualname__
	int 60
	constobj 0
	tuple 2
	null
	mkfun.defargs 1
	st.name beep
	int 60
	tuple 1
	null
	mkfun.defargs 2
	st.name start_beep
	mkfun 3
	st.name stop
	mkfun 4
	st.name get_volume
	mkfun 5
	st.name set_volume
	none
	ret
	
<module>: ;_api/speaker.py
	128
	none
	import.nm hub
	st.name hub
	128
	str system
	tuple 1
	import.nm system
	import.from system
	st.name system
	pop
	129
	str wait_for_async
	tuple 1
	import.nm util
	import.from wait_for_async
	st.name wait_for_async
	pop
	buildclass
	mkfun 0
	str Speaker
	call 2
	st.name Speaker
	none
	ret
	