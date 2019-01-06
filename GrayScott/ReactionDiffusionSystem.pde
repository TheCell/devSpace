// example was this: https://github.com/pmneila/jsexp/blob/master/grayscott/
// paper was this: https://arxiv.org/pdf/1806.07980.pdf
// javascript example is: https://pmneila.github.io/jsexp/grayscott/

class ReactionDiffusionSystem
{
  private float feed;
  private float kill;
  private float deltaTime = 0.01;
  private float diffusionCoefficientA = 0.2097;
  private float diffusionCoefficientB = 0.105;
  private PVector[][] dotPerScreenPixel;
  private int xSize;
  private int ySize;
  private color[] colorPalette;
  private float[] colorTreshholds;
  private float stepX = 1.0 / xSize;
  private float stepY = 1.0 / ySize;
  public boolean drawInverted = true;
  
  public ReactionDiffusionSystem(int x, int y, float feed, float kill)
  {
    this.xSize = x;
    this.ySize = y;
    this.feed = feed;
    this.kill = kill;
    init();
  }
  
  public void update()
  {
    float du;
    float dv;
    float delta;
    
    // manhattan Neighbourhood
    PVector uv;
    PVector uvLeft;
    PVector uvRight;
    PVector uvTop;
    PVector uvBottom;
    PVector laplacian;
    
    for (int i = 0; i < (xSize*ySize); i++)
    {
      int xCoord = i%xSize;
      int yCoord = (int)Math.floor(i/xSize);
      float previousA = dotPerScreenPixel[xCoord][yCoord].x;
      float previousB = dotPerScreenPixel[xCoord][yCoord].y;
      
      uv = dotPerScreenPixel[xCoord][yCoord];
      boolean isLeftEdge = !(xCoord > 0);
      boolean isRightEdge = !(xCoord < (xSize - 1));
      boolean isTopEdge = !(yCoord > 0);
      boolean isBottomEdge = !(yCoord < (ySize - 1));

      if (!isLeftEdge && !isRightEdge && !isTopEdge && !isBottomEdge)
      {
        uvLeft = dotPerScreenPixel[xCoord - 1][yCoord];
        uvRight = dotPerScreenPixel[xCoord + 1][yCoord];
        uvTop = dotPerScreenPixel[xCoord][yCoord - 1];
        uvBottom = dotPerScreenPixel[xCoord][yCoord + 1];
      }
      else if (isTopEdge && !isRightEdge && !isLeftEdge)
      {
        uvLeft = dotPerScreenPixel[xCoord - 1][yCoord];
        uvRight = dotPerScreenPixel[xCoord + 1][yCoord];
        uvTop = dotPerScreenPixel[xCoord][yCoord];
        uvBottom = dotPerScreenPixel[xCoord][yCoord + 1];
      }
      else if (isBottomEdge && !isRightEdge && !isLeftEdge)
      {
        uvLeft = dotPerScreenPixel[xCoord - 1][yCoord];
        uvRight = dotPerScreenPixel[xCoord + 1][yCoord];
        uvTop = dotPerScreenPixel[xCoord][yCoord - 1];
        uvBottom = dotPerScreenPixel[xCoord][yCoord];
      }
      else if (isRightEdge && !isTopEdge && !isBottomEdge)
      {
        uvLeft = dotPerScreenPixel[xCoord - 1][yCoord];
        uvRight = dotPerScreenPixel[xCoord][yCoord];
        uvTop = dotPerScreenPixel[xCoord][yCoord - 1];
        uvBottom = dotPerScreenPixel[xCoord][yCoord + 1];
      }
      else if (isLeftEdge && !isTopEdge && !isBottomEdge)
      {
        uvLeft = dotPerScreenPixel[xCoord][yCoord];
        uvRight = dotPerScreenPixel[xCoord + 1][yCoord];
        uvTop = dotPerScreenPixel[xCoord][yCoord - 1];
        uvBottom = dotPerScreenPixel[xCoord][yCoord + 1];
      }
      else
      {
        float defaultValue = 1.0f;
        uvLeft = new PVector(defaultValue, defaultValue);
        uvRight = new PVector(defaultValue, defaultValue);
        uvTop = new PVector(defaultValue, defaultValue);
        uvBottom = new PVector(defaultValue, defaultValue);
      }
      
      // basically add all 4 neighbours and divide by the 4*actual one
      laplacian = PVector.add(uvLeft, uvRight);
      laplacian = PVector.add(laplacian, uvTop);
      laplacian = PVector.add(laplacian, uvBottom);
      laplacian = PVector.sub(laplacian, PVector.mult(uv, 4.0f));
      
      du = diffusionCoefficientA*laplacian.x - uv.x*uv.y*uv.y + feed*(1.0 - uv.x);
      dv = diffusionCoefficientB*laplacian.y + uv.x*uv.y*uv.y - (feed + kill)*uv.y;
      
      PVector newValue = new PVector(uv.x + deltaTime*du, uv.y + deltaTime*dv);
      
      dotPerScreenPixel[xCoord][yCoord] = newValue;
    }
  }
  
  public void draw()
  {
    for (int i = 0; i < (xSize*ySize); i++)
    {
      float pixelValue;
      
      if (drawInverted)
      {
        pixelValue = dotPerScreenPixel[i%xSize][(int)Math.floor(i/xSize)].y;
      }
      else
      {
        pixelValue = dotPerScreenPixel[i%xSize][(int)Math.floor(i/xSize)].x;
      }
      
      color color1;
      color color2;
      float lerpValue = 0.0f;
      
      if(pixelValue < colorTreshholds[0])
      {
        color1 = colorPalette[0];
        color2 = colorPalette[0];
        lerpValue = 1.0f;
      }
      if(pixelValue < colorTreshholds[1])
      {
        color1 = colorPalette[0];
        color2 = colorPalette[1];
        float lowerValue = colorTreshholds[0];
        float upperValue = colorTreshholds[1];
        float maxValue = upperValue - lowerValue;
        lerpValue = 1 / maxValue * lowerValue;
      }
      else if(pixelValue < colorTreshholds[2])
      {
        color1 = colorPalette[1];
        color2 = colorPalette[2];
        float lowerValue = colorTreshholds[1];
        float upperValue = colorTreshholds[2];
        float maxValue = upperValue - lowerValue;
        lerpValue = 1 / maxValue * lowerValue;
      }
      else if(pixelValue < colorTreshholds[3])
      {
        color1 = colorPalette[2];
        color2 = colorPalette[3];
        float lowerValue = colorTreshholds[2];
        float upperValue = colorTreshholds[3];
        float maxValue = upperValue - lowerValue;
        lerpValue = 1 / maxValue * lowerValue;
      }
      else if(pixelValue < colorTreshholds[4])
      {
        color1 = colorPalette[3];
        color2 = colorPalette[4];
        float lowerValue = colorTreshholds[3];
        float upperValue = colorTreshholds[4];
        float maxValue = upperValue - lowerValue;
        lerpValue = 1 / maxValue * lowerValue;
      }
      else
      {
        // welp there is no 6th color so it is the last in the array
        color1 = colorPalette[4];
        color2 = colorPalette[4];
        lerpValue = 1.0f;
      }
      
      //print(color1, color2, lerpValue);
      color pixelColor = lerpColor(color1, color2, lerpValue);
      pixels[i] = pixelColor;
    }
  }

  private void init()
  {
    dotPerScreenPixel = new PVector[xSize][ySize];
    
    for(int y = 0; y < ySize; y++)
    {
      for(int x = 0; x < xSize; x++)
      {
        dotPerScreenPixel[x][y] = new PVector(random(0.0f, 0.4f), random(0.0f, 0.4f));
      }
    }
    
    int amountOfColors = 5;
    colorPalette = new color[amountOfColors];
    colorPalette[0] = #000000;
    colorPalette[1] = #00FF00;
    colorPalette[2] = #FFFF00;
    colorPalette[3] = #FF0000;
    colorPalette[4] = #FFFFFF;
    
    colorTreshholds = new float[amountOfColors];
    colorTreshholds[0] = 0.0f;
    colorTreshholds[1] = 0.2f;
    colorTreshholds[2] = 0.21f;
    colorTreshholds[3] = 0.4f;
    colorTreshholds[4] = 0.6f;
    
  }
}
