title ALFABETO
.model small
.DATA
.CODE
MAIN PROC 
    MOV AH, 2
    MOV DL, 'A'

    MOV CX, 26
    MAIUSCULA: ;loop para imprimir as letras maiúsculas
        INT 21h
        INC DL ;passa para a próxima letra maiuscula
        LOOP MAIUSCULA

    MOV DL, 10 
    INT 21h
    MOV DL, 13 ;pula a linha e envia cursor para a esquerda
    INT 21h

    MOV CX, 26
    MOV DL, 'a'
    MINUSCULA:
        INT 21H
        INC DL ; próxima letra minuscula
        LOOP MINUSCULA

    MOV AH, 4CH
    INT 21h
MAIN ENDP
END MAIN