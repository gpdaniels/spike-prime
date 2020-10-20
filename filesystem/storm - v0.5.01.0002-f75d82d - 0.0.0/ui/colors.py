
BLACK = (0, 0, 0)
MAGENTA = (255, 7, 20)
PURPLE = (255, 10, 100)
BLUE = (0, 0, 255)
AZURE = (0, 57, 57)
TURQUOISE = (0, 112, 28)
GREEN = (0, 130, 0)
YELLOW = (255, 60, 0)
ORANGE = (255, 15, 0)
RED = (255, 0, 0)
WHITE = (255, 100, 70)


def color_percentage(color, pct):
    """
    Returns a new color as percentage intensity of "color"

    :param (r, g, b) color: The original color
    :param int pct: Desired intensity in percentage
    :return (r, g, b): New color
    """
    return rgb_percentage(*color, pct=pct)


def rgb_percentage(r, g, b, pct):
    """
    Returns a new color as percentage intensity of (r, g, b) color

    :param int r: Red (0-255)
    :param g: Green (0-255)
    :param b: Blue (0-255)
    :param int pct: Desired intensity in percentage
    :return (r, g, b): New color
    """
    pct = (pct / 100)
    return int(r * pct), int(g * pct), int(b * pct)


def get_color_percentage(color, of_color):
    """
    Returns the intensity of a color of color,
    ie. (r, g, b) is X% visible.

    :param color:
    :param of_color:
    :return:
    """
    return get_rgb_percentage(*color, of_color=of_color)


def get_rgb_percentage(r, g, b, of_color):
    """
    Returns the intensity of a (r, g, b) of color,
    ie. (r, g, b) is X% visible.

    :param r:
    :param g:
    :param b:
    :param of_color:
    :return:
    """
    return int(max((r, g, b)) / max(of_color) * 100)


if __name__ == '__main__':
    assert(color_percentage(BLUE, 00) == (0, 0, 00))
    assert(color_percentage(BLUE, 50) == (0, 0, 40))
    assert(color_percentage(BLUE, 100) == (0, 0, 80))

    assert(get_rgb_percentage(0, 0, 00, BLUE) == 0)
    assert(get_rgb_percentage(0, 0, 40, BLUE) == 50)
    assert(get_rgb_percentage(0, 0, 80, BLUE) == 100)

    assert(get_color_percentage(color_percentage(BLUE, 0), BLUE) == 0)
    assert(get_color_percentage(color_percentage(BLUE, 50), BLUE) == 50)
    assert(get_color_percentage(color_percentage(BLUE, 100), BLUE) == 100)
