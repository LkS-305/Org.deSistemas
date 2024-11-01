title Eco
.model small
.code
main proc
    ;exibe o caracter ? na tela
    mov ah,2
    mov dl,"?"
    int 21h
    
    ;le um caracter do teclado e salva o caracter lido em aL
    mov ah,1
    int 21h

    ;copia o caracter lido para bL
    mov bl,al

    ;exibe o caracter line feed (move cursor para a linhe seguinte)
    mov ah,2
    mov dl,10 ;codigo asc do caracter line feed é 10 (0Ah)
    int 21h

    ;exibe o caracter Carriage return (move cursor para o canto esquerdo da tela)
    mov ah,2
    mov dl,13
    int 21h
    ;exibe o caracter lido
    mov ah,2
    mov dl,bl
    int 21h
    ;finalizar programa
    mov ah,4ch
    int 21h
main endp
end main
