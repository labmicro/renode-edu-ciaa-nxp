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
/* Macros para a las rutinas predefinidas en flash para gestion de los leds
/****************************************************************************/

    .equ rutinas,           0x1A000100 + 1
    .equ leds_init,         rutinas

    .equ set_led_r,         rutinas + 0x0058
    .equ clear_led_r,       rutinas + 0x0068
    .equ toggle_led_r,      rutinas + 0x0078

    .equ set_led_g,         rutinas + 0x0088
    .equ clear_led_g,       rutinas + 0x0098
    .equ toggle_led_g,      rutinas + 0x00A8

    .equ set_led_b,         rutinas + 0x00B8
    .equ clear_led_b,       rutinas + 0x00C8
    .equ toggle_led_b,      rutinas + 0x00D8

    .equ set_led_1,         rutinas + 0x00E8
    .equ clear_led_1,       rutinas + 0x00F8
    .equ toggle_led_1,      rutinas + 0x0108

    .equ set_led_2,         rutinas + 0x0118
    .equ clear_led_2,       rutinas + 0x0128
    .equ toggle_led_2,      rutinas + 0x0138

    .equ set_led_3,         rutinas + 0x0148
    .equ clear_led_3,       rutinas + 0x0158
    .equ toggle_led_3,      rutinas + 0x0168
