"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
from hub import Image

from .images import DISPLAY_WIDTH


def chain_animations(*animations):
    """
    Chains multiple animations into a single animation sequence.
    """
    for animation in animations:
        yield from animation


def shift_out_to_left(image):
    """
    Creates an animation where "image" is shifted from center
    of display out of the screen to the left.
    """
    for i in range(DISPLAY_WIDTH + 1):
        yield Image.shift_left(image, i)


def shift_out_to_right(image):
    """
    Creates an animation where "image" is shifted from center
    of display out of the screen to the right.
    """
    for i in range(DISPLAY_WIDTH + 1):
        yield Image.shift_right(image, i)


def shift_out_to_top(image):
    """
    Creates an animation where "image" is shifted from center
    of display out of the screen upwards.
    """
    for i in range(DISPLAY_WIDTH + 1):
        yield Image.shift_up(image, i)


def shift_out_to_bottom(image):
    """
    Creates an animation where "image" is shifted from center
    of display out of the screen downwards.
    """
    for i in range(DISPLAY_WIDTH + 1):
        yield Image.shift_down(image, i)


def shift_in_from_left(image):
    """
    Creates an animation where "image" is shifted from left
    of the display and in to the center of the display.
    """
    for i in reversed(range(DISPLAY_WIDTH + 1)):
        yield Image.shift_left(image, i)


def shift_in_from_right(image):
    """
    Creates an animation where "image" is shifted from right
    of the display and in to the center of the display.
    """
    for i in reversed(range(DISPLAY_WIDTH + 1)):
        yield Image.shift_right(image, i)


def shift_in_from_top(image):
    """
    Creates an animation where "image" is shifted from top
    of the display down in to the center of the display.
    """
    for i in reversed(range(DISPLAY_WIDTH + 1)):
        yield Image.shift_up(image, i)


def shift_in_from_bottom(image):
    """
    Creates an animation where "image" is shifted from bottom
    of the display up in to the center of the display.
    """
    for i in reversed(range(DISPLAY_WIDTH + 1)):
        yield Image.shift_down(image, i)


def shift_left(start_image, end_image):
    return chain_animations(
        shift_out_to_left(start_image),
        shift_in_from_right(end_image),
    )


def shift_right(start_image, end_image):
    return chain_animations(
        shift_out_to_right(start_image),
        shift_in_from_left(end_image),
    )
