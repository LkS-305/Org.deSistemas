title Soma
.model small
pula_linha macro ;atalho para pular linha e enviar cursor para a esquerda
   mov ah,02
   mov dl,10 ;pula linha
   int 21h
   mov dl,13 ;cursor para a direita
   int 21h
endm
.data
    msg1 db "Digite um numero de 0 a 9: .$"
    msg2 db "Digite o segundo numero de 0 a 9 (Tenha em mente que a soma dos dois nao pode exceder 9): .$"
    msg3 db "A soma dos valores digitados e: .$"
.code
main proc
    mov ax,@data
    mov ds,ax ; pega as mensagens e as envia para o ds

    mov ah,9 ;imprime a primeira mensagem
    lea dx,msg1
    int 21h 
    
    mov ah,1 ;recebe o primeiro numero
    int 21h
    sub al,"0"
    mov bl,al ;salva o primeiro numero em BL

    pula_linha ;usa um macro para pular a linha e enviar o cursor para a esquerda

    mov ah,9 ;imprime a segunda mensagem
    lea dx,msg2
    int 21h

    mov ah,1 ;recebe o segundo numero
    int 21h
    sub al,"0" ;subtrai '0' (ou 48) de bl
    add bl,al ;soma o segundo numero em bl
    add bl,"0" ;soma '0' (ou 48) a bl para representar um número de 0 a 9

    pula_linha ;pula linha e envia cursor para a esquerda

    mov ah,9 ;imprime a terceira mensagem
    lea dx,msg3
    int 21h

    mov ah,2 ;imprime a soma dos dois números
    mov dl,bl
    int 21h

    mov ah,4ch ; finaliza o programa
    int 21h
main endp
end main
