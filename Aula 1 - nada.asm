section .text ; início de segmento de código (pode ser segment também)
global _start ;diretiva
_start:

fim: ;label
mov eax,1 ; número do serviço exit ; instrução ; 32 bits
int 80h ; chamada ao sistema
