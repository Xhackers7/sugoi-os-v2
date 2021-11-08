org 0x7c00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main



; Prints a string to the screen
; Parameters:
;   - ds:si points to the string
print:
    ; saves the registers to the stack
    push si
    push ax

.loop:
    lodsb           ; loads a byte from the ds:si register and then increments si by the number of bytes loaded
    or al, al       ; checks if the value of al is null(0)
    jz .done
    mov ah, 0x0e
    mov bh, 0
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret


main:

    ; setting up data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    ;  setting up stack
    mov ss, ax
    mov sp, 0x7c00  ; points the stack at the begining of the operating system so it won't override it

    mov si, msg
    call print

    hlt

.halt:
    jmp .halt

msg: db 'Yo man!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h