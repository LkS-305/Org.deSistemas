title Ler e Imprimir Binario
.model small
.DATA
    MSG1 DB 10,13, "Digite 0s e 1s para formar um número binário (para parar o input, presssione enter): $"

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
        OR BL, AL                   ;SOMA EM BX O NUMERO DIGITADO
        JMP INPUT                   ;VOLTA O LOOP
    
    SAIDA:
        MOV CX, 16                      ;LER OS 16 BITS DA PALAVRA
        MOV AH, 2
        FOR:
            SHL BX, 1                   ;DESLOCA BX 1 BIT PARA A ESQUERDA
            JC UM                       ;SE OCORREU CARRY (MSB FOR IGUAL A 1), SALTA PARA 'UM'
            MOV DL, '0'                 ;SE MSB FOR IGUAL A 0, DL = 0
            JMP IMPRIME
            UM:
                MOV DL, '1'
            IMPRIME:
                INT 21H                 ;IMPRIME O BIT
        LOOP FOR

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN