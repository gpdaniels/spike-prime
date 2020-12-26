on: ;_api/statuslight.py
	glbl isinstance
	ldloc.1
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 2
	call 1
	raiseobj
	except.setup 9, 0
	glbl _COLORMAP
	ldloc.1
	MP_BC_LOAD_SUBSCR
	stloc.2
	except.jump 30, 0
	dup
	glbl KeyError
	ematch
	bfalse 21
	pop
	glbl ValueError
	constobj 3
	glbl _COLORMAP
	method keys
	call.meth 0
	mod
	call 1
	raiseobj
	except.jump 1, 0
	finally.end
	glbl hub
	method led
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
off: ;_api/statuslight.py
	glbl hub
	method led
	128
	call.meth 1
	pop
	none
	ret
	
StatusLight: ;_api/statuslight.py
	loadname __name__
	st.name __module__
	str StatusLight
	st.name __qualname__
	str white
	tuple 1
	null
	mkfun.defargs 0
	st.name on
	mkfun 1
	st.name off
	none
	ret
	
<module>: ;_api/statuslight.py
	128
	none
	import.nm hub
	st.name hub
	map 11
	128
	str black
	st.map
	129
	str pink
	st.map
	130
	str violet
	st.map
	131
	str blue
	st.map
	132
	str azure
	st.map
	133
	str cyan
	st.map
	134
	str green
	st.map
	135
	str yellow
	st.map
	136
	str orange
	st.map
	137
	str red
	st.map
	138
	str white
	st.map
	st.name _COLORMAP
	buildclass
	mkfun 0
	str StatusLight
	call 2
	st.name StatusLight
	none
	ret
	