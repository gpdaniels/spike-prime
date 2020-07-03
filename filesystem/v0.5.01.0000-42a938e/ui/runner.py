"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import hub
import time

from .boot import shutdown_animation
from .settings import Sounds


LONG_PRESS_MS = 3000


class Runner(object):
    """
    A program runner to start and stop programs. Adds app-like lifecycle
    events and an abstraction over the lower-level device connect/disconnect
    button events. Programs should comply with the interface of the
    Program class.

    Programs are pushed onto a stack with the most recently started (and
    currently running) program at the top of the stack. When quitting a
    program it is removed from the stack, and the Program which is the new
    top of the stack is continued.

    Runner also watches center button down and play the shutdown animation.
    """
    def __init__(self):
        self.stack = []

    def startup(self):
        """
        Initialize everything.
        """
        hub.button.left.on_change(self.on_left_button_change)
        hub.button.right.on_change(self.on_right_button_change)
        hub.button.center.on_change(self.on_center_button_change)

        # Callbacks for when devices are connected/disconnected
        hub.port.A.callback(lambda c: self.device_callback(hub.port.A, c))
        hub.port.B.callback(lambda c: self.device_callback(hub.port.B, c))
        hub.port.C.callback(lambda c: self.device_callback(hub.port.C, c))
        hub.port.D.callback(lambda c: self.device_callback(hub.port.D, c))
        hub.port.E.callback(lambda c: self.device_callback(hub.port.E, c))
        hub.port.F.callback(lambda c: self.device_callback(hub.port.F, c))

    def run_program(self, program):
        """
        Adds a program to the stack and runs it.

        :param Program program: The program to run
        """
        if self.stack:
            current_program = self.get_current_program()
            current_program.on_pause()

        self.stack.append(program)

        program.on_enter()

    def exit_current_program(self):
        """
        Exits the currently running program.
        """
        if self.stack:
            current_program = self.stack.pop()
            current_program.on_exit()

        return_to_program = self.get_current_program()
        return_to_program.on_resume()

    def get_current_program(self):
        """
        Returns the currently running program (if any), or None if no
        program is currently running.

        :return Program: The currently running program
        """
        if self.stack:
            return self.stack[-1]

    def on_left_button_change(self, ms):
        """
        Invoked when the state of the left button changes.

        :param int ms: Time in milliseconds in which the button was pressed.
            A value of zero indicates this was a "button down" event.
            A value greater than zero indicates this was a "button up" event.
        """
        current_program = self.get_current_program()

        if not current_program:
            return

        if ms == 0:
            if hub.button.left.is_pressed():
                current_program.on_left_button_down()
        else:
            current_program.on_left_button_up(ms)

    def on_right_button_change(self, ms):
        """
        Invoked when the state of the right button changes.

        :param int ms: Time in milliseconds in which the button was pressed.
            A value of zero indicates this was a "button down" event.
            A value greater than zero indicates this was a "button up" event.
        """
        current_program = self.get_current_program()

        if not current_program:
            return

        if ms == 0:
            if hub.button.right.is_pressed():
                current_program.on_right_button_down()
        else:
            current_program.on_right_button_up(ms)

    def on_center_button_change(self, ms):
        """
        Invoked when the state of the center button changes.

        :param int ms: Time in milliseconds in which the button was pressed.
            A value of zero indicates this was a "button down" event.
            A value greater than zero indicates this was a "button up" event.
        """
        current_program = self.get_current_program()

        if not current_program:
            return

        if ms == 0:
            if hub.button.center.is_pressed():
                current_program.on_center_button_down()
                start = time.ticks_ms()
                while hub.button.center.is_pressed():
                    now = time.ticks_ms()
                    if 1960 > now - start > 1955:
                        hub.sound.play(Sounds.SHUTDOWN, 16000)
                    elif 5515 < now - start < 5525:
                        shutdown_animation()
        else:
            current_program.on_center_button_up(ms)

    def device_callback(self, port, c):
        """
        Invoked when a device was connected or disconnected from either
        of the six ports.

        :param Port port: A hub.port.X object
        :param int c: An integer value representing the event type.
            A value of 0 means device was disconnected from port.
            A value of 1 means device was connected to port.
        """
        current_program = self.get_current_program()

        if current_program:
            if c == 0:
                current_program.on_device_disconnected(port)
            elif c == 1:
                current_program.on_device_connected(port)


# Singleton
runner = Runner()

