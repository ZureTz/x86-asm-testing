assume cs:codeseg
codeseg segment
   mov ax, 2
   mov bx, 2
   mov cx, 11

s:
   ; add ax, ax
   ; is the same as
   mul bx ; bx == 2 
   loop s

   mov ax, 4c00h
   int 21h
codeseg ends
end
