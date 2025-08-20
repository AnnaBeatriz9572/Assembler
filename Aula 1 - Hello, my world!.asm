segment .data
mens db "Hello, my world!",10 ; define byte, é um label porém não precisa de : pois é apenas utilizado em segmento de código
tam equ $-mens ; ele já descobre o tamanho da string

section .text ; início de segmento de código (pode ser segment também)
global _start ;diretiva
_start:

;códigos
;exibindo a string mens
mov eax,4 ; serviço print
mov ebx,1 ; descritor do arquivo - FD
mov ecx,mens ; ponteiro da string
mov edx,tam ;tamanho da string
int 80h

fim: ;label
mov eax,1 ; número do serviço exit ; instrução ; 32 bits
int 80h ; chamada ao sistema
