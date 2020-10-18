# Get all available modules
# help("modules")
module_names = [ "__main__", "micropython", "uhashlib", "uselect", "_onewire", "sys", "uheapq", "ustruct", "builtins", "uarray", "uio", "utime", "cmath", "ubinascii", "ujson", "utimeq", "firmware", "ubluetooth", "umachine", "uzlib", "gc", "ucollections", "uos", "hub", "uctypes", "urandom", "math", "uerrno", "ure" ]

# Recursively add classes and modules to a dict.
def map_object(everything_map, object_name, object_handle):
    object_contents = dir(object_handle)
    object_map = dict();
    for object_entry_name in object_contents:
        object_entry_type = type(getattr(object_handle, object_entry_name)).__name__
        object_map[object_entry_name] = object_entry_type
        if ((not object_entry_name == "__class__") and (not object_entry_name in everything_map)):
            if ((object_entry_type == "module") or (isinstance(getattr(object_handle, object_entry_name), type))):
                #print("Processing {} from {}.".format(object_entry_name, object_name))
                everything_map = map_object(everything_map, object_entry_name, getattr(object_handle, object_entry_name))
    everything_map[object_name] = object_map
    return everything_map

# Map of all objects.
everything_map = dict()

# Loop over the builtin modules.
for module_name in module_names:
    #print("Processing module {}.".format(module_name))
    everything_map = map_object(everything_map, module_name, __import__(module_name))

print(everything_map)
