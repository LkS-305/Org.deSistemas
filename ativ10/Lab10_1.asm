title IMPRIMIR MATRIZ 4X4
.MODEL SMALL
PULAR_LINHA MACRO
    PUSH DX
    PUSH AX
    MOV AL, 2
    MOV DL, 10
    INT 21H
    POP AX
    POP DX
ENDM

PUSHALL MACRO
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI
    PUSH SI
ENDM

POPALL MACRO
    POP SI
    POP DI
    POP DX
    POP CX
    POP BX
    POP AX
ENDM

.DATA
    MATRIZ  DB 1,2,3,4
            DB 4,3,2,1
            DB 5,6,7,8
            DB 8,7,6,5
.STACK 100H

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA BX, MATRIZ
    CALL PRINT

    MOV AH, 4CH
    INT 21H
MAIN ENDP

;PROCEDIMENTO QUE IMPRIME UMA MATRIZ 4X4, QUE CONTEM NÚMERO E CUJO ENDEREÇO ESTÁ EM BX
PRINT PROC
    PUSHALL
    MOV AH, 2
    MOV DI, BX                      ;USADO COMO COMPARADOR PARA O ÍNDICE DE BX NA ÚLTIMA FILEIRA
    ADD DI, 12
    FILEIRA:
    XOR SI,SI
    MOV CX, 4
    IMPRIMIR:                       ;LOOP QUE IMPRIME OS 4 NÚMEROS EM UMA FILEIRA
        MOV DX, [BX][SI]            ;MOVE ELEMENTO DA MATRIZ PARA O REGISTRADOR
        OR DL, 30H                  ;CONVERTE EM NÚMERO
        INT 21H                     ;IMPRIME NUMERO
        MOV DL, 20H                  ;IMPRIME UM ESPAÇO
        INT 21H
        INC SI
        LOOP IMPRIMIR
        PULAR_LINHA
        ADD BX, SI
        CMP BX, DI                  ;REALIZA COMPARAÇÃO ENTRE A POSIÇÃO ATUAL DE BX E A POSIÇÃO DA ÚLTIMA FILEIRA
        JLE FILEIRA                 ;SAI DO LOOP APÓS IMPRIMIR OS NÚMEROS DA ÚLTIMA FILEIRA, QUANDO BX SERÁ 16 A MAIS QUE O VALOR INICIAL
    POPALL
    RET
PRINT ENDP
END MAIN