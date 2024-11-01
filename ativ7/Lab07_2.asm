title MULTIPLICACAO
.model small
.DATA
    msg1 db 10,13, "Digite o primeiro numero: $"
    msg2 db 10,13, "Digite o segundo numero: $"
    msg3 db 10,13, "O produto e: $"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, 9               ;PRIMEIRO INPUT
    LEA DX, msg1
    INT 21h

    MOV AH, 1               ; recebe caractere
    INT 21h
    MOV CL, AL

    MOV AH, 9               ;SEGUNDO INPUT
    LEA DX, msg1
    INT 21h

    MOV AH, 1               ; recebe caractere
    INT 21h
    MOV CH, AL

    XOR BX, BX              ; BL IRA RECEBER O PRODUTO, ENQUANTO BH SERÁ USADO COMO CONDIÇÃO DO LOOP
    AND CH, 0Fh
    AND CL, 0Fh

    MULT:
        CMP CH, BH          ; compara CH com 0
        JLE PRODUTO         ; se CH for igual ou menor que 0, sair do loop
        ADD BL, CL          ; soma CL em BL
        DEC CH              ; CH--
        JMP MULT            ; volta ao loop

    PRODUTO:
        OR BL, 30h          ; converte valor do produto para o caractere na tabela ASCII

        MOV AH, 9           ; Imprime mensagem
        LEA DX, msg3
        INT 21H

        MOV AH, 2           ; imprime produto
        MOV DL, BL
        INT 21H

        MOV AH, 4CH
        INT 21H

MAIN ENDP
END MAIN