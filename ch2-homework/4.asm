stack segment stack
  dw 16 dup(?)
stack ends

data segment
  message db 'Please input a hexadecimal digit: $'
  result_msg db 'The result is: $'
  exception_msg db 'Error: Invalid input $'
  newline db 0dh, 0ah, '$'
data ends

code segment
  assume cs:code, ds:data, ss:stack
main:
  ; init
  mov ax, data
  mov ds, ax
  mov ax, stack
  mov ss, ax

  ; print message
  lea dx, [message]
  mov ah, 9h
  int 21h

  ; wait for input
  mov ah, 1h
  int 21h

  ; process input
  cmp al, 'a'
  jae lower_alpha
  cmp al, 'A'
  jae upper_alpha
  cmp al, '0'
  jae digit

  ; exception
  jmp exception

lower_alpha:
  cmp al, 'f'
  ja exception
  ; al = al - 'a' + 10
  sub al, 'a'
  add al, 10
  jmp end_process

upper_alpha:
  cmp al, 'F'
  ja exception
  ; al = al - 'A' + 10
  sub al, 'A'
  add al, 10
  jmp end_process

digit:
  cmp al, '9'
  ja exception
  ; al = al - '0'
  sub al, '0'
  jmp end_process

end_process:
  ; if al == 0
  cmp al, '0'
  je print_0

  ; al = al * al
  mul al

  mov bl, 10
  ; using cx as counter
  mov cx, 0

  ; while (al > 0)
  jmp pre_print_cond
pre_print:
  ; al /= 10
  mov ah, 0
  div bl
  ; the mod is in ah, store ax
  push ax
  inc cx

pre_print_cond:
  cmp al, 0
  ja pre_print

  lea dx, [newline]
  mov ah, 9h
  int 21h
  
  lea dx, [result_msg]
  mov ah, 9h
  int 21h


print:
  pop dx
  mov dl, dh
  add dl, '0'
  mov ah, 2h
  int 21h
  
  loop print

exit:
  mov ax, 4c00h
  int 21h

print_0:
  lea dx, [newline]
  mov ah, 9h
  int 21h
  
  lea dx, [result_msg]
  mov ah, 9h
  int 21h
  
  mov dl, '0'
  mov ah, 2h
  int 21h

  jmp exit

exception:
  lea dx, [newline]
  mov ah, 9h
  int 21h

  lea dx, [exception_msg]
  mov ah, 9h
  int 21h

  jmp exit

code ends
end main