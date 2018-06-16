int sensorPin = A0;    // select the input pin for the potentiometer
int ledPin = 13;      // select the pin for the LED
int sensorValue = 0;  // variable to store the value coming from the sensor
int oldValue = 0;
int errorTolerance = 50;
int soundPlayPin = 10;
int soundRecordPin = 11;

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
  }
  sensorValue = sensorValue / 10;

  if (oldValue > (sensorValue + errorTolerance) || oldValue < (sensorValue - errorTolerance))
  {
      // turn the ledPin on
      digitalWrite(ledPin, HIGH);
      // stop the program for for <sensorValue> milliseconds:
      Serial.println("Changed");
      digitalWrite(soundPlayPin, LOW);
      digitalWrite(soundRecordPin, LOW);
      delay(200);
      digitalWrite(soundPlayPin, HIGH);
      digitalWrite(soundRecordPin, HIGH);
  }

  /*
  Serial.print("seonsorValue ");
  Serial.println(sensorValue);
  Serial.print("oldValue ");
  Serial.println(oldValue);
  */
  oldValue = sensorValue;
  // stop the program for <sensorValue> milliseconds:
  delay(30);
}
