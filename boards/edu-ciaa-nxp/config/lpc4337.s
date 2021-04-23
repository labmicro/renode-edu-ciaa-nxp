/* Copyright 2016, Laboratorio de Microprocesadores 
 * Facultad de Ciencias Exactas y Tecnología 
 * Universidad Nacional de Tucuman
 * http://www.microprocesadores.unt.edu.ar/
 * Copyright 2016, Esteban Volentini <evolentini@herrera.unt.edu.ar>
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
    .equ ACTLR,                     0xE000E008

    .equ SYST_CSR,                  0xE000E010
    .equ SYST_RVR,                  0xE000E014
    .equ SYST_CVR,                  0xE000E018
    .equ SYST_CALIB,                0xE000E01C

    .equ STCSR,                     SYST_CSR
    .equ STRVR,                     SYST_RVR
    .equ STCVR,                     SYST_CVR
    .equ STCR,                      SYST_CALIB

    .equ COUNTFLAG,                 (1 << 16)
    .equ CLKSOURCE,                 (1 << 2)
    .equ TICKINT,                   (1 << 1)
    .equ ENABLE,                    (1 << 0)
     
    .equ CPUID,                     0xE000ED00
    .equ ICSR,                      0xE000ED04    
    .equ VTOR,                      0xE000ED08
    .equ AIRCR,                     0xE000ED0C
    .equ SCR,                       0xE000ED10
    .equ CCR,                       0xE000ED14
    .equ SHPR1,                     0xE000ED18
    .equ SHPR2,                     0xE000ED1C
    .equ SHPR3,                     0xE000ED20
    .equ SHCSR,                     0xE000ED24
    .equ CFSR,                      0xE000ED28
    .equ HFSR,                      0xE000ED2C
    .equ DFSR,                      0xE000ED30
    .equ MMFAR,                     0xE000ED34
    .equ BFAR,                      0xE000ED38
    .equ AFSR,                      0xE000ED3C
    .equ ID_PFR0,                   0xE000ED40
    .equ ID_PFR1,                   0xE000ED44
    .equ ID_DFR0,                   0xE000ED48
    .equ ID_AFR0,                   0xE000ED4C

/* === NVIC (Nested Vectored Interrupt Controller) ======================== */

    .equ NVIC_BASE,                 0xE000E000

    .equ ISER0,                     0x0100
    .equ ISER1,                     0x0104
    .equ ISER2,                     0x0108
    .equ ISER3,                     0x010C
    .equ ISER4,                     0x0110
    .equ ISER5,                     0x0114
    .equ ISER6,                     0x0118
    .equ ISER7,                     0x011C

    .equ NVIC_ISER0,                (NVIC_BASE + ISER0)
    .equ NVIC_ISER1,                (NVIC_BASE + ISER1)
    .equ NVIC_ISER2,                (NVIC_BASE + ISER2)
    .equ NVIC_ISER3,                (NVIC_BASE + ISER3)
    .equ NVIC_ISER4,                (NVIC_BASE + ISER4)
    .equ NVIC_ISER5,                (NVIC_BASE + ISER5)
    .equ NVIC_ISER6,                (NVIC_BASE + ISER6)
    .equ NVIC_ISER7,                (NVIC_BASE + ISER7)

    .equ NVIC_ICER0,                0xE000E180
    .equ NVIC_ICER1,                0xE000E184
    .equ NVIC_ICER2,                0xE000E188
    .equ NVIC_ICER3,                0xE000E18C
    .equ NVIC_ICER4,                0xE000E190
    .equ NVIC_ICER5,                0xE000E194
    .equ NVIC_ICER6,                0xE000E198
    .equ NVIC_ICER7,                0xE000E19C

    .equ NVIC_ISPR0,                0xE000E200
    .equ NVIC_ISPR1,                0xE000E204
    .equ NVIC_ISPR2,                0xE000E208
    .equ NVIC_ISPR3,                0xE000E20C
    .equ NVIC_ISPR4,                0xE000E210
    .equ NVIC_ISPR5,                0xE000E214
    .equ NVIC_ISPR6,                0xE000E218
    .equ NVIC_ISPR7,                0xE000E21C

    .equ NVIC_ICPR0,                0xE000E280
    .equ NVIC_ICPR1,                0xE000E284
    .equ NVIC_ICPR2,                0xE000E288
    .equ NVIC_ICPR3,                0xE000E28C
    .equ NVIC_ICPR4,                0xE000E290
    .equ NVIC_ICPR5,                0xE000E294
    .equ NVIC_ICPR6,                0xE000E298
    .equ NVIC_ICPR7,                0xE000E29C

    .equ NVIC_IABR0,                0xE000E300
    .equ NVIC_IABR1,                0xE000E304
    .equ NVIC_IABR2,                0xE000E308
    .equ NVIC_IABR3,                0xE000E30C
    .equ NVIC_IABR4,                0xE000E310
    .equ NVIC_IABR5,                0xE000E314
    .equ NVIC_IABR6,                0xE000E318
    .equ NVIC_IABR7,                0xE000E31C

    
    .equ NVIC_IPR0,                 0xE000E400
    .equ NVIC_IPR1,                 0xE000E404
    .equ NVIC_IPR2,                 0xE000E408
    .equ NVIC_IPR3,                 0xE000E40C
    .equ NVIC_IPR4,                 0xE000E410
    .equ NVIC_IPR5,                 0xE000E414
    .equ NVIC_IPR6,                 0xE000E418
    .equ NVIC_IPR7,                 0xE000E41C
    .equ NVIC_IPR8,                 0xE000E420
    .equ NVIC_IPR9,                 0xE000E424
    .equ NVIC_IPR10,                0xE000E428
    .equ NVIC_IPR11,                0xE000E42C
    .equ NVIC_IPR12,                0xE000E430
    .equ NVIC_IPR13,                0xE000E434
    .equ NVIC_IPR14,                0xE000E438
    .equ NVIC_IPR15,                0xE000E43C
    .equ NVIC_IPR16,                0xE000E440
    .equ NVIC_IPR17,                0xE000E444
    .equ NVIC_IPR18,                0xE000E448
    .equ NVIC_IPR19,                0xE000E44C
    .equ NVIC_IPR20,                0xE000E450
    .equ NVIC_IPR21,                0xE000E454
    .equ NVIC_IPR22,                0xE000E458
    .equ NVIC_IPR23,                0xE000E45C
    .equ NVIC_IPR24,                0xE000E460
    .equ NVIC_IPR25,                0xE000E464
    .equ NVIC_IPR26,                0xE000E468
    .equ NVIC_IPR27,                0xE000E46C
    .equ NVIC_IPR28,                0xE000E470
    .equ NVIC_IPR29,                0xE000E474
    .equ NVIC_IPR30,                0xE000E478
    .equ NVIC_IPR31,                0xE000E47C
    .equ NVIC_IPR32,                0xE000E480
    .equ NVIC_IPR33,                0xE000E484
    .equ NVIC_IPR34,                0xE000E488
    .equ NVIC_IPR35,                0xE000E48C
    .equ NVIC_IPR36,                0xE000E490
    .equ NVIC_IPR37,                0xE000E494
    .equ NVIC_IPR38,                0xE000E498
    .equ NVIC_IPR39,                0xE000E49C
    .equ NVIC_IPR40,                0xE000E4A0
    .equ NVIC_IPR41,                0xE000E4A4
    .equ NVIC_IPR42,                0xE000E4A8
    .equ NVIC_IPR43,                0xE000E4AC
    .equ NVIC_IPR44,                0xE000E4B0
    .equ NVIC_IPR45,                0xE000E4B4
    .equ NVIC_IPR46,                0xE000E4B8
    .equ NVIC_IPR47,                0xE000E4BC
    .equ NVIC_IPR48,                0xE000E4C0
    .equ NVIC_IPR49,                0xE000E4C4
    .equ NVIC_IPR50,                0xE000E4C8
    .equ NVIC_IPR51,                0xE000E4CC
    .equ NVIC_IPR52,                0xE000E4D0
    .equ NVIC_IPR53,                0xE000E4D4
    .equ NVIC_IPR54,                0xE000E4D8
    .equ NVIC_IPR55,                0xE000E4DC
    .equ NVIC_IPR56,                0xE000E4E0
    .equ NVIC_IPR57,                0xE000E4E4
    .equ NVIC_IPR58,                0xE000E4E8
    .equ NVIC_IPR59,                0xE000E4EC

    .equ STIR,                      0xE000EF00
    
/* === SCU (System Control Unit) ========================================== */

    .equ SCU_BASE,                  0x40086000

    .equ SFSP0_0,                   0x0000
    .equ SFSP0_1,                   0x0004
	.equ SFSP0_2,					0x0008
    .equ SFSP0_3,                   0x000C
    .equ SFSP0_4,                   0x0010
	.equ SFSP0_5,					0x0014


    .equ SFSP1_0,                   0x0080
    .equ SFSP1_1,                   0x0084
    .equ SFSP1_2,                   0x0088
    .equ SFSP1_3,                   0x008C
    .equ SFSP1_4,                   0x0090
    .equ SFSP1_5,                   0x0094
    .equ SFSP1_6,                   0x0098
    .equ SFSP1_7,                   0x009C

    .equ SFSP2_0,                   0x0100
    .equ SFSP2_1,                   0x0104
    .equ SFSP2_2,                   0x0108
    .equ SFSP2_10,                  0x0128
    .equ SFSP2_11,                  0x012C
    .equ SFSP2_12,                  0x0130

    .equ PINTSEL0,                  0x0E00
    .equ PINTSEL1,                  0x0E04


    .equ SCU_SFSP0_0,               (SCU_BASE + SFSP0_0)
    .equ SCU_SFSP0_1,               (SCU_BASE + SFSP0_1)
	.equ SCU_SFSP0_2,               (SCU_BASE + SFSP0_2)
    .equ SCU_SFSP0_3,               (SCU_BASE + SFSP0_3)
	.equ SCU_SFSP0_4,               (SCU_BASE + SFSP0_4)
    .equ SCU_SFSP0_5,               (SCU_BASE + SFSP0_5)
	
	

    .equ SCU_SFSP1_0,               (SCU_BASE + SFSP1_0)
    .equ SCU_SFSP1_1,               (SCU_BASE + SFSP1_1)
    .equ SCU_SFSP1_2,               (SCU_BASE + SFSP1_2)
    .equ SCU_SFSP1_3,               (SCU_BASE + SFSP1_3)
    .equ SCU_SFSP1_4,               (SCU_BASE + SFSP1_4)
    .equ SCU_SFSP1_5,               (SCU_BASE + SFSP1_5)
    .equ SCU_SFSP1_6,               (SCU_BASE + SFSP1_6)

    .equ SCU_SFSP2_0,               (SCU_BASE + SFSP2_0)
    .equ SCU_SFSP2_1,               (SCU_BASE + SFSP2_1)
    .equ SCU_SFSP2_2,               (SCU_BASE + SFSP2_2)
    .equ SCU_SFSP2_10,              (SCU_BASE + SFSP2_10)
    .equ SCU_SFSP2_11,              (SCU_BASE + SFSP2_11)
    .equ SCU_SFSP2_12,              (SCU_BASE + SFSP2_11)

    .equ SCU_PINTSEL0,              (SCU_BASE + PINTSEL0)
    .equ SCU_PINTSEL1,              (SCU_BASE + PINTSEL1)

    .equ SCU_MODE_PULLUP,           (0x0 << 3)       /*!< Enable pull-up resistor at pad */
    .equ SCU_MODE_REPEATER,         (0x1 << 3)       /*!< Enable pull-down and pull-up resistor at resistor at pad (repeater mode) */
    .equ SCU_MODE_INACT,            (0x2 << 3)       /*!< Disable pull-down and pull-up resistor at resistor at pad */
    .equ SCU_MODE_PULLDOWN,         (0x3 << 3)       /*!< Enable pull-down resistor at pad */
    .equ SCU_MODE_HIGHSPEEDSLEW_EN, (0x1 << 5)       /*!< Enable high-speed slew */
    .equ SCU_MODE_INBUFF_EN,        (0x1 << 6)       /*!< Enable Input buffer */
    .equ SCU_MODE_ZIF_DIS,          (0x1 << 7)       /*!< Disable input glitch filter */
    .equ SCU_MODE_4MA_DRIVESTR,     (0x0 << 8)       /*!< Normal drive: 4mA drive strength */
    .equ SCU_MODE_8MA_DRIVESTR,     (0x1 << 8)       /*!< Medium drive: 8mA drive strength */
    .equ SCU_MODE_14MA_DRIVESTR,    (0x2 << 8)       /*!< High drive: 14mA drive strength */
    .equ SCU_MODE_20MA_DRIVESTR,    (0x3 << 8)       /*!< Ultra high- drive: 20mA drive strength */

    .equ SCU_MODE_FUNC0,            0x0
    .equ SCU_MODE_FUNC1,            0x1
    .equ SCU_MODE_FUNC2,            0x2
    .equ SCU_MODE_FUNC3,            0x3
    .equ SCU_MODE_FUNC4,            0x4
    .equ SCU_MODE_FUNC5,            0x5
    .equ SCU_MODE_FUNC6,            0x6
    .equ SCU_MODE_FUNC7,            0x7

/* === GPIO (General Porpouse Input Output) =============================== */

    .equ GPIO_BASE,                 0x400F4000

    .equ DIR0,                      0x2000
    .equ DIR1,                      0x2004
    .equ DIR2,                      0x2008
    .equ DIR3,                      0x200C
    .equ DIR4,                      0x2010
    .equ DIR5,                      0x2014
    .equ DIR6,                      0x2018
    .equ DIR7,                      0x201C

    .equ GPIO_DIR0,                 (GPIO_BASE + DIR0)
    .equ GPIO_DIR1,                 (GPIO_BASE + DIR1)
    .equ GPIO_DIR2,                 (GPIO_BASE + DIR2)
    .equ GPIO_DIR3,                 (GPIO_BASE + DIR3)
    .equ GPIO_DIR4,                 (GPIO_BASE + DIR4)
    .equ GPIO_DIR5,                 (GPIO_BASE + DIR5)
    .equ GPIO_DIR6,                 (GPIO_BASE + DIR6)
    .equ GPIO_DIR7,                 (GPIO_BASE + DIR7)

    .equ PIN0,                      0x2100 
    .equ PIN1,                      0x2104 
    .equ PIN2,                      0x2108 
    .equ PIN3,                      0x210C 
    .equ PIN4,                      0x2110 
    .equ PIN5,                      0x2114 
    .equ PIN6,                      0x2118 
    .equ PIN7,                      0x211C 

    .equ GPIO_PIN0,                 (GPIO_BASE + PIN0)
    .equ GPIO_PIN1,                 (GPIO_BASE + PIN1)
    .equ GPIO_PIN2,                 (GPIO_BASE + PIN2)
    .equ GPIO_PIN3,                 (GPIO_BASE + PIN3)
    .equ GPIO_PIN4,                 (GPIO_BASE + PIN4)
    .equ GPIO_PIN5,                 (GPIO_BASE + PIN5)
    .equ GPIO_PIN6,                 (GPIO_BASE + PIN6)
    .equ GPIO_PIN7,                 (GPIO_BASE + PIN7)

    .equ MPIN0,                     0x2180 
    .equ MPIN1,                     0x2184 
    .equ MPIN2,                     0x2188 
    .equ MPIN3,                     0x218C 
    .equ MPIN4,                     0x2190 
    .equ MPIN5,                     0x2194 
    .equ MPIN6,                     0x2198 
    .equ MPIN7,                     0x219C 

    .equ GPIO_MPIN0,                (GPIO_BASE + MPIN0)
    .equ GPIO_MPIN1,                (GPIO_BASE + MPIN1)
    .equ GPIO_MPIN2,                (GPIO_BASE + MPIN2)
    .equ GPIO_MPIN3,                (GPIO_BASE + MPIN3)
    .equ GPIO_MPIN4,                (GPIO_BASE + MPIN4)
    .equ GPIO_MPIN5,                (GPIO_BASE + MPIN5)
    .equ GPIO_MPIN6,                (GPIO_BASE + MPIN6)
    .equ GPIO_MPIN7,                (GPIO_BASE + MPIN7)

    .equ MASK0,                     0x2080 
    .equ MASK1,                     0x2084 
    .equ MASK2,                     0x2088 
    .equ MASK3,                     0x208C 
    .equ MASK4,                     0x2090 
    .equ MASK5,                     0x2094 
    .equ MASK6,                     0x2098 
    .equ MASK7,                     0x209C 

    .equ GPIO_MASK0,                (GPIO_BASE + MASK0)
    .equ GPIO_MASK1,                (GPIO_BASE + MASK1)
    .equ GPIO_MASK2,                (GPIO_BASE + MASK2)
    .equ GPIO_MASK3,                (GPIO_BASE + MASK3)
    .equ GPIO_MASK4,                (GPIO_BASE + MASK4)
    .equ GPIO_MASK5,                (GPIO_BASE + MASK5)
    .equ GPIO_MASK6,                (GPIO_BASE + MASK6)
    .equ GPIO_MASK7,                (GPIO_BASE + MASK7)

    .equ SET0,                      0x2200
    .equ SET1,                      0x2204
    .equ SET2,                      0x2208
    .equ SET3,                      0x220C
    .equ SET4,                      0x2210
    .equ SET5,                      0x2214
    .equ SET6,                      0x2218
    .equ SET7,                      0x221C

    .equ GPIO_SET0,                 (GPIO_BASE + SET0)
    .equ GPIO_SET1,                 (GPIO_BASE + SET1)
    .equ GPIO_SET2,                 (GPIO_BASE + SET2)
    .equ GPIO_SET3,                 (GPIO_BASE + SET3)
    .equ GPIO_SET4,                 (GPIO_BASE + SET4)
    .equ GPIO_SET5,                 (GPIO_BASE + SET5)
    .equ GPIO_SET6,                 (GPIO_BASE + SET6)
    .equ GPIO_SET7,                 (GPIO_BASE + SET7)

    .equ CLR0,                      0x2280
    .equ CLR1,                      0x2284
    .equ CLR2,                      0x2288
    .equ CLR3,                      0x228C
    .equ CLR4,                      0x2290
    .equ CLR5,                      0x2294
    .equ CLR6,                      0x2298
    .equ CLR7,                      0x229C

    .equ GPIO_CLR0,                 (GPIO_BASE + CLR0)
    .equ GPIO_CLR1,                 (GPIO_BASE + CLR1)
    .equ GPIO_CLR2,                 (GPIO_BASE + CLR2)
    .equ GPIO_CLR3,                 (GPIO_BASE + CLR3)
    .equ GPIO_CLR4,                 (GPIO_BASE + CLR4)
    .equ GPIO_CLR5,                 (GPIO_BASE + CLR5)
    .equ GPIO_CLR6,                 (GPIO_BASE + CLR6)
    .equ GPIO_CLR7,                 (GPIO_BASE + CLR7)

    .equ NOT0,                      0x2300
    .equ NOT1,                      0x2304
    .equ NOT2,                      0x2308
    .equ NOT3,                      0x230C
    .equ NOT4,                      0x2310
    .equ NOT5,                      0x2314
    .equ NOT6,                      0x2318
    .equ NOT7,                      0x231C

    .equ GPIO_NOT0,                 (GPIO_BASE + NOT0)
    .equ GPIO_NOT1,                 (GPIO_BASE + NOT1)
    .equ GPIO_NOT2,                 (GPIO_BASE + NOT2)
    .equ GPIO_NOT3,                 (GPIO_BASE + NOT3)
    .equ GPIO_NOT4,                 (GPIO_BASE + NOT4)
    .equ GPIO_NOT5,                 (GPIO_BASE + NOT5)
    .equ GPIO_NOT6,                 (GPIO_BASE + NOT6)
    .equ GPIO_NOT7,                 (GPIO_BASE + NOT7)

/* === PINT (Pin Individual Interrupt) ==================================== */

    .equ PINT_BASE,                 0x40087000

    .equ ISEL,                      0x0000
    .equ IENR,                      0x0004
    .equ SIENR,                     0x0008
    .equ CIENR,                     0x000C
    .equ IENF,                      0x0010
    .equ SIENF,                     0x0014
    .equ CIENF,                     0x0018
    .equ RISE,                      0x001C
    .equ FALL,                      0x0020
    .equ IST,                       0x0024

    .equ PINT_ISEL,                 (PINT_BASE + ISEL)
    .equ PINT_IENR,                 (PINT_BASE + IENR)
    .equ PINT_SIENR,                (PINT_BASE + SIENR)
    .equ PINT_CIENR,                (PINT_BASE + CIENR)
    .equ PINT_IENF,                 (PINT_BASE + IENF)
    .equ PINT_SIENF,                (PINT_BASE + SIENF)
    .equ PINT_CIENF,                (PINT_BASE + CIENF)
    .equ PINT_RISE,                 (PINT_BASE + RISE)
    .equ PINT_FALL,                 (PINT_BASE + FALL)
    .equ GPIO_IST,                  (PINT_BASE + IST)

/* === TIMER (Timers) ===================================================== */

    .equ CEN,                       (1 <<  0)
    .equ CRST,                      (1 <<  1)

    .equ MR0I,                      (1 <<  0)
    .equ MR0R,                      (1 <<  1)
    .equ MR0S,                      (1 <<  2)

    .equ MR1I,                      (1 <<  3)
    .equ MR1R,                      (1 <<  4)
    .equ MR1S,                      (1 <<  5)

    .equ MR2I,                      (1 <<  6)
    .equ MR2R,                      (1 <<  7)
    .equ MR2S,                      (1 <<  8)

    .equ MR3I,                      (1 <<  9)
    .equ MR3R,                      (1 << 10)
    .equ MR3S,                      (1 << 11)

    .equ TIMER0_BASE,               0x40084000
    .equ TIMER1_BASE,               0x40085000
    .equ TIMER2_BASE,               0x400C3000
    .equ TIMER3_BASE,               0x4004C000

    .equ IR,                        0x0000
    .equ TCR,                       0x0004
    .equ TC,                        0x0008
    .equ PR,                        0x000C
    .equ PCR,                       0x0010
    .equ MCR,                       0x0014
    .equ MR0,                       0x0018
    .equ MR1,                       0x001C
    .equ MR2,                       0x0020
    .equ MR3,                       0x0024
    .equ CCR,                       0x0028
    .equ CR0,                       0x002C
    .equ CR1,                       0x0030
    .equ CR2,                       0x0034
    .equ CR3,                       0x0038
    .equ EMR,                       0x003C
    .equ CTCR,                      0x0070

    .equ TIMER0_IR,                 (TIMER0_BASE + IR)
    .equ TIMER0_TCR,                (TIMER0_BASE + TCR)
    .equ TIMER0_TC,                 (TIMER0_BASE + TC)
    .equ TIMER0_PR,                 (TIMER0_BASE + PR)
    .equ TIMER0_PC,                 (TIMER0_BASE + PCR)
    .equ TIMER0_MCR,                (TIMER0_BASE + MCR)
    .equ TIMER0_MR0,                (TIMER0_BASE + MR0)
    .equ TIMER0_MR1,                (TIMER0_BASE + MR1)
    .equ TIMER0_MR2,                (TIMER0_BASE + MR2)
    .equ TIMER0_MR3,                (TIMER0_BASE + MR3)
    .equ TIMER0_CCR,                (TIMER0_BASE + CCR)
    .equ TIMER0_CR0,                (TIMER0_BASE + CR0)
    .equ TIMER0_CR1,                (TIMER0_BASE + CR1)
    .equ TIMER0_CR2,                (TIMER0_BASE + CR2)
    .equ TIMER0_CR3,                (TIMER0_BASE + CR3)
    .equ TIMER0_EMR,                (TIMER0_BASE + EMR)
    .equ TIMER0_CTCR,               (TIMER0_BASE + CTCR)

    .equ TIMER1_IR,                 (TIMER1_BASE + IR)
    .equ TIMER1_TCR,                (TIMER1_BASE + TCR)
    .equ TIMER1_TC,                 (TIMER1_BASE + TC)
    .equ TIMER1_PR,                 (TIMER1_BASE + PR)
    .equ TIMER1_PC,                 (TIMER1_BASE + PCR)
    .equ TIMER1_MCR,                (TIMER1_BASE + MCR)
    .equ TIMER1_MR0,                (TIMER1_BASE + MR0)
    .equ TIMER1_MR1,                (TIMER1_BASE + MR1)
    .equ TIMER1_MR2,                (TIMER1_BASE + MR2)
    .equ TIMER1_MR3,                (TIMER1_BASE + MR3)
    .equ TIMER1_CCR,                (TIMER1_BASE + CCR)
    .equ TIMER1_CR0,                (TIMER1_BASE + CR0)
    .equ TIMER1_CR1,                (TIMER1_BASE + CR1)
    .equ TIMER1_CR2,                (TIMER1_BASE + CR2)
    .equ TIMER1_CR3,                (TIMER1_BASE + CR3)
    .equ TIMER1_EMR,                (TIMER1_BASE + EMR)
    .equ TIMER1_CTCR,               (TIMER1_BASE + CTCR)

    .equ TIMER2_IR,                 (TIMER2_BASE + IR)
    .equ TIMER2_TCR,                (TIMER2_BASE + TCR)
    .equ TIMER2_TC,                 (TIMER2_BASE + TC)
    .equ TIMER2_PR,                 (TIMER2_BASE + PR)
    .equ TIMER2_PC,                 (TIMER2_BASE + PCR)
    .equ TIMER2_MCR,                (TIMER2_BASE + MCR)
    .equ TIMER2_MR0,                (TIMER2_BASE + MR0)
    .equ TIMER2_MR1,                (TIMER2_BASE + MR1)
    .equ TIMER2_MR2,                (TIMER2_BASE + MR2)
    .equ TIMER2_MR3,                (TIMER2_BASE + MR3)
    .equ TIMER2_CCR,                (TIMER2_BASE + CCR)
    .equ TIMER2_CR0,                (TIMER2_BASE + CR0)
    .equ TIMER2_CR1,                (TIMER2_BASE + CR1)
    .equ TIMER2_CR2,                (TIMER2_BASE + CR2)
    .equ TIMER2_CR3,                (TIMER2_BASE + CR3)
    .equ TIMER2_EMR,                (TIMER2_BASE + EMR)
    .equ TIMER2_CTCR,               (TIMER2_BASE + CTCR)

    .equ TIMER3_IR,                 (TIMER3_BASE + IR)
    .equ TIMER3_TCR,                (TIMER3_BASE + TCR)
    .equ TIMER3_TC,                 (TIMER3_BASE + TC)
    .equ TIMER3_PR,                 (TIMER3_BASE + PR)
    .equ TIMER3_PC,                 (TIMER3_BASE + PCR)
    .equ TIMER3_MCR,                (TIMER3_BASE + MCR)
    .equ TIMER3_MR0,                (TIMER3_BASE + MR0)
    .equ TIMER3_MR1,                (TIMER3_BASE + MR1)
    .equ TIMER3_MR2,                (TIMER3_BASE + MR2)
    .equ TIMER3_MR3,                (TIMER3_BASE + MR3)
    .equ TIMER3_CCR,                (TIMER3_BASE + CCR)
    .equ TIMER3_CR0,                (TIMER3_BASE + CR0)
    .equ TIMER3_CR1,                (TIMER3_BASE + CR1)
    .equ TIMER3_CR2,                (TIMER3_BASE + CR2)
    .equ TIMER3_CR3,                (TIMER3_BASE + CR3)
    .equ TIMER3_EMR,                (TIMER3_BASE + EMR)
    .equ TIMER3_CTCR,               (TIMER3_BASE + CTCR)
