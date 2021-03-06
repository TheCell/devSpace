class Neuron
{
    PVector location;
    ArrayList<Connection> connections;
    float sum = 0;
    
    Neuron(float x, float y)
    {
        this.location = new PVector(x, y);
        this.connections = new ArrayList<Connection>();
    }
    
    void addConnection(Connection c)
    {
        connections.add(c);
    }
    
    void feedforward(float input)
    {
        sum += input;
        if (sum > 1)
        {
            fire();
            sum = 0;
        }
    }
    
    void fire()
    {
        for (Connection c : connections)
        {
            c.feedforward(sum);
        }
    }
    
    void display()
    {
        stroke(0);
        strokeWeight(1);
        fill(0);
        ellipse(location.x, location.y, 16, 16);
       
    }
}
