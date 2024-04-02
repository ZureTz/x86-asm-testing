stack segment stack
stack ends

data segment
  prompt db 'The count of digit 3 in the number is: $'
  number dw 32323
data ends


code segment
  assume cs:code, ds:data, ss:stack

main:
  mov ax, data
  mov ds, ax
  mov ax, stack
  mov ss, ax

  ; load num to ax
  mov ax, [number]
  ; use bx as div operand
  mov bx, 10
  ; use cl as counter
  mov cl, 0

  jmp count_3_cond

count_3:
  ; ax /= 10
  mov dx, 0
  div bx
  ; if dx == 3, counter++
  cmp dx, 3
  jne count_3_cond
  inc cl

count_3_cond:
  ; while ax > 0
  cmp ax, 0
  ja count_3

  ; output prompt
  lea dx, [prompt]
  mov ah, 9h
  int 21h

  ; output counter
  mov dl, cl
  add dl, '0'
  mov ah, 2h
  int 21h

  mov ax, 4c00h
  int 21h

code ends
end main