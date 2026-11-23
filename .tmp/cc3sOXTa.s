	.file	"math_prime_util-families.adb"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__finalize
	.type	math_prime_util__families__lucky_vectors__implementation__finalize, @function
math_prime_util__families__lucky_vectors__implementation__finalize:
.LFB4:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L1
	movq	$0, 8(%rdi)
.L1:
	ret
	.cfi_endproc
.LFE4:
	.size	math_prime_util__families__lucky_vectors__implementation__finalize, .-math_prime_util__families__lucky_vectors__implementation__finalize
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__finalize__2
	.type	math_prime_util__families__lucky_vectors__implementation__finalize__2, @function
math_prime_util__families__lucky_vectors__implementation__finalize__2:
.LFB5:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE5:
	.size	math_prime_util__families__lucky_vectors__implementation__finalize__2, .-math_prime_util__families__lucky_vectors__implementation__finalize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__finalize__3
	.type	math_prime_util__families__lucky_vectors__implementation__finalize__3, @function
math_prime_util__families__lucky_vectors__implementation__finalize__3:
.LFB6:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE6:
	.size	math_prime_util__families__lucky_vectors__implementation__finalize__3, .-math_prime_util__families__lucky_vectors__implementation__finalize__3
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__initialize__2
	.type	math_prime_util__families__lucky_vectors__implementation__initialize__2, @function
math_prime_util__families__lucky_vectors__implementation__initialize__2:
.LFB7:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE7:
	.size	math_prime_util__families__lucky_vectors__implementation__initialize__2, .-math_prime_util__families__lucky_vectors__implementation__initialize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__initialize__3
	.type	math_prime_util__families__lucky_vectors__implementation__initialize__3, @function
math_prime_util__families__lucky_vectors__implementation__initialize__3:
.LFB8:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE8:
	.size	math_prime_util__families__lucky_vectors__implementation__initialize__3, .-math_prime_util__families__lucky_vectors__implementation__initialize__3
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__clear
	.type	math_prime_util__families__lucky_vectors__clear, @function
math_prime_util__families__lucky_vectors__clear:
.LFB31:
	.cfi_startproc
	movl	$-1, 16(%rdi)
	ret
	.cfi_endproc
.LFE31:
	.size	math_prime_util__families__lucky_vectors__clear, .-math_prime_util__families__lucky_vectors__clear
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__constant_reference
	.type	math_prime_util__families__lucky_vectors__constant_reference, @function
math_prime_util__families__lucky_vectors__constant_reference:
.LFB32:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	8(%rdx,%rcx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__families__lucky_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE32:
	.size	math_prime_util__families__lucky_vectors__constant_reference, .-math_prime_util__families__lucky_vectors__constant_reference
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__constant_reference__2
	.type	math_prime_util__families__lucky_vectors__constant_reference__2, @function
math_prime_util__families__lucky_vectors__constant_reference__2:
.LFB33:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	8(%rcx,%rdx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__families__lucky_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE33:
	.size	math_prime_util__families__lucky_vectors__constant_reference__2, .-math_prime_util__families__lucky_vectors__constant_reference__2
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__contains
	.type	math_prime_util__families__lucky_vectors__contains, @function
math_prime_util__families__lucky_vectors__contains:
.LFB34:
	.cfi_startproc
	movl	16(%rdi), %edx
	testl	%edx, %edx
	js	.L12
	movq	8(%rdi), %rcx
	leaq	8(%rcx), %rax
	leaq	16(%rcx,%rdx,8), %rdx
	jmp	.L14
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L17:
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L12
.L14:
	cmpq	(%rax), %rsi
	jne	.L17
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L12:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE34:
	.size	math_prime_util__families__lucky_vectors__contains, .-math_prime_util__families__lucky_vectors__contains
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__element
	.type	math_prime_util__families__lucky_vectors__element, @function
math_prime_util__families__lucky_vectors__element:
.LFB41:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movq	8(%rax,%rsi,8), %rax
	ret
	.cfi_endproc
.LFE41:
	.size	math_prime_util__families__lucky_vectors__element, .-math_prime_util__families__lucky_vectors__element
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__finalize__4
	.type	math_prime_util__families__lucky_vectors__finalize__4, @function
math_prime_util__families__lucky_vectors__finalize__4:
.LFB46:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE46:
	.size	math_prime_util__families__lucky_vectors__finalize__4, .-math_prime_util__families__lucky_vectors__finalize__4
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__find
	.type	math_prime_util__families__lucky_vectors__find, @function
math_prime_util__families__lucky_vectors__find:
.LFB47:
	.cfi_startproc
	movq	%rdi, %r8
	movq	%rcx, %rdi
	movl	16(%r8), %ecx
	cmpl	%ecx, %edi
	jg	.L21
	movslq	%edi, %rax
	subl	%edi, %ecx
	movq	8(%r8), %rdx
	leaq	1(%rax,%rcx), %rcx
	jmp	.L24
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L22:
	addq	$1, %rax
	cmpq	%rcx, %rax
	je	.L21
.L24:
	cmpq	%rsi, 8(%rdx,%rax,8)
	jne	.L22
	movl	%eax, %eax
	movq	%rax, %rdx
	movq	%r8, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L21:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE47:
	.size	math_prime_util__families__lucky_vectors__find, .-math_prime_util__families__lucky_vectors__find
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__find_index
	.type	math_prime_util__families__lucky_vectors__find_index, @function
math_prime_util__families__lucky_vectors__find_index:
.LFB48:
	.cfi_startproc
	movq	%rdi, %rax
	movl	%edx, %edi
	movl	16(%rax), %ecx
	cmpl	%edx, %ecx
	jl	.L31
	movq	8(%rax), %rdx
	subl	%edi, %ecx
	movslq	%edi, %rax
	leaq	1(%rax,%rcx), %rcx
	jmp	.L30
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L33:
	addq	$1, %rax
	cmpq	%rcx, %rax
	je	.L31
.L30:
	cmpq	%rsi, 8(%rdx,%rax,8)
	jne	.L33
	ret
	.p2align 4,,10
	.p2align 3
.L31:
	movl	$-1, %eax
	ret
	.cfi_endproc
.LFE48:
	.size	math_prime_util__families__lucky_vectors__find_index, .-math_prime_util__families__lucky_vectors__find_index
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__first
	.type	math_prime_util__families__lucky_vectors__first, @function
math_prime_util__families__lucky_vectors__first:
.LFB49:
	.cfi_startproc
	movl	16(%rdi), %ecx
	movq	%rdi, %rax
	xorl	%edx, %edx
	testl	%ecx, %ecx
	js	.L37
	ret
	.p2align 4,,10
	.p2align 3
.L37:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE49:
	.size	math_prime_util__families__lucky_vectors__first, .-math_prime_util__families__lucky_vectors__first
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__first_element
	.type	math_prime_util__families__lucky_vectors__first_element, @function
math_prime_util__families__lucky_vectors__first_element:
.LFB51:
	.cfi_startproc
	movq	8(%rdi), %rax
	movq	8(%rax), %rax
	ret
	.cfi_endproc
.LFE51:
	.size	math_prime_util__families__lucky_vectors__first_element, .-math_prime_util__families__lucky_vectors__first_element
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__first_index
	.type	math_prime_util__families__lucky_vectors__first_index, @function
math_prime_util__families__lucky_vectors__first_index:
.LFB52:
	.cfi_startproc
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE52:
	.size	math_prime_util__families__lucky_vectors__first_index, .-math_prime_util__families__lucky_vectors__first_index
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__is_empty
	.type	math_prime_util__families__lucky_vectors__is_empty, @function
math_prime_util__families__lucky_vectors__is_empty:
.LFB66:
	.cfi_startproc
	movl	16(%rdi), %eax
	shrl	$31, %eax
	ret
	.cfi_endproc
.LFE66:
	.size	math_prime_util__families__lucky_vectors__is_empty, .-math_prime_util__families__lucky_vectors__is_empty
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__iterate
	.type	math_prime_util__families__lucky_vectors__iterate, @function
math_prime_util__families__lucky_vectors__iterate:
.LFB67:
	.cfi_startproc
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%r14, 56(%rsp)
	.cfi_offset 14, -24
	movl	16(%rdi), %r14d
	testl	%r14d, %r14d
	js	.L41
	movq	%r12, 40(%rsp)
	movq	%r13, 48(%rsp)
	movq	%rdi, 8(%rsp)
	movq	%rbx, 24(%rsp)
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -48
	movl	$-1, %ebp
	movq	%r15, 64(%rsp)
	.cfi_offset 15, -16
	movabsq	$-4294967296, %r15
	.p2align 4
	.p2align 3
.L44:
	movl	%r13d, %eax
	leal	1(%rbp), %ecx
	movq	8(%rsp), %r12
	andq	%r15, %rax
	movq	%rcx, %rbp
	orq	%rcx, %rax
	movq	%r12, %rdi
	movq	%rax, %r13
	movq	%rax, %rsi
	movq	%rbx, %rax
	testb	$1, %bl
	jne	.L50
.L43:
	call	*%rax
	cmpl	%ebp, %r14d
	jne	.L44
	movq	24(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r12
	.cfi_restore 12
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	64(%rsp), %r15
	.cfi_restore 15
.L41:
	movq	56(%rsp), %r14
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
.L50:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	movq	-1(%rbx), %r10
	movq	7(%rbx), %rax
	jmp	.L43
	.cfi_endproc
.LFE67:
	.size	math_prime_util__families__lucky_vectors__iterate, .-math_prime_util__families__lucky_vectors__iterate
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__last
	.type	math_prime_util__families__lucky_vectors__last, @function
math_prime_util__families__lucky_vectors__last:
.LFB72:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rdi, %rax
	testl	%ecx, %ecx
	js	.L54
	ret
	.p2align 4,,10
	.p2align 3
.L54:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE72:
	.size	math_prime_util__families__lucky_vectors__last, .-math_prime_util__families__lucky_vectors__last
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__last_element
	.type	math_prime_util__families__lucky_vectors__last_element, @function
math_prime_util__families__lucky_vectors__last_element:
.LFB74:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	16(%rdi), %rdx
	movq	8(%rax,%rdx,8), %rax
	ret
	.cfi_endproc
.LFE74:
	.size	math_prime_util__families__lucky_vectors__last_element, .-math_prime_util__families__lucky_vectors__last_element
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__last_index
	.type	math_prime_util__families__lucky_vectors__last_index, @function
math_prime_util__families__lucky_vectors__last_index:
.LFB75:
	.cfi_startproc
	movl	16(%rdi), %eax
	ret
	.cfi_endproc
.LFE75:
	.size	math_prime_util__families__lucky_vectors__last_index, .-math_prime_util__families__lucky_vectors__last_index
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__move
	.type	math_prime_util__families__lucky_vectors__move, @function
math_prime_util__families__lucky_vectors__move:
.LFB77:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L57
	movq	8(%rdi), %rax
	movq	8(%rsi), %rdx
	movq	%rdx, 8(%rdi)
	movq	%rax, 8(%rsi)
	movl	16(%rsi), %eax
	movl	%eax, 16(%rdi)
	movl	$-1, 16(%rsi)
.L57:
	ret
	.cfi_endproc
.LFE77:
	.size	math_prime_util__families__lucky_vectors__move, .-math_prime_util__families__lucky_vectors__move
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__query_element
	.type	math_prime_util__families__lucky_vectors__query_element, @function
math_prime_util__families__lucky_vectors__query_element:
.LFB89:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movq	8(%rax,%rsi,8), %rdi
	testb	$1, %dl
	jne	.L64
	jmp	*%rdx
.L64:
	movq	-1(%rdx), %r10
	movq	7(%rdx), %rdx
	jmp	*%rdx
	.cfi_endproc
.LFE89:
	.size	math_prime_util__families__lucky_vectors__query_element, .-math_prime_util__families__lucky_vectors__query_element
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__reference
	.type	math_prime_util__families__lucky_vectors__reference, @function
math_prime_util__families__lucky_vectors__reference:
.LFB95:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	8(%rdx,%rcx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__families__lucky_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE95:
	.size	math_prime_util__families__lucky_vectors__reference, .-math_prime_util__families__lucky_vectors__reference
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__reference__2
	.type	math_prime_util__families__lucky_vectors__reference__2, @function
math_prime_util__families__lucky_vectors__reference__2:
.LFB96:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	8(%rcx,%rdx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__families__lucky_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE96:
	.size	math_prime_util__families__lucky_vectors__reference__2, .-math_prime_util__families__lucky_vectors__reference__2
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__replace_element
	.type	math_prime_util__families__lucky_vectors__replace_element, @function
math_prime_util__families__lucky_vectors__replace_element:
.LFB97:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movq	%rdx, 8(%rax,%rsi,8)
	ret
	.cfi_endproc
.LFE97:
	.size	math_prime_util__families__lucky_vectors__replace_element, .-math_prime_util__families__lucky_vectors__replace_element
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__replace_element__2
	.type	math_prime_util__families__lucky_vectors__replace_element__2, @function
math_prime_util__families__lucky_vectors__replace_element__2:
.LFB98:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movq	%rcx, 8(%rax,%rdx,8)
	ret
	.cfi_endproc
.LFE98:
	.size	math_prime_util__families__lucky_vectors__replace_element__2, .-math_prime_util__families__lucky_vectors__replace_element__2
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__reverse_find
	.type	math_prime_util__families__lucky_vectors__reverse_find, @function
math_prime_util__families__lucky_vectors__reverse_find:
.LFB101:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	%ecx, %eax
	cmovle	%eax, %ecx
	testq	%rdx, %rdx
	cmovne	%ecx, %eax
	testl	%eax, %eax
	js	.L71
	movl	%eax, %eax
	movq	8(%rdi), %rdx
	addq	$1, %rax
	jmp	.L74
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L72:
	testq	%rax, %rax
	je	.L71
.L74:
	subq	$1, %rax
	cmpq	%rsi, 8(%rdx,%rax,8)
	jne	.L72
	movl	%eax, %eax
	movq	%rax, %rdx
	movq	%rdi, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L71:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE101:
	.size	math_prime_util__families__lucky_vectors__reverse_find, .-math_prime_util__families__lucky_vectors__reverse_find
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__reverse_find_index
	.type	math_prime_util__families__lucky_vectors__reverse_find_index, @function
math_prime_util__families__lucky_vectors__reverse_find_index:
.LFB102:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	testl	%edx, %edx
	js	.L83
	movl	%edx, %edx
	leaq	1(%rdx), %rax
	movq	8(%rdi), %rdx
	jmp	.L82
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L85:
	testq	%rax, %rax
	je	.L83
.L82:
	subq	$1, %rax
	cmpq	%rsi, 8(%rdx,%rax,8)
	jne	.L85
	ret
	.p2align 4,,10
	.p2align 3
.L83:
	movl	$-1, %eax
	ret
	.cfi_endproc
.LFE102:
	.size	math_prime_util__families__lucky_vectors__reverse_find_index, .-math_prime_util__families__lucky_vectors__reverse_find_index
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__reverse_iterate
	.type	math_prime_util__families__lucky_vectors__reverse_iterate, @function
math_prime_util__families__lucky_vectors__reverse_iterate:
.LFB103:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%r15, 48(%rsp)
	.cfi_offset 15, -16
	movl	16(%rdi), %r15d
	testl	%r15d, %r15d
	js	.L86
	movq	%r12, 24(%rsp)
	addq	$1, %r15
	movq	%r13, 32(%rsp)
	movq	%rbx, 8(%rsp)
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	movq	%r14, 40(%rsp)
	.cfi_offset 14, -24
	movabsq	$-4294967296, %r14
	.p2align 4
	.p2align 3
.L89:
	subq	$1, %r15
	movl	%r13d, %eax
	movq	%rbp, %rdi
	andq	%r14, %rax
	movl	%r15d, %edx
	orq	%rdx, %rax
	movq	%rax, %r13
	movq	%rax, %rsi
	movq	%rbx, %rax
	testb	$1, %bl
	jne	.L95
.L88:
	call	*%rax
	testq	%r15, %r15
	jne	.L89
	movq	8(%rsp), %rbx
	.cfi_restore 3
	movq	16(%rsp), %rbp
	.cfi_restore 6
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
	movq	40(%rsp), %r14
	.cfi_restore 14
.L86:
	movq	48(%rsp), %r15
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
.L95:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	movq	-1(%rbx), %r10
	movq	7(%rbx), %rax
	jmp	.L88
	.cfi_endproc
.LFE103:
	.size	math_prime_util__families__lucky_vectors__reverse_iterate, .-math_prime_util__families__lucky_vectors__reverse_iterate
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__swap
	.type	math_prime_util__families__lucky_vectors__swap, @function
math_prime_util__families__lucky_vectors__swap:
.LFB105:
	.cfi_startproc
	cmpl	%edx, %esi
	je	.L96
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movslq	%esi, %rsi
	movq	8(%rax,%rdx,8), %r8
	movq	8(%rax,%rsi,8), %rcx
	movq	%r8, 8(%rax,%rsi,8)
	movq	8(%rdi), %rax
	movq	%rcx, 8(%rax,%rdx,8)
.L96:
	ret
	.cfi_endproc
.LFE105:
	.size	math_prime_util__families__lucky_vectors__swap, .-math_prime_util__families__lucky_vectors__swap
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__to_cursor
	.type	math_prime_util__families__lucky_vectors__to_cursor, @function
math_prime_util__families__lucky_vectors__to_cursor:
.LFB107:
	.cfi_startproc
	testl	%esi, %esi
	js	.L99
	cmpl	%esi, 16(%rdi)
	jge	.L100
.L99:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.p2align 4,,10
	.p2align 3
.L100:
	movl	%esi, %eax
	movq	%rax, %rdx
	movq	%rdi, %rax
	ret
	.cfi_endproc
.LFE107:
	.size	math_prime_util__families__lucky_vectors__to_cursor, .-math_prime_util__families__lucky_vectors__to_cursor
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__update_element
	.type	math_prime_util__families__lucky_vectors__update_element, @function
math_prime_util__families__lucky_vectors__update_element:
.LFB113:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movslq	%esi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rbp
	movq	8(%rbp,%rbx,8), %rdi
	testb	$1, %dl
	jne	.L108
.L103:
	call	*%rdx
	movq	%rax, 8(%rbp,%rbx,8)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L108:
	.cfi_restore_state
	movq	-1(%rdx), %r10
	movq	7(%rdx), %rdx
	jmp	.L103
	.cfi_endproc
.LFE113:
	.size	math_prime_util__families__lucky_vectors__update_element, .-math_prime_util__families__lucky_vectors__update_element
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__update_element__2
	.type	math_prime_util__families__lucky_vectors__update_element__2, @function
math_prime_util__families__lucky_vectors__update_element__2:
.LFB114:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movslq	%edx, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rbp
	movq	8(%rbp,%rbx,8), %rdi
	testb	$1, %cl
	jne	.L115
.L110:
	call	*%rcx
	movq	%rax, 8(%rbp,%rbx,8)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L115:
	.cfi_restore_state
	movq	-1(%rcx), %r10
	movq	7(%rcx), %rcx
	jmp	.L110
	.cfi_endproc
.LFE114:
	.size	math_prime_util__families__lucky_vectors__update_element__2, .-math_prime_util__families__lucky_vectors__update_element__2
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11, @function
math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11:
.LFB120:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
	.cfi_endproc
.LFE120:
	.size	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11, .-math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B111b___finalizer.170,math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__families__lucky_vectors__TiteratorCFD__B346s___finalizer.16,math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__families__lucky_vectors__implementation__Twith_lockCFD__B121s___finalizer.14,math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__families__lucky_vectors__implementation__Twith_busyCFD__B110s___finalizer.13,math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B16s___finalizer.12,math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation___size
	.type	math_prime_util__families__lucky_vectors__implementation___size, @function
math_prime_util__families__lucky_vectors__implementation___size:
.LFB124:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE124:
	.size	math_prime_util__families__lucky_vectors__implementation___size, .-math_prime_util__families__lucky_vectors__implementation___size
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__reference_control_typeDA
	.type	math_prime_util__families__lucky_vectors__implementation__reference_control_typeDA, @function
math_prime_util__families__lucky_vectors__implementation__reference_control_typeDA:
.LFB132:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE132:
	.size	math_prime_util__families__lucky_vectors__implementation__reference_control_typeDA, .-math_prime_util__families__lucky_vectors__implementation__reference_control_typeDA
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors___size__2
	.type	math_prime_util__families__lucky_vectors___size__2, @function
math_prime_util__families__lucky_vectors___size__2:
.LFB153:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE153:
	.size	math_prime_util__families__lucky_vectors___size__2, .-math_prime_util__families__lucky_vectors___size__2
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T580s, @function
math_prime_util__families__lucky_vectors__T580s:
.LFB1017:
	.cfi_startproc
	movq	(%rdi), %rax
	movzbl	%sil, %esi
	addq	-16(%rax), %rdi
	jmp	system__finalization_root__root_controlledDA@PLT
	.cfi_endproc
.LFE1017:
	.size	math_prime_util__families__lucky_vectors__T580s, .-math_prime_util__families__lucky_vectors__T580s
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize.114, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize.114:
.LFB570:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L122
	movq	$0, 8(%rdi)
.L122:
	ret
	.cfi_endproc
.LFE570:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize.114, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize.114
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__2.108, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__2.108:
.LFB571:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE571:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__2.108, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__2.108
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__3.101, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__3.101:
.LFB572:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE572:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__3.101, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__3.101
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__2.109, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__2.109:
.LFB573:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE573:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__2.109, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__2.109
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__3.103, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__3.103:
.LFB574:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE574:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__3.103, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__3.103
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__clear.84, @function
math_prime_util__families__bitmask_sieve__word_vectors__clear.84:
.LFB597:
	.cfi_startproc
	movl	$-1, 16(%rdi)
	ret
	.cfi_endproc
.LFE597:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__clear.84, .-math_prime_util__families__bitmask_sieve__word_vectors__clear.84
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__constant_reference.182, @function
math_prime_util__families__bitmask_sieve__word_vectors__constant_reference.182:
.LFB598:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	movq	%rdi, %rax
	addq	$20, %rsi
	leaq	4(%rdx,%rcx,4), %rdx
	movq	%rdx, (%rdi)
	leaq	32+ada__finalization__controlledT(%rip), %rdi
	movq	%rdi, 8(%rax)
	movq	%rsi, 16(%rax)
	movq	632(%r10), %rdx
	movq	%rdx, 8(%rax)
	ret
	.cfi_endproc
.LFE598:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__constant_reference.182, .-math_prime_util__families__bitmask_sieve__word_vectors__constant_reference.182
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__constant_reference__2.181, @function
math_prime_util__families__bitmask_sieve__word_vectors__constant_reference__2.181:
.LFB599:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	movq	%rdi, %rax
	addq	$20, %rsi
	leaq	4(%rcx,%rdx,4), %rdx
	movq	%rdx, (%rdi)
	leaq	32+ada__finalization__controlledT(%rip), %rdi
	movq	%rdi, 8(%rax)
	movq	%rsi, 16(%rax)
	movq	632(%r10), %rdx
	movq	%rdx, 8(%rax)
	ret
	.cfi_endproc
.LFE599:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__constant_reference__2.181, .-math_prime_util__families__bitmask_sieve__word_vectors__constant_reference__2.181
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__contains.180, @function
math_prime_util__families__bitmask_sieve__word_vectors__contains.180:
.LFB600:
	.cfi_startproc
	movl	16(%rdi), %edx
	testl	%edx, %edx
	js	.L132
	movq	8(%rdi), %rcx
	leaq	4(%rcx), %rax
	leaq	8(%rcx,%rdx,4), %rdx
	jmp	.L134
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L137:
	addq	$4, %rax
	cmpq	%rdx, %rax
	je	.L132
.L134:
	cmpl	(%rax), %esi
	jne	.L137
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L132:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE600:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__contains.180, .-math_prime_util__families__bitmask_sieve__word_vectors__contains.180
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__element.194, @function
math_prime_util__families__bitmask_sieve__word_vectors__element.194:
.LFB607:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movl	4(%rax,%rsi,4), %eax
	ret
	.cfi_endproc
.LFE607:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__element.194, .-math_prime_util__families__bitmask_sieve__word_vectors__element.194
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__finalize__4.44, @function
math_prime_util__families__bitmask_sieve__word_vectors__finalize__4.44:
.LFB612:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE612:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__finalize__4.44, .-math_prime_util__families__bitmask_sieve__word_vectors__finalize__4.44
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__find.179, @function
math_prime_util__families__bitmask_sieve__word_vectors__find.179:
.LFB613:
	.cfi_startproc
	movq	%rdi, %r8
	movq	%rcx, %rdi
	movl	16(%r8), %ecx
	cmpl	%ecx, %edi
	jg	.L141
	movslq	%edi, %rax
	subl	%edi, %ecx
	movq	8(%r8), %rdx
	leaq	1(%rax,%rcx), %rcx
	jmp	.L144
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L142:
	addq	$1, %rax
	cmpq	%rcx, %rax
	je	.L141
.L144:
	cmpl	%esi, 4(%rdx,%rax,4)
	jne	.L142
	movl	%eax, %eax
	movq	%rax, %rdx
	movq	%r8, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L141:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE613:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__find.179, .-math_prime_util__families__bitmask_sieve__word_vectors__find.179
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__find_index.178, @function
math_prime_util__families__bitmask_sieve__word_vectors__find_index.178:
.LFB614:
	.cfi_startproc
	movq	%rdi, %rax
	movl	%edx, %edi
	movl	16(%rax), %ecx
	cmpl	%edx, %ecx
	jl	.L151
	movq	8(%rax), %rdx
	subl	%edi, %ecx
	movslq	%edi, %rax
	leaq	1(%rax,%rcx), %rcx
	jmp	.L150
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L153:
	addq	$1, %rax
	cmpq	%rcx, %rax
	je	.L151
.L150:
	cmpl	%esi, 4(%rdx,%rax,4)
	jne	.L153
	ret
	.p2align 4,,10
	.p2align 3
.L151:
	movl	$-1, %eax
	ret
	.cfi_endproc
.LFE614:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__find_index.178, .-math_prime_util__families__bitmask_sieve__word_vectors__find_index.178
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__first.55, @function
math_prime_util__families__bitmask_sieve__word_vectors__first.55:
.LFB615:
	.cfi_startproc
	movl	16(%rdi), %ecx
	movq	%rdi, %rax
	xorl	%edx, %edx
	testl	%ecx, %ecx
	js	.L157
	ret
	.p2align 4,,10
	.p2align 3
.L157:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE615:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__first.55, .-math_prime_util__families__bitmask_sieve__word_vectors__first.55
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__first_element.54, @function
math_prime_util__families__bitmask_sieve__word_vectors__first_element.54:
.LFB617:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	4(%rax), %eax
	ret
	.cfi_endproc
.LFE617:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__first_element.54, .-math_prime_util__families__bitmask_sieve__word_vectors__first_element.54
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__is_empty.85, @function
math_prime_util__families__bitmask_sieve__word_vectors__is_empty.85:
.LFB632:
	.cfi_startproc
	movl	16(%rdi), %eax
	shrl	$31, %eax
	ret
	.cfi_endproc
.LFE632:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__is_empty.85, .-math_prime_util__families__bitmask_sieve__word_vectors__is_empty.85
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__iterate.177, @function
math_prime_util__families__bitmask_sieve__word_vectors__iterate.177:
.LFB633:
	.cfi_startproc
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%r14, 56(%rsp)
	.cfi_offset 14, -24
	movl	16(%rdi), %r14d
	testl	%r14d, %r14d
	js	.L160
	movq	%r12, 40(%rsp)
	movq	%r13, 48(%rsp)
	movq	%rdi, 8(%rsp)
	movq	%rbx, 24(%rsp)
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -48
	movl	$-1, %ebp
	movq	%r15, 64(%rsp)
	.cfi_offset 15, -16
	movabsq	$-4294967296, %r15
	.p2align 4
	.p2align 3
.L163:
	movl	%r13d, %eax
	leal	1(%rbp), %ecx
	movq	8(%rsp), %r12
	andq	%r15, %rax
	movq	%rcx, %rbp
	orq	%rcx, %rax
	movq	%r12, %rdi
	movq	%rax, %r13
	movq	%rax, %rsi
	movq	%rbx, %rax
	testb	$1, %bl
	jne	.L169
.L162:
	call	*%rax
	cmpl	%ebp, %r14d
	jne	.L163
	movq	24(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r12
	.cfi_restore 12
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	64(%rsp), %r15
	.cfi_restore 15
.L160:
	movq	56(%rsp), %r14
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
.L169:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	movq	-1(%rbx), %r10
	movq	7(%rbx), %rax
	jmp	.L162
	.cfi_endproc
.LFE633:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__iterate.177, .-math_prime_util__families__bitmask_sieve__word_vectors__iterate.177
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__last.53, @function
math_prime_util__families__bitmask_sieve__word_vectors__last.53:
.LFB638:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	%rax, %rcx
	movq	%rax, %rdx
	movq	%rdi, %rax
	testl	%ecx, %ecx
	js	.L173
	ret
	.p2align 4,,10
	.p2align 3
.L173:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE638:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__last.53, .-math_prime_util__families__bitmask_sieve__word_vectors__last.53
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__last_element.52, @function
math_prime_util__families__bitmask_sieve__word_vectors__last_element.52:
.LFB640:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	16(%rdi), %rdx
	movl	4(%rax,%rdx,4), %eax
	ret
	.cfi_endproc
.LFE640:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__last_element.52, .-math_prime_util__families__bitmask_sieve__word_vectors__last_element.52
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__last_index.193, @function
math_prime_util__families__bitmask_sieve__word_vectors__last_index.193:
.LFB641:
	.cfi_startproc
	movl	16(%rdi), %eax
	ret
	.cfi_endproc
.LFE641:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__last_index.193, .-math_prime_util__families__bitmask_sieve__word_vectors__last_index.193
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__move.80, @function
math_prime_util__families__bitmask_sieve__word_vectors__move.80:
.LFB643:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L176
	movq	8(%rdi), %rax
	movq	8(%rsi), %rdx
	movq	%rdx, 8(%rdi)
	movq	%rax, 8(%rsi)
	movl	16(%rsi), %eax
	movl	%eax, 16(%rdi)
	movl	$-1, 16(%rsi)
.L176:
	ret
	.cfi_endproc
.LFE643:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__move.80, .-math_prime_util__families__bitmask_sieve__word_vectors__move.80
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__query_element.167, @function
math_prime_util__families__bitmask_sieve__word_vectors__query_element.167:
.LFB655:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movl	4(%rax,%rsi,4), %edi
	testb	$1, %dl
	jne	.L183
	jmp	*%rdx
.L183:
	movq	-1(%rdx), %r10
	movq	7(%rdx), %rdx
	jmp	*%rdx
	.cfi_endproc
.LFE655:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__query_element.167, .-math_prime_util__families__bitmask_sieve__word_vectors__query_element.167
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reference.166, @function
math_prime_util__families__bitmask_sieve__word_vectors__reference.166:
.LFB661:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	movq	%rdi, %rax
	addq	$20, %rsi
	leaq	4(%rdx,%rcx,4), %rdx
	movq	%rdx, (%rdi)
	leaq	32+ada__finalization__controlledT(%rip), %rdi
	movq	%rdi, 8(%rax)
	movq	%rsi, 16(%rax)
	movq	632(%r10), %rdx
	movq	%rdx, 8(%rax)
	ret
	.cfi_endproc
.LFE661:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reference.166, .-math_prime_util__families__bitmask_sieve__word_vectors__reference.166
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reference__2.165, @function
math_prime_util__families__bitmask_sieve__word_vectors__reference__2.165:
.LFB662:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	movq	%rdi, %rax
	addq	$20, %rsi
	leaq	4(%rcx,%rdx,4), %rdx
	movq	%rdx, (%rdi)
	leaq	32+ada__finalization__controlledT(%rip), %rdi
	movq	%rdi, 8(%rax)
	movq	%rsi, 16(%rax)
	movq	632(%r10), %rdx
	movq	%rdx, 8(%rax)
	ret
	.cfi_endproc
.LFE662:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reference__2.165, .-math_prime_util__families__bitmask_sieve__word_vectors__reference__2.165
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__replace_element.190, @function
math_prime_util__families__bitmask_sieve__word_vectors__replace_element.190:
.LFB663:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movl	%edx, 4(%rax,%rsi,4)
	ret
	.cfi_endproc
.LFE663:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__replace_element.190, .-math_prime_util__families__bitmask_sieve__word_vectors__replace_element.190
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__replace_element__2.82, @function
math_prime_util__families__bitmask_sieve__word_vectors__replace_element__2.82:
.LFB664:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movl	%ecx, 4(%rax,%rdx,4)
	ret
	.cfi_endproc
.LFE664:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__replace_element__2.82, .-math_prime_util__families__bitmask_sieve__word_vectors__replace_element__2.82
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reverse_find.164, @function
math_prime_util__families__bitmask_sieve__word_vectors__reverse_find.164:
.LFB667:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	%ecx, %eax
	cmovle	%eax, %ecx
	testq	%rdx, %rdx
	cmovne	%ecx, %eax
	testl	%eax, %eax
	js	.L190
	movl	%eax, %eax
	movq	8(%rdi), %rdx
	addq	$1, %rax
	jmp	.L193
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L191:
	testq	%rax, %rax
	je	.L190
.L193:
	subq	$1, %rax
	cmpl	%esi, 4(%rdx,%rax,4)
	jne	.L191
	movl	%eax, %eax
	movq	%rax, %rdx
	movq	%rdi, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L190:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE667:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reverse_find.164, .-math_prime_util__families__bitmask_sieve__word_vectors__reverse_find.164
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reverse_find_index.163, @function
math_prime_util__families__bitmask_sieve__word_vectors__reverse_find_index.163:
.LFB668:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	testl	%edx, %edx
	js	.L202
	movl	%edx, %edx
	leaq	1(%rdx), %rax
	movq	8(%rdi), %rdx
	jmp	.L201
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L204:
	testq	%rax, %rax
	je	.L202
.L201:
	subq	$1, %rax
	cmpl	%esi, 4(%rdx,%rax,4)
	jne	.L204
	ret
	.p2align 4,,10
	.p2align 3
.L202:
	movl	$-1, %eax
	ret
	.cfi_endproc
.LFE668:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reverse_find_index.163, .-math_prime_util__families__bitmask_sieve__word_vectors__reverse_find_index.163
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reverse_iterate.161, @function
math_prime_util__families__bitmask_sieve__word_vectors__reverse_iterate.161:
.LFB669:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%r15, 48(%rsp)
	.cfi_offset 15, -16
	movl	16(%rdi), %r15d
	testl	%r15d, %r15d
	js	.L205
	movq	%r12, 24(%rsp)
	addq	$1, %r15
	movq	%r13, 32(%rsp)
	movq	%rbx, 8(%rsp)
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	movq	%r14, 40(%rsp)
	.cfi_offset 14, -24
	movabsq	$-4294967296, %r14
	.p2align 4
	.p2align 3
.L208:
	subq	$1, %r15
	movl	%r13d, %eax
	movq	%rbp, %rdi
	andq	%r14, %rax
	movl	%r15d, %edx
	orq	%rdx, %rax
	movq	%rax, %r13
	movq	%rax, %rsi
	movq	%rbx, %rax
	testb	$1, %bl
	jne	.L214
.L207:
	call	*%rax
	testq	%r15, %r15
	jne	.L208
	movq	8(%rsp), %rbx
	.cfi_restore 3
	movq	16(%rsp), %rbp
	.cfi_restore 6
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
	movq	40(%rsp), %r14
	.cfi_restore 14
.L205:
	movq	48(%rsp), %r15
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
.L214:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	movq	-1(%rbx), %r10
	movq	7(%rbx), %rax
	jmp	.L207
	.cfi_endproc
.LFE669:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reverse_iterate.161, .-math_prime_util__families__bitmask_sieve__word_vectors__reverse_iterate.161
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__swap.57, @function
math_prime_util__families__bitmask_sieve__word_vectors__swap.57:
.LFB671:
	.cfi_startproc
	cmpl	%edx, %esi
	je	.L215
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movslq	%esi, %rsi
	movl	4(%rax,%rdx,4), %r8d
	movl	4(%rax,%rsi,4), %ecx
	movl	%r8d, 4(%rax,%rsi,4)
	movq	8(%rdi), %rax
	movl	%ecx, 4(%rax,%rdx,4)
.L215:
	ret
	.cfi_endproc
.LFE671:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__swap.57, .-math_prime_util__families__bitmask_sieve__word_vectors__swap.57
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__to_cursor.83, @function
math_prime_util__families__bitmask_sieve__word_vectors__to_cursor.83:
.LFB673:
	.cfi_startproc
	testl	%esi, %esi
	js	.L218
	cmpl	%esi, 16(%rdi)
	jge	.L219
.L218:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.p2align 4,,10
	.p2align 3
.L219:
	movl	%esi, %eax
	movq	%rax, %rdx
	movq	%rdi, %rax
	ret
	.cfi_endproc
.LFE673:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__to_cursor.83, .-math_prime_util__families__bitmask_sieve__word_vectors__to_cursor.83
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__update_element.159, @function
math_prime_util__families__bitmask_sieve__word_vectors__update_element.159:
.LFB679:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movslq	%esi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rbp
	movl	4(%rbp,%rbx,4), %edi
	testb	$1, %dl
	jne	.L227
.L222:
	call	*%rdx
	movl	%eax, 4(%rbp,%rbx,4)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L227:
	.cfi_restore_state
	movq	-1(%rdx), %r10
	movq	7(%rdx), %rdx
	jmp	.L222
	.cfi_endproc
.LFE679:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__update_element.159, .-math_prime_util__families__bitmask_sieve__word_vectors__update_element.159
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__update_element__2.158, @function
math_prime_util__families__bitmask_sieve__word_vectors__update_element__2.158:
.LFB680:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movslq	%edx, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rbp
	movl	4(%rbp,%rbx,4), %edi
	testb	$1, %cl
	jne	.L234
.L229:
	call	*%rcx
	movl	%eax, 4(%rbp,%rbx,4)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L234:
	.cfi_restore_state
	movq	-1(%rcx), %r10
	movq	7(%rcx), %rcx
	jmp	.L229
	.cfi_endproc
.LFE680:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__update_element__2.158, .-math_prime_util__families__bitmask_sieve__word_vectors__update_element__2.158
	.section	.rodata
.LC18:
	.ascii	"math_prime_util-families.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__find.189, @function
math_prime_util__families__bitmask_sieve__find.189:
.LFB766:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	640(%r10), %edx
	movq	%rdi, %rax
	testl	%edx, %edx
	js	.L251
	leaq	1(%rdx), %rdi
	xorl	%edx, %edx
	.p2align 4
	.p2align 3
.L245:
	subq	$1, %rdi
	movslq	%edx, %r8
	movq	%rdi, %rcx
	salq	$5, %rcx
	movq	72(%r10,%rcx), %rsi
	movq	8(%rsi,%r8,8), %rcx
	cmpq	%rcx, %rax
	jb	.L237
	leaq	(%rsi,%r8,8), %rsi
	.p2align 5
	.p2align 4
	.p2align 3
.L239:
	cmpl	$2147483647, %edx
	je	.L259
	addq	$8, %rsi
	subq	%rcx, %rax
	addl	$1, %edx
	movq	8(%rsi), %rcx
	cmpq	%rcx, %rax
	jnb	.L239
.L237:
	testq	%rdi, %rdi
	jne	.L240
	movslq	%edx, %rcx
.L236:
	movq	24(%r10), %rsi
	movl	4(%rsi,%rcx,4), %r8d
	xorl	%ecx, %ecx
	jmp	.L250
	.p2align 4,,10
	.p2align 3
.L260:
	subq	$1, %rax
.L249:
	addl	$1, %ecx
.L250:
	cmpl	$31, %ecx
	jg	.L246
	movl	$1, %esi
	sall	%cl, %esi
	testl	%r8d, %esi
	je	.L249
	testq	%rax, %rax
	jne	.L260
	salq	$32, %rcx
	movl	%edx, %eax
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	orq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L240:
	.cfi_restore_state
	xorl	%ecx, %ecx
	cmpq	$2, %rdi
	sete	%cl
	leal	8(,%rcx,8), %ecx
	imull	%edx, %ecx
	jo	.L261
	movl	%ecx, %edx
	jmp	.L245
.L251:
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	jmp	.L236
.L259:
	movl	$170, %esi
	leaq	.LC18(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L246:
	cmpl	$2147483647, %ecx
	jne	.L249
	movl	$184, %esi
	leaq	.LC18(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L261:
	movl	$173, %esi
	leaq	.LC18(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE766:
	.size	math_prime_util__families__bitmask_sieve__find.189, .-math_prime_util__families__bitmask_sieve__find.189
	.align 2
	.p2align 4
	.type	math_prime_util__families__semi_window__mark.227, @function
math_prime_util__families__semi_window__mark.227:
.LFB874:
	.cfi_startproc
	movq	80(%r10), %r9
	movq	72(%r10), %r11
	movq	%rdi, %rcx
	movq	%rsi, %r8
	cmpq	%r9, %rdi
	jnb	.L263
	movq	%r9, %rax
	xorl	%edx, %edx
	divq	%rsi
	testq	%rdx, %rdx
	je	.L267
	movq	%rsi, %rax
	movq	%r11, %rcx
	subq	%rdx, %rax
	subq	%r9, %rcx
	cmpq	%rax, %rcx
	jb	.L262
	leaq	(%r9,%rsi), %rcx
	subq	%rdx, %rcx
	.p2align 4
	.p2align 3
.L263:
	cmpq	%rcx, %r11
	jb	.L262
	movq	64(%r10), %rsi
	jmp	.L266
	.p2align 4,,10
	.p2align 3
.L273:
	addq	%r8, %rcx
	cmpq	%rcx, %r11
	jb	.L262
.L266:
	movq	%rcx, %rax
	subq	%r9, %rax
	cmpq	$2147483647, %rax
	ja	.L272
	movl	%ecx, %eax
	movl	$2, %edi
	subl	%r9d, %eax
	cltq
	addb	$1, (%rsi,%rax)
	movzbl	(%rsi,%rax), %edx
	cmpb	%dil, %dl
	cmovg	%edi, %edx
	movb	%dl, (%rsi,%rax)
	movq	%r11, %rax
	subq	%rcx, %rax
	cmpq	%r8, %rax
	jnb	.L273
.L262:
	ret
	.p2align 4,,10
	.p2align 3
.L267:
	movq	%r9, %rcx
	jmp	.L263
.L272:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$2088, %esi
	leaq	.LC18(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE874:
	.size	math_prime_util__families__semi_window__mark.227, .-math_prime_util__families__semi_window__mark.227
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0, @function
math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0:
.LFB16:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%r10, %rbx
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbx, %rdi
	leaq	math_prime_util__families__lucky_vectors__vectorFD(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
	.cfi_endproc
.LFE16:
	.size	math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0, .-math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__vectorSI__R288s___finalizer__2.15,math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__to_vector__R1476s___finalizer__2.10,math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__to_vector__R1446s___finalizer.9,math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__empty__R909s___finalizer.5,math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__copy__R871s___finalizer.4,math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__Oconcat__R801s___finalizer__4.3,math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__Oconcat__R792s___finalizer__3.2,math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__Oconcat__R783s___finalizer__2.1,math_prime_util__families__lucky_vectors__Oconcat__R774s___finalizer.0
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144, @function
math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144:
.LFB582:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%r10, %rbx
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbx, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.90(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
	.cfi_endproc
.LFE582:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144, .-math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144
	.set	math_prime_util__families__bitmask_sieve__word_vectors__vectorSI__R473b___finalizer__2.154,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144
	.set	math_prime_util__families__bitmask_sieve__word_vectors__to_vector__R2652b___finalizer__2.147,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144
	.set	math_prime_util__families__bitmask_sieve__word_vectors__to_vector__R2622b___finalizer.129,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144
	.set	math_prime_util__families__bitmask_sieve__word_vectors__empty__R2085b___finalizer.151,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144
	.set	math_prime_util__families__bitmask_sieve__word_vectors__copy__R2047b___finalizer.132,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144
	.set	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1977b___finalizer__4.135,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144
	.set	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1968b___finalizer__3.138,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144
	.set	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1959b___finalizer__2.141,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1950b___finalizer.144
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.99, @function
math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.99:
.LFB590:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -32
	movl	16(%rdi), %ebp
	cmpl	$-1, %ebp
	je	.L282
	movq	%rbx, 24(%rsp)
	movslq	%ebp, %rax
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	movq	%r12, 40(%rsp)
	leaq	4(,%rax,4), %rdx
	movq	%r13, 48(%rsp)
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	8(%rdi), %r13
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	leaq	4(%rdx), %rdi
	movq	%rdx, 8(%rsp)
	call	__gnat_malloc@PLT
	movq	8(%rsp), %rdx
	leaq	4(%r13), %rsi
	movl	%ebp, (%rax)
	movq	%rax, %r12
	leaq	4(%rax), %rdi
	call	memcpy@PLT
	movq	%r12, 8(%rbx)
	movq	48(%rsp), %r13
	.cfi_restore 13
	movl	%ebp, 16(%rbx)
	movq	40(%rsp), %r12
	.cfi_restore 12
	movq	24(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %rbp
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L282:
	.cfi_def_cfa_offset 64
	movq	$0, 8(%rdi)
	movq	32(%rsp), %rbp
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE590:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.99, .-math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.99
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__adjust__2
	.type	math_prime_util__families__lucky_vectors__adjust__2, @function
math_prime_util__families__lucky_vectors__adjust__2:
.LFB24:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -32
	movl	16(%rdi), %ebp
	cmpl	$-1, %ebp
	je	.L287
	movq	%rbx, 24(%rsp)
	movslq	%ebp, %rax
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	movq	%r12, 40(%rsp)
	leaq	8(,%rax,8), %rdx
	movq	%r13, 48(%rsp)
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	8(%rdi), %r13
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	leaq	8(%rdx), %rdi
	movq	%rdx, 8(%rsp)
	call	__gnat_malloc@PLT
	movq	8(%rsp), %rdx
	leaq	8(%r13), %rsi
	movl	%ebp, (%rax)
	movq	%rax, %r12
	leaq	8(%rax), %rdi
	call	memcpy@PLT
	movq	%r12, 8(%rbx)
	movq	48(%rsp), %r13
	.cfi_restore 13
	movl	%ebp, 16(%rbx)
	movq	40(%rsp), %r12
	.cfi_restore 12
	movq	24(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %rbp
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L287:
	.cfi_def_cfa_offset 64
	movq	$0, 8(%rdi)
	movq	32(%rsp), %rbp
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	math_prime_util__families__lucky_vectors__adjust__2, .-math_prime_util__families__lucky_vectors__adjust__2
	.section	.rodata
.LC19:
	.ascii	"a-convec.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__delete.64, @function
math_prime_util__families__bitmask_sieve__word_vectors__delete.64:
.LFB603:
	.cfi_startproc
	movl	16(%rdi), %eax
	testl	%edx, %edx
	je	.L309
	cmpl	%esi, %eax
	jl	.L309
	movl	%eax, %ecx
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	subl	%esi, %ecx
	jo	.L293
	cmpl	$2147483647, %ecx
	je	.L293
	addl	$1, %ecx
	cmpl	%ecx, %edx
	jge	.L312
	subl	%edx, %eax
	movl	%eax, %ecx
	jo	.L296
	addl	%esi, %edx
	jo	.L313
	movq	8(%rdi), %r9
	movslq	%esi, %r10
	movq	%rdi, 8(%rsp)
	movslq	%ecx, %rdi
	subq	%r10, %rdi
	xorl	%eax, %eax
	cmpl	%ecx, %esi
	movslq	%edx, %rdx
	leaq	4(,%rdi,4), %rdi
	leaq	4(%r9,%rdx,4), %rsi
	movl	%ecx, 4(%rsp)
	cmovle	%rdi, %rax
	leaq	4(%r9,%r10,4), %rdi
	movq	%rax, %rdx
	call	memmove@PLT
	movl	4(%rsp), %ecx
	movq	8(%rsp), %r8
	movl	%ecx, 16(%r8)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L309:
	ret
	.p2align 4,,10
	.p2align 3
.L312:
	.cfi_def_cfa_offset 32
	subl	$1, %esi
	movl	%esi, 16(%rdi)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L293:
	.cfi_restore_state
	movl	$460, %esi
	leaq	.LC19(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L296:
	movl	$484, %esi
	leaq	.LC19(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L313:
	movl	$485, %esi
	leaq	.LC19(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE603:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__delete.64, .-math_prime_util__families__bitmask_sieve__word_vectors__delete.64
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__delete__2.63, @function
math_prime_util__families__bitmask_sieve__word_vectors__delete__2.63:
.LFB604:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rdx, %rsi
	movl	%ecx, %edx
	call	ma