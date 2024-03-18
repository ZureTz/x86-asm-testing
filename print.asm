stack segment

stack ends  

data segment
  message db 'Please input a character: $'
  new_line db 0dh, 0ah, '$'
data ends

code segment
  assume cs:code, ds:data, ss:stack
  main proc far

start:
  mov ax, data
  mov ds, ax
  
  ; Output message and new line character
  lea dx, [message]
  mov ah, 9
  int 21h
  lea dx, [new_line]
  mov ah, 9
  int 21h
  
  mov ax, 4c00h
  int 21h

code ends
end start
