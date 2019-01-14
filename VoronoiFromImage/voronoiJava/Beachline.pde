import java.util.LinkedList;

class Beachline
{
  private LinkedList beachLine;
  
  Beachline()
  {
    this.beachLine = new LinkedList();
  }
  
  public int getSize()
  {
    return beachLine.size();
  }
  
  public void add(Object o)
  {
    this.beachLine.add(o);
  }
  
  public void clear()
  {
    this.beachLine = new LinkedList();
  }
}
