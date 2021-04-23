/* Copyright 2014, 2015 Mariano Cerdeiro
 * Copyright 2014, Pablo Ridolfi
 * Copyright 2014, Juan Cecconi
 * Copyright 2014, Gustavo Muro
 * All rights reserved.
 *
 * This file is part of CIAA Firmware.
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
 *
 */

/** \brief Bare Metal example source file
 **
 ** This is a mini example of the CIAA Firmware.
 **
 **/

/** \addtogroup CIAA_Firmware CIAA Firmware
 ** @{ */
/** \addtogroup Examples CIAA Firmware Examples
 ** @{ */
/** \addtogroup Baremetal Bare Metal example source file
 ** @{ */

/*
 * Initials     Name
 * ---------------------------
 *
 */

/*
 * modification history (new versions first)
 * -----------------------------------------------------------
 * yyyymmdd v0.0.1 initials initial version
 */

/*==================[inclusions]=============================================*/
#include "chip.h"
#include "segmentos.h"

/*==================[macros and definitions]=================================*/
#define SCU_MODE_SAL (SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS)

/*==================[internal data declaration]==============================*/

segmentos_t pantalla;

/*==================[internal functions declaration]=========================*/
void ConfigurarPuertos(void);

void ConfigurarInterrupcion(void);

void ApagarSegmentos(void);

void PrenderSegmentos(uint8_t segmentos);

void ApagarDigitos(void);

void PrenderDigito(uint8_t digito);

/*==================[internal data definition]===============================*/

const struct segmentos_controlador_s CONTROLADOR_PANTALLA = {
    .ApagarSegmentos = ApagarSegmentos,
    .PrenderSegmentos = PrenderSegmentos,
    .ApagarDigitos = ApagarDigitos,
    .PrenderDigito = PrenderDigito,
};

/*==================[external data definition]===============================*/

/*==================[internal functions definition]==========================*/
void ConfigurarInterrupcion(void) {
    __asm__ volatile("cpsid i");

    /* Activate SysTick */
    SystemCoreClockUpdate();
    SysTick_Config(SystemCoreClock / 1000);

    /* Update priority set by SysTick_Config */
    NVIC_SetPriority(SysTick_IRQn, (1 << __NVIC_PRIO_BITS) - 1);

    __asm__ volatile("cpsie i");
}

void ConfigurarPuertos(void) {
   ApagarDigitos();
   ApagarSegmentos();

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
}

void ApagarSegmentos(void) {
    Chip_GPIO_ClearValue(LPC_GPIO_PORT, 2, 0x7F);
}

void PrenderSegmentos(uint8_t segmentos) {
    Chip_GPIO_SetValue(LPC_GPIO_PORT, 2, (segmentos)&0x7F);
}

void ApagarDigitos(void) {
    Chip_GPIO_ClearValue(LPC_GPIO_PORT, 0, 0x0F);
}

void PrenderDigito(uint8_t digito) {
    Chip_GPIO_SetValue(LPC_GPIO_PORT, 0, (1 << (digito)) & 0x0F);
}

/*==================[external functions definition]==========================*/
/**
 * @brief Funcion periodica que se ejecuta con el SysTick
 */
void SysTick_Handler(void) {
    static int contador = 0;

    contador++;
    if (contador > 1000) {
        contador = 0;
        Chip_GPIO_SetPinToggle(LPC_GPIO_PORT, 0, 14);
    }
    // SegmentosRefrescar(pantalla);
}

int main(void) {
    uint8_t cuenta[4] = {1, 2, 3, 4};

    ConfigurarPuertos();
    ConfigurarInterrupcion();

    pantalla = SegmentosCrear(3, &CONTROLADOR_PANTALLA);
    SegmentosBCD(pantalla, cuenta);
    
    while (1) {
        __asm("nop");
    }
    
    return 0;
}

/** @} doxygen end group definition */
/** @} doxygen end group definition */
/** @} doxygen end group definition */
/*==================[end of file]============================================*/
