title ImprimeBinario
.model small
.DATA
    MSG DB 10,13, "Numero binario: $"

.CODE
MAIN PROC
    MOV BX, 0FFFFH                      ;REGISTRADOR DE ARMAZENAMENTO
    MOV CX, 16                          ;LER OS 16 BITS DA PALAVRA
    MOV AH, 2
    FOR:
        SHL BX, 1                       ;DESLOCA BX 1 BIT PARA A ESQUERDA
        JC UM                           ;SE OCORREU CARRY (MSB FOR IGUAL A 1), SALTA PARA 'UM'
        MOV DL, '0'                       ;SE MSB FOR IGUAL A 0, DL = 0
        JMP IMPRIME
        UM:
            MOV DL, '1'
        IMPRIME:
            INT 21H                     ;IMPRIME O BIT
    LOOP FOR

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN