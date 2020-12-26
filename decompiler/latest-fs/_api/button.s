__init__: ;_api/button.py
	ldloc.1
	ldloc.0
	st.attr _button
	none
	ret
	
is_pressed: ;_api/button.py
	ldloc.0
	attr _button
	method is_pressed
	call.meth 0
	ret
	
was_pressed: ;_api/button.py
	ldloc.0
	attr _button
	method was_pressed
	call.meth 0
	ret
	
wait_until_pressed: ;_api/button.py
	jmp 0
	ldloc.0
	method is_pressed
	call.meth 0
	bfalse -9
	none
	ret
	
wait_until_released: ;_api/button.py
	jmp 0
	ldloc.0
	method is_pressed
	call.meth 0
	btrue -9
	none
	ret
	
Button: ;_api/button.py
	loadname __name__
	st.name __module__
	str Button
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name is_pressed
	mkfun 2
	st.name was_pressed
	mkfun 3
	st.name wait_until_pressed
	mkfun 4
	st.name wait_until_released
	none
	ret
	
<module>: ;_api/button.py
	buildclass
	mkfun 0
	str Button
	call 2
	st.name Button
	none
	ret
	