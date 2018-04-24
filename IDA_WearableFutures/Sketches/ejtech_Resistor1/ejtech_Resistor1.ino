int sensorPin = A1;

void setup() {
 Serial.begin(9600); // put your setup code here, to run once:

}

void loop() {
  long a = analogRead(A1);
  Serial.print("a");
  Serial.print(a);
  Serial.println("");
  delay (100);
  // put your main code here, to run repeatedly:

}
