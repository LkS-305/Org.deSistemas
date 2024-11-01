title _LOOP_ * 
.model small
PULA_LINHA MACRO
    MOV AH, 02
    MOV DL, 10
    INT 21h
    MOV DL,13
    INT 21h
ENDM

.code
main proc
    MOV AH, 02H
    MOV DL, '*'
    MOV CX, 50 ; determina quantas vezes o loop roda
    FOR:
            INT 21h
            LOOP FOR
    
    PULA_LINHA

    MOV CX, 50
    FOR_LINHA:
        MOV DL, '*' ;envia '*' para o DL, uma vez que o macro altera o valor de DL a cada uso
        INT 21h
        PULA_LINHA
        LOOP FOR_LINHA

    MOV AH, 4CH
    INT 21h
MAIN ENDP
END MAIN