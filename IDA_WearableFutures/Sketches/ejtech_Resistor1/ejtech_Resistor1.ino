int sensorPin = A1;
int sensorPin2 = A2;

void setup() {
 Serial.begin(9600); // put your setup code here, to run once:

}

void loop() {
  long a = analogRead(sensorPin);
  long b = analogRead(sensorPin2);
  Serial.print("a");
  Serial.print(a);
  Serial.print("b");
  Serial.print(b);
 
  Serial.println("");
  delay (100);
  // put your main code here, to run repeatedly:

}
