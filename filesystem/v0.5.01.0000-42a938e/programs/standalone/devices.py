"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import hub


MOTOR_MEDIUM = 48
MOTOR_LARGE = 49
COLOR_SENSOR = 61
ULTRASOUND_SENSOR = 62
TOUCH_SENSOR = 63
TILT_SENSOR = 34


class Device(object):
    """
    Base class for all devices supported by the application.
    All devices should inherit from this class and only implement the
    methods that are relevant for it.
    """

    @staticmethod
    def from_port(port, *args, **kwargs):
        return Device.from_device_type(
            port.info()['type'], port, *args, **kwargs)

    @staticmethod
    def from_device_type(device_type, *args, **kwargs):
        """
        Identifies and instantiates a Device from its type id.
        Returns None if device type id is not supported.

        :param int device_type: Device type ID
        :param args: Positional parameters to Device
        :param kwargs: Keywords parameters to Device
        :return Device: An instance of a Device class
        """
        if device_type is COLOR_SENSOR:
            return Color(*args, **kwargs)
        elif device_type is TOUCH_SENSOR:
            return TouchButton(*args, **kwargs)
        elif device_type is ULTRASOUND_SENSOR:
            return UltraSound(*args, **kwargs)
        elif device_type is TILT_SENSOR:
            return TiltSensor(*args, **kwargs)
        elif device_type in (MOTOR_MEDIUM, MOTOR_LARGE):
            return Motor(*args, **kwargs)

        return None

    def __init__(self, port):
        self.port = port

    def get_port(self):
        """
        Get the port which the device is connected to.

        :return Port: A hub.port.X object
        """
        return self.port

    def on_connect(self):
        """
        Invoked when device has been connected to a port
        """
        self.setup()

    def is_sensor(self):
        """
        Check if device is a sensor.

        :return bool: Whether or not device is a sensor
        """
        return False

    def is_actuator(self):
        """
        Check if device is a actuator.

        :return bool: Whether or not device is a actuator
        """
        return False

    def setup(self):
        """
        Invoked when the device has to setup its port properties (modes etc.)
        """
        pass

    def get_value(self):
        """
        Gets the current value of the device. This method must return its
        value in percent as an integer in the interval [-100;100].

        :return int: Device value in the interval [-100;100]
        """
        return 0

    def set_value(self, value):
        """
        Sets the value of the device.

        :param int value: The value to set on device (0-100)
        """
        pass

    def set_value_delta(self, delta):
        """
        Sets the value of the device relative to its current value. Device
        should increment or decrement according to the given delta.

        :param int delta: A positive or negative number to add to the
            device' current value
        """
        pass


class Color(Device):
    """
    The Color sensor reads positive-only values.
    """
    def is_sensor(self):
        return True

    def setup(self):
        port = self.get_port()
        port.device.mode(0)

    def get_value(self):
        try:
            device = self.get_port().device
        except AttributeError:
            # This happens if the device is disconnected
            # when trying to read its value
            return None
        else:
            value = device.get(0)[0]

            if value in (-1, None):
                return 0
            elif value == 0:
                # Black returns 0
                return 1
            else:
                return value * 10


class UltraSound(Device):
    """
    Reads values as percentage.
    """
    def is_sensor(self):
        return True

    def setup(self):
        port = self.get_port()
        port.device.mode(1)

    def get_value(self):
        try:
            device = self.get_port().device
        except AttributeError:
            # This happens if the device is disconnected
            # when trying to read its value
            return None

        # Reads distance in percentage
        value = device.get(1)[0]

        if value in (-1, None):
            return 0
        else:
            return 100 - value


class TouchButton(Device):
    """
    The TouchButton sensor reads positive-only values.
    """
    def is_sensor(self):
        return True

    def setup(self):
        port = self.get_port()
        port.device.mode(0)

    def get_value(self):
        """
        Returns percentage (0-100)
        """
        try:
            device = self.get_port().device
        except AttributeError:
            # This happens if the device is disconnected
            # when trying to read its value
            return None
        else:
            return device.get(0)[0]


class TiltSensor(Device):
    """
    TiltSensor can read values in the interval [-45;45].
    Reads tilt in two directions but only one are used here.
    """
    def is_sensor(self):
        return True

    def setup(self):
        port = self.get_port()
        port.device.mode(0)

    def get_value(self):
        try:
            device = self.get_port().device
        except AttributeError:
            # This happens if the device is disconnected
            # when trying to read its value
            return None

        # A number in the interval [-45;45]
        actual_value = device.get(0)[0]

        if actual_value is None:
            actual_value = 0

        # The table which device is placed may not be completely leveled
        # Treat values -2 to 2 as zero.
        elif -2 <= actual_value <= 2:
            actual_value = 0

        return actual_value / 45 * 100


class Motor(Device):
    """
    The motor can have its value set in the interval [-100;100].
    """
    def __init__(self, *args, **kwargs):
        super(Motor, self).__init__(*args, **kwargs)
        self.value = 0

    def is_actuator(self):
        return True

    def setup(self):
        port = self.get_port()
        port.motor.mode(0)

    def reverse(self):
        return self.get_port() in (hub.port.A, hub.port.C, hub.port.E)

    def set_value(self, value):
        self.value = min(100, max(-100, int(value)))

        port = self.get_port()
        if value == 0:
            port.motor.float()
        else:
            # Reverse direction for motors connected to one side of the hub
            if self.reverse():
                value = self.value * -1
            else:
                value = self.value

            port.motor.run_at_speed(value)

    def set_value_delta(self, delta):
        self.set_value(self.value + delta)

