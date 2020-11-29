from hub import button

print("Left button:")
print("    Was pressed at some point: {}".format(button.left.was_pressed()))
print("    Was pressed {} times.".format(button.left.presses()))
print("    Is pressed right now: {}".format(button.left.is_pressed()))

print("Centre button:")
print("    Was pressed at some point: {}".format(button.center.was_pressed()))
print("    Was pressed {} times.".format(button.center.presses()))
print("    Is pressed right now: {}".format(button.center.is_pressed()))

print("Left button:")
print("    Was pressed at some point: {}".format(button.right.was_pressed()))
print("    Was pressed {} times.".format(button.right.presses()))
print("    Is pressed right now: {}".format(button.right.is_pressed()))
