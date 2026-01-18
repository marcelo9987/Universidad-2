
#include <math.h>
#define PIN_LED 15
#define numFases 20

void setup() {
  ledcAttach(PIN_LED, 100, 12);

}

float fase[] ={00,0.1,0.2,0.3,0.4,0.5,0.6,.7,0.8,0.9,1.0,.9,.8,.7,.6,.5,.4,.3,.2,.1} ;
int n = 0;
void loop() {
  delay(60);
  ledcWrite(PIN_LED,(4095 * fase[n]));
  n++;
  n%=numFases;

}
