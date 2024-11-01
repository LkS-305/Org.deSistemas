title Divisao
.model small
.DATA
    msg1 db 10,13, "dividendo: $"
    msg2 db 10,13, "divisor: $"
    msg3 db 10,13, "quociente: $"
    msg4 db 10,13, "resto: $"
.CODE
    main proc
        mov ax, @DATA
        mov ds, ax
        mov ah, 9
        lea dx, msg1
        int 21h

        mov ah,1 
        int 21h
        mov ch,al   ;guarda dividendo em ch

        mov ah, 9
        lea dx, msg2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al  ;guarda divisor em cl

        XOR bl, bl  ;zera o contador para o quociente
        AND cl, 0Fh ;Converte o divisor, do caractere para o número
        AND ch, 0Fh ;Converte o dividendo, do caractere para o número

        Divisao:
            cmp ch,cl
            jb Quociente        ; se o dividendo for menor que o divisor, sair do loop
            sub ch,cl
            inc bl              ; quociente++
            jmp Divisao         ; volta ao loop

        Quociente:
            OR cl, 30h ; converte valor do dividendo para o caractere na tabela ASCII
            OR ch, 30h ; converte valor do divisor para o caractere na tabela ASCII
            OR bl, 30h ; converte valor do quociente para o caractere na tabela ASCII
            
            mov ah, 9   ; Imprime quociente
            lea dx, msg3
            int 21h

            mov ah, 2
            mov dl,bl
            int 21h

            mov ah, 9   ; imprime resto
            lea dx, msg4
            int 21h
            mov ah, 2
            mov dl, ch
            int 21h

            mov ah, 4CH ;finaliza programa
            int 21h

    main ENDP
end main