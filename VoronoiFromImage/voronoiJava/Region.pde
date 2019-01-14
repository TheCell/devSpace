import java.util.LinkedList;

class Region
{
  private Point centerPoint;
  private color regionColor;
  private LinkedList<Point> vertexPoints;
  
  Region(Point centerPoint)
  {
    this
    (
      centerPoint,
      color
      (
        (int)random(0, 255), 
        (int)random(0, 255), 
        (int)random(0, 255)
      )
    );
  }
  
  Region(Point centerPoint, color regionColor)
  {
    this
    (
      centerPoint,
      regionColor,
      new LinkedList<Point>()
    );
  }
  
  Region(Point centerPoint, color regionColor, LinkedList<Point> vertexPoints)
  {
    this.centerPoint = centerPoint;
    this.regionColor = regionColor;
    this.vertexPoints = vertexPoints;
  }
  
  public void addVertex(Point vertexPoint)
  {
    this.vertexPoints.add(vertexPoint);
  }
  
  public void draw()
  {
    Point[] vertexPoints = this.vertexPoints.toArray(new Point[0]);
    if (vertexPoints.length > 1)
    {
      PShape shape = createShape();
      shape.beginShape();
      shape.fill(this.regionColor);
      for (int i = 0; i < vertexPoints.length; i++)
      {
        PVector coords = vertexPoints[i].getCoords();
        shape.vertex(coords.x, coords.y);
      }
      shape.endShape(CLOSE);
      shape(shape);
    }
  }
}
