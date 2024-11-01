title REPEAT
.MODEL small
.DATA
    MSG1 DB 10, 13, "Digite um caractere: $"

.CODE
MAIN PROC
    MOV AX, @DATA           ; IMPORTA AS MENSAGENS
    MOV DS, AX

    MOV CL, 0               ; CONTADOR DOS CARACTERES

    LEITURA:
    MOV AH, 9
    LEA DX, MSG1            ; IMPRIME A MENSAGEM PEDINDO CARACTERE
    INT 21h

    MOV AH, 1H              ; RECEBE O CARACTERE
    INT 21H
    
    INC CL                  ; INCREMENTA O CONTADOR DE CARACTERES
    CMP AL, 13              ; COMPARA O INPUT DO USUÁRIO COM O CR
    JNZ LEITURA             ; SE FOR DIFERENTE DE CR, VOLTE NO LOOP

    MOV AH, 2               ; COMANDO PARA IMPRIMIR CARACTERE
    MOV DL, '*'             ; COLOCA '*' EM DL PARA IMPRIMIR A CADA INT 21H

    IMPRIMIR:
        INT 21h             ; IMPRIME '*' ATÉ O CL SER 0
    LOOP IMPRIMIR           ; AUTOMATICAMENTE DECREMENTA CL

    FIM:
    MOV AH, 4CH
    INT 21h
 MAIN ENDP
 END MAIN


; A diferença entra a parte 1 (WHILE) e a parte 2 (REPEAT), se deve à posição do comparador e do jump.
; No WHILE, após receber o caracter, o CMP e JZ comparam se o input é igual a CR, caso não seja, incrementa o CL e volta o loop.
; Por outro lado, no REPEAT, o incremento ocorre antes da comparação. Ademais, o CMP e JNZ comparam se o input é diferente de CR para recomeçar o loop.
; Em suma, na segunda parte o incremento é contado tanto para os caracteres, quanto para o enter, imprimindo uma '*' a mais  