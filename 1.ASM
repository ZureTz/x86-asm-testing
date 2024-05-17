stack segment stack
  dw 100h dup(0)
stack ends

data segment
  num dw 100h
data ends

code segment
main proc far
  assume cs:code, ds:data, ss:stack
start:
  mov ax, data
  mov ds, ax
  mov ax, stack
  mov ss, ax

  lea si, [num]
  mov 500h[bp], 200h

  mov ax, 4c00h
  int 21h

main endp
code ends
end start
