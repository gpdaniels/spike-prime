"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import hub

from .animation import (
    AnimationController,
    SingleSensorAnimation,
    SingleActuatorAnimation,
    SensorActuatorAnimation,
    reverse_image,
)


class DisplayController(object):
    """
    A controller for a single row of pixels in the display.

    DisplayController is used by a RowController to control how its row of
    pixels are displayed according to the RowController's current state.
    DisplayController keeps track of the current state of the display and
    only acts accordingly, ie. does not run animations if they are already
    running etc.

    DisplayController uses an AnimationController to start/stop animations.
    """
    def __init__(self, index):
        self.index = index
        self.animation = AnimationController(self)
        self.sensor_animation = SingleSensorAnimation()
        self.actuator_animation = SingleActuatorAnimation()
        self.sensor_actuator_animation = SensorActuatorAnimation()

    def draw(self, *pixels):
        """
        Draw a set of pixels onto the display. Each pixel may have an
        integer value of 0-9, or None. None values are ignored and the
        current pixel on the display is kept as is.

        This example only draws the three right-most pixels on the display:
            draw(None, None, 9, 6, 9)

        This example only draw the two left-most pixels on the display:
            draw(6, 9)

        :param [int] pixels: An iterator of integers
        """
        for column, pixel in enumerate(pixels[:5]):
            if pixel is not None:
                hub.display.set_pixel(column, self.index, pixel)

    def clear(self):
        """
        Clears the entire row of the display.
        """
        self.animation.stop()
        self.draw(0, 0, 0, 0, 0)

    def advertise_ports(self):
        self.animation.stop()
        self.draw(9, 0, 0, 0, 9)

    def sensor_left(self, sensor_value):
        if sensor_value != 0:
            # Draw sensor value in percent across the screen
            self.animation.stop()
            self.draw(*_pct_to_pixels(sensor_value))
        elif not self.sensor_animation.is_running():
            self.sensor_animation.forward()
            self.sensor_animation.reset()
            self.animation.start(self.sensor_animation, 1000)
            self.draw(*self.sensor_animation.images[0])

    def sensor_right(self, sensor_value):
        if sensor_value != 0:
            # Draw sensor value in percent across the screen
            self.animation.stop()
            self.draw(*reverse_image(_pct_to_pixels(sensor_value)))
        elif not self.sensor_animation.is_running():
            self.sensor_animation.backward()
            self.sensor_animation.reset()
            self.animation.start(self.sensor_animation, 1000)
            self.draw(*self.sensor_animation.images[0])

    def actuator_left(self, button_pressed):
        self.draw(6 if button_pressed else 9)

        if not self.actuator_animation.is_running():
            self.actuator_animation.forward()
            self.actuator_animation.reset()
            self.animation.start(self.actuator_animation)

    def actuator_right(self, button_pressed):
        self.draw(None, None, None, None, 6 if button_pressed else 9)

        if not self.actuator_animation.is_running():
            self.actuator_animation.backward()
            self.actuator_animation.reset()
            self.animation.start(self.actuator_animation)

    def sensor_sensor(self):
        self.animation.stop()
        self.draw(9, 9, 0, 9, 9)

    def actuator_actuator(self, button_pressed):
        self.animation.stop()

        if button_pressed:
            self.draw(6, 6, 0, 6, 6)
        else:
            self.draw(9, 9, 0, 9, 9)

    def actuator_actuator_left_button_down(self):
        self.animation.stop()
        self.draw(5, 5, 0, 9, 9)

    def actuator_actuator_right_button_down(self):
        self.animation.stop()
        self.draw(9, 9, 0, 5, 5)

    def sensor_left_actuator_right(self):
        if not self.sensor_actuator_animation.is_running():
            self.sensor_actuator_animation.forward()
            self.sensor_actuator_animation.reset()
            self.animation.stop()
            self.animation.start(self.sensor_actuator_animation)

    def sensor_right_actuator_left(self):
        if not self.sensor_actuator_animation.is_running():
            self.sensor_actuator_animation.backward()
            self.sensor_actuator_animation.reset()
            self.animation.stop()
            self.animation.start(self.sensor_actuator_animation)


def _pct_to_pixels(percentage):
    p = abs(percentage)

    if p > 90:
        pixels = (9, 9, 9, 9, 9)
    elif p > 80:
        pixels = (9, 9, 9, 9, 6)
    elif p > 70:
        pixels = (9, 9, 9, 9, 0)
    elif p > 60:
        pixels = (9, 9, 9, 6, 0)
    elif p > 50:
        pixels = (9, 9, 9, 0, 0)
    elif p > 40:
        pixels = (9, 9, 6, 0, 0)
    elif p > 30:
        pixels = (9, 9, 0, 0, 0)
    elif p > 20:
        pixels = (9, 6, 0, 0, 0)
    elif p > 10:
        pixels = (9, 0, 0, 0, 0)
    elif p > 0:
        pixels = (9, 0, 0, 0, 0)
    else:
        pixels = (9, 0, 0, 0, 0)

    if percentage < 0:
        pixels = tuple(reversed(pixels))

    return pixels

