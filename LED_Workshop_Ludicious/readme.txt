Tetris is the game our Team of 2 made during the Ludicious19 Workshop by @Robin_B
you can swap colors and brightness. have 4 leds with the same color and brightness in a row to get a combo
The game will get faster after each combo
it restarts after you lost (the stripe is full)

You need:
1x esp32 micro board
2x potentiometer
1x 1 meter 30 led stripe 5 Volts (search for: "WS2812B")
1x breadboard
1x mini USB

download uPyCraft (https://github.com/DFRobot/uPyCraft)

potentiometers have 3 pins. The two outer pins are for +3V and GND (doesn't matter which way). The inner Pin is the data. I plugged my 2 potentiometer data Pins into ESP32 board pin 32 and 33

The LED Stripe has 3 connections. The stripe has little arrows on it that shows in which direction the led stripe is counting his LED's. You should connect the side where the arrows are pointing away from the board if plugged in. The cable should have marks where the +5V, GND and Data (D1) has to be connected. On my stripe it's red for +5V, white for GND and green for Data.