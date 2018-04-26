

const char HEADER = 'E'; 
const int TOTAL_BYTES = 3; //header + 1 button + 2 relay

const int rel1 = 3;
const int rel2 = 4;
const int rel3 = 5;
const int rel4 = 6;

// Reading voltage(change) on designated pin and serial printing the value.

int sensorPin0 = A0; // Define input pin 
int sensorPin1 = A1; // Define input pin 


void setup() 
{
  
  Serial.begin(115200);  //baudrate (symbols or pulses per second) for serial communication with MAX

  pinMode(rel1, OUTPUT);
  pinMode(rel2, OUTPUT);
  pinMode(rel3, OUTPUT);
  pinMode(rel4, OUTPUT);
}

void loop ()

{
  if (Serial.available() >= TOTAL_BYTES)
  {
    if (Serial.read() == HEADER)
    {
      int val1 = Serial.read();
      digitalWrite (rel1, val1);
      int val2 = Serial.read();
      digitalWrite (rel2, val2);
      int val3 = Serial.read();
      digitalWrite (rel3, val3);
      int val4 = Serial.read();
      digitalWrite (rel4, val4);
    }
  }

  long a = analogRead(sensorPin0); // name the value in order to create a readable list between the different sensors
  long b = analogRead(sensorPin1); // name the value in order to create a readable list between the different sensors
  // long b = analogRead(A1);
  // long c and so on...

  Serial.print("a");    // print name to unlist 
  Serial.print(a);      // value is printed to serial
  Serial.print("b");  // + sensors
  Serial.print(b);
  
  Serial.println("");  // carriage return / next line
  
  delay (100); // time interval between readings (milliseconds) read every tenth of a second 
}

