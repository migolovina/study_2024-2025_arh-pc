%include 'in_out.asm'

SECTION .data
A1 DB 'Введите число А: ',0h
B1 DB 'Введите число B: ',0h
C1 DB 'Введите число С: ',0h
otv DB 'Наименьшее число: ',0h
SECTION .bss
min RESB 20
A RESB 20
B RESB 20
C RESB 20

SECTION .text
GLOBAL _start
_start:

mov eax,A1
call sprint

mov ecx,A
mov edx,20
call sread

mov eax, A
call atoi
mov [A],eax

xor eax,eax

mov eax,B1
call sprint

mov ecx,B
mov edx,20
call sread

mov eax,B
call atoi
mov [B],eax

xor eax,eax

mov ecx, [A]
mov [min],ecx
mov ecx,[min]

cmp ecx,[B]
jl check_C
mov ecx, [B]
mov [min],ecx

check_C:

mov eax,C1
call sprint

mov ecx,C
mov edx,10
call sread

mov eax,C
call atoi
mov [C],eax

xor eax,eax


mov ecx,[min]
cmp ecx,[C]
jl fin
mov ecx,[C]
mov [min],ecx


fin:
mov eax, otv
call sprint
mov eax, [min]
call iprintLF
call quit


