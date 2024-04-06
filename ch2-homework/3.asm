data segment
  number dw 34433
data ends

code segment
  assume cs:code, ds:data

main:
  ; init
  mov ax, data
  mov ds, ax

  ; ax = number
  mov ax, [number]
  ; using bx as 10
  mov bx, 10
  ; using cl as counter
  mov cl, 0

  ; while ax > 0
  jmp count_cond
count:
  ; ax /= 10
  mov dx, 0
  div bx

  ; counter += (dx == 3) ? 1 : 0
  cmp dx, 3
  jne count_cond
  inc cl

count_cond:
  cmp ax, 0
  ja count
  
  ; print counter
  mov dl, cl
  add dl, '0'
  mov ah, 2h
  int 21h

exit:
  mov ax, 4c00h
  int 21h

code ends
end main