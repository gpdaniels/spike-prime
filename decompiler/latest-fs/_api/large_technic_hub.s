light_matrix: ;_api/large_technic_hub.py
	ldloc.0
	attr _light_matrix
	ret
	
status_light: ;_api/large_technic_hub.py
	ldloc.0
	attr _status_light
	ret
	
left_button: ;_api/large_technic_hub.py
	ldloc.0
	attr _left_button
	ret
	
right_button: ;_api/large_technic_hub.py
	ldloc.0
	attr _right_button
	ret
	
motion_sensor: ;_api/large_technic_hub.py
	ldloc.0
	attr _motion_sensor
	ret
	
speaker: ;_api/large_technic_hub.py
	ldloc.0
	attr _speaker
	ret
	
LargeTechnicHub: ;_api/large_technic_hub.py
	loadname __name__
	st.name __module__
	str LargeTechnicHub
	st.name __qualname__
	loadname LightMatrix
	call 0
	st.name _light_matrix
	loadname StatusLight
	call 0
	st.name _status_light
	loadname Button
	loadname hub
	attr button
	attr left
	call 1
	st.name _left_button
	loadname Button
	loadname hub
	attr button
	attr right
	call 1
	st.name _right_button
	loadname MotionSensor
	call 0
	st.name _motion_sensor
	loadname Speaker
	call 0
	st.name _speaker
	loadname property
	mkfun 0
	call 1
	st.name light_matrix
	loadname property
	mkfun 1
	call 1
	st.name status_light
	loadname property
	mkfun 2
	call 1
	st.name left_button
	loadname property
	mkfun 3
	call 1
	st.name right_button
	loadname property
	mkfun 4
	call 1
	st.name motion_sensor
	loadname property
	mkfun 5
	call 1
	st.name speaker
	str A
	st.name PORT_A
	str B
	st.name PORT_B
	str C
	st.name PORT_C
	str D
	st.name PORT_D
	str E
	st.name PORT_E
	str F
	st.name PORT_F
	none
	ret
	
<module>: ;_api/large_technic_hub.py
	128
	none
	import.nm hub
	st.name hub
	129
	str LightMatrix
	tuple 1
	import.nm lightmatrix
	import.from LightMatrix
	st.name LightMatrix
	pop
	129
	str StatusLight
	tuple 1
	import.nm statuslight
	import.from StatusLight
	st.name StatusLight
	pop
	129
	str Button
	tuple 1
	import.nm button
	import.from Button
	st.name Button
	pop
	129
	str MotionSensor
	tuple 1
	import.nm motionsensor
	import.from MotionSensor
	st.name MotionSensor
	pop
	129
	str Speaker
	tuple 1
	import.nm speaker
	import.from Speaker
	st.name Speaker
	pop
	buildclass
	mkfun 0
	str LargeTechnicHub
	call 2
	st.name LargeTechnicHub
	none
	ret
	