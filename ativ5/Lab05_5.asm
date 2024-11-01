title SOMA
.model small
.DATA
    msg1 db 10, 13, "Digite um numero de 0 a 9: .$"
    msg2 db 10, 13, "A soma dos valores digitados e: .$"
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV BL, 0
    MOV CX, 5                           ; determina quantas vezes o loop roda

    SOMA:                               ; recebe 5 números e salva a soma em BL
        MOV AH, 9                       ; imprime a primeira mensagem
        LEA DX, MSG1
        INT 21H

        MOV AH, 1                       ; guarda o numero recebido em AL
        INT 21H
        SUB AL, "0"                     ; converte o número na tabela ascii para apenas o número digitado
        ADD BL, AL                      ; soma o valor de AL em BL
    LOOP SOMA
    ADD BL, "0"                         ; faz com que a soma dos números digitados representem um número na tabela ascii

    MOV AH, 9                           ; imprime a segunda mensagem
    LEA DX, MSG2
    INT 21H

    MOV AH, 2                           ; imprime a soma dos numeros
    MOV DL, BL
    INT 21H

    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN