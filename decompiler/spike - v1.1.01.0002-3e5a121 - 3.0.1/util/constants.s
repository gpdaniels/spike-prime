Sounds: ;util/constants.py
	loadname __name__
	st.name __module__
	str Sounds
	st.name __qualname__
	constobj 0
	st.name NAVIGATION
	constobj 1
	st.name NAVIGATION_FAST
	constobj 2
	st.name PROGRAM_START
	constobj 3
	st.name PROGRAM_STOP
	constobj 4
	st.name STARTUP
	constobj 5
	st.name SHUTDOWN
	none
	ret
	
<module>: ;util/constants.py
	128
	none
	import.nm hub
	st.name hub
	128
	str Image
	tuple 1
	import.nm hub
	import.from Image
	st.name Image
	pop
	128
	str const
	tuple 1
	import.nm micropython
	import.from const
	st.name const
	pop
	map 6
	loadname hub
	attr port
	attr A
	str A
	st.map
	loadname hub
	attr port
	attr B
	str B
	st.map
	loadname hub
	attr port
	attr C
	str C
	st.map
	loadname hub
	attr port
	attr D
	str D
	st.map
	loadname hub
	attr port
	attr E
	str E
	st.map
	loadname hub
	attr port
	attr F
	str F
	st.map
	st.name PORTS
	loadname hub
	method USB_VCP
	call.meth 0
	st.name USB_VCP
	loadname hub
	method BT_VCP
	call.meth 0
	st.name BT_VCP
	int 128, 65
	st.name LPF2_FLIPPER_MOTOR_SMALL
	int 48
	st.name LPF2_FLIPPER_MOTOR_MEDIUM
	int 49
	st.name LPF2_FLIPPER_MOTOR_LARGE
	int 61
	st.name LPF2_FLIPPER_COLOR
	int 62
	st.name LPF2_FLIPPER_DISTANCE
	int 63
	st.name LPF2_FLIPPER_FORCE
	int 57
	st.name LPF2_ACCELERATION
	int 58
	st.name LPF2_GYRO
	int 59
	st.name LPF2_ORIENTATION
	int 128, 75
	st.name LPF2_STONE_GREY_MOTOR_MEDIUM
	int 128, 76
	st.name LPF2_STONE_GREY_MOTOR_LARGE
	int 128, 65
	int 48
	int 49
	int 128, 75
	int 128, 76
	tuple 5
	st.name MOTOR_TYPES
	127
	st.name NO_STATUS
	128
	st.name SUCCESS
	129
	st.name INTERRUPTED
	130
	st.name STALLED
	128
	st.name FLOAT
	129
	st.name BRAKE
	130
	st.name HOLD
	127
	st.name NO_KEY
	128
	st.name NUMBER
	129
	st.name STRING
	130
	st.name BOOLEAN
	map 3
	loadname const
	128
	call 1
	128
	st.map
	str 
	129
	st.map
	false
	130
	st.map
	st.name VAR_DEFAULTS
	int 151, 56
	st.name LONG_PRESS_MS
	int 146, 167, 96
	st.name INACTIVE_SHUTDOWN_MS
	int 128, 201, 159, 0
	st.name INACTIVE_SHUTDOWN_BT_MS
	144
	st.name TIMER_PACE_HIGH
	int 48
	st.name TIMER_PACE_LOW
	buildclass
	mkfun 21
	str Sounds
	loadname object
	call 3
	st.name Sounds
	loadname Image
	attr HEART
	loadname Image
	attr GO_RIGHT
	tuple 2
	st.name DEFAULT_IMAGE
	loadname Image
	constobj 0
	call 1
	loadname Image
	constobj 1
	call 1
	loadname Image
	constobj 2
	call 1
	loadname Image
	constobj 3
	call 1
	loadname Image
	constobj 4
	call 1
	loadname Image
	constobj 5
	call 1
	loadname Image
	constobj 6
	call 1
	loadname Image
	constobj 7
	call 1
	loadname Image
	constobj 8
	call 1
	loadname Image
	constobj 9
	call 1
	loadname Image
	constobj 10
	call 1
	loadname Image
	constobj 11
	call 1
	loadname Image
	constobj 12
	call 1
	loadname Image
	constobj 13
	call 1
	loadname Image
	constobj 14
	call 1
	loadname Image
	constobj 15
	call 1
	loadname Image
	constobj 16
	call 1
	loadname Image
	constobj 17
	call 1
	loadname Image
	constobj 18
	call 1
	loadname Image
	constobj 19
	call 1
	tuple 20
	st.name SLOTS_IMAGE
	constobj 20
	st.name LOCAL_NAME
	str /data
	st.name DATA_DIR
	loadname DATA_DIR
	str /linegraph
	add
	st.name LINEGRAPH_DIR
	none
	ret
	