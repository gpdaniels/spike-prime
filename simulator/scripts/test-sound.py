from hub import sound
from utime import sleep

# Get the volume.
sound.volume()

# Set the volume, 0 to 10
sound.volume(10)

# Make a standard beep.
sound.beep()
sleep(0.5)

# Make a custom beep.
#   frequency:  sound frequency in Hz.
#   duration:   time to play sound for.
#   waveform:   sound.SOUND_SAWTOOTH, sound.SOUND_SIN, sound.SOUND_SQUARE, or sound.SOUND_TRIANGLE
sound.beep(2000, 500, sound.SOUND_SIN)
sleep(0.5)

# Set a callback that will be called upon sounds being interrupted or finishing.
# NOTE: The value of the arg will be 0 for a finished sound, and 1 for an interrupted one.
sound.callback(lambda arg: print("Sound callback: {}".format(arg)))

# Play a sound from the filesystem.
# NOTE: The audio file format on device is raw signed 16 bit samples at 16000Hz.
sound.play("extra_files/1234")
