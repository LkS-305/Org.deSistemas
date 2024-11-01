title ImprimitHexa
.model small
.DATA
    MSG DB 10,13, "O numero digitato foi: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 9
    LEA DX, MSG
    INT 21H
    MOV BX, 1234H

    MOV CX, 4                       ;LOOP RODA 4 VEZES (4 DIGITOS HEXA EM UMA PALAVRA DE 16-BITS)
    MOV AH, 2
    SAIDA:
        MOV DL, BH
        SHR DL, 4                   ;DESLOCA O DÍGITO HEXADECIMAL PARA A DIREITA (RESTA APENAS O DÍGITO MAIS SIGNIFICATIVO EM DL)
        CMP DL, 0Ah                 ;COMPARA DIGITO MAIS SIGNIFICATIVO COM 10
        JL NUMERO                   ;SE INPUT FOR MENOR QUE 10, SALTA
        ADD DL, 37H                 ;CONVERTE DE NUMERO PARA UM CARACTERE (DE 'A' a 'F')
        JMP IMPRIME
        NUMERO:
            OR DL, 30H              ;CONVERTE DE NUMERO PARA CARACTERE NUMERICO
        IMPRIME:
            SHL BX, 4
            INT 21H
    LOOP SAIDA

        MOV AH, 4CH
        INT 21H

MAIN ENDP
END MAIN