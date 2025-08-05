#!/bin/bash

echo "Setting up X11 environment..."

# Allow access from any user
xhost +local:

# Set up display configuration
export DISPLAY=:99

# Set DPI to make text more readable
xrdb -merge <<< "Xft.dpi: 96"
xrdb -merge <<< "Xft.antialias: true"
xrdb -merge <<< "Xft.hinting: true"
xrdb -merge <<< "Xft.hintstyle: hintslight"
xrdb -merge <<< "Xft.rgba: rgb"

# Disable screen saver and DPMS
xset s off
xset -dpms
xset s noblank

echo "X11 setup complete"
