stack segment stack
  ; 16 bytes data
  dw 16 dup(0)
stack ends

data segment
  output_number dw 32767
  flag dw 0
data ends

code segment
  assume cs:code, ds:data, ss:stack
main:
  mov ax, data
  mov ds, ax
  mov ax, stack
  mov ss, ax

  ; ax to store number
  mov ax, [output_number]
  ; be used in div by 10
  mov bx, 10
  ; cx as counter
  mov cx, 0

  cmp ax, 0
  jne is_negative_cond

  ; if num == 0
output_zero:
  mov dl, '0'
  mov ah, 2h
  int 21h
  jmp exit

is_negative_cond:
  ; find pos or neg
  mov dx, ax
  and dx, 8000h
  cmp dx, 0
  ; if num > 0, then dx is 0
  je push_num_cond
  ; else: num < 0
  ; neg ax
  not ax
  add ax, 1
  ; set flag to true
  mov [flag], 1  
  jmp push_num_cond

push_num:
  ; higher dx MUST be 0 !!
  mov dx, 0
  div bx
  push dx
  ; counter++
  inc cx
push_num_cond:
  ; while ax > 0
  cmp ax, 0
  ja push_num

  mov ax, [flag]
  cmp ax, 0
  ; if flag is 0: positive
  je out_num

  ; output neg
  mov dl, '-'
  mov ah, 2h
  int 21h

out_num:
  pop dx
  add dl, '0'
  mov ah, 2h
  int 21h

  loop out_num

exit:
  mov ax, 4c00h
  int 21h

code ends
end main