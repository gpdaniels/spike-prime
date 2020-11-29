from hub import port
from utime import sleep

if (not port.A.motor):
    print("Please connect a motor to port A.")
else:
    # Get the default settings of the motor?
    port.A.motor.default()
    sleep(0.5)
    
    # Get the mode of the motor?
    port.A.motor.mode(1)
    
    # Get the current value of the motor?
    port.A.motor.get()
    
    # Get or set the pid values?
    port.A.motor.pid()
    
    # Get or set a preset?
    port.A.motor.preset(0)
    
    # Set a velocity (-100 to +100).
    for pwm in range(-100, 100 + 1, 50):
        port.A.motor.pwm(pwm)
        sleep(0.5)
    
    # Set the operation of the motor when being driven externally.
    port.A.motor.brake()
    port.A.motor.float()
    port.A.motor.hold()
    
    # More advanced running function.
    #   speed:          -100 to 100     - larger or smaller than limit has no impact.
    #   max_power:         0 to 100     - absolute is taken from negative values.
    #   acceleration:      0 to 100     - absolute is taken from negative values.
    #   deceleration:      0 to 100     - absolute is taken from negative values.
    #   stall:          True or False
    port.A.motor.run_at_speed(speed = 50, max_power = 100, acceleration = 100, deceleration = 100, stall = False)
    
    # Rotate for a number of degrees.
    #   Argument 1: number of degrees   - positive or negative.
    #   Argument 2: speed -100 to 100   - larger or smaller than limit has no impact.
    port.A.motor.run_for_degrees(90, 50)
    
    # Rotate to a position.
    # NOTE: If you call motor.run_for_degrees(...) a number of times it will use the final position.
    # NOTE: a.k.a. rotate 90, rotate 90, rotate 90, position 0 would mean rotate -270.
    # NOTE: The pwm and other run_XXX functions will also count towards the position.
    #   Argument 1: Position in degrees - positive or negative.
    #   Argument 2: speed 0 to 100      - absolute is taken from negative values.
    port.A.motor.run_to_position(0, 50)
    
    # Rotate for an amount of time.
    #   Argument 1: time in ms          - positive or negative.
    #   Argument 2: speed -100 to 100   - larger or smaller than limit has no impact.
    port.A.motor.run_for_time(100, 50)

    sleep(1.0)

    # Check if the motor is busy.
    if (port.A.motor.busy(1)):
        print("Motor: Busy")
    else:
        print("Motor: Not busy")
    port.A.motor.run_for_time(100, 50)
    if (port.A.motor.busy(1)):
        print("Motor: Busy")
    else:
        print("Motor: Not busy")
    sleep(0.11)
    if (port.A.motor.busy(1)):
        print("Motor: Busy")
    else:
        print("Motor: Not busy")
    
    # Register a callback to be called when the motor is done.
    # NOTE: The value of the arg will be 0 for a finished motion, and 1 for an interrupted one.
    port.A.motor.callback(lambda arg: print("Motor callback: {}".format(arg)))
