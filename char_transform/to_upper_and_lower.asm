stack segment stack
  db 16 dup(0)
stack ends

data segment
  newline db 0dh, 0ah, '$'
  str1 db 'BaSic$'
  str2 db 'InforMatIon$'
data ends

code segment
  assume cs:code, ds:data, ss:stack

main:
  ; init
  mov ax, data
  mov ds, ax
  mov ax, stack
  mov ss, ax

  ; load address of str1
  lea bx, [str1]
  jmp loop_upper_cond

loop_upper:
  and al, 11011111b
  mov [bx], al
  inc bx

loop_upper_cond:
  mov al, [bx]
  cmp al, '$'
  jne loop_upper

  ; print string
  lea dx, [str1]
  mov ah, 9h
  int 21h

  ; seperator newline
  lea dx, [newline]
  mov ah, 9h
  int 21h

  ; load address of str2
  lea bx, [str2]
  jmp loop_lower_cond

loop_lower:
  or al, 00100000b
  mov [bx], al
  inc bx

loop_lower_cond:
  mov al, [bx]
  cmp al, '$'
  jne loop_lower

  ; print string
  lea dx, [str2]
  mov ah, 9h
  int 21h

  mov ax, 4c00h 
  int 21h

code ends
end main
