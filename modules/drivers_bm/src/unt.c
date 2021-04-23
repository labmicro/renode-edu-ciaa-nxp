/* Copyright 2016, Laboratorio de Microprocesadores 
 * Facultad de Ciencias Exactas y Tecnología 
 * Universidad Nacional de Tucuman
 * http://www.microprocesadores.unt.edu.ar/
 * Copyright 2016, Esteban Volentini <evolentini@gmail.com>
 * Copyright 2016, Matias Giori <matias.giori@domotech.com.ar>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

/** @brief Controlador de dispositivos para el poncho educativo
 **
 ** Conjunto de rutinas para configurar y controlar el poncho educativo para EDU-CIAA_NXP
 **
 ** @addtogroup drivers Controladores
 ** @brief Controladores de dispositivos
 ** @{ */

/* === Inclusiones de cabeceras ================================================================ */
#if (lpc4337 == CPU)
#include "chip.h"
#elif (mk60fx512vlq15 == CPU)
#error Por el momento este programa solo puede ser compilado para la EDU-CIAA-NXP
#endif

#include "unt.h"
#include "display.h"


/* === Definicion y Macros ===================================================================== */

#define SCU_MODE_SAL (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS)
#define SCU_MODE_ENT (SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN)

#define SW_GPIO_PORT    5
#define SW1_GPIO_PIN    15
#define SW1_GPIO_MASK   (1UL << SW1_GPIO_PIN)
#define SW2_GPIO_PIN    14
#define SW2_GPIO_MASK   (1UL << SW2_GPIO_PIN)
#define SW3_GPIO_PIN    13
#define SW3_GPIO_MASK   (1UL << SW3_GPIO_PIN)
#define SW4_GPIO_PIN    12
#define SW4_GPIO_MASK   (1UL << SW4_GPIO_PIN)
#define FUN_GPIO_MASK   (SW1_GPIO_MASK | SW2_GPIO_MASK | SW3_GPIO_MASK | SW4_GPIO_MASK)

#define SW5_GPIO_PIN    8
#define SW5_GPIO_MASK   (1UL << SW5_GPIO_PIN)
#define SW6_GPIO_PIN    9
#define SW6_GPIO_MASK   (1UL << SW6_GPIO_PIN)
#define SW_GPIO_MASK    (FUN_GPIO_MASK | SW5_GPIO_MASK | SW6_GPIO_MASK)

#define CANTIDAD_DIGITOS 4

#define apagarSegmentos()              Chip_GPIO_ClearValue(LPC_GPIO_PORT, 2, 0x7F)
#define prenderSegmentos(mascara)      Chip_GPIO_SetValue(LPC_GPIO_PORT, 2, (mascara) & 0x7F)
#define apagarDigitos()                Chip_GPIO_ClearValue(LPC_GPIO_PORT, 0, 0x0F)
#define prenderDigito(digito)          Chip_GPIO_SetValue(LPC_GPIO_PORT, 0, (1 << (digito)) & 0x0F)
#define prenderPunto(valor)            Chip_GPIO_SetPinState(LPC_GPIO_PORT, 5, 16, valor)

/* === Declaraciones de tipos de datos internos ================================================ */

/* === Declaraciones de funciones internas ===================================================== */

void configurarPuertos(void);

void configurarInterrupcion(void);

/* === Definiciones de variables internas ====================================================== */
const uint8_t digitos[] = {
   0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67
};

uint8_t numero[4] = { 0, 0, 0, 0};

/* === Definiciones de variables externas ====================================================== */

/* === Definiciones de funciones internas ====================================================== */
void configurarDigitos() {
   apagarDigitos();
   apagarSegmentos();
   prenderPunto(false);

   /* Pines de los digitos */
   Chip_SCU_PinMux(0, 0, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(0, 1, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(1, 15, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(1, 17, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_GPIO_SetDir(LPC_GPIO_PORT, 0, 0x0F, 1);

   /* Pines de los segmentos */
   Chip_SCU_PinMux(4, 0, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(4, 1, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(4, 2, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(4, 3, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(4, 4, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(4, 5, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(4, 6, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_GPIO_SetDir(LPC_GPIO_PORT, 2, 0x7F, 1);

   /* Pin del punto */
   Chip_SCU_PinMux(6, 8, SCU_MODE_SAL, SCU_MODE_FUNC4);
   Chip_GPIO_SetDir(LPC_GPIO_PORT, 5, 0x10000, 1);
}

void configurarLcd(void) {
   lcdWriteEnable(0);

   /* Pines de datos  y control */
   Chip_SCU_PinMux(6, 4, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(6, 5, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(6, 9, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(6, 10, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(6, 11, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(6, 12, SCU_MODE_SAL, SCU_MODE_FUNC0);   
   Chip_GPIO_SetDir(LPC_GPIO_PORT, 2, 0x100, 1);
   Chip_GPIO_SetDir(LPC_GPIO_PORT, 3, 0xF8, 1);

   lcdInit();
}

void configurarLeds(void) {
   /* Puerto Led RGB */
   Chip_SCU_PinMux(2, 0, SCU_MODE_SAL, SCU_MODE_FUNC4);
   Chip_SCU_PinMux(2, 1, SCU_MODE_SAL, SCU_MODE_FUNC4);
   Chip_SCU_PinMux(2, 2, SCU_MODE_SAL, SCU_MODE_FUNC4);
   Chip_GPIO_ClearValue(LPC_GPIO_PORT, 5, (1 << 0) | (1 << 1) | (1 << 2));
   Chip_GPIO_SetDir(LPC_GPIO_PORT, 5, (1 << 0) | (1 << 1) | (1 << 2), 1);

   /* Puerto Leds 1 a 3 */
   Chip_SCU_PinMux(2, 10, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(2, 11, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_SCU_PinMux(2, 12, SCU_MODE_SAL, SCU_MODE_FUNC0);
   Chip_GPIO_ClearValue(LPC_GPIO_PORT, 0, (1 << 14));
   Chip_GPIO_ClearValue(LPC_GPIO_PORT, 1, (1 << 11) | (1 << 12));
   Chip_GPIO_SetDir(LPC_GPIO_PORT, 0, (1 << 14), true);
   Chip_GPIO_SetDir(LPC_GPIO_PORT, 1, (1 << 11) | (1 << 12), true);
}

void configurarTeclas(void) {

   /* Puerto Teclas 1 a 4 */
   Chip_SCU_PinMux(4, 8, SCU_MODE_ENT, SCU_MODE_FUNC4);
   Chip_SCU_PinMux(4, 9, SCU_MODE_ENT, SCU_MODE_FUNC4);
   Chip_SCU_PinMux(4, 10, SCU_MODE_ENT, SCU_MODE_FUNC4);
   Chip_SCU_PinMux(6, 7, SCU_MODE_ENT, SCU_MODE_FUNC4);

   /* Puerto Teclas Aceptar y Cancelar */
   Chip_SCU_PinMux(3, 1, SCU_MODE_ENT, SCU_MODE_FUNC4);
   Chip_SCU_PinMux(3, 2, SCU_MODE_ENT, SCU_MODE_FUNC4);

   Chip_GPIO_SetDir(LPC_GPIO_PORT, SW_GPIO_PORT, SW_GPIO_MASK, false);
}

void configurarRGB(void) {
   /* Puerto Leds RGB */
   Chip_SCU_PinMux(1, 3, SCU_MODE_SAL, SCU_MODE_FUNC1);
   Chip_SCU_PinMux(1, 4, SCU_MODE_SAL, SCU_MODE_FUNC1);
   Chip_SCU_PinMux(1, 5, SCU_MODE_SAL, SCU_MODE_FUNC1);

   Chip_SCTPWM_Init(LPC_SCT);
   Chip_SCTPWM_SetRate(LPC_SCT, 10000);
   Chip_SCTPWM_SetOutPin(LPC_SCT, 1, 8);
   Chip_SCTPWM_SetOutPin(LPC_SCT, 2, 9);
   Chip_SCTPWM_SetOutPin(LPC_SCT, 3, 10);
   Chip_SCTPWM_Start(LPC_SCT);
}

void configurarPuertos(void) {

   //Chip_GPIO_SetValue(LPC_GPIO_PORT, 2, 0x7F); //prende todos los led
   //Chip_GPIO_SetDir(LPC_GPIO_PORT, 2, 0x7F, 1);

   Chip_GPIO_SetValue(LPC_GPIO_PORT, 0, 0x1);
   Chip_GPIO_ClearValue(LPC_GPIO_PORT, 0, 0xF);
   Chip_GPIO_SetValue(LPC_GPIO_PORT, 0, 0x2);
   Chip_GPIO_ClearValue(LPC_GPIO_PORT, 0, 0xF);
   Chip_GPIO_SetValue(LPC_GPIO_PORT, 0, 0x4);
   Chip_GPIO_ClearValue(LPC_GPIO_PORT, 0, 0xF);
   Chip_GPIO_SetValue(LPC_GPIO_PORT, 0, 0x8);
   Chip_GPIO_ClearValue(LPC_GPIO_PORT, 0, 0xF);

   /* todos los LED del display a 1 */
   /* multiplex a 0 */
   /* Chip_GPIO_SetDir(LPC_GPIO_PORT, port, mask, output); */
   //Chip_GPIO_SetDir(LPC_GPIO_PORT, 5, (1 << 0) | (1 << 1) | (1 << 2), 1);

}

void configurarInterrupcion(void) {
   __asm volatile ("cpsid i");

   /* Activate SysTick */
   SystemCoreClockUpdate();
   SysTick_Config(SystemCoreClock/10000);

   /* Update priority set by SysTick_Config */
   NVIC_SetPriority(SysTick_IRQn, (1<<__NVIC_PRIO_BITS) - 1);

   __asm volatile ("cpsie i");
}

void refrescarDigitos(void) {
   static int activo = 0;

   activo = ((activo + 1) & 0x03);
   Escribir_Digito(numero[activo], activo);
 }

int escanearTeclado(void) {
   int pulsadas;
   int actuales;
   static int anteriores = 0;

   actuales = Chip_GPIO_ReadValue(LPC_GPIO_PORT, 5);
   pulsadas = ((actuales ^ anteriores) & actuales);
   anteriores = actuales;

   return pulsadas;
}

/* === Definiciones de funciones externas ====================================================== */
void funcionPeriodica(void) {
   static int divisor = 0;

   divisor = (divisor + 1) % 10;
   if (divisor == 0) {
      refrescarDigitos();
   }
}

void Init_PonchoUNT(void) {
   configurarLeds();
   configurarTeclas();
   configurarDigitos();
   configurarLcd();   
   configurarRGB();
   Led_RGB(0, 0, 0);
}

void Escribir_Segmentos(uint8_t segmentos, uint8_t posicion) {
   if (posicion < CANTIDAD_DIGITOS) {
      apagarDigitos();
      apagarSegmentos();
      prenderSegmentos(segmentos);
      prenderDigito(CANTIDAD_DIGITOS - 1 - posicion);
   }
}

void Escribir_Digito(uint8_t valor, uint8_t posicion) {
   if (posicion < CANTIDAD_DIGITOS) {
      apagarDigitos();
      apagarSegmentos();
      prenderSegmentos(digitos[valor & 0x0F]);
      prenderDigito(CANTIDAD_DIGITOS - 1 - posicion);
   }
}

void Led_RGB(uint8_t r, uint8_t g, uint8_t b) {
   if ((r <= 100) & (g <= 100) & (b <= 100)) {
      Chip_SCTPWM_SetDutyCycle(LPC_SCT, 1, Chip_SCTPWM_PercentageToTicks(LPC_SCT, 100 - r));
      Chip_SCTPWM_SetDutyCycle(LPC_SCT, 2, Chip_SCTPWM_PercentageToTicks(LPC_SCT, 100 - g));
      Chip_SCTPWM_SetDutyCycle(LPC_SCT, 3, Chip_SCTPWM_PercentageToTicks(LPC_SCT, 100 - b));
   }
}

uint8_t Teclas_Pulsadas(void) {
   uint8_t resultado = 0;
   uint32_t puerto = Chip_GPIO_GetPortValue(LPC_GPIO_PORT,SW_GPIO_PORT);

   if (puerto & SW1_GPIO_MASK)
      resultado |= (1 << 0);
   if (puerto & SW2_GPIO_MASK)
      resultado |= TECLA_F2;
   if (puerto & SW3_GPIO_MASK)
      resultado |= TECLA_F3;
   if (puerto & SW4_GPIO_MASK)
      resultado |= TECLA_F4;
   if (puerto & SW5_GPIO_MASK)
      resultado |= TECLA_SI;
   if (puerto & SW6_GPIO_MASK)
      resultado |= TECLA_NO;

   return resultado;
}

uint8_t Leer_Teclas(void) {
   uint8_t switchPressed = NO_KEY;

   if (Chip_GPIO_ReadPortBit(LPC_GPIO_PORT,SW_GPIO_PORT,SW1_GPIO_PIN))
      switchPressed = TECLA_F1;

   if (Chip_GPIO_ReadPortBit(LPC_GPIO_PORT,SW_GPIO_PORT,SW2_GPIO_PIN))
      switchPressed = TECLA_F2;

   if (Chip_GPIO_ReadPortBit(LPC_GPIO_PORT,SW_GPIO_PORT,SW3_GPIO_PIN))
      switchPressed = TECLA_F3;

   if (Chip_GPIO_ReadPortBit(LPC_GPIO_PORT,SW_GPIO_PORT,SW4_GPIO_PIN))
      switchPressed = TECLA_F4;

   if (Chip_GPIO_ReadPortBit(LPC_GPIO_PORT,SW_GPIO_PORT,SW5_GPIO_PIN))
      switchPressed = TECLA_SI;

   if (Chip_GPIO_ReadPortBit(LPC_GPIO_PORT,SW_GPIO_PORT,SW6_GPIO_PIN))
      switchPressed = TECLA_NO;

   return switchPressed;
}

void Test_PonchoUNT(void) {
   static uint8_t anterior = 0;
   uint8_t actual;

   // configurarInterrupcion();

   lcdWriteString("  LABORATORIO DE  ");
   lcdAtPos(1,0);
   lcdWriteString(" MICROPROCESADORES");

   while (1) {
      actual = Leer_Teclas();
      if (actual != anterior) {
         switch(actual) {
            case TECLA_F1:
               numero[0] = (numero[0] + 1) % 10;
               break;
            case TECLA_F2:
               numero[1] = (numero[1] + 1) % 10;
               break;
            case TECLA_F3:
               numero[2] = (numero[2] + 1) % 10;
               break;
            case TECLA_F4:
               numero[3] = (numero[3] + 1) % 10;
               break;
            case TECLA_SI:
               numero[0] = 9;
               numero[1] = 9;
               numero[2] = 9;
               numero[3] = 9;
               break;
            case TECLA_NO:
               numero[0] = 0;
               numero[1] = 0;
               numero[2] = 0;
               numero[3] = 0;
               break;
         }
         Led_RGB(10 * numero[0], 10 * numero[1], 10 *  numero[2]);
         anterior = actual;
      }
   }
}
/* === Ciere de documentacion ================================================================== */

/** @} Final de la definición del modulo para doxygen */