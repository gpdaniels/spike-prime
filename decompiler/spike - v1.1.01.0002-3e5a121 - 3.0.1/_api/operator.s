greater_than: ;_api/operator.py
	ldloc.0
	ldloc.1
	qt
	ret
	
greater_than_or_equal_to: ;_api/operator.py
	ldloc.0
	ldloc.1
	qe
	ret
	
less_than: ;_api/operator.py
	ldloc.0
	ldloc.1
	lt
	ret
	
less_than_or_equal_to: ;_api/operator.py
	ldloc.0
	ldloc.1
	le
	ret
	
equal_to: ;_api/operator.py
	ldloc.0
	ldloc.1
	eq
	ret
	
not_equal_to: ;_api/operator.py
	ldloc.0
	ldloc.1
	ne
	ret
	
<module>: ;_api/operator.py
	mkfun 0
	st.name greater_than
	mkfun 1
	st.name greater_than_or_equal_to
	mkfun 2
	st.name less_than
	mkfun 3
	st.name less_than_or_equal_to
	mkfun 4
	st.name equal_to
	mkfun 5
	st.name not_equal_to
	none
	ret
	