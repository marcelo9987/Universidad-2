/*
Creado por Javier Burgoa el 22/11/24 para simular un deadlock

*/


#include <stdio.h>
#include <string.h>
#include <math.h>
#include "freertos/FreeRTOS.h"
#include "freertos/projdefs.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "freertos/semphr.h"
#include "driver/gpio.h"
#include "driver/ledc.h"
#include "esp_timer.h"

//PERIODOS TAREAS en ms
#define TASK_A_T 200
#define TASK_B_T 200

//CONTADORES
#define ITER_A 400000
#define ITER_B 400000

#define STACK_SIZE	3*1024	     //N x 1kByte es el tamaÃ±o de la piLa  

#define VERBOSE 1

SemaphoreHandle_t xMutex1;
SemaphoreHandle_t xMutex2;

//-----------------------------------------------------------------------------------------
void TareaA( void * pvParameters )
{
    //InicializaciÃ³nes dentro de la tarea
    //...
    //...

    //Tarea    
    while(1)
    {
       if(xSemaphoreTake(xMutex1, portMAX_DELAY) == pdFALSE)
       {
            continue;
       }
       printf("La tarea A ha cogido el mutex 1 # %llu ms\n",esp_timer_get_time()/1000);        
       vTaskDelay(1/portTICK_PERIOD_MS);
            
       if(xSemaphoreTake(xMutex2, portMAX_DELAY) == pdFALSE)
       {
            xSemaphoreGive(xMutex1); //Libera el mutex 1 para evitar el deadlock
            continue;
       }
       printf("La tarea A ha cogido el mutex 2 # %llu ms\n",esp_timer_get_time()/1000);           
            
       //Consume CPU cycles
       for (long i = 0; i < ITER_A; i++) {   __asm__ __volatile__("NOP");     }

       printf("La tarea A Libera Mutex 2 y Mutex 1 #  %llu ms\n",esp_timer_get_time()/1000);           
       xSemaphoreGive(xMutex1);
       xSemaphoreGive(xMutex2);

       //Bloquea la tarea
       vTaskDelay(TASK_A_T / portTICK_PERIOD_MS);
    }	
}

//-----------------------------------------------------------------------------------------
void TareaB( void * pvParameters )
{
    //InicializaciÃ³nes dentro de la tarea
    //...
    //...

    //Tarea
    while(1)
    {
       if(xSemaphoreTake(xMutex2, portMAX_DELAY) == pdFALSE)
       {
            continue;
       }
       printf("La tarea B ha cogido el mutex 2 # %llu ms\n",esp_timer_get_time()/1000);      
       vTaskDelay(1/portTICK_PERIOD_MS);
            
       if(xSemaphoreTake(xMutex1, portMAX_DELAY) == pdFALSE)
       {
         xSemaphoreGive(xMutex2); //Libera el mutex 2 para evitar el deadlock
         continue;
       }
       printf("La tarea B ha cogido el mutex 1 # %llu ms\n",esp_timer_get_time()/1000);          
            
       //Consume CPU cycles
       for (long i = 0; i < ITER_B; i++) {   __asm__ __volatile__("NOP");     }

       printf("La tarea B Libera Mutex 1 y Mutex 2 # %llu ms\n",esp_timer_get_time()/1000);           
       xSemaphoreGive(xMutex1);
       xSemaphoreGive(xMutex2);

       //Bloquea la tarea
       vTaskDelay(TASK_B_T / portTICK_PERIOD_MS);
    }	
}
//-----------------------------------------------------------------------------------------


void app_main(void) 
{   
    xMutex1 = xSemaphoreCreateMutex();                                  //mutex
    xMutex2 = xSemaphoreCreateMutex();                                  //mutex
 
    TaskHandle_t xHandle1 = NULL;                                       //Handler a la tarea A
    TaskHandle_t xHandle2 = NULL;                                       //Handler a la tarea B
    
    printf("\n\n\n"); 

    xTaskCreate( TareaA, "TAREA_A", STACK_SIZE, NULL, 1, &xHandle1 );   //Crea la tarea
    xTaskCreate( TareaB, "TAREA_B", STACK_SIZE, NULL, 2, &xHandle2 );   //Crea la tarea 2 con mayor prioridad

    while (1) 
    {
    }
}
