title Letra ou Numero
.MODEL SMALL
.STACK 100h
.DATA
    MSG01 DB "Digite um caractere: $"
    MSG02 DB 10,13, "O caractere digitado e um numero. $"
    MSG03 DB 10,13, "O caractere digitado e uma letra. $"
    MSG04 DB 10,13, "O caractere digitado e um caractere desconhecido. $"
.CODE
MAIN PROC
           MOV AX,@DATA
           MOV DS,AX

           MOV AH,9
           MOV DX, OFFSET MSG01
           INT 21h

           MOV AH,1
           INT 21h

           MOV BL,AL

           CMP BL, 48 ;Checa se o caractere tem valor menor do que "0"
           JB ERRADO ;"caractere inválido"

           CMP BL, 57 ;checa se o caractere tem valor menor ou igual a "9"
           JBE NUM ;imprime que é um número

           CMP BL, 'A' ;Checa se o caractere tem valor menor do que "A"
           JB ERRADO ;"caracterere invalido"

           CMP BL, 'Z' ;Checa se o caractere tem valor menor ou igual a "Z"
           JBE LETRA

           CMP BL, 'a' ;Checa se o caractere tem valor menor do que "a"
           JB ERRADO ;"caracterere invalido"

           CMP BL, 'z' ;Checa se o caractere tem valor menor ou igual a "z"
           JBE LETRA
           
    NUM:   
           MOV AH, 9
           MOV DX, OFFSET MSG02
           INT 21h
           JMP FIM

    LETRA: 
           MOV AH, 9
           MOV DX, OFFSET MSG03
           INT 21h
           JMP FIM

    ERRADO:
           MOV AH,9
           MOV DX, OFFSET MSG04
           INT 21h

    FIM:   
           MOV AH, 4ch
           INT 21H

MAIN ENDP
END MAIN