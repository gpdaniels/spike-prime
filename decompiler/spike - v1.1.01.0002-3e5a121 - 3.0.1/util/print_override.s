rpc_callback: ;util/print_override.py
	true
	st.deref 0
	none
	ret
	
spikeprint: ;util/print_override.py
	glbl BT_VCP
	method isconnected
	call.meth 0
	btrue 33
	glbl USB_VCP
	method isconnected
	call.meth 0
	btrue 22
	glbl builtins
	method print
	str sep
	ldloc.1
	str end
	ldloc.0
	ldloc.2
	null
	call.kvmeth 132, 0
	pop
	none
	ret
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
	stloc.3
	false
	st.deref 9
	ldloc.9
	mkclosure 3, 1
	stloc.4
	glbl uio
	method BytesIO
	call.meth 0
	stloc.5
	glbl builtins
	method print
	str sep
	ldloc.1
	str end
	ldloc.0
	str file
	ldloc.5
	ldloc.2
	null
	call.kvmeth 134, 0
	pop
	glbl b2a_base64
	ldloc.5
	method getvalue
	call.meth 0
	call 1
	stloc.6
	ldloc.5
	method close
	call.meth 0
	pop
	ldloc.3
	method call
	constobj 2
	map 1
	ldloc.6
	str value
	st.map
	ldloc.4
	call.meth 3
	stloc.7
	glbl ticks_ms
	call 0
	stloc.8
	jmp 0
	deref 9
	btrue 18
	glbl ticks_diff
	glbl ticks_ms
	call 0
	ldloc.8
	call 2
	int 135, 104
	lt
	btrue -23
	deref 9
	btrue 8
	ldloc.3
	method cancel_call
	ldloc.7
	call.meth 1
	pop
	none
	ret
	
<module>: ;util/print_override.py
	128
	none
	import.nm builtins
	st.name builtins
	128
	none
	import.nm uio
	st.name uio
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
	128
	str b2a_base64
	tuple 1
	import.nm ubinascii
	import.from b2a_base64
	st.name b2a_base64
	pop
	constobj 0
	st.name _NOT_CONNECTED_ERROR
	null
	map 0
	str  
	str sep
	st.map
	str \x0a
	str end
	st.map
	mkfun.defargs 1
	st.name spikeprint
	none
	ret
	