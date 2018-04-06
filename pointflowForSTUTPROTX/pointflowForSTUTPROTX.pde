import processing.dxf.*;
import processing.svg.*;

// big stamp
/*
int canvasSizeX = 800;
int canvasSizeY = 800;
int numberOfAgents = 1;
int tailLength = 16;
int movespeed = 250;
float noiseFactor = 0.0005;
*/
// little stamp
/*
int canvasSizeX = 2000;
int canvasSizeY = 4000;
int numberOfAgents = 50;
int tailLength = 16;
int movespeed = 45;
float noiseFactor = 0.001;
*/
int canvasSizeX = 800;
int canvasSizeY = 800;
int numberOfAgents = 1;
int tailLength = 16;
int movespeed = 250;
float noiseFactor = 0.0005;
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
    
    // f
    if (int(key) == 102)
    {
        saveAsText();
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

// stampindex is 1, 2, 3 etc.
String writeStampAsSVG(int x, int y, float angle, int stampindex)
{
    // big stamp
    /*
    float xOffset = 220 * cos(angle);
    float yOffset = 220 * sin(angle);
    */
    // little stamp
    /*
    float xOffset = 50 * cos(angle);
    float yOffset = 50 * sin(angle);
    */
    // little stamp NEW
    /*
    float xOffset = 0;
    float yOffset = 0;
    */
    float xOffset = 220 * cos(angle);
    float yOffset = 220 * sin(angle);
    
    if (stampindex == 1)
    {
        return "<polyline points=\"" + (x + xOffset) + "," + (y + yOffset) + " " + (x + xOffset + 100 * cos(angle)) + "," + (y + yOffset + 100 * sin(angle)) + " " + (x + xOffset + (100 + stampindex * 10) * cos(angle)) + "," + (y + yOffset + (100 + stampindex * 10) * sin(angle)) + " " + (x + xOffset + (100 + stampindex * 10 + 10) * cos(angle)) + "," + (y + yOffset + (100 + stampindex * 10 + 10) * sin(angle)) + "\" style=\"stroke:rgb(255,0,0);stroke-width:1\" />";
        //return "<polyline points=\"" + x + "," + y + " " + (x + 100 * cos(angle)) + "," + (y + 100 * sin(angle)) + " " + (x + (100 + stampindex * 10) * cos(angle)) + "," + (y + (100 + stampindex * 10) * sin(angle)) + " " + (x + (100 + stampindex * 10 + 10) * cos(angle)) + "," + (y + (100 + stampindex * 10 + 10) * sin(angle)) + "\" style=\"stroke:rgb(0,0,255);stroke-width:5\" />";
        //return "<line x1=\"" + x + "\" y1=\"" + y + "\" x2=\"" + x + "\" y2=\"" + (y + 100) + "\" style=\"stroke:rgb(255,0,0);stroke-width:1\" />";
    }
    else
    {
        return "<polyline points=\"" + (x + xOffset) + "," + (y + yOffset) + " " + (x + xOffset + 100 * cos(angle)) + "," + (y + yOffset + 100 * sin(angle)) + " " + (x + xOffset + (100 + stampindex * 10) * cos(angle)) + "," + (y + yOffset + (100 + stampindex * 10) * sin(angle)) + " " + (x + xOffset + (100 + stampindex * 10 + 10) * cos(angle)) + "," + (y + yOffset + (100 + stampindex * 10 + 10) * sin(angle)) + "\" style=\"stroke:rgb(0,255,0);stroke-width:1\" />";
        //return "<polyline points=\"" + x + "," + y + " " + (x + 100 * cos(angle)) + "," + (y + 100 * sin(angle)) + " " + (x + (100 + stampindex * 10) * cos(angle)) + "," + (y + (100 + stampindex * 10) * sin(angle)) + " " + (x + (100 + stampindex * 10 + 10) * cos(angle)) + "," + (y + (100 + stampindex * 10 + 10) * sin(angle)) + "\" style=\"stroke:rgb(0,0,255);stroke-width:5\" />";
        //return "<line x1=\"" + x + "\" y1=\"" + y + "\" x2=\"" + x + "\" y2=\"" + (y + 100) + "\" style=\"stroke:rgb(255,0,0);stroke-width:1\" />";
    }
}

// stampindex is 1, 2, 3 etc.
String writeStampAsSVG(int x, int y, float angle, int stampindex, boolean isDebug)
{
    if (isDebug)
    {
        x = 0;
        y = 0;
        // big stamp
        /*
        float xOffset = 220 * cos(angle);
        float yOffset = 220 * sin(angle);
        */
        // little stamp
        /*
        float xOffset = 50 * cos(angle);
        float yOffset = 50 * sin(angle);
        */
        // little stamp NEW
        /*
        float xOffset = 0;
        float yOffset = 0;
        */
        float xOffset = 220 * cos(angle);
        float yOffset = 220 * sin(angle);
        
        return "<polyline points=\"" + (x + xOffset) + "," + (y + yOffset) + " " + (x + xOffset + 100 * cos(angle)) + "," + (y + yOffset + 100 * sin(angle)) + " " + (x + xOffset + (100 + stampindex * 10) * cos(angle)) + "," + (y + yOffset + (100 + stampindex * 10) * sin(angle)) + " " + (x + xOffset + (100 + stampindex * 10 + 10) * cos(angle)) + "," + (y + yOffset + (100 + stampindex * 10 + 10) * sin(angle)) + "\" style=\"stroke:rgb(0,0,255);stroke-width:5\" />";
        //return "<polyline points=\"" + x + "," + y + " " + (x + 100 * cos(angle)) + "," + (y + 100 * sin(angle)) + " " + (x + (100 + stampindex * 10) * cos(angle)) + "," + (y + (100 + stampindex * 10) * sin(angle)) + " " + (x + (100 + stampindex * 10 + 10) * cos(angle)) + "," + (y + (100 + stampindex * 10 + 10) * sin(angle)) + "\" style=\"stroke:rgb(0,0,255);stroke-width:5\" />";
        //return "<line x1=\"" + x + "\" y1=\"" + y + "\" x2=\"" + x + "\" y2=\"" + (y + 100) + "\" style=\"stroke:rgb(255,0,0);stroke-width:1\" />";
    }
    
    return "not important";
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

void exportAsText()
{
    String svg = "";
    svg = "<svg height=\"" + canvasSizeX + "\" width=\"" + canvasSizeY + "\">";
    
    for (int i = 0; i < middlepointCoordinates.length; i++)
    {
        MiddlepointCoordinates mpc = middlepointCoordinates[i];
        // for big stamp
        /*
        svg += writeStampAsSVG(mpc.x, mpc.y, mpc.angle + (float) Math.PI * 1/2, 2);
        svg += writeStampAsSVG(mpc.x, mpc.y, mpc.angle - (float) Math.PI * 1/2, 2);
        */
        // for little stamp
        /*
        svg += writeStampAsSVG(mpc.x, mpc.y, mpc.angle + (float) Math.PI * 1/2, 1);
        */
        svg += writeStampAsSVG(mpc.x, mpc.y, mpc.angle + (float) Math.PI * 1/2, 2);
        svg += writeStampAsSVG(mpc.x, mpc.y, mpc.angle - (float) Math.PI * 1/2, 2);
    }
    
    // example line for rescale
    svg += writeStampAsSVG(0, 0, (float) Math.PI * 1/2, 1, true);
    //svg += writeStampAsSVG(0, 0, (float) Math.PI * 3/2, 2, true);
    svg += "</svg>";
    
    String[] svgArr = new String[1];
    svgArr[0] = svg;
    saveStrings(seed+ ".txt", svgArr);
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
        MiddlepointCoordinates mpc = new MiddlepointCoordinates(xVal, yVal, map(noise(xVal * noiseFactor,yVal * noiseFactor), 0.0f, 1.0f, 0.0f, (float) Math.PI * 2));

        middlepointCoordinates[i * tailLength] = mpc;
        
        float newXVal = mpc.x;
        float newYVal = mpc.y;
        float angle = 0.0f;
        
        for (int j = 1; j < tailLength; j++)
        {
            angle = map(noise(newXVal * noiseFactor,newYVal * noiseFactor), 0.0f, 1.0f, 0.0f, (float) Math.PI * 2);
            newXVal = newXVal + (cos(angle) * movespeed);
            newYVal = newYVal + (sin(angle) * movespeed);
            
            middlepointCoordinates[i * tailLength + j] = new MiddlepointCoordinates((int) newXVal, (int) newYVal, angle);
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

void saveAsText()
{
    print("save as " + seed + ".txt");
    exportAsText();
}
