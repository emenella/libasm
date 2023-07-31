section .text
global ft_strcmp

ft_strcmp:
    ; Arguments:
    ; rdi = s1 (pointer to the first string)
    ; rsi = s2 (pointer to the second string)

    xor     rcx, rcx        ; Initialize rcx to zero (character counter)

cmp_loop:
    mov     al, [rdi + rcx] ; Load a byte from the first string into al
    mov     dl, [rsi + rcx] ; Load a byte from the second string into dl
    cmp     al, dl          ; Compare the characters

    ; Jump to the appropriate label based on the comparison result
    je      equal           ; Jump to equal if the characters are equal
    jne     not_equal       ; Jump to not_equal if the characters are not equal

equal:
    test    al, al          ; Check if we reached the end of the string (null character)
    jz      end             ; If al is zero, we reached the end of s1

    ; Characters are equal, continue comparing the next characters
    inc     rcx             ; Increment the character counter (move to the next character)
    jmp     cmp_loop        ; Jump back to the beginning of the loop

not_equal:
    ; Characters are not equal, set the return value to the difference of the characters
    sub     al, dl          ; Subtract the characters to get the difference
    movsx   rax, al         ; Sign-extend the difference to 64 bits
    ret

end:
    ; Both strings are equal, set the return value to 0
    xor     rax, rax
    ret
