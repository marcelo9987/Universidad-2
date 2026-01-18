#include <BLEDevice.h>
#include <BLEUtils.h>
#include <BLEScan.h>
#include <BLEAdvertisedDevice.h>

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

    BLEDevice::init("YD_ESP32_EXAM");  //Bluetooth device name
    BLEServer *pServer = BLEDevice::createServer();

    

    BLEService *pService = pServer->createService("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");
    // Start the service
    pService->start();


    // Start advertising
    pServer->getAdvertising()->start();

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