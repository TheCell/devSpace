class Network
{
    ArrayList<Neuron> neurons;
    ArrayList<Connection> connections;
    PVector location;
    
    Network(float x, float y)
    {
        this.location = new PVector(x, y);
        this.neurons = new ArrayList<Neuron>();
        this.connections = new ArrayList<Connection>();
    }
    
    void addNeuron(Neuron n)
    {
        neurons.add(n);
    }
    
    void connect(Neuron from, Neuron to, float weight)
    {
        Connection c = new Connection(from, to, weight);
        from.addConnection(c);
        connections.add(c);
    }
    
    void feedforward(float input)
    {
        Neuron start = neurons.get(0);
        start.feedforward(input);
    }
    
    void update()
    {
        for (Connection c : connections)
        {
            c.update();
        }
    }
    
    void display()
    {
        pushMatrix();
        translate(location.x, location.y);
        for (Neuron n : neurons)
        {
            n.display();
        }
        
        for (Connection c : connections)
        {
            c.display();
        }
        popMatrix();
    }
}
