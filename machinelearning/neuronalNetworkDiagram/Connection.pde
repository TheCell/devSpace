class Connection
{
    Neuron from;
    Neuron to;
    float weight;
    // animation variables
    boolean sending = false;
    PVector sender;
    float output;
    
    Connection(Neuron from, Neuron to, float w)
    {
        this.weight = w;
        this.from = from;
        this.to = to;
    }
    
    void feedforward(float val)
    {
        sending = true;
        sender = from.location.get();
        output = val*weight;
    }
    
    void update()
    {
        if (sending)
        {
            sender.x = lerp(sender.x, to.location.x, 0.1);
            sender.y = lerp(sender.y, to.location.y, 0.1);
            
            float d = PVector.dist(sender, to.location);
            if ( d < 1)
            {
                to.feedforward(output);
                sending = false;
            }
        }
    }
    
    void display()
    {
        stroke(0);
        strokeWeight(1+weight*4);
        line(from.location.x, from.location.y, to.location.x, to.location.y);
        
        if (sending)
        {
            fill(0);
            strokeWeight(1);
            ellipse(sender.x, sender.y, 16, 16);
        }
    }
}
