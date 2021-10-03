import gc
import micropython

import hub_runtime

micropython.alloc_emergency_exception_buf(256)

hub_runtime.start()
