import machine
import neopixel
import time

leds = neopixel.NeoPixel(machine.Pin(4), 60)
i = 0
invert = True

while True:
  if invert:
    leds[i] = (0,0,0)
  i += 1
  if i >= 30:
    i = 0
    invert = not invert
  leds[i] = (0, 100, 0)
  leds.write()
  time.sleep_ms(30)
