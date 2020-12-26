__init__: ;commands/abstract_handler.py
	ldloc.1
	ldloc.0
	st.attr _rpc
	none
	ret
	
get_methods: ;commands/abstract_handler.py
	none
	ret
	
AbstractHandler: ;commands/abstract_handler.py
	loadname __name__
	st.name __module__
	str AbstractHandler
	st.name __qualname__
	none
	st.name _rpc
	mkfun 0
	st.name __init__
	mkfun 1
	st.name get_methods
	none
	ret
	
<module>: ;commands/abstract_handler.py
	buildclass
	mkfun 0
	str AbstractHandler
	call 2
	st.name AbstractHandler
	none
	ret
	