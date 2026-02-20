#define  PINBUZZER  4
#define  PINBOTON   13

// --- Definición de Frecuencias (Notas necesarias para Chopin) ---
#define Fa4 466
#define Do5  523
#define Re5  587
#define ReS5 622
#define Mi5  659
#define Fa5  698
#define Sol5  784
#define SolS5 831
#define La5  880
#define La5S 932
#define NOTE_B5  988
#define NOTE_C6  1047
#define NOTE_D6  1175
#define NOTE_Eb6 1245

// --- A Melodía (Frecuencias) ---
// O 0 representa un silencio
const int melodia2[] = 
{
    Fa4, Sol5, Fa5, Sol5, Fa5, ReS5, Fa4, Sol5, Do5, 554, Do5, 494, Do5, 1047, Sol5,
    La5S, SolS5, Sol5, Fa5, Sol5, Re5, ReS5, Do5, Fa4, 1175, 1047, La5S, SolS5, Sol5, SolS5,
    Do5, Re5, ReS5, Fa4, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Mi5, Fa5, Sol5, Fa5, ReS5,
    Fa5, ReS5, Fa5, ReS5, Re5, ReS5, Fa5, Sol5, 494, Do5, 554, Do5, Fa5, Mi5, SolS5,
    Sol5, 1109, 1047, Sol5, La5S, SolS5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5,
    Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Mi5, Fa5, Sol5, Sol5, Re5, ReS5,
    Do5, Fa4, 1175, 1047, La5S, SolS5, Sol5, SolS5, SolS5, Do5, Re5, ReS5, Re5, ReS5,
    Fa5, Sol5, Fa5, Fa5, Do5, ReS5, ReS5, ReS5, ReS5, Re5, ReS5, Fa5, ReS5, ReS5,Fa4,
    La5S, La5, Sol5, Fa5, Re5, ReS5, Re5, Do5, Re5, Fa4, 494, 494, Do5, Do5,
    Re5, ReS5, Sol5, Fa4, 494, 554, Re5, Sol5, Fa5, Fa5, ReS5, Fa5, ReS5, Fa5, ReS5,
    Re5, ReS5, Fa5, Sol5, 494, Do5, 554, Do5, Fa5, Mi5, SolS5, Sol5, 1109, Fa4, 1047,
    Sol5, La5S, SolS5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5,
    Sol5, Fa5, Sol5, Fa5, Mi5, Fa5, Sol5, Sol5, Re5, ReS5, Do5, Fa4, 1175, 1109, 1047, 988,
    La5S, La5, SolS5, Fa5, Re5, 494, Fa4, Re5, Sol5, Fa5, ReS5, ReS5, Re5, ReS5, 392, Fa5, Sol5,
    Fa5, Fa5, Do5, ReS5, ReS5, ReS5, ReS5, ReS5, Re5, ReS5, Fa5, ReS5, ReS5, Fa4, La5S, La5,
    Sol5, Fa5, Re5, ReS5, Re5, Do5, Re5, Fa4, 494, 494, Do5, Do5, Re5, ReS5, Sol5, 440, Fa4,
    494, 554, Re5, Sol5, Fa5, Fa5, ReS5, Fa5, ReS5, Fa5, ReS5, Re5, ReS5, Fa5, Sol5, 494, Do5,
    554, Do5, Fa5, Mi5, SolS5, Sol5, 1109, 1047, Sol5, La5S, SolS5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5,
    Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Sol5, Fa5, Mi5, Fa5, Sol5, Sol5, Re5, ReS5, Do5,
    Fa4, 1175, 1109, 1047, 988, La5S, La5, SolS5, Sol5, Fa5, ReS5, ReS5, ReS5, 415, Fa5, ReS5, Fa5,
    415, Sol5, ReS5, Fa5, ReS5, Fa5, ReS5, Fa5, Sol5, ReS5, Fa5, ReS5, Re5, ReS5, 1245, 1175, 1047,
    La5S, La5, SolS5, Do5, Re5, ReS5, ReS5, ReS5, Re5, ReS5, ReS5, 1568, 1397, 1245, 1175, 1047, 988, La5S,
    La5, La5, SolS5, SolS5, Sol5, Sol5, Fa5, ReS5, ReS5, 415, Fa5, ReS5, Fa5, ReS5, Fa5, ReS5, Fa5, Sol5, ReS5,
    415, Fa4, 415, Fa4, 415, 415, 494, ReS5, SolS5, 1245, 1397, 1568, 2489, 2349, 2093, 1976, 1865, 1760, 1661,
    1568, 2489, 2093, 1976, 1865, 1976, 1865, 2093, 1760, 1976, 1865, 2093, 1760, 1976, 1865, 2093, 1760, 1976,
    1865, 2093, 1760, 1976, 1865, 2093, 1760, 1976, 1865, 2093, 1760, 1976, 1865, 2093, 1760, 1976, 1865, 2093,
    1760, 1976, 1865, 2093, 1760, 1976, 1865, 2093, 1760, 1976, 1865, 2093, 1760, 1976, 1865, 2349, 2093, 1865,
    1760, 1661, 1568, 1397, 1175, 1245, 1047, La5S, SolS5, Do5, Re5, ReS5, Fa4, Sol5, ReS5, Fa4, Sol5, ReS5, Fa4,
    Sol5, ReS5, Fa4, Sol5, ReS5, Fa4, 311
};
const int melodia[]={
  523, 523, 523, 523, 494, 440, 415, 440, 494, 440, 440, 392, 349, 330, 440, 494, 523, 494, 440, 523, 523, 523, 523, 494, 440, 415, 440, 494, 440, 440, 392, 349, 330, 440, 494, 523, 494, 440, 440, 415, 440, 494, 494, 494, 494, 440, 494, 523, 523, 523, 494, 523, 587, 392, 784, 698, 659, 659, 587, 659, 698, 494, 494, 523, 587, 659, 440, 523, 494, 440, 659, 587, 523, 494, 440, 440, 415, 440, 494, 494, 494, 494, 440, 494, 523, 523, 523, 494, 523, 587, 392, 784, 698, 659, 659, 587, 659, 698, 494, 494, 523, 587, 659, 440, 523, 494, 440, 659, 587, 523, 494, 440, 440, 415, 440, 659, 587, 523, 494, 440, 440, 415, 440, 523, 523, 523, 523, 494, 440, 415, 440, 494, 440, 440, 392, 349, 330, 440, 494, 523, 494, 440, 523, 523, 523, 523, 494, 440, 415, 440, 494, 440, 440, 392, 349, 330, 440, 494, 523, 494, 440, 440, 415, 440, 494, 494, 494, 494, 440, 494, 523, 523, 523, 494, 523, 587, 392, 784, 698, 659, 659, 587, 659, 698, 494, 494, 523, 587, 659, 440, 523, 494, 440, 440, 440, 415, 440, 494, 494, 494, 494, 440, 494, 523, 523, 523, 494, 523, 587, 392, 784, 698, 659, 659, 587, 659, 698, 494, 494, 523, 587, 659, 440, 523, 494, 440, 440, 440, 415, 440, 659, 587, 523, 494, 440, 440, 415, 440, 659, 587, 523, 494, 440, 440, 415, 440
};
const int duracions[]
{

384, 288, 96, 384, 192, 192, 384, 192, 192, 768, 384, 192, 192, 384, 192, 192, 384, 384, 768, 384, 288, 96, 384, 192, 192, 384, 192, 192, 768, 384, 192, 192, 384, 192, 192, 384, 384, 192, 192, 192, 192, 288, 96, 576, 192, 192, 192, 384, 576, 192, 192, 192, 384, 384, 384, 384, 960, 192, 192, 192, 384, 576, 192, 192, 192, 384, 576, 192, 192, 192, 384, 384, 384, 384, 960, 192, 192, 192, 288, 96, 576, 192, 192, 192, 384, 576, 192, 192, 192, 384, 384, 384, 384, 960, 192, 192, 192, 384, 576, 192, 192, 192, 384, 576, 192, 192, 192, 384, 384, 384, 384, 960, 192, 192, 192, 384, 384, 384, 384, 960, 192, 192, 192, 384, 288, 96, 384, 192, 192, 384, 192, 192, 768, 384, 192, 192, 384, 192, 192, 384, 384, 768, 384, 288, 96, 384, 192, 192, 384, 192, 192, 768, 384, 192, 192, 384, 192, 192, 384, 384, 192, 192, 192, 192, 288, 96, 576, 192, 192, 192, 384, 576, 192, 192, 192, 384, 384, 384, 384, 960, 192, 192, 192, 384, 576, 192, 192, 192, 384, 576, 192, 192, 192, 960, 192, 192, 192, 288, 96, 576, 192, 192, 192, 384, 576, 192, 192, 192, 384, 384, 384, 384, 960, 192, 192, 192, 384, 576, 192, 192, 192, 384, 576, 192, 192, 192, 960, 192, 192, 192, 384, 384, 384, 384, 960, 192, 192, 192, 384, 384, 384, 384, 960, 192, 192

};
const int duracions2[] =  
{
592, 1842, 366, 454, 1270, 852, 422, 730, 118, 74, 94, 80, 168, 736, 414, 1238, 882, 412, 1118, 810, 398, 1204, 1338, 544, 522, 408, 320, 228, 198, 190, 222, 274, 2176, 508, 1222, 236, 116, 52, 36, 186, 194, 204, 250, 486, 1014, 122, 56, 40, 184, 176, 182, 220, 214, 202, 176, 190, 172, 196, 182, 208, 218, 262, 228, 318, 1310, 984, 514, 212, 100, 78, 58, 56, 74, 62, 54, 62, 70, 54, 64, 46, 72, 90, 106, 194, 418, 430, 444, 1280, 1360, 572, 474, 426, 334, 236, 218, 126, 118, 266, 346, 1788, 408, 400, 1156, 776, 388, 1244, 1438, 434, 370, 456, 546, 264, 280, 476, 152, 1276, 1312, 1152, 760, 362, 1084, 1224, 1170, 344, 358, 416, 468, 420, 356, 370, 434, 478, 156, 1048, 178, 330, 204, 316, Fa4, 132, 890, 660, 96, 64, 46, 194, 170, 180, 192, 182, 212, 196, 188, 166, 194, 184, 204, 200, 196, 64, 228, 314, 1352, 1050, 498, 214, 80, 68, 50, 58, 72, 64, 68, 52, 76, 44, 52, 60, 64, 92, 92, 152, 426, 458, 404, 1328, 1454, 538, 460, 428, 242, 178, 150, 116, 100, 94, 98, 108, 128, 132, 170, 162, 162, 1862, 408, 18, 488, 1264, 816, 374, 1274, 1474, 398, 306, 334, 366, 554, 214, 282, 488, 138, 1246, 1272, 1120, 712, 412, 1138, 1240, 1132, 436, 386, 344, 352, 362, 376, 390, 434, 502, 184, 838, 232, 198, 334, 182, 318, 390, 136, 886, 576, 62, 66, 46, 192, 160, 182, 196, 214, 202, 190, 186, 178, 188, 196, 234, 208, 228, 258, 418, 1310, 994, 574, 210, 54, 72, 66, 60, 60, 74, 56, 64, 88, 30, 70, 48, 50, 98, 88, 174, 420, 436, 418, 1276, 1548, 370, 668, 260, 226, 250, 368, 282, 930, 206, 176, 218, 2878, 1018, 388, 438, 430, 24, 510, 2752, 1636, 308, 224, 198, 248, 316, 890, 132, 68, 100, 68, 132, 456, 410, 398, 924, 404, 368, 396, 370, 672, 94, 148, 200, 98, 342, 602, 288, 206, 208, 216, 490, 460, 406, 356, 232, 254, 330, 644, 262, 2860, 1388, 294, 216, 180, 130, 194, 144, 170, 246, 2612, 546, 228, 94, 62, 48, 350, 180, 144, 152, 200, 342, 174, 832, 696, 336, 308, 336, 278, 270, 276, 1004, 1448, 546, 2558, 1506, 200, 146, 118, 118, 110, 98, 68, 84, 68, 64, 48, 64, 56, 58, 56, 56, 68, 56, 46, 48, 56, 60, 32, 58, 54, 50, 50, 48, 56, 52, 40, 56, 56, 56, 40, 56, 62, 58, 64, 54, 76, 82, 68, 102, 76, 154, 178, 164, 146, 154, 164, 186, 204, 210, 214, 248, 264, 342, 472, 534, 676, 452, 372, 368, 392, 364, 356, 378, 358, 398, 466, 524, 1634, 2050
};


typedef enum  {
  DETENIDO
  , INICIAR_NOTA
  , TOCANDO_NOTA
  , PAUSA_ENTRE_NOTAS
  }EstadoMelodia;


volatile EstadoMelodia estado = DETENIDO;
int notaActual = 0;
unsigned long tempoAnterior = 0; 
unsigned long duracionActual = 0; 

int numNotas = sizeof(melodia) / sizeof(melodia[0]);


void IRAM_ATTR btnPulsadoISR()
{
  if(estado==DETENIDO)
  {
    estado=INICIAR_NOTA;
    return;
  }
  estado = DETENIDO;
}

void setup() {
  Serial.begin(115200);

  attachInterrupt(PINBOTON,btnPulsadoISR, FALLING);
  pinMode(PINBOTON,INPUT_PULLUP);

  // Configuramos o canal PWM
  ledcAttach(PINBUZZER, 5000, 12);


}

void loop() {
  xestionarMusica();
}

void xestionarMusica() {
  unsigned long tempoActual = millis();

  // Comprobamos se xa pasou o tempo necesario para a acción actual
  if (tempoActual - tempoAnterior >= duracionActual) {
    
    // Gardamos o tempo actual para a seguinte conta
    tempoAnterior = tempoActual;

    // Máquina de estados: Que facemos agora?
    switch (estado) {
      
      case TOCANDO_NOTA:
        // A nota rematou. Apagamos o son e imos á pausa técnica (staccato)
        ledcWriteTone(PINBUZZER, 0);
        duracionActual = 50; // A pausa técnica de 50ms
        estado = PAUSA_ENTRE_NOTAS;
        break;

      case PAUSA_ENTRE_NOTAS:
        // A pausa técnica rematou. Tocamos a seguinte nota?
        notaActual++;
        
        if (notaActual < numNotas) {
          // Si, quedan notas. Iniciamos a seguinte.
          iniciarNota(notaActual); 
        } else {
          // Non, rematou a canción. Imos á espera longa.
          Serial.println("Fin da melodía. Agardando 3s...");
          duracionActual = 3000;
          estado = DETENIDO;
        }
        break;

      case DETENIDO:
        // Pasaron os 3 segundos. Reiniciamos a canción.
        ledcWriteTone(PINBUZZER, 0);
        Serial.println("Esperando...");
        break;

      case INICIAR_NOTA:
        notaActual=0;
        iniciarNota(notaActual);
        break;

    }
  }
}

// Función auxiliar para non repetir código
void iniciarNota(int indice) {
  int nota = melodia[indice];
  duracionActual = duracions[indice]; // Establecemos canto debe durar este estado
  
  if (nota == 0) {
    ledcWriteTone(PINBUZZER, 0);
  } else {
    ledcWriteTone(PINBUZZER, nota);
  }
  
  estado = TOCANDO_NOTA; // Marcamos que estamos no estado de tocar
}