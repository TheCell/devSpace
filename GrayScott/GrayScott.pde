// Gray-Scott model
// goal: insert bw image as feed / kill values: https://twitter.com/i/status/1081067778176634880
ReactionDiffusionSystem rfs;
int xSize = 300;
int ySize = 300;

void settings()
{
  size(xSize, ySize);
}

void setup()
{
  rfs = new ReactionDiffusionSystem(xSize, ySize, 0.037f, 0.07f);
}

void draw()
{
  loadPixels();
  rfs.update();
  rfs.draw();
  updatePixels();
}
