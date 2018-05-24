int potPin = 2;
int LEDS = 3;
int switchPin = 2;
int val = 0;
int buzzerPin = 4;
int sonarVal = 0;
int sonarAnalogPin = 5;

void setup()
{
  // put your setup code here, to run once:
  pinMode(LEDS, OUTPUT);
  pinMode(switchPin, INPUT);
  pinMode(buzzerPin, OUTPUT);
  Serial.begin(9600);      // open the serial port at 9600 bps:    
}

void loop()
{
  // put your main code here, to run repeatedly:
  val = analogRead(potPin);    // read the value from the sensor
  sonarVal = analogRead(sonarAnalogPin);
  Serial.print("sonarval: ");
  Serial.println(sonarVal);
  Serial.print(digitalRead(switchPin));
  Serial.print("_");
  Serial.println(val);
  digitalWrite(LEDS, HIGH);  // turn the ledPin on

  int waitTime = 1;
  if (val < 300)
  {
    waitTime = 1;
  }
  else if (val < 600)
  {
    waitTime = 2;
  }
  else
  {
    waitTime = 3;
  }
  
  for (int i = 0; i < 80; i++)
  {
      digitalWrite(buzzerPin, HIGH);  // turn the ledPin on
      delay(waitTime);
      digitalWrite(buzzerPin, LOW);   // turn the ledPin off
      delay(waitTime);
  }
  delay(val);                  // stop the program for some time
  digitalWrite(LEDS, LOW);     // turn the ledPin off
  delay(val);                  // stop the program for some time
  
}
