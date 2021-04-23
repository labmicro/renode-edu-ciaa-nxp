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

/** @brief Implementacion de la clase para gestion de los sensores digitales
 **
 **| REV | YYYY.MM.DD | Autor           | Descripción de los cambios                              |
 **|-----|------------|-----------------|---------------------------------------------------------|
 **|   1 | 2020.02.05 | evolentini      | Version inicial del archivo                             |
 **
 ** @addtogroup controladores
 ** @brief Controladores de dispositivos
 ** @{ */

/* === Inclusiones de cabeceras ================================================================ */

#include "segmentos.h"
#include "config.h"
#include <stdio.h>
#include <string.h>

#ifndef SEGMENTOS_DIGITOS
#define SEGMENTOS_DIGITOS 8
#endif

/* === Definicion y Macros ===================================================================== */

struct segmentos_s {
    struct segmentos_controlador_s controlador[1];
    uint8_t memoria[SEGMENTOS_DIGITOS];
    uint8_t digitos;
    uint8_t activo;
};

/* === Declaraciones de tipos de datos internos ================================================ */

/* === Declaraciones de funciones internas ===================================================== */

/* === Definiciones de variables internas ====================================================== */
static const uint8_t DIGITOS[] = {
    SEGMENTO_A | SEGMENTO_B | SEGMENTO_C | SEGMENTO_D | SEGMENTO_E | SEGMENTO_F,               //! < 0
    SEGMENTO_B | SEGMENTO_C,                                                                   //! < 1
    SEGMENTO_A | SEGMENTO_B | SEGMENTO_D | SEGMENTO_E | SEGMENTO_G,                            //! < 2
    SEGMENTO_A | SEGMENTO_B | SEGMENTO_C | SEGMENTO_D,                                         //! < 3
    SEGMENTO_B | SEGMENTO_C | SEGMENTO_F | SEGMENTO_G,                                         //! < 4
    SEGMENTO_A | SEGMENTO_C | SEGMENTO_D | SEGMENTO_F | SEGMENTO_G,                            //! < 5
    SEGMENTO_A | SEGMENTO_C | SEGMENTO_D | SEGMENTO_E | SEGMENTO_F | SEGMENTO_G,               //! < 6
    SEGMENTO_A | SEGMENTO_B | SEGMENTO_C,                                                      //! < 7
    SEGMENTO_A | SEGMENTO_B | SEGMENTO_C | SEGMENTO_D | SEGMENTO_E | SEGMENTO_F | SEGMENTO_G,  //! < 8
    SEGMENTO_A | SEGMENTO_B | SEGMENTO_C | SEGMENTO_F | SEGMENTO_G,                            //! < 9
};

/* === Definiciones de variables externas ====================================================== */

/* === Definiciones de funciones internas ====================================================== */

segmentos_t CrearInstancia() {
    static struct segmentos_s self[1];
    return self;
}

/* === Definiciones de funciones externas ====================================================== */
segmentos_t SegmentosCrear(uint8_t digitos, segmentos_controlador_t controlador) {
    segmentos_t self = NULL;

    self = CrearInstancia();
    if (self) {
        self->digitos = digitos;
        self->activo = 0;
        memset(self->memoria, 0, sizeof(self->memoria));
        memcpy(self->controlador, controlador, sizeof(struct segmentos_controlador_s));
        self->memoria[0] = DIGITOS[0];
    }
    return self;
}

void SegmentosEscribir(segmentos_t self, uint8_t posicion, uint8_t valor) {
    if (self && (posicion < self->digitos)) {
        self->memoria[posicion] = valor;
    }
}

void SegmentosDigito(segmentos_t self, uint8_t posicion, uint8_t valor) {
    if (self && (posicion < self->digitos)) {
        self->memoria[posicion] = DIGITOS[valor & 0x0F];
    }
}

void SegmentosNumero(segmentos_t self, int valor) {
    if (self) {
        char numero[SEGMENTOS_DIGITOS];
        sprintf(numero, "%d", valor);
        memset(self->memoria, 0, sizeof(self->memoria));

        int longitud = strlen(numero);
        for (int indice = 0; indice < longitud; indice++) {
            SegmentosDigito(self, indice, numero[longitud - indice] - '0');
        }
    }
}

void SegmentosBCD(segmentos_t self, uint8_t valor[]) {
    if (self) {
        for (int indice = 0; indice < self->digitos; indice++) {
            SegmentosDigito(self, indice, valor[indice]);
        }
    }
}

void SegmentosRefrescar(segmentos_t self) {
    self->controlador->ApagarDigitos();
    self->controlador->ApagarSegmentos();
    self->activo = (self->activo + 1) & self->digitos;
    self->controlador->PrenderSegmentos(self->memoria[self->activo]);
    self->controlador->PrenderDigito(self->activo);
}

/* === Ciere de documentacion ================================================================== */

/** @} Final de la definición del modulo para doxygen */