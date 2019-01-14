import java.util.Objects;

class Point implements Comparable<Point>
{
  private PVector coordinates;
  private color pColor;

  Point(int x, int y)
  {
    this(new PVector(x, y));
  }

  Point(PVector coordinates)
  {
    this
      (
      coordinates, 
      color
      (
      (int)random(0, 255), 
      (int)random(0, 255), 
      (int)random(0, 255)
      )
      );
  }

  Point(PVector coordinates, color pointColor)
  {
    this.coordinates = coordinates;
    this.pColor = pointColor;
  }
  
  public PVector getCoords()
  {
    return this.coordinates;
  }

  @Override
  public boolean equals(Object o)
  {
    if (o == this)
    {
      return true;
    }

    if (!(o instanceof Point))
    {
      return false;
    }

    Point point = (Point)o;
    return point.coordinates.equals(coordinates);
  }
  
  @Override
  public int hashCode()
  {
    return Objects.hash(coordinates.hashCode());
  }
  
  @Override
  public int compareTo(Point o)
  {
    int xComp = Float.compare(this.coordinates.x, o.coordinates.x);
    if (xComp != 0)
    {
      return xComp;
    }
    
    int yComp = Float.compare(this.coordinates.y, o.coordinates.y);
    if (yComp != 0)
    {
      return yComp;
    }
    
    int zComp = Float.compare(this.coordinates.z, o.coordinates.z);
    return zComp;
  }
}
