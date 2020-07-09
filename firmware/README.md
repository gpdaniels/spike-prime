# Firmware #

Dumps of the firmware on the SPIKE Prime Hub using the micropython REPL.

The lines below will output a number of bytes of the firmware starting at the provided location, or false if past the end.

```python
import firmware
firmware.flash_read(BYTE_NUMBER)
```

Version numbers are from running the `help(hub)` command on the board.
