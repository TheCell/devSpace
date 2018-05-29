int potPin = 0;
int LEDS = 3;
int blueLed = 4;
int yellowLed = 5;
int val = 0;
int buzzerPin = 2;
bool blueLedOn = false;

void setup()
{
  // put your setup code here, to run once:
  pinMode(LEDS, OUTPUT);
  pinMode(blueLed, OUTPUT);
  pinMode(yellowLed, OUTPUT);
  pinMode(buzzerPin, OUTPUT);
  Serial.begin(9600);      // open the serial port at 9600 bps:    
}

void loop()
{
  // put your main code here, to run repeatedly:
  val = analogRead(potPin);    // read the value from the sensor
  Serial.println(val);

  if (random(50) > 30)
  {
    digitalWrite(yellowLed, HIGH);
  }
  else
  {
    digitalWrite(yellowLed, LOW);
  }
  
  digitalWrite(LEDS, HIGH);  // turn the ledPin on
  if (blueLedOn)
  {
    blueLedOn = false;
    digitalWrite(blueLed, LOW);
  }
  else
  {
    blueLedOn = true;
    digitalWrite(blueLed, HIGH);
  }

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
