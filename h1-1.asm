data segment
  x dw 0ffffh
  y db 0abh
data ends

stack segment stack
  ; set stack size to 8 words (16 byte)
  dw 0, 0, 0, 0, 0, 0, 0, 0
stack ends

code segment
  assume cs:code, ds:data, ss:stack

start:
  mov ax, data
  mov ds, ax

  mov ax, stack
  mov ss, ax
  mov sp, 10h

  mov ax, [x]
  mov si, ax
  mov al, [y]
  mov dl, al

  mov ax, 4c00h
  int 21h

code ends
end start