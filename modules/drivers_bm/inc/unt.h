/* Copyright 2016-2019, Laboratorio de Microprocesadores 
 * Facultad de Ciencias Exactas y Tecnología 
 * Universidad Nacional de Tucuman
 * http://www.microprocesadores.unt.edu.ar/
 * All rights reserved.
 * 
 * Copyright 2016,2019, Esteban Volentini <evolentini@gmail.com>
 * Copyright 2016, Matias Giori <matias.giori@domotech.com.ar>
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

#ifndef UNT_H
#define UNT_H

/** @brief Controlador de dispositivos para el poncho educativo
 **
 ** Conjunto de rutinas para configurar y controlar el poncho educativo para EDU-CIAA_NXP
 **
 **| REV | YYYY.MM.DD | Autor           | Descripción de los cambios                              |
 **|-----|------------|-----------------|---------------------------------------------------------|
 **|   1 | 2016.07.02 | evolentini      | Primera version del programa para prueba del prototipo  |
 **|   2 | 2016.07.09 | evolentini      | Mejoras y correcciones las definiciones de los recursos |
 **|   3 | 2016.07.15 | evolentini      | Agregado de las funciones para manejo del LCD           |
 **|   4 | 2018.04.10 | evolentini      | Conversion del codigo de ejemplo en una libreria        |
 **|   5 | 2018.04.18 | evolentini      | Correccion en el manejo de potencia del led RGB         |
 **|   6 | 2019.04.06 | evolentini      | Mejoras en la documentacion y formato                   |
 **
 ** @addtogroup drivers Controladores
 ** @brief Controladores de dispositivos
 ** @{ */

/* === Inclusiones de archivos externos ======================================================== */
#include <stdint.h>
#include "display.h"

/* === Cabecera C++ ============================================================================ */
#ifdef __cplusplus
extern "C" {
#endif

/* === Definicion y Macros ===================================================================== */
//! Valor de retorno cuando no hay ninguna tecla presionada
#define NO_KEY    0

//! Valor de retorno cuando esta presionada la tecla F1
#define TECLA_F1  1

//! Valor de mascara cuando esta presionada la tecla F1
#define MASCARA_F1  (1  << 0)

//! Valor de retorno cuando esta presionada la tecla F2
#define TECLA_F2  2

//! Valor de mascara cuando esta presionada la tecla F2
#define MASCARA_F2  (1  << 1)

//! Valor de retorno cuando esta presionada la tecla F3
#define TECLA_F3  3

//! Valor de mascara cuando esta presionada la tecla F2
#define MASCARA_F3  (1  << 2)

//! Valor de retorno cuando esta presionada la tecla F4
#define TECLA_F4  4

//! Valor de mascara cuando esta presionada la tecla F2
#define MASCARA_F4  (1  << 3)

//! Valor de retorno cuando esta presionada la tecla SI
#define TECLA_SI  5

//! Valor de mascara cuando esta presionada la tecla F2
#define MASCARA_SI  (1  << 4)

//! Valor de retorno cuando esta presionada la tecla NO
#define TECLA_NO  6

//! Valor de mascara cuando esta presionada la tecla NO
#define MASCARA_NO  (1  << 5)

/* == Declaraciones de tipos de datos ========================================================== */
 
/* === Declaraciones de variables externas ===================================================== */

/* === Declaraciones de funciones externas ===================================================== */

//! Funcion para configurar el poncho educativo de la UNT
/**
 * Esta funcion configura los terminales del procesador asociados con el poncho educativo
 * e inicializa el estado del mismo configurando el display de LCD y apagando los displays
 * de siete segmentos y el led RGB. 
 */
void Init_PonchoUNT(void);

//! Funcion para probar la funcionalidad del poncho educativo de la UNT
/**
 * Esta funcion ejecuta un programa de prueba en el que cada tecla de funcion ingremente el
 * correspondiente digito del display de siete segmentos. Los tres primeros valores son 
 * utilizados como valor de potencia de los canales rojo, verde y azul del led RGB. 
 * En la pantalla de LCD se muestra un mensaje estatico.
 */
void Test_PonchoUNT(void);

//! Funcion para escribir un digito decimal
/**
 * La funcion recive un valor numerico del 0 al 9 y una poscion de display del 0 al 3 
 * y prende los segmentos correspondientes para formar el numero en la posicion deseada.
 * 
 * @param[in]	valor 		Valor decimal a escribir en el display (Valores validos: 0 a 9)
 * @param[in]   posicion    Posicion del display a utilizar (Valores validos: 0 a 3)
 */
void Escribir_Digito(uint8_t valor, uint8_t posicion);

//! Funcion para escribir un patron de segmentos
/**
 * La funcion recive un patron de bits y una poscion de display del 0 al 3 
 * y prende los segmentos correspondientes a los bits con valor uno del patron
 * en la posicion deseada. El bit cero corresponde al segmento a y en forma correlativa
 * el bit seis corresponde al segment g mientras que el bit siete corresponde al punto
 * decimal
 *
 * @param[in]	segmentos 	Patron de bit con los segmentos a prender
 * @param[in]   posicion    Posicion del display a utilizar (Valores validos: 0 a 3)
 */
void Escribir_Segmentos(uint8_t segmentos, uint8_t posicion);

//! Funcion para leer el estado del teclado
/**
 * La funcion realiza un escaneo del teclado y devuelve la tecla presionada de mayor
 * prioridad  (TECLA_F1, TECLA_F2, TECLA_F3, TECLA_F4, TECLA_SI, TECLA_NO). Si no hay
 * ninguna tecla presionada retorna el valor NO_KEY
 */
uint8_t Leer_Teclas(void);

/** 
 * @brief Funcion para controlar el led RGB
 * 
 * Esta funcion controla la intensidad de los canales rojo, verde y azul del 
 * del RGB
 * 
 * @param[in] r Nivel de potencia del canal rojo (Valores validos: 0 a 100)
 * @param[in] g Nivel de potencia del canal verde (Valores validos: 0 a 100)
 * @param[in] b Nivel de potencia del canal azul (Valores validos: 0 a 100)
 */
void Led_RGB(uint8_t r, uint8_t g, uint8_t b);

/* === Ciere de documentacion ================================================================== */
#ifdef __cplusplus
}
#endif

/** @} Final de la definición del modulo para doxygen */

#endif   /* UNT_H */