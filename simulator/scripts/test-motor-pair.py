from hub import port
from utime import sleep

if (not port.A.motor or not port.B.motor):
    print("Please connect a motor to ports A and B.")
else:
    # Pair the motors together.
    pair = port.A.motor.pair(port.B.motor)
    
    # For access to the individual motors.
    motorA = pair.primary()
    motorB = pair.secondary()
    
    # Identity of the pair.
    pair.id()
    
    # Get or set a preset?
    pair.preset(0, 0)
    
    # Set the pid values?
    # pair.pid() <-- Doesn't work
    pair.pid(0, 0, 0)
    
    # Set the operation of the motor pair when being driven externally.
    pair.brake()
    pair.float()
    pair.hold()
    
    pair.pwm(50, 50)
    sleep(0.5)
    pair.pwm(-50, 50)
    sleep(0.5)
    pair.pwm(50, -50)
    sleep(0.5)
    pair.pwm(-50, -50)
    sleep(0.5)
    pair.pwm(0, 0)

    # Same as single motor, but two speeds required.
    pair.run_at_speed(50, -50)
    
    # Same as single motor, but speed given first and two degrees values required.
    pair.run_for_degrees(50, 90, 90)

    # Same as single motor, but two positions required.
    pair.run_to_position(0, 0, 100)
        
    # Same as single motor, but two speeds required.
    pair.run_for_time(200, 50, -50)
    
    sleep(0.5)
        
    # Register a callback to be called when the pair is done.
    # NOTE: The value of the arg will be 0 for a finished motion, and 1 for an interrupted one.
    pair.callback(lambda arg: print("Motor pair callback: {}".format(arg)))
    
    # Split up the pair.
    pair.unpair()
