get_event_loop: ;event_loop/__init__.py
	glbl _EVENT_LOOP
	none
	is
	bfalse 8
	glbl EventLoop
	call 0
	st.glbl _EVENT_LOOP
	glbl _EVENT_LOOP
	ret
	
<module>: ;event_loop/__init__.py
	129
	str EventLoop
	tuple 1
	import.nm event_loop
	import.from EventLoop
	st.name EventLoop
	pop
	none
	st.glbl _EVENT_LOOP
	mkfun 0
	st.name get_event_loop
	none
	ret
	