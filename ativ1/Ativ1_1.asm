title Mensagens
.model small
.data
    msg1 DB "Mensagem 1.$"
    msg2 DB 10,13,"Mensagem 2.$"
.code
main proc
    ; da acesso às variáveis criadas em .data
    mov ax,@data
    mov ds,ax ;copia as mensagens de ax para ds
    ;ds guarda o endereço do segmento de dados

    ;exibe na tela a string msg1
    mov ah,9 ;9 é o comando de imprimir no 21h
    lea dx,msg1 ;imprime a msg1 que está no dx
    int 21h

    ;imprime a mensagem 2
    mov ah,9
    lea dx,msg2 ;imprime a msg2 qua esta no dx
    int 21h

    ;finaliza o programa
    mov ah,4ch ;comando do 21h para finalizar o sistema
    int 21h
main endp
end main
