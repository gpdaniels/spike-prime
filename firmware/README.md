# Firmware #

Dumps of the firmware on the SPIKE Prime Hub using the micropython REPL.

The lines below will output a number of bytes of the firmware starting at the provided location, or false if past the end.

```python
import firmware
firmware.flash_read(BYTE_NUMBER)
```

Version numbers are from running the `help(hub)` command on the board.

## Disassembly ##

The hub processor is an STM32F413 which is an ARM Cortex M4 and therefore uses the ARMv7E-M instruction set.
ARM Cortex M4 is most commonly little endian.
