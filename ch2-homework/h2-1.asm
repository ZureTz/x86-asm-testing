data segment
  A db 0, 35, 1, 2, 65, 75, 85, 95
  B db 1, 33, 2, 2, 60, 69, 78, 87
  C db 8 dup(0)
  logic_ruler db 11110010b ; 0: add, 1: sub
data ends

code segment
  assume cs:code, ds:data

main:
  mov ax, data
  mov ds, ax

  ; using dl as logic ruler
  mov dl, [logic_ruler]
  mov bx, 0
  ; for (int i = 0; i < 8; i++)
process:
  ; do addition or substraction
  shr dl, 1
  ; if carry (the least significant digit is 1), goto sub
  jc substraction
  ; else, add
addition:
  ; C[bx] = A[bx] + B[bx]
  mov al, A[bx]
  add al, B[bx]
  mov C[bx], al
  jmp end_process

substraction:
  mov al, A[bx]
  sub al, B[bx]
  mov C[bx], al
  jmp end_process
  
end_process:
  inc bx
  cmp bx, 8
  jl process

  ; do 8 iterations to output
  ; for (int i = 0; i < 8; i++)
  mov bx, 0
output:
  ; print number
  mov dl, C[bx]
  add dl, '0'
  mov ah, 2h
  int 21h
  ; print space
  mov dl, ' '
  mov ah, 2h
  int 21h

end_output:
  inc bx
  cmp bx, 8
  jl output

  mov ax, 4c00h
  int 21h

code ends
end main
