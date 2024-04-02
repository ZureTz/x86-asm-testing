data segment
  prompt db 'Please input a character: $'
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
  mov sp, 10h ; same as stack size (16)

  ; show the prompt to input
  lea dx, [prompt]
  mov ah, 9
  int 21h
  lea dx, [newline]
  mov ah, 9
  int 21h
  
  ; wait for input
  mov ah, 1
  int 21h
  ; temprorily store the input into stack
  push ax

  ; output newline 
  lea dx, [newline]
  mov ah, 9
  int 21h

  ; recover result from stack to al
  pop ax
  ; fetch the result from al to dl
  mov dl, al
  ; increase ascii code by 1
  inc dl
  ; output the result from dl
  mov ah, 2
  int 21h
  
  ; output newline 
  lea dx, [newline]
  mov ah, 9
  int 21h
  
  mov ax, 4c00h
  int 21h

code ends
end start
