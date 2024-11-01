title WHILE
.model small
.DATA
    MSG1 DB 10, 13, "Digite um caractere: $"

.CODE
MAIN PROC
    MOV AX, @DATA           ; IMPORTA AS MENSAGENS
    MOV DS, AX

    MOV CL, 0               ; CONTADOR DOS CARACTERES

    leitura:
    MOV AH, 9
    LEA DX, MSG1            ; IMPRIME A MENSAGEM PEDINDO CARACTERE
    INT 21h

    MOV AH, 1H              ; RECEBE O CARACTERE
    INT 21H
    
    CMP AL, 13              ; COMPARA O INPUT DO USUÁRIO COM O CR
    JZ SAIDA                ; SE SIM, SAIA DO LOOP
    INC CL                  ; INCREMENTA O CONTADOR DE CARACTERES
    JMP leitura             ; VOLTA O LOOP

    SAIDA:                  ; MOVER O AH E DL, PARA IMPRIMIR O '*'
    MOV AH, 2
    MOV DL, '*'

    IMPRIMIR:
        INT 21h             ; IMPRIME '*' ATÉ O CL SER 0
    LOOP IMPRIMIR           ; AUTOMATICAMENTE DECREMENTA CL E VOLTA O LOOP

    FIM:                    ; ENCERRA O PROGRAMA
    MOV AH, 4CH
    INT 21h

MAIN ENDP
END MAIN