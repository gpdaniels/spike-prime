__init__: ;runtime/multimotor.py
	ldloc.1
	ldloc.0
	st.attr vm
	128
	ldloc.0
	st.attr target
	128
	ldloc.0
	st.attr done
	none
	ret
	
callback: ;runtime/multimotor.py
	deref 0
	attr vm
	attr store
	method motor_last_status
	deref 1
	ldloc.2
	call.meth 2
	pop
	deref 0
	dup
	attr done
	129
	add.in
	rot
	st.attr done
	none
	ret
	
run: ;runtime/multimotor.py
	deref 0
	dup
	attr target
	129
	add.in
	rot
	st.attr target
	ldloc.0
	ldloc.1
	mkclosure 3, 2
	stloc.5
	ldloc.2
	str callback
	ldloc.5
	ldloc.3
	ldloc.4
	call.kw 130, 0
	pop
	none
	ret
	
await_all: ;runtime/multimotor.py
	none
	yield
	pop
	jmp 3
	138
	yield
	pop
	ldloc.0
	attr done
	ldloc.0
	attr target
	ne
	btrue -15
	none
	ret
	
MultiMotor: ;runtime/multimotor.py
	loadname __name__
	st.name __module__
	str MultiMotor
	st.name __qualname__
	mkfun 0
	st.name __init__
	mkfun 1
	st.name run
	mkfun 2
	st.name await_all
	none
	ret
	
<module>: ;runtime/multimotor.py
	buildclass
	mkfun 0
	str MultiMotor
	call 2
	st.name MultiMotor
	none
	ret
	