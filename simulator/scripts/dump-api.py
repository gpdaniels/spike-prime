# Get all available modules
# help("modules")
module_names = [ "micropython", "uhashlib", "uselect", "_onewire", "sys", "uheapq", "ustruct", "builtins", "uarray", "uio", "utime", "cmath", "ubinascii", "ujson", "utimeq", "firmware", "ubluetooth", "umachine", "uzlib", "gc", "ucollections", "uos", "hub", "uctypes", "urandom", "math", "uerrno", "ure" ]

# List of objects to be processed.
object_list_todo = list()
object_list_done = list()

# Loop over the builtin modules.
for object_name in module_names:
    # Add them to the object list to be processed.
    object_list_todo.append((object_name, __import__(object_name)))
    object_list_done.append(object_name)

# Loop over all objects.
while len(object_list_todo) > 0:
    object_name, object_handle = object_list_todo.pop(0)

    # Reserve space in map, and ensure checks for whether we already have this module pass. 
    object_map = dict()
    
    # Get contents of object.
    object_entries = dir(object_handle)
    
    # Loop over all entries in the object.
    for object_entry in object_entries:
        # Add them to the map for output.
        object_map[object_entry] = (type(getattr(object_handle, object_entry)).__name__, str(getattr(object_handle, object_entry)))

        # Add them to the object list to be processed.
        if (not object_entry in object_list_done):
            # Add them to the list for further processing if they are not a base type.
            if ((not isinstance(getattr(object_handle, object_entry), (str, float, int, list, dict, set))) and (not type(getattr(object_handle, object_entry)).__name__ == "function")):
                object_list_todo.append((object_entry, getattr(object_handle, object_entry)))
                object_list_done.append(object_entry)
            
    print("{} = {}".format(object_name, object_map))
