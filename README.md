# Mindstorms / SPIKE Prime #

|This repository is a collection of useful information about the Lego Mindstorms 51515 and Lego SPIKE Prime hub.|![Mindstorms Robot Inventor Logo](https://raw.githubusercontent.com/gpdaniels/spike-prime/master/simulator/images/icon-mindstorms.png)|![SPIKE Prime Logo](https://raw.githubusercontent.com/gpdaniels/spike-prime/master/simulator/images/icon-spike.png)|
|--|--|--|

## Lego Hub Hardware ##

|                     Part | Description                                                                      |
|-------------------------:|:---------------------------------------------------------------------------------|
|                  **CPU** | STM32F413 (Architecture: ARM Cortex M4, ROM: 1M, RAM: 320k, Clock: 100MHz).      |
|     **Internal storage** | 32MB flash memory (IC: Winbond W25Q256JV).                                       |
|**Wireless connectivity** | Bluetooth supporting 1 BT and 4 BTLE connections (IC: TI CC2564C).               |
|   **Wired connectivity** | Micro USB cable.                                                                 |
|              **Display** | 25 white LEDs in a 5x5 grid and 1 RGB LED (Driver IC: TI TLC5955).               |
|        **Motor Drivers** | 6 motor outputs (Driver ICs: 3 x LB1836).                                        |
|   **Battery Management** | Lithium ion battery management (IC: MPS 2639A).                                  |

## Connecting to the hub ##

To connect to the hub you have two options, a micro USB cable or bluetooth.
Both options create a serial connection between the hub and the computer.
At the hub end of this serial connection is a micropython REPL (Read Evaluate Print Loop).
You can use this REPL to run python commands just like you would in the python interpreter on your computer.

To connect on Linux you will normall use:
- `/dev/ttyACM0` for USB connections.
- `/dev/rfcomm0` for bluetooth connections.

## Directory Content ##

### Filesystem ###

Dumps of the micropython filesystem on the Lego hub using [rshell](https://github.com/dhylands/rshell).

```shell
rshell
> connect serial /dev/ttyACM0 115200
> rsync -a /pyboard ~/filesystem
```

Long version numbers are from running the `help(hub)` command on the board.
Short versions numbers are from the `version.py` files where available.

#### SPIKE Prime ####

|                     Dump | Description                                                                      |
|-------------------------:|:---------------------------------------------------------------------------------|
| **v0.5.01.0000-42a938e** | Initial filesystem (Purchased on: 28/05/2020) (Box Version: 29).                 |
| **v1.0.00.0027-64837e9** | Additional filesystem in 1.0.0 on Windows (Extracted from app.asar).             |
| **v1.0.00.0030-b228d30** | Filesystem from 1.0.0 on Windows (Extracted from app.asar).                      |
| **v1.0.00.0033-268c151** | Filesystem from 1.1.4 on Windows (Extracted from app.asar).                      |
| **v1.0.03.0034-c3879ab** | Updated filesystem using 1.2.0 on Windows(Updated on: 02/07/2020).               |
| **v1.0.06.0034-b0c335b** | Updated filesystem using 1.2.1 on Windows (Updated on: 17/07/2020).              |
| **v1.1.01.0000-6b4a939** | Updated filesystem using 1.3.0 on Windows (Updated on: 01/09/2020).              |
| **v1.1.01.0000-6b4a939** | Updated filesystem using 1.3.1 on Windows (Updated on: 20/10/2020).              |
| **v1.1.01.0002-3e5a121** | Updated filesystem using 1.3.2 on Windows (Updated on: 03/11/2020).              |

#### Mindstorms Robot Inventor ####

|                     Dump | Description                                                                      |
|-------------------------:|:---------------------------------------------------------------------------------|
| **v0.5.01.0002-f75d82d** | Initial filesystem (Purchased on: 16/10/2020).                                   |
| **v1.0.06.0034-b0c335b** | Updated filesystem using 4.0.4-dev.99999 on Windows (Updated on: 20/10/2020).    |

### Firmware ###

Dumps of the firmware on the Lego hub using the micropython REPL.

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
# Install the dfu-util program if you do no already have it.
# sudo apt-get install dfu-util

# List the connected devices, this should show the hub is connected.
sudo dfu-util --list

# Read the firmware.
sudo dfu-util --alt 0 --dfuse-address 0x08000000:1048576 --upload ~/firmware.bin

# Take ownership of the file created by the dfu-util program.
sudo chown $(whoami) firmware.bin

# Remove the first 0x8000 bytes, as these are before the firmware starts.
fallocate -c -o 0 -l 32768 firmware.bin

# Remove the trailing bytes that have the value 0xFF, as these are unnecessary.
sed -i '$ s/\xFF*$//' firmware.bin

# Rename the firmware to the md5 hash of itself.
mv firmware.bin $(md5sum firmware.bin | awk '{ print $1 }').bin
```

Long version numbers are from running the `help(hub)` command on the board.
Short versions numbers are from the `version.py` files where available.

#### SPIKE Prime ####

|                     Dump | Description                                                                      |
|-------------------------:|:---------------------------------------------------------------------------------|
| **v0.5.01.0000-42a938e** | **MISSING** Initial firmware (Purchased on: 28/05/2020) (Box Version: 29).       |
| **v1.0.00.0027-64837e9** | **MISSING** Additional firmware in 1.0.0 on Windows (Extracted from app.asar).   |
| **v1.0.00.0030-b228d30** | Firmware from 1.0.0 on Windows (Extracted from app.asar).                        |
| **v1.0.00.0033-268c151** | Firmware from 1.1.4 on Windows (Extracted from app.asar).                        |
| **v1.0.03.0034-c3879ab** | Updated firmware using 1.2.0 on Windows (Updated on: 02/07/2020).                |
| **v1.0.06.0034-b0c335b** | Updated firmware using 1.2.1 on Windows (Updated on: 17/07/2020).                |
| **v1.1.01.0000-6b4a939** | Updated firmware using 1.3.0 on Windows (Updated on: 01/09/2020).                |
| **v1.1.01.0000-6b4a939** | Updated firmware using 1.3.1 on Windows (Updated on: 20/10/2020).                |
| **v1.1.01.0002-3e5a121** | Updated firmware using 1.3.2 on Windows (Updated on: 03/11/2020).                |

#### Mindstorms Robot Inventor ####

|                     Dump | Description                                                                      |
|-------------------------:|:---------------------------------------------------------------------------------|
| **v0.5.01.0002-f75d82d** | Initial firmware (Purchased on: 16/10/2020).                                     |
| **v1.0.06.0034-b0c335b** | Updated firmware using 4.0.4-dev.99999 on Windows (Updated on: 20/10/2020).      |

### Simulator ###

A recreation of the spike prime hardware using python to allow testing and debugging python scripts on a PC.

The aim is to create a script to dump the functions of the real hardware and then mock them to allow local development.

Currently there is two main scripts one to simulate running micropython scripts on a hub and one to push micropython scripts to a real connected hub.
The simulator uses a mocked implementation of the micropython modules available on the phyical hub that redirect actions to the simulator gui.

|                     File | Description                                                                      |
|-------------------------:|:---------------------------------------------------------------------------------|
|         **simulator.py** | A python3 gui based simulator for the Lego hub.                                  |
|               **run.py** | A python3 script to run a micropython script on a connected Lego hub.            |

### Specifications ###

The Lego specification pdfs for the electrical parts of the Lego hub.

|                     File | Description                                                                      |
|-------------------------:|:---------------------------------------------------------------------------------|
|            **stm32f413** | The microprocessor inside the hub.                                               |
|      **spike-prime-hub** | The main hub.                                                                    |
|  **spike-prime-battery** | Rechargeable lithium ion battery pack for the hub, capacity 2100 mAH.            |
| **medium-angular-motor** | Medium motor with integrated absolute orientation sensor, accuracy +- 3 degrees. |
|  **large-angular-motor** | Large motor with integrated absolute orientation sensor, accuracy +- 3 degrees.  |
|         **force-sensor** | Measures touch, tap, and force up to 10N (About 1Kg) at an accuracy of 0.65N.    |
|         **depth-sensor** | Measures depth to 2m (fast to 30cm) with 1mm resolution. Has 4 white LED outputs.|
|        **colour-sensor** | Measures 8 colours, reflectivity, and ambient light. Has 3 white LED outputs.    |

## License ##

Where documents, code, graphics, binary or any other files have been created by me they are licensed under the MIT license.
Other files that have been pulled from the firmware or filesystem of LEGO products remain licensed by LEGO.

> The MIT License
> 
> Copyright (c) 2020 Geoffrey Daniels. http://gpdaniels.com/
> 
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in
> all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE SOFTWARE.
.
