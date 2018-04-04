class MiddlepointCoordinates
{
    public int x;
    public int y;
    public float angle;
   
    MiddlepointCoordinates()
    {
        this(0, 0);
    }
    
    MiddlepointCoordinates(int x, int y)
    {
        // because this(...) does not work ?
        this.x = x;
        this.y = y;
        this.angle = 0.0f;
    }
    
    MiddlepointCoordinates(int x, int y, float angle)
    {
        this.x = x;
        this.y = y;
        this.angle = angle;
    }
}
