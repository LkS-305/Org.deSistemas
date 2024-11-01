TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VATORES USANDO BX
.MODEL SMALL
.DATA
    VETOR DB 1,1,1,2,2,2

.STACK 100H
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX          ;IMPORTA O CONTEÚDO DE .DATA
    LEA BX, VETOR       ;COLOCA EM BX O OFFSET DE ENDEREÇO DO VETOR
    MOV CX, 6           ;DEVE CONTER O NÚMERO DE ELEMENTOS NO VETOR

    CALL CONVERSOR      ;RECEBE UM VETOR COM ELEMENTOS NUMÉRICOS DE 0 A 9, CONVERTE ESSES VALORES PARA CARACTERES E OS IMPRIME

    MOV AH, 4CH         ;ENCERRA PROGRAMA
    INT 21H

MAIN ENDP

;SUB-ROTINA QUE RECEBE UM VETOR DE NÚMEROS DE 0 A 9 E OS CONVERTE PARA SEUS RESPECTIVOS CARACTERES E OS IMPRIME
;CX DEVE CONTER O NÚMERO DE ELEMENTOS DO VETOR
;BX DEVE CONTER O ENDEREÇO DO VETOR
;O CONTEÚDO DE DL SERÁ ALTERADO PARA O VALOR DO ÚLTIMO ELEMENTO NO VETOR
CONVERSOR PROC
    XOR DL,DL           ;ZERA DL
    VOLTA:
        MOV DL, [BX]    ;ENVIA O VALOR ARMAZENADO NO ENDEREÇO DE MEMÓRIA BX, PARA DL
        INC BX          ;AVANÇA O ENDEREÇO EM BX POR 1 UNIDADE
        ADD DL, 30H     ;CONVERTE DE NÚMERO PARA CARACTERE
        MOV AH, 2       ;PODERIA ESTAR FORA DO LOOP
        INT 21H         ;IMPRIME CARACTERE EM DL
    LOOP VOLTA
    RET
CONVERSOR ENDP
END MAIN