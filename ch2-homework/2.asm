stack segment stack
  dw 16 dup(?)
stack ends

data segment
  X dw 0
  ; 0: +, 1: -
  negative_flag db 0
data ends

code segment
  assume cs:code, ds:data, ss:stack

main:
  ; init
  mov ax, data
  mov ds, ax
  mov ax, stack
  mov ss, ax

  ; using ax to store number
  mov ax, [X]
  ; + or - or 0
  cmp ax, 0
  je print_0
  ; find the least significant digit
  mov dx, ax
  and dx, 8000h
  cmp dx, 0
  je positive

negative:
  mov [negative_flag], 1
  not ax
  inc ax

  jmp positive

positive:
  ; bx = 10
  mov bx, 10
  ; using cx as counter
  mov cx, 0
  ; while (ax > 0)
  jmp pre_print_cond
pre_print:
  mov dx, 0
  div bx
  push dx
  ; cx++
  inc cx

pre_print_cond:
  cmp ax, 0
  ja pre_print

  ; negative symbol
  cmp [negative_flag], 0
  je print

  mov dl, '-'
  mov ah, 2h
  int 21h

print:
  pop dx
  add dl, '0'
  mov ah, 2h
  int 21h

  loop print

exit:
  mov ax, 4c00h
  int 21h

print_0:
  mov dl, '0'
  mov ah, 2h
  int 21h

  jmp exit

code ends
end main
