section	.text
extern	malloc
global	ft_list_push_front

ft_list_push_front:				; RDI, RSI - RAX, R10
	push	rdi
	push	rsi
	mov		rdi,		16
	sub		rsp,		8		; Align stack to 16 bytes
	call	malloc WRT ..plt	; malloc(sizeof(t_list))
	add		rsp,		8		; Restore alignment
	pop		rsi
	pop		rdi
	test	rax, rax			; Check for NULL
	jz		.end
	mov		[rax],		rsi
	mov		r10,		[rdi]	; Dereference RDI
	mov		[rax + 8],	r10
	mov		[rdi],		rax
.end:
	ret