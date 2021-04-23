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
    .include "configuraciones/rutinas.s"
    .include "configuraciones/ciaa.s"
    .include "configuraciones/poncho.s"

/************************************************************************************/
/* Programa principal                                                               */
/************************************************************************************/

    .global reset           // Define el punto de entrada del código
    .section .text          // Define la sección de código (FLASH)
    .func main              // Inidica al depurador el inicio de una funcion

reset:
    // Mueve el vector de interrupciones al principio de la segunda RAM
    LDR R1,=VTOR
    LDR R0,=#0x10080000
    STR R0,[R1]

    // Llama a una subrutina existente en flash para configurar los leds
    LDR R1,=leds_init
    BLX R1

    // Configuración de los pines de segmentos como gpio sin pull-up
    LDR R1,=SCU_BASE
    MOV R0,#(SCU_MODE_INACT | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC0)
    STR R0,[R1,#((SA_PORT * 32 + SA_PIN) * 4)]
    STR R0,[R1,#((SB_PORT * 32 + SB_PIN) * 4)]
    STR R0,[R1,#((SC_PORT * 32 + SC_PIN) * 4)]
    STR R0,[R1,#((SD_PORT * 32 + SD_PIN) * 4)]
    STR R0,[R1,#((SD_PORT * 32 + SE_PIN) * 4)]
    STR R0,[R1,#((SF_PORT * 32 + SF_PIN) * 4)]
    STR R0,[R1,#((SG_PORT * 32 + SG_PIN) * 4)]
    STR R0,[R1,#((SDP_PORT * 32 + SDP_PIN) * 4)]

    // Configuración de los pines de digitos como gpio sin pull-up
    STR R0,[R1,#((D1_PORT << 5 + D1_PIN) << 2)]
    STR R0,[R1,#((D2_PORT << 5 + D2_PIN) << 2)]
    STR R0,[R1,#((D3_PORT << 5 + D3_PIN) << 2)]
    STR R0,[R1,#((D4_PORT << 5 + D4_PIN) << 2)]

    // Configura los pines de las teclas como gpio con pull-up
    MOV R0,#(SCU_MODE_PULLUP | SCU_MODE_INBUFF_EN | SCU_MODE_ZIF_DIS | SCU_MODE_FUNC4)
    STR R0,[R1,#(TEC_1_PORT << 7 | TEC_1_PIN << 2)]
    STR R0,[R1,#(TEC_2_PORT << 7 | TEC_2_PIN << 2)]
    STR R0,[R1,#(TEC_3_PORT << 7 | TEC_3_PIN << 2)]
    STR R0,[R1,#(TEC_4_PORT << 7 | TEC_4_PIN << 2)]
    STR R0,[R1,#(TEC_A_PORT << 7 | TEC_A_PIN << 2)]
    STR R0,[R1,#(TEC_C_PORT << 7 | TEC_C_PIN << 2)]

    // Apagado de todos los bits gpio de los segmentos
    LDR R1,=GPIO_CLR0
    LDR R0,=SEG_MASK
    STR R0,[R1,#SEG_OFFSET]
    LDR R0,=SDP_MASK
    STR R0,[R1,#SDP_OFFSET]

    // Apagado de todos bits gpio de los digitos
    LDR R0,=DIG_MASK
    STR R0,[R1,#DIG_OFFSET]

    // Configuración de los bits gpio de segmentos como salidas
    LDR R1,=GPIO_DIR0
    LDR R0,[R1,#SEG_OFFSET]
    ORR R0,#SEG_MASK
    STR R0,[R1,#SEG_OFFSET]

    LDR R0,[R1,#SDP_OFFSET]
    ORR R0,#SDP_MASK
    STR R0,[R1,#SDP_OFFSET]

    // Configuración de los bits gpio de digitos como salidas
    LDR R0,[R1,#DIG_OFFSET]
    ORR R0,#DIG_MASK
    STR R0,[R1,#DIG_OFFSET]

    // Configura los bits gpio de los botones como entradas
    LDR R0,[R1,#TEC_OFFSET]
    AND R0,#~TEC_MASK
    STR R0,[R1,#TEC_OFFSET]

    numero      .req R0
    posicion    .req R1
    puntero     .req R2
    valor       .req R3

    MOV numero,#0
    MOV posicion,#0

refrescar:
    // Se apagan todos los digitos
    LDR puntero,=GPIO_CLR0
    MOV valor,#DIG_MASK
    STR valor,[puntero,#DIG_OFFSET]
    // Se apagan todos los segmentos
    MOV valor,#SEG_MASK
    STR valor,[puntero,#SEG_OFFSET]
    
    // Se prenden los segmentos del numero actual
    AND numero,#0x0F
    LDR puntero,=segmentos
    LDR valor,[puntero, numero, LSL #2]
    LDR puntero,=GPIO_SET0
    STR valor,[puntero,#SEG_OFFSET]

    // Se prende el punto comun de la posicion actual
    LDR puntero,=digitos
    LDR valor,[puntero, posicion, LSL #2]
    LDR puntero,=GPIO_SET0
    STR valor,[puntero,#DIG_OFFSET]

    LDR valor,=1000000
espera_liberar:
    SUBS valor,#1
    BNE espera_liberar

    LDR puntero,=GPIO_PIN0

    LDR valor,=1000000
espera_presionar:
    SUBS valor,#1
    BNE espera_presionar

    LDR puntero,=GPIO_PIN0
presionar:
    LDR valor,[puntero,#TEC_OFFSET]
    TST valor,#TEC_MASK
    BEQ presionar
    
    // Si la tecla uno esta apretada se muestra el numero en el primer display
    TST valor,#TEC_1_MASK
    // Si la tecla esta apretada
    IT NE
    // Se muestra el numero en el primer display
    MOVNE posicion,#0

    // Si la tecla dos esta apretada se muestra el numero en el segundo display
    TST valor,#TEC_2_MASK
    IT NE
    MOVNE posicion,#1

    // Si la tecla tres esta apretada se muestra el numero en el tercer display
    TST valor,#TEC_3_MASK
    IT NE
    MOVNE posicion,#2

    // Si la tecla cuatro esta apretada se muestra el numero en el cuarto display
    TST valor,#TEC_4_MASK
    IT NE
    MOVNE posicion,#3

    // Si la tecla aceptar esta apretada se incrementa el numero mostrado
    TST valor,#TEC_A_MASK
    IT NE
    ADDNE numero,#1

    // Si la tecla cancelar esta apretada se decrementa el numero mostrado
    TST valor,#TEC_C_MASK
    IT NE
    SUBNE numero,#1

    // Repite el lazo de refresco indefinidamente
    B refrescar

    .pool                   // Almacenar las constantes de código
    .endfunc

segmentos:
    .word SA_MASK + SB_MASK + SC_MASK + SD_MASK + SE_MASK + SF_MASK             // 0
    .word SB_MASK + SC_MASK                                                     // 1
    .word SA_MASK + SB_MASK + SD_MASK + SE_MASK + SG_MASK                       // 2
    .word SA_MASK + SB_MASK + SC_MASK + SD_MASK + SG_MASK                       // 3
    .word SB_MASK + SC_MASK + SF_MASK + SG_MASK                                 // 4
    .word SA_MASK + SC_MASK + SD_MASK + SF_MASK + SG_MASK                       // 5
    .word SA_MASK + SC_MASK + SD_MASK + SE_MASK + SF_MASK + SG_MASK             // 6
    .word SA_MASK + SB_MASK + SC_MASK                                           // 7
    .word SA_MASK + SB_MASK + SC_MASK + SD_MASK + SE_MASK + SF_MASK + SG_MASK   // 8
//    .byte SA_MASK + SB_MASK + SC_MASK + SF_MASK + SG_MASK                      // 9
    .word SA_MASK + SB_MASK + SC_MASK + SD_MASK + SF_MASK + SG_MASK             // 9

    .word SA_MASK + SB_MASK + SC_MASK + SE_MASK + SF_MASK + SG_MASK             // A
    .word SC_MASK + SD_MASK + SE_MASK + SF_MASK + SG_MASK                       // B
    .word SA_MASK + SD_MASK + SE_MASK + SF_MASK                                 // C
    .word SB_MASK + SC_MASK + SD_MASK + SE_MASK + SG_MASK                       // D
    .word SA_MASK + SD_MASK + SE_MASK + SF_MASK + SG_MASK                       // E
    .word SA_MASK + SE_MASK + SF_MASK + SG_MASK                                 // F

digitos:
    .word D1_MASK
    .word D2_MASK
    .word D3_MASK
    .word D4_MASK            
