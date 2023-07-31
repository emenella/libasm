section	.text
global	ft_list_size

ft_list_size:					; RDI - RAX
	sub		rax,	rax			; Clear RCX
.loop:
	test	rdi,	rdi			; Check for NULL
	jz		.end
	mov		rdi,	[rdi + 8]	; Load next pointer
	inc		rax
	jmp		.loop					; Loop
.end:
	ret