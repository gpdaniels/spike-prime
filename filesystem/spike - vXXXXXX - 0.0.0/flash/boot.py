# boot.py -- run on boot to configure USB and filesystem
# Put app code in main.py

import micropython, hub
micropython.alloc_emergency_exception_buf(128)
hub.config["hub_os_enable"] = True
