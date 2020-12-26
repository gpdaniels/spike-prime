__init__: ;runtime/extensions/abstract_extension.py
	ldloc.1
	ldloc.0
	st.attr _rpc
	glbl get_event_loop
	call 0
	ldloc.0
	st.attr _loop
	none
	ret
	
stop: ;runtime/extensions/abstract_extension.py
	none
	ret
	
<lambda>: ;runtime/extensions/abstract_extension.py
	none
	ret
	
_call_sync: ;runtime/extensions/abstract_extension.py
	ldloc.0
	attr _rpc
	method call
	ldloc.1
	ldloc.2
	ldloc.3
	call.meth 3
	ret
	
callback: ;runtime/extensions/abstract_extension.py
	true
	st.deref 1
	ldloc.2
	st.deref 0
	none
	ret
	
_call: ;runtime/extensions/abstract_extension.py
	glbl USB_VCP
	method isconnected
	call.meth 0
	btrue 13
	glbl BT_VCP
	method isconnected
	call.meth 0
	btrue 2
	none
	ret
	none
	st.deref 7
	false
	st.deref 8
	ldloc.7
	ldloc.8
	mkclosure 4, 2
	stloc.4
	ldloc.0
	method _call_sync
	ldloc.1
	ldloc.2
	ldloc.4
	call.meth 3
	stloc.5
	glbl utime
	method ticks_ms
	call.meth 0
	stloc.6
	jmp 5
	int 129, 122
	yield
	pop
	deref 8
	btrue 22
	glbl utime
	method ticks_diff
	glbl utime
	method ticks_ms
	call.meth 0
	ldloc.6
	call.meth 2
	ldloc.3
	lt
	btrue -32
	deref 8
	bfalse 3
	deref 7
	ret
	ldloc.0
	attr _rpc
	method cancel_call
	ldloc.5
	call.meth 1
	pop
	none
	ret
	
AbstractExtension: ;runtime/extensions/abstract_extension.py
	loadname __name__
	st.name __module__
	str AbstractExtension
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name stop
	none
	mkfun 2
	tuple 2
	null
	mkfun.defargs 3
	st.name _call_sync
	none
	int 135, 104
	tuple 2
	null
	mkfun.defargs 4
	st.name _call
	none
	ret
	
<module>: ;runtime/extensions/abstract_extension.py
	128
	none
	import.nm utime
	st.name utime
	128
	str get_event_loop
	tuple 1
	import.nm event_loop
	import.from get_event_loop
	st.name get_event_loop
	pop
	128
	str JSONRPC
	tuple 1
	import.nm protocol.ujsonrpc
	import.from JSONRPC
	st.name JSONRPC
	pop
	128
	str USB_VCP
	str BT_VCP
	tuple 2
	import.nm util.constants
	import.from USB_VCP
	st.name USB_VCP
	import.from BT_VCP
	st.name BT_VCP
	pop
	buildclass
	mkfun 0
	str AbstractExtension
	call 2
	st.name AbstractExtension
	none
	ret
	