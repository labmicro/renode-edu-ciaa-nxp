/* Copyright 2016-2020, Laboratorio de Microprocesadores 
 * Facultad de Ciencias Exactas y Tecnología 
 * Universidad Nacional de Tucuman
 * http://www.microprocesadores.unt.edu.ar/
 * Copyright 2016-2020, Esteban Volentini <evolentini@herrera.unt.edu.ar>
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
    .cpu cortex-m4          // Indica el procesador de destino  
    .syntax unified         // Habilita las instrucciones Thumb-2
    .thumb                  // Usar instrucciones Thumb y no ARM

    .include "configuraciones/lpc4337.s"
    .include "configuraciones/ciaa.s"

/****************************************************************************/
/* Vector de interrupciones
/****************************************************************************/
    .section .isr_vector
    .word   stack           //  0: Initial stack pointer value
    .word   reset+1         //  1: Initial program counter value: Program entry point
    .word   handler+1       //  2: Non mascarable interrupt service routine
    .word   handler+1       //  3: Hard fault system trap service routine
    .word   handler+1       //  4: Memory manager system trap service routine
    .word   handler+1       //  5: Bus fault system trap service routine
    .word   handler+1       //  6: Usage fault system tram service routine
    .word   0               //  7: Reserved entry
    .word   0               //  8: Reserved entry
    .word   0               //  9: Reserved entry
    .word   0               // 10: Reserved entry
    .word   handler+1       // 11: System service call trap service routine
    .word   0               // 12: Reserved entry
    .word   0               // 13: Reserved entry
    .word   handler+1       // 14: Pending service system trap service routine
    .word   handler+1       // 15: System tick service routine
    .word   handler+1       // 16: Interrupt IRQ service routine

/****************************************************************************/
/* Rutina de inicializacion del GPIO de leds
/****************************************************************************/
    .section .text
    .func leds_init
leds_init:
    // Se configuran los pines de los leds rgb como gpio sin pull-up
    LDR R1,=SCU_BASE
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(4 * (32 * LED_R_PORT + LED_R_PIN))]
    STR R0,[R1,#(4 * (32 * LED_G_PORT + LED_G_PIN))]
    STR R0,[R1,#(4 * (32 * LED_B_PORT + LED_B_PIN))]

    // Se configuran los pines de los leds 1 al 3 como gpio sin pull-up
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#(LED_1_PORT << 7 | LED_1_PIN << 2)]
    STR R0,[R1,#(LED_2_PORT << 7 | LED_2_PIN << 2)]
    STR R0,[R1,#(LED_3_PORT << 7 | LED_3_PIN << 2)]

    // Se apagan todos los bits gpio de los leds rgb
    LDR R1,=GPIO_CLR0
    LDR R0,=LED_MASK
    STR R0,[R1,#LED_OFFSET]

    // Se apagan los bits gpio correspondientes a los leds 2 al 3 
    LDR R0,=LED_1_MASK
    STR R0,[R1,#LED_1_OFFSET]
    LDR R0,=LED_N_MASK
    STR R0,[R1,#LED_N_OFFSET]

    // Se configuran los bits gpio de los leds rgb como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#LED_OFFSET]
    ORR R0,#LED_MASK
    STR R0,[R1,#LED_OFFSET]

    // Se configuran los bits gpio de los leds 2 a 3 como salidas
    LDR R0,=LED_1_MASK
    STR R0,[R1,#LED_1_OFFSET]
    LDR R0,=LED_N_MASK
    STR R0,[R1,#LED_N_OFFSET]

    BX LR
    .pool                   // Se almacenan las constantes de codigo
    .endfunc

/****************************************************************************/
/* Rutina de control para el canal R del led RGB
/****************************************************************************/
    .func set_led_r
set_led_r:
    LDR R1,=GPIO_SET0
    MOV R0,#LED_R_MASK
    STR R0,[R1,#LED_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func clear_led_r
clear_led_r:
    LDR R1,=GPIO_CLR0
    MOV R0,#LED_R_MASK
    STR R0,[R1,#LED_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func toggle_led_r
toggle_led_r:
    LDR R1,=GPIO_NOT0
    MOV R0,#LED_R_MASK
    STR R0,[R1,#LED_OFFSET]
    BX LR
    .pool
    .endfunc

/****************************************************************************/
/* Rutina de control para el canal G del led RGB
/****************************************************************************/
    .func set_led_g
set_led_g:
    LDR R1,=GPIO_SET0
    MOV R0,#LED_G_MASK
    STR R0,[R1,#LED_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func clear_led_g
clear_led_g:
    LDR R1,=GPIO_CLR0
    MOV R0,#LED_G_MASK
    STR R0,[R1,#LED_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func toggle_led_g
toggle_led_g:
    LDR R1,=GPIO_NOT0
    MOV R0,#LED_G_MASK
    STR R0,[R1,#LED_OFFSET]
    BX LR
    .pool
    .endfunc

/****************************************************************************/
/* Rutina de control para el canal b del led RGB
/****************************************************************************/
    .func set_led_b
set_led_b:
    LDR R1,=GPIO_SET0
    MOV R0,#LED_B_MASK
    STR R0,[R1,#LED_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func clear_led_b
clear_led_b:
    LDR R1,=GPIO_CLR0
    MOV R0,#LED_B_MASK
    STR R0,[R1,#LED_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func toggle_led_b
toggle_led_b:
    LDR R1,=GPIO_NOT0
    MOV R0,#LED_B_MASK
    STR R0,[R1,#LED_OFFSET]
    BX LR
    .pool
    .endfunc
    
/****************************************************************************/
/* Rutina de control para el led 1
/****************************************************************************/
    .func set_led_1
set_led_1:
    LDR R1,=GPIO_SET0
    MOV R0,#LED_1_MASK
    STR R0,[R1,#LED_1_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func clear_led_1
clear_led_1:
    LDR R1,=GPIO_CLR0
    MOV R0,#LED_1_MASK
    STR R0,[R1,#LED_1_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func toggle_led_1
toggle_led_1:
    LDR R1,=GPIO_NOT0
    MOV R0,#LED_1_MASK
    STR R0,[R1,#LED_1_OFFSET]
    BX LR
    .pool
    .endfunc

/****************************************************************************/
/* Rutina de control para el led 2
/****************************************************************************/
    .func set_led_2
set_led_2:
    LDR R1,=GPIO_SET0
    MOV R0,#LED_2_MASK
    STR R0,[R1,#LED_N_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func clear_led_2
clear_led_2:
    LDR R1,=GPIO_CLR0
    MOV R0,#LED_2_MASK
    STR R0,[R1,#LED_N_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func toggle_led_2
toggle_led_2:
    LDR R1,=GPIO_NOT0
    MOV R0,#LED_2_MASK
    STR R0,[R1,#LED_N_OFFSET]
    BX LR
    .pool
    .endfunc

/****************************************************************************/
/* Rutina de control para el led 3
/****************************************************************************/
    .func set_led_3
set_led_3:
    LDR R1,=GPIO_SET0
    MOV R0,#LED_3_MASK
    STR R0,[R1,#LED_N_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func clear_led_3
clear_led_3:
    LDR R1,=GPIO_CLR0
    MOV R0,#LED_3_MASK
    STR R0,[R1,#LED_N_OFFSET]
    BX LR
    .pool
    .endfunc
/****************************************************************************/
    .func toggle_led_3
toggle_led_3:
    LDR R1,=GPIO_NOT0
    MOV R0,#LED_3_MASK
    STR R0,[R1,#LED_N_OFFSET]
    BX LR
    .pool
    .endfunc

/****************************************************************************/
/* Rutina de servicio generica para excepciones
/****************************************************************************/
    .func handler
handler:
    BL leds_init
    BL set_led_1
loop:
    B loop
    .pool
    .endfunc

/****************************************************************************/
/* Handler para el manejo del arranque
/****************************************************************************/
    .global reset
    .func reset 
reset:
    BL leds_init
    LDR LR,=0x10000001
    BX LR

    .pool
    .endfunc
