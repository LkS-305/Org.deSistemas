title Numero
.MODEL small
.STACK 100h
.data
    MSG01 db "Digite um caractere: $"
    SIM db 10,13, "O caractere digitado e um numero.$"
    NAO db 10,13, "O caractere digitado nao e um numero.$"
.code
main proc
    mov ax,@data ;permite o acesso às linhas em @data
    mov ds,ax

    mov ah,9 ;imprime a string mdg01 no console
    mov dx, offset MSG01
    int 21h

    mov ah,1 ;le um caractere do teclado
    int 21h

    mov bl,al ;copia o caractere lido para bl

    cmp bl,48 ;compara o caractere lido com "0" (checa se é um número)

    jb naoenumero ;se o caractere não for um número, salta para o rotulo naoenumero

    cmp bl,57 ;checa se o caractere é maior que 9

    ja naoenumero ;se o caractere não for um número, salta para o rotulo naoenumero

    mov ah,9 ;exibe que o caractere é um número
    mov dx,offset SIM
    int 21h

    jmp FIM ;salta para o fim

naoenumero: ;exibe na tela que o caractere não é um número
    mov ah,9 
    mov dx,offset NAO
    int 21h

FIM: ;encerra o programa
    mov ah,4ch
    int 21h
main endp
end main
