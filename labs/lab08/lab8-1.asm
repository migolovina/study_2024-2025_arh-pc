%include 'in_out.asm'
SECTION .data
msg1 DB 'Введите N:',0

SECTION .bss
N: RESB 10

SECTION .text
GLOBAL _start
_start:

mov eax,msg1
call sprint

mov ecx,N
mov edx,10
call sread

mov eax,N
call atoi
mov [N],eax

mov ecx,[N]
label:

push ecx
sub ecx,1
mov [N],ecx
mov eax,[N]
call iprintLF
pop ecx

loop label

call quit




