code segment
  org 100h
  assume cs:code, ds:code, ss:code

main proc far
  ; output the prompt message
  mov ah, 09h
  lea dx, [message]
  int 21h

  ; input the string
  mov ah, 0ah
  lea dx, [string]
  int 21h

  call stat_count
  
  mov al, [digit_count]
  mov ah, 0
  call print_num
  
  mov al, [alpha_count]
  mov ah, 0
  call print_num

  ; exit
  mov ax, 4c00h
  int 21h

main endp

stat_count proc near
  mov cl, [string + 1]
  mov ch, 0

  ; if length = 0, return
  cmp cx, 0
  je exit

  mov si, 2

  ; digits
L1:
  cmp string[si], '0'
  jb L2
  cmp string[si], '9'
  ja L2

  inc [digit_count]
  jmp L4
  ; lower alphas
L2:
  cmp string[si], 'a'
  jb L3
  cmp string[si], 'z'
  ja L3

  inc [alpha_count]
  jmp L4

  ; upper alphas
L3:
  cmp string[si], 'A'
  jb L4
  cmp string[si], 'Z'
  ja L4

  inc [alpha_count]
  jmp L4

L4:
  inc si
  loop L1

exit:
  ret

stat_count endp

; print number stored in ax
print_num proc near
  ; while ax > 0

print_num endp

  string db 128, ?, 128 dup(?)
  digit_count db 0
  alpha_count db 0
  
  message db 'Please input a string: $'
  newline db 0dh, 0ah, '$'
  digit_result db 'Digits: $'
  alpha_result db 'Alphas: $'

code ends
end main