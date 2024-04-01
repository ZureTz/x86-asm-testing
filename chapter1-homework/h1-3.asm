data segment
  first_prompt db 'Please input the first digit: $'
  second_prompt db 'Please input the second digit: $'
  newline db 0dh, 0ah, '$'
data ends

stack segment stack
  db 16 dup(0)
stack ends

code segment
  assume cs:code, ds:data, ss:stack

main:
  mov ax, data
  mov ds, ax
  
  mov ax, stack
  mov ss, ax
  mov sp, 10h


  ; print the first prompt
  lea dx, [first_prompt]
  mov ah, 9
  int 21h
  lea dx, [newline]
  mov ah, 9
  int 21h

  ; input the first digit
  mov ah, 1
  int 21h
  ; process the char into number
  sub al, '0'
  mov ah, 0
  push ax

  lea dx, [newline]
  mov ah, 9
  int 21h

  ; print the second prompt
  lea dx, [second_prompt]
  mov ah, 9
  int 21h
  lea dx, [newline]
  mov ah, 9
  int 21h

  ; input the second digit
  mov ah, 1
  int 21h
  ; process the char into number
  sub al, '0'
  mov ah, 0
  push ax

  lea dx, [newline]
  mov ah, 9
  int 21h

  ; fetch the numbers from stack
  mov dx, 0
  pop ax
  add dx, ax
  pop ax
  add dx, ax
  
  ; convert the result into char
  add dl, '0'
  ; print the result
  mov ah, 2
  int 21h

  lea dx, [newline]
  mov ah, 9
  int 21h
  
  mov ax, 4c00h
  int 21h


code ends
end main 