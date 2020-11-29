from hub import led
from utime import sleep

# Save current LED colour.
current_colour = led()

# The LEDs can be set to one of the built in colours:
# 0  = black/off
# 1  = pink
# 2  = purple
# 3  = blue
# 4  = cyan
# 5  = turquoise
# 6  = green
# 7  = yellow
# 8  = orange
# 9  = red
# 10 = grey
# 11 = white
for colour_code in range(11):
    led(colour_code)
    print(led())
    sleep(0.5)

# Colour conversion function to convert HSV to RGB.
def hsv_to_rgb(hue, saturation, value):
    if saturation == 0.0:
        return (value, value, value)
    hue_segment = int(hue * 6.0)
    hue_offset = (hue * 6.0) - hue_segment
    p = (value * (1.0 - saturation))
    q = (value * (1.0 - saturation * hue_offset))
    t = (value * (1.0 - saturation * (1.0 - hue_offset)))
    hue_segment %= 6
    if hue_segment == 0: return (value, t, p)
    if hue_segment == 1: return (q, value, p)
    if hue_segment == 2: return (p, value, t)
    if hue_segment == 3: return (p, q, value)
    if hue_segment == 4: return (t, p, value)
    if hue_segment == 5: return (value, p, q)

# Display each hue colour on the LED.
for hue in range(360):
    r, g, b = hsv_to_rgb(float(hue) / 360.0, 1.0, 1.0)
    led(int(255 * r), int(255 * g), int(255 * b))
    sleep(0.01)

# Restore the initial led colour.
led(current_colour)
