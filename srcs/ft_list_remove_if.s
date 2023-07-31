section	.text
;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
global	ft_list_remove_if		; RDI, RSI, RDX, RCX - RBX!, R12!, R13!, R14!, R15!

extern	free

ft_list_remove_if:
	mov		r12,	rdi			; Set R12 to RDI
	mov		r13,	[r12]		; Set R13 to list pointer
	mov		r15,	rdx			; Set R15 to (*cmp)()
	mov		rbx,	rcx			; Set RBX to (*free_fct)(void*)
	push	rsi					; Store *data_ref
.start:
	test	r13,	r13			; Check for NULL
	jz		.end				; End on NULL
	mov		rdi,	[r13]		; Set RDI to data pointer
	pop		rsi					; Restore *data_ref
	push	rsi					; Store *data_ref
	call	r15					; cmp(RDI, RSI)
	test	eax,	eax			; Check for match
	jnz		.loop				; Continue loop if no match
	call	rbx					; free_fct(RDI)
	mov		rdi,	r13			; Set RDI to list pointer
	mov		r13,	[r13 + 8]	; Set R13 to next pointer
	call	free				; free(RDI)
	mov		[r12],	r13			; Set *R12 to next pointer
	jmp		.start				; Loop on next pointer
.loop:
	mov		r14,	[r13 + 8]	; Set R14 to next pointer
	test	r14,	r14			; Check for NULL
	jz		.end				; End on NULL
	mov		rdi,	[r14]		; Set RDI to data pointer
	pop		rsi					; Restore *data_ref
	push	rsi					; Store *data_ref
	call	r15					; cmp(RDI, RSI)
	test	eax,	eax			; Check for match
	jz		.delete				; Delete if matching
	mov		r13,	r14			; Set R13 to list pointer
	jmp		.loop				; End on NULL
.end:
	pop		rsi					; Restore RSI
	ret
.delete:
	call	rbx					; free_fct(RDI)
	mov		rdi,	r14			; Set RDI to list pointer
	mov		r14,	[r14 + 8]	; Set R14 to next pointer
	call	free				; free(RDI)
	mov		[r13 + 8], r14		; Set previous next pointer to R14
	jmp		.loop				; Continue loop