section .text
global ft_read
extern	__errno_location

ft_read:
    ; Arguments:
    ; rdi = fd (file descriptor)
    ; rsi = buf (buffer address)
    ; rdx = count (maximum number of bytes to read)

    ; syscall read
    mov     rax, 0      ; sys_read system call number (0 for sys_read)
    syscall             ; Call the kernel to read from the file descriptor specified in rdi

    ; The result (number of bytes read) is returned in rax
    ; Check for errors (rax will be set to -errno if an error occurred)
    test    rax, rax    ; Test if rax is negative (error occurred)
    js      error       ; Jump to the error label if rax is negative

    ret

error:
    neg		rax ; Negative value in rax because the syscall returns errno as a negative value
    mov		rdi, rax ; Move rax to rdi as a buffer, as rax will hold the return value of errno location
    call	__errno_location WRT ..plt ; Call __errno_location with position-independent code
    mov		[rax], rdi ; errno location returns a pointer to errno; store rdi into errno
    mov		rax, -1 ; Set rax to -1 to return the correct value for a write syscall
    ret ; Return rax