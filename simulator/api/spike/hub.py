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



class Motor():
    def __init__(self, ):
        self.velocity = 0

    def default(self):
        pass

    def mode(self, state):
        pass

    def pid(self):
        pass

    def get(self):
        pass

    def pwm(self, pwm):
        pass  # self.velocity = pwm

    def preset(self, preset):
        pass

    def brake(self):
        pass

    def float(self):
        pass

    def hold(self):
        pass

    def run_at_speed(self, speed, max_power, acceleration, deceleration, stall):
        pass

    def run_for_degrees(self, degrees, speed):
        simulator_gui.ports[self.my_port].widget_run_for_degrees(degrees, speed)


    def run_to_position(self, degrees, speed):
        # print(f"{self.my_port=}")
        # simulator_gui.ports[self.my_port].angle.set(degrees)
        simulator_gui.ports[self.my_port].widget_run_to_position(degrees, speed)


    def run_for_time(self, time, speed):
        simulator_gui.ports[self.my_port].widget_run_for_time(time, speed)

    def busy(self, param):  # param might be time
        ret = simulator_gui.ports[self.my_port].running
        print(f"busy {ret=}")
        return ret

    def callback(self, param):  # param not sure
        pass

# This class connects simulation Widgets to their relevant accessories
class Port():
    def __init__(self):
        accessories = (None, Motor())
        configured_ports = simulator_gui.create_ports_on_hub(accessories)
        for key, widget_name, portref, my_class in configured_ports:
            instance = type(my_class)()
            # print(f"{key=}  {widget_name=}  {portref=}  {instance=}")
            setattr(self, key, portref)  # Setting main PortRef 'A', 'B' etc
            name = f"{key}.{widget_name}"
            parent, child = name.split('.')

            port_attr = getattr(self, parent)
            setattr(port_attr, child, instance)  # Setting our sub attribute.
            child_attr = getattr(port_attr, child)
            # print(f"   {port_attr=}  {child_attr=}")
            if child_attr:
                setattr(child_attr, 'my_port', key)

port = Port()
#print(dir(port))