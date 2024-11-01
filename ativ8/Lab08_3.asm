title LerHexa
.model small
.DATA
    MSG DB 10,13, "Digite um numero hexadecimal de 4 digitos (por exemplo: 1A11h): $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 9
    LEA DX, MSG
    INT 21H

    XOR BX, BX
    MOV AH, 1
    INPUT:
        INT 21H                     ;RECEBE UM CARACTERE
        CMP AL, 0DH                 ;COMPARA INPUT COM CR
        JZ SAIDA                    ;SE CR --> SAIR DO LOOP
        SHL Bx, 4                   ;DESLOCA PARA O PRÓXIMO DÍGITO HEXADECIMAL
        CMP AL, 39H                 ;COMPARA INPUT COM '9'
        JG LETRA                    ;SE INPUT FOR MAIOR QUE '9', ASSUME-SE QUE É UMA LETRA MAIUSCULA
        AND AL, 0Fh                 ;CONVERTE DE CARACTERE NUMERICO  PARA UM NUMERO
        JMP SOMA
        LETRA:
            SUB AL, 37H             ;CONVERTE DE LETRA MAIUSCULA PARA SEU VALOR EM HEXADECIMAL
        SOMA:
            OR BL, AL               ;SOMA EM BX O NÚMERO RECÉM CONVERTIDO
        LOOP INPUT

    SAIDA:
        MOV AH, 4CH
        INT 21H

MAIN ENDP
END MAIN