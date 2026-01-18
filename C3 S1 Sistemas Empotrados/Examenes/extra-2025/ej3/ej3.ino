void setup() {
  Serial.begin(9600);
  pinMode(18, INPUT);
  pinMode(2,OUTPUT);

}

void loop()
{
  int voltaje =  3300.00/4095.00 * analogRead(18);
  Serial.println(voltaje);

  if(voltaje>1500)
  {
    digitalWrite(2,HIGH);
  }
  else
  {
    digitalWrite(2,LOW);
  }

}
