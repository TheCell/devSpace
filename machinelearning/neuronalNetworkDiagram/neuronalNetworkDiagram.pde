Network network;

void setup()
{
    size(800, 300);
    network = new Network(width/2,height/2);
    
    Neuron a = new Neuron(-350, 0);
    Neuron b = new Neuron(-200, 0);
    Neuron c = new Neuron(0, 100);
    Neuron d = new Neuron(0, -100);
    Neuron e = new Neuron(200, 0);
    Neuron f = new Neuron(350, 0);
    
    network.connect(a, b,1);
    network.connect(b, c,random(1));
    network.connect(b, d,random(1));
    network.connect(c, e,random(1));
    network.connect(d, e,random(1));
    network.connect(e, f,1);
    
    network.addNeuron(a);
    network.addNeuron(b);
    network.addNeuron(c);
    network.addNeuron(d);
    network.addNeuron(e);
    network.addNeuron(f);
}

void draw()
{
    background(255);
    network.update();
    network.display();
  
    // Every 30 frames feed in an input
    if (frameCount % 30 == 0)
    {
        network.feedforward(random(1));
    }
}
