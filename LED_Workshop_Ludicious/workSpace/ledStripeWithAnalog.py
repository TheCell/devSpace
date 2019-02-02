import machine
import neopixel
import time

leds = neopixel.NeoPixel(machine.Pin(4), 60)
analogPin = machine.ADC(machine.Pin(33))
analogPin.atten(machine.ADC.ATTN_11DB)

def map(x, in_min, in_max, out_min, out_max):
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min

i = 0
invert = True
r = 0
g = 0
b = 0

while True:
  r = map(analogPin.read(), 1024, 3072, 0, 255)
  r = int(r)
  g = map(analogPin.read(), 0, 2048, 0, 255)
  g = int(g)
  b = map(analogPin.read(), 2048, 4095, 0, 255)
  b = int(b)
  if invert:
    leds[i] = (0,0,0)
  i += 1
  if i >= 30:
    i = 0
    invert = not invert
  leds[i] = (r, g, b)
  leds.write()
  #print(int(map(analogPin.read(), 0, 4095, 0, 255)))
  #print(analogPin.read())
  time.sleep_ms(30)
