color_percentage: ;util/color.py
	glbl rgb_percentage
	str pct
	ldloc.1
	ldloc.0
	null
	call.kw 130, 0
	ret
	
rgb_percentage: ;util/color.py
	ldloc.3
	int 128, 100
	truediv
	stloc.3
	glbl int
	ldloc.0
	ldloc.3
	mul
	call 1
	glbl int
	ldloc.1
	ldloc.3
	mul
	call 1
	glbl int
	ldloc.2
	ldloc.3
	mul
	call 1
	tuple 3
	ret
	
get_color_percentage: ;util/color.py
	glbl get_rgb_percentage
	str of_color
	ldloc.1
	ldloc.0
	null
	call.kw 130, 0
	ret
	
get_rgb_percentage: ;util/color.py
	glbl int
	glbl max
	ldloc.0
	ldloc.1
	ldloc.2
	tuple 3
	call 1
	glbl max
	ldloc.3
	call 1
	truediv
	int 128, 100
	mul
	call 1
	ret
	
<module>: ;util/color.py
	128
	128
	128
	tuple 3
	st.name BLACK
	int 129, 127
	136
	151
	tuple 3
	st.name VIOLET
	128
	128
	int 128, 80
	tuple 3
	st.name BLUE
	128
	int 57
	int 57
	tuple 3
	st.name AZURE
	128
	int 129, 67
	128
	tuple 3
	st.name GREEN
	int 129, 127
	163
	128
	tuple 3
	st.name YELLOW
	int 129, 127
	128
	128
	tuple 3
	st.name RED
	int 129, 127
	int 128, 70
	163
	tuple 3
	st.name WHITE
	int 129, 7
	153
	138
	tuple 3
	st.name DIM_WHITE
	mkfun 0
	st.name color_percentage
	mkfun 1
	st.name rgb_percentage
	mkfun 2
	st.name get_color_percentage
	mkfun 3
	st.name get_rgb_percentage
	loadname __name__
	str __main__
	eq
	bfalse 0
	none
	ret
	