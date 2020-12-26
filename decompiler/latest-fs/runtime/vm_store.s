prop: ;runtime/vm_store.py
	ldloc.3
	none
	is
	bfalse 11
	ldloc.2
	method get
	deref 0
	deref 1
	call.meth 2
	ret
	ldloc.3
	ldloc.2
	deref 0
	MP_BC_STORE_SUBSCR
	none
	ret
	
add_prop: ;runtime/vm_store.py
	none
	tuple 1
	null
	ldloc.1
	ldloc.2
	mkclosure.defargs 3, 2
	stloc.3
	glbl setattr
	ldloc.0
	deref 1
	ldloc.3
	call 3
	pop
	none
	ret
	
prop: ;runtime/vm_store.py
	ldloc.4
	none
	is
	bfalse 12
	ldloc.2
	method dict_get
	ldloc.3
	deref 0
	deref 1
	call.meth 3
	ret
	ldloc.2
	method dict_set
	ldloc.3
	deref 0
	ldloc.4
	call.meth 3
	pop
	none
	ret
	
add_port_prop: ;runtime/vm_store.py
	none
	tuple 1
	null
	ldloc.1
	ldloc.2
	mkclosure.defargs 3, 2
	stloc.3
	glbl setattr
	ldloc.0
	deref 1
	ldloc.3
	call 3
	pop
	none
	ret
	
VMStore: ;runtime/vm_store.py
	loadname __name__
	st.name __module__
	str VMStore
	st.name __qualname__
	none
	ret
	
<module>: ;runtime/vm_store.py
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	128
	str DirtyDict
	tuple 1
	import.nm runtime.dirty_dict
	import.from DirtyDict
	st.name DirtyDict
	pop
	128
	str BRAKE
	str SUCCESS
	tuple 2
	import.nm util.constants
	import.from BRAKE
	st.name BRAKE
	import.from SUCCESS
	st.name SUCCESS
	pop
	true
	st.name _STALL
	loadname SUCCESS
	st.name _STAT
	loadname BRAKE
	st.name _STOP
	str A
	str B
	tuple 2
	st.name _PAIR
	constobj 0
	st.name _PCALIB
	loadname const
	int 128, 100
	call 1
	loadname const
	int 129, 22
	call 1
	tuple 2
	st.name _ACCEL
	str Billund
	st.name _LOC
	mkfun 15
	st.name add_prop
	mkfun 16
	st.name add_port_prop
	buildclass
	mkfun 17
	str VMStore
	loadname DirtyDict
	call 3
	st.name VMStore
	loadname add_port_prop
	loadname VMStore
	constobj 1
	int 128, 75
	call 3
	pop
	loadname add_port_prop
	loadname VMStore
	constobj 2
	loadname _STALL
	call 3
	pop
	loadname add_port_prop
	loadname VMStore
	constobj 3
	loadname _STAT
	call 3
	pop
	loadname add_port_prop
	loadname VMStore
	str motor_stop
	loadname _STOP
	call 3
	pop
	loadname add_port_prop
	loadname VMStore
	constobj 4
	loadname _ACCEL
	call 3
	pop
	loadname add_prop
	loadname VMStore
	str move_pair
	loadname _PAIR
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 5
	loadname _PCALIB
	call 3
	pop
	loadname add_prop
	loadname VMStore
	str move_speed
	int 50
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 6
	loadname _STAT
	call 3
	pop
	loadname add_prop
	loadname VMStore
	str move_stop
	loadname _STOP
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 7
	loadname _ACCEL
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 8
	int 128, 100
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 9
	int 128, 100
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 10
	128
	call 3
	pop
	loadname add_prop
	loadname VMStore
	str sound_pan
	128
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 11
	int 60
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 12
	129
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 13
	loadname _LOC
	call 3
	pop
	loadname add_prop
	loadname VMStore
	constobj 14
	128
	call 3
	pop
	none
	ret
	