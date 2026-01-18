#define PINANALOG 2
#define PINLEDBLANCO 18
#define PINBTN 21

volatile bool ticked = false;
volatile bool btn_presionado = false;

void IRAM_ATTR onTimerTick()
{
  ticked = !ticked;
}

void IRAM_ATTR pin21ISR()
{
  btn_presionado = true;
}

hw_timer_t *timer = NULL; 

void setup()
{
    Serial.begin(9600);
    pinMode(PINANALOG, ANALOG);
    pinMode(PINBTN, INPUT_PULLUP);
    pinMode(PINLEDBLANCO, OUTPUT);

    timer =  timerBegin(1000000);
    timerAttachInterrupt(timer, onTimerTick);
    timerAlarm(timer,250000,true,0);

    attachInterrupt(PINBTN, pin21ISR, FALLING);

    neopixelWrite(RGB_BUILTIN, 128, 200, 50);
}

void loop()
{

  digitalWrite(PINLEDBLANCO, HIGH);


  int adcValue = analogRead(PINANALOG);
  if(ticked)
  {
    Serial.printf("He hecho tick!\n");
    Serial.printf("Potenciometro: %ld\n",adcValue);
    ticked = false;
  }
  if(btn_presionado)
  {
    Serial.printf("Botón presionado!\n");
    Serial.printf("Potenciometro: %ld\n",adcValue);
    btn_presionado = false;
  }

}