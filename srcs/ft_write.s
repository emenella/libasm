section .text
global ft_write

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
    test    rax, rax        ; Test if rax is negative (error occurred)
    js      error           ; Jump to the error label if rax is negative

    ret

error:
    ; An error occurred, set rax to the negative value (error code) and return
    neg     rax             ; Negate rax to get the negative error code
    ret
