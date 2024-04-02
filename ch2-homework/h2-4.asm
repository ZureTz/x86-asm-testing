stack segment stack
  dw 16 dup(?)
stack ends

data segment
  prompt db 'Please input a hexadecimal digit: $'
  prompt_res db 'The result is: $'
  exception_str db 'Error: Invalid input. The input must be a hexadecimal digit.', 0dh, 0ah, '$'
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

  ; prompt
  lea dx, [prompt]
  mov ah, 9h
  int 21h

  ; wait for input
  mov ah, 1h
  int 21h

  ; process input

  ; lower alphabet
  cmp al, 'a'
  jae lower_alpha
  ; upper alphabet
  cmp al, 'A'
  jae upper_alpha
  ; digits
  cmp al, '0'
  jae digits

  ; else: invalid input, print exception
  jmp exception

lower_alpha:
  ; al > 'z' : invalid input
  cmp al, 'f'
  ja exception
  ; al = al - 'a' + 10
  sub al, 'a'
  add al, 10
  jmp end_parsing

upper_alpha:
  ; al > 'Z' : invalid input
  cmp al, 'F'
  ja exception
  ; al = al - 'A' + 10
  sub al, 'A'
  add al, 10
  jmp end_parsing

digits:
  ; al > '9' : invalid input
  cmp al, '9'
  ja exception
  ; al = al - '0'
  sub al, '0'
  jmp end_parsing

end_parsing:
  ; if input is 0, print 0 directly
  cmp al, 0
  je print_0
  
  ; set ah to 0
  mov ah, 0
  ; al = al * al
  mul al

  ; to print number
  ; using bl as 10
  mov bl, 10
  ; using cx as counter of digits
  mov cx, 0

  jmp pre_print_cond
pre_print:
  ; al /= 10
  mov ah, 0
  div bl
  ; the mod is stored in ah
  ; push into stack
  push ax
  ; counter++
  inc cx

pre_print_cond:
  ; while (al > 0)
  cmp al, 0
  ja pre_print

  ; print newline
  lea dx, [newline]
  mov ah, 9h
  int 21h  

  ; print prompt of the result
  lea dx, [prompt_res]
  mov ah, 9h
  int 21h

  ; for (int i = 0; i < numOfDigits; i++)
print_digit:
  pop dx
  ; mov the mod to dl
  mov dl, dh
  ; covert to char
  add dl, '0'
  ; print
  mov ah, 2h
  int 21h

  loop print_digit

exit:
  mov ax, 4c00h
  int 21h

print_0:
  ; print newline
  lea dx, [newline]
  mov ah, 9h
  int 21h

  lea dx, [prompt_res]
  mov ah, 9h
  int 21h

  mov dl, '0'
  mov ah, 2h
  int 21h
  
  jmp exit

exception:
  ; print newline
  lea dx, [newline]
  mov ah, 9h
  int 21h

  lea dx, [exception_str]
  mov ah, 9h
  int 21h
  jmp exit
  
code ends
end main
