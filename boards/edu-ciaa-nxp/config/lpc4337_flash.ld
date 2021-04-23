/* Copyright 2016, Laboratorio de Microprocesadores 
 * Facultad de Ciencias Exactas y Tecnología 
 * Universidad Nacional de Tucuman
 * http://www.microprocesadores.unt.edu.ar/
 * Copyright 2016, Esteban Volentini <evolentini@gmail.com>
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

/* Define each memory region */
MEMORY {
    MFlashA512 (rx)    : ORIGIN = 0x1a000000, LENGTH = 0x80000 /* 512K bytes */
    MFlashB512 (rx)    : ORIGIN = 0x1b000000, LENGTH = 0x80000 /* 512K bytes */
    RamLoc32 (rwx)     : ORIGIN = 0x10000000, LENGTH = 0x8000  /* 32K bytes */
    RamLoc40 (rwx)     : ORIGIN = 0x10080000, LENGTH = 0x8000  /* 32K bytes */
    RamLoc08 (rwx)     : ORIGIN = 0x10088000, LENGTH = 0x2000  /*  8K bytes */
    RamAHB32 (rwx)     : ORIGIN = 0x20000000, LENGTH = 0x8000  /* 32K bytes */
    RamAHB16 (rwx)     : ORIGIN = 0x20008000, LENGTH = 0x4000  /* 16K bytes */
    RamAHB_ETB16 (rwx) : ORIGIN = 0x2000c000, LENGTH = 0x4000  /* 16K bytes */
}

/* Define a symbol for the top of each memory region */
    __top_MFlashA512 = 0x1a000000 + 0x80000;
    __top_MFlashB512 = 0x1b000000 + 0x80000;
    __top_RamLoc32 = 0x10000000 + 0x8000;
    __top_RamLoc40 = 0x10080000 + 0x8000;
    __top_RamLoc08 = 0x10088000 + 0x2000;
    __top_RamAHB32 = 0x20000000 + 0x8000;
    __top_RamAHB16 = 0x20008000 + 0x4000;
    __top_RamAHB_ETB16 = 0x2000c000 + 0x4000;

ENTRY(reset)

SECTIONS {
    .text : ALIGN(4) {
        FILL(0xFF)
        KEEP(*(.isr_vector)) ;
        . = ALIGN(0x100);
        *(.text*)
        . = ALIGN(4);
        *(.constant*)
    } > MFlashA512

   	.code : ALIGN(4) {
    	*(.data*)
        . = ALIGN(4) ;
    } > RamLoc08	

    PROVIDE(stack = __top_RamLoc40 - 0);
}
