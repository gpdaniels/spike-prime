reverse_image: ;projects/standalone_/animation.py
	glbl tuple
	glbl reversed
	ldloc.0
	call 1
	call 1
	ret
	
<genexpr>: ;projects/standalone_/animation.py
	null
	ldloc.0
	null
	null
	for.iter 12, 0
	stloc.1
	glbl reverse_image
	ldloc.1
	call 1
	yield
	pop
	jmp -15
	none
	ret
	
reverse_animation: ;projects/standalone_/animation.py
	glbl tuple
	mkfun 1
	ldloc.0
	ld.iter
	call 1
	call 1
	ret
	
__init__: ;projects/standalone_/animation.py
	ldloc.1
	ldloc.0
	st.attr display
	ldloc.2
	ldloc.0
	st.attr system
	none
	ldloc.0
	st.attr runner
	none
	ldloc.0
	st.attr animation
	128
	ldloc.0
	st.attr current
	none
	ret
	
start: ;projects/standalone_/animation.py
	ldloc.0
	method stop
	call.meth 0
	pop
	ldloc.1
	ldloc.0
	st.attr animation
	true
	ldloc.0
	attr animation
	st.attr _running
	ldloc.0
	method _run_animation
	ldloc.1
	ldloc.2
	ldloc.0
	attr current
	call.meth 3
	ldloc.0
	st.attr runner
	ldloc.0
	attr system
	attr loop
	method call_soon
	ldloc.0
	attr runner
	call.meth 1
	pop
	none
	ret
	
stop: ;projects/standalone_/animation.py
	ldloc.0
	dup
	attr current
	129
	add.in
	rot
	st.attr current
	ldloc.0
	attr animation
	bfalse 8
	false
	ldloc.0
	attr animation
	st.attr _running
	ldloc.0
	attr runner
	bfalse 15
	glbl cancel
	ldloc.0
	attr runner
	call 1
	pop
	none
	ldloc.0
	st.attr runner
	none
	ret
	
_run_animation: ;projects/standalone_/animation.py
	ldloc.2
	bfalse 29
	except.setup 6, 0
	ldloc.2
	yield
	pop
	except.jump 20, 0
	dup
	glbl AttributeError
	ematch
	bfalse 11
	pop
	false
	ldloc.1
	st.attr _running
	none
	ret
	except.jump 1, 0
	finally.end
	ldloc.1
	ld.iterstack
	for.iter 64, 0
	stloc.4
	ldloc.3
	ldloc.0
	attr current
	ne
	bfalse 7
	pop
	pop
	pop
	pop
	jmp 47
	ldloc.0
	attr display
	method draw
	ldloc.4
	null
	call.kvmeth 0
	pop
	except.setup 9, 0
	ldloc.1
	attr sleep
	yield
	pop
	except.jump 20, 0
	dup
	glbl AttributeError
	ematch
	bfalse 11
	pop
	false
	ldloc.1
	st.attr _running
	none
	ret
	except.jump 1, 0
	finally.end
	jmp -67
	false
	ldloc.1
	st.attr _running
	none
	ret
	
AnimationController: ;projects/standalone_/animation.py
	loadname __name__
	st.name __module__
	str AnimationController
	st.name __qualname__
	mkfun 0
	st.name __init__
	128
	tuple 1
	null
	mkfun.defargs 1
	st.name start
	mkfun 2
	st.name stop
	mkfun 3
	st.name _run_animation
	none
	ret
	
__init__: ;projects/standalone_/animation.py
	glbl tuple
	ldloc.1
	call 1
	ldloc.0
	st.attr _images_original
	128
	ldloc.0
	st.attr _next_index
	false
	ldloc.0
	st.attr _running
	glbl tuple
	ldloc.1
	call 1
	ldloc.0
	st.attr images
	ldloc.2
	ldloc.0
	st.attr loop
	ldloc.3
	ldloc.0
	st.attr sleep
	none
	ret
	
__iter__: ;projects/standalone_/animation.py
	ldloc.0
	attr loop
	bfalse 7
	ldloc.0
	method loop_images_infinitely
	call.meth 0
	ret
	glbl iter
	ldloc.0
	attr images
	call 1
	ret
	none
	ret
	
loop_images_infinitely: ;projects/standalone_/animation.py
	ldloc.0
	attr _next_index
	glbl len
	ldloc.0
	attr images
	call 1
	mod
	stloc.1
	ldloc.0
	dup
	attr _next_index
	129
	add.in
	rot
	st.attr _next_index
	ldloc.0
	attr images
	ldloc.1
	MP_BC_LOAD_SUBSCR
	yield
	pop
	jmp -37
	none
	ret
	
is_running: ;projects/standalone_/animation.py
	ldloc.0
	attr _running
	ret
	
reset: ;projects/standalone_/animation.py
	128
	ldloc.0
	st.attr _next_index
	none
	ret
	
forward: ;projects/standalone_/animation.py
	ldloc.0
	attr _images_original
	ldloc.0
	st.attr images
	none
	ret
	
backward: ;projects/standalone_/animation.py
	glbl reverse_animation
	ldloc.0
	attr _images_original
	call 1
	ldloc.0
	st.attr images
	none
	ret
	
Animation: ;projects/standalone_/animation.py
	loadname __name__
	st.name __module__
	str Animation
	st.name __qualname__
	false
	int 50
	tuple 2
	null
	mkfun.defargs 0
	st.name __init__
	mkfun 1
	st.name __iter__
	mkfun 2
	st.name loop_images_infinitely
	mkfun 3
	st.name is_running
	mkfun 4
	st.name reset
	mkfun 5
	st.name forward
	mkfun 6
	st.name backward
	none
	ret
	
__init__: ;projects/standalone_/animation.py
	glbl super
	glbl SingleSensorAnimation
	ldloc.0
	call 2
	method __init__
	str loop
	true
	str sleep
	int 129, 72
	str images
	137
	128
	128
	128
	128
	tuple 5
	137
	137
	128
	128
	128
	tuple 5
	137
	128
	137
	128
	128
	tuple 5
	137
	128
	128
	137
	128
	tuple 5
	137
	128
	128
	128
	137
	tuple 5
	tuple 5
	call.meth 134, 0
	pop
	none
	ret
	
SingleSensorAnimation: ;projects/standalone_/animation.py
	loadname __name__
	st.name __module__
	str SingleSensorAnimation
	st.name __qualname__
	mkfun 0
	st.name __init__
	none
	ret
	
__init__: ;projects/standalone_/animation.py
	glbl super
	glbl SingleActuatorAnimation
	ldloc.0
	call 2
	method __init__
	str loop
	true
	str sleep
	int 129, 72
	str images
	none
	128
	128
	128
	137
	tuple 5
	none
	128
	128
	137
	128
	tuple 5
	none
	128
	137
	128
	128
	tuple 5
	none
	137
	128
	128
	128
	tuple 5
	none
	128
	128
	128
	128
	tuple 5
	tuple 5
	call.meth 134, 0
	pop
	none
	ret
	
SingleActuatorAnimation: ;projects/standalone_/animation.py
	loadname __name__
	st.name __module__
	str SingleActuatorAnimation
	st.name __qualname__
	mkfun 0
	st.name __init__
	none
	ret
	
__init__: ;projects/standalone_/animation.py
	glbl super
	glbl SensorActuatorAnimation
	ldloc.0
	call 2
	method __init__
	str sleep
	int 60
	str images
	135
	137
	137
	137
	137
	tuple 5
	137
	135
	137
	137
	137
	tuple 5
	137
	137
	135
	137
	137
	tuple 5
	137
	137
	137
	135
	137
	tuple 5
	137
	137
	137
	137
	135
	tuple 5
	137
	137
	137
	137
	137
	tuple 5
	tuple 6
	call.meth 132, 0
	pop
	none
	ret
	
SensorActuatorAnimation: ;projects/standalone_/animation.py
	loadname __name__
	st.name __module__
	str SensorActuatorAnimation
	st.name __qualname__
	mkfun 0
	st.name __init__
	none
	ret
	
<module>: ;projects/standalone_/animation.py
	129
	str cancel
	tuple 1
	import.nm util
	import.from cancel
	st.name cancel
	pop
	mkfun 0
	st.name reverse_image
	mkfun 1
	st.name reverse_animation
	buildclass
	mkfun 2
	str AnimationController
	loadname object
	call 3
	st.name AnimationController
	buildclass
	mkfun 3
	str Animation
	loadname object
	call 3
	st.name Animation
	buildclass
	mkfun 4
	str SingleSensorAnimation
	loadname Animation
	call 3
	st.name SingleSensorAnimation
	buildclass
	mkfun 5
	str SingleActuatorAnimation
	loadname Animation
	call 3
	st.name SingleActuatorAnimation
	buildclass
	mkfun 6
	str SensorActuatorAnimation
	loadname Animation
	call 3
	st.name SensorActuatorAnimation
	none
	ret
	