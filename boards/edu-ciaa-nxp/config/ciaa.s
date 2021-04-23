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

/****************************************************************************/
/* Macros para acceso simbolico a los recursos de la placa base edu-ciaa-nxp
/****************************************************************************/

// Recursos utilizados por el canal Rojo del led RGB
    // Numero de puerto de entrada/salida utilizado en el Led Rojo
    .equ LED_R_PORT,    2
    // Numero de terminal dentro del puerto de e/s utilizado en el Led Rojo
    .equ LED_R_PIN,     0
    // Numero de bit GPIO utilizado en el Led Rojo
    .equ LED_R_BIT,     0
    // Mascara de 32 bits con un 1 en el bit correspondiente al Led Rojo
    .equ LED_R_MASK,    (1 << LED_R_BIT)

// Recursos utilizados por el canal Verde del led RGB
    .equ LED_G_PORT,    2
    .equ LED_G_PIN,     1
    .equ LED_G_BIT,     1
    .equ LED_G_MASK,    (1 << LED_G_BIT)

// Recursos utilizados por el canal Azul del led RGB
    .equ LED_B_PORT,    2
    .equ LED_B_PIN,     2
    .equ LED_B_BIT,     2
    .equ LED_B_MASK,    (1 << LED_B_BIT)

// Recursos utilizados por el led RGB
    // Numero de puerto GPIO utilizado por los todos leds
    .equ LED_GPIO,      5
    // Desplazamiento para acceder a los registros GPIO de los leds
    .equ LED_OFFSET,    ( 4 * LED_GPIO )
    // Mascara de 32 bits con un 1 en los bits correspondiente a cada led
    .equ LED_MASK,      ( LED_R_MASK | LED_G_MASK | LED_B_MASK )

// Recursos utilizados por el led 1
    .equ LED_1_PORT,    2
    .equ LED_1_PIN,     10
    .equ LED_1_BIT,     14
    .equ LED_1_MASK,    (1 << LED_1_BIT)

    .equ LED_1_GPIO,    0
    .equ LED_1_OFFSET,  ( LED_1_GPIO << 2)

// Recursos utilizados por el led 2
    .equ LED_2_PORT,    2
    .equ LED_2_PIN,     11
    .equ LED_2_BIT,     11
    .equ LED_2_MASK,    (1 << LED_2_BIT)

// Recursos utilizados por el led 3
    .equ LED_3_PORT,    2
    .equ LED_3_PIN,     12
    .equ LED_3_BIT,     12
    .equ LED_3_MASK,    (1 << LED_3_BIT)

// Recursos utilizados por los leds 2 y 3
    .equ LED_N_GPIO,    1
    .equ LED_N_OFFSET,  ( LED_N_GPIO << 2)
    .equ LED_N_MASK,    ( LED_2_MASK | LED_3_MASK )

// Recursos utilizados por la primera tecla
    .equ TEC_1_PORT,    1
    .equ TEC_1_PIN,     0
    .equ TEC_1_BIT,     4
    .equ TEC_1_MASK,    (1 << TEC_1_BIT)

// Recursos utilizados por la segunda tecla
    .equ TEC_2_PORT,    1
    .equ TEC_2_PIN,     1
    .equ TEC_2_BIT,     8
    .equ TEC_2_MASK,    (1 << TEC_2_BIT)

// Recursos utilizados por la tercera tecla
    .equ TEC_3_PORT,    1
    .equ TEC_3_PIN,     2
    .equ TEC_3_BIT,     9
    .equ TEC_3_MASK,    (1 << TEC_3_BIT)

// Recursos utilizados por el teclado
    .equ TEC_GPIO,      0
    .equ TEC_OFFSET,    ( TEC_GPIO << 2)
    .equ TEC_MASK,      ( TEC_1_MASK | TEC_2_MASK | TEC_3_MASK )
