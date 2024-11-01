title Letra minuscula em maiuscula
.model small
.data
    msg1 db "Digite um caractere: .$"
    msg2 db "A letra maiuscula correspondente e: .$"
.code
main proc
    mov ax,@data
    mov ds,ax ;acessa as mensagens e as copia no ds

    mov ah,9 ;imprime a mensagem pedindo o caractere
    lea dx,msg1
    int 21h 
    
    mov ah,1 ;recebe o caractere
    int 21h
    mov bl,al ;salva o caractere em BL

    sub bl,32 ;subtrai 32 de bl (-20h) para obter a letra maiúscula

    mov ah,2
    mov dl,10 ;pula uma linha
    int 21h

    mov ah,2
    mov dl,13 ;move o cursor para a esquerda
    int 21h

    mov ah,9 ;imprime a segunda mensagem
    lea dx,msg2
    int 21h

    mov ah,2 ;imprime o caractere digitado
    mov dl,bl
    int 21h

    mov ah,4ch ; finaliza o programa
    int 21h
main endp
end main
