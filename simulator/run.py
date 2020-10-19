#!/usr/bin/python3

import argparse
import os
import serial
import sys
import time

def wait_for_prompt(port, timeout, prompt_string):
    prompt_expected = b'\r\n' + prompt_string
    prompt_buffer = b''
    response_buffer = b''
    time_timeout = timeout
    time_elapsed = 0.0
    time_start = time.time()
    port.timeout = time_timeout
    
    while (time_elapsed < time_timeout):
        port.timeout = time_timeout - time_elapsed
        response_buffer = response_buffer + port.read(port.in_waiting if port.in_waiting else 1)
        prompt_buffer = response_buffer[-len(prompt_expected):]
        time_elapsed = time.time() - time_start
        if (prompt_buffer == prompt_expected):
            return response_buffer[:-len(prompt_expected)] + b'\r\n'
    raise ConnectionError("Failed to get to the command prompt (Last prompt was {}).".format(prompt_buffer))
    
def write_control(port, timeout, prompt_string, control):
    port.reset_output_buffer()
    port.reset_input_buffer()
    control_full =  b'\r\n'
    time.sleep(0.1)
    port.write(control)
    time.sleep(0.1)
    response_full = wait_for_prompt(port, timeout, prompt_string)
    response_control = response_full[:len(control_full)]
    response_output = response_full[len(control_full):]
    if (response_control != control_full):
        raise ConnectionError("Failed to send the control. {} != {}".format(response_control, control_full))
    return response_output
    
def write_command(port, timeout, prompt_string, command):
    port.reset_output_buffer()
    port.reset_input_buffer()
    command_full = command + b'\r\n'
    time.sleep(0.1)
    port.write(command_full)
    time.sleep(0.1)
    response_full = wait_for_prompt(port, timeout, prompt_string)
    response_command = response_full[:len(command_full)]
    response_output = response_full[len(command_full):]
    if (response_command != command_full):
        raise ConnectionError("Failed to send the command. {} != {}".format(response_command, command_full))
    return response_output

################################################################################

if (__name__ == "__main__"):
    print("Initialising script runner...")
    
    print("Parsing arguments...")
    parser = argparse.ArgumentParser(description="Runs a micropython script on a physical hub.")
    parser.add_argument("script_path", help="Script file name to run")
    parser.add_argument("output_path", nargs='?', help="Output file to used for responses from the hub.\n", default="")
    parser.add_argument("-p", "--port", help="Hub device path/port.\n  Linux wired is: /dev/ttyACM0\n Linux bluetooth is: /dev/rfcomm0\n", default="/dev/ttyACM0")
    parser.add_argument("-r", "--reboot", help="Reboot the hub before connecting\n", action='store_true')
    parser.add_argument("-t", "--timeout", help="Set the connection timeout value in seconds\n", default=10.0)
    arguments = parser.parse_args()
    arguments.timeout = float(arguments.timeout)

    print("Checking local script...")
    if (os.path.isfile(arguments.script_path) != True):
        raise FileNotFoundError("Failed to find the local script file at the given path.")
        
    if (os.access(arguments.script_path, os.R_OK) != True):
        raise PermissionError("Do not have permission to read the local script file.")

    print("Opening serial port...")
    port = serial.Serial(arguments.port, 115200, timeout = arguments.timeout)

    # Check the port opened successfully.
    if (port.isOpen() == False):
        raise ConnectionError("Failed to open serial port.")
    
    if (arguments.reboot == True):
        print("Rebooting hub...")
        port.reset_output_buffer()
        port.reset_input_buffer()
        port.write(b'\x04')
        time.sleep(10.0)
    
    print("Resetting remote REPL to base state...")
    port.reset_output_buffer()
    port.reset_input_buffer()
    port.write(b'\x03')
    time.sleep(0.1)
    port.write(b'\x03')
    time.sleep(1.0)
    port.reset_output_buffer()
    port.reset_input_buffer()
    port.write(b'raise KeyboardInterrupt()')
    time.sleep(1.0)
    write_control(port, arguments.timeout, b'>>> ', b'\x03')

    print("Reading script...")
    script_file = open(arguments.script_path, 'rb') 
    script_lines = script_file.readlines() 
    
    print("Entering REPL paste mode...")
    response = write_control(port, arguments.timeout, b'=== ', b'\x05')
    
    print("Sending script...")
    for line in script_lines:
        write_command(port, arguments.timeout, b'=== \n', line.rstrip())
    
    # Ensure the script ends with a newline.
    write_command(port, arguments.timeout, b'=== \n', b'')
    
    print("Exiting REPL paste mode...")
    response = write_control(port, arguments.timeout, b'>>> ', b'\x04')
    
    if (arguments.output_path != ""):
        print("Saving script output to file...")
        output_file = open(arguments.output_path, 'wb') 
        output_file.write(response)
    else:
        print("Executing script...")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print(response.decode("utf-8"))
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    
    print("Finished.")
