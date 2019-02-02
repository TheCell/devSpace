from uresponsivevalue import ResponsiveValue
import machine
from machine import Pin, ADC
import neopixel

def map(x, in_min, in_max, out_min, out_max):
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min


pixel_count = 30

leds = neopixel.NeoPixel(machine.Pin(4), pixel_count)

player1 = machine.ADC(machine.Pin(33))
player2 = machine.ADC(machine.Pin(32))
player1.atten(machine.ADC.ATTN_11DB)
player2.atten(machine.ADC.ATTN_11DB)
previousPos1 = 0
previousPos2 = 0

while True:
  leds[previousPos1] = (0,0,0)
  leds[previousPos2] = (0,0,0)
  leds.write()
  
  player1Pos = int(map(player1.read(), 0, 4095, 0, 5))
  player2Pos = int(map(player2.read(), 0, 4095, 24, 29))
  
  leds[player1Pos] = (0,50,0)
  leds[player2Pos] = (0,0,50)
  leds.write()
  previousPos1 = player1Pos
  previousPos2 = player2Pos
