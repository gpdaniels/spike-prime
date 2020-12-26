PrimeHub: ;spike/__init__.py
	loadname __name__
	st.name __module__
	str PrimeHub
	st.name __qualname__
	none
	ret
	
<module>: ;spike/__init__.py
	128
	str *
	tuple 1
	import.nm _api
	import.all
	128
	str large_technic_hub
	tuple 1
	import.nm _api
	import.from large_technic_hub
	st.name large_technic_hub
	pop
	buildclass
	mkfun 0
	str PrimeHub
	loadname large_technic_hub
	attr LargeTechnicHub
	call 3
	st.name PrimeHub
	none
	ret
	