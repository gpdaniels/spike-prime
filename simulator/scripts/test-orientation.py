from hub import motion
from utime import sleep

# Get accelerometer values.
motion.accelerometer()

# Get gyroscope values.
motion.gyroscope()

# Get position values.
#motion.position() <-- Sadly doesn't exist

# Get the euler angles of the hub.
yaw, pitch, roll = motion.yaw_pitch_roll()
print(f"Yaw: {yaw}, Pitch: {pitch}, Roll: {roll}")

# Get current orientation.
#   1 - Front
#   2 - Back
#   3 - Top
#   4 - Bottom
#   5 - Left side
#   6 - Right side
motion.orientation()

# Check if a gesture has happened since this function was last called.
# If it has it will return one of: 
#   motion.DOUBLETAPPED
#   motion.FREEFALL
#   motion.SHAKE
#   motion.TAPPED
motion.gesture()
