"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import hub
import time

from ui.runner import runner
from ui.program import Program
from ui.system import call_soon, cancel, sleep_ms
from ui.settings import Sounds, LONG_PRESS_MS
from ui.colors import BLUE, color_percentage, get_color_percentage
from ui.animations import (
    shift_left,
    shift_right,
    shift_out_to_bottom,
    shift_in_from_bottom,
)


class Menu(Program):
    """
    Menu (also known as UI) is a horizontal scrollable selection of programs.
    The user can use the left- and right buttons to scroll through programs
    and use the center button to enter the currently selected program.

    When the user presses and holds either left or right button the scrolling
    continues uninterrupted. When the user has held either of the two buttons
    for a certain period of time then scrolling speeds up.
    """
    def __init__(self):
        self.current_index = 0
        self.programs = []
        self.led_fade_in_out = None
        self.led_fade = None

    def add_program(self, program):
        self.programs.append(program)

    def on_enter(self):
        hub.sound.volume(10)

        # Fade in the initial image
        current_program = self.get_current_program()
        current_image = current_program.get_image()
        hub.display.show(current_image, fade=2)

        # Start LED fading in animation
        self.led_fade = call_soon(led_fade_to(BLUE, 100, 1))

    def on_exit(self):
        # Stop all LED animations before exiting
        if self.led_fade:
            cancel(self.led_fade)
            self.led_fade = None
        if self.led_fade_in_out:
            cancel(self.led_fade_in_out)
            self.led_fade_in_out = None

    def on_pause(self):
        current_program = self.get_current_program()
        current_image = current_program.get_image()
        animation = shift_out_to_bottom(current_image)

        hub.sound.play(Sounds.PROGRAM_START, 16000)
        hub.display.show(animation, delay=44)

        # Stop LED fade in animation
        if self.led_fade:
            cancel(self.led_fade)
            self.led_fade = None

        # Start LED fading in and out animation
        self.led_fade_in_out = call_soon(led_fade_in_out())

    def on_resume(self):
        current_program = self.get_current_program()
        current_image = current_program.get_image()
        animation = shift_in_from_bottom(current_image)

        hub.sound.play(Sounds.PROGRAM_STOP, 16000)
        hub.display.show(animation, delay=44)

        # Stop LED fading in and out animation
        if self.led_fade_in_out:
            cancel(self.led_fade_in_out)
            self.led_fade_in_out = None

        # Start LED fade in animation
        self.led_fade = call_soon(led_fade_to(BLUE, 100, 1))

    def get_current_program(self):
        if self.programs:
            actual_index = self.current_index % len(self.programs)
            return self.programs[actual_index]

    def on_center_button_up(self, time):
        runner.run_program(self.get_current_program())

    def on_left_button_down(self):
        self.loop_through_programs(
            hub.button.left.is_pressed, shift_right, -1)

    def on_right_button_down(self):
        self.loop_through_programs(
            hub.button.right.is_pressed, shift_left, 1)

    def loop_through_programs(self, predicate, create_animation, index_delta):
        start = time.ticks_ms()

        while predicate():
            previous_program = self.get_current_program()
            self.current_index += index_delta
            current_program = self.get_current_program()

            if time.ticks_ms() - start <= LONG_PRESS_MS:
                # Default delay time and sound
                delay = 33
                sound = Sounds.NAVIGATION
            else:
                # After LONG_PRESS (milliseconds) speed things up a bit
                delay = 25
                sound = Sounds.NAVIGATION_FAST

            animation = create_animation(
                previous_program.get_image(),
                current_program.get_image())

            hub.sound.play(sound, 16000)
            hub.display.show(animation, wait=True, delay=delay)

            time.sleep(0.05)


async def led_fade_to(color, target_pct, step_delay=4):
    """
    Fades the LED diode of the center button to a certain value of intensity
    in steps with a sleep in between each step.

    :param int target_value: Target intensity (0 = off, 65535 = max bright)
    :param int step_size: Increment/decrement in steps of this size
    """
    start_color = hub.led()
    start_pct = get_color_percentage(start_color, color)

    if start_pct < target_pct:
        step_size = 1
    elif start_pct > target_pct:
        step_size = -1
    else:
        return

    for pct in range(start_pct, target_pct, step_size):
        hub.led(*color_percentage(color, pct))

        try:
            await sleep_ms(step_delay)
        except AttributeError:
            # uasyncio bug resulting in AttributeError when cancelled
            return


async def led_fade_in_out():
    """
    Keeps fading the LED of the center button in and out.
    """
    while True:
        try:
            await led_fade_to(BLUE, 100)
            await led_fade_to(BLUE, 0)
        except AttributeError:
            # uasyncio bug resulting in AttributeError when cancelled
            break
