/* Copyright 2016, Laboratorio de Microprocesadores
 * Facultad de Ciencias Exactas y Tecnología
 * Universidad Nacional de Tucuman
 * http://www.microprocesadores.unt.edu.ar/
 * Copyright 2016-2021, Esteban Volentini <evolentini@gmail.com>
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

/** @brief Definiciones para la implementación del ejemplo de un led parpadeando
 **
 **| REV | YYYY.MM.DD | Autor           | Descripción de los cambios                              |
 **|-----|------------|-----------------|---------------------------------------------------------|
 **|   1 | 2021.04.23 | evolentini      | Version inicial de la plantilla de codigo               |
 **
 ** @addtogroup ejemplos
 ** @brief Archivos con programas de ejemplo
 ** @{ */

/* === Inclusiones de cabeceras ================================================================ */

#include "chip.h"

/* === Definicion y Macros ===================================================================== */

/**
 * @brief Declara el puerto del procesador utilizado por el led a parpadear
 */
#define LED_PORT    2

/**
 * @brief Declara el terminal del puerto del procesador utilizado por el led a parpadear
 */
#define LED_PIN     12

/**
 * @brief Declara el puerto de entrada/salida digital utilizado por el led a parpadear
 */
#define LED_GPIO    1

/**
 * @brief Declara el bit del puerto de entrada/salida digital utilizado por el led a parpadear
 */
#define LED_BIT     12

/**
 * @brief Declara una mascara para afectar solo al bit que controla al led
 */
#define LED_MASK    (1 << LED_BIT)

/**
 * @brief Declara los bits a configurar en un puerto de salida del procesador
 */
#define SCU_MODE_SAL (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS)

/* === Declaraciones de tipos de datos internos ================================================ */

/* === Declaraciones de funciones internas ===================================================== */

/**
 * @brief Función para configurar una interrupción periodica con el SysTick
 * 
 * Esta función configura el SysTick del procesador Cortex-M4 para producir una interrupción
 * que llama a la funcion SysTick_Handle cada 100ms.
 */
void ConfigurarInterrupcion(void);

/**
 * @brief Función para configurar los puertos de entrada/salida digitales
 * 
 */
void ConfigurarPuertos(void);

/* === Definiciones de variables internas ====================================================== */

/* === Definiciones de variables externas ====================================================== */

/* === Definiciones de funciones internas ====================================================== */

void ConfigurarInterrupcion(void) {
    __asm__ volatile("cpsid i");

    /* Activate SysTick */
    SystemCoreClockUpdate();
    SysTick_Config(SystemCoreClock / 1000);

    /* Update priority set by SysTick_Config */
    NVIC_SetPriority(SysTick_IRQn, (1 << __NVIC_PRIO_BITS) - 1);

    __asm__ volatile("cpsie i");
}

void ParpadearLed(void) {
    Chip_GPIO_SetPinToggle(LPC_GPIO_PORT, LED_GPIO, LED_BIT);
}

void ConfigurarPuertos(void) {
    Chip_GPIO_ClearValue(LPC_GPIO_PORT, LED_GPIO, LED_MASK);
    Chip_SCU_PinMux(LED_PORT, LED_PORT, SCU_MODE_SAL, SCU_MODE_FUNC0);
    Chip_GPIO_SetDir(LPC_GPIO_PORT, LED_GPIO, LED_MASK, 1);
}
/* === Definiciones de funciones externas ====================================================== */
/**
 * @brief Funcion periodica que se ejecuta con el SysTick
 */
void SysTick_Handler(void) {
    static int contador = 0;

    contador++;
    if (contador > 500) {
        contador = 0;
        ParpadearLed();
    }
    // SegmentosRefrescar(pantalla);
}

int main(void) {
    ConfigurarPuertos();
    ConfigurarInterrupcion();
    
    while (1) {
        __asm("nop");
    }
    
    return 0;
}
/* === Ciere de documentacion ================================================================== */

/** @} Final de la definición del modulo para doxygen */
