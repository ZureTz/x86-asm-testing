stack segment stack
  dw 256 dup(?)
stack ends

data segment
  str db 30, ?, 30 dup(?)
  newline db 0dh, 0ah, '$'
data ends

code segment
  assume cs:code,ds:data

main proc far
start:
  mov ax, data
  mov ds, ax
  mov ax, stack
  mov ss, ax

  ; input string
  mov ah, 0ah
  lea dx, str
  int 21h

  ; output newline
  mov ah, 09h
  lea dx, [newline]
  int 21h

  ; set cx to current input length
  ; for loop convenience
  mov si, offset str + 1
  mov cl, [si]
  mov ch, 0
  ; set si to the beginning of the string
  mov si, offset str + 2
  ; using al as a counter
  ; initialized to 0
  mov al, 0

counting_loop:
  ; get current character
  mov dl, [si]
  ; if ( dl < '0' or dl > '9' ) : not a digit
  cmp dl, '0'
  jb is_not_number
  cmp dl, '9'
  ja is_not_number
  ; else: it is a number
  jmp counting_loop_exit

is_not_number:
  inc al

counting_loop_exit:
  inc si
  loop counting_loop

  ; using bl = 10
  mov bl, 10
  ; using cx as counter of digits
  mov cx, 0

  ; while (al > 0) :
  jmp pre_output_cond
pre_output:
  ; set ah to 0
  mov ah, 0
  div bl
  ; remainder is stored in ah
  push ax
  ; cx++
  inc cx
  
pre_output_cond:
  cmp al, 0
  ja pre_output

  ; output the number
output:
  pop dx
  mov ah, 02h
  ; set remainder
  mov dl, dh
  ; convert to char
  add dl, '0'
  int 21h

  loop output

  mov ax, 4c00h
  int 21h

main endp
code ends
end start
