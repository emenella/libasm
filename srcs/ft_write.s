section .text
global ft_write
extern	__errno_location

ft_write:
    ; Arguments:
    ; rdi = fd (file descriptor)
    ; rsi = buf (pointer to the buffer containing the data)
    ; rdx = count (number of bytes to write)

    ; syscall write
    mov     rax, 1          ; sys_write system call number (1 for sys_write)
    syscall                 ; Call the kernel to write to the file descriptor specified in rdi

    ; The result (number of bytes written) is returned in rax
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
