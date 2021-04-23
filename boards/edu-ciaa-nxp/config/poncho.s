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
/* Declaraciones de macros para acceso simbolico a los recursos del poncho
/****************************************************************************/

	// Recursos utilizados por el primer segmento
    .equ SA_PORT,	    4
    .equ SA_PIN,	    0
    .equ SA_BIT,	    0
    .equ SA_MASK,	    (1 << SA_BIT)

	// Recursos utilizados por el segundo segmento
    .equ SB_PORT,	    4
    .equ SB_PIN,	    1
    .equ SB_BIT,	    1
    .equ SB_MASK,	    (1 << SB_BIT)

	// Recursos utilizados por el tercer segmento
    .equ SC_PORT,	    4
    .equ SC_PIN,	    2
    .equ SC_BIT,	    2
    .equ SC_MASK,	    (1 << SC_BIT)

	// Recursos utilizados por el cuatro segmento
    .equ SD_PORT,	    4
    .equ SD_PIN,	    3
    .equ SD_BIT,	    3
    .equ SD_MASK,	    (1 << SD_BIT)

	// Recursos utilizados por el quint segmento
    .equ SE_PORT,	    4
    .equ SE_PIN,	    4
    .equ SE_BIT,	    4
    .equ SE_MASK,	    (1 << SE_BIT)

	// Recursos utilizados por el sexto segmento
    .equ SF_PORT,	    4
    .equ SF_PIN,	    5
    .equ SF_BIT,	    5
    .equ SF_MASK,	    (1 << SF_BIT)

	// Recursos utilizados por el septimo segmento
    .equ SG_PORT,	    4
    .equ SG_PIN,	    6
    .equ SG_BIT,	    6
    .equ SG_MASK,	    (1 << SG_BIT)

	// Recursos utilizados por los segmentos en general
    .equ SEG_GPIO,	    2
    .equ SEG_OFFSET,    ( SEG_GPIO << 2 ) 
    .equ SEG_MASK,	    ( SA_MASK | SB_MASK | SC_MASK | SD_MASK | SE_MASK | SF_MASK | SG_MASK )

    // Recursos utilizados por el octavo segmento (punto)
    .equ SDP_PORT,	    6
    .equ SDP_PIN,	    8
    .equ SDP_BIT,	    16
    .equ SDP_MASK,	    (1 << SDP_BIT)

	// Recursos utilizados por los segmentos en general
    .equ SDP_GPIO,	    5
    .equ SDP_OFFSET,    ( SDP_GPIO << 2 ) 

	// Recursos utilizados por el primer digito
    .equ D1_PORT,	    0
    .equ D1_PIN,	    0
    .equ D1_BIT,	    0
    .equ D1_MASK,	    (1 << D1_BIT)

	// Recursos utilizados por el segundo digito
    .equ D2_PORT,	    0
    .equ D2_PIN,	    1
    .equ D2_BIT,	    1
    .equ D2_MASK,	    (1 << D2_BIT)

	// Recursos utilizados por el tercer digito
    .equ D3_PORT,	    1
    .equ D3_PIN,	    15
    .equ D3_BIT,	    2
    .equ D3_MASK,	    (1 << D3_BIT)

	// Recursos utilizados por el cuatro digito
    .equ D4_PORT,	    1
    .equ D4_PIN,	    17
    .equ D4_BIT,	    3
    .equ D4_MASK,	    (1 << D4_BIT)
    
	// Recursos utilizados por los digitos en general
    .equ DIG_GPIO,	    0
    .equ DIG_OFFSET,    ( DIG_GPIO << 2 ) 
    .equ DIG_MASK,	    ( D1_MASK | D2_MASK | D3_MASK | D4_MASK)

    // Recursos utilizados por la tecla F1
    .equ TEC_1_PORT,    4
    .equ TEC_1_PIN,     8
    .equ TEC_1_BIT,     12
    .equ TEC_1_MASK,    (1 << TEC_1_BIT)

    // Recursos utilizados por la tecla F2
    .equ TEC_2_PORT,    4
    .equ TEC_2_PIN,     9
    .equ TEC_2_BIT,     13
    .equ TEC_2_MASK,    (1 << TEC_2_BIT)

    // Recursos utilizados por la tecla F3
    .equ TEC_3_PORT,    4
    .equ TEC_3_PIN,     10
    .equ TEC_3_BIT,     14
    .equ TEC_3_MASK,    (1 << TEC_3_BIT)

    // Recursos utilizados por la tecla F4
    .equ TEC_4_PORT,    6
    .equ TEC_4_PIN,     7
    .equ TEC_4_BIT,     15
    .equ TEC_4_MASK,    (1 << TEC_4_BIT)

    // Recursos utilizados por la tecla ACEPTAR
    .equ TEC_A_PORT,    3
    .equ TEC_A_PIN,     2
    .equ TEC_A_BIT,     9
    .equ TEC_A_MASK,    (1 << TEC_A_BIT)

    // Recursos utilizados por la tecla CANCELAR
    .equ TEC_C_PORT,    3
    .equ TEC_C_PIN,     1
    .equ TEC_C_BIT,     8
    .equ TEC_C_MASK,    (1 << TEC_C_BIT)

    // Recursos utilizados por el teclado
    .equ TEC_GPIO,      5
    .equ TEC_OFFSET,    ( TEC_GPIO << 2 ) 
    .equ TEC_MASK,      ( TEC_1_MASK | TEC_2_MASK | TEC_3_MASK | TEC_4_MASK | TEC_A_MASK | TEC_C_MASK )
