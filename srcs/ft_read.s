section .text
global ft_read
extern	__errno_location

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
	neg		rax			; car le syscall renvoie dans rax errno mais en negatif
	mov		rdi, rax		; rdi sert de tampon car apres rax prendera le retour de errno location
	call	__errno_location WRT ..plt	; errno location renvoie un pointeur sur errno
	mov		[rax], rdi		; ici rax contient l'adresse de errno donc en faisant ca on met rdi dans errno
	mov		rax, -1			; on met rax à -1 pour renvoyer la bonne valeur d'un appel à write
	ret					; return rax