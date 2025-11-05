; como foi feito no jdoodle, acaba que o programa vai dar erro por ser limitado
;abrir/fechar.s
segment .data ; precisa inicializar a variável
nome db "/uploads/text.txt",0 ; combinado com o abrir, termina a string quando acha o 0 no final (/0 de uma string)
merrab db "Erro ao tentar abrir",10 ; metragem de erro de abertura, o 10 é uma instrução imprimir uma mensagem
tam equ $-merrab
segment .bss ; não precisa inicializar a variável 
fd resd 1 ; descritor

segment .text
global _start

erro: ;print
mov ecx, merrab
mov edx, tam
call exibir

fim:
mov eax,1; EXIT
int 80h ; sys_call

;area de procedimento

abrir:
mov eax,5 ;OPEN
mov ecx,2 ;modo RW(leitura e escrita)
mov edx, 0q777 ;permissão total 0q-octal
int 80h
ret

fechar:
mov eax, 6; CLOSE
int 80h
ret

exibir:
mov eax, 4; print
mov ebx, 1; FD da tela
int 80h
ret

_start:
; abrindo 
mov ebx, nome ; apontando para o nome
call abrir ; para abrir o arquivo
cmp eax, 0 ; comparando eax com 0
jl erro ; se eax<0
mov[fd], eax ; salva fd
mov ebx,[fd] ;preparando o CLOSE
call fechar
jmp fim ; contornar merrab
