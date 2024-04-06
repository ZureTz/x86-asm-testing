data segment
  A db 0, 35, 1, 2, 65, 75, 85, 95
  B db 1, 33, 2, 2, 60, 69, 78, 87
  C db 8 dup(0)
  ; 0: +; 1: -
  logic_ruler db 11110010b
data ends

code segment
  assume cs:code, ds:data
main:
  ; init
  mov ax, data
  mov ds, ax

  ; using dl to store logic ruler
  mov dl, [logic_ruler]
  mov bx, 0
  ; for (bx = 0; bx < 8; bx++)
  jmp process_cond
process:
  shr dl, 1
  jc substraction
  jmp addtion

addtion:
  mov al, A[bx]
  add al, B[bx]
  mov C[bx], al

  inc bx
  jmp process_cond

substraction:
  mov al, A[bx]
  sub al, B[bx]
  mov C[bx], al

  inc bx
  jmp process_cond

process_cond:
  cmp bx, 8
  jl process

  ; for (bx = 0; bx < 8; bx++)
  mov bx, 0
print:
  ; print digit
  mov dl, C[bx]
  add dl, '0'
  mov ah, 2h
  int 21h
  ; print space
  mov dl, ' '
  mov ah, 2h
  int 21h

  ; bx++
  inc bx

print_cond:
  cmp bx, 8
  jl print

  mov ax, 4c00h
  int 21h

code ends
end main
