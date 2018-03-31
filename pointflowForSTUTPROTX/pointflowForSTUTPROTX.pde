int canvasSizeX = 800;
int canvasSizeY = 800;
int numberOfAgents = 70;
int tailLength = 50;
int movespeed = 4;
MiddlepointCoordinates[] middlepointCoordinates = null;

void settings()
{
    size(canvasSizeX, canvasSizeY);
}

void setup()
{   
    setupAndInitArray();
    noiseDetail(8, 1);
    fill(255);
    noStroke();
}

void draw()
{
    clear();
    for (int i = 0; i < middlepointCoordinates.length; i++)
    {
        MiddlepointCoordinates mpc = middlepointCoordinates[i];
        drawStamp(mpc.x, mpc.y);
        //System.out.println(mpc.x + "," + mpc.y);
    }
    for (int y = 0; y < canvasSizeY; y++)
    {
      for (int x = 0; x < canvasSizeX; x++)
      {
          pix
      }
    }
}

void mouseClicked()
{
    setupAndInitArray();
}

void drawStamp(int x, int y)
{
    int radius = 4;
    ellipse( x, y, radius, radius);
}

void setupAndInitArray()
{
    middlepointCoordinates = new MiddlepointCoordinates[numberOfAgents * tailLength];
    for (int i = 0; i < numberOfAgents; i++)
    {
        int xVal = (int) random(canvasSizeX - 50.0f);
        int yVal = (int) random(canvasSizeY - 50.0f);
        MiddlepointCoordinates mpc = new MiddlepointCoordinates(xVal, yVal);
        middlepointCoordinates[i * tailLength] = mpc;
        
        float newXVal = mpc.x;
        float newYVal = mpc.y;
        
        for (int j = 1; j < tailLength; j++)
        {
            newXVal = newXVal + (cos(map(noise(newXVal,newYVal), 0.0f, 1.0f, 0.0f, (float) Math.PI * 2)) * movespeed);
            newYVal = newYVal + (sin(map(noise(newXVal,newYVal), 0.0f, 1.0f, 0.0f, (float) Math.PI * 2)) * movespeed);
            
            middlepointCoordinates[i * tailLength + j] = new MiddlepointCoordinates((int) newXVal, (int) newYVal);
            MiddlepointCoordinates mpcnew = middlepointCoordinates[i * tailLength + j];
        }
    }
}
