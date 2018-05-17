int potPin = 2;
int LEDS = 3;
int switchPin = 2;
int val = 0;

void setup()
{
  // put your setup code here, to run once:
  pinMode(LEDS, OUTPUT);
  pinMode(switchPin, INPUT);
  Serial.begin(9600);      // open the serial port at 9600 bps:    
}

void loop()
{
  // put your main code here, to run repeatedly:
  val = analogRead(potPin);    // read the value from the sensor
  Serial.println(digitalRead(switchPin));
  digitalWrite(LEDS, HIGH);  // turn the ledPin on
  delay(val);                  // stop the program for some time
  digitalWrite(LEDS, LOW);   // turn the ledPin off
  delay(val);                  // stop the program for some time
  
}
