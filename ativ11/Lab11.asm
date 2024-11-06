title ENTRADA E SAÍDA: BINÁRIO, DECIMAL E HEXADECIMAL
.MODEL SMALL
PULAR_LINHA MACRO
    PUSH AX
    PUSH DX
    
    MOV AH, 2
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H

    POP DX
    POP AX
ENDM

IMPRIME_RECEBE MACRO    ;IMPRIME UMA MENSAGEM E RECEBE UM CARACTERE, ENDEREÇO DA MENSAGEM DEVE ESTAR EM DX
    MOV AH, 9           ;IMPRIME MENSAGEM DE ENTRADA
    INT 21H

    PULAR_LINHA

    MOV AH, 1           ;RECEBE CARACTERE REFERENTE AO TIPO DE ENTRADA
    INT 21H
ENDM
.DATA
    MSG1 DB "Qual será a forma de entrada?",10,"1. Binario",10,"2. Decimal",10,"3. Hexadecimal$"
    MSG2 DB "Qual será a forma de saida?",10,"1. Binario",10,"2. Decimal",10,"3. Hexadecimal$"

    TABELAHEXA      DB 30H, 31H, 32H, 33H, 34H, 35H, 36H, 37H, 38H, 39H             ;TABELA DE CONVERSÃO NÚMEROS
                    DB 41H, 42H, 43H, 44H, 45H, 46H                                 ;TABELA DE CONVERSÃO LETRA MAIUSCULA

.STACK 100H
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG1
    LEA SI, MSG2
    CALL ESCOLHA

    MOV AH, 4CH
    INT 21H
MAIN ENDP

;OS ENDEREÇOS DA MENSAGEM DE ENTRADA DEVE ESTAR EM DX E DA SEGUNDA MENSAGEM EM BX
;PROCEDIMENTO QUE IMPRIME UMA MENSAGEM PERGUNTANDO QUAL SERÁ A ENTRADA E QUAL SERÁ A SAÍDA
;DEPENDENDO DA ESCOLHA DO USUÁRIO REALIZA UM CALL DIFERENTE
ESCOLHA PROC
    PUSH AX
    PUSH BX
    PUSH DX
    
    IMPRIME_RECEBE

    PULAR_LINHA

    CMP AL, 31h         ;COMPARA VALOR QUE O USUÁRIO DIGITOU E DECIDE QUAL SERÁ A FORMA DE ENTRADA DO NÚMERO
    JZ BINARIO
    CMP AL, 32h
    JZ DECIMAL

    HEXA:
    CALL ENTRADAHEXA
    JMP IMPRIMIR
    
    DECIMAL:
    CALL ENTRADADECIMAL
    JMP IMPRIMIR
    
    BINARIO:
    CALL ENTRADABINARIO

    IMPRIMIR:
    PULAR_LINHA             ;PULA LINHA
    MOV DX, SI
    IMPRIME_RECEBE          ;IMPRIME SEGUNDA MENSAGEM

    PULAR_LINHA

    CMP AL, 31h               ;COMPARA VALOR QUE O USUÁRIO DIGITOU E DECIDE QUAL SERÁ A FORMA DE ENTRADA DO NÚMERO
    JZ IMPRIMEBINARIO
    CMP AL, 32h
    JZ IMPRIMEDECIMAL

    IMPRIMEHEXA:
    CALL SAIDAHEXA
    JMP FORA
    
    IMPRIMEDECIMAL:
    CALL SAIDADECIMAL
    JMP FORA
    
    IMPRIMEBINARIO:
    CALL SAIDABINARIO

    FORA:
    POP DX
    POP BX
    POP AX
    RET
ESCOLHA ENDP

;RECEBE NÚMERO BINÁRIO E O GUARDA EM BX
;CASO O NÚMERO RECEBIDO SEJA NEGATIVO (MSB FOR 1), RETORNA 1 EM CX
ENTRADABINARIO PROC

    PUSH AX
    XOR BX, BX
    MOV AH, 1
    MOV CX, 16

    INPUTBINARIO:
        INT 21H                     ;RECEBE UM CARACTERE
        CMP AL, 0DH                 ;COMPARA INPUT COM CR
        JZ SAIBINARIO               ;SE CR --> SAIR DO LOOP
        AND AL, 0Fh                 ;CONVERTE CARACTERE PARA NUMERO
        SHL BX, 1                   ;DESLOCA BX 1 BIT PARA A ESQUERDA 
        OR BL, AL                   ;SOMA EM BX O NUMERO DIGITADO
        LOOP INPUTBINARIO
    SAIBINARIO:
    TEST BX, 8000H
    JZ NUM_POSITIVO_BINARIO
    MOV CX, 1
    NUM_POSITIVO_BINARIO:
    POP AX
    RET
ENTRADABINARIO ENDP

;IMPRIME UMA PALAVRA DE 16 BITS QUE ESTÁ ARMAZENADA EM BX
SAIDABINARIO PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 16                      ;LER OS 16 BITS DA PALAVRA
    MOV AH, 2
    FORBINARIO:
        SHL BX, 1                   ;DESLOCA BX 1 BIT PARA A ESQUERDA
        JC UM                       ;SE OCORREU CARRY (MSB FOR IGUAL A 1), SALTA PARA 'UM'
        MOV DL, 30h                 ;SE MSB FOR IGUAL A 0, DL = 0
        JMP IMPRIMIRBINARIO
        UM:
            MOV DL, 31h
        IMPRIMIRBINARIO:
            INT 21H                 ;IMPRIME O BIT
        LOOP FORBINARIO
    POP DX
    POP CX
    POP BX
    POP AX
    RET
SAIDABINARIO ENDP


;RECEBE NÚMERO DECIMAL E O GUARDA EM BX
ENTRADADECIMAL PROC
    
    PUSH AX
    PUSH DX

    XOR BX, BX
    XOR CX, CX
    MOV AH, 2
    MOV DL, '?'
    INT 21H
    MOV AH, 1
    INT 21H
    CMP AL, '-'                     ;CHECA O SINAL (CASO USUÁRIO DIGITE '-', O NÚMERO SERÁ NEGATIVO, QUALQUER OUTRO CARACTERE SERÁ IGNORADO)
    JNZ INPUTDECIMAL                ;SE NÚMERO NÃO FOR NEGATIVO, PULA PARA A ENTRADA DO NÚMERO
    MOV CX, 1

    INPUTDECIMAL:
        INT 21H
        CMP AL, 13                  ;SE INPUT = CR, PARA DE RECEBER NÚMERO
        JZ SAIDECIMAL
        PUSH AX                     ;SALVA NÚMERO DIGITADO NA PILHA
        MOV AX, 10
        MUL BX                      ;MULTIPLICA POR 10
        MOV BX, AX
        POP AX                      ;RECUPERA NÚMERO DIGITADO
        AND AL, 0Fh                 ;CONVERTE PARA NÚMERO
        ADD BL, AL                  ;SOMA NÚMERO RECÉM DIGITADO NO TOTAL
        JMP INPUTDECIMAL
    SAIDECIMAL:
    OR CX,CX                        ;SE CX FOR = 0, ATIVARÁ FLAG DE ZERO
    JZ POSITIVO                     ;SE O NÚMERO FOR POSITIVO, SALTA
    NEG BX                          ;CASO CONTRÁRIO, CONVERTA PARA NEGATIVO
    POSITIVO:
    POP DX
    POP AX
    RET
ENTRADADECIMAL ENDP

;IMPRIME NÚMERO DECIMAL ARMAZENADO EM BX
;PODE IMPRIMIR NÚMEROS DE 1 ATÉ 262143
SAIDADECIMAL PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    OR CX, CX                   ;CHECA SE O NÚMERO É NEGATIVO
    JZ NUM_POSITIVO            ;SE FOR POSITIVO PULA
        MOV AH, 2               ;SE FOR NEGATIVO, IMPRIME O '-'
        MOV DL, '-'
        INT 21H
        NEG BX
    NUM_POSITIVO:
    MOV DI, 10
    XOR CX, CX
    MOV AX, BX          ;PASSA O NUMERO A SER DIVIDIDO PARA AX
    XOR DX, DX          ;tira o lixo de dx
    OUTPUTDECIMAL:
        DIV DI              ;AX / DI    --> QUOCIENTE VAI PARA AX E RESTO VAI PARA DX
        PUSH DX
        XOR DX, DX
        INC CX
        OR AX, AX
        JNZ OUTPUTDECIMAL
    
    MOV AH, 2
    IMPRIMIRDECIMAL:
        POP DX
        OR DL, 30H
        INT 21H
        LOOP IMPRIMIRDECIMAL

    POP DX
    POP CX
    POP BX
    POP AX
    RET
SAIDADECIMAL ENDP

;RECEBE NÚMERO HEXADECIMAL E O GUARDA EM BX
ENTRADAHEXA PROC
    PUSH AX
    PUSH DX

    XOR BX, BX
    MOV AH, 1
    MOV CX, 4
    INPUTHEXA:
        INT 21H                     ;RECEBE UM CARACTERE
        CMP AL, 0DH                 ;COMPARA INPUT COM CR
        JZ SAIHEXA                  ;SE CR --> SAIR DO LOOP
        SHL BX, 4                   ;DESLOCA PARA O PRÓXIMO DÍGITO HEXADECIMAL
        CMP AL, 39H                 ;COMPARA INPUT COM '9'
        JG LETRAHEXA                ;SE INPUT FOR MAIOR QUE '9', ASSUME-SE QUE É UMA LETRA MAIUSCULA
        AND AL, 0Fh                 ;CONVERTE DE CARACTERE NUMERICO PARA UM NUMERO
        JMP SOMAHEXA
        LETRAHEXA:
            SUB AL, 37H             ;CONVERTE DE LETRA MAIUSCULA PARA SEU VALOR EM HEXADECIMAL
        SOMAHEXA:
            OR BL, AL               ;SOMA EM BX O NÚMERO RECÉM CONVERTIDO
        LOOP INPUTHEXA
    SAIHEXA:

    TEST BX, 8000H                  ;TESTA SE O MSB É 1 OU 0
    JZ NUM_POSITIVO_HEXA         ;SE FOR 0, NÚMERO POSITIVO
    MOV CX, 1                       ;SE FOR 1, CX <-- 1, MARCANDO COMO NEGATIVO
    NUM_POSITIVO_HEXA:

    POP DX
    POP AX
    RET
ENTRADAHEXA ENDP

;IMPRIME O NÚMERO GUARDADO EM BX, NO FORMATO HEXADECIMAL
SAIDAHEXA PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AH, 2
    MOV CX, 4
    OUTPUTHEXA:
        MOV DL, BH                  
        SHR DL, 4                   ;DESLOCA O DÍGITO HEXADECIMAL PARA A DIREITA (RESTA APENAS UM DÍGITO EM DL) (DÍGITO RESTANTE ERA O MAIS SIGNIFICATIVO EM BX)

        PUSH BX                     ;GUARDA VALOR DE BX NA PILHA
        LEA BX, TABELAHEXA          ;COLOCA OFFSET DO ENDEREÇO EM BX
        XCHG AL, DL                 ;TROCA CONTEÚDO DE AL E DL (ENVIA O CARACTERE A SER CONVERTIDO PARA AL)
        XLAT                        ;CONVERTE CONTEÚDO DE AL PARA CARACTERE
        XCHG AL, DL                 ;TROCA CONTEÚDO DE AL E DL
        POP BX                      ;RETORNA VALOR DE BX DA PILHA
        SHL BX, 4                   ;DESLOCA BX 4 BITS PARA A ESQUERDA
        INT 21H                     ;IMPRIME CARACTERE ARMAZENADO EM DL
        LOOP OUTPUTHEXA
    POP DX
    POP CX
    POP BX
    POP AX
    RET
SAIDAHEXA ENDP
END MAIN