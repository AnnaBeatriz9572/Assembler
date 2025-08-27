segment .data
mens db "Entre com string",10
tam equ $-mens

segment .bss
buffer resb 100
qntd resb 1

segment .text
global _start
_start:
; exibindo mensagem inicial
mov eax,4 
mov ebx,1
mov ecx, mens
mov edx, tam
int 80h

;recebendo string
mov eax,3
mov ebx,0
mov ecx,buffer
mov edx,100
int 80h
;exibindo string
mov [qntd], eax
mov eax,4 
mov ebx,1
mov ecx, buffer
mov edx, [qntd]
int 80h

fim:
mov eax,1
int 80h
