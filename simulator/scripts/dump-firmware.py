import firmware

byte_index = 0
while True:
    firmware_bytes = firmware.flash_read(byte_index)
    if (firmware_bytes == False):
        break;
    print(firmware_bytes)
    byte_index += 32
