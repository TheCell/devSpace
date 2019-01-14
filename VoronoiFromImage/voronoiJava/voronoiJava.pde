PVector windowSize;
int xSize;
int ySize;
VoronoiEngine voronoiEngine;

void settings()
{
  xSize = 700;
  ySize = 400;
  size(xSize, ySize);
  pixelDensity(displayDensity());
}

void setup()
{
  windowSize = new PVector(xSize, ySize);
   //<>//
  voronoiEngine = new VoronoiEngine(windowSize, 20);
}

void draw()
{
  voronoiEngine.draw();
}
