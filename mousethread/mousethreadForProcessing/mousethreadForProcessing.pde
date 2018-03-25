import processing.dxf.*;

private boolean trackMouseMove = false;
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
    
}

void mouseClicked()
{
    this.trackMouseMove = !this.trackMouseMove;
}

void mouseMoved()
{
  
}

void mouseSafeTimer()
{
    if (!this.trackMouseMove)
    {
      return;
    }

    safeMouseCoords();
    trackMouseMove = false;
}

void safeMouseCoords()
{
    this.mouseCoords.add(new MouseCoordinates(mouseX, mouseY));
}
