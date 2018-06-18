int sensorPin = A0;    // select the input pin for the potentiometer
int ledPin = 13;      // select the pin for the LED
int sensorValue = 0;  // variable to store the value coming from the sensor
int oldValue = 0;
int errorTolerance = 50;
int soundPlayPin = 10;
int soundRecordPin = 11;
int recentlySwitched = 0;
int waitLoopsTillNextPlay = 20;

void setup() {
  // declare the ledPin as an OUTPUT:
  pinMode(ledPin, OUTPUT);
  pinMode(soundPlayPin, OUTPUT);
  digitalWrite(soundPlayPin, HIGH);
  digitalWrite(soundRecordPin, HIGH);
  Serial.begin(9600);

  // initiate with basic values
  oldValue = 0;
  for(int i = 0; i < 10; i++)
  {
    oldValue += analogRead(sensorPin);
    delay(5);
  }
  oldValue = oldValue / 10;
}

void loop() {
  // turn the ledPin off:
  digitalWrite(ledPin, LOW);
  // read the value from the sensor:
  sensorValue = 0;
  for(int i = 0; i < 10; i++)
  {
    sensorValue += analogRead(sensorPin);
    delay(2);
  }
  sensorValue = sensorValue / 10;

  if (oldValue > (sensorValue + errorTolerance) || oldValue < (sensorValue - errorTolerance))
  {
      // turn the ledPin on
      digitalWrite(ledPin, HIGH);
      // stop the program for for <sensorValue> milliseconds:
      Serial.println("Changed");
      if (recentlySwitched > waitLoopsTillNextPlay)
      {
        Serial.println("playing sound");
        digitalWrite(soundPlayPin, LOW);
        digitalWrite(soundRecordPin, LOW);
        delay(200);
        digitalWrite(soundPlayPin, HIGH);
        digitalWrite(soundRecordPin, HIGH);
        recentlySwitched = 0;
      }
  }

  /*
  Serial.print("seonsorValue ");
  Serial.print(sensorValue);
  Serial.print(" oldValue ");
  Serial.print(oldValue);
  Serial.print(" sensorValue + errorTolerance ");
  Serial.print(sensorValue + errorTolerance);
  Serial.print("sensorValue - errorTolerance");
  Serial.println(sensorValue - errorTolerance);
  */
  
  oldValue = sensorValue;
  recentlySwitched = recentlySwitched + 1;
  // stop the program for <sensorValue> milliseconds:
  delay(200);
}
