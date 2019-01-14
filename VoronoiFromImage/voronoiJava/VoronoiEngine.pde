import java.util.Arrays;
import java.util.PriorityQueue;

class VoronoiEngine
{
  private PVector imageSize;
  private int numberOfSeeds;
  private Point[] seedPoints; // so called "sites" minimal y-coordinate, ordered by x-coordinate
  private Beachline beachline = new Beachline(); // complex line made of several parts.
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
      if (this.regions.length > 0 && this.regions[i] != null)
      {
        this.regions[i].draw();
      }
      PVector coords = seedPoints[i].getCoords();
      point(coords.x, coords.y);
    }
  }

  private void generateExample()
  {
    this.seedPoints = generateRandomPoints();
    sortSeeds();

    //this.regions = generateRegionsFromSeedPoints();
    /*
    // generate a region
     this.regions[0].addVertex(new Point(10,10));
     this.regions[0].addVertex(new Point(30,10));
     this.regions[0].addVertex(new Point(40,15));
     this.regions[0].addVertex(new Point(50,30));
     this.regions[0].addVertex(new Point(20,30));
     */

    calculateVoronoi();
  }

  private void calculateVoronoi()
  {
    if (this.seedPoints.length < 2)
    {
      print("not enough points");
      return;
    }
    
    // add regions and boundaryRays between points. See T <- Rp1, C0p1p2.. in wiki pseudocode
    this.beachline.clear();
    Point pointLeft;
    Point currentPoint = this.seedPoints[0];
    Region tempRegion = new Region(this.seedPoints[0]);
    this.beachline.add(tempRegion);
    
    for (int i = 1; i < this.seedPoints.length; i++)
    {
      pointLeft = currentPoint;
      currentPoint = this.seedPoints[i];
      // not boundaryray from p1 to p2 I need the bound half way inbetween
      this.beachline.add(new BoundaryRay(pointLeft, currentPoint));
      this.beachline.add(new Region(currentPoint));
    }
    
    // prepare for while
    this.priorityQueue.clear();
    for (int i = this.seedPoints.length -1; i >= 0; i--)
    {
      this.priorityQueue.add(this.seedPoints[i]);
    }
    
    while (this.priorityQueue.peek() != null)
    {
      // I'll have to think about how to save and retrieve different datatypes here
      // if p is site then this
      // todo
      Point site = (Point) this.priorityQueue.poll();

      //if p is voronoi vertex then this
      // todo next
      println("working through point");
    }
    
    println(this.beachline.getSize());
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
        (int)random(0, this.imageSize.x), 
        (int)random(0, this.imageSize.y)
        );
    }

    return randomPoints;
  }

  /*
  private Region[] generateRegionsFromSeedPoints()
   {
   Region[] regionsFromSeeds = new Region[this.numberOfSeeds];
   
   for (int i = 0; i < this.seedPoints.length; i++)
   {
   regionsFromSeeds[i] = new Region(this.seedPoints[i]);
   }
   
   return regionsFromSeeds;
   }
   */
}
