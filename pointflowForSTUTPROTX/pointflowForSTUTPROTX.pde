import processing.dxf.*;
import processing.svg.*;

int canvasSizeX = 800;
int canvasSizeY = 800;
int numberOfAgents = 70;
int tailLength = 50;
int movespeed = 4;
float noiseFactor = 0.005;
int seed = (int) random(999999999);

MiddlepointCoordinates[] middlepointCoordinates = null;

void settings()
{
    size(canvasSizeX, canvasSizeY, P2D);
}

void setup()
{
    fill(255);
    noStroke();
    setupAndInitArray();
}

void draw()
{
    clear();
    drawWithOption(false);
    //drawNoise();
    
}

void mouseClicked()
{
    seed = (int) random(999999999);
    setupAndInitArray();
}

void keyTyped()
{
    //System.out.println(int(key));
  
    // s
    if (int(key) == 115)
    {
        saveAsDXF();
    }
    
    // a
    if (int(key) == 97)
    {
        print("save as " + seed + ".png");
        save( seed + ".png");
    }
    
    // d
    if (int(key) == 100)
    {
        saveAsSVG();
    }
}

void drawStamp(int x, int y)
{
    int radius = 4;
    ellipse( x, y, radius, radius);
}

void drawStampCommand(int x, int y)
{
    stroke(0);
    strokeWeight(1);
    line( x, y, x, y + 100);
}

void drawWithOption(boolean isDxfExport)
{
    if (isDxfExport)
    {
        for (int i = 0; i < middlepointCoordinates.length; i++)
        {
            MiddlepointCoordinates mpc = middlepointCoordinates[i];
            drawStampCommand(mpc.x, mpc.y);
            //System.out.println(mpc.x + "," + mpc.y);
        }
    }
    else
    {
        for (int i = 0; i < middlepointCoordinates.length; i++)
        {
            MiddlepointCoordinates mpc = middlepointCoordinates[i];
            drawStamp(mpc.x, mpc.y);
            //System.out.println(mpc.x + "," + mpc.y);
        }
    }
}

void setupAndInitArray()
{
    noiseSeed(seed);
    randomSeed(seed);
    middlepointCoordinates = new MiddlepointCoordinates[numberOfAgents * tailLength];
    for (int i = 0; i < numberOfAgents; i++)
    {
        int xVal = (int) random(canvasSizeX);
        int yVal = (int) random(canvasSizeY);
        MiddlepointCoordinates mpc = new MiddlepointCoordinates(xVal, yVal);
        middlepointCoordinates[i * tailLength] = mpc;
        
        float newXVal = mpc.x;
        float newYVal = mpc.y;
        
        for (int j = 1; j < tailLength; j++)
        {
            newXVal = newXVal + (cos(map(noise(newXVal * noiseFactor,newYVal * noiseFactor), 0.0f, 1.0f, 0.0f, (float) Math.PI * 2)) * movespeed);
            newYVal = newYVal + (sin(map(noise(newXVal * noiseFactor,newYVal * noiseFactor), 0.0f, 1.0f, 0.0f, (float) Math.PI * 2)) * movespeed);
            
            middlepointCoordinates[i * tailLength + j] = new MiddlepointCoordinates((int) newXVal, (int) newYVal);
        }
    }
}

void drawNoise()
{
    loadPixels();
    
    for (int i = 0; i < (width * height); i++)
    {
        int y = floor(i / width);
        int x = i - y * width;
        float bwColor = noise(x * noiseFactor, y * noiseFactor);
        
        //System.out.print(bwColor + " ");
        
        bwColor = bwColor * 255;
        pixels[i] = color(bwColor, bwColor, bwColor);
    }
    
    updatePixels();
}

void saveAsDXF()
{
    print("save as " + seed + ".dxf");
    clear();
    drawWithOption(true);
    beginRaw(DXF, seed + ".dxf");
    endRaw();
}

void saveAsSVG()
{
    clear();    
    print("save as " + seed + ".svg");
    clear();
    drawWithOption(true);
    beginRaw(SVG, seed + ".svg");
    endRaw();
}
