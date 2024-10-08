%include 'in_out.asm'

SECTION .data

prim: DB '10*(x+1)-10',0
x1: DB 'Введите значение x: ',0
otv1: DB 'Ответ при x= ',0

SECTION .bss
p: RESB 80

SECTION .text
GLOBAL _start
_start:

mov eax,prim
call sprintLF

mov eax,x1
call sprint

mov ecx,p
mov edx,80
call sread

mov eax,p
call atoi

xor edx,edx

add eax,1
mov ebx,10
mul ebx
sub eax,10

mov edi,eax

mov eax,otv1
call sprint
mov eax,p
call sprint
mov eax,edi
call iprintLF

call quit


