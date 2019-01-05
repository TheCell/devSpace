// Gray-Scott model
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
  rfs.update();
  rfs.draw();
}
