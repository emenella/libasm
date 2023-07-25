section .text
global ft_strcpy
global ft_strncpy

extern ft_strlen

ft_strncpy:			; RDI, RSI, RDX - RAX, RCX
	mov		rax, rdi	; Set RAX to dest
	mov		rcx, rdx	; Set RCX to RDX
	cld					; Clear DF / go forward
	rep		movsb		; Copy RCX bytes from RSI to RDI
	ret

ft_strcpy:				; RDI, RSI
	push	rdi			; Save RDI
	mov		rdi, rsi	; Put RSI into RDI
	call	ft_strlen	; Get total length
	pop		rdi			; Restore RDI
	mov		rdx, rax	; Put length into RDX
	inc		rdx			; Increment RDX to give size
	sub		rsp, 8		; Align stack to 16 bytes
	call	ft_strncpy	; Copy total string
	add		rsp, 8		; Restore alignment
	ret
