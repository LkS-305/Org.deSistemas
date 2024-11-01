title COLUNA_ALFABETO
.model small
PULA_LINHA MACRO                    ; macro para pular linha e enviar cursor para a esquerda
    XCHG DL, DH                     ; para evitar perder o valor em DL, o envia para DH
    MOV AH, 2
    MOV DL, 10
    INT 21h
    MOV DL, 13                      ; pula a linha
    INT 21h
    XCHG DL, DH                     ; retorna o valor original para DL
ENDM
.CODE
MAIN PROC 

    MOV AH, 2                       ; imprimir letra
    MOV DL, 'a'                     ; começa pela primeira letra do alfabeto
    LINHAS:                         ; atua como um while, até imprimir o 'z'
        MOV CX, 4                   ; define CX para o loop 
        LETRAS:                     ; atua como um FOR para imprimir as quatro letras
            CMP DL, 'z'             ; checa se já foi impresso o 'z'
            JG FIM                  ; caso sim, pula para o fim do programa
            INT 21h                 ; imprime a letra atual
            INC DL                  ; atualiza DL para a próxima letra
            LOOP LETRAS             ; repete até imprimir quatro letras
        PULA_LINHA                  ; macro para pular linha
        LOOP LINHAS

    FIM:                            ; finaliza o programa
        MOV AH, 4CH
        INT 21h

MAIN ENDP
END MAIN