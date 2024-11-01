title FOR *
.model small
PULA_LINHA MACRO ; macro para enviar cursor para a esquerda e pular linha
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
    MOV CX, 50
    FOR:
            DEC CX
            INT 21h
            JNZ FOR
    
    PULA_LINHA

    MOV CX, 50
    FOR_LINHA:
        MOV DL, '*'
        DEC CX
        INT 21h ; imprime o '*'
        PULA_LINHA
        JNZ FOR_LINHA ;volta o loop

    MOV AH, 4CH
    INT 21h
MAIN ENDP
END MAIN