import simulator_gui

# 'hub': {
#   'display': 'Display',
#   'config': 'dict',
#   'repl_restart': 'function',
#   'BT_VCP': 'type',
#   'bluetooth': 'bluetooth',
#   'TOP': 'int',
#   '__class__': 'type',
#   'sound': 'Sound',
#   'temperature': 'function',
#   'status': 'function',
#   'battery': 'Battery',
#   '__version__': 'str',
#   'motion': 'Motion',
#   'LEFT': 'int',
#   'supervision': 'supervision',
#   'USB_VCP': 'type',
#   '__name__': 'str',
#   'BACK': 'int',
#   'led': 'function',
#   'BOTTOM': 'int',
#   'reset': 'function',
#   'powerdown_timeout': 'function',
#   'Image': 'type',
#   'RIGHT': 'int',
#   'button': 'type',
#   'file_transfer': 'function',
#   'info': 'function',
#   'power_off': 'function',
#   'FRONT': 'int',
#   'port': 'type'
# }

def repl_restart():
    pass


def temperature():
    return simulator_gui.get_temperature()


def status():
    pass


def led(*arguments):
    if (len(arguments) == 0):
        # Get current colour.
        return simulator_gui.get_led()
    if (len(arguments) == 1):
        # Set from colour list.
        if (arguments[0] == 0): simulator_gui.set_led(0, 0, 0)
        elif (arguments[0] == 1): simulator_gui.set_led(255, 7, 20)
        elif (arguments[0] == 2): simulator_gui.set_led(255, 10, 100)
        elif (arguments[0] == 3): simulator_gui.set_led(0, 0, 80)
        elif (arguments[0] == 4): simulator_gui.set_led(0, 57, 57)
        elif (arguments[0] == 5): simulator_gui.set_led(0, 112, 28)
        elif (arguments[0] == 6): simulator_gui.set_led(0, 80, 0)
        elif (arguments[0] == 7): simulator_gui.set_led(255, 35, 0)
        elif (arguments[0] == 8): simulator_gui.set_led(255, 15, 0)
        elif (arguments[0] == 9): simulator_gui.set_led(255, 0, 0)
        elif (arguments[0] == 10): simulator_gui.set_led(255, 70, 35)
        else: simulator_gui.set_led(102, 28, 14)
    if (len(arguments) == 3):
        # Set from RGB
        simulator_gui.set_led(arguments[0], arguments[1], arguments[2])


def reset():
    pass


def powerdown_timeout():
    pass


class Motion():
    def yaw_pitch_roll(self):
        return simulator_gui.get_yaw_pitch_roll()

    def accelerometer(self):
        pass

    def gyroscope(self):
        pass

    def orientation(self):
        pass

    def gesture(self):
        pass


motion = Motion()
