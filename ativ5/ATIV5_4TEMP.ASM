.model small
PULA_LINHA MACRO
    MOV AH, 2
    MOV DL, 10
    INT 21h
    MOV DL, 13
    INT 21h
    XCHG DL, DH
ENDM
.DATA
.CODE
MAIN PROC 

    MOV AH, 2
    MOV CX, 26
    MOV DL, 'a'
    LINHAS:    
        MOV CX, 4
        LETRAS:
            CMP DL, 'z'
            JG FIM
            INT 21h
            INC DL
            LOOP LETRAS
        XCHG DL, DH
        PULA_LINHA
        LOOP LINHAS

    FIM:
        MOV AH, 4CH
        INT 21h

MAIN ENDP
END MAIN