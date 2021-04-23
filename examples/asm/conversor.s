    .cpu cortex-m4              // Indica el procesador de destino  
    .syntax unified             // Habilita las instrucciones Thumb-2
    .thumb                      // Usar instrucciones Thumb y no ARM

/****************************************************************************/
/* Definicion de variables globales                                         */
/****************************************************************************/

    .section .data              // Define la sección de variables (RAM) 
origen:     
    .byte 6,2,8,5,7             // Variable inicializada de 5 bytes
    .space 15,0xFF              // Completo los 20 lugares de origen con 0xFF
destino:    
    .space 20,0x00              // Variable de 20 bytes en blanco

/****************************************************************************/
/* Programa principal                                                       */
/****************************************************************************/

    .section .text          // Define la sección de código (FLASH)
    .global reset           // Define el punto de entrada del código
    .func main              // Inidica al depurador el inicio de una funcion

reset:
    LDR  R0,=origen         // Apunta R0 al bloque de origen
    LDR  R1,=destino        // Apunta R1 al bloque de destino
    ADR  R3,tabla           // Apunta R3 al bloque con la tabla
lazo:
    LDRB R2,[R0],#1         // Carga en R2 el elemento a convertir
    CMP  R2,0xFF            // Determina si es el fin de conversión
    BEQ  final              // Terminar si es fin de conversión
    LDRB R2,[R3,R2]         // Cargar en R2 el elemento convertido
    STRB R2,[R1],#1         // Guardar el elemento convertido 
    B    lazo               // Repetir el lazo de conversión
final:
    STRB R2,[R1]            // Guardar el fin de conversión en destino
stop:
    B    stop               // Lazo infinito para terminar la ejecución

    .pool                   // Almacenar las constantes de código

tabla:                      // Define la tabla de conversión 
    .byrenoce,0xF6      
    .endfunc
