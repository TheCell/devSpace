// Gray-Scott model
// goal: insert bw image as feed / kill values: https://twitter.com/i/status/1081067778176634880
ReactionDiffusionSystem rfs;
int xSize = 300;
int ySize = 300;
int displaySizeX = xSize * 2;
int displaySizeY = xSize * 2;
PImage canvas;

void settings()
{
  size(displaySizeX, displaySizeY);
}

void setup()
{
  canvas = createImage(xSize, ySize, RGB);
  rfs = new ReactionDiffusionSystem(xSize, ySize, 0.037f, 0.07f, canvas);
}

void draw()
{
  canvas.loadPixels();
  rfs.update();
  rfs.draw();
  canvas.updatePixels();
  image(canvas, 0, 0, displaySizeX, displaySizeY);
}
