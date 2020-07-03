"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
from ui.runner import runner


class Program(object):
    """
    A base class for programs running through the Runner.
    """
    def exit(self):
        runner.exit_current_program()

    # -- Program lifecycle events --------------------------------------------

    def get_image(self):
        """
        Returns the image/icon to display for this program while in the menu.

        :return Image: Image/icon for this program
        """
        pass

    def on_enter(self):
        """
        Invoked when entering the program.
        """
        pass

    def on_exit(self):
        """
        Invoked when exiting the program.
        """
        pass

    def on_pause(self):
        """
        Invoked when pausing this program to enter another.
        """
        pass

    def on_resume(self):
        """
        Invoked when exiting another program and returning to this one.
        """
        pass

    # -- Device connect/disconnect events ------------------------------------

    def on_device_connected(self, port):
        """
        Invoked when a device was connected to a port.

        :param Port port: A hub.port.X object which device was connected to.
        """
        pass

    def on_device_disconnected(self, port):
        """
        Invoked when a devices was disconnected from a port.

        :param Port port: A hub.port.X object which device was disconnected from.
        :return:
        """
        pass

    # -- Left button events --------------------------------------------------

    def on_left_button_down(self):
        pass

    def on_left_button_up(self, time):
        pass

    # -- Right button events -------------------------------------------------

    def on_right_button_down(self):
        pass

    def on_right_button_up(self, time):
        pass

    # -- Center button events ------------------------------------------------

    def on_center_button_down(self):
        pass

    def on_center_button_up(self, time):
        pass

