title LerBinario
.model small
.DATA
    MSG1 DB 10,13, "Digite 0s e 1s para formar um número binário (para parar o input, presssione enter sem ter digitado um número): $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    XOR BX,BX                       ;ZERA BX
    MOV AH, 9                       ;IMPRIME MENSAGEM
    LEA DX, MSG1
    INT 21H

    MOV AH, 1

    INPUT:
        INT 21H                     ;RECEBE UM CARACTERE
        CMP AL, 0DH                 ;COMPARA INPUT COM CR
        JZ SAIDA                    ;SE CR --> SAIR DO LOOP
        AND AL, 0Fh                 ;CONVERTE CARACTERE PARA NUMERO
        SHL BX, 1                   ;DESLOCA BX 1 BIT PARA A ESQUERDA 
        ADD BL, AL                  ;SOMA O NUMERO DIGITADO EM BX
        JMP INPUT                   ;VOLTA O LOOP
    SAIDA:
        MOV AH, 4CH
        INT 21H
MAIN ENDP
END MAIN