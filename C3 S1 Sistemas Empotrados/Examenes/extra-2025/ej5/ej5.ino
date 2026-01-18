void setup() {
  Serial.begin(115200);

  ledcAttach(4,5000,8);

}
long tiempo =  millis();

void loop() {
  // put your main code here, to run repeatedly:
  ledcWriteNote(4, NOTE_C, 3);
  delay(500);

  ledcWriteNote(4, NOTE_D, 3);
  delay(500);
  ledcWriteNote(4, NOTE_E, 3);
  delay(500);
  ledcWriteNote(4, NOTE_F, 3);
  delay(500);
  ledcWriteNote(4, NOTE_G, 3);
  delay(500);
  ledcWriteNote(4, NOTE_A, 3);
  delay(500);
  ledcWriteNote(4, NOTE_B, 3);
  delay(500);
  ledcWriteNote(4, NOTE_C, 4);
  delay(500);

}
/*
ledcFade(4,0,4095,3000);
  delay(3000);
  ledcFade(4,4095,0,3000);
  delay(3000);
*/
