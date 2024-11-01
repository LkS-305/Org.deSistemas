title Ler e Imprimir Hexadecimal
.model small
.STACK 100H
.DATA
    MSG1 DB 10,13, "Digite um numero hexadecimal de 4 digitos (por exemplo: 1A11h): $"
    MSG2 DB 10,13, "O numero digitato foi: $"

    TABELA     DB 30H, 31H, 32H, 33H, 34H, 35H, 36H, 37H, 38H, 39H             ;TABELA DE CONVERSÃO NÚMEROS
                DB 41H, 42H, 43H, 44H, 45H, 46H                                 ;TABELA DE CONVERSÃO LETRA MAIUSCULA

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

;ler um número
    MOV AH, 9
    LEA DX, MSG1
    INT 21H

    XOR BX, BX
    MOV AH, 1
    INPUT:
        INT 21H                     ;RECEBE UM CARACTERE
        CMP AL, 0DH                 ;COMPARA INPUT COM CR
        JZ SAIDA                    ;SE CR --> SAIR DO LOOP
        SHL BX, 4                   ;DESLOCA PARA O PRÓXIMO DÍGITO HEXADECIMAL
        CMP AL, 39H                 ;COMPARA INPUT COM '9'
        JG LETRA                    ;SE INPUT FOR MAIOR QUE '9', ASSUME-SE QUE É UMA LETRA MAIUSCULA
        AND AL, 0Fh                 ;CONVERTE DE CARACTERE NUMERICO PARA UM NUMERO
        JMP SOMA
        LETRA:
            SUB AL, 37H             ;CONVERTE DE LETRA MAIUSCULA PARA SEU VALOR EM HEXADECIMAL
        SOMA:
            OR BL, AL               ;SOMA EM BX O NÚMERO RECÉM CONVERTIDO
        LOOP INPUT

;Imprime o número digitado
    SAIDA:
    MOV AH, 9
    LEA DX, MSG2
    INT 21H

    MOV CX, 4                       ;LOOP RODA 4 VEZES (4 DIGITOS HEXA EM UMA PALAVRA DE 16-BITS)
    MOV AH, 2

    OUTPUT:
        MOV DL, BH                  
        SHR DL, 4                   ;DESLOCA O DÍGITO HEXADECIMAL PARA A DIREITA (RESTA APENAS UM DÍGITO EM DL) (DÍGITO RESTANTE ERA O MAIS SIGNIFICATIVO EM BX)

        PUSH BX                     ;GUARDA VALOR DE BX NA PILHA
        LEA BX, TABELA              ;COLOCA OFFSET DO ENDEREÇO EM BX
        XCHG AL, DL                 ;TROCA CONTEÚDO DE AL E DL (ENVIA O CARACTERE A SER CONVERTIDO PARA AL)
        XLAT                        ;CONVERTE CONTEÚDO DE AL PARA CARACTERE
        XCHG AL, DL                 ;TROCA CONTEÚDO DE AL E DL
        POP BX                      ;RETORNA VALOR DE BX DA PILHA
        IMPRIME:
            SHL BX, 4               ;DESLOCA BX 4 BITS PARA A ESQUERDA
            INT 21H                 ;IMPRIME CARACTERE ARMAZENADO EM DL
    LOOP OUTPUT

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN