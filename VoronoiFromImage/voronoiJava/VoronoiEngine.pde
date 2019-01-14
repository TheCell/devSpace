import java.util.Arrays;
import java.util.PriorityQueue;

class VoronoiEngine
{
  private PVector imageSize;
  private int numberOfSeeds;
  private Point[] seedPoints; // so called "sites" minimal y-coordinate, ordered by x-coordinate
  private Beachline beachline; // complex line made of several parts.
  private PriorityQueue priorityQueue = new PriorityQueue();
  private Region[] regions;
  
  VoronoiEngine(PVector imageSize, int numberOfSeeds)
  {
    this.imageSize = imageSize;
    this.numberOfSeeds = numberOfSeeds;
    this.seedPoints = new Point[numberOfSeeds];
    this.regions = new Region[numberOfSeeds];
    
    generateExample();
  }
  
  public void draw()
  {
    for (int i = 0; i < this.numberOfSeeds; i++)
    {
      this.regions[i].draw();
      PVector coords = seedPoints[i].getCoords();
      point(coords.x, coords.y);
    }
  }
  
  private void generateExample()
  {
    this.seedPoints = generateRandomPoints();
    sortSeeds();
    
    this.regions = generateRegionsFromSeedPoints();
    /*
    // generate a region
    this.regions[0].addVertex(new Point(10,10));
    this.regions[0].addVertex(new Point(30,10));
    this.regions[0].addVertex(new Point(40,15));
    this.regions[0].addVertex(new Point(50,30));
    this.regions[0].addVertex(new Point(20,30));
    */
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
      randomPoints[i] = new Point
        (
          (int)random(0,this.imageSize.x),
          (int)random(0,this.imageSize.y)
        );
    }
    
    return randomPoints;
  }
  
  private Region[] generateRegionsFromSeedPoints()
  {
    Region[] regionsFromSeeds = new Region[this.numberOfSeeds];
    
    for (int i = 0; i < this.seedPoints.length; i++)
    {
      regionsFromSeeds[i] = new Region(this.seedPoints[i]);
    }
    
    return regionsFromSeeds;
  }
}
