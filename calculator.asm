; create and developed by hamid reza nadi moghadam
; e-mail: hrnm2003@gmail.com

org 100h

.data

menumsg: db 9,9,9,"--[ Calculator ]--",10,10,10,13,9,"1- Addtion (x+y)",13,10,9,"2- Subtraction (x-y)",13,10,9,"3- Multiplication (x*y)",13,10,9,"4- Dividation (x/y)", 13,10,9,"5- Eulers Power (e^x)",13,10,9,"0- Exit", 13,10,10,9,"Select an option: $"

firstmsg: db 13,10,9,"Enter First Number: $"
secondmsg: db 13,10,9,"Enter Second Number: $"
wrongoption: db 13,10,10,9,"Wrong Option",13,10,9,"press any key to choose another option ... $"
resultmsg: db 13,13,10,9,"Result: $"
presskey db 13,10,10,"press any key back to main menu ... $"  
exitmsg: db 13,10,"thank you for using my calculator.",13,10,9,"press any key to exit ... $"

.code
main:
    ;clear screen
    call clear
    
    ;display the main menu
    mov ah, 9
    mov dx, offset menumsg
    int 21h
    
    ;read option from keyboard
    mov ah, 1                      
    int 21h
    
    ;compare al regsiter and goes to the right function
    
    ;if user select 1 jump to addtion operator
    cmp al, '1'
    je sum
    
    ;if user select 2 jump to subtraction operator
    cmp al, '2'
    je subtract
    
    ;if user select 3 jump to multiplication operator
    cmp al, '3'
    je multiply
    
    ; if user select 4 jump to division operator
    cmp al, '4'
    je divide
    
    
    ;if user select 6 jump to euler operator
    cmp al, '5'
    je euler
    
    ;if user select 0 exit the program
    cmp al, '0'
    je exit
   
    jmp main


        
sum:
    ;clear screen
    call clear
    
    
    ;display string for entering first number
    mov ah, 09h
    mov dx, offset firstmsg
    int 21h
    
    
    ;cx specifies the maximum number of digits that user can enter (it use in get_oprand function)
    mov cx, 8
    call get_operand
    ;store the first operand in stack to avoid getting lost
    push si
    push di
    
    
    ;display string for entering second number
    mov ah, 09h
    mov dx, offset secondmsg
    int 21h
    
    
    ;cx specifies the maximum number of digits that user can enter (it use in get_oprand function)
    mov cx, 8
    call get_operand    
    
    
    ;restore first oprand from stack
    pop cx
    pop bx
    
    
    ;--------------------------------
    ;add two number
    ;first  number in cx-bx (msb-lsb)
    ;second number in di-si (msb-lsb)
    ;                 ---------------
    ;answer number in bx-cx (msb-lsb)
    ;--------------------------------
    
    ;add two lsb together
    add bx, si
    ;add two msb together with carry in pervious instruction
    adc cx, di
    
    ;clear di and si
    mov si, 0
    mov di, 0
    
    
    ;dispaly string
    call print
    ;display number in di, si, cx and bx respectively
    call show
    ;dispaly string and wait for user to press any key
    call pressakey
    ;jump to main menu
    jmp main



subtract:
    ;clear screen
    call clear
    
    
    ;display string for entering first number
    mov ah, 09h
    mov dx, offset firstmsg
    int 21h
    
    
    ;cx specifies the maximum number of digits that user can enter (it use in get_oprand function)
    mov cx, 8
    call get_operand
    ;store the first operand in stack to avoid getting lost
    push si
    push di
    
    
    ;display string for entering second number
    mov ah, 09h
    mov dx, offset secondmsg
    int 21h
    ;cx specifies the maximum number of digits that user can enter (it use in get_oprand function)
    mov cx, 8
    call get_operand
    
    ;restore first oprand from stack
    pop cx
    pop bx

    
    ;--------------------------------
    ;subtract two number
    ;first  number in cx-bx (msb-lsb)
    ;second number in di-si (msb-lsb)
    ;                 ---------------
    ;answer number in bx-cx (msb-lsb)
    ;--------------------------------
    
    ;subtract two lsb together
    sub bx, si
    ;subtract two msb together with borrow in pervious instruction
    sbb cx, di
    
    ;clear di and si
    mov di, 0
    mov si, 0
    
    
    ;dispaly string
    call print
    ;display number in di, si, cx and bx respectively
    call show
    ;dispaly string and wait for user to press any key
    call pressakey
    ;jump to main menu
    jmp main
    

multiply:
    ;clear screen
    call clear
    
    
    ;display string for entering first number
    mov ah, 09h
    mov dx, offset firstmsg
    int 21h
    
    
    ;cx specifies the maximum number of digits that user can enter (it use in get_oprand function)
    mov cx, 8
    call get_operand
    ;store the first operand in stack to avoid getting lost
    push si
    push di
    
    
    ;display string for entering second number
    mov ah, 09h
    mov dx, offset secondmsg
    int 21h
    
    
    ;cx specifies the maximum number of digits that user can enter (it use in get_oprand function)
    mov cx, 8
    call get_operand
    
    ;restore first oprand from stack
    pop bx
    pop bp
    
    
    ;multiply two number
    ;first  number in bx-bp (msb-lsb)
    ;second number in di-si (msb-lsb)
    call multiplication
    ;                 ---------------
    ;answer number in di-si-cx-bx (msb to lsb)
    
    ;dispaly string
    call print
    ;display number in di, si, cx and bx respectively
    call show
    ;dispaly string and wait for user to press any key
    call pressakey
    ;jump to main menu
    jmp main


divide:
    ;clear screen
    call clear
    
    
    ;display string for entering first number
    mov ah, 09h
    mov dx, offset firstmsg
    int 21h
    
    ;cx specifies the maximum number of digits that user can enter (it use in get_oprand function)
    mov cx, 4
    call get_operand
    ;store the first operand in stack to avoid getting lost
    push si
    
    
    ;display string for entering second number
    mov ah, 09h
    mov dx, offset secondmsg
    int 21h
        
    ;cx specifies the maximum number of digits that user can enter (it use in get_oprand function)
    mov cx, 4
    call get_operand
    ;second number in si
    
    
    ;if second number is zero jump to divide address
    cmp si, 0
    je divide
    
    
    pop ax     ;put first number in ax
    mov dx, 0  ;to ensure dx is clear
    div si     ;firstnumber/second number -- ax divided by si (quotient will be in ax & remainder will be in dx)
    
    push si    ;store the second number
    push dx    ;store the remainder
    
    
    ;display quotient
    mov di, 0
    mov si, 0
    mov cx, 0
    mov bx, ax
    
    
    ;dispaly string
    call print
    ;display number in di, si, cx and bx respectively
    call show
    
    
    ;display decimal
    pop ax          ;store the remainder
    pop bp          ;store the second number
    cmp ax, 0
    je nofloat      ;jump if remainder is zero (dm't display decimal)
    call floatdiv   ;remainder divided by second number
    call floatshow  ;display the decimal number after quotient (quotient.decimal)
    nofloat:        
    ;dispaly string and wait for user to press any key
    call pressakey
    ;jump to main menu
    jmp main


euler:
    ;clear screen
    call clear
    
    
    ;display string for entering first number
    mov ah, 09h
    mov dx, offset firstmsg
    int 21h
    
    mov cx, 2
    call get_operand
    ;push si ;x
    
    
    ;-----------------------------------------
    ;first step (1 + x)
    ;pop ax ;x
    mov ax, si
    inc ax
    mov bx, 10000
    mul bx
    push dx
    push ax
    
    
    ;-----------------------------------------
    ;second step (1/2! * x^2)
    mov ax, si
    mul si          ;x^2 (dx-ax)
    push ax         ;save x^2
    mov bx, 15000
    mul bx          ;15000 * x^2 (answer will be in dx-ax)
    ;mov bx, ax
    ;mov cx, dx      ;15000 * x^2 (cx-bx)
    pop bp          ;save x^2
    push dx         ;store answer in stack -- 15000 * x^2 (answer will be in dx-ax)
    push ax         ;store answer in stack -- 15000 * x^2 (answer will be in dx-ax)
    mov ax, bp
    mov dx, 0
    mov bx, 10000
    mul bx
    
    pop bx
    pop cx
    ;15000 * x^2 (cx-bx)
    ;15000 * x^2 (dx-ax)
    sub bx, ax
    sbb cx, dx
    
    push bx
    push cx
    
    
    ;-----------------------------------------
    ;third step (1/3! * x^3)
    mov ax, si
    mul si              ;x^2 (dx-ax)
    mul si              ;x^3 (dx-ax)
    push si             ;save x
    push si             ;save x
    push ax             ;save x^3
    push dx             ;save x^3
    mov bp, 11666
    mov bx, 0
    mov si, ax
    mov di, dx
    call multiplication ;11666 * x^3 (answer will be in si-cx-bx)
    pop dx
    pop ax
    pop bp
    push si
    push cx
    push bx
    mov bp, ax
    mov bx, 0
    mov si, 10000
    mov di, 0
    call multiplication ; x^3 * 1000
    pop ax
    pop dx
    pop bp
    
    sub ax, bx
    sbb dx, cx
    sbb bp, si    
    pop si
    push bp
    push dx
    push ax
    
    ;-----------------------------------------
    ;fourth step (1/4! * x^4)
    mov ax, si
    mul si ;x^2 (dx-ax)
    mul si ;x^3 (dx-ax)
    ;push si ;save x    
    mov bx, dx
    mov bp, ax 
    mov di, 0
    call multiplication
    ;pop si
    push cx ;save x^4
    push bx ;save x^4    
    ;10416 * x^4
    mov si, bx
    mov di, cx
    mov bp, 10416
    mov bx, 0
    call multiplication
    ;10416 * x^4 (si-cx-bx)
    pop bp
    pop ax ; x^4
    push si
    push cx
    push bx
    mov bx, ax
    mov si, 10000
    mov di, 0
    ; x^4 * 1000
    call multiplication
    
    
    
    ;--
    ;bp-dx-ax
    ;si-cx-bx
    pop ax
    pop dx
    pop bp
    
    sub ax, bx
    sbb dx, cx
    sbb bp, si
    
    ;-- addition of step 3 and 4
    pop bx ; lsb
    pop cx
    pop di ; msb
    
    add ax, bx
    adc dx, cx
    adc bp, di
    
    ;-- addition of step 3 and 4 and 2
    pop bx ; msb
    pop cx ; lsb
    
    add ax, cx
    adc dx, bx
    adc bp, 0
    
    ;-- addition of step 3 and 4 and 2 and 1
    pop bx ; lsb
    pop cx ; msb
    
    add ax, bx
    adc dx, cx
    adc bp, 0
    
    
    mov di, 0
    mov si, bp
    mov cx, dx
    mov bx, ax
    
    
    
    call print
    call show

    call pressakey
    jmp main    

exit:
    call clear
    mov ah, 9
    mov dx, offset exitmsg
    call pressakey
    .exit


clear proc
    mov ax, 3
    int 10h
    ret   
clear endp


get_operand proc
    mov si, 0           ;for first time si is 0
    mov di, 0           ;to ensure that di is clear
    mov bx, 10          ;constant multipler
    
    next:
        mov ah, 1       ;read a number
        int 21h         ;execute int 21h and read assci code and put it in al
        cmp al, 13      ;check if user press enter key
        je break        ;jump to break
        
        mov ah, 0       ;to ensure that right number will store in stack
        sub al, 30h     ;convert ascii code of number to a number
        push ax         ;store number in stack
        
        ;least significant bit part
        mov ax, si      ;put pervious number (first time is 0) in ax (lsb)
        mul bx          ;multiply pervious number (si) by bx (10) and answer will be in dx-ax
        mov si, ax      ;dx-si = si*bx
        push dx         ;store msb in stack
        
        ;most significant bit part
        mov ax, di      ;put pervious number (first time is 0) in ax (msb)      
        mul bx          ;multiply pervious number (di) by bx (10) and answer will be in dx-ax
        mov di, ax      ;dx-di = di*bx
        
        pop ax          ;restore msb in stack of least significant bit part (dx pervious step)
        add di, ax      ;msb of least significant part add with lsb of most significant bit part
        
        pop ax          ;restore number from stack
        add si, ax      ;add number with lsb
        adc di, 0       ;if has carry add with msb
        
        dec cx          ;decrement cx by 1
        
        cmp cx, 0       ;compare cx with 0
        je break        ;if cx is zero, we rich the maximum digits
        jmp next        ;jump to add another digit or enter
    
    break:
    ;user number in ;di-si (msb-lsb)
    ret
    
get_operand endp


multiplication proc
    ;multiply two number
    ;first  number in bx-bp (msb-lsb)
    ;second number in di-si (msb-lsb)
    ;                 ---------------
    ;answer number in di-si-cx-bx (msb to lsb)
    
    
    ;first step
    mov ax, bp      ;
    mul si          ;bp(ax) multiply by si and answer will be in dx-ax
    push ax         ;store ax in stack (lsb of final answer)
    mov cx, dx      ;move cx to dx to enusure in safe palce

    
    ;second step
    mov ax, bx      ;
    mul si          ;bx(ax) multiply by si and answer will be in dx-ax
    add cx, ax      ;add msb of previous step with lsb current step
    mov si, 0       ;put zero in si
    jnc loo         ;if previous add instruction doesn't have the carry jump to loo address
    mov si, 1       ;if add instruction has carry then si will be 1
    loo:            
    push si         ;store si in stack (carry flag store in stack) biroon2
    push cx         ;store cx in stack (dx1 + ax2)
    mov cx, dx      ;store msb multiply in cx

    
    ;third step
    mov ax, bp      ;
    mul di          ;bp(ax) multiply by di and answer will be in dx-ax
    pop si          ;out of stack (dx1 + ax2)
    add si, ax      ;si = ax3 + ax2 + dx1
    adc cx, dx      ;cx = dx3 + dx2
    pop ax          ;restore from stack (carry add ax2 + dx1) biroon2
    add cx, ax      ;cx = dx3 + dx2 + carry step 2 (check carry)
    push si         ;store in stack (ax3 + ax2 + dx1)

    
    ;foruth step
    mov ax, bx      ;
    mul di          ;bx(ax) multiply by di and answer will be in dx-ax
    add cx, ax      ;cx = ax4 + dx3 + dx2 
    push cx         ;store in stack
    adc dx, 0       ;add carry previous with dx 
    push dx         ;store in stack
    
    
    ;only answer available in stack
    pop di
    pop si
    pop cx
    pop bx
    
    ret
multiplication endp

floatdiv proc
    mov dx, 0
    ; ax / bp
    div bp
    mov bx, 10      ;constant mutiplier
    
    cmp dx, 0       ;baghi mande dar di
    je breakpoint   ;age baghi mande sefr bood ashar anjam nashavad
    
    mov cx, 4       ;yani deghat ashar
    
    repeatdecimal:
    
        mov ax, dx  ;baghimandeh * 10
        mul bx      ;baghimandeh * 10 (dx-ax)
        
        div bp      ;java baghimandeh * 10 / add = dx-ax
        push ax     ;yeki az javabha
        
        dec cx
        cmp dx, 0   ;age baghimandeh sefr shod halghe tamam
        je stack
        
        
        cmp cx, 0   ;age 4 add dar amad halghe tamam
        jne repeatdecimal
    
    
    stack:
    mov ax, 4
    sub ax, cx
    mov cx, ax
    
    ;DI:SI:CX:BX
    cmp cx, 4
    je fourstack
    
    cmp cx, 3
    je threestack
    
    cmp cx, 2
    je twostack
    
    cmp cx, 1
    je onestack
    
    
    fourstack:
    pop di
    pop si
    pop cx
    pop bx
    jmp endreverse
    
    threestack:
    pop si
    pop cx
    pop bx
    mov di, 0
    jmp endreverse
    
    twostack:
    pop cx
    pop bx
    mov si, 0
    mov di, 0
    jmp endreverse
    
    onestack:
    pop bx
    mov cx, 0
    mov si, 0
    mov di, 0
    jmp endreverse
    
    ;answer in di-si-cx-bx
    
    
    endreverse:
    
    mov bp, 10
    mov dx, 1
    mov ax, dx
    mul bp
    add ax, bx
    ;------------------
    mul bp
    add ax, cx
    ;------------------
    mul bp
    add ax, si
    ;------------------
    mul bp
    add ax, di
    
    mov bx, ax
    
    ;final answer in bx
    
    breakpoint:
    ret
floatdiv endp


print proc
    ;avoid missing the ax & dx register
    push ax
    push dx
    mov ah, 9
    mov dx, offset resultmsg
    int 21h
    ;restore ax & dx register
    pop dx
    pop ax
    
    ret
print endp


show proc
    ;Displaying number in DI-SI-CX-BX
    mov bp, 10          ;constant divider
    push bp
    
    Next2:
        xor dx, dx
        xchg ax, di     ;msb is in DI
        div bp          ;Divide Word3
        xchg di, ax
        xchg ax, si
        div bp          ;Divide Word2
        xchg si, ax
        xchg ax, cx
        div bp          ;Divide Word1
        xchg cx, ax
        xchg ax, bx     ;lsb is in BX
        div bp          ;Divide Word0
        mov bx, ax
        
        push dx         ;every remainder is between 0 to 9
        
        or ax, cx       ;or all quotients together
        or ax, si
        or ax, di
        jnz Next2       ;repeat while for number not zero
        
        pop dx          ;first pop (Is digit for sure)
        
        pir:
        
        add dl, 30h     ;convert to character
        mov ah, 02h     ;
        int 21h         ;display number on screen
        pop dx          ;(1b) All remaining pops
        cmp dx, bp      ;dx never 0Ah
        jb pir          ;repeat if below 10
    
    ret     
show endp

floatshow proc
    ;number in bx
    mov bp, 10      ;constant divider
    mov ax, bx
        
    firsts:
        div bp          ;quotient in ax & remainder in dx
        cmp ax, 0
        je bir
        push dx
        mov dx, 0
        jmp firsts
    
    bir:
        mov ah, 2
        mov dx, '.'
        int 21h
    
    mov cx, 4
    next_digit:
    mov ah, 2h
    pop dx
    add dx, 30h
    int 21h
    loop next_digit
    ret
    
floatshow endp

pressakey proc
    mov dx, offset presskey
    mov ah, 9
    int 21h
    mov ah, 1
    int 21h
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov dx, 0
    mov si, 0
    mov di, 0
    ret   
pressakey endp