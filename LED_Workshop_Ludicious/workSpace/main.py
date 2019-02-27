

import machine
import neopixel
import time
import random

amountOfLeds = 30
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

def chooseColor(colorInput, brightness, colorSettingsArr, brightnessSettingsArr):
  if brightness == brightnessSettingsArr[0]:
    brightVal = 1
  if brightness == brightnessSettingsArr[1]:
    brightVal = 20
  if brightness == brightnessSettingsArr[2]:
    brightVal = 150
    
  if colorInput == colorSettingsArr[0]:
    return (brightVal,0,0)
  if colorInput == colorSettingsArr[1]:
    return (0, brightVal,0)
  if colorInput == colorSettingsArr[2]:
    return (0, 0, brightVal)
  if colorInput == colorSettingsArr[3]:
    return (brightVal, brightVal, 0)

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

def shuffleArray(arr):
  newArr = []
  while(len(arr) > 0):
    randomVal = random.choice(arr)
    newArr.append(randomVal)
    arr.remove(randomVal)
  return newArr

def playTetris():
  lost = False
  blocks = []
  colorSetting = [0, 1, 2, 3]
  brightnessSetting = [0, 1, 2]
  lastDroppedPosition = -1
  dropPosition = amountOfLeds
  tetrisDelay = 150

  while not lost:
    brightVal = int(map(brightness.read(), 0, 4095, 0, len(brightnessSetting) - 1))
    colorVal = int(map(color.read(), 0, 4095, 0, len(colorSetting) - 1))
    dropPosition -= 1
    
    if dropPosition == lastDroppedPosition + 1:
      block = Block(dropPosition, chooseColor(colorVal, brightVal, colorSetting, brightnessSetting))
      blocks.append(block)
      lastDroppedPosition = dropPosition
      dropPosition = amountOfLeds - 1
      colorSetting = shuffleArray(colorSetting)
      brightnessSetting = shuffleArray(brightnessSetting)
    

    if (lastDroppedPosition == amountOfLeds - 2):
      lost = True
    
    # draw gameparts
    resetLeds(leds, blocks)
    drawBlocks(leds, blocks)
    leds[dropPosition] = chooseColor(colorVal, brightVal, colorSetting, brightnessSetting)
    leds.write()
    
    if checkAndRemove(blocks):
      lastDroppedPosition = lastDroppedPosition - 4
      if tetrisDelay > 10:
        tetrisDelay -= 10
    time.sleep_ms(tetrisDelay)


# call to action
inGameLoop = True
while inGameLoop:
  playTetris()



