org 100h

section .data

; Fancy menu with symbols
bigmenu db 10,13
        db "================================================================",10,13
        db "||                     BOOK MANAGEMENT SYSTEM                 ||",10,13
        db "||============================================================||",10,13
        db "||                                                            ||",10,13
        db "||      --------------- AVAILABLE BOOKS ---------------      ||",10,13
        db "||      1. Math (Rs 500)                                     ||",10,13
        db "||      2. Physics (Rs 600)                                  ||",10,13
        db "||      3. Computer Science (Rs 700)                         ||",10,13
        db "||                                                            ||",10,13
        db "||      ----------------- MAIN MENU ------------------       ||",10,13
        db "||      1. View Books                                        ||",10,13
        db "||      2. Buy Book                                          ||",10,13
        db "||      3. View Cart                                         ||",10,13
        db "||      4. Exit                                              ||",10,13
        db "||                                                            ||",10,13
        db "================================================================",10,13
        db "Enter Choice: $"

books db 10,13,"1. Math (Rs 500)",10,13
      db "2. Physics (Rs 600)",10,13
      db "3. CS (Rs 700)$"

askBook db 10,13,"Select Book (1-3): $"
askQty  db 10,13,"Enter Quantity: $"

cartMsg db 10,13,"+ Book added to cart!$"
invalid db 10,13,"Invalid Input! Try again.$"
stockErr db 10,13,"Not enough stock!$"

cartView db 10,13,"========= YOUR CART =========",10,13,"$"
totalMsg db 10,13,"Total Bill = Rs $"

; Item names for cart display
name1 db "Math$"
name2 db "Physics$"
name3 db "CS$"
mult_str db " x $"
rs_str db " = Rs $"
newline db 10,13,"$"

prices dw 500, 600, 700
stock  db 5, 5, 5
cart   db 0, 0, 0
total  dw 0

section .text

start:
main_menu:
    mov dx, bigmenu
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'

    cmp al, 1
    je near view_books
    cmp al, 2
    je near buy_book
    cmp al, 3
    je near view_cart
    cmp al, 4
    je near exit_prog

    mov dx, invalid
    mov ah, 9
    int 21h
    jmp main_menu

view_books:
    mov dx, books
    mov ah, 9
    int 21h
    jmp main_menu

buy_book:
    mov dx, books
    mov ah, 9
    int 21h

    mov dx, askBook
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '1'          ; 0-based index (0,1,2)
    mov bl, al
    cmp bl, 2
    ja near invalid_input

    mov dx, askQty
    mov ah, 9
    int 21h

    mov ah, 1
    int 21h
    sub al, '0'
    mov bh, al           ; BH = quantity
    cmp bh, 0
    je near invalid_input

    ; check stock
    xor cx, cx
    mov cl, bl
    mov si, cx
    mov al, [stock + si]
    cmp al, bh
    jb near stock_error

    ; reduce stock
    sub [stock + si], bh

    ; update cart
    add [cart + si], bh

    ; calculate total increment
    mov cl, bl
    shl cl, 1            ; word offset
    xor ch, ch
    mov si, cx
    mov ax, [prices + si]
    mul bh               ; AX = price * quantity
    add [total], ax

    mov dx, cartMsg
    mov ah, 9
    int 21h
    jmp main_menu

view_cart:
    mov dx, cartView
    mov ah, 9
    int 21h

    ; display each non-zero cart item
    mov cx, 3
    mov si, 0            ; item index
cart_loop:
    mov al, [cart + si]
    cmp al, 0
    je next_item

    ; save registers
    push cx
    push si

    ; print book name
    call print_book_name
    mov ah, 9
    int 21h

    ; print " x "
    mov dx, mult_str
    mov ah, 9
    int 21h

    ; print quantity
    pop si               ; restore index to get cart[si]
    push si
    mov al, [cart + si]
    xor ah, ah
    call print_num

    ; print " = Rs "
    mov dx, rs_str
    mov ah, 9
    int 21h

    ; compute subtotal = price * cart[si]
    mov al, [cart + si]
    xor ah, ah
    mov bx, ax           ; bx = quantity
    mov ax, si
    shl ax, 1
    mov di, ax
    mov ax, [prices + di]   ; price
    mul bx               ; ax = price * qty
    call print_num

    mov dx, newline
    mov ah, 9
    int 21h

    pop cx               ; restore outer loop counter
next_item:
    inc si
    loop cart_loop

    ; print total bill
    mov dx, totalMsg
    mov ah, 9
    int 21h
    mov ax, [total]
    call print_num

    jmp main_menu

; helper: print book name based on SI (0,1,2)
print_book_name:
    cmp si, 0
    jne .test1
    mov dx, name1
    ret
.test1:
    cmp si, 1
    jne .test2
    mov dx, name2
    ret
.test2:
    mov dx, name3
    ret

invalid_input:
    mov dx, invalid
    mov ah, 9
    int 21h
    jmp main_menu

stock_error:
    mov dx, stockErr
    mov ah, 9
    int 21h
    jmp main_menu

exit_prog:
    mov ah, 0x4c
    int 21h

; ---------- print AX as decimal ----------
print_num:
    mov bx, 10
    xor cx, cx
    xor dx, dx
.next_digit:
    div bx
    push dx
    inc cx
    xor dx, dx
    test ax, ax
    jnz .next_digit
.print_loop:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop .print_loop
    ret