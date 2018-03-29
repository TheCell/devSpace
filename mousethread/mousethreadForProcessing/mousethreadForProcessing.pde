import java.util.ArrayList;
import java.util.Iterator;
import processing.dxf.*;

private int timeBetweenPointsMS = 15;
private long timeLastPoint = System.currentTimeMillis();
private boolean trackMouseMove = false;
private boolean trackingInProgress = false;
private ArrayList<MouseCoordinates> mouseCoords = null;
private ArrayList<MouseCoordinates> alreadyDrawnPoints = null;

void settings()
{
    size(800, 800);
}

void setup()
{
   mouseCoords = new ArrayList<MouseCoordinates>();
   alreadyDrawnPoints = new ArrayList<MouseCoordinates>();
}

void draw()
{
    mouseTrackingInterval();
    drawPointsOnCanvas();
    mouseSafeTimer();
}

void mouseClicked()
{
    this.trackingInProgress = !this.trackingInProgress;
}

void mouseMoved()
{
    
}

void mouseSafeTimer()
{
    if (!this.trackMouseMove || !this.trackingInProgress)
    {
        return;
    }

    safeMouseCoords();
    this.trackMouseMove = false;
}

void safeMouseCoords()
{
    this.mouseCoords.add(new MouseCoordinates(mouseX, mouseY));
}

void drawPointsOnCanvas()
{
    updateCoordArrays();
    Iterator<MouseCoordinates> iterator = this.alreadyDrawnPoints.iterator();
    
    while (iterator.hasNext())
    {
        MouseCoordinates currentCoords = iterator.next();
        drawCircle(currentCoords.x, currentCoords.y);
        drawRectangle(currentCoords.x, currentCoords.y);
    }
}

void mouseTrackingInterval()
{
    if (this.trackMouseMove)
    {
        return;
    }
    
    if ((timeLastPoint + timeBetweenPointsMS) < System.currentTimeMillis())
    {
        this.trackMouseMove = true;
        timeLastPoint = System.currentTimeMillis();
    }
}

private ArrayList<MouseCoordinates> getAndResetNewCoords()
{
    ArrayList<MouseCoordinates> newCoordinates = mouseCoords; 
    this.mouseCoords = new ArrayList<MouseCoordinates>(); 
    return newCoordinates;
}

private void updateCoordArrays()
{
    this.alreadyDrawnPoints.addAll(getAndResetNewCoords());
}

private void drawCircle(float x, float y)
{
    float width = 10.0f;
    float height = 10.0f;
    ellipse(x, y, width, height);
}

private void drawRectangle(float x, float y)
{
    float width = 50.0f;
    float height = 10.0f;
    rect( x, y - height / 2, width, height);
}
