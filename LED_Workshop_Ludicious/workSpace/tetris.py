import machine
import neopixel
import time
import random

amountOfLeds = 30
lost = False
leds = neopixel.NeoPixel(machine.Pin(4), amountOfLeds)

brightness = machine.ADC(machine.Pin(33))
color = machine.ADC(machine.Pin(32))
brightness.atten(machine.ADC.ATTN_11DB)
color.atten(machine.ADC.ATTN_11DB)

class Block:
  def __init__(self, pos, color):
    self.pos = pos
    self.color = color
  
  def draw(self, leds):
    leds[int(self.pos)] = self.color



def map(x, in_min, in_max, out_min, out_max):
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min

def chooseColor(colorInput, brightness):
  if brightness == brightnessSetting[0]:
    brightVal = 1
  if brightness == brightnessSetting[1]:
    brightVal = 20
  if brightness == brightnessSetting[2]:
    brightVal = 100
  
  #brightness = brightness * 85 + 1
  
  if colorInput == colorSetting[0]:
    return (brightVal,0,0)
  if colorInput == colorSetting[1]:
    return (0, brightVal,0)
  if colorInput == colorSetting[2]:
    return (0, 0, brightVal)

def resetLeds(ledArr, blockArr):
  for x in range(len(blockArr), amountOfLeds):
    ledArr[x] = (0, 0, 0)
    ledArr.write()
 
def drawBlocks(ledArr, blockArr):
  for x in range(0, len(blockArr)):
      blockArr[x].draw(ledArr)
      ledArr.write()

def checkAndRemove(blockArr):
  if len(blockArr) <= 1:
    return
  
  hasRemoved = False
  
  amountTheSameColor = 0
  for x in range(1, len(blockArr)):
    prevItem = blockArr[x - 1]
    
    if blockArr[x].color == prevItem.color:
      amountTheSameColor = amountTheSameColor + 1
    else:
      amountTheSameColor = 0
    
    if amountTheSameColor == 3:
      for i in range(blockArr[x].pos, blockArr[x].pos - 4, -1):
        blockArr.pop(i)
      hasRemoved = True
  
  return hasRemoved
    
    #if amountTheSameColor == -1:
    #  prevItem = blockArr[x]
    #  amountTheSameColor = 0

def setNewColorRange(arr):
  firstVal = arr[0]
  arr.pop(0)
  arr.append(firstVal)
  
  
def setNewBrightnessRange(arr):
  firstVal = arr[0]
  arr.pop(0)
  arr.append(firstVal)
  
  
blocks = []
colorSetting = [0, 1, 2]
brightnessSetting = [0, 1, 2]
lastDroppedPosition = -1
dropPosition = amountOfLeds

while not lost:
  resetLeds(leds, blocks)
  drawBlocks(leds, blocks)
  
  brightVal = int(map(brightness.read(), 0, 4095, 0, 2))
  colorVal = int(map(color.read(), 0, 4095, 0, 2))
  dropPosition -= 1
  if dropPosition == lastDroppedPosition + 1:
    block = Block(dropPosition, chooseColor(colorVal, brightVal))
    blocks.append(block)
    lastDroppedPosition = dropPosition
    dropPosition = amountOfLeds - 1
    setNewColorRange(colorSetting)
    setNewBrightnessRange(brightnessSetting)
  
  if (lastDroppedPosition == amountOfLeds - 1):
    lost = True
  leds[dropPosition] = chooseColor(colorVal, brightVal)
  leds.write()
  
  if checkAndRemove(blocks):
    lastDroppedPosition = lastDroppedPosition - 4
  #print(int(map(analogPin.read(), 0, 4095, 0, 255)))
  #print(analogPin.read())
  time.sleep_ms(50)
