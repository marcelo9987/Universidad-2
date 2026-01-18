#define PIN_LED 16

void setup() {
  pinMode(PIN_LED, OUTPUT);

}

int tiempoViejo = millis();
bool estado = 0; 

void loop() 
{

  if(millis() >= 500+tiempoViejo)
  {
    digitalWrite(PIN_LED,estado?HIGH:LOW);
    estado = !estado;
    tiempoViejo = millis();
  }
  
  

}
