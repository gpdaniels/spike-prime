from hub import display
from hub import Image
from utime import sleep

# Save the current display.
# The '[:]' is needed to ensure the string is actually copied.
# Otherwise updates to the display will change the variable.
current_display = display.show()[:]

# Clear clears the image, but not the rotation.
display.clear()

# There's a lot of included images:
# - ALL_ARROWS = [ ARROW_E, ARROW_N, ARROW_NE, ARROW_NW, ARROW_S, ARROW_SE, ARROW_SW, ARROW_W ]
# - GO_DOWN, GO_LEFT, GO_RIGHT, GO_UP
# - ALL_CLOCKS = [ CLOCK1, CLOCK2, CLOCK3, CLOCK4, CLOCK5, CLOCK6, CLOCK7, CLOCK8, CLOCK9, CLOCK10, CLOCK11, CLOCK12 ]
# - ANGRY, ASLEEP, CONFUSED, FABULOUS, HAPPY, MEH, SAD, SILLY, SKULL, SMILE, SURPRISED
# - CHESSBOARD, DIAMOND, DIAMOND_SMALL, HEART, HEART_SMALL, TRIANGLE, TRIANGLE_LEFT, SQUARE, SQUARE_SMALL
# - HOUSE, PACMAN, PITCHFORK, ROLLERSKATE, SWORD, TARGET, TSHIRT, UMBRELLA
# - BUTTERFLY, COW, DUCK, GHOST, GIRAFFE, RABBIT, SNAKE, STICKFIGURE, TORTOISE
# - MUSIC_CROTCHET, MUSIC_QUAVER, MUSIC_QUAVERS
# - XMAS
# - YES, NO

# The display can show scrolling text or stationary images.
display.show(Image.HAPPY)

sleep(0.5)

# The first argument is the text to show.
# The 'loop' argument when false it will display once, if a number it will loop that many times, if true it will loop forever. 
# The 'clear' argyment when true will clear the screen at the end.
# The 'delay' argument is the delay that each letter is shown for in milliseconds.
# The 'fade' argument is an enum describing the fade style between each letter, between 0 and 6 inclusive.
# The 'callback' argument takes a function which will be called upon completion.
display.show('TEST', loop = False, delay = 500, clear = True, fade = 0)

sleep(0.5)

for x in range(0, 5):
    for y in range(0, 5):
        display.pixel(x, y, 5 + max(x, y))
        sleep(0.1)
        
sleep(0.5)

# Clear the display.
display.clear()

sleep(0.5)

# Set the display rotation, this can be 0, 90, 180, 270.
display.show(Image.GO_UP)
sleep(0.5)
display.rotation(90)
sleep(0.5)
display.rotation(90)
sleep(0.5)
display.rotation(90)
sleep(0.5)
display.rotation(90)

sleep(0.5)

# Show an animation.
animation = [
    Image("09090:99999:99999:09990:00900"),
    Image("01010:11111:11111:01110:00100"),
    Image("09090:99999:99999:09990:00900"),
    Image("01010:11111:11111:01110:00100")
]
display.show(animation, fade=2, clear=False, delay=500)

sleep(0.5)

# Restore the initial display.
display.clear()
display.show(Image(current_display), fade=0, clear=False, delay=500)

