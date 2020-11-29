from hub import display
from utime import sleep

display.clear()
sleep(1)

display.pixel(0,0,100)
sleep(1)
display.rotation(90)
sleep(1)
display.pixel(0,0,100)
sleep(1)
display.rotation(-90)
sleep(1)
display.pixel(0,0,0)

# Expected output if the display.pixel(...) command works on the rotated display.
# clear    set00    rot+90   set00    rot-90   set00
# 00000    #0000    0000#    0000#    #0000    00000
# 00000    00000    00000    00000    00000    00000
# 00000 -> 00000 -> 00000 -> 00000 -> 00000 -> 00000
# 00000    00000    00000    00000    00000    00000
# 00000    00000    00000    00000    00000    00000

# Expected output if the display.pixel(...) command works on the NOT rotated display.
# clear    set00    rot+90   set00    rot-90   set00
# 00000    #0000    0000#    #000#    #0000    00000
# 00000    00000    00000    00000    00000    00000
# 00000 -> 00000 -> 00000 -> 00000 -> 00000 -> 00000
# 00000    00000    00000    00000    00000    00000
# 00000    00000    00000    00000    #0000    #0000

# Recorded output.
# clear    set00    rot+90   set00    rot-90   set00
# 00000    #0000    0000#    0000#    #000#    00000
# 00000    00000    00000    00000    00000    00000
# 00000 -> 00000 -> 00000 -> 00000 -> 00000 -> 00000
# 00000    00000    00000    00000    00000    00000
# 00000    00000    00000    0000#    00000    #0000
#
# It seems that the display.pixel(...) command opperates on the display rotated by twice the amount?
