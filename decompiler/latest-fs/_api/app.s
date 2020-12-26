__init__: ;_api/app.py
	glbl BT_VCP
	method isconnected
	call.meth 0
	btrue 20
	glbl USB_VCP
	method isconnected
	call.meth 0
	btrue 9
	glbl RuntimeError
	glbl _NOT_CONNECTED_ERROR
	call 1
	raiseobj
	glbl JSONRPC
	glbl BT_VCP
	method isconnected
	call.meth 0
	bfalse 11
	glbl USB_VCP
	method isconnected
	call.meth 0
	bfalse 6
	glbl USB_VCP
	jmp 3
	glbl BT_VCP
	call 1
	ldloc.0
	st.attr _json_rpc
	none
	ret
	
rpc_callback: ;_api/app.py
	true
	st.deref 0
	none
	ret
	
_play_sound: ;_api/app.py
	false
	st.deref 7
	ldloc.7
	mkclosure 5, 1
	stloc.4
	ldloc.0
	attr _json_rpc
	method call
	constobj 4
	map 5
	ldloc.1
	str sound
	st.map
	glbl min
	int 128, 100
	glbl max
	128
	ldloc.2
	call 2
	call 2
	str volume
	st.map
	128
	str pitch
	st.map
	128
	str pan
	st.map
	ldloc.3
	str wait
	st.map
	ldloc.4
	call.meth 3
	stloc.5
	glbl ticks_ms
	call 0
	stloc.6
	jmp 0
	deref 7
	btrue 19
	glbl ticks_diff
	glbl ticks_ms
	call 0
	ldloc.6
	call 2
	int 129, 196, 12
	lt
	btrue -24
	deref 7
	btrue 20
	ldloc.0
	attr _json_rpc
	method cancel_call
	ldloc.5
	call.meth 1
	pop
	glbl RuntimeError
	glbl _NOT_CONNECTED_ERROR
	call 1
	raiseobj
	none
	ret
	
play_sound: ;_api/app.py
	glbl isinstance
	ldloc.1
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl USB_VCP
	method isconnected
	call.meth 0
	btrue 20
	glbl BT_VCP
	method isconnected
	call.meth 0
	btrue 9
	glbl RuntimeError
	glbl _NOT_CONNECTED_ERROR
	call 1
	raiseobj
	ldloc.0
	method _play_sound
	ldloc.1
	ldloc.2
	true
	call.meth 3
	pop
	none
	ret
	
start_sound: ;_api/app.py
	glbl isinstance
	ldloc.1
	glbl str
	call 2
	btrue 8
	glbl TypeError
	constobj 3
	call 1
	raiseobj
	glbl isinstance
	ldloc.2
	glbl int
	call 2
	btrue 8
	glbl TypeError
	constobj 4
	call 1
	raiseobj
	glbl USB_VCP
	method isconnected
	call.meth 0
	btrue 20
	glbl BT_VCP
	method isconnected
	call.meth 0
	btrue 9
	glbl RuntimeError
	glbl _NOT_CONNECTED_ERROR
	call 1
	raiseobj
	ldloc.0
	method _play_sound
	ldloc.1
	ldloc.2
	false
	call.meth 3
	pop
	none
	ret
	
App: ;_api/app.py
	loadname __name__
	st.name __module__
	str App
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name _play_sound
	int 128, 100
	tuple 1
	null
	mkfun.defargs 2
	st.name play_sound
	int 128, 100
	tuple 1
	null
	mkfun.defargs 3
	st.name start_sound
	none
	ret
	
<module>: ;_api/app.py
	128
	str BT_VCP
	str USB_VCP
	tuple 2
	import.nm util.constants
	import.from BT_VCP
	st.name BT_VCP
	import.from USB_VCP
	st.name USB_VCP
	pop
	128
	str JSONRPC
	tuple 1
	import.nm protocol.ujsonrpc
	import.from JSONRPC
	st.name JSONRPC
	pop
	128
	str ticks_ms
	str ticks_diff
	tuple 2
	import.nm utime
	import.from ticks_ms
	st.name ticks_ms
	import.from ticks_diff
	st.name ticks_diff
	pop
	constobj 0
	st.name _NOT_CONNECTED_ERROR
	buildclass
	mkfun 1
	str App
	call 2
	st.name App
	none
	ret
	