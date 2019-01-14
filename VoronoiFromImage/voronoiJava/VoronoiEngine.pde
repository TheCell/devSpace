import java.util.Arrays;

class VoronoiEngine
{
  PVector imageSize;
  int numberOfSeeds;
  Point[] seedPoints;
  
  VoronoiEngine(PVector imageSize, int numberOfSeeds)
  {
    this.imageSize = imageSize;
    this.numberOfSeeds = numberOfSeeds;
    this.seedPoints = new Point[numberOfSeeds];
    
    generateExample();
  }
  
  public void draw()
  {
    for (int i = 0; i < this.numberOfSeeds; i++)
    {
      PVector coords = seedPoints[i].getCoords();
      point(coords.x, coords.y);
    }
  }
  
  private void generateExample()
  {
    this.seedPoints = generateRandomPoints();
    sortSeeds();
  }
  
  private void sortSeeds()
  {
    /*
    println("pre sort");
    for (int i = 0; i < this.seedPoints.length; i++)
    {
      PVector coords = this.seedPoints[i].getCoords();
      print(coords.x + " " + coords.y + " " + coords.z + "; ");
    }
    */
    Arrays.sort(this.seedPoints);
    
    /*
    println("post sort");
    for (int i = 0; i < this.seedPoints.length; i++)
    {
      PVector coords = this.seedPoints[i].getCoords();
      print(coords.x + " " + coords.y + " " + coords.z + "; ");
    }
    */
  }
  
  private Point[] generateRandomPoints()
  {
    Point[] randomPoints = new Point[this.numberOfSeeds];
    
    for (int i = 0; i < this.numberOfSeeds; i++)
    {
      randomPoints[i] = new Point(
        (int)random(0,this.imageSize.x),
        (int)random(0,this.imageSize.y));
    }
    
    return randomPoints;
  }
}
