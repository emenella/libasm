section .text
global ft_read

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
    ; An error occurred, set rax to the negative value (error code) and return
    neg     rax         ; Negate rax to get the negative error code
    ret