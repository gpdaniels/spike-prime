# Simulator #

An attempt to create a simulator to allow running / debugging micropython scripts as if they were on a LEGO hub.

## simulator.py ##

Currently uses tkinter to create an interactive GUI mimicing a hub. The script seaches the api directory to try and find hub modules, these will need to be mocked from the functions that are available on the hub.

## run.py ##

A short python program to send a micropython script to a connected hub, run it, and then print the result.
