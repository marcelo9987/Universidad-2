#define PIN_BOTON 0
#define PIN_LED 2

volatile bool botonPresionado = false;
volatile unsigned long tiempoISR = -1;

void IRAM_ATTR handleButtonISR()
{
  botonPresionado = true;
  tiempoISR = millis();
}


void setup() 
{
  Serial.begin(9600);
  pinMode(PIN_LED, OUTPUT);
  pinMode(PIN_BOTON, INPUT_PULLUP);
  attachInterrupt(PIN_BOTON,handleButtonISR, FALLING);
}

void loop() {

  unsigned long tiempoLoop = millis();
  if(botonPresionado)
  {
    Serial.println("Ola");
    digitalWrite(PIN_LED,HIGH);
    botonPresionado = false;
  }

  if(!botonPresionado && tiempoLoop>= tiempoISR+2000)
  {
    digitalWrite(PIN_LED,LOW);
    tiempoLoop = tiempoISR;
  }

}
