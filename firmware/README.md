# Firmware #

Dumps of the firmware on the Lego hub using the micropython REPL.

The lines below will output a number of bytes of the firmware starting at the provided location, or false if past the end.

```python
import firmware
firmware.flash_read(BYTE_NUMBER)
```

The first versions of the firmware on the device do not have the firmware library.
To dump these you have to use the DFU tool after booting the device into DFU mode.

To boot the device into DFU mode:

1. Turn the hub off and disconnect the USB wire from your computer.
2. Hold down the bluetooth button and plug in the USB wire to your computer.
3. Keep holding the bluetooth button until it starts flashing in a cycle (pink-green-blue-off).
4. The hub is now in DFU mode.
5. The `dfu-util` program can be used to extract the firmware, see the script below.

```shell
# Install the dfu-util program if you do not already have it.
# sudo apt-get install dfu-util

# List the connected devices, this should show the hub is connected.
sudo dfu-util --list

# Read the firmware.
sudo dfu-util --alt 0 --dfuse-address 0x08000000:1048576 --upload ~/firmware.bin

# Take ownership of the file created by the dfu-util program.
sudo chown $(whoami) ~/firmware.bin

# Remove the first 0x8000 bytes, as these are before the firmware starts.
fallocate -c -o 0 -l 32768 ~/firmware.bin

# Remove the trailing bytes that have the value 0xFF, as these are unnecessary.
sed -i '$ s/\xFF*$//' ~/firmware.bin

# Rename the firmware to the md5 hash of itself.
mv ~/firmware.bin ~/$(md5sum ~/firmware.bin | awk '{ print $1 }').bin
```

Long version numbers are from running the `help(hub)` command on the board.
Short versions numbers are from the `version.py` files where available.

## Disassembly ##

The hub processor is an STM32F413 which is an ARM Cortex M4 and therefore uses the ARMv7E-M instruction set.
ARM Cortex M4 is most commonly little endian.
