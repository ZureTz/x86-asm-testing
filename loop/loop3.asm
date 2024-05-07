stack segment stack
  dw 16 dup(0)
stack ends

data segment
  array dw 100 dup(?)
  sum dw ?
data ends

code segment
  assume cs:code, ds:data, ss:stack

main proc far
start:
  mov ax, data
  mov ds, ax
  mov ax, stack
  mov ss, ax
  
  call gen_data

  mov ax, 4c00h
  int 21h

main endp

gen_data proc near
  mov si, 0
  ; for (int i = 0; i < 100; i++)
  jmp l1_cond
l1:
  ; ax = si + 1
  mov ax, si
  add ax, 1
  ; array[si] = si + 1
  mov array[si], ax
  inc si
l1_cond:
  cmp si, 100
  jl l1

  ret
gen_data endp

code ends
end start