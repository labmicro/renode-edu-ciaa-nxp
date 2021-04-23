/* Copyright 2016, 
 * Leandro D. Medus
 * lmedus@bioingenieria.edu.ar
 * Eduardo Filomena
 * efilomena@bioingenieria.edu.ar
 * Juan Manuel Reta
 * jmrera@bioingenieria.edu.ar
 * Facultad de Ingeniería
 * Universidad Nacional de Entre Ríos
 * Argentina
 *
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
 *
 */

/** \brief Bare Metal driver for uart in the EDU-CIAA board.
 **
 **/

/*
 * Initials     Name
 * ---------------------------
 *	LM			Leandro Medus
 *  EF			Eduardo Filomena
 *  JMR			Juan Manuel Reta
 */

/*
 * modification history (new versions first)
 * -----------------------------------------------------------
 * 20160422 v0.1 initials initial version leo
 * 20160807 v0.2 modifications and improvements made by Eduardo Filomena
 * 20160808 v0.3 modifications and improvements made by Juan Manuel Reta
 */

/*==================[inclusions]=============================================*/
#include "uart.h"

/*==================[macros and definitions]=================================*/

#define DELAY_CHARACTER 500000

/* UART0 (RS485/Profibus) */

#define RS485_TXD_MUX_GROUP   9
#define RS485_RXD_MUX_GROUP   9

#define RS485_TXD_MUX_PIN   5
#define RS485_RXD_MUX_PIN   6


/* UART2 (USB-UART) */
#define UART_USB_TXD_MUX_GROUP   7
#define UART_USB_RXD_MUX_GROUP   7

#define UART_USB_TXD_MUX_PIN   1
#define UART_USB_RXD_MUX_PIN   2


/* UART3 (RS232) */

#define RS232_TXD_MUX_GROUP   2
#define RS232_RXD_MUX_GROUP   2

#define RS232_TXD_MUX_PIN   3
#define RS232_RXD_MUX_PIN   4



/*==================[internal data declaration]==============================*/

/*==================[internal functions declaration]=========================*/

/*==================[internal data definition]===============================*/

/*==================[external data definition]===============================*/

/*==================[internal functions definition]==========================*/

/*==================[external functions definition]==========================*/
/** \brief ADC Initialization method  */
uint32_t Init_Uart_Ftdi(void)
{

	/** \details
	 * This function initialize the ADC peripheral in the EDU-CIAA board,
	 * with the correct parameters with LPCOpen library. It uses CH1
	 *
	 * \param none
	 *
	 * \return uint8_t: TBD (to support errors in the init function)
	 * */


	/* UART2 (USB-UART) */
	Chip_UART_Init(USB_UART);
	Chip_UART_SetBaud(USB_UART, 115200);

	Chip_UART_SetupFIFOS(USB_UART, UART_FCR_FIFO_EN | UART_FCR_TRG_LEV0);

	Chip_UART_TXEnable(USB_UART);

	Chip_SCU_PinMux(UART_USB_TXD_MUX_GROUP, UART_USB_TXD_MUX_PIN, MD_PDN, FUNC6);              /* P7_1: UART2_TXD */
	Chip_SCU_PinMux(UART_USB_RXD_MUX_GROUP, UART_USB_RXD_MUX_PIN, MD_PLN|MD_EZI|MD_ZI, FUNC6); /* P7_2: UART2_RXD */

	/* UART3 (RS232) */
	Chip_UART_Init(RS232_UART);
	Chip_UART_SetBaud(RS232_UART, 115200);

	Chip_UART_SetupFIFOS(RS232_UART, UART_FCR_FIFO_EN | UART_FCR_TRG_LEV0);

	Chip_UART_TXEnable(LPC_USART3);

	Chip_SCU_PinMux(RS232_TXD_MUX_GROUP, RS232_TXD_MUX_PIN, MD_PDN, FUNC2);              /* P2_3: UART3_TXD */
	Chip_SCU_PinMux(RS232_RXD_MUX_GROUP, RS232_RXD_MUX_PIN, MD_PLN|MD_EZI|MD_ZI, FUNC2); /* P2_4: UART3_RXD */

	return TRUE;
}

uint32_t Init_Uart_Rs485(void)
{

	/** \details
	 * This function initialize the ADC peripheral in the EDU-CIAA board,
	 * with the correct parameters with LPCOpen library. It uses CH1
	 *
	 * \param none
	 *
	 * \return uint8_t: TBD (to support errors in the init function)
	 * */

	/*UART initialization*/

	/* UART0 (RS485/Profibus) */
	Chip_UART_Init(RS485_UART);
	Chip_UART_SetBaud(RS485_UART, 115200);

	Chip_UART_SetupFIFOS(RS485_UART, UART_FCR_FIFO_EN | UART_FCR_TRG_LEV0);

	Chip_UART_TXEnable(RS485_UART);

	Chip_SCU_PinMux(RS485_TXD_MUX_GROUP, RS485_TXD_MUX_PIN, MD_PDN, FUNC7);              /* P9_5: UART0_TXD */
	Chip_SCU_PinMux(RS485_RXD_MUX_GROUP, RS485_RXD_MUX_PIN, MD_PLN|MD_EZI|MD_ZI, FUNC7); /* P9_6: UART0_RXD */

	Chip_UART_SetRS485Flags(RS485_UART, UART_RS485CTRL_DCTRL_EN | UART_RS485CTRL_OINV_1);

	Chip_SCU_PinMux(6, 2, MD_PDN, FUNC2);              /* P6_2: UART0_DIR */

	return TRUE;
}

uint32_t Init_Uart_Rs232(void)
{

	/** \details
	 * This function initialize the ADC peripheral in the EDU-CIAA board,
	 * with the correct parameters with LPCOpen library. It uses CH1
	 *
	 * \param none
	 *
	 * \return uint8_t: TBD (to support errors in the init function)
	 * */

	/*UART initialization*/

	/* UART3 (RS232) */
	Chip_UART_Init(RS232_UART);
	Chip_UART_SetBaud(RS232_UART, 115200);

	Chip_UART_SetupFIFOS(RS232_UART, UART_FCR_FIFO_EN | UART_FCR_TRG_LEV0);

	Chip_UART_TXEnable(RS232_UART);

	Chip_SCU_PinMux(RS232_TXD_MUX_GROUP, RS232_TXD_MUX_PIN, MD_PDN, FUNC2);              /* P2_3: UART3_TXD */
	Chip_SCU_PinMux(RS232_TXD_MUX_GROUP, RS232_RXD_MUX_PIN, MD_PLN|MD_EZI|MD_ZI, FUNC2); /* P2_4: UART3_RXD */

	return TRUE;
}

uint32_t ReadStatus_Uart_Rs232(void)
{
	return Chip_UART_ReadLineStatus((LPC_USART_T *)LPC_USART3) & UART_LSR_THRE;
}

uint32_t ReadStatus_Uart_Ftdi(void)
{
	return Chip_UART_ReadLineStatus((LPC_USART_T *)LPC_USART2) & UART_LSR_THRE;

}
uint32_t ReadRxReady_Uart_Ftdi(void)
{
	return Chip_UART_ReadLineStatus( (LPC_USART_T *)LPC_USART2) & UART_LSR_RDR;
}

uint32_t ReadRxReady_Uart_Rs232(void)
{
	return Chip_UART_ReadLineStatus( (LPC_USART_T *)LPC_USART3) & UART_LSR_RDR;
}


uint8_t ReadByte_Uart_Ftdi(uint8_t* dat)
{
	if (ReadRxReady_Uart_Ftdi())
	{
		*dat = Chip_UART_ReadByte((LPC_USART_T *)LPC_USART2);
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

uint8_t ReadByte_Uart_Rs232(uint8_t* dat)
{
	if (ReadRxReady_Uart_Rs232())
	{
		*dat = Chip_UART_ReadByte((LPC_USART_T *)LPC_USART3);
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}


void SendString_Uart_Ftdi(uint8_t* msg)
{
	/* sending byte by byte*/
	while(*msg != 0)
	{
		while(ReadStatus_Uart_Ftdi() == 0);
		Chip_UART_SendByte((LPC_USART_T *)LPC_USART2, (uint8_t)*msg);
		msg++;
	}
}

void SendByte_Uart_Ftdi(uint8_t* dat)
{
	while(ReadStatus_Uart_Ftdi() == 0);
	Chip_UART_SendByte((LPC_USART_T *)LPC_USART2, *dat);
}
void SendByte_Uart_Rs232(uint8_t* dat)
{
	while(ReadStatus_Uart_Rs232() == 0);
	Chip_UART_SendByte((LPC_USART_T *)LPC_USART3, *dat);
}

void SendString_Uart_Rs232(uint8_t* msg)
{
	/* sending byte by byte*/
	while(*msg != 0)
	{
		while(ReadStatus_Uart_Rs232() == 0);
		Chip_UART_SendByte((LPC_USART_T *)LPC_USART3, (uint8_t) *msg);
		msg++;
	}
}

void IntToString(int16_t value, uint8_t* pBuf, uint32_t len, uint32_t base)
{
	/**
	 * \details
	 * Conversion method to obtain a character or a string from a float to send
	 * throw UART peripheral.
	 * */
    static const char* pAscii = "0123456789abcdefghijklmnopqrstuvwxyz";
    int pos = 0;
    int tmpValue = value;

    /*  the buffer must not be null and at least have a length of 2 to handle one */
    /*  digit and null-terminator */
    if (pBuf == NULL || len < 2)
    {
        return;
    }

    /* a valid base cannot be less than 2 or larger than 36 */
    /* a base value of 2 means binary representation. A value of 1 would mean only zeros */
    /*  a base larger than 36 can only be used if a larger alphabet were used. */
    if (base < 2 || base > 36)
    {
        return;
    }

    /* negative value */
    if (value < 0)
    {
        tmpValue = -tmpValue;
        value    = -value;
        pBuf[pos++] = '-';
    }

    /* calculate the required length of the buffer */
    do {
        pos++;
        tmpValue /= base;
    } while(tmpValue > 0);


    if (pos > len)
    {
    	/* the len parameter is invalid. */
        return;
    }

    pBuf[pos] = '\0';

    do {
        pBuf[--pos] = pAscii[value % base];
        value /= base;
    } while(value > 0);

    return;
}

/** @} doxygen end group definition */
/** @} doxygen end group definition */
/** @} doxygen end group definition */
/*==================[end of file]============================================*/
