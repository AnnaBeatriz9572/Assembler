; não esqueça de abrir um arquivo .txt para executar o código 
; como foi feito no jdoodle, acaba que o programa vai dar erro por ser limitado
;abrir/fechar.s
segment .data
nome db "/uploads/teste.txt", 0
merrab db "Erro ao tentar abrir arquivo", 10
tam equ $-merrab

segment .bss
fd resd 1;descritor
buffer resb 20;vetor ou estrutura/ faremos uma repetição para descobrir o final do arquivo, se o eax retornar 20 ele repete ate o eax ser menor que 20 então ele imprime tudo
qtd resb 1

segment .text;inicio codigo
global _start

;area de procedimento
abrir:
mov eax, 5; OPEN
mov ecx, 0; 0 só leitura e 1 só escrita /2 modo RW leitura e escrita
mov edx, 0q777; permissao total
int 80h
ret

fechar:
mov eax, 6; CLOSE
int 80h
ret

exibir:;print
; foram "passados" ponteiro e tamanho
mov eax, 4; servico print
mov ebx, 1; exibe na tela / FD da tela
int 80h; chama o kernel (codigo, sistema), le oq ta no eax e executa
ret

_start: ;ponto de entrada
;Abertura
mov ebx, nome; aponta pro noe
call abrir
cmp eax, 0; se um número negativo dá erro o eax está rcebendo u retorno; no read ele também retorna o valor da qtd de caractéres digtados pelo usuário
jl erro;se eax<0
mov[fd], eax;salva fd

;lendo o arquivo
mov eax, 3;read o 3 é genérico
mov ebx, [fd]
mov ecx, buffer
mov edx, 20
int 80h

;salva qtd
mov [qtd], eax; coloca o que está em eax na qtd para eu poder impprimir o que está dentro do arquivo
mov ecx, buffer
mov edx,[qtd]
call exibir

mov ebx, [fd]; preparando CLOSE
call fechar
jmp fim; contornar merrab
erro: ; (print)
mov ecx, merrab
mov edx, tam
call exibir
fim:
mov eax, 1; EXIT
int 80h; sys_call
