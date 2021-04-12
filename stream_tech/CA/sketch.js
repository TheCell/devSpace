let gfx;
const xSize = 100;
const ySize = 100;
const CARules = {
  r111: true,
  r110: false,
  r101: true,
  r100: true,
  r011: false,
  r010: true,
  r001: true,
  r000: true,
  background: '#1a9bc6',
  foreground: '#84e3f9',
  randomStart: true,
  restart: function () {
    gfx.reset();
    lineCount = 0;
    gfx.background(CARules.background);
  }
};

let lineCount = 0;

function setup() {
  createCanvas(xSize, ySize);
  gfx = createGraphics(xSize, ySize)
  gfx.background(CARules.background);
}

function draw() {
  if (lineCount < gfx.height) {
    applyRulesToLine(lineCount);
    image(gfx, 0, 0);

    lineCount++;
  } else {
    gfx.copy(gfx, 0, 1, xSize, ySize - 1, 0, 0, xSize, ySize - 1);
    // gfx.copy(gfx, 0, 0, xSize, 1, 0, ySize -1, xSize, 1);
    // image(gfx, 0, 0);
    applyRulesToLine(lineCount - 1);
    image(gfx, 0, 0);
  }
}

function applyRulesToLine(lineNr) {
  gfx.loadPixels();
  const d = gfx.pixelDensity();
  const width = gfx.width * d * 4;

  if (lineNr == 0) {
    // starting new
    if (CARules.randomStart) {
      for (let i = 0; i < width; i += 4) {
        if (Math.random() > 0.5) {
          gfx.pixels[width * lineNr + i] = red(CARules.foreground);
          gfx.pixels[width * lineNr + i + 1] = green(CARules.foreground);
          gfx.pixels[width * lineNr + i + 2] = blue(CARules.foreground);
          gfx.pixels[width * lineNr + i + 3] = alpha(CARules.foreground);
        }
      }
    } else {
      gfx.pixels[Math.round(width / 2)] = red(CARules.foreground);
      gfx.pixels[Math.round(width / 2) + 1] = green(CARules.foreground);
      gfx.pixels[Math.round(width / 2) + 2] = blue(CARules.foreground);
      gfx.pixels[Math.round(width / 2) + 3] = alpha(CARules.foreground);
    }
  } else {
    for (let i = 0; i < width; i += 4) {
      let previousLeft = 0;
      let previousMiddle = pixelIsOn(gfx.pixels, width * (lineNr - 1) + i);
      let previousRight = 0;
      if (i > 0) {
        previousLeft = pixelIsOn(gfx.pixels, width * (lineNr - 1) + i - 4);
      }
      if (i < width - 4) {
        previousRight = pixelIsOn(gfx.pixels, width * (lineNr - 1) + i + 4);
      }
      
      const shouldDraw = ruleAllowsDraw(previousLeft, previousMiddle, previousRight);
      if (shouldDraw) {
        gfx.pixels[width * lineNr + i] = red(CARules.foreground);
        gfx.pixels[width * lineNr + i + 1] = green(CARules.foreground);
        gfx.pixels[width * lineNr + i + 2] = blue(CARules.foreground);
        gfx.pixels[width * lineNr + i + 3] = alpha(CARules.foreground);
      } else {
        gfx.pixels[width * lineNr + i] = red(CARules.background);
        gfx.pixels[width * lineNr + i + 1] = green(CARules.background);
        gfx.pixels[width * lineNr + i + 2] = blue(CARules.background);
        gfx.pixels[width * lineNr + i + 3] = alpha(CARules.background);
      }
    }
  }

  gfx.updatePixels();
}

function pixelIsOn(array, pixelNumber) {
  return array[pixelNumber] != red(CARules.background) 
    && array[pixelNumber + 1] != green(CARules.background) 
    && array[pixelNumber + 2] != blue(CARules.background);
}

function ruleAllowsDraw(left, middle, right) {
  let ruleName = 'r';
  ruleName += left ? 1 : 0;
  ruleName += middle ? 1 : 0;
  ruleName += right ? 1 : 0;
  
  return CARules[ruleName];
}