"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import hub

from ui.system import call_soon, cancel, sleep_ms

from .display import DisplayController


class RowController(object):
    """
    A controller for a single row in the interface of the default application.
    A row consists of two device ports and five horizontal pixels.

    RowController is responsible for all event handling and state management
    of devices connected to either of the two ports. It uses a
    DisplayController to control the five pixels in the row to display
    the current state of (and interaction between) the devices.

    RowController is also responsible for connecting devices connected to the
    two ports, passing on sensor values to actuators and handling button
    events (left and right).

    Each device (self.left and self.right) is represented by a Device object.
    If no device is connected then self.left and/or self.right is None.

    # Advertising ports
    Means to display a single pixel next to each empty port.

    # Heartbeat
    Means to display a single pixel next to each empty port and animating
    them off/on for 100 ms. each (flashing).

    # Adjust
    A corouting running which adjust the values of actuators every 100 ms.
    as long as either the left or right button is pressed down.
    """
    def __init__(self, index):
        self.display = DisplayController(index)
        self.running = False
        self.adjust = None
        self.heartbeat = None

        # Whether or not to advertice ports when no devices are connected
        self.advertise_ports = True

        # The Device object connected to the left slot (if any)
        self.left = None

        # The coroutine reading sensor values from left Device
        # if it's connected and is a sensor
        self.left_read = None

        # The last read sensor value from the left Device
        self.left_value = 0

        # The Device object connected to the right slot (if any)
        self.right = None

        # The coroutine reading sensor values from right Device
        # if it's connected and is a sensor
        self.right_read = None

        # The last read sensor value from the right Device
        self.right_value = 0

    # -- Lifecycle events ----------------------------------------------------

    def on_enter(self):
        """
        Invoked when the default application starts, before any other methods
        are invoked, to signal program start.
        """
        self.running = True
        self._update_display()

    def on_exit(self):
        """
        Invoked as the last thing before the default application exists.
        """
        self.running = False

        # Stop ongoing animation
        self.display.animation.stop()

        # Stop reading sensor values from these devices
        if self.left_read:
            cancel(self.left_read)
            self.left_read = None
        if self.right_read:
            cancel(self.right_read)
            self.right_read = None

        # Stop adjusting actuator values
        if self.adjust:
            cancel(self.adjust)
            self.adjust = None

        if self.left:
            self.left.set_value(0)
            self.left = None
        if self.right:
            self.right.set_value(0)
            self.right = None

        self.left_value = 0
        self.right_value = 0

    # -- Device connect/disconnect events ------------------------------------

    def on_connected_left(self, device):
        """
        Invoked when a new device is connected to the left port by the user.

        :param Device device: The device which was connected
        """
        self.left = device

        # If this is a sensor being connected start reading values from it
        if device.is_sensor():
            self.left_read = read_sensor_input(
                device, self.on_left_value_changed)
            call_soon(self.left_read)

        if device.is_actuator():
            device.set_value(self.right_value)

        self._update_display()

    def on_connected_right(self, device):
        """
        Invoked when a new device is connected to the right port by the user.

        :param Device device: The device which was connected
        """
        self.right = device

        # If this is a sensor being connected start reading values from it
        if device.is_sensor():
            self.right_read = read_sensor_input(
                device, self.on_right_value_changed)
            call_soon(self.right_read)

        if device.is_actuator():
            device.set_value(self.left_value)

        self._update_display()

    def on_disconnected_left(self):
        """
        Invoked when the user disconnects the device in the left port.
        """
        # Make sure this method won't fail even if invoked when no left
        # device connected
        if not self.left:
            return

        # Stop reading sensor values from this device
        if self.left_read:
            cancel(self.left_read)
            self.left_read = None

        # Set other device' value to zero if this was a sensor
        if self.left.is_sensor() and self.right:
            self.right.set_value(0)

        self.left = None
        self.left_value = 0
        self._update_display()

    def on_disconnected_right(self):
        """
        Invoked when the user disconnects the device in the right port.
        """
        # Make sure this method won't fail even if invoked when no left
        # device connected
        if not self.right:
            return

        # Stop reading sensor values from this device
        if self.right_read:
            cancel(self.right_read)
            self.right_read = None

        # Set other device' value to zero if this was a sensor
        if self.right.is_sensor() and self.left:
            self.left.set_value(0)

        self.right = None
        self.right_value = 0
        self._update_display()

    # -- Button events -------------------------------------------------------

    def on_left_button_down(self):
        """
        Invoked when the user presses down the left button.
        This triggers the adjust coroutine which decreases the values of
        actuators connected to either of the two ports (if any).

        If the user has pressed down both left and right buttons at the same
        time, then the values are reset in stead of running the coroutine.
        """
        if hub.button.right.is_pressed():
            # Both buttons are pressed down
            self._reset_values()
            return

        def _predicate():
            return (hub.button.left.is_pressed()
                    and not hub.button.right.is_pressed())

        self._update_display()
        self.adjust = self._adjust_actuator_value(_predicate, -10)
        call_soon(self.adjust)

    def on_left_button_up(self):
        """
        Invoked when the user no longer presses down the left button.
        Stop the adjust coroutine if it's running to stop adjusting
        the actuator values.
        """
        if self.adjust:
            cancel(self.adjust)
            self.adjust = None
        self._update_display()

    def on_right_button_down(self):
        """
        Invoked when the user presses down the left button.
        This triggers the adjust coroutine which increase the values of
        actuators connected to either of the two ports (if any).

        If the user has pressed down both left and right buttons at the same
        time, then the values are reset in stead of running the coroutine.
        """
        if hub.button.left.is_pressed():
            # Both buttons are pressed down
            self._reset_values()
            return

        def _predicate():
            return (hub.button.right.is_pressed()
                    and not hub.button.left.is_pressed())

        self._update_display()
        self.adjust = self._adjust_actuator_value(_predicate, 10)
        call_soon(self.adjust)

    def on_right_button_up(self):
        """
        Invoked when the user no longer presses down the right button.
        Stop the adjust coroutine if it's running to stop adjusting
        the actuator values.
        """
        if self.adjust:
            cancel(self.adjust)
            self.adjust = None
        self._update_display()

    def _should_update_value(self, device, other_device):
        """
        Determines whether a device should have its value updated when
        pressing either the left or right button.

        The value should only be updated if its value is not controlled by a
        sensor. That is, if the other device is not a sensor, ie. don't reset
        right device if left device is a sensor and vice versa.

        :param Device device: The device to check for
        :param Device other_device: The device connected to the other port
        :return bool: Whether to update the value of device
        """
        return (device and device.is_actuator()
                and (not other_device or not other_device.is_sensor()))

    def _reset_values(self):
        """
        This method is invoked when the user has pressed down both buttons.
        Reset the value of actuator(s) connected (if required to).
        """
        if self._should_update_value(self.left, self.right):
            self.left.set_value(0)
        if self._should_update_value(self.right, self.left):
            self.right.set_value(0)

    async def _adjust_actuator_value(self, predicate, step):
        """
        Keeps adjusting the values of connected devices by a delta of "size"
        as long a predicate() returns True.

        :param func predicate: Runs until this functions returns False
        :param int step: Delta value to increment each step (may be negative)
        """
        while predicate() and self.running:
            if self._should_update_value(self.left, self.right):
                self.left.set_value_delta(step)
            if self._should_update_value(self.right, self.left):
                self.right.set_value_delta(step)

            try:
                await sleep_ms(100)
            except AttributeError:
                # uasyncio bug resulting in AttributeError when cancelled
                break

    # -- Sensor values changed events ----------------------------------------

    def on_left_value_changed(self, value):
        """
        Invoked when the devices connected to the left port has changed its
        value - ie. it's a sensor.

        This is a callback method invoked by an asynchronous coroutine.
        Timing may result in the method being invoked after on_exit() has
        been invoked by the program, so make sure we only do anything
        if we're still running.

        :param int value: Sensor value in the interval [-100;100]
        """
        if self.running:
            self.left_value = int(round(min(100, max(-100, value))))

            if self.right and self.right.is_actuator():
                self.right.set_value(self.left_value)

            self._update_display()

    def on_right_value_changed(self, value):
        """
        Invoked when the devices connected to the right port has changed its
        value - ie. it's a sensor.

        This is a callback method invoked by an asynchronous coroutine.
        Timing may result in the method being invoked after on_exit() has
        been invoked by the program, so make sure we only do anything
        if we're still running.

        :param int value: Sensor value in the interval [-100;100]
        """
        if self.running:
            self.right_value = int(round(min(100, max(-100, value))))

            if self.left and self.left.is_actuator():
                self.left.set_value(self.right_value)

            self._update_display()

    # -- Display logic -------------------------------------------------------

    def set_advertise_ports(self, advertise_ports):
        """
        Enable/disable advertising of ports.

        :param bool advertise_ports: Whether or not to advertise ports
            when no devices are connected.
        """
        self.advertise_ports = advertise_ports
        self._update_display()

    async def run_heartbeat(self):
        """
        A corouting running the heartbeat animation.
        """
        images = (
            (0, 0, 0, 0, 9),
            (9, 0, 0, 0, 9),
            (9, 0, 0, 0, 0),
            (9, 0, 0, 0, 9),
        )

        delays = (100, 100, 100, 0)

        for image, delay in zip(images, delays):
            self.display.draw(*image)

            if delay:
                try:
                    await sleep_ms(100)
                except AttributeError:
                    # uasyncio bug resulting in AttributeError when cancelled
                    return

    def _update_display(self):
        """
        Updates the display according to the current state of the row
        and the currently connected devices.
        """

        # Both left and right device connected
        if self.left and self.right:
            if self.left.is_sensor() and self.right.is_sensor():
                self.display.sensor_sensor()
            elif self.left.is_actuator() and self.right.is_actuator():
                self.display.actuator_actuator(
                    hub.button.left.is_pressed()
                    or hub.button.right.is_pressed())
            elif self.left.is_sensor() and self.right.is_actuator():
                self.display.sensor_left_actuator_right()
            elif self.left.is_actuator() and self.right.is_sensor():
                self.display.sensor_right_actuator_left()
            else:
                self.display.clear()

        # Only left device connected
        elif self.left:
            if self.left.is_sensor():
                self.display.sensor_left(self.left_value)
            elif self.left.is_actuator():
                self.display.actuator_left(
                    hub.button.left.is_pressed()
                    or hub.button.right.is_pressed())
            else:
                self.display.clear()

        # Only right device connected
        elif self.right:
            if self.right.is_sensor():
                self.display.sensor_right(self.right_value)
            elif self.right.is_actuator():
                self.display.actuator_right(
                    hub.button.left.is_pressed()
                    or hub.button.right.is_pressed())
            else:
                self.display.clear()

        # No devices connected
        else:
            if self.advertise_ports:
                self.display.advertise_ports()
            else:
                self.display.clear()


async def read_sensor_input(device, callback):
    """
    Keeps reading values from a device in intervals of 50 ms. as this is the
    speed at which devices can deliver them.

    :param Device device: The device to get values from
    :param func callback: A function to invoke after each reading
    """
    last_read_value = None

    while 1:
        value = device.get_value()

        if value is not None and value != last_read_value:
            callback(value)
            last_read_value = value

        try:
            await sleep_ms(50)
        except AttributeError:
            # uasyncio bug resulting in AttributeError when cancelled
            break

