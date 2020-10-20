"""
This product is released under the MIT License (MIT)

Copyright (c) 2019, LEGO System A/S, Aastvej 1, 7190 Billund, Denmark

See LICENSE.txt for the full MIT license notice.
"""
import hub


DISPLAY_WIDTH = 5
DISPLAY_HEIGHT = 5


def screenshot():
    """
    Take a screenshot of the current screen and return the Image.

    :return Image: An image representing the current pixels on the screen
    """
    rows = []

    for row_i in range(DISPLAY_HEIGHT):
        row = []

        for column_i in range(DISPLAY_WIDTH):
            row.append(hub.display.get_pixel(column_i, row_i))

        rows.append(''.join(str(pixel) for pixel in row))

    return hub.Image(':'.join(rows))
