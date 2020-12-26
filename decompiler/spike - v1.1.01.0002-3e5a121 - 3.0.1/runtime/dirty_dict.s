__init__: ;runtime/dirty_dict.py
	glbl super
	deref 0
	ldloc.1
	supermethod __init__
	call.meth 0
	pop
	glbl set
	call 0
	ldloc.1
	st.attr _dirty
	false
	ldloc.1
	st.attr is_dirty
	none
	ret
	
__delitem__: ;runtime/dirty_dict.py
	glbl super
	deref 0
	ldloc.1
	supermethod __delitem__
	ldloc.2
	call.meth 1
	pop
	ldloc.1
	attr _dirty
	method remove
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
__setitem__: ;runtime/dirty_dict.py
	glbl super
	deref 0
	ldloc.1
	supermethod __setitem__
	ldloc.2
	ldloc.3
	call.meth 2
	pop
	ldloc.1
	method _mark_dirty
	ldloc.2
	call.meth 1
	pop
	none
	ret
	
_mark_dirty: ;runtime/dirty_dict.py
	ldloc.0
	attr _dirty
	method add
	ldloc.1
	call.meth 1
	pop
	true
	ldloc.0
	st.attr is_dirty
	none
	ret
	
clear: ;runtime/dirty_dict.py
	glbl super
	deref 0
	ldloc.1
	supermethod clear
	call.meth 0
	pop
	ldloc.1
	attr _dirty
	method clear
	call.meth 0
	pop
	false
	ldloc.1
	st.attr is_dirty
	none
	ret
	
<genexpr>: ;runtime/dirty_dict.py
	null
	ldloc.1
	null
	null
	for.iter 23, 0
	MP_BC_UNPACK_SEQUENCE 2
	stloc.2
	stloc.3
	ldloc.2
	deref 0
	attr _dirty
	in
	bfalse -17
	ldloc.2
	ldloc.3
	tuple 2
	yield
	pop
	jmp -26
	none
	ret
	
dirty_items: ;runtime/dirty_dict.py
	deref 0
	attr is_dirty
	btrue 2
	none
	ret
	ldloc.0
	mkclosure 1, 1
	deref 0
	method items
	call.meth 0
	ld.iter
	call 1
	ld.iter
	none
	yieldfrom
	pop
	deref 0
	attr _dirty
	method clear
	call.meth 0
	pop
	false
	deref 0
	st.attr is_dirty
	none
	ret
	
list_set: ;runtime/dirty_dict.py
	ldloc.2
	glbl range
	glbl len
	ldloc.0
	ldloc.1
	MP_BC_LOAD_SUBSCR
	call 1
	call 1
	in
	bfalse 14
	ldloc.3
	ldloc.0
	ldloc.1
	MP_BC_LOAD_SUBSCR
	ldloc.2
	MP_BC_STORE_SUBSCR
	ldloc.0
	method _mark_dirty
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
list_insert: ;runtime/dirty_dict.py
	ldloc.2
	glbl range
	glbl len
	ldloc.0
	ldloc.1
	MP_BC_LOAD_SUBSCR
	call 1
	129
	add
	call 1
	in
	bfalse 19
	ldloc.0
	ldloc.1
	MP_BC_LOAD_SUBSCR
	method insert
	ldloc.2
	ldloc.3
	call.meth 2
	pop
	ldloc.0
	method _mark_dirty
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
list_append: ;runtime/dirty_dict.py
	ldloc.0
	ldloc.1
	MP_BC_LOAD_SUBSCR
	method append
	ldloc.2
	call.meth 1
	pop
	ldloc.0
	method _mark_dirty
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
list_del: ;runtime/dirty_dict.py
	ldloc.2
	glbl range
	glbl len
	ldloc.0
	ldloc.1
	MP_BC_LOAD_SUBSCR
	call 1
	call 1
	in
	bfalse 15
	ldloc.0
	ldloc.1
	MP_BC_LOAD_SUBSCR
	ldloc.2
	null
	rot3
	MP_BC_STORE_SUBSCR
	ldloc.0
	method _mark_dirty
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
list_clear: ;runtime/dirty_dict.py
	ldloc.0
	ldloc.1
	MP_BC_LOAD_SUBSCR
	method clear
	call.meth 0
	pop
	ldloc.0
	method _mark_dirty
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
dict_set: ;runtime/dirty_dict.py
	ldloc.3
	ldloc.0
	attr setdefault
	ldloc.1
	map 0
	call 2
	ldloc.2
	MP_BC_STORE_SUBSCR
	ldloc.0
	method _mark_dirty
	ldloc.1
	call.meth 1
	pop
	none
	ret
	
dict_get: ;runtime/dirty_dict.py
	ldloc.0
	method get
	ldloc.1
	map 0
	call.meth 2
	method get
	ldloc.2
	ldloc.3
	call.meth 2
	ret
	
DirtyDict: ;runtime/dirty_dict.py
	loadname __name__
	st.name __module__
	str DirtyDict
	st.name __qualname__
	ldloc.0
	mkclosure 0, 1
	st.name __init__
	ldloc.0
	mkclosure 1, 1
	st.name __delitem__
	ldloc.0
	mkclosure 2, 1
	st.name __setitem__
	mkfun 3
	st.name _mark_dirty
	ldloc.0
	mkclosure 4, 1
	st.name clear
	mkfun 5
	st.name dirty_items
	mkfun 6
	st.name list_set
	mkfun 7
	st.name list_insert
	mkfun 8
	st.name list_append
	mkfun 9
	st.name list_del
	mkfun 10
	st.name list_clear
	mkfun 11
	st.name dict_set
	mkfun 12
	st.name dict_get
	ldloc.0
	ret
	
<module>: ;runtime/dirty_dict.py
	buildclass
	mkfun 0
	str DirtyDict
	loadname dict
	call 3
	st.name DirtyDict
	none
	ret
	