section	.text
global ft_strlen

ft_strlen:
    push  rcx               ; save and clear out counter
    xor   rcx, rcx

ft_strlen_next:
    cmp   [rdi], byte 0     ; null byte yet?
    jz    ft_strlen_null    ; yes, get out

    inc   rcx               ; char is ok, count it
    inc   rdi               ; move to next char
    jmp   ft_strlen_next    ; process again

ft_strlen_null:
    mov   rax, rcx          ; rcx = the length (put in rax)
    pop   rcx               ; restore rcx
    ret                     ; get out