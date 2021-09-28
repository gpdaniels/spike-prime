"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import hub

from ui.system import call_soon, cancel, sleep_ms
from ui.program import Program
from ui.images import screenshot

from .row import RowController
from .devices import Device


LEFT = 0
RIGHT = 1

ALL_PORTS = (
    hub.port.A, hub.port.B, hub.port.C,
    hub.port.D, hub.port.E, hub.port.F,
)


class Standalone(Program):
    """
    The Standalone program is the default application programmed onto the
    device in the production stage.

    The program consists of tree (almost independent) rows, each controlled
    by a RowController. The Standalone class is responsible for detecting
    device connect/disconnect and button events, and propagating these to the
    appropriate RowController.

    The heartbeat animation and the advertising of non-connected ports are
    synchronized across the tree rows here in the Standalone class.

    # Advertising ports
    Means to display a single pixel next to each empty port. Is only enabled
    if NO ports have a devices connected.

    # Heartbeat
    Means to display a single pixel next to each empty port and animating
    them off/on for 100 ms. each (flashing).
    """
    def __init__(self):
        self.heartbeat = None
        self.rows = (
            RowController(0),  # Row index 0 of display
            RowController(2),  # Row index 2 of display
            RowController(4),  # Row index 4 of display
        )

    def get_image(self):
        return hub.Image.HEART

    # -- Lifecycle events ----------------------------------------------------

    def on_enter(self):
        """
        Invoked when the default application starts, before any other methods
        are invoked, to signal program start.
        """
        hub.display.clear()

        # Invoke on_enter() on all rows to signal program start
        for row in self.rows:
            row.on_enter()

        if not self._any_devices_connected():
            self._enable_advertise_ports()
            self._start_heartbeat()

        # Make sure to register all devices which are already connected.
        # Devices connected later will be registered with on_device_connected.
        for port in ALL_PORTS:
            if self._has_device_connected(port):
                self.on_device_connected(port)

    def on_exit(self):
        """
        Invoked as the last thing before the default application exists.
        """
        # Stop animations
        if self.heartbeat:
            self._stop_heartbeat()

        # Invoke on_exit() on all rows to signal program exit
        for row in self.rows:
            row.on_exit()

        # Take a screenshot of the current screen and fade the image out
        hub.display.show(screenshot(), fade=6)

    # -- Device connect/disconnect events ------------------------------------

    def on_device_connected(self, port):
        """
        Invoked when a devices was connected to any of the six ports.
        Detect device based on its type id and propagate the event to
        the appropriate RowController.

        Ignores devices which it can't detect/does not support.

        :param Port port: The hub.port.X object which device
            was connected to
        """
        device = Device.from_port(port)

        if device:
            self._disable_advertise_ports()
            self._stop_heartbeat()

            row = self._get_row(port)
            side = self._get_side(port)

            device.on_connect()

            if side is LEFT:
                row.on_connected_left(device)
            elif side is RIGHT:
                row.on_connected_right(device)

    def on_device_disconnected(self, port):
        """
        Invoked when a devices was disconnected to any of the six ports.
        Propagate the event to the appropriate RowController.

        :param Port port: The hub.port.X object which device
            was disconnected from
        """
        if not self._any_devices_connected():
            self._enable_advertise_ports()
            self._start_heartbeat()

        row = self._get_row(port)
        side = self._get_side(port)

        if side is LEFT:
            row.on_disconnected_left()
        elif side is RIGHT:
            row.on_disconnected_right()

    # -- Button events -------------------------------------------------------

    def on_center_button_up(self, time):
        self.exit()

    def on_left_button_down(self):
        for row in self.rows:
            row.on_left_button_down()

    def on_left_button_up(self, time):
        for row in self.rows:
            row.on_left_button_up()

    def on_right_button_down(self):
        for row in self.rows:
            row.on_right_button_down()

    def on_right_button_up(self, time):
        for row in self.rows:
            row.on_right_button_up()

    # -- Device row/side/port logic ------------------------------------------

    def _get_row(self, port):
        """
        Identify which RowController a specific port belongs to based on
        which vertical row its physically connected to.

        :param Port port: The hub.port.X object
        :return RowController: An instance of one of the tree RowControllers
        """
        if port in (hub.port.A, hub.port.B):
            return self.rows[0]
        elif port in (hub.port.C, hub.port.D):
            return self.rows[1]
        elif port in (hub.port.E, hub.port.F):
            return self.rows[2]

        raise RuntimeError((
            'Trying to identify row failed. The requested port was not '
            'recognized. Did you pass a hub.port.X object to get_row()?'
        ))

    def _get_side(self, port):
        """
        Identify which side (left or right) a specific port is physically
        located on the device.

        :param Port port: The hub.port.X object
        :return int: LEFT or RIGHT
        """
        if port in (hub.port.A, hub.port.C, hub.port.E):
            return LEFT
        elif port in (hub.port.B, hub.port.D, hub.port.F):
            return RIGHT

        raise RuntimeError((
            'Trying to identify port side failed. The requested port was not '
            'recognized. Did you pass a hub.port.X object to get_side()?'
        ))

    def _any_devices_connected(self):
        """
        Checks is any devices are connected to either of the siz ports.

        :return bool: Whether minimum one device is connected
        """
        return any(self._has_device_connected(port) for port in ALL_PORTS)

    def _has_device_connected(self, port):
        """
        Checks if a devices is connected to a specific port.

        :param Port port: The hub.port.X object
        :return bool: Whether a device is connected to the port
        """
        return port.info()['type'] is not None

    # -- Heartbeat/port advertising ------------------------------------------

    def _enable_advertise_ports(self):
        """
        Enable advertising of empty ports.
        """
        for row in self.rows:
            row.set_advertise_ports(True)

    def _disable_advertise_ports(self):
        """
        Disable advertising of empty ports.
        """
        for row in self.rows:
            row.set_advertise_ports(False)

    def _start_heartbeat(self):
        """
        Start the heartbeat animation.
        """
        if not self.heartbeat:
            self.heartbeat = self._run_heartbeat_loop()
            call_soon(self.heartbeat)

    def _stop_heartbeat(self):
        """
        Stop the heartbeat animation if its currently running.
        """
        if self.heartbeat:
            cancel(self.heartbeat)
            self.heartbeat = None

    async def _run_heartbeat_loop(self):
        """
        Runs the heartbeat animation by starting it on each row with a delay.
        """
        while self.heartbeat:
            try:
                await sleep_ms(5000)
            except AttributeError:
                # uasyncio bug resulting in AttributeError when cancelled
                break

            for row in self.rows:
                try:
                    await row.run_heartbeat()
                except AttributeError:
                    # uasyncio bug resulting in AttributeError when cancelled
                    break

                try:
                    await sleep_ms(1000)
                except AttributeError:
                    # uasyncio bug resulting in AttributeError when cancelled
                    break

