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

#ifndef SEGMENTOS_H
#define SEGMENTOS_H

/** @brief Controlador para manejo de un display de siete segmentos multiplezado
 **
 ** Conjunto de rutinas para manejar una pantalla numerica con display de siete segmentos
 **
 **| REV | YYYY.MM.DD | Autor           | Descripción de los cambios                              |
 **|-----|------------|-----------------|---------------------------------------------------------|
 **|   1 | 2020.08.26 | evolentini      | Primera version del programa para prueba del prototipo  |
 **
 ** @addtogroup drivers Controladores
 ** @brief Controladores de dispositivos
 ** @{ */

/* === Inclusiones de archivos externos ======================================================== */
#include <stdint.h>

/* === Cabecera C++ ============================================================================ */
#ifdef __cplusplus
extern "C" {
#endif

/* === Definicion y Macros ===================================================================== */
#include <stdint.h>

#define SEGMENTO_A  (1 << 0)
#define SEGMENTO_B  (1 << 1)
#define SEGMENTO_C  (1 << 2)
#define SEGMENTO_D  (1 << 3)
#define SEGMENTO_E  (1 << 4)    
#define SEGMENTO_F  (1 << 5)
#define SEGMENTO_G  (1 << 6)

/* == Declaraciones de tipos de datos ========================================================== */
 
/* === Declaraciones de variables externas ===================================================== */

/* === Declaraciones de funciones externas ===================================================== */

//! Funcion para apagar digitos o segmentos
typedef void(*segmentos_apagar_t)(void);

//! Funcion para prender los segmentos de un digito
typedef void(*segmentos_prender_t)(uint8_t mascara);

//! Funcion para prender un digito
typedef void(*segmentos_digito_t)(uint8_t digito);

//! Estrutura con las funciones para controlar los digitos y segmentos
typedef struct segmentos_controlador_s {
    segmentos_apagar_t ApagarSegmentos;
    segmentos_prender_t PrenderSegmentos;
    segmentos_apagar_t ApagarDigitos;
    segmentos_digito_t PrenderDigito;
} const * segmentos_controlador_t;

//! Puntero a un descriptor de un objeto segmentos
typedef struct segmentos_s *  segmentos_t;

//! Funcion para crear una nueva instanacia del objeto segmentos
segmentos_t SegmentosCrear(uint8_t digitos, segmentos_controlador_t controlador);

//! Funcion para escribir un patron de segmentos
/**
 * La funcion recive un patron de bits y una poscion de display del 0 al D - 1 
 * y prende los segmentos correspondientes a los bits con valor uno del patron
 * en la posicion deseada. El bit cero corresponde al segmento a y en forma correlativa
 * el bit seis corresponde al segment g mientras que el bit siete corresponde al punto
 * decimal
 *
 * @param[in]   segmentos   Descriptor al objeto devuelto por la funcion al crear el objeto
 * @param[in]   posicion    Posicion del display a utilizar (Valores validos: 0 a D - 1)
 * @param[in]	valor 	    Patron de bit con los segmentos a prender
 */
void SegmentosEscribir(segmentos_t segmentos, uint8_t posicion, uint8_t valor);

//! Funcion para escribir un digito decimal
/**
 * La funcion recive un valor numerico del 0 al 9 y una poscion de display del 0 a D - 1
 * y prende los segmentos correspondientes para formar el numero en la posicion deseada.
 * D es la cantidad de digitos que tiene la pantalla y se configuró al crear el objeto.
 * 
 * @param[in]   segmentos   Descriptor al objeto devuelto por la funcion al crear el objeto
 * @param[in]   posicion    Posicion del display a utilizar (Valores validos: 0 a D - 1)
 * @param[in]	valor 		Valor decimal a escribir en el display (Valores validos: 0 a 9)
 */
void SegmentosDigito(segmentos_t segmentos, uint8_t posicion, uint8_t valor);

//! Funcion para escribir un numero en binario natural
/**
 * La funcion recibe un valor numerico y almacena en la memoria de pantalla los segmentos 
 * correspondientes para formar cada uno de los digitos del numero deseado.
 * 
 * @param[in]   segmentos   Descriptor al objeto devuelto por la funcion al crear el objeto
 * @param[in]	valor 		Valor decimal a escribir en el display
 */
void SegmentosNumero(segmentos_t segmentos, int valor);

//! Funcion para escribir un numero en BCD
/**
 * La funcion recibe un valor numerico BCD y almacena en la memoria de pantalla los segmentos 
 * correspondientes para formar cada uno de los digitos del numero deseado.
 * 
 * @param[in]   segmentos   Descriptor al objeto devuelto por la funcion al crear el objeto
 * @param[in]	valor 		Valor decimal BCD a escribir en el display
 */
void SegmentosBCD(segmentos_t segmentos, uint8_t valor[]);

//! Funcion para refrescar la pantalla
void SegmentosRefrescar(segmentos_t segmentos);

/* === Ciere de documentacion ================================================================== */
#ifdef __cplusplus
}
#endif

/** @} Final de la definición del modulo para doxygen */

#endif   /* SEGMENTOS_H */