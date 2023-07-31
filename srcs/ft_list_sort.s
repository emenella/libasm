section	.text
global	ft_list_sort

ft_list_sort:
		push	rbp
		mov		rbp, rsp

		mov		rdx, rdi
		mov		r11, rsi

		mov		r8, [rdx]

_do1:
		cmp		r8, 0			;a == NULL
		je		_end
		mov		r9, [rdx]

_do2:
		mov		r10, [r9+8]		;b->next == NULL
		cmp		r10, 0
		je		_next1

		mov		rdi, [r9]		;prepare strcmp
		mov		rsi, [r10]

		push	r11
		push	r10
		push	r9
		push	r8
		push	rdx
		sub		rsp, 8

		call	r11				;call (*cmp)()

		add		rsp, 8
		pop		rdx
		pop		r8;
		pop		r9;
		pop		r10
		pop		r11

		cmp		rax, -1			;return strcmp
		je		_next2
		cmp		rax, 0
		je		_next2

		mov		rsi, [r9]		;data = list->data
		mov		rdi, [r10]		;data2 = list->next->data
		mov		[r9], rdi		;list->data = data2
		mov		[r10], rsi		;list->next->data = data

_next2:
		mov		r9, [r9+8]		;b = b->next
		jmp		_do2

_next1:
		mov		r8, [r8+8]		;a = a->next
		jmp		_do1

_end:
		leave
		ret
