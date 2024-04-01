; find the byte in ffff:0006 and multiply it by 3
; store the result in register dx
; loop must be used

codesg segment
  assume cs:codesg
  
start:
  mov ax, 0ffffh
  mov ds, ax  ; let ds to be ffffh
  mov bx, 6 ; if access memory, the offset must be in bx (base register)
  mov al, [bx]  ; load byte into al
  mov ah, 0 ; let ah to be 0 to erase garbage data
  mov dx, 0 ; set dx to be 0

  ; for (int i = 0; i < 3; i++) { ... }
  mov cx, 3
multiply:
  add dx, ax
  loop multiply
  
  ; program ends
  mov ax, 4c00h
  int 21h
codesg ends
end start