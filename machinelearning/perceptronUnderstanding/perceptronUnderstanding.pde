float[] inputs = {12, 4};
float[] weights = {0.5, -1};

void setup()
{
    float sum = 0;
    for (int i = 0; i < inputs.length; i++)
    {
        sum += inputs[i]*weights[i];
    }
    
    float output = activate(sum);
    System.out.println("output: " + output);
}

int activate(float sum)
{
    if (sum > 0)
    {
        return 1;
    }
    return -1;
}
