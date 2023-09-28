section .text
global ft_list_remove_if

extern free

ft_list_remove_if:
    mov r12, rdi             ; Set R12 to RDI (begin_list)
    mov r15, rdx             ; Set R15 to cmp function
    mov rsi, [rsp + 8]       ; Load data_ref from the stack

.start:
    mov rdi, [r12]           ; Load data from the current node
    test rdi, rdi            ; Check for NULL
    jz .end                  ; End of the list

    ; Call the cmp function
    push rdi                 ; Push data
    push rsi                 ; Push data_ref
    call r15                 ; cmp(data, data_ref)
    add rsp, 16              ; Restore the stack

    test eax, eax            ; Check for a match
    jnz .loop                ; Continue loop if no match

    ; Call the free_fct function
    push rdi                 ; Push data to free
    call rbx                 ; free_fct(data)
    add rsp, 8               ; Restore the stack

    ; Remove the current node from the list
    mov rdi, [r12 + 8]       ; Load the next node
    call free                ; Free the current node
    mov [r12], rdi           ; Update the pointer in begin_list

    jmp .start               ; Loop to the next node

.loop:
    mov r13, r12             ; Set R13 to the previous node
    mov r12, [r12 + 8]       ; Set R12 to the next node
    test r12, r12            ; Check for NULL
    jz .end                  ; End of the list

    ; Call the cmp function for the next node
    mov rdi, [r12]           ; Load data from the next node
    push rdi                 ; Push data
    push rsi                 ; Push data_ref
    call r15                 ; cmp(data, data_ref)
    add rsp, 16              ; Restore the stack

    test eax, eax            ; Check for a match
    jz .delete               ; Continue loop if no match
	mov	r13, r14			; Set R13 to list pointer
	jmp	.loop				; End on NULL

.delete:
    ; Call the free_fct function for the matching node
    push rdi                 ; Push data to free
    call rbx                 ; free_fct(data)
    add rsp, 8               ; Restore the stack

    ; Remove the matching node from the list
    mov rdi, [r12 + 8]       ; Load the next node
    call free                ; Free the matching node
    mov [r13 + 8], rdi       ; Update the previous node's next pointer

    jmp .loop                ; Continue loop

.end:
    ret
