data segment
  first_prompt db 'Please input the first digit: $'
  second_prompt db 'Please input the second digit: $'
  newline db 0dh, 0ah, '$'
data ends

stack segment stack
  ; set stack size to 8 words (16 byte)
  db 16 dup(0)
stack ends

code segment
  assume cs:code, ds:data, ss:stack

start:
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
  
  ; input the digit
  mov ah, 1
  int 21h
  ; calculate the distance from '0'
  sub al, '0'
  mov ah, 0
  ; push the result to the stack
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

  ; input the digit
  mov ah, 1
  int 21h
  ; calculate the distance from '0'
  sub al, '0'
  mov ah, 0
  ; push the result to the stack
  push ax
  
  ; print newline
  lea dx, [newline]
  mov ah, 9
  int 21h
  
  ; add together
  mov dl, 0
  pop ax
  add dl, al
  pop ax
  add dl, al

  ; convert into char
  add dl, '0'
  ; print
  mov ah, 2
  int 21h

  lea dx, [newline]
  mov ah, 9
  int 21h
  
  
  mov ax, 4c00h
  int 21h
  

code ends
end start