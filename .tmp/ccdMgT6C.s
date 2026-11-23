	.file	"math_prime_util-sieve.adb"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__finalize
	.type	math_prime_util__sieve__prime_vectors__implementation__finalize, @function
math_prime_util__sieve__prime_vectors__implementation__finalize:
.LFB4:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L1
	movq	$0, 8(%rdi)
.L1:
	ret
	.cfi_endproc
.LFE4:
	.size	math_prime_util__sieve__prime_vectors__implementation__finalize, .-math_prime_util__sieve__prime_vectors__implementation__finalize
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__finalize__2
	.type	math_prime_util__sieve__prime_vectors__implementation__finalize__2, @function
math_prime_util__sieve__prime_vectors__implementation__finalize__2:
.LFB5:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE5:
	.size	math_prime_util__sieve__prime_vectors__implementation__finalize__2, .-math_prime_util__sieve__prime_vectors__implementation__finalize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__finalize__3
	.type	math_prime_util__sieve__prime_vectors__implementation__finalize__3, @function
math_prime_util__sieve__prime_vectors__implementation__finalize__3:
.LFB6:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE6:
	.size	math_prime_util__sieve__prime_vectors__implementation__finalize__3, .-math_prime_util__sieve__prime_vectors__implementation__finalize__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__initialize__2
	.type	math_prime_util__sieve__prime_vectors__implementation__initialize__2, @function
math_prime_util__sieve__prime_vectors__implementation__initialize__2:
.LFB7:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE7:
	.size	math_prime_util__sieve__prime_vectors__implementation__initialize__2, .-math_prime_util__sieve__prime_vectors__implementation__initialize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__initialize__3
	.type	math_prime_util__sieve__prime_vectors__implementation__initialize__3, @function
math_prime_util__sieve__prime_vectors__implementation__initialize__3:
.LFB8:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE8:
	.size	math_prime_util__sieve__prime_vectors__implementation__initialize__3, .-math_prime_util__sieve__prime_vectors__implementation__initialize__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__clear
	.type	math_prime_util__sieve__prime_vectors__clear, @function
math_prime_util__sieve__prime_vectors__clear:
.LFB31:
	.cfi_startproc
	movl	$-1, 16(%rdi)
	ret
	.cfi_endproc
.LFE31:
	.size	math_prime_util__sieve__prime_vectors__clear, .-math_prime_util__sieve__prime_vectors__clear
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__constant_reference
	.type	math_prime_util__sieve__prime_vectors__constant_reference, @function
math_prime_util__sieve__prime_vectors__constant_reference:
.LFB32:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	8(%rdx,%rcx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__sieve__prime_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE32:
	.size	math_prime_util__sieve__prime_vectors__constant_reference, .-math_prime_util__sieve__prime_vectors__constant_reference
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__constant_reference__2
	.type	math_prime_util__sieve__prime_vectors__constant_reference__2, @function
math_prime_util__sieve__prime_vectors__constant_reference__2:
.LFB33:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	8(%rcx,%rdx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__sieve__prime_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE33:
	.size	math_prime_util__sieve__prime_vectors__constant_reference__2, .-math_prime_util__sieve__prime_vectors__constant_reference__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__contains
	.type	math_prime_util__sieve__prime_vectors__contains, @function
math_prime_util__sieve__prime_vectors__contains:
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
	.size	math_prime_util__sieve__prime_vectors__contains, .-math_prime_util__sieve__prime_vectors__contains
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__element
	.type	math_prime_util__sieve__prime_vectors__element, @function
math_prime_util__sieve__prime_vectors__element:
.LFB41:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movq	8(%rax,%rsi,8), %rax
	ret
	.cfi_endproc
.LFE41:
	.size	math_prime_util__sieve__prime_vectors__element, .-math_prime_util__sieve__prime_vectors__element
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__finalize__4
	.type	math_prime_util__sieve__prime_vectors__finalize__4, @function
math_prime_util__sieve__prime_vectors__finalize__4:
.LFB46:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE46:
	.size	math_prime_util__sieve__prime_vectors__finalize__4, .-math_prime_util__sieve__prime_vectors__finalize__4
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__find
	.type	math_prime_util__sieve__prime_vectors__find, @function
math_prime_util__sieve__prime_vectors__find:
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
	.size	math_prime_util__sieve__prime_vectors__find, .-math_prime_util__sieve__prime_vectors__find
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__find_index
	.type	math_prime_util__sieve__prime_vectors__find_index, @function
math_prime_util__sieve__prime_vectors__find_index:
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
	.size	math_prime_util__sieve__prime_vectors__find_index, .-math_prime_util__sieve__prime_vectors__find_index
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__first
	.type	math_prime_util__sieve__prime_vectors__first, @function
math_prime_util__sieve__prime_vectors__first:
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
	.size	math_prime_util__sieve__prime_vectors__first, .-math_prime_util__sieve__prime_vectors__first
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__first_element
	.type	math_prime_util__sieve__prime_vectors__first_element, @function
math_prime_util__sieve__prime_vectors__first_element:
.LFB51:
	.cfi_startproc
	movq	8(%rdi), %rax
	movq	8(%rax), %rax
	ret
	.cfi_endproc
.LFE51:
	.size	math_prime_util__sieve__prime_vectors__first_element, .-math_prime_util__sieve__prime_vectors__first_element
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__first_index
	.type	math_prime_util__sieve__prime_vectors__first_index, @function
math_prime_util__sieve__prime_vectors__first_index:
.LFB52:
	.cfi_startproc
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE52:
	.size	math_prime_util__sieve__prime_vectors__first_index, .-math_prime_util__sieve__prime_vectors__first_index
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__is_empty
	.type	math_prime_util__sieve__prime_vectors__is_empty, @function
math_prime_util__sieve__prime_vectors__is_empty:
.LFB66:
	.cfi_startproc
	movl	16(%rdi), %eax
	shrl	$31, %eax
	ret
	.cfi_endproc
.LFE66:
	.size	math_prime_util__sieve__prime_vectors__is_empty, .-math_prime_util__sieve__prime_vectors__is_empty
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__iterate
	.type	math_prime_util__sieve__prime_vectors__iterate, @function
math_prime_util__sieve__prime_vectors__iterate:
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
	.size	math_prime_util__sieve__prime_vectors__iterate, .-math_prime_util__sieve__prime_vectors__iterate
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__last
	.type	math_prime_util__sieve__prime_vectors__last, @function
math_prime_util__sieve__prime_vectors__last:
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
	.size	math_prime_util__sieve__prime_vectors__last, .-math_prime_util__sieve__prime_vectors__last
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__last_element
	.type	math_prime_util__sieve__prime_vectors__last_element, @function
math_prime_util__sieve__prime_vectors__last_element:
.LFB74:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	16(%rdi), %rdx
	movq	8(%rax,%rdx,8), %rax
	ret
	.cfi_endproc
.LFE74:
	.size	math_prime_util__sieve__prime_vectors__last_element, .-math_prime_util__sieve__prime_vectors__last_element
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__last_index
	.type	math_prime_util__sieve__prime_vectors__last_index, @function
math_prime_util__sieve__prime_vectors__last_index:
.LFB75:
	.cfi_startproc
	movl	16(%rdi), %eax
	ret
	.cfi_endproc
.LFE75:
	.size	math_prime_util__sieve__prime_vectors__last_index, .-math_prime_util__sieve__prime_vectors__last_index
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__move
	.type	math_prime_util__sieve__prime_vectors__move, @function
math_prime_util__sieve__prime_vectors__move:
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
	.size	math_prime_util__sieve__prime_vectors__move, .-math_prime_util__sieve__prime_vectors__move
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__query_element
	.type	math_prime_util__sieve__prime_vectors__query_element, @function
math_prime_util__sieve__prime_vectors__query_element:
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
	.size	math_prime_util__sieve__prime_vectors__query_element, .-math_prime_util__sieve__prime_vectors__query_element
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__reference
	.type	math_prime_util__sieve__prime_vectors__reference, @function
math_prime_util__sieve__prime_vectors__reference:
.LFB95:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	8(%rdx,%rcx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__sieve__prime_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE95:
	.size	math_prime_util__sieve__prime_vectors__reference, .-math_prime_util__sieve__prime_vectors__reference
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__reference__2
	.type	math_prime_util__sieve__prime_vectors__reference__2, @function
math_prime_util__sieve__prime_vectors__reference__2:
.LFB96:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	8(%rcx,%rdx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__sieve__prime_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE96:
	.size	math_prime_util__sieve__prime_vectors__reference__2, .-math_prime_util__sieve__prime_vectors__reference__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__replace_element
	.type	math_prime_util__sieve__prime_vectors__replace_element, @function
math_prime_util__sieve__prime_vectors__replace_element:
.LFB97:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movq	%rdx, 8(%rax,%rsi,8)
	ret
	.cfi_endproc
.LFE97:
	.size	math_prime_util__sieve__prime_vectors__replace_element, .-math_prime_util__sieve__prime_vectors__replace_element
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__replace_element__2
	.type	math_prime_util__sieve__prime_vectors__replace_element__2, @function
math_prime_util__sieve__prime_vectors__replace_element__2:
.LFB98:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movq	%rcx, 8(%rax,%rdx,8)
	ret
	.cfi_endproc
.LFE98:
	.size	math_prime_util__sieve__prime_vectors__replace_element__2, .-math_prime_util__sieve__prime_vectors__replace_element__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__reverse_find
	.type	math_prime_util__sieve__prime_vectors__reverse_find, @function
math_prime_util__sieve__prime_vectors__reverse_find:
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
	.size	math_prime_util__sieve__prime_vectors__reverse_find, .-math_prime_util__sieve__prime_vectors__reverse_find
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__reverse_find_index
	.type	math_prime_util__sieve__prime_vectors__reverse_find_index, @function
math_prime_util__sieve__prime_vectors__reverse_find_index:
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
	.size	math_prime_util__sieve__prime_vectors__reverse_find_index, .-math_prime_util__sieve__prime_vectors__reverse_find_index
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__reverse_iterate
	.type	math_prime_util__sieve__prime_vectors__reverse_iterate, @function
math_prime_util__sieve__prime_vectors__reverse_iterate:
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
	.size	math_prime_util__sieve__prime_vectors__reverse_iterate, .-math_prime_util__sieve__prime_vectors__reverse_iterate
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__swap
	.type	math_prime_util__sieve__prime_vectors__swap, @function
math_prime_util__sieve__prime_vectors__swap:
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
	.size	math_prime_util__sieve__prime_vectors__swap, .-math_prime_util__sieve__prime_vectors__swap
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__to_cursor
	.type	math_prime_util__sieve__prime_vectors__to_cursor, @function
math_prime_util__sieve__prime_vectors__to_cursor:
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
	.size	math_prime_util__sieve__prime_vectors__to_cursor, .-math_prime_util__sieve__prime_vectors__to_cursor
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__update_element
	.type	math_prime_util__sieve__prime_vectors__update_element, @function
math_prime_util__sieve__prime_vectors__update_element:
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
	.size	math_prime_util__sieve__prime_vectors__update_element, .-math_prime_util__sieve__prime_vectors__update_element
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__update_element__2
	.type	math_prime_util__sieve__prime_vectors__update_element__2, @function
math_prime_util__sieve__prime_vectors__update_element__2:
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
	.size	math_prime_util__sieve__prime_vectors__update_element__2, .-math_prime_util__sieve__prime_vectors__update_element__2
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11, @function
math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11:
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
	.size	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11, .-math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__sieve__byte_vectors__TiteratorCFD__B346b___finalizerXn.33,math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__sieve__byte_vectors__implementation__Twith_lockCFD__B121b___finalizerXn.31,math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__sieve__byte_vectors__implementation__Twith_busyCFD__B110b___finalizerXn.30,math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B16b___finalizerXn.29,math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7b___finalizerXn.28,math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__sieve__prime_vectors__TiteratorCFD__B346s___finalizer.16,math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__sieve__prime_vectors__implementation__Twith_lockCFD__B121s___finalizer.14,math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__sieve__prime_vectors__implementation__Twith_busyCFD__B110s___finalizer.13,math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.set	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B16s___finalizer.12,math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation___size
	.type	math_prime_util__sieve__prime_vectors__implementation___size, @function
math_prime_util__sieve__prime_vectors__implementation___size:
.LFB124:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE124:
	.size	math_prime_util__sieve__prime_vectors__implementation___size, .-math_prime_util__sieve__prime_vectors__implementation___size
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDA
	.type	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDA, @function
math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDA:
.LFB132:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE132:
	.size	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDA, .-math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDA
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors___size__2
	.type	math_prime_util__sieve__prime_vectors___size__2, @function
math_prime_util__sieve__prime_vectors___size__2:
.LFB153:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE153:
	.size	math_prime_util__sieve__prime_vectors___size__2, .-math_prime_util__sieve__prime_vectors___size__2
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T580s, @function
math_prime_util__sieve__prime_vectors__T580s:
.LFB504:
	.cfi_startproc
	movq	(%rdi), %rax
	movzbl	%sil, %esi
	addq	-16(%rax), %rdi
	jmp	system__finalization_root__root_controlledDA@PLT
	.cfi_endproc
.LFE504:
	.size	math_prime_util__sieve__prime_vectors__T580s, .-math_prime_util__sieve__prime_vectors__T580s
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__finalize
	.type	math_prime_util__sieve__byte_vectors__implementation__finalize, @function
math_prime_util__sieve__byte_vectors__implementation__finalize:
.LFB202:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L122
	movq	$0, 8(%rdi)
.L122:
	ret
	.cfi_endproc
.LFE202:
	.size	math_prime_util__sieve__byte_vectors__implementation__finalize, .-math_prime_util__sieve__byte_vectors__implementation__finalize
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__finalize__2
	.type	math_prime_util__sieve__byte_vectors__implementation__finalize__2, @function
math_prime_util__sieve__byte_vectors__implementation__finalize__2:
.LFB203:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE203:
	.size	math_prime_util__sieve__byte_vectors__implementation__finalize__2, .-math_prime_util__sieve__byte_vectors__implementation__finalize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__finalize__3
	.type	math_prime_util__sieve__byte_vectors__implementation__finalize__3, @function
math_prime_util__sieve__byte_vectors__implementation__finalize__3:
.LFB204:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE204:
	.size	math_prime_util__sieve__byte_vectors__implementation__finalize__3, .-math_prime_util__sieve__byte_vectors__implementation__finalize__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__initialize__2
	.type	math_prime_util__sieve__byte_vectors__implementation__initialize__2, @function
math_prime_util__sieve__byte_vectors__implementation__initialize__2:
.LFB205:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE205:
	.size	math_prime_util__sieve__byte_vectors__implementation__initialize__2, .-math_prime_util__sieve__byte_vectors__implementation__initialize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__initialize__3
	.type	math_prime_util__sieve__byte_vectors__implementation__initialize__3, @function
math_prime_util__sieve__byte_vectors__implementation__initialize__3:
.LFB206:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE206:
	.size	math_prime_util__sieve__byte_vectors__implementation__initialize__3, .-math_prime_util__sieve__byte_vectors__implementation__initialize__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__clearXn
	.type	math_prime_util__sieve__byte_vectors__clearXn, @function
math_prime_util__sieve__byte_vectors__clearXn:
.LFB229:
	.cfi_startproc
	movl	$-1, 16(%rdi)
	ret
	.cfi_endproc
.LFE229:
	.size	math_prime_util__sieve__byte_vectors__clearXn, .-math_prime_util__sieve__byte_vectors__clearXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__constant_referenceXn
	.type	math_prime_util__sieve__byte_vectors__constant_referenceXn, @function
math_prime_util__sieve__byte_vectors__constant_referenceXn:
.LFB230:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	4(%rdx,%rcx), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__sieve__byte_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE230:
	.size	math_prime_util__sieve__byte_vectors__constant_referenceXn, .-math_prime_util__sieve__byte_vectors__constant_referenceXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__constant_reference__2Xn
	.type	math_prime_util__sieve__byte_vectors__constant_reference__2Xn, @function
math_prime_util__sieve__byte_vectors__constant_reference__2Xn:
.LFB231:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	4(%rcx,%rdx), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__sieve__byte_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE231:
	.size	math_prime_util__sieve__byte_vectors__constant_reference__2Xn, .-math_prime_util__sieve__byte_vectors__constant_reference__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__containsXn
	.type	math_prime_util__sieve__byte_vectors__containsXn, @function
math_prime_util__sieve__byte_vectors__containsXn:
.LFB232:
	.cfi_startproc
	movl	16(%rdi), %edx
	testl	%edx, %edx
	js	.L132
	movq	8(%rdi), %rcx
	leaq	4(%rcx), %rax
	leaq	5(%rcx,%rdx), %rdx
	jmp	.L134
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L137:
	addq	$1, %rax
	cmpq	%rdx, %rax
	je	.L132
.L134:
	cmpb	(%rax), %sil
	jne	.L137
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L132:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE232:
	.size	math_prime_util__sieve__byte_vectors__containsXn, .-math_prime_util__sieve__byte_vectors__containsXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__elementXn
	.type	math_prime_util__sieve__byte_vectors__elementXn, @function
math_prime_util__sieve__byte_vectors__elementXn:
.LFB239:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movzbl	4(%rax,%rsi), %eax
	ret
	.cfi_endproc
.LFE239:
	.size	math_prime_util__sieve__byte_vectors__elementXn, .-math_prime_util__sieve__byte_vectors__elementXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__finalize__4Xn
	.type	math_prime_util__sieve__byte_vectors__finalize__4Xn, @function
math_prime_util__sieve__byte_vectors__finalize__4Xn:
.LFB244:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE244:
	.size	math_prime_util__sieve__byte_vectors__finalize__4Xn, .-math_prime_util__sieve__byte_vectors__finalize__4Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__findXn
	.type	math_prime_util__sieve__byte_vectors__findXn, @function
math_prime_util__sieve__byte_vectors__findXn:
.LFB245:
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
	cmpb	%sil, 4(%rdx,%rax)
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
.LFE245:
	.size	math_prime_util__sieve__byte_vectors__findXn, .-math_prime_util__sieve__byte_vectors__findXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__find_indexXn
	.type	math_prime_util__sieve__byte_vectors__find_indexXn, @function
math_prime_util__sieve__byte_vectors__find_indexXn:
.LFB246:
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
	cmpb	%sil, 4(%rdx,%rax)
	jne	.L153
	ret
	.p2align 4,,10
	.p2align 3
.L151:
	movl	$-1, %eax
	ret
	.cfi_endproc
.LFE246:
	.size	math_prime_util__sieve__byte_vectors__find_indexXn, .-math_prime_util__sieve__byte_vectors__find_indexXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__firstXn
	.type	math_prime_util__sieve__byte_vectors__firstXn, @function
math_prime_util__sieve__byte_vectors__firstXn:
.LFB247:
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
.LFE247:
	.size	math_prime_util__sieve__byte_vectors__firstXn, .-math_prime_util__sieve__byte_vectors__firstXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__first_elementXn
	.type	math_prime_util__sieve__byte_vectors__first_elementXn, @function
math_prime_util__sieve__byte_vectors__first_elementXn:
.LFB249:
	.cfi_startproc
	movq	8(%rdi), %rax
	movzbl	4(%rax), %eax
	ret
	.cfi_endproc
.LFE249:
	.size	math_prime_util__sieve__byte_vectors__first_elementXn, .-math_prime_util__sieve__byte_vectors__first_elementXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__is_emptyXn
	.type	math_prime_util__sieve__byte_vectors__is_emptyXn, @function
math_prime_util__sieve__byte_vectors__is_emptyXn:
.LFB264:
	.cfi_startproc
	movl	16(%rdi), %eax
	shrl	$31, %eax
	ret
	.cfi_endproc
.LFE264:
	.size	math_prime_util__sieve__byte_vectors__is_emptyXn, .-math_prime_util__sieve__byte_vectors__is_emptyXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__iterateXn
	.type	math_prime_util__sieve__byte_vectors__iterateXn, @function
math_prime_util__sieve__byte_vectors__iterateXn:
.LFB265:
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
.LFE265:
	.size	math_prime_util__sieve__byte_vectors__iterateXn, .-math_prime_util__sieve__byte_vectors__iterateXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__lastXn
	.type	math_prime_util__sieve__byte_vectors__lastXn, @function
math_prime_util__sieve__byte_vectors__lastXn:
.LFB270:
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
.LFE270:
	.size	math_prime_util__sieve__byte_vectors__lastXn, .-math_prime_util__sieve__byte_vectors__lastXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__last_elementXn
	.type	math_prime_util__sieve__byte_vectors__last_elementXn, @function
math_prime_util__sieve__byte_vectors__last_elementXn:
.LFB272:
	.cfi_startproc
	movq	8(%rdi), %rdx
	movslq	16(%rdi), %rax
	movzbl	4(%rdx,%rax), %eax
	ret
	.cfi_endproc
.LFE272:
	.size	math_prime_util__sieve__byte_vectors__last_elementXn, .-math_prime_util__sieve__byte_vectors__last_elementXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__last_indexXn
	.type	math_prime_util__sieve__byte_vectors__last_indexXn, @function
math_prime_util__sieve__byte_vectors__last_indexXn:
.LFB273:
	.cfi_startproc
	movl	16(%rdi), %eax
	ret
	.cfi_endproc
.LFE273:
	.size	math_prime_util__sieve__byte_vectors__last_indexXn, .-math_prime_util__sieve__byte_vectors__last_indexXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__moveXn
	.type	math_prime_util__sieve__byte_vectors__moveXn, @function
math_prime_util__sieve__byte_vectors__moveXn:
.LFB275:
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
.LFE275:
	.size	math_prime_util__sieve__byte_vectors__moveXn, .-math_prime_util__sieve__byte_vectors__moveXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__query_elementXn
	.type	math_prime_util__sieve__byte_vectors__query_elementXn, @function
math_prime_util__sieve__byte_vectors__query_elementXn:
.LFB287:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movzbl	4(%rax,%rsi), %edi
	testb	$1, %dl
	jne	.L183
	jmp	*%rdx
.L183:
	movq	-1(%rdx), %r10
	movq	7(%rdx), %rdx
	jmp	*%rdx
	.cfi_endproc
.LFE287:
	.size	math_prime_util__sieve__byte_vectors__query_elementXn, .-math_prime_util__sieve__byte_vectors__query_elementXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__referenceXn
	.type	math_prime_util__sieve__byte_vectors__referenceXn, @function
math_prime_util__sieve__byte_vectors__referenceXn:
.LFB293:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	4(%rdx,%rcx), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__sieve__byte_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE293:
	.size	math_prime_util__sieve__byte_vectors__referenceXn, .-math_prime_util__sieve__byte_vectors__referenceXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__reference__2Xn
	.type	math_prime_util__sieve__byte_vectors__reference__2Xn, @function
math_prime_util__sieve__byte_vectors__reference__2Xn:
.LFB294:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	4(%rcx,%rdx), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__sieve__byte_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE294:
	.size	math_prime_util__sieve__byte_vectors__reference__2Xn, .-math_prime_util__sieve__byte_vectors__reference__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__replace_elementXn
	.type	math_prime_util__sieve__byte_vectors__replace_elementXn, @function
math_prime_util__sieve__byte_vectors__replace_elementXn:
.LFB295:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movb	%dl, 4(%rax,%rsi)
	ret
	.cfi_endproc
.LFE295:
	.size	math_prime_util__sieve__byte_vectors__replace_elementXn, .-math_prime_util__sieve__byte_vectors__replace_elementXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__replace_element__2Xn
	.type	math_prime_util__sieve__byte_vectors__replace_element__2Xn, @function
math_prime_util__sieve__byte_vectors__replace_element__2Xn:
.LFB296:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movb	%cl, 4(%rax,%rdx)
	ret
	.cfi_endproc
.LFE296:
	.size	math_prime_util__sieve__byte_vectors__replace_element__2Xn, .-math_prime_util__sieve__byte_vectors__replace_element__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__reverse_findXn
	.type	math_prime_util__sieve__byte_vectors__reverse_findXn, @function
math_prime_util__sieve__byte_vectors__reverse_findXn:
.LFB299:
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
	cmpb	%sil, 4(%rdx,%rax)
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
.LFE299:
	.size	math_prime_util__sieve__byte_vectors__reverse_findXn, .-math_prime_util__sieve__byte_vectors__reverse_findXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__reverse_find_indexXn
	.type	math_prime_util__sieve__byte_vectors__reverse_find_indexXn, @function
math_prime_util__sieve__byte_vectors__reverse_find_indexXn:
.LFB300:
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
	cmpb	%sil, 4(%rdx,%rax)
	jne	.L204
	ret
	.p2align 4,,10
	.p2align 3
.L202:
	movl	$-1, %eax
	ret
	.cfi_endproc
.LFE300:
	.size	math_prime_util__sieve__byte_vectors__reverse_find_indexXn, .-math_prime_util__sieve__byte_vectors__reverse_find_indexXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__reverse_iterateXn
	.type	math_prime_util__sieve__byte_vectors__reverse_iterateXn, @function
math_prime_util__sieve__byte_vectors__reverse_iterateXn:
.LFB301:
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
.LFE301:
	.size	math_prime_util__sieve__byte_vectors__reverse_iterateXn, .-math_prime_util__sieve__byte_vectors__reverse_iterateXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__swapXn
	.type	math_prime_util__sieve__byte_vectors__swapXn, @function
math_prime_util__sieve__byte_vectors__swapXn:
.LFB303:
	.cfi_startproc
	cmpl	%edx, %esi
	je	.L215
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movslq	%esi, %rsi
	movzbl	4(%rax,%rdx), %r8d
	movzbl	4(%rax,%rsi), %ecx
	movb	%r8b, 4(%rax,%rsi)
	movq	8(%rdi), %rax
	movb	%cl, 4(%rax,%rdx)
.L215:
	ret
	.cfi_endproc
.LFE303:
	.size	math_prime_util__sieve__byte_vectors__swapXn, .-math_prime_util__sieve__byte_vectors__swapXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__to_cursorXn
	.type	math_prime_util__sieve__byte_vectors__to_cursorXn, @function
math_prime_util__sieve__byte_vectors__to_cursorXn:
.LFB305:
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
.LFE305:
	.size	math_prime_util__sieve__byte_vectors__to_cursorXn, .-math_prime_util__sieve__byte_vectors__to_cursorXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__update_elementXn
	.type	math_prime_util__sieve__byte_vectors__update_elementXn, @function
math_prime_util__sieve__byte_vectors__update_elementXn:
.LFB311:
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
	movzbl	4(%rbp,%rbx), %edi
	testb	$1, %dl
	jne	.L227
.L222:
	call	*%rdx
	movb	%al, 4(%rbp,%rbx)
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
.LFE311:
	.size	math_prime_util__sieve__byte_vectors__update_elementXn, .-math_prime_util__sieve__byte_vectors__update_elementXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__update_element__2Xn
	.type	math_prime_util__sieve__byte_vectors__update_element__2Xn, @function
math_prime_util__sieve__byte_vectors__update_element__2Xn:
.LFB312:
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
	movzbl	4(%rbp,%rbx), %edi
	testb	$1, %cl
	jne	.L234
.L229:
	call	*%rcx
	movb	%al, 4(%rbp,%rbx)
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
.LFE312:
	.size	math_prime_util__sieve__byte_vectors__update_element__2Xn, .-math_prime_util__sieve__byte_vectors__update_element__2Xn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T580bXn, @function
math_prime_util__sieve__byte_vectors__T580bXn:
.LFB505:
	.cfi_startproc
	movq	(%rdi), %rax
	movzbl	%sil, %esi
	addq	-16(%rax), %rdi
	jmp	system__finalization_root__root_controlledDA@PLT
	.cfi_endproc
.LFE505:
	.size	math_prime_util__sieve__byte_vectors__T580bXn, .-math_prime_util__sieve__byte_vectors__T580bXn
	.section	.rodata
.LC13:
	.ascii	"math_prime_util-sieve.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__mark, @function
math_prime_util__sieve__mark:
.LFB396:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rsi, %rax
	movq	%rcx, %r10
	movq	%rbx, (%rsp)
	.cfi_offset 3, -48
	movq	%rdx, %rbx
	xorl	%edx, %edx
	divq	%rcx
	cmpq	$1, %rdx
	sbbq	$-1, %rax
	cmpq	%rcx, %rax
	cmovb	%rcx, %rax
	xorl	%edx, %edx
	movq	%rax, %rcx
	movq	%rbx, %rax
	divq	%r10
	cmpq	%rcx, %rax
	jb	.L236
	imulq	%r10, %rcx
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	movabsq	$64424509439, %r14
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -40
	movq	%rsi, %rbp
	movq	%r12, 16(%rsp)
	subq	%rsi, %rcx
	movq	%r13, 24(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	cmpq	%rcx, %r14
	jb	.L240
	movq	%rdi, %r12
	leaq	math_prime_util__sieve__masks(%rip), %r13
	subq	%rsi, %rbx
	movabsq	$-8608480567731124087, %r11
	jmp	.L239
	.p2align 4,,10
	.p2align 3
.L246:
	addq	%r10, %rcx
	cmpq	%rcx, %r14
	jb	.L240
.L239:
	movq	%rcx, %rax
	leaq	0(%rbp,%rcx), %r8
	movq	8(%r12), %r9
	mulq	%r11
	movq	%r8, %rax
	movq	%rdx, %rdi
	mulq	%r11
	shrq	$4, %rdi
	shrq	$4, %rdx
	imulq	$30, %rdx, %rsi
	subq	%rsi, %r8
	movzbl	0(%r13,%r8), %eax
	orb	%al, 4(%r9,%rdi)
	movq	%rbx, %rax
	subq	%rcx, %rax
	cmpq	%r10, %rax
	jnb	.L246
	movq	8(%rsp), %rbp
	.cfi_restore 6
	movq	16(%rsp), %r12
	.cfi_restore 12
	movq	24(%rsp), %r13
	.cfi_restore 13
	movq	32(%rsp), %r14
	.cfi_restore 14
.L236:
	movq	(%rsp), %rbx
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
.L240:
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	movl	$43, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE396:
	.size	math_prime_util__sieve__mark, .-math_prime_util__sieve__mark
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0, @function
math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0:
.LFB16:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%r10, %rbx
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbx, %rdi
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
	.cfi_endproc
.LFE16:
	.size	math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0, .-math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	.set	math_prime_util__sieve__prime_vectors__vectorSI__R288s___finalizer__2.15,math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	.set	math_prime_util__sieve__prime_vectors__to_vector__R1472s___finalizer__2.10,math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	.set	math_prime_util__sieve__prime_vectors__to_vector__R1442s___finalizer.9,math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	.set	math_prime_util__sieve__prime_vectors__empty__R905s___finalizer.5,math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	.set	math_prime_util__sieve__prime_vectors__copy__R867s___finalizer.4,math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	.set	math_prime_util__sieve__prime_vectors__Oconcat__R797s___finalizer__4.3,math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	.set	math_prime_util__sieve__prime_vectors__Oconcat__R788s___finalizer__3.2,math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	.set	math_prime_util__sieve__prime_vectors__Oconcat__R779s___finalizer__2.1,math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17, @function
math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17:
.LFB214:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%r10, %rbx
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbx, %rdi
	leaq	math_prime_util__sieve__byte_vectors__vectorFDXn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
	.cfi_endproc
.LFE214:
	.size	math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17, .-math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17
	.set	math_prime_util__sieve__byte_vectors__vectorSI__R288b___finalizer__2Xn.32,math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17
	.set	math_prime_util__sieve__byte_vectors__to_vector__R1811b___finalizer__2.27,math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17
	.set	math_prime_util__sieve__byte_vectors__to_vector__R1784b___finalizer.26,math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17
	.set	math_prime_util__sieve__byte_vectors__empty__R1286b___finalizer.22,math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17
	.set	math_prime_util__sieve__byte_vectors__copy__R1248b___finalizer.21,math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17
	.set	math_prime_util__sieve__byte_vectors__Oconcat__R1178b___finalizer__4.20,math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17
	.set	math_prime_util__sieve__byte_vectors__Oconcat__R1169b___finalizer__3.19,math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17
	.set	math_prime_util__sieve__byte_vectors__Oconcat__R1160b___finalizer__2.18,math_prime_util__sieve__byte_vectors__Oconcat__R1151b___finalizer.17
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__adjust__2
	.type	math_prime_util__sieve__prime_vectors__adjust__2, @function
math_prime_util__sieve__prime_vectors__adjust__2:
.LFB24:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -32
	movl	16(%rdi), %ebp
	cmpl	$-1, %ebp
	je	.L255
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
.L255:
	.cfi_def_cfa_offset 64
	movq	$0, 8(%rdi)
	movq	32(%rsp), %rbp
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	math_prime_util__sieve__prime_vectors__adjust__2, .-math_prime_util__sieve__prime_vectors__adjust__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__adjust__2Xn
	.type	math_prime_util__sieve__byte_vectors__adjust__2Xn, @function
math_prime_util__sieve__byte_vectors__adjust__2Xn:
.LFB222:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -40
	movl	16(%rdi), %ebp
	cmpl	$-1, %ebp
	je	.L260
	movq	%rbx, (%rsp)
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	movq	%r12, 16(%rsp)
	.cfi_offset 12, -32
	movslq	%ebp, %r12
	movq	%r13, 24(%rsp)
	movq	%r14, 32(%rsp)
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	movq	8(%rdi), %r14
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	leaq	8(%r12), %rdi
	andq	$-4, %rdi
	call	__gnat_malloc@PLT
	leaq	1(%r12), %rdx
	leaq	4(%r14), %rsi
	movl	%ebp, (%rax)
	movq	%rax, %r13
	leaq	4(%rax), %rdi
	call	memcpy@PLT
	movq	%r13, 8(%rbx)
	movq	16(%rsp), %r12
	.cfi_restore 12
	movq	24(%rsp), %r13
	.cfi_restore 13
	movq	32(%rsp), %r14
	.cfi_restore 14
	movl	%ebp, 16(%rbx)
	movq	(%rsp), %rbx
	.cfi_restore 3
	movq	8(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L260:
	.cfi_def_cfa_offset 48
	movq	$0, 8(%rdi)
	movq	8(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE222:
	.size	math_prime_util__sieve__byte_vectors__adjust__2Xn, .-math_prime_util__sieve__byte_vectors__adjust__2Xn
	.section	.rodata
.LC14:
	.ascii	"a-convec.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__delete
	.type	math_prime_util__sieve__prime_vectors__delete, @function
math_prime_util__sieve__prime_vectors__delete:
.LFB37:
	.cfi_startproc
	movl	16(%rdi), %eax
	testl	%edx, %edx
	je	.L282
	cmpl	%esi, %eax
	jl	.L282
	movl	%eax, %ecx
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	subl	%esi, %ecx
	jo	.L266
	cmpl	$2147483647, %ecx
	je	.L266
	addl	$1, %ecx
	cmpl	%ecx, %edx
	jge	.L285
	subl	%edx, %eax
	movl	%eax, %ecx
	jo	.L269
	addl	%esi, %edx
	jo	.L286
	movq	8(%rdi), %r9
	movslq	%esi, %r10
	movq	%rdi, 8(%rsp)
	movslq	%ecx, %rdi
	subq	%r10, %rdi
	xorl	%eax, %eax
	cmpl	%ecx, %esi
	movslq	%edx, %rdx
	leaq	8(,%rdi,8), %rdi
	leaq	8(%r9,%rdx,8), %rsi
	movl	%ecx, 4(%rsp)
	cmovle	%rdi, %rax
	leaq	8(%r9,%r10,8), %rdi
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
.L282:
	ret
	.p2align 4,,10
	.p2align 3
.L285:
	.cfi_def_cfa_offset 32
	subl	$1, %esi
	movl	%esi, 16(%rdi)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L266:
	.cfi_restore_state
	movl	$460, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L269:
	movl	$484, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L286:
	movl	$485, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE37:
	.size	math_prime_util__sieve__prime_vectors__delete, .-math_prime_util__sieve__prime_vectors__delete
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__delete__2
	.type	math_prime_util__sieve__prime_vectors__delete__2, @function
math_prime_util__sieve__prime_vectors__delete__2:
.LFB38:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rdx, %rsi
	movl	%ecx, %edx
	call	math_prime_util__sieve__prime_vectors__delete
	xorl	%eax, %eax
	xorl	%edx, %edx
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE38:
	.size	math_prime_util__sieve__prime_vectors__delete__2, .-math_prime_util__sieve__prime_vectors__delete__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__deleteXn
	.type	math_prime_util__sieve__byte_vectors__deleteXn, @function
math_prime_util__sieve__byte_vectors__deleteXn:
.LFB235:
	.cfi_startproc
	movl	16(%rdi), %ecx
	testl	%edx, %edx
	je	.L310
	cmpl	%esi, %ecx
	jl	.L310
	movl	%esi, %eax
	movl	%ecx, %esi
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	subl	%eax, %esi
	jo	.L294
	cmpl	$2147483647, %esi
	je	.L294
	addl	$1, %esi
	cmpl	%esi, %edx
	jge	.L313
	subl	%edx, %ecx
	jo	.L297
	addl	%eax, %edx
	jo	.L314
	movslq	%eax, %r9
	movl	$1, %esi
	movslq	%ecx, %r11
	movq	8(%rdi), %r10
	subq	%r9, %rsi
	movq	%rdi, 8(%rsp)
	xorl	%edi, %edi
	movslq	%edx, %rdx
	addq	%r11, %rsi
	cmpl	%ecx, %eax
	movl	%ecx, 4(%rsp)
	cmovle	%rsi, %rdi
	leaq	4(%r10,%rdx), %rsi
	movq	%rdi, %rdx
	leaq	4(%r10,%r9), %rdi
	call	memmove@PLT
	movl	4(%rsp), %ecx
	movq	8(%rsp), %r8
	movl	%ecx, 16(%r8)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L310:
	ret
	.p2align 4,,10
	.p2align 3
.L313:
	.cfi_def_cfa_offset 32
	subl	$1, %eax
	movl	%eax, 16(%rdi)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L294:
	.cfi_restore_state
	movl	$460, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L297:
	movl	$484, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L314:
	movl	$485, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE235:
	.size	math_prime_util__sieve__byte_vectors__deleteXn, .-math_prime_util__sieve__byte_vectors__deleteXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__delete__2Xn
	.type	math_prime_util__sieve__byte_vectors__delete__2Xn, @function
math_prime_util__sieve__byte_vectors__delete__2Xn:
.LFB236:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rdx, %rsi
	movl	%ecx, %edx
	call	math_prime_util__sieve__byte_vectors__deleteXn
	xorl	%eax, %eax
	xorl	%edx, %edx
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE236:
	.size	math_prime_util__sieve__byte_vectors__delete__2Xn, .-math_prime_util__sieve__byte_vectors__delete__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__finalize__2
	.type	math_prime_util__sieve__prime_vectors__finalize__2, @function
math_prime_util__sieve__prime_vectors__finalize__2:
.LFB45:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L317
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L317:
	ret
	.cfi_endproc
.LFE45:
	.size	math_prime_util__sieve__prime_vectors__finalize__2, .-math_prime_util__sieve__prime_vectors__finalize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__finalize__2Xn
	.type	math_prime_util__sieve__byte_vectors__finalize__2Xn, @function
math_prime_util__sieve__byte_vectors__finalize__2Xn:
.LFB243:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L319
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L319:
	ret
	.cfi_endproc
.LFE243:
	.size	math_prime_util__sieve__byte_vectors__finalize__2Xn, .-math_prime_util__sieve__byte_vectors__finalize__2Xn
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC15:
	.string	"MATH_PRIME_UTIL.SIEVE.PRIME_VECTORS.IMPLEMENTATION.REFERENCE_CONTROL_TYPE"
	.section	.rodata
	.align 8
.LC0:
	.long	1
	.long	73
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__reference_control_typePI
	.type	math_prime_util__sieve__prime_vectors__implementation__reference_control_typePI, @function
math_prime_util__sieve__prime_vectors__implementation__reference_control_typePI:
.LFB125:
	.cfi_startproc
	leaq	.LC15(%rip), %rsi
	leaq	.LC0(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE125:
	.size	math_prime_util__sieve__prime_vectors__implementation__reference_control_typePI, .-math_prime_util__sieve__prime_vectors__implementation__reference_control_typePI
	.section	.rodata.str1.8
	.align 8
.LC16:
	.string	"MATH_PRIME_UTIL.SIEVE.PRIME_VECTORS.IMPLEMENTATION.WITH_BUSY"
	.section	.rodata
	.align 8
.LC4:
	.long	1
	.long	60
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__with_busyPI
	.type	math_prime_util__sieve__prime_vectors__implementation__with_busyPI, @function
math_prime_util__sieve__prime_vectors__implementation__with_busyPI:
.LFB137:
	.cfi_startproc
	leaq	.LC16(%rip), %rsi
	leaq	.LC4(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE137:
	.size	math_prime_util__sieve__prime_vectors__implementation__with_busyPI, .-math_prime_util__sieve__prime_vectors__implementation__with_busyPI
	.section	.rodata.str1.8
	.align 8
.LC17:
	.string	"MATH_PRIME_UTIL.SIEVE.PRIME_VECTORS.IMPLEMENTATION.WITH_LOCK"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__with_lockPI
	.type	math_prime_util__sieve__prime_vectors__implementation__with_lockPI, @function
math_prime_util__sieve__prime_vectors__implementation__with_lockPI:
.LFB143:
	.cfi_startproc
	leaq	.LC17(%rip), %rsi
	leaq	.LC4(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE143:
	.size	math_prime_util__sieve__prime_vectors__implementation__with_lockPI, .-math_prime_util__sieve__prime_vectors__implementation__with_lockPI
	.section	.rodata.str1.8
	.align 8
.LC18:
	.string	"MATH_PRIME_UTIL.SIEVE.PRIME_VECTORS.ITERATOR"
	.section	.rodata
	.align 8
.LC5:
	.long	1
	.long	44
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__iteratorPI__2
	.type	math_prime_util__sieve__prime_vectors__iteratorPI__2, @function
math_prime_util__sieve__prime_vectors__iteratorPI__2:
.LFB172:
	.cfi_startproc
	leaq	.LC18(%rip), %rsi
	leaq	.LC5(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE172:
	.size	math_prime_util__sieve__prime_vectors__iteratorPI__2, .-math_prime_util__sieve__prime_vectors__iteratorPI__2
	.section	.rodata.str1.8
	.align 8
.LC19:
	.string	"MATH_PRIME_UTIL.SIEVE.BYTE_VECTORS.IMPLEMENTATION.REFERENCE_CONTROL_TYPE"
	.section	.rodata
	.align 8
.LC6:
	.long	1
	.long	72
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__reference_control_typePI
	.type	math_prime_util__sieve__byte_vectors__implementation__reference_control_typePI, @function
math_prime_util__sieve__byte_vectors__implementation__reference_control_typePI:
.LFB323:
	.cfi_startproc
	leaq	.LC19(%rip), %rsi
	leaq	.LC6(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE323:
	.size	math_prime_util__sieve__byte_vectors__implementation__reference_control_typePI, .-math_prime_util__sieve__byte_vectors__implementation__reference_control_typePI
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"MATH_PRIME_UTIL.SIEVE.BYTE_VECTORS.IMPLEMENTATION.WITH_BUSY"
	.section	.rodata
	.align 8
.LC8:
	.long	1
	.long	59
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__with_busyPI
	.type	math_prime_util__sieve__byte_vectors__implementation__with_busyPI, @function
math_prime_util__sieve__byte_vectors__implementation__with_busyPI:
.LFB335:
	.cfi_startproc
	leaq	.LC20(%rip), %rsi
	leaq	.LC8(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE335:
	.size	math_prime_util__sieve__byte_vectors__implementation__with_busyPI, .-math_prime_util__sieve__byte_vectors__implementation__with_busyPI
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"MATH_PRIME_UTIL.SIEVE.BYTE_VECTORS.IMPLEMENTATION.WITH_LOCK"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__with_lockPI
	.type	math_prime_util__sieve__byte_vectors__implementation__with_lockPI, @function
math_prime_util__sieve__byte_vectors__implementation__with_lockPI:
.LFB341:
	.cfi_startproc
	leaq	.LC21(%rip), %rsi
	leaq	.LC8(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE341:
	.size	math_prime_util__sieve__byte_vectors__implementation__with_lockPI, .-math_prime_util__sieve__byte_vectors__implementation__with_lockPI
	.section	.rodata.str1.8
	.align 8
.LC22:
	.string	"MATH_PRIME_UTIL.SIEVE.BYTE_VECTORS.ITERATOR"
	.section	.rodata
	.align 8
.LC9:
	.long	1
	.long	43
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__iteratorPI__2Xn
	.type	math_prime_util__sieve__byte_vectors__iteratorPI__2Xn, @function
math_prime_util__sieve__byte_vectors__iteratorPI__2Xn:
.LFB370:
	.cfi_startproc
	leaq	.LC22(%rip), %rsi
	leaq	.LC9(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE370:
	.size	math_prime_util__sieve__byte_vectors__iteratorPI__2Xn, .-math_prime_util__sieve__byte_vectors__iteratorPI__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSR
	.type	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSR, @function
math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSR:
.LFB126:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$4, %eax
	movq	%rsi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movq	%rdi, 8(%rsp)
	call	ada__finalization__controlledSR__2@PLT
	movq	8(%rsp), %rdi
	call	system__stream_attributes__i_as@PLT
	movq	%rax, 8(%rbx)
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE126:
	.size	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSR, .-math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSR
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSR
	.type	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSR, @function
math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSR:
.LFB324:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$4, %eax
	movq	%rsi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movq	%rdi, 8(%rsp)
	call	ada__finalization__controlledSR__2@PLT
	movq	8(%rsp), %rdi
	call	system__stream_attributes__i_as@PLT
	movq	%rax, 8(%rbx)
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE324:
	.size	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSR, .-math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSR
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSW
	.type	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSW, @function
math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSW:
.LFB127:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$4, %eax
	movq	%rsi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movq	%rdi, 8(%rsp)
	call	ada__finalization__controlledSW__2@PLT
	movq	8(%rbx), %rsi
	movq	8(%rsp), %rdi
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	system__stream_attributes__w_as@PLT
	.cfi_endproc
.LFE127:
	.size	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSW, .-math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSW
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSW
	.type	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSW, @function
math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSW:
.LFB325:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$4, %eax
	movq	%rsi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movq	%rdi, 8(%rsp)
	call	ada__finalization__controlledSW__2@PLT
	movq	8(%rbx), %rsi
	movq	8(%rsp), %rdi
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	system__stream_attributes__w_as@PLT
	.cfi_endproc
.LFE325:
	.size	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSW, .-math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSW
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__Oeq__3
	.type	math_prime_util__sieve__prime_vectors__implementation__Oeq__3, @function
math_prime_util__sieve__prime_vectors__implementation__Oeq__3:
.LFB130:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	ada__finalization__Oeq__3@PLT
	testb	%al, %al
	je	.L337
	movq	8(%rbx), %rax
	cmpq	%rax, 8(%rbp)
	sete	%al
.L337:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE130:
	.size	math_prime_util__sieve__prime_vectors__implementation__Oeq__3, .-math_prime_util__sieve__prime_vectors__implementation__Oeq__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__Oeq__3
	.type	math_prime_util__sieve__byte_vectors__implementation__Oeq__3, @function
math_prime_util__sieve__byte_vectors__implementation__Oeq__3:
.LFB328:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	ada__finalization__Oeq__3@PLT
	testb	%al, %al
	je	.L343
	movq	8(%rbx), %rax
	cmpq	%rax, 8(%rbp)
	sete	%al
.L343:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE328:
	.size	math_prime_util__sieve__byte_vectors__implementation__Oeq__3, .-math_prime_util__sieve__byte_vectors__implementation__Oeq__3
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T558s, @function
math_prime_util__sieve__prime_vectors__T558s:
.LFB192:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	call	ada__tags__offset_to_top@PLT
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 8
	leaq	.LC18(%rip), %rsi
	leaq	.LC5(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE192:
	.size	math_prime_util__sieve__prime_vectors__T558s, .-math_prime_util__sieve__prime_vectors__T558s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T577s, @function
math_prime_util__sieve__prime_vectors__T577s:
.LFB197:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	call	ada__tags__offset_to_top@PLT
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	ada__tags__offset_to_top@PLT
	leaq	(%rbx,%r12), %rdi
	popq	%rbx
	.cfi_def_cfa_offset 24
	leaq	0(%rbp,%rax), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root___assign@PLT
	.cfi_endproc
.LFE197:
	.size	math_prime_util__sieve__prime_vectors__T577s, .-math_prime_util__sieve__prime_vectors__T577s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T572s, @function
math_prime_util__sieve__prime_vectors__T572s:
.LFB196:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	call	ada__tags__offset_to_top@PLT
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	ada__tags__offset_to_top@PLT
	leaq	(%rbx,%r12), %rdi
	popq	%rbx
	.cfi_def_cfa_offset 24
	leaq	0(%rbp,%rax), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root__Oeq@PLT
	.cfi_endproc
.LFE196:
	.size	math_prime_util__sieve__prime_vectors__T572s, .-math_prime_util__sieve__prime_vectors__T572s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T567s, @function
math_prime_util__sieve__prime_vectors__T567s:
.LFB195:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movl	%edx, 12(%rsp)
	call	ada__tags__offset_to_top@PLT
	movl	12(%rsp), %edx
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdi
	leaq	(%rbx,%rax), %rsi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root__root_controlledSO@PLT
	.cfi_endproc
.LFE195:
	.size	math_prime_util__sieve__prime_vectors__T567s, .-math_prime_util__sieve__prime_vectors__T567s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T564s, @function
math_prime_util__sieve__prime_vectors__T564s:
.LFB194:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movl	%edx, 12(%rsp)
	call	ada__tags__offset_to_top@PLT
	movl	12(%rsp), %edx
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdi
	leaq	(%rbx,%rax), %rsi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root__root_controlledSW@PLT
	.cfi_endproc
.LFE194:
	.size	math_prime_util__sieve__prime_vectors__T564s, .-math_prime_util__sieve__prime_vectors__T564s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T561s, @function
math_prime_util__sieve__prime_vectors__T561s:
.LFB193:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movl	%edx, 12(%rsp)
	call	ada__tags__offset_to_top@PLT
	movl	12(%rsp), %edx
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdi
	leaq	(%rbx,%rax), %rsi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root__root_controlledSR@PLT
	.cfi_endproc
.LFE193:
	.size	math_prime_util__sieve__prime_vectors__T561s, .-math_prime_util__sieve__prime_vectors__T561s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T558bXn, @function
math_prime_util__sieve__byte_vectors__T558bXn:
.LFB390:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	call	ada__tags__offset_to_top@PLT
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 8
	leaq	.LC22(%rip), %rsi
	leaq	.LC9(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE390:
	.size	math_prime_util__sieve__byte_vectors__T558bXn, .-math_prime_util__sieve__byte_vectors__T558bXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation___assign__3
	.type	math_prime_util__sieve__prime_vectors__implementation___assign__3, @function
math_prime_util__sieve__prime_vectors__implementation___assign__3:
.LFB131:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L363
	movq	(%rdi), %rax
	movdqu	(%rsi), %xmm0
	movups	%xmm0, (%rdi)
	movq	%rax, (%rdi)
.L363:
	ret
	.cfi_endproc
.LFE131:
	.size	math_prime_util__sieve__prime_vectors__implementation___assign__3, .-math_prime_util__sieve__prime_vectors__implementation___assign__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation___assign__3
	.type	math_prime_util__sieve__byte_vectors__implementation___assign__3, @function
math_prime_util__sieve__byte_vectors__implementation___assign__3:
.LFB329:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L365
	movq	(%rdi), %rax
	movdqu	(%rsi), %xmm0
	movups	%xmm0, (%rdi)
	movq	%rax, (%rdi)
.L365:
	ret
	.cfi_endproc
.LFE329:
	.size	math_prime_util__sieve__byte_vectors__implementation___assign__3, .-math_prime_util__sieve__byte_vectors__implementation___assign__3
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__capacity.part.0, @function
math_prime_util__sieve__prime_vectors__capacity.part.0:
.LFB512:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$275, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE512:
	.size	math_prime_util__sieve__prime_vectors__capacity.part.0, .-math_prime_util__sieve__prime_vectors__capacity.part.0
	.set	math_prime_util__sieve__byte_vectors__capacityXn.part.0,math_prime_util__sieve__prime_vectors__capacity.part.0
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__capacity
	.type	math_prime_util__sieve__prime_vectors__capacity, @function
math_prime_util__sieve__prime_vectors__capacity:
.LFB30:
	.cfi_startproc
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L370
	movl	(%rax), %eax
	testl	%eax, %eax
	js	.L370
	cmpl	$2147483647, %eax
	je	.L371
	addl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L370:
	xorl	%eax, %eax
	ret
.L371:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__prime_vectors__capacity.part.0
	.cfi_endproc
.LFE30:
	.size	math_prime_util__sieve__prime_vectors__capacity, .-math_prime_util__sieve__prime_vectors__capacity
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__length.part.0, @function
math_prime_util__sieve__prime_vectors__length.part.0:
.LFB513:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$2205, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE513:
	.size	math_prime_util__sieve__prime_vectors__length.part.0, .-math_prime_util__sieve__prime_vectors__length.part.0
	.set	math_prime_util__sieve__byte_vectors__lengthXn.part.0,math_prime_util__sieve__prime_vectors__length.part.0
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__length
	.type	math_prime_util__sieve__prime_vectors__length, @function
math_prime_util__sieve__prime_vectors__length:
.LFB76:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L385
	addl	$1, %eax
	ret
.L385:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__prime_vectors__length.part.0
	.cfi_endproc
.LFE76:
	.size	math_prime_util__sieve__prime_vectors__length, .-math_prime_util__sieve__prime_vectors__length
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__write
	.type	math_prime_util__sieve__prime_vectors__write, @function
math_prime_util__sieve__prime_vectors__write:
.LFB115:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	movl	16(%rsi), %esi
	cmpl	$2147483647, %esi
	je	.L392
	addl	$1, %esi
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	call	system__stream_attributes__w_u@PLT
	movl	16(%rbp), %eax
	testl	%eax, %eax
	js	.L386
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	leaq	1(%rax), %r13
	.p2align 4
	.p2align 3
.L389:
	movq	8(%rbp), %rax
	movq	%r12, %rdi
	movq	8(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	system__stream_attributes__w_lu@PLT
	cmpq	%rbx, %r13
	jne	.L389
	movq	8(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %r13
	.cfi_restore 13
.L386:
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
.L392:
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	movq	%r12, 24(%rsp)
	movq	%r13, 32(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__sieve__prime_vectors__length.part.0
	.cfi_endproc
.LFE115:
	.size	math_prime_util__sieve__prime_vectors__write, .-math_prime_util__sieve__prime_vectors__write
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__vectorSW__2
	.type	math_prime_util__sieve__prime_vectors__vectorSW__2, @function
math_prime_util__sieve__prime_vectors__vectorSW__2:
.LFB168:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__sieve__prime_vectors__write
	.cfi_endproc
.LFE168:
	.size	math_prime_util__sieve__prime_vectors__vectorSW__2, .-math_prime_util__sieve__prime_vectors__vectorSW__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__reverse_elements
	.type	math_prime_util__sieve__prime_vectors__reverse_elements, @function
math_prime_util__sieve__prime_vectors__reverse_elements:
.LFB100:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L402
	testl	%eax, %eax
	jle	.L394
	movq	8(%rdi), %rcx
	xorl	%edx, %edx
	.p2align 5
	.p2align 4
	.p2align 3
.L397:
	movq	8(%rcx,%rdx,8), %rsi
	movq	8(%rcx,%rax,8), %rdi
	movq	%rdi, 8(%rcx,%rdx,8)
	addq	$1, %rdx
	movq	%rsi, 8(%rcx,%rax,8)
	subq	$1, %rax
	cmpl	%eax, %edx
	jl	.L397
.L394:
	ret
.L402:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__prime_vectors__length.part.0
	.cfi_endproc
.LFE100:
	.size	math_prime_util__sieve__prime_vectors__reverse_elements, .-math_prime_util__sieve__prime_vectors__reverse_elements
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__Oeq__2
	.type	math_prime_util__sieve__prime_vectors__Oeq__2, @function
math_prime_util__sieve__prime_vectors__Oeq__2:
.LFB23:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	16(%rsi), %eax
	jne	.L408
	cmpl	$2147483647, %eax
	je	.L415
	testl	%eax, %eax
	jns	.L407
.L410:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L407:
	leal	1(%rax), %edx
	movq	8(%rsi), %rcx
	xorl	%eax, %eax
	movq	8(%rdi), %rsi
	salq	$3, %rdx
	jmp	.L409
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L416:
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L410
.L409:
	movq	8(%rcx,%rax), %rdi
	cmpq	%rdi, 8(%rsi,%rax)
	je	.L416
.L408:
	xorl	%eax, %eax
	ret
.L415:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__prime_vectors__length.part.0
	.cfi_endproc
.LFE23:
	.size	math_prime_util__sieve__prime_vectors__Oeq__2, .-math_prime_util__sieve__prime_vectors__Oeq__2
	.section	.text.unlikely,"ax",@progbits
	.align 2
.LCOLDB23:
	.text
.LHOTB23:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert__4
	.type	math_prime_util__sieve__prime_vectors__insert__4, @function
math_prime_util__sieve__prime_vectors__insert__4:
.LFB56:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA56
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%rbp, 48(%rsp)
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	movl	16(%rdi), %edx
	cmpl	$2147483647, %edx
	je	.L512
	movl	%ecx, %r8d
	testl	%ecx, %ecx
	je	.L417
	leal	1(%rdx), %ecx
	xorl	%eax, %eax
	movq	%rbx, 40(%rsp)
	addl	%r8d, %ecx
	movq	%r12, 56(%rsp)
	movq	%r13, 64(%rsp)
	seto	%al
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	jo	.L513
	cmpl	$-2147483648, %ecx
	je	.L514
	movq	8(%rdi), %r12
	movq	%rdi, %rbx
	leal	-1(%rcx), %r13d
	testq	%r12, %r12
	je	.L515
	movl	%esi, %r9d
	movl	(%r12), %esi
	testl	%esi, %esi
	js	.L427
	cmpl	$2147483647, %esi
	je	.L428
	leal	1(%rsi), %eax
.L427:
	cmpl	%eax, %ecx
	jle	.L516
	testl	%eax, %eax
	movl	$1, %edx
	cmovle	%edx, %eax
	cmpl	%eax, %ecx
	jg	.L441
	jmp	.L438
	.p2align 4,,10
	.p2align 3
.L519:
	cmpl	$-1073741824, %eax
	js	.L517
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L518
.L441:
	cmpl	$1073741823, %eax
	jle	.L519
	movabsq	$17179869184, %rdi
	movl	$2147483646, %edx
.L439:
	movl	%r8d, 24(%rsp)
	movl	%r9d, 20(%rsp)
	movl	%ecx, 16(%rsp)
	movl	%edx, 8(%rsp)
.LEHB0:
	call	__gnat_malloc@PLT
	movl	20(%rsp), %r9d
	movl	8(%rsp), %edx
	movq	8(%rbx), %r10
	movl	16(%rbx), %r11d
	movq	%rax, %r12
	testl	%r9d, %r9d
	movl	16(%rsp), %ecx
	movl	24(%rsp), %r8d
	movl	%edx, (%rax)
	jle	.L520
	movl	%r9d, %edx
	leaq	8(%r10), %rsi
	leaq	8(%rax), %rdi
	movl	%r8d, 28(%rsp)
	salq	$3, %rdx
	movl	%ecx, 24(%rsp)
	movl	%r9d, 16(%rsp)
	movq	%r10, 8(%rsp)
	movl	%r11d, 20(%rsp)
	call	memmove@PLT
	movl	16(%rsp), %r9d
	cmpl	20(%rsp), %r9d
	movq	8(%rsp), %r10
	movl	24(%rsp), %ecx
	movq	%rax, %rdi
	movl	28(%rsp), %r8d
	jle	.L445
	cmpl	%r9d, %r13d
	jge	.L443
.L446:
	movq	%r12, 8(%rbx)
	movq	48(%rsp), %rbp
	movq	%r10, %rdi
	movl	%r13d, 16(%rbx)
	movq	56(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	64(%rsp), %r13
	.cfi_restore 13
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L516:
	.cfi_restore_state
	cmpl	%r9d, %edx
	jl	.L521
	addl	%r9d, %r8d
	jo	.L434
	cmpl	%r8d, %r13d
	jl	.L436
	movslq	%r8d, %rax
	movslq	%ecx, %rdx
	leal	1(%r9), %ecx
	movl	%r8d, 16(%rsp)
	subq	%rax, %rdx
	movslq	%ecx, %rcx
	leaq	8(%r12,%rax,8), %rdi
	movl	%r9d, 8(%rsp)
	salq	$3, %rdx
	leaq	(%r12,%rcx,8), %rsi
	call	memmove@PLT
	movl	16(%rsp), %r8d
	movl	8(%rsp), %r9d
	cmpl	$-2147483648, %r8d
	je	.L522
.L436:
	leal	-1(%r8), %eax
	cmpl	%eax, %r9d
	jg	.L431
	subl	%r9d, %r8d
	movslq	%r9d, %rcx
	leal	-1(%r8), %edx
	leaq	(%r12,%rcx,8), %rax
	addq	%rcx, %rdx
	leaq	8(%r12,%rdx,8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$8, %ecx
	jne	.L505
	.p2align 4
	.p2align 4
	.p2align 3
.L437:
	movq	%rbp, 8(%rax)
	addq	$16, %rax
	movq	%rbp, (%rax)
	cmpq	%rdx, %rax
	jne	.L437
	.p2align 4
	.p2align 3
.L431:
	movl	%r13d, 16(%rbx)
	movq	56(%rsp), %r12
	.cfi_restore 12
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	64(%rsp), %r13
	.cfi_restore 13
.L417:
	movq	48(%rsp), %rbp
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L521:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	cmpl	%r9d, %r13d
	jl	.L431
	subl	%r9d, %ecx
	movslq	%r9d, %rsi
	leal	-1(%rcx), %edx
	leaq	(%r12,%rsi,8), %rax
	addq	%rsi, %rdx
	leaq	8(%r12,%rdx,8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$8, %ecx
	je	.L432
	movq	%rbp, 8(%rax)
	addq	$8, %rax
	cmpq	%rax, %rdx
	je	.L431
	.p2align 4
	.p2align 4
	.p2align 3
.L432:
	movq	%rbp, 8(%rax)
	addq	$16, %rax
	movq	%rbp, (%rax)
	cmpq	%rax, %rdx
	jne	.L432
	jmp	.L431
	.p2align 4,,10
	.p2align 3
.L518:
	leal	1(%rax), %edi
	leal	-1(%rax), %edx
	movslq	%edi, %rdi
	salq	$3, %rdi
	jmp	.L439
	.p2align 4,,10
	.p2align 3
.L520:
	cmpl	%r11d, %r9d
	jg	.L443
	movl	%r8d, %eax
	addl	%r9d, %eax
	jo	.L450
	movl	%eax, %r8d
	cmpl	$-2147483648, %eax
	je	.L451
	leal	-1(%rax), %edx
	leaq	8(%r12), %rdi
	cmpl	%edx, %r9d
	jle	.L452
	cltq
	movslq	%r9d, %rsi
.L453:
	movl	%ecx, %edx
	subq	%rax, %rdx
	salq	$3, %rdx
	jmp	.L460
	.p2align 4,,10
	.p2align 3
.L445:
	addl	%r9d, %r8d
	jo	.L450
	cmpl	$-2147483648, %r8d
	je	.L451
	leal	-1(%r8), %eax
	movslq	%r9d, %rsi
	cmpl	%eax, %r9d
	jg	.L458
.L452:
	movl	%r8d, %edx
	movslq	%r9d, %rsi
	subl	%r9d, %edx
	leaq	(%r12,%rsi,8), %rax
	subl	$1, %edx
	addq	%rsi, %rdx
	leaq	(%rdi,%rdx,8), %rdx
	movq	%rdx, %rdi
	subq	%rax, %rdi
	andl	$8, %edi
	je	.L459
	movq	%rbp, 8(%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L458
	.p2align 4
	.p2align 4
	.p2align 3
.L459:
	movq	%rbp, 8(%rax)
	addq	$16, %rax
	movq	%rbp, (%rax)
	cmpq	%rdx, %rax
	jne	.L459
.L458:
	movslq	%r8d, %rax
	xorl	%edx, %edx
	cmpl	%r8d, %r13d
	jge	.L453
.L460:
	leaq	8(%r10,%rsi,8), %rsi
	leaq	8(%r12,%rax,8), %rdi
	movq	%r10, 8(%rsp)
	call	memmove@PLT
	movq	8(%rsp), %r10
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L443:
	subl	%r9d, %ecx
	movslq	%r9d, %rdx
	subl	$1, %ecx
	leaq	(%r12,%rdx,8), %rax
	leaq	1(%rdx,%rcx), %rdx
	leaq	(%r12,%rdx,8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$8, %ecx
	je	.L447
	movq	%rbp, 8(%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L446
	.p2align 4
	.p2align 4
	.p2align 3
.L447:
	movq	%rbp, 8(%rax)
	addq	$16, %rax
	movq	%rbp, (%rax)
	cmpq	%rdx, %rax
	jne	.L447
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L515:
	movslq	%r13d, %rax
	leaq	16(,%rax,8), %rdi
	call	__gnat_malloc@PLT
	movl	%r13d, (%rax)
	movq	%rax, %rdx
	testl	%r13d, %r13d
	js	.L425
	movl	%r13d, %ecx
	leaq	8(%rax), %rax
	leaq	16(%rdx,%rcx,8), %rcx
	movq	%rcx, %rsi
	subq	%rax, %rsi
	andl	$8, %esi
	je	.L426
	movq	%rbp, (%rax)
	leaq	16(%rdx), %rax
	cmpq	%rcx, %rax
	je	.L425
	.p2align 4
	.p2align 4
	.p2align 3
.L426:
	movq	%rbp, (%rax)
	addq	$16, %rax
	movq	%rbp, -8(%rax)
	cmpq	%rcx, %rax
	jne	.L426
.L425:
	movl	%r13d, 16(%rbx)
	movq	56(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	%rdx, 8(%rbx)
	movq	64(%rsp), %r13
	.cfi_restore 13
	movq	40(%rsp), %rbx
	.cfi_restore 3
	jmp	.L417
	.p2align 4,,10
	.p2align 3
.L505:
	.cfi_restore_state
	movq	%rbp, 8(%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	jne	.L437
	jmp	.L431
.L438:
	leal	1(%rax), %edi
	leal	-1(%rax), %edx
	salq	$3, %rdi
	jmp	.L439
.L517:
	movl	$1235, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L514:
	movl	$1149, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L513:
	movl	$1037, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L512:
	.cfi_restore 3
	.cfi_restore 12
	.cfi_restore 13
	movq	%rbx, 40(%rsp)
	movq	%r12, 56(%rsp)
	movq	%r13, 64(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__sieve__prime_vectors__length.part.0
.L522:
	movl	$1212, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE0:
.L451:
	movl	$1291, %esi
	leaq	.LC14(%rip), %rdi
.LEHB1:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L450:
	movl	$1286, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE1:
.L434:
	movl	$1206, %esi
	leaq	.LC14(%rip), %rdi
.LEHB2:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L428:
	movl	$1182, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE2:
.L466:
	movq	%rax, %rbx
	jmp	.L461
	.section	.gcc_except_table,"a",@progbits
	.align 4
.LLSDA56:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT56-.LLSDATTD56
.LLSDATTD56:
	.byte	0x1
	.uleb128 .LLSDACSE56-.LLSDACSB56
.LLSDACSB56:
	.uleb128 .LEHB0-.LFB56
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB1-.LFB56
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L466-.LFB56
	.uleb128 0x1
	.uleb128 .LEHB2-.LFB56
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
.LLSDACSE56:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT56:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC56
	.type	math_prime_util__sieve__prime_vectors__insert__4.cold, @function
math_prime_util__sieve__prime_vectors__insert__4.cold:
.LFSB56:
.L461:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L511
	call	__gnat_begin_handler_v1@PLT
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB3:
	call	__gnat_free@PLT
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE3:
.L467:
	movq	%rax, %rbp
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r13, %rsi
.LEHB4:
	call	__gnat_end_handler_v1@PLT
	movq	%rbp, %rdi
.L511:
	call	_Unwind_Resume@PLT
.LEHE4:
	.cfi_endproc
.LFE56:
	.section	.gcc_except_table
	.align 4
.LLSDAC56:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC56-.LLSDATTDC56
.LLSDATTDC56:
	.byte	0x1
	.uleb128 .LLSDACSEC56-.LLSDACSBC56
.LLSDACSBC56:
	.uleb128 .LEHB3-.LCOLDB23
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L467-.LCOLDB23
	.uleb128 0
	.uleb128 .LEHB4-.LCOLDB23
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSEC56:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC56:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__insert__4, .-math_prime_util__sieve__prime_vectors__insert__4
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__insert__4.cold, .-math_prime_util__sieve__prime_vectors__insert__4.cold
.LCOLDE23:
	.text
.LHOTE23:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert__6
	.type	math_prime_util__sieve__prime_vectors__insert__6, @function
math_prime_util__sieve__prime_vectors__insert__6:
.LFB61:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rcx, %r10
	movl	48(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L524
	testq	%rsi, %rsi
	je	.L530
	cmpl	%edx, 16(%rdi)
	jge	.L532
.L530:
	xorl	%edi, %edi
	jmp	.L525
	.p2align 4,,10
	.p2align 3
.L524:
	movl	16(%rdi), %r11d
	testq	%rsi, %rsi
	je	.L526
	movl	%edx, %eax
	cmpl	%r11d, %edx
	jg	.L527
.L528:
	movq	%r10, %rdx
	movl	%eax, %esi
	movq	%r9, 24(%rsp)
	movq	%rdi, (%rsp)
	movq	%r8, 16(%rsp)
	movl	%eax, 12(%rsp)
	call	math_prime_util__sieve__prime_vectors__insert__4
	movl	12(%rsp), %ecx
	movq	(%rsp), %rdi
	movq	24(%rsp), %r9
.L525:
	movl	%r9d, %eax
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movq	%rax, %rdx
	movq	%rdi, %rax
	movabsq	$-4294967296, %rdi
	movq	%rdx, %rsi
	andq	%rdi, %rsi
	orq	%rsi, %rcx
	movq	%rcx, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L526:
	.cfi_restore_state
	cmpl	$2147483647, %r11d
	je	.L533
.L527:
	leal	1(%r11), %eax
	jmp	.L528
	.p2align 4,,10
	.p2align 3
.L532:
	movl	%edx, %ecx
	jmp	.L525
.L533:
	movl	$1585, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE61:
	.size	math_prime_util__sieve__prime_vectors__insert__6, .-math_prime_util__sieve__prime_vectors__insert__6
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert__7
	.type	math_prime_util__sieve__prime_vectors__insert__7, @function
math_prime_util__sieve__prime_vectors__insert__7:
.LFB62:
	.cfi_startproc
	movl	%edx, %ecx
	xorl	%edx, %edx
	jmp	math_prime_util__sieve__prime_vectors__insert__4
	.cfi_endproc
.LFE62:
	.size	math_prime_util__sieve__prime_vectors__insert__7, .-math_prime_util__sieve__prime_vectors__insert__7
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__prepend__2
	.type	math_prime_util__sieve__prime_vectors__prepend__2, @function
math_prime_util__sieve__prime_vectors__prepend__2:
.LFB81:
	.cfi_startproc
	movl	%edx, %ecx
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__sieve__prime_vectors__insert__4
	.cfi_endproc
.LFE81:
	.size	math_prime_util__sieve__prime_vectors__prepend__2, .-math_prime_util__sieve__prime_vectors__prepend__2
	.section	.text.unlikely
	.align 2
.LCOLDB24:
	.text
.LHOTB24:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert_space
	.type	math_prime_util__sieve__prime_vectors__insert_space, @function
math_prime_util__sieve__prime_vectors__insert_space:
.LFB64:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA64
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movl	%edx, %r8d
	movl	16(%rdi), %edx
	cmpl	$2147483647, %edx
	je	.L576
	testl	%r8d, %r8d
	je	.L536
	leal	1(%rdx), %ecx
	movq	%rbx, 16(%rsp)
	addl	%r8d, %ecx
	movq	%rbp, 24(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	jo	.L540
	movq	%r13, 40(%rsp)
	cmpl	$-2147483648, %ecx
	.cfi_offset 13, -24
	je	.L577
	movl	%esi, %ebx
	movq	8(%rdi), %rsi
	movq	%rdi, %rbp
	leal	-1(%rcx), %r13d
	testq	%rsi, %rsi
	je	.L578
	movl	(%rsi), %eax
	cmpl	%r13d, %eax
	jge	.L579
	xorl	%edx, %edx
	testl	%eax, %eax
	movq	%r12, 32(%rsp)
	cmovns	%eax, %edx
	movq	%r14, 48(%rsp)
	leal	1(%rdx), %eax
	cmpl	%eax, %ecx
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	jg	.L553
	jmp	.L550
	.p2align 4,,10
	.p2align 3
.L582:
	cmpl	$-1073741824, %eax
	js	.L580
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L581
.L553:
	cmpl	$1073741823, %eax
	jle	.L582
	movabsq	$17179869184, %rdi
	movl	$2147483646, %edx
.L551:
	movl	%edx, 4(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%ecx, 8(%rsp)
.LEHB5:
	call	__gnat_malloc@PLT
	movl	4(%rsp), %edx
	xorl	%r9d, %r9d
	movq	8(%rbp), %r14
	leaq	8(%rax), %rdi
	movq	%rax, %r12
	movl	%edx, (%rax)
	movl	%ebx, %edx
	leaq	8(%r14), %rsi
	salq	$3, %rdx
	testl	%ebx, %ebx
	cmovle	%r9, %rdx
	call	memmove@PLT
	cmpl	%ebx, 16(%rbp)
	jl	.L555
	movl	12(%rsp), %r8d
	addl	%ebx, %r8d
	jo	.L557
	movslq	8(%rsp), %rdx
	movslq	%r8d, %rax
	xorl	%r9d, %r9d
	movslq	%ebx, %rbx
	leaq	8(%r14,%rbx,8), %rsi
	leaq	8(%r12,%rax,8), %rdi
	subq	%rax, %rdx
	salq	$3, %rdx
	cmpl	%r8d, %r13d
	cmovl	%r9, %rdx
	call	memmove@PLT
.L555:
	movq	%r12, 8(%rbp)
	movq	16(%rsp), %rbx
	.cfi_restore 3
	movq	%r14, %rdi
	movq	32(%rsp), %r12
	.cfi_restore 12
	movq	48(%rsp), %r14
	.cfi_restore 14
	movl	%r13d, 16(%rbp)
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r13
	.cfi_restore 13
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L579:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	cmpl	%ebx, %edx
	jl	.L545
	addl	%ebx, %r8d
	jo	.L547
	movslq	%r8d, %rax
	movslq	%ecx, %rdx
	xorl	%ecx, %ecx
	subq	%rax, %rdx
	leaq	8(%rsi,%rax,8), %rdi
	salq	$3, %rdx
	cmpl	%r8d, %r13d
	cmovl	%rcx, %rdx
	addl	$1, %ebx
	movslq	%ebx, %rbx
	leaq	(%rsi,%rbx,8), %rsi
	call	memmove@PLT
.L545:
	movl	%r13d, 16(%rbp)
	movq	16(%rsp), %rbx
	.cfi_restore 3
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r13
	.cfi_restore 13
.L536:
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L581:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	leal	1(%rax), %edi
	leal	-1(%rax), %edx
	movslq	%edi, %rdi
	salq	$3, %rdi
	jmp	.L551
	.p2align 4,,10
	.p2align 3
.L578:
	.cfi_restore 12
	.cfi_restore 14
	movslq	%r13d, %rax
	leaq	16(,%rax,8), %rdi
	call	__gnat_malloc@PLT
	movl	%r13d, 16(%rbp)
	movl	%r13d, (%rax)
	movq	16(%rsp), %rbx
	.cfi_restore 3
	movq	%rax, 8(%rbp)
	movq	40(%rsp), %r13
	.cfi_restore 13
	movq	24(%rsp), %rbp
	.cfi_restore 6
	jmp	.L536
.L550:
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	leal	2(%rdx), %edi
	salq	$3, %rdi
	jmp	.L551
.L580:
	movl	$1891, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L577:
	.cfi_restore 12
	.cfi_restore 14
	movl	$1811, %esi
	leaq	.LC14(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L540:
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	movl	$1700, %esi
	leaq	.LC14(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r13, 40(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L576:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	movq	%rbx, 16(%rsp)
	movq	%rbp, 24(%rsp)
	movq	%r12, 32(%rsp)
	movq	%r13, 40(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	math_prime_util__sieve__prime_vectors__length.part.0
.LEHE5:
.L557:
	movl	$1939, %esi
	leaq	.LC14(%rip), %rdi
.LEHB6:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE6:
.L547:
	.cfi_restore 12
	.cfi_restore 14
	movl	$1861, %esi
	leaq	.LC14(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 14, -16
.LEHB7:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE7:
.L567:
	movq	%rax, %rbx
	jmp	.L560
	.section	.gcc_except_table
	.align 4
.LLSDA64:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT64-.LLSDATTD64
.LLSDATTD64:
	.byte	0x1
	.uleb128 .LLSDACSE64-.LLSDACSB64
.LLSDACSB64:
	.uleb128 .LEHB5-.LFB64
	.uleb128 .LEHE5-.LEHB5
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB6-.LFB64
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L567-.LFB64
	.uleb128 0x1
	.uleb128 .LEHB7-.LFB64
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
.LLSDACSE64:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT64:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC64
	.type	math_prime_util__sieve__prime_vectors__insert_space.cold, @function
math_prime_util__sieve__prime_vectors__insert_space.cold:
.LFSB64:
.L560:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L575
	call	__gnat_begin_handler_v1@PLT
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB8:
	call	__gnat_free@PLT
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE8:
.L568:
	movq	%rax, %rbp
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r13, %rsi
.LEHB9:
	call	__gnat_end_handler_v1@PLT
	movq	%rbp, %rdi
.L575:
	call	_Unwind_Resume@PLT
.LEHE9:
	.cfi_endproc
.LFE64:
	.section	.gcc_except_table
	.align 4
.LLSDAC64:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC64-.LLSDATTDC64
.LLSDATTDC64:
	.byte	0x1
	.uleb128 .LLSDACSEC64-.LLSDACSBC64
.LLSDACSBC64:
	.uleb128 .LEHB8-.LCOLDB24
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L568-.LCOLDB24
	.uleb128 0
	.uleb128 .LEHB9-.LCOLDB24
	.uleb128 .LEHE9-.LEHB9
	.uleb128 0
	.uleb128 0
.LLSDACSEC64:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC64:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__insert_space, .-math_prime_util__sieve__prime_vectors__insert_space
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__insert_space.cold, .-math_prime_util__sieve__prime_vectors__insert_space.cold
.LCOLDE24:
	.text
.LHOTE24:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert_space__2
	.type	math_prime_util__sieve__prime_vectors__insert_space__2, @function
math_prime_util__sieve__prime_vectors__insert_space__2:
.LFB65:
	.cfi_startproc
	movq	%rdi, %rax
	movq	%rsi, %rdi
	movq	%rdx, %rsi
	movl	%r9d, %edx
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	testl	%edx, %edx
	jne	.L584
	testq	%rdi, %rdi
	je	.L590
	cmpl	%esi, 16(%rax)
	jge	.L592
.L590:
	xorl	%eax, %eax
	jmp	.L585
	.p2align 4,,10
	.p2align 3
.L584:
	movl	16(%rax), %r9d
	movq	%rcx, %r10
	movq	%r8, %r11
	testq	%rdi, %rdi
	je	.L586
	movl	%esi, %ecx
	cmpl	%r9d, %esi
	jg	.L587
.L588:
	movq	%rax, %rdi
	movl	%ecx, %esi
	movq	%r8, 40(%rsp)
	movq	%rax, 8(%rsp)
	movq	%r10, 16(%rsp)
	movq	%r11, 24(%rsp)
	movl	%ecx, 36(%rsp)
	call	math_prime_util__sieve__prime_vectors__insert_space
	movl	36(%rsp), %edx
	movq	8(%rsp), %rax
	movq	40(%rsp), %r8
.L585:
	movl	%r8d, %r8d
	movq	%rax, %r10
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movabsq	$-4294967296, %rcx
	movq	%r8, %rax
	andq	%rcx, %rax
	orq	%rdx, %rax
	movq	%rax, %r11
	movq	%r10, %rax
	movq	%r11, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L586:
	.cfi_restore_state
	cmpl	$2147483647, %r9d
	je	.L593
.L587:
	leal	1(%r9), %ecx
	jmp	.L588
	.p2align 4,,10
	.p2align 3
.L592:
	movl	%esi, %edx
	jmp	.L585
.L593:
	movl	$2006, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE65:
	.size	math_prime_util__sieve__prime_vectors__insert_space__2, .-math_prime_util__sieve__prime_vectors__insert_space__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert_vector
	.type	math_prime_util__sieve__prime_vectors__insert_vector, @function
math_prime_util__sieve__prime_vectors__insert_vector:
.LFB57:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	movl	16(%rdx), %ebx
	cmpl	$2147483647, %ebx
	je	.L622
	addl	$1, %ebx
	movq	%rdx, %r13
	movq	%rdi, %r12
	movl	%esi, %ebp
	movl	%ebx, %edx
	call	math_prime_util__sieve__prime_vectors__insert_space
	testl	%ebx, %ebx
	je	.L594
	leal	-1(%rbp), %eax
	xorl	%esi, %esi
	movl	%eax, %ecx
	addl	%ebx, %ecx
	seto	%sil
	jo	.L623
	movq	8(%r12), %rdx
	cmpq	%r13, %r12
	jne	.L624
	testl	%eax, %eax
	cmovns	%ebp, %esi
	xorl	%r8d, %r8d
	addl	%esi, %eax
	movl	%esi, %r13d
	seto	%r8b
	jo	.L625
	movslq	%ebp, %r9
	movslq	%eax, %rdi
	xorl	%esi, %esi
	movl	%ecx, 12(%rsp)
	subq	%r9, %rdi
	cmpl	%eax, %ebp
	leaq	8(%rdx), %rax
	movl	%r8d, 8(%rsp)
	leaq	8(,%rdi,8), %rdi
	cmovle	%rdi, %rsi
	leaq	8(%rdx,%r9,8), %rdi
	movq	%rsi, %rdx
	movq	%rax, %rsi
	call	memmove@PLT
	cmpl	%ebx, %r13d
	je	.L594
	movl	12(%rsp), %ecx
	movl	8(%rsp), %r8d
	cmpl	$2147483647, %ecx
	je	.L626
	movl	16(%r12), %esi
	leal	1(%rcx), %eax
	cmpl	%esi, %eax
	jg	.L608
	movslq	%eax, %rdi
	movslq	%esi, %rdx
	subq	%rdi, %rdx
	movl	$2147483649, %edi
	addq	%rdi, %rdx
	shrq	$32, %rdx
	jne	.L612
	addl	$1, %esi
	subl	%eax, %esi
	movl	%esi, %r8d
.L608:
	movl	%eax, %r9d
	subl	%r8d, %r9d
	jo	.L612
	cltq
	movslq	%r9d, %rdi
	movq	8(%r12), %rsi
	movq	%rax, %rdx
	subq	%rdi, %rdx
	leaq	8(%rsi,%rdi,8), %rdi
	leaq	8(%rsi,%rax,8), %rsi
	salq	$3, %rdx
	cmpl	%r9d, %ecx
	movl	$0, %ecx
	cmovl	%rcx, %rdx
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	memmove@PLT
	.p2align 4,,10
	.p2align 3
.L624:
	.cfi_restore_state
	movslq	%ebp, %r8
	movslq	%ecx, %rdi
	xorl	%eax, %eax
	movq	8(%r13), %rsi
	subq	%r8, %rdi
	cmpl	%ecx, %ebp
	leaq	8(,%rdi,8), %rdi
	cmovle	%rdi, %rax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	8(%rdx,%r8,8), %rdi
	addq	$8, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	movq	%rax, %rdx
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	memmove@PLT
	.p2align 4,,10
	.p2align 3
.L594:
	.cfi_restore_state
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L622:
	.cfi_restore_state
	call	math_prime_util__sieve__prime_vectors__length.part.0
.L623:
	movl	$1349, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L612:
	movl	$1435, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L626:
	movl	$1418, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L625:
	movl	$1392, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE57:
	.size	math_prime_util__sieve__prime_vectors__insert_vector, .-math_prime_util__sieve__prime_vectors__insert_vector
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert_vector__3
	.type	math_prime_util__sieve__prime_vectors__insert_vector__3, @function
math_prime_util__sieve__prime_vectors__insert_vector__3:
.LFB59:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%edx, %ebx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movl	16(%rcx), %eax
	testl	%eax, %eax
	js	.L636
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L630
	cmpl	%eax, %edx
	jle	.L632
.L631:
	leal	1(%rax), %ebx
.L632:
	movq	%rcx, %rdx
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r9, 8(%rsp)
	movq	%r8, (%rsp)
	call	math_prime_util__sieve__prime_vectors__insert_vector
	movq	8(%rsp), %r9
.L629:
	movl	%r9d, %eax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movabsq	$-4294967296, %rsi
	movq	%rax, %rdx
	movq	%rbp, %rax
	movq	%rdx, %rcx
	andq	%rsi, %rcx
	orq	%rbx, %rcx
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	movq	%rcx, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L636:
	.cfi_restore_state
	testq	%rsi, %rsi
	je	.L633
	xorl	%eax, %eax
	cmpl	16(%rdi), %edx
	cmovg	%rax, %rbx
	movl	$0, %eax
	cmovg	%rax, %rbp
	jmp	.L629
	.p2align 4,,10
	.p2align 3
.L630:
	cmpl	$2147483647, %eax
	jne	.L631
	movl	$1508, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L633:
	xorl	%ebx, %ebx
	xorl	%ebp, %ebp
	jmp	.L629
	.cfi_endproc
.LFE59:
	.size	math_prime_util__sieve__prime_vectors__insert_vector__3, .-math_prime_util__sieve__prime_vectors__insert_vector__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__prepend_vector
	.type	math_prime_util__sieve__prime_vectors__prepend_vector, @function
math_prime_util__sieve__prime_vectors__prepend_vector:
.LFB82:
	.cfi_startproc
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__sieve__prime_vectors__insert_vector
	.cfi_endproc
.LFE82:
	.size	math_prime_util__sieve__prime_vectors__prepend_vector, .-math_prime_util__sieve__prime_vectors__prepend_vector
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__reserve_capacity
	.type	math_prime_util__sieve__prime_vectors__reserve_capacity, @function
math_prime_util__sieve__prime_vectors__reserve_capacity:
.LFB99:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movl	16(%rdi), %r8d
	cmpl	$2147483647, %r8d
	je	.L659
	movq	8(%rdi), %r9
	movq	%rdi, %rcx
	leal	1(%r8), %edx
	testl	%esi, %esi
	jne	.L640
	testl	%edx, %edx
	je	.L660
	movl	(%r9), %eax
	testl	%eax, %eax
	js	.L643
	cmpl	$2147483647, %eax
	je	.L644
	leal	1(%rax), %esi
.L643:
	cmpl	%esi, %edx
	jl	.L658
.L638:
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L640:
	.cfi_restore_state
	leal	-1(%rsi), %r10d
	testq	%r9, %r9
	je	.L661
	movl	(%r9), %eax
	cmpl	%edx, %esi
	jg	.L646
	testl	%eax, %eax
	js	.L652
	cmpl	$2147483647, %eax
	je	.L648
	addl	$1, %eax
.L647:
	cmpl	%edx, %eax
	jle	.L638
.L658:
	movslq	%edx, %rdx
	movq	%rcx, 40(%rsp)
	salq	$3, %rdx
	movq	%r9, 32(%rsp)
	leaq	8(%rdx), %rdi
	movl	%r8d, 8(%rsp)
	movq	%rdx, 24(%rsp)
	call	__gnat_malloc@PLT
	movl	8(%rsp), %r8d
	leaq	8(%rax), %rdi
	movl	%r8d, (%rax)
	movq	32(%rsp), %r9
	movq	24(%rsp), %rdx
	movq	%rax, 16(%rsp)
	leaq	8(%r9), %rsi
	movq	%r9, 8(%rsp)
	call	memcpy@PLT
	movq	16(%rsp), %r10
	movq	40(%rsp), %rcx
	movq	8(%rsp), %rdi
	movq	%r10, 8(%rcx)
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L646:
	.cfi_restore_state
	testl	%eax, %eax
	js	.L649
	cmpl	$2147483647, %eax
	je	.L662
	addl	$1, %eax
	cmpl	%eax, %esi
	je	.L638
.L649:
	movslq	%r10d, %rax
	movq	%rcx, 16(%rsp)
	leaq	16(,%rax,8), %rdi
	movl	%r10d, 8(%rsp)
	call	__gnat_malloc@PLT
	movq	16(%rsp), %rcx
	movl	8(%rsp), %r10d
	movq	%rax, %r8
	movl	16(%rcx), %edx
	movq	8(%rcx), %r9
	movl	%r10d, (%rax)
	leaq	8(%r8), %rdi
	movq	%rcx, 24(%rsp)
	movq	%rdx, %rax
	leaq	8(%r9), %rsi
	movq	%r8, 8(%rsp)
	leaq	8(,%rdx,8), %rdx
	testl	%eax, %eax
	movl	$0, %eax
	movq	%r9, 16(%rsp)
	cmovs	%rax, %rdx
	call	memmove@PLT
	movq	8(%rsp), %r8
	movq	24(%rsp), %rcx
	movq	16(%rsp), %rdi
	movq	%r8, 8(%rcx)
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L652:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L647
	.p2align 4,,10
	.p2align 3
.L660:
	movq	$0, 8(%rdi)
	testq	%r9, %r9
	je	.L638
	movq	%r9, %rdi
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L661:
	.cfi_restore_state
	movslq	%r10d, %rax
	movq	%rdi, 16(%rsp)
	leaq	16(,%rax,8), %rdi
	movl	%r10d, 8(%rsp)
	call	__gnat_malloc@PLT
	movl	8(%rsp), %r10d
	movq	16(%rsp), %rcx
	movl	%r10d, (%rax)
	movq	%rax, 8(%rcx)
	jmp	.L638
.L659:
	call	math_prime_util__sieve__prime_vectors__length.part.0
.L644:
	movl	$2605, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L662:
	movl	$2795, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L648:
	movl	$2745, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE99:
	.size	math_prime_util__sieve__prime_vectors__reserve_capacity, .-math_prime_util__sieve__prime_vectors__reserve_capacity
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__capacityXn
	.type	math_prime_util__sieve__byte_vectors__capacityXn, @function
math_prime_util__sieve__byte_vectors__capacityXn:
.LFB228:
	.cfi_startproc
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L664
	movl	(%rax), %eax
	testl	%eax, %eax
	js	.L664
	cmpl	$2147483647, %eax
	je	.L665
	addl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L664:
	xorl	%eax, %eax
	ret
.L665:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__byte_vectors__capacityXn.part.0
	.cfi_endproc
.LFE228:
	.size	math_prime_util__sieve__byte_vectors__capacityXn, .-math_prime_util__sieve__byte_vectors__capacityXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__lengthXn
	.type	math_prime_util__sieve__byte_vectors__lengthXn, @function
math_prime_util__sieve__byte_vectors__lengthXn:
.LFB274:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L677
	addl	$1, %eax
	ret
.L677:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
	.cfi_endproc
.LFE274:
	.size	math_prime_util__sieve__byte_vectors__lengthXn, .-math_prime_util__sieve__byte_vectors__lengthXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__writeXn
	.type	math_prime_util__sieve__byte_vectors__writeXn, @function
math_prime_util__sieve__byte_vectors__writeXn:
.LFB313:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	movl	16(%rsi), %esi
	cmpl	$2147483647, %esi
	je	.L684
	addl	$1, %esi
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	call	system__stream_attributes__w_u@PLT
	movl	16(%rbp), %eax
	testl	%eax, %eax
	js	.L678
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	leaq	1(%rax), %r13
	.p2align 4
	.p2align 3
.L681:
	movq	8(%rbp), %rax
	movq	%r12, %rdi
	movzbl	4(%rax,%rbx), %esi
	addq	$1, %rbx
	call	system__stream_attributes__w_ssu@PLT
	cmpq	%rbx, %r13
	jne	.L681
	movq	8(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %r13
	.cfi_restore 13
.L678:
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
.L684:
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	movq	%r12, 24(%rsp)
	movq	%r13, 32(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
	.cfi_endproc
.LFE313:
	.size	math_prime_util__sieve__byte_vectors__writeXn, .-math_prime_util__sieve__byte_vectors__writeXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__vectorSW__2Xn
	.type	math_prime_util__sieve__byte_vectors__vectorSW__2Xn, @function
math_prime_util__sieve__byte_vectors__vectorSW__2Xn:
.LFB366:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__sieve__byte_vectors__writeXn
	.cfi_endproc
.LFE366:
	.size	math_prime_util__sieve__byte_vectors__vectorSW__2Xn, .-math_prime_util__sieve__byte_vectors__vectorSW__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__reverse_elementsXn
	.type	math_prime_util__sieve__byte_vectors__reverse_elementsXn, @function
math_prime_util__sieve__byte_vectors__reverse_elementsXn:
.LFB298:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L694
	testl	%eax, %eax
	jle	.L686
	movq	8(%rdi), %rcx
	xorl	%edx, %edx
	.p2align 5
	.p2align 4
	.p2align 3
.L689:
	movzbl	4(%rcx,%rdx), %esi
	movzbl	4(%rcx,%rax), %edi
	movb	%dil, 4(%rcx,%rdx)
	addq	$1, %rdx
	movb	%sil, 4(%rcx,%rax)
	subq	$1, %rax
	cmpl	%eax, %edx
	jl	.L689
.L686:
	ret
.L694:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
	.cfi_endproc
.LFE298:
	.size	math_prime_util__sieve__byte_vectors__reverse_elementsXn, .-math_prime_util__sieve__byte_vectors__reverse_elementsXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__Oeq__2Xn
	.type	math_prime_util__sieve__byte_vectors__Oeq__2Xn, @function
math_prime_util__sieve__byte_vectors__Oeq__2Xn:
.LFB221:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	16(%rsi), %eax
	jne	.L700
	cmpl	$2147483647, %eax
	je	.L707
	testl	%eax, %eax
	jns	.L699
.L702:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L699:
	movq	8(%rsi), %rdx
	movq	8(%rdi), %rcx
	leal	1(%rax), %esi
	xorl	%eax, %eax
	jmp	.L701
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L708:
	addq	$1, %rax
	cmpq	%rax, %rsi
	je	.L702
.L701:
	movzbl	4(%rdx,%rax), %edi
	cmpb	%dil, 4(%rcx,%rax)
	je	.L708
.L700:
	xorl	%eax, %eax
	ret
.L707:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
	.cfi_endproc
.LFE221:
	.size	math_prime_util__sieve__byte_vectors__Oeq__2Xn, .-math_prime_util__sieve__byte_vectors__Oeq__2Xn
	.section	.text.unlikely
	.align 2
.LCOLDB25:
	.text
.LHOTB25:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert__4Xn
	.type	math_prime_util__sieve__byte_vectors__insert__4Xn, @function
math_prime_util__sieve__byte_vectors__insert__4Xn:
.LFB254:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA254
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movl	%edx, %r8d
	movl	16(%rdi), %edx
	cmpl	$2147483647, %edx
	je	.L764
	movl	%ecx, %r9d
	testl	%ecx, %ecx
	je	.L709
	leal	1(%rdx), %ecx
	xorl	%eax, %eax
	movq	%rbx, 32(%rsp)
	addl	%r9d, %ecx
	movq	%r12, 48(%rsp)
	seto	%al
	.cfi_offset 3, -48
	.cfi_offset 12, -32
	jo	.L765
	cmpl	$-2147483648, %ecx
	je	.L766
	movq	%rdi, %r12
	movq	8(%rdi), %rdi
	leal	-1(%rcx), %ebx
	testq	%rdi, %rdi
	je	.L767
	movq	%r13, 56(%rsp)
	.cfi_offset 13, -24
	movl	%esi, %r13d
	movl	(%rdi), %esi
	testl	%esi, %esi
	js	.L717
	cmpl	$2147483647, %esi
	je	.L718
	leal	1(%rsi), %eax
.L717:
	cmpl	%eax, %ecx
	jle	.L768
	testl	%eax, %eax
	movl	$1, %edx
	movq	%rbp, 40(%rsp)
	cmovle	%edx, %eax
	movq	%r14, 64(%rsp)
	cmpl	%eax, %ecx
	.cfi_offset 6, -40
	.cfi_offset 14, -16
	jg	.L731
	jmp	.L728
	.p2align 4,,10
	.p2align 3
.L770:
	cmpl	$-1073741824, %eax
	js	.L769
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L728
.L731:
	cmpl	$1073741823, %eax
	jle	.L770
	movl	$2147483652, %edi
	movl	$2147483646, %edx
.L729:
	movl	%r9d, 28(%rsp)
	movb	%r8b, 24(%rsp)
	movl	%ecx, 16(%rsp)
	movl	%edx, 8(%rsp)
.LEHB10:
	call	__gnat_malloc@PLT
	movl	8(%rsp), %edx
	movq	%rax, %rbp
	movl	%edx, (%rax)
	xorl	%edx, %edx
	movq	8(%r12), %rax
	testl	%r13d, %r13d
	cmovns	%r13d, %edx
	leaq	4(%rbp), %rdi
	leaq	4(%rax), %rsi
	movq	%rax, %r14
	call	memmove@PLT
	cmpl	%r13d, 16(%r12)
	movl	16(%rsp), %ecx
	movzbl	24(%rsp), %r8d
	movl	28(%rsp), %r9d
	jge	.L732
	movslq	%r13d, %rax
	movl	$1, %edx
	movl	%ebx, %ecx
	movzbl	%r8b, %esi
	subq	%rax, %rdx
	leaq	4(%rbp,%rax), %rdi
	addq	%rcx, %rdx
	xorl	%ecx, %ecx
	cmpl	%r13d, %ebx
	cmovl	%rcx, %rdx
	call	memset@PLT
.L734:
	movq	8(%r12), %rdi
	movq	56(%rsp), %r13
	.cfi_restore 13
	movq	%rbp, 8(%r12)
	movq	64(%rsp), %r14
	.cfi_restore 14
	movq	40(%rsp), %rbp
	.cfi_restore 6
	movl	%ebx, 16(%r12)
	movq	32(%rsp), %rbx
	.cfi_restore 3
	movq	48(%rsp), %r12
	.cfi_restore 12
	testq	%rdi, %rdi
	je	.L709
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L768:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -48
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	cmpl	%r13d, %edx
	jl	.L771
	addl	%r13d, %r9d
	movq	%rbp, 40(%rsp)
	.cfi_offset 6, -40
	movl	%r9d, %ebp
	jo	.L724
	movslq	%r13d, %r11
	leaq	4(%rdi,%r11), %r10
	cmpl	%r9d, %ebx
	jl	.L726
	movslq	%r9d, %rax
	movslq	%ecx, %rdx
	movq	%r10, %rsi
	movb	%r8b, 24(%rsp)
	subq	%rax, %rdx
	leaq	4(%rdi,%rax), %rdi
	movq	%r11, 16(%rsp)
	movq	%r10, 8(%rsp)
	call	memmove@PLT
	cmpl	$-2147483648, %ebp
	movq	8(%rsp), %r10
	movq	16(%rsp), %r11
	movzbl	24(%rsp), %r8d
	je	.L772
.L726:
	leal	-1(%rbp), %eax
	movslq	%ebp, %rdx
	movzbl	%r8b, %esi
	movq	%r10, %rdi
	subq	%r11, %rdx
	cmpl	%eax, %r13d
	movl	$0, %eax
	cmovg	%rax, %rdx
	call	memset@PLT
	movq	40(%rsp), %rbp
	.cfi_restore 6
.L722:
	movl	%ebx, 16(%r12)
	movq	56(%rsp), %r13
	.cfi_restore 13
	movq	32(%rsp), %rbx
	.cfi_restore 3
	movq	48(%rsp), %r12
	.cfi_restore 12
.L709:
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L771:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -48
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	movslq	%r13d, %rcx
	movl	$1, %eax
	movslq	%ebx, %rsi
	xorl	%edx, %edx
	subq	%rcx, %rax
	leaq	4(%rdi,%rcx), %rdi
	addq	%rsi, %rax
	cmpl	%r13d, %ebx
	movzbl	%r8b, %esi
	cmovge	%rax, %rdx
	call	memset@PLT
	jmp	.L722
	.p2align 4,,10
	.p2align 3
.L728:
	.cfi_offset 6, -40
	.cfi_offset 14, -16
	leal	-1(%rax), %edi
	movq	%rdi, %rdx
	addq	$8, %rdi
	andq	$-4, %rdi
	jmp	.L729
	.p2align 4,,10
	.p2align 3
.L732:
	addl	%r13d, %r9d
	jo	.L736
	cmpl	$-2147483648, %r9d
	je	.L773
	movslq	%r13d, %r10
	leal	-1(%r9), %esi
	movl	$1, %eax
	xorl	%edx, %edx
	subq	%r10, %rax
	movslq	%esi, %rdi
	movl	%ecx, 24(%rsp)
	addq	%rdi, %rax
	cmpl	%esi, %r13d
	leaq	4(%rbp,%r10), %rdi
	movzbl	%r8b, %esi
	cmovle	%rax, %rdx
	movq	%r10, 8(%rsp)
	movl	%r9d, 16(%rsp)
	call	memset@PLT
	movslq	16(%rsp), %rax
	movl	24(%rsp), %ecx
	xorl	%edx, %edx
	movq	8(%rsp), %r10
	subq	%rax, %rcx
	cmpl	%eax, %ebx
	leaq	4(%rbp,%rax), %rdi
	cmovge	%rcx, %rdx
	leaq	4(%r14,%r10), %rsi
	call	memmove@PLT
	jmp	.L734
	.p2align 4,,10
	.p2align 3
.L767:
	.cfi_restore 6
	.cfi_restore 13
	.cfi_restore 14
	movslq	%ebx, %rdi
	movq	%rbp, 40(%rsp)
	addq	$8, %rdi
	movb	%r8b, 16(%rsp)
	andq	$-4, %rdi
	movl	%ecx, 8(%rsp)
	.cfi_offset 6, -40
	call	__gnat_malloc@PLT
	movslq	8(%rsp), %rdx
	movzbl	16(%rsp), %esi
	movl	%ebx, (%rax)
	movq	%rax, %rbp
	leaq	4(%rax), %rdi
	call	memset@PLT
	movq	%rbp, 8(%r12)
	movq	40(%rsp), %rbp
	.cfi_restore 6
	movl	%ebx, 16(%r12)
	movq	32(%rsp), %rbx
	.cfi_restore 3
	movq	48(%rsp), %r12
	.cfi_restore 12
	jmp	.L709
.L769:
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	movl	$1235, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L765:
	.cfi_restore 6
	.cfi_restore 13
	.cfi_restore 14
	movl	$1037, %esi
	leaq	.LC14(%rip), %rdi
	movq	%rbp, 40(%rsp)
	movq	%r13, 56(%rsp)
	movq	%r14, 64(%rsp)
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L764:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	movq	%rbx, 32(%rsp)
	movq	%rbp, 40(%rsp)
	movq	%r12, 48(%rsp)
	movq	%r13, 56(%rsp)
	movq	%r14, 64(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
.L766:
	.cfi_restore 6
	.cfi_restore 13
	.cfi_restore 14
	movl	$1149, %esi
	leaq	.LC14(%rip), %rdi
	movq	%rbp, 40(%rsp)
	movq	%r13, 56(%rsp)
	movq	%r14, 64(%rsp)
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L718:
	.cfi_restore 6
	.cfi_restore 14
	movl	$1182, %esi
	leaq	.LC14(%rip), %rdi
	movq	%rbp, 40(%rsp)
	movq	%r14, 64(%rsp)
	.cfi_offset 6, -40
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE10:
.L773:
	movl	$1291, %esi
	leaq	.LC14(%rip), %rdi
.LEHB11:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L736:
	movl	$1286, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE11:
.L772:
	.cfi_restore 14
	movl	$1212, %esi
	leaq	.LC14(%rip), %rdi
	movq	%r14, 64(%rsp)
.LEHB12:
	.cfi_remember_state
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L724:
	.cfi_restore_state
	movl	$1206, %esi
	leaq	.LC14(%rip), %rdi
	movq	%r14, 64(%rsp)
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE12:
.L750:
	movq	%rax, %rbx
	jmp	.L741
	.section	.gcc_except_table
	.align 4
.LLSDA254:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT254-.LLSDATTD254
.LLSDATTD254:
	.byte	0x1
	.uleb128 .LLSDACSE254-.LLSDACSB254
.LLSDACSB254:
	.uleb128 .LEHB10-.LFB254
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB11-.LFB254
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L750-.LFB254
	.uleb128 0x1
	.uleb128 .LEHB12-.LFB254
	.uleb128 .LEHE12-.LEHB12
	.uleb128 0
	.uleb128 0
.LLSDACSE254:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT254:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC254
	.type	math_prime_util__sieve__byte_vectors__insert__4Xn.cold, @function
math_prime_util__sieve__byte_vectors__insert__4Xn.cold:
.LFSB254:
.L741:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L763
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rdi
	movq	%rax, %r12
.LEHB13:
	call	__gnat_free@PLT
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE13:
.L751:
	movq	%rax, %rbp
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r12, %rsi
.LEHB14:
	call	__gnat_end_handler_v1@PLT
	movq	%rbp, %rdi
.L763:
	call	_Unwind_Resume@PLT
.LEHE14:
	.cfi_endproc
.LFE254:
	.section	.gcc_except_table
	.align 4
.LLSDAC254:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC254-.LLSDATTDC254
.LLSDATTDC254:
	.byte	0x1
	.uleb128 .LLSDACSEC254-.LLSDACSBC254
.LLSDACSBC254:
	.uleb128 .LEHB13-.LCOLDB25
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L751-.LCOLDB25
	.uleb128 0
	.uleb128 .LEHB14-.LCOLDB25
	.uleb128 .LEHE14-.LEHB14
	.uleb128 0
	.uleb128 0
.LLSDACSEC254:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC254:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__byte_vectors__insert__4Xn, .-math_prime_util__sieve__byte_vectors__insert__4Xn
	.section	.text.unlikely
	.size	math_prime_util__sieve__byte_vectors__insert__4Xn.cold, .-math_prime_util__sieve__byte_vectors__insert__4Xn.cold
.LCOLDE25:
	.text
.LHOTE25:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert__6Xn
	.type	math_prime_util__sieve__byte_vectors__insert__6Xn, @function
math_prime_util__sieve__byte_vectors__insert__6Xn:
.LFB259:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	%ecx, %eax
	movl	48(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L775
	testq	%rsi, %rsi
	je	.L781
	cmpl	%edx, 16(%rdi)
	jge	.L783
.L781:
	xorl	%edi, %edi
	jmp	.L776
	.p2align 4,,10
	.p2align 3
.L775:
	movl	16(%rdi), %r11d
	testq	%rsi, %rsi
	je	.L777
	movl	%edx, %esi
	cmpl	%r11d, %edx
	jg	.L778
.L779:
	movzbl	%al, %edx
	movq	%r9, 24(%rsp)
	movq	%rdi, (%rsp)
	movq	%r8, 16(%rsp)
	movl	%esi, 12(%rsp)
	call	math_prime_util__sieve__byte_vectors__insert__4Xn
	movl	12(%rsp), %ecx
	movq	(%rsp), %rdi
	movq	24(%rsp), %r9
.L776:
	movl	%r9d, %eax
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movq	%rax, %rdx
	movq	%rdi, %rax
	movabsq	$-4294967296, %rdi
	movq	%rdx, %rsi
	andq	%rdi, %rsi
	orq	%rsi, %rcx
	movq	%rcx, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L777:
	.cfi_restore_state
	cmpl	$2147483647, %r11d
	je	.L784
.L778:
	leal	1(%r11), %esi
	jmp	.L779
	.p2align 4,,10
	.p2align 3
.L783:
	movl	%edx, %ecx
	jmp	.L776
.L784:
	movl	$1585, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE259:
	.size	math_prime_util__sieve__byte_vectors__insert__6Xn, .-math_prime_util__sieve__byte_vectors__insert__6Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert__7Xn
	.type	math_prime_util__sieve__byte_vectors__insert__7Xn, @function
math_prime_util__sieve__byte_vectors__insert__7Xn:
.LFB260:
	.cfi_startproc
	movl	%edx, %ecx
	xorl	%edx, %edx
	jmp	math_prime_util__sieve__byte_vectors__insert__4Xn
	.cfi_endproc
.LFE260:
	.size	math_prime_util__sieve__byte_vectors__insert__7Xn, .-math_prime_util__sieve__byte_vectors__insert__7Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__prepend__2Xn
	.type	math_prime_util__sieve__byte_vectors__prepend__2Xn, @function
math_prime_util__sieve__byte_vectors__prepend__2Xn:
.LFB279:
	.cfi_startproc
	movl	%edx, %ecx
	movzbl	%sil, %edx
	xorl	%esi, %esi
	jmp	math_prime_util__sieve__byte_vectors__insert__4Xn
	.cfi_endproc
.LFE279:
	.size	math_prime_util__sieve__byte_vectors__prepend__2Xn, .-math_prime_util__sieve__byte_vectors__prepend__2Xn
	.section	.text.unlikely
	.align 2
.LCOLDB26:
	.text
.LHOTB26:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert_spaceXn
	.type	math_prime_util__sieve__byte_vectors__insert_spaceXn, @function
math_prime_util__sieve__byte_vectors__insert_spaceXn:
.LFB262:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA262
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movl	%edx, %r8d
	movl	16(%rdi), %edx
	cmpl	$2147483647, %edx
	je	.L825
	testl	%r8d, %r8d
	je	.L787
	leal	1(%rdx), %ecx
	addl	%r8d, %ecx
	jo	.L791
	movq	%rbp, 24(%rsp)
	movq	%r12, 32(%rsp)
	movq	%r13, 40(%rsp)
	cmpl	$-2147483648, %ecx
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	je	.L826
	movslq	%esi, %rbp
	movq	8(%rdi), %rsi
	movq	%rdi, %r12
	leal	-1(%rcx), %r13d
	testq	%rsi, %rsi
	je	.L827
	movl	(%rsi), %eax
	cmpl	%r13d, %eax
	jge	.L828
	xorl	%edx, %edx
	testl	%eax, %eax
	movq	%rbx, 16(%rsp)
	cmovns	%eax, %edx
	movq	%r14, 48(%rsp)
	leal	1(%rdx), %eax
	cmpl	%ecx, %eax
	.cfi_offset 3, -48
	.cfi_offset 14, -16
	jl	.L804
	jmp	.L801
	.p2align 4,,10
	.p2align 3
.L831:
	cmpl	$-1073741824, %eax
	js	.L829
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L830
.L804:
	cmpl	$1073741823, %eax
	jle	.L831
	movl	$2147483652, %edi
	movl	$2147483646, %edx
.L802:
	movl	%edx, 4(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%ecx, 8(%rsp)
.LEHB15:
	call	__gnat_malloc@PLT
	movl	4(%rsp), %edx
	movq	8(%r12), %r14
	leaq	4(%rax), %rdi
	movq	%rax, %rbx
	movl	%edx, (%rax)
	xorl	%edx, %edx
	testl	%ebp, %ebp
	leaq	4(%r14), %rsi
	cmovns	%ebp, %edx
	call	memmove@PLT
	cmpl	%ebp, 16(%r12)
	jl	.L805
	movl	12(%rsp), %eax
	addl	%ebp, %eax
	jo	.L807
	movslq	8(%rsp), %rcx
	movslq	%eax, %rsi
	leaq	4(%rbx,%rsi), %rdi
	subq	%rsi, %rcx
	cmpl	%eax, %r13d
	leaq	4(%r14,%rbp), %rsi
	movl	$0, %eax
	cmovge	%rcx, %rax
	movq	%rax, %rdx
	call	memmove@PLT
.L805:
	movq	%rbx, 8(%r12)
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	%r14, %rdi
	movq	16(%rsp), %rbx
	.cfi_restore 3
	movq	48(%rsp), %r14
	.cfi_restore 14
	movl	%r13d, 16(%r12)
	movq	32(%rsp), %r12
	.cfi_restore 12
	movq	40(%rsp), %r13
	.cfi_restore 13
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L828:
	.cfi_def_cfa_offset 64
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	cmpl	%ebp, %edx
	jl	.L796
	movl	%r8d, %eax
	addl	%ebp, %eax
	jo	.L798
	movslq	%eax, %rdi
	movslq	%ecx, %rcx
	subq	%rdi, %rcx
	cmpl	%eax, %r13d
	leaq	4(%rsi,%rdi), %rdi
	movl	$0, %eax
	cmovge	%rcx, %rax
	leaq	4(%rsi,%rbp), %rsi
	movq	%rax, %rdx
	call	memmove@PLT
.L796:
	movl	%r13d, 16(%r12)
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	32(%rsp), %r12
	.cfi_restore 12
	movq	40(%rsp), %r13
	.cfi_restore 13
.L787:
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L830:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	leal	-1(%rax), %edi
	movq	%rdi, %rdx
	addq	$8, %rdi
	andq	$-4, %rdi
	jmp	.L802
	.p2align 4,,10
	.p2align 3
.L827:
	.cfi_restore 3
	.cfi_restore 14
	movslq	%r13d, %rdi
	addq	$8, %rdi
	andq	$-4, %rdi
	call	__gnat_malloc@PLT
	movl	%r13d, 16(%r12)
	movl	%r13d, (%rax)
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	%rax, 8(%r12)
	movq	40(%rsp), %r13
	.cfi_restore 13
	movq	32(%rsp), %r12
	.cfi_restore 12
	jmp	.L787
.L801:
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	movl	%edx, %edi
	addq	$8, %rdi
	andq	$-4, %rdi
	jmp	.L802
.L829:
	movl	$1891, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L826:
	.cfi_restore 3
	.cfi_restore 14
	movl	$1811, %esi
	leaq	.LC14(%rip), %rdi
	movq	%rbx, 16(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L791:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	movl	$1700, %esi
	leaq	.LC14(%rip), %rdi
	movq	%rbx, 16(%rsp)
	movq	%rbp, 24(%rsp)
	movq	%r12, 32(%rsp)
	movq	%r13, 40(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_remember_state
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L825:
	.cfi_restore_state
	movq	%rbx, 16(%rsp)
	movq	%rbp, 24(%rsp)
	movq	%r12, 32(%rsp)
	movq	%r13, 40(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
.LEHE15:
.L807:
	movl	$1939, %esi
	leaq	.LC14(%rip), %rdi
.LEHB16:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE16:
.L798:
	.cfi_restore 3
	.cfi_restore 14
	movl	$1861, %esi
	leaq	.LC14(%rip), %rdi
	movq	%rbx, 16(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 14, -16
.LEHB17:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE17:
.L816:
	movq	%rax, %rbp
	jmp	.L810
	.section	.gcc_except_table
	.align 4
.LLSDA262:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT262-.LLSDATTD262
.LLSDATTD262:
	.byte	0x1
	.uleb128 .LLSDACSE262-.LLSDACSB262
.LLSDACSB262:
	.uleb128 .LEHB15-.LFB262
	.uleb128 .LEHE15-.LEHB15
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB16-.LFB262
	.uleb128 .LEHE16-.LEHB16
	.uleb128 .L816-.LFB262
	.uleb128 0x1
	.uleb128 .LEHB17-.LFB262
	.uleb128 .LEHE17-.LEHB17
	.uleb128 0
	.uleb128 0
.LLSDACSE262:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT262:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC262
	.type	math_prime_util__sieve__byte_vectors__insert_spaceXn.cold, @function
math_prime_util__sieve__byte_vectors__insert_spaceXn.cold:
.LFSB262:
.L810:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L824
	call	__gnat_begin_handler_v1@PLT
	movq	%rbx, %rdi
	movq	%rax, %r12
.LEHB18:
	call	__gnat_free@PLT
	movq	%rbp, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE18:
.L817:
	movq	%rax, %rbx
	movq	%rbp, %rdi
	movq	%rax, %rdx
	movq	%r12, %rsi
.LEHB19:
	call	__gnat_end_handler_v1@PLT
	movq	%rbx, %rdi
.L824:
	call	_Unwind_Resume@PLT
.LEHE19:
	.cfi_endproc
.LFE262:
	.section	.gcc_except_table
	.align 4
.LLSDAC262:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC262-.LLSDATTDC262
.LLSDATTDC262:
	.byte	0x1
	.uleb128 .LLSDACSEC262-.LLSDACSBC262
.LLSDACSBC262:
	.uleb128 .LEHB18-.LCOLDB26
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L817-.LCOLDB26
	.uleb128 0
	.uleb128 .LEHB19-.LCOLDB26
	.uleb128 .LEHE19-.LEHB19
	.uleb128 0
	.uleb128 0
.LLSDACSEC262:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC262:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__byte_vectors__insert_spaceXn, .-math_prime_util__sieve__byte_vectors__insert_spaceXn
	.section	.text.unlikely
	.size	math_prime_util__sieve__byte_vectors__insert_spaceXn.cold, .-math_prime_util__sieve__byte_vectors__insert_spaceXn.cold
.LCOLDE26:
	.text
.LHOTE26:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert_space__2Xn
	.type	math_prime_util__sieve__byte_vectors__insert_space__2Xn, @function
math_prime_util__sieve__byte_vectors__insert_space__2Xn:
.LFB263:
	.cfi_startproc
	movq	%rdi, %rax
	movq	%rsi, %rdi
	movq	%rdx, %rsi
	movl	%r9d, %edx
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	testl	%edx, %edx
	jne	.L833
	testq	%rdi, %rdi
	je	.L839
	cmpl	%esi, 16(%rax)
	jge	.L841
.L839:
	xorl	%eax, %eax
	jmp	.L834
	.p2align 4,,10
	.p2align 3
.L833:
	movl	16(%rax), %r9d
	movq	%rcx, %r10
	movq	%r8, %r11
	testq	%rdi, %rdi
	je	.L835
	movl	%esi, %ecx
	cmpl	%r9d, %esi
	jg	.L836
.L837:
	movq	%rax, %rdi
	movl	%ecx, %esi
	movq	%r8, 40(%rsp)
	movq	%rax, 8(%rsp)
	movq	%r10, 16(%rsp)
	movq	%r11, 24(%rsp)
	movl	%ecx, 36(%rsp)
	call	math_prime_util__sieve__byte_vectors__insert_spaceXn
	movl	36(%rsp), %edx
	movq	8(%rsp), %rax
	movq	40(%rsp), %r8
.L834:
	movl	%r8d, %r8d
	movq	%rax, %r10
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movabsq	$-4294967296, %rcx
	movq	%r8, %rax
	andq	%rcx, %rax
	orq	%rdx, %rax
	movq	%rax, %r11
	movq	%r10, %rax
	movq	%r11, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L835:
	.cfi_restore_state
	cmpl	$2147483647, %r9d
	je	.L842
.L836:
	leal	1(%r9), %ecx
	jmp	.L837
	.p2align 4,,10
	.p2align 3
.L841:
	movl	%esi, %edx
	jmp	.L834
.L842:
	movl	$2006, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE263:
	.size	math_prime_util__sieve__byte_vectors__insert_space__2Xn, .-math_prime_util__sieve__byte_vectors__insert_space__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert_vectorXn
	.type	math_prime_util__sieve__byte_vectors__insert_vectorXn, @function
math_prime_util__sieve__byte_vectors__insert_vectorXn:
.LFB255:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	movl	16(%rdx), %ebx
	cmpl	$2147483647, %ebx
	je	.L871
	addl	$1, %ebx
	movq	%rdx, %r13
	movq	%rdi, %r12
	movl	%esi, %ebp
	movl	%ebx, %edx
	call	math_prime_util__sieve__byte_vectors__insert_spaceXn
	testl	%ebx, %ebx
	je	.L843
	leal	-1(%rbp), %eax
	xorl	%edx, %edx
	movl	%eax, %ecx
	addl	%ebx, %ecx
	seto	%dl
	jo	.L872
	movq	8(%r12), %rdi
	cmpq	%r13, %r12
	jne	.L873
	testl	%eax, %eax
	cmovns	%ebp, %edx
	xorl	%r8d, %r8d
	addl	%edx, %eax
	movl	%edx, %r13d
	seto	%r8b
	jo	.L874
	movslq	%ebp, %r9
	movl	$1, %edx
	movslq	%eax, %r10
	xorl	%esi, %esi
	subq	%r9, %rdx
	movl	%ecx, 12(%rsp)
	addq	%r10, %rdx
	cmpl	%eax, %ebp
	movl	%r8d, 8(%rsp)
	cmovg	%rsi, %rdx
	leaq	4(%rdi), %rsi
	leaq	4(%rdi,%r9), %rdi
	call	memmove@PLT
	cmpl	%ebx, %r13d
	je	.L843
	movl	12(%rsp), %ecx
	movl	8(%rsp), %r8d
	cmpl	$2147483647, %ecx
	je	.L875
	movl	16(%r12), %esi
	leal	1(%rcx), %eax
	cmpl	%esi, %eax
	jg	.L857
	movslq	%eax, %rdi
	movslq	%esi, %rdx
	subq	%rdi, %rdx
	movl	$2147483649, %edi
	addq	%rdi, %rdx
	shrq	$32, %rdx
	jne	.L861
	addl	$1, %esi
	subl	%eax, %esi
	movl	%esi, %r8d
.L857:
	movl	%eax, %r9d
	subl	%r8d, %r9d
	jo	.L861
	cltq
	movq	8(%r12), %rdi
	movslq	%r9d, %rsi
	movq	%rax, %rdx
	subq	%rsi, %rdx
	cmpl	%r9d, %ecx
	leaq	4(%rdi,%rax), %rax
	movl	$0, %ecx
	cmovl	%rcx, %rdx
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	4(%rdi,%rsi), %rdi
	movq	%rax, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	memmove@PLT
	.p2align 4,,10
	.p2align 3
.L873:
	.cfi_restore_state
	movslq	%ebp, %r8
	movl	$1, %eax
	movslq	%ecx, %r9
	movq	8(%r13), %rsi
	subq	%r8, %rax
	xorl	%edx, %edx
	leaq	4(%rdi,%r8), %rdi
	addq	%r9, %rax
	cmpl	%ecx, %ebp
	cmovle	%rax, %rdx
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	addq	$4, %rsi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	memmove@PLT
	.p2align 4,,10
	.p2align 3
.L843:
	.cfi_restore_state
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L871:
	.cfi_restore_state
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
.L872:
	movl	$1349, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L861:
	movl	$1435, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L875:
	movl	$1418, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L874:
	movl	$1392, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE255:
	.size	math_prime_util__sieve__byte_vectors__insert_vectorXn, .-math_prime_util__sieve__byte_vectors__insert_vectorXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert_vector__3Xn
	.type	math_prime_util__sieve__byte_vectors__insert_vector__3Xn, @function
math_prime_util__sieve__byte_vectors__insert_vector__3Xn:
.LFB257:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%edx, %ebx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movl	16(%rcx), %eax
	testl	%eax, %eax
	js	.L885
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L879
	cmpl	%eax, %edx
	jle	.L881
.L880:
	leal	1(%rax), %ebx
.L881:
	movq	%rcx, %rdx
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r9, 8(%rsp)
	movq	%r8, (%rsp)
	call	math_prime_util__sieve__byte_vectors__insert_vectorXn
	movq	8(%rsp), %r9
.L878:
	movl	%r9d, %eax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movabsq	$-4294967296, %rsi
	movq	%rax, %rdx
	movq	%rbp, %rax
	movq	%rdx, %rcx
	andq	%rsi, %rcx
	orq	%rbx, %rcx
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	movq	%rcx, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L885:
	.cfi_restore_state
	testq	%rsi, %rsi
	je	.L882
	xorl	%eax, %eax
	cmpl	16(%rdi), %edx
	cmovg	%rax, %rbx
	movl	$0, %eax
	cmovg	%rax, %rbp
	jmp	.L878
	.p2align 4,,10
	.p2align 3
.L879:
	cmpl	$2147483647, %eax
	jne	.L880
	movl	$1508, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L882:
	xorl	%ebx, %ebx
	xorl	%ebp, %ebp
	jmp	.L878
	.cfi_endproc
.LFE257:
	.size	math_prime_util__sieve__byte_vectors__insert_vector__3Xn, .-math_prime_util__sieve__byte_vectors__insert_vector__3Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__prepend_vectorXn
	.type	math_prime_util__sieve__byte_vectors__prepend_vectorXn, @function
math_prime_util__sieve__byte_vectors__prepend_vectorXn:
.LFB280:
	.cfi_startproc
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__sieve__byte_vectors__insert_vectorXn
	.cfi_endproc
.LFE280:
	.size	math_prime_util__sieve__byte_vectors__prepend_vectorXn, .-math_prime_util__sieve__byte_vectors__prepend_vectorXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__reserve_capacityXn
	.type	math_prime_util__sieve__byte_vectors__reserve_capacityXn, @function
math_prime_util__sieve__byte_vectors__reserve_capacityXn:
.LFB297:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	16(%rdi), %r8d
	cmpl	$2147483647, %r8d
	je	.L908
	movq	8(%rdi), %r9
	movq	%rdi, %rcx
	leal	1(%r8), %eax
	testl	%esi, %esi
	jne	.L889
	testl	%eax, %eax
	je	.L909
	movl	(%r9), %edx
	testl	%edx, %edx
	js	.L892
	cmpl	$2147483647, %edx
	je	.L893
	leal	1(%rdx), %esi
.L892:
	cmpl	%esi, %eax
	jl	.L907
.L887:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L889:
	.cfi_restore_state
	leal	-1(%rsi), %r10d
	testq	%r9, %r9
	je	.L910
	movl	(%r9), %edx
	cmpl	%eax, %esi
	jg	.L895
	testl	%edx, %edx
	js	.L901
	cmpl	$2147483647, %edx
	je	.L897
	addl	$1, %edx
.L896:
	cmpl	%eax, %edx
	jle	.L887
.L907:
	movslq	%r8d, %rdx
	movq	%rcx, 24(%rsp)
	leaq	8(%rdx), %rdi
	movq	%r9, 16(%rsp)
	andq	$-4, %rdi
	movl	%r8d, 8(%rsp)
	movq	%rdx, (%rsp)
	call	__gnat_malloc@PLT
	movl	8(%rsp), %r8d
	leaq	4(%rax), %rdi
	movl	%r8d, (%rax)
	movq	(%rsp), %rdx
	movq	16(%rsp), %r9
	movq	%rax, 8(%rsp)
	addq	$1, %rdx
	leaq	4(%r9), %rsi
	movq	%r9, (%rsp)
	call	memcpy@PLT
	movq	8(%rsp), %r10
	movq	24(%rsp), %rcx
	movq	(%rsp), %rdi
	movq	%r10, 8(%rcx)
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L895:
	.cfi_restore_state
	testl	%edx, %edx
	js	.L898
	cmpl	$2147483647, %edx
	je	.L911
	addl	$1, %edx
	cmpl	%edx, %esi
	je	.L887
.L898:
	movslq	%r10d, %rdi
	movq	%rcx, 8(%rsp)
	addq	$8, %rdi
	movl	%r10d, (%rsp)
	andq	$-4, %rdi
	call	__gnat_malloc@PLT
	movq	8(%rsp), %rcx
	movl	(%rsp), %r10d
	movq	%rax, %r8
	movl	16(%rcx), %edx
	movq	8(%rcx), %r9
	movl	%r10d, (%rax)
	leaq	4(%r8), %rdi
	movq	%rcx, 16(%rsp)
	movq	%rdx, %rax
	addq	$1, %rdx
	leaq	4(%r9), %rsi
	movq	%r8, (%rsp)
	testl	%eax, %eax
	movl	$0, %eax
	movq	%r9, 8(%rsp)
	cmovs	%rax, %rdx
	call	memmove@PLT
	movq	(%rsp), %r8
	movq	16(%rsp), %rcx
	movq	8(%rsp), %rdi
	movq	%r8, 8(%rcx)
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L901:
	.cfi_restore_state
	xorl	%edx, %edx
	jmp	.L896
	.p2align 4,,10
	.p2align 3
.L909:
	movq	$0, 8(%rdi)
	testq	%r9, %r9
	je	.L887
	movq	%r9, %rdi
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L910:
	.cfi_restore_state
	movq	%rdi, 8(%rsp)
	movslq	%r10d, %rdi
	addq	$8, %rdi
	movl	%r10d, (%rsp)
	andq	$-4, %rdi
	call	__gnat_malloc@PLT
	movl	(%rsp), %r10d
	movq	8(%rsp), %rcx
	movl	%r10d, (%rax)
	movq	%rax, 8(%rcx)
	jmp	.L887
.L908:
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
.L893:
	movl	$2605, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L911:
	movl	$2795, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L897:
	movl	$2745, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE297:
	.size	math_prime_util__sieve__byte_vectors__reserve_capacityXn, .-math_prime_util__sieve__byte_vectors__reserve_capacityXn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__native_prime, @function
math_prime_util__sieve__native_prime:
.LFB420:
	.cfi_startproc
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	movb	$0, 15(%rsp)
	cmpq	$1, %rdi
	jbe	.L912
	movq	%rbx, 56(%rsp)
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	testb	$1, %dil
	je	.L925
	movabsq	$-6148914691236517205, %rax
	movabsq	$6148914691236517205, %rdx
	imulq	%rdi, %rax
	cmpq	%rax, %rdx
	jnb	.L926
	movabsq	$-3689348814741910323, %rax
	movq	%r13, 80(%rsp)
	.cfi_offset 13, -32
	leaq	-1(%rdi), %r13
	movabsq	$3689348814741910323, %rdx
	imulq	%rdi, %rax
	movq	%r12, 72(%rsp)
	.cfi_offset 12, -40
	movq	%r13, %r12
	cmpq	%rax, %rdx
	jnb	.L940
	movq	%rbp, 64(%rsp)
	movq	%r14, 88(%rsp)
	movq	%r15, 96(%rsp)
	.cfi_offset 6, -48
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	.p2align 4
	.p2align 4
	.p2align 3
.L916:
	shrq	%r12
	testb	$1, %r12b
	je	.L916
	movq	%r13, %r14
	leaq	bases.54(%rip), %rbp
	shrq	%r14
	rep bsfq	%r14, %r14
	jmp	.L923
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L917:
	addq	$8, %rbp
	leaq	56+bases.54(%rip), %rax
	cmpq	%rbp, %rax
	je	.L941
.L923:
	movq	0(%rbp), %rax
	xorl	%edx, %edx
	divq	%rbx
	movq	%rdx, %rsi
	cmpq	$1, %rdx
	seta	%dl
	cmpq	%r13, %rsi
	setb	%al
	testb	%al, %dl
	je	.L917
	movq	%rbx, %rcx
	movq	%r12, %rdx
	leaq	16(%rsp), %rdi
	call	math_prime_util__int__powmod@PLT
	movq	24(%rsp), %rsi
	cmpq	$1, %rsi
	sete	%r15b
	cmpq	%rsi, %r13
	sete	%al
	orb	%al, %r15b
	movb	%r15b, 15(%rsp)
	jne	.L917
	testl	%r14d, %r14d
	je	.L939
	xorl	%edx, %edx
	xorl	%r15d, %r15d
	.p2align 4
	.p2align 3
.L919:
	testb	%dl, %dl
	jne	.L917
	movq	%rsi, %rdx
	movq	%rbx, %rcx
	leaq	32(%rsp), %rdi
	addl	$1, %r15d
	call	math_prime_util__int__mulmod@PLT
	movq	40(%rsp), %rsi
	cmpq	%rsi, %r13
	sete	%dl
	cmpl	%r14d, %r15d
	jne	.L919
	cmpq	%rsi, %r13
	jne	.L939
	addq	$8, %rbp
	leaq	56+bases.54(%rip), %rax
	cmpq	%rbp, %rax
	jne	.L923
	.p2align 4
	.p2align 3
.L941:
	movb	$1, 15(%rsp)
.L939:
	movq	56(%rsp), %rbx
	.cfi_restore 3
	movq	64(%rsp), %rbp
	.cfi_restore 6
	movq	72(%rsp), %r12
	.cfi_restore 12
	movq	80(%rsp), %r13
	.cfi_restore 13
	movq	88(%rsp), %r14
	.cfi_restore 14
	movq	96(%rsp), %r15
	.cfi_restore 15
.L912:
	movzbl	15(%rsp), %eax
	addq	$104, %rsp
	.cfi_def_cfa_offset 8
	ret
.L925:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -56
	movl	$2, %eax
.L914:
	cmpq	%rax, %rbx
	movq	56(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	sete	15(%rsp)
	movzbl	15(%rsp), %eax
	addq	$104, %rsp
	.cfi_def_cfa_offset 8
	ret
.L926:
	.cfi_restore_state
	movl	$3, %eax
	jmp	.L914
.L940:
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	movq	72(%rsp), %r12
	.cfi_restore 12
	movq	80(%rsp), %r13
	.cfi_restore 13
	movl	$5, %eax
	jmp	.L914
	.cfi_endproc
.LFE420:
	.size	math_prime_util__sieve__native_prime, .-math_prime_util__sieve__native_prime
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__delete_first
	.type	math_prime_util__sieve__prime_vectors__delete_first, @function
math_prime_util__sieve__prime_vectors__delete_first:
.LFB39:
	.cfi_startproc
	testl	%esi, %esi
	je	.L942
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L952
	addl	$1, %eax
	cmpl	%eax, %esi
	jl	.L945
	movl	$-1, 16(%rdi)
	ret
	.p2align 4,,10
	.p2align 3
.L942:
	ret
	.p2align 4,,10
	.p2align 3
.L945:
	movl	%esi, %edx
	xorl	%esi, %esi
	jmp	math_prime_util__sieve__prime_vectors__delete
.L952:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__prime_vectors__length.part.0
	.cfi_endproc
.LFE39:
	.size	math_prime_util__sieve__prime_vectors__delete_first, .-math_prime_util__sieve__prime_vectors__delete_first
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__delete_last.part.0, @function
math_prime_util__sieve__prime_vectors__delete_last.part.0:
.LFB518:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$589, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE518:
	.size	math_prime_util__sieve__prime_vectors__delete_last.part.0, .-math_prime_util__sieve__prime_vectors__delete_last.part.0
	.set	math_prime_util__sieve__byte_vectors__delete_lastXn.part.0,math_prime_util__sieve__prime_vectors__delete_last.part.0
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__delete_last
	.type	math_prime_util__sieve__prime_vectors__delete_last, @function
math_prime_util__sieve__prime_vectors__delete_last:
.LFB40:
	.cfi_startproc
	testl	%esi, %esi
	je	.L966
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L969
	leal	1(%rax), %edx
	cmpl	%edx, %esi
	jge	.L970
	subl	%esi, %eax
	jo	.L960
	movl	%eax, 16(%rdi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L970:
	.cfi_restore_state
	movl	$-1, 16(%rdi)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L966:
	ret
.L969:
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__prime_vectors__length.part.0
.L960:
	call	math_prime_util__sieve__prime_vectors__delete_last.part.0
	.cfi_endproc
.LFE40:
	.size	math_prime_util__sieve__prime_vectors__delete_last, .-math_prime_util__sieve__prime_vectors__delete_last
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__append__3Xn
	.type	math_prime_util__sieve__byte_vectors__append__3Xn, @function
math_prime_util__sieve__byte_vectors__append__3Xn:
.LFB225:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	8(%rdi), %rcx
	movl	16(%rdi), %eax
	testq	%rcx, %rcx
	je	.L972
	cmpl	%eax, (%rcx)
	je	.L972
	cmpl	$2147483647, %eax
	je	.L981
	addl	$1, %eax
	movslq	%eax, %rdx
	movb	%sil, 4(%rcx,%rdx)
	movl	%eax, 16(%rdi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L972:
	.cfi_restore_state
	cmpl	$2147483647, %eax
	je	.L982
	movzbl	%sil, %edx
	movl	$1, %ecx
	leal	1(%rax), %esi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__sieve__byte_vectors__insert__4Xn
.L981:
	.cfi_restore_state
	movl	$223, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L982:
	movl	$229, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE225:
	.size	math_prime_util__sieve__byte_vectors__append__3Xn, .-math_prime_util__sieve__byte_vectors__append__3Xn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__append_slow_path.part.0, @function
math_prime_util__sieve__prime_vectors__append_slow_path.part.0:
.LFB520:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$248, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE520:
	.size	math_prime_util__sieve__prime_vectors__append_slow_path.part.0, .-math_prime_util__sieve__prime_vectors__append_slow_path.part.0
	.set	math_prime_util__sieve__byte_vectors__append_slow_pathXn.part.0,math_prime_util__sieve__prime_vectors__append_slow_path.part.0
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert__5Xn
	.type	math_prime_util__sieve__byte_vectors__insert__5Xn, @function
math_prime_util__sieve__byte_vectors__insert__5Xn:
.LFB258:
	.cfi_startproc
	testl	%r8d, %r8d
	je	.L985
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L987
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L989
.L988:
	leal	1(%rax), %esi
.L989:
	movzbl	%cl, %edx
	movl	%r8d, %ecx
	jmp	math_prime_util__sieve__byte_vectors__insert__4Xn
	.p2align 4,,10
	.p2align 3
.L985:
	ret
	.p2align 4,,10
	.p2align 3
.L987:
	cmpl	$2147483647, %eax
	jne	.L988
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1543, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE258:
	.size	math_prime_util__sieve__byte_vectors__insert__5Xn, .-math_prime_util__sieve__byte_vectors__insert__5Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__append_vectorXn
	.type	math_prime_util__sieve__byte_vectors__append_vectorXn, @function
math_prime_util__sieve__byte_vectors__append_vectorXn:
.LFB224:
	.cfi_startproc
	movl	16(%rsi), %edx
	testl	%edx, %edx
	js	.L993
	movq	%rsi, %rdx
	movl	16(%rdi), %esi
	cmpl	$2147483647, %esi
	je	.L999
	addl	$1, %esi
	jmp	math_prime_util__sieve__byte_vectors__insert_vectorXn
	.p2align 4,,10
	.p2align 3
.L993:
	ret
.L999:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$197, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE224:
	.size	math_prime_util__sieve__byte_vectors__append_vectorXn, .-math_prime_util__sieve__byte_vectors__append_vectorXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert_vector__2Xn
	.type	math_prime_util__sieve__byte_vectors__insert_vector__2Xn, @function
math_prime_util__sieve__byte_vectors__insert_vector__2Xn:
.LFB256:
	.cfi_startproc
	movl	16(%rcx), %r8d
	testl	%r8d, %r8d
	js	.L1000
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L1002
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L1004
.L1003:
	leal	1(%rax), %esi
.L1004:
	movq	%rcx, %rdx
	jmp	math_prime_util__sieve__byte_vectors__insert_vectorXn
	.p2align 4,,10
	.p2align 3
.L1000:
	ret
	.p2align 4,,10
	.p2align 3
.L1002:
	cmpl	$2147483647, %eax
	jne	.L1003
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1468, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE256:
	.size	math_prime_util__sieve__byte_vectors__insert_vector__2Xn, .-math_prime_util__sieve__byte_vectors__insert_vector__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__delete_firstXn
	.type	math_prime_util__sieve__byte_vectors__delete_firstXn, @function
math_prime_util__sieve__byte_vectors__delete_firstXn:
.LFB237:
	.cfi_startproc
	testl	%esi, %esi
	je	.L1008
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L1018
	addl	$1, %eax
	cmpl	%eax, %esi
	jl	.L1011
	movl	$-1, 16(%rdi)
	ret
	.p2align 4,,10
	.p2align 3
.L1008:
	ret
	.p2align 4,,10
	.p2align 3
.L1011:
	movl	%esi, %edx
	xorl	%esi, %esi
	jmp	math_prime_util__sieve__byte_vectors__deleteXn
.L1018:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
	.cfi_endproc
.LFE237:
	.size	math_prime_util__sieve__byte_vectors__delete_firstXn, .-math_prime_util__sieve__byte_vectors__delete_firstXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__delete_lastXn
	.type	math_prime_util__sieve__byte_vectors__delete_lastXn, @function
math_prime_util__sieve__byte_vectors__delete_lastXn:
.LFB238:
	.cfi_startproc
	testl	%esi, %esi
	je	.L1030
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L1033
	leal	1(%rax), %edx
	cmpl	%edx, %esi
	jge	.L1034
	subl	%esi, %eax
	jo	.L1024
	movl	%eax, 16(%rdi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1034:
	.cfi_restore_state
	movl	$-1, 16(%rdi)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1030:
	ret
.L1033:
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
.L1024:
	call	math_prime_util__sieve__byte_vectors__delete_lastXn.part.0
	.cfi_endproc
.LFE238:
	.size	math_prime_util__sieve__byte_vectors__delete_lastXn, .-math_prime_util__sieve__byte_vectors__delete_lastXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors___size__4Xn
	.type	math_prime_util__sieve__byte_vectors___size__4Xn, @function
math_prime_util__sieve__byte_vectors___size__4Xn:
.LFB602:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE602:
	.size	math_prime_util__sieve__byte_vectors___size__4Xn, .-math_prime_util__sieve__byte_vectors___size__4Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__iteratorDF__2Xn
	.type	math_prime_util__sieve__byte_vectors__iteratorDF__2Xn, @function
math_prime_util__sieve__byte_vectors__iteratorDF__2Xn:
.LFB596:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE596:
	.size	math_prime_util__sieve__byte_vectors__iteratorDF__2Xn, .-math_prime_util__sieve__byte_vectors__iteratorDF__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation___size__3
	.type	math_prime_util__sieve__byte_vectors__implementation___size__3, @function
math_prime_util__sieve__byte_vectors__implementation___size__3:
.LFB578:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE578:
	.size	math_prime_util__sieve__byte_vectors__implementation___size__3, .-math_prime_util__sieve__byte_vectors__implementation___size__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__adjust
	.type	math_prime_util__sieve__byte_vectors__implementation__adjust, @function
math_prime_util__sieve__byte_vectors__implementation__adjust:
.LFB564:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE564:
	.size	math_prime_util__sieve__byte_vectors__implementation__adjust, .-math_prime_util__sieve__byte_vectors__implementation__adjust
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__last__3Xn
	.type	math_prime_util__sieve__byte_vectors__last__3Xn, @function
math_prime_util__sieve__byte_vectors__last__3Xn:
.LFB271:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1043
	ret
	.p2align 4,,10
	.p2align 3
.L1043:
	movl	16(%rcx), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	movl	$0, %edx
	cmovs	%rdx, %rcx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE271:
	.size	math_prime_util__sieve__byte_vectors__last__3Xn, .-math_prime_util__sieve__byte_vectors__last__3Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__first__3Xn
	.type	math_prime_util__sieve__byte_vectors__first__3Xn, @function
math_prime_util__sieve__byte_vectors__first__3Xn:
.LFB248:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1048
	ret
	.p2align 4,,10
	.p2align 3
.L1048:
	movl	16(%rcx), %eax
	xorl	%esi, %esi
	movq	%rsi, %rdx
	testl	%eax, %eax
	cmovs	%rsi, %rcx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE248:
	.size	math_prime_util__sieve__byte_vectors__first__3Xn, .-math_prime_util__sieve__byte_vectors__first__3Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__last__3
	.type	math_prime_util__sieve__prime_vectors__last__3, @function
math_prime_util__sieve__prime_vectors__last__3:
.LFB73:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1053
	ret
	.p2align 4,,10
	.p2align 3
.L1053:
	movl	16(%rcx), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	movl	$0, %edx
	cmovs	%rdx, %rcx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE73:
	.size	math_prime_util__sieve__prime_vectors__last__3, .-math_prime_util__sieve__prime_vectors__last__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__first__3
	.type	math_prime_util__sieve__prime_vectors__first__3, @function
math_prime_util__sieve__prime_vectors__first__3:
.LFB50:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1058
	ret
	.p2align 4,,10
	.p2align 3
.L1058:
	movl	16(%rcx), %eax
	xorl	%esi, %esi
	movq	%rsi, %rdx
	testl	%eax, %eax
	cmovs	%rsi, %rcx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE50:
	.size	math_prime_util__sieve__prime_vectors__first__3, .-math_prime_util__sieve__prime_vectors__first__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__first_indexXn
	.type	math_prime_util__sieve__byte_vectors__first_indexXn, @function
math_prime_util__sieve__byte_vectors__first_indexXn:
.LFB616:
	.cfi_startproc
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE616:
	.size	math_prime_util__sieve__byte_vectors__first_indexXn, .-math_prime_util__sieve__byte_vectors__first_indexXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__adjust
	.type	math_prime_util__sieve__prime_vectors__implementation__adjust, @function
math_prime_util__sieve__prime_vectors__implementation__adjust:
.LFB548:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE548:
	.size	math_prime_util__sieve__prime_vectors__implementation__adjust, .-math_prime_util__sieve__prime_vectors__implementation__adjust
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation___size__2
	.type	math_prime_util__sieve__prime_vectors__implementation___size__2, @function
math_prime_util__sieve__prime_vectors__implementation___size__2:
.LFB570:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE570:
	.size	math_prime_util__sieve__prime_vectors__implementation___size__2, .-math_prime_util__sieve__prime_vectors__implementation___size__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation___size__3
	.type	math_prime_util__sieve__prime_vectors__implementation___size__3, @function
math_prime_util__sieve__prime_vectors__implementation___size__3:
.LFB572:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE572:
	.size	math_prime_util__sieve__prime_vectors__implementation___size__3, .-math_prime_util__sieve__prime_vectors__implementation___size__3
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation___size
	.type	math_prime_util__sieve__byte_vectors__implementation___size, @function
math_prime_util__sieve__byte_vectors__implementation___size:
.LFB574:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE574:
	.size	math_prime_util__sieve__byte_vectors__implementation___size, .-math_prime_util__sieve__byte_vectors__implementation___size
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation___size__2
	.type	math_prime_util__sieve__byte_vectors__implementation___size__2, @function
math_prime_util__sieve__byte_vectors__implementation___size__2:
.LFB576:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE576:
	.size	math_prime_util__sieve__byte_vectors__implementation___size__2, .-math_prime_util__sieve__byte_vectors__implementation___size__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDF
	.type	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDF, @function
math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDF:
.LFB580:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE580:
	.size	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDF, .-math_prime_util__sieve__prime_vectors__implementation__reference_control_typeDF
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__with_busyDF
	.type	math_prime_util__sieve__prime_vectors__implementation__with_busyDF, @function
math_prime_util__sieve__prime_vectors__implementation__with_busyDF:
.LFB582:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE582:
	.size	math_prime_util__sieve__prime_vectors__implementation__with_busyDF, .-math_prime_util__sieve__prime_vectors__implementation__with_busyDF
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__with_lockDF
	.type	math_prime_util__sieve__prime_vectors__implementation__with_lockDF, @function
math_prime_util__sieve__prime_vectors__implementation__with_lockDF:
.LFB584:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE584:
	.size	math_prime_util__sieve__prime_vectors__implementation__with_lockDF, .-math_prime_util__sieve__prime_vectors__implementation__with_lockDF
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__iteratorDF__2
	.type	math_prime_util__sieve__prime_vectors__iteratorDF__2, @function
math_prime_util__sieve__prime_vectors__iteratorDF__2:
.LFB586:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE586:
	.size	math_prime_util__sieve__prime_vectors__iteratorDF__2, .-math_prime_util__sieve__prime_vectors__iteratorDF__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDA
	.type	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDA, @function
math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDA:
.LFB588:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE588:
	.size	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDA, .-math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDA
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDF
	.type	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDF, @function
math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDF:
.LFB590:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE590:
	.size	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDF, .-math_prime_util__sieve__byte_vectors__implementation__reference_control_typeDF
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__with_busyDF
	.type	math_prime_util__sieve__byte_vectors__implementation__with_busyDF, @function
math_prime_util__sieve__byte_vectors__implementation__with_busyDF:
.LFB592:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE592:
	.size	math_prime_util__sieve__byte_vectors__implementation__with_busyDF, .-math_prime_util__sieve__byte_vectors__implementation__with_busyDF
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__with_lockDF
	.type	math_prime_util__sieve__byte_vectors__implementation__with_lockDF, @function
math_prime_util__sieve__byte_vectors__implementation__with_lockDF:
.LFB594:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE594:
	.size	math_prime_util__sieve__byte_vectors__implementation__with_lockDF, .-math_prime_util__sieve__byte_vectors__implementation__with_lockDF
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors___size__4
	.type	math_prime_util__sieve__prime_vectors___size__4, @function
math_prime_util__sieve__prime_vectors___size__4:
.LFB598:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE598:
	.size	math_prime_util__sieve__prime_vectors___size__4, .-math_prime_util__sieve__prime_vectors___size__4
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors___size__2Xn
	.type	math_prime_util__sieve__byte_vectors___size__2Xn, @function
math_prime_util__sieve__byte_vectors___size__2Xn:
.LFB600:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE600:
	.size	math_prime_util__sieve__byte_vectors___size__2Xn, .-math_prime_util__sieve__byte_vectors___size__2Xn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T583s, @function
math_prime_util__sieve__prime_vectors__T583s:
.LFB635:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE635:
	.size	math_prime_util__sieve__prime_vectors__T583s, .-math_prime_util__sieve__prime_vectors__T583s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T555s, @function
math_prime_util__sieve__prime_vectors__T555s:
.LFB636:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE636:
	.size	math_prime_util__sieve__prime_vectors__T555s, .-math_prime_util__sieve__prime_vectors__T555s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T583bXn, @function
math_prime_util__sieve__byte_vectors__T583bXn:
.LFB637:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE637:
	.size	math_prime_util__sieve__byte_vectors__T583bXn, .-math_prime_util__sieve__byte_vectors__T583bXn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T555bXn, @function
math_prime_util__sieve__byte_vectors__T555bXn:
.LFB638:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE638:
	.size	math_prime_util__sieve__byte_vectors__T555bXn, .-math_prime_util__sieve__byte_vectors__T555bXn
	.section	.text.unlikely
	.align 2
.LCOLDB28:
	.text
.LHOTB28:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__iterate__2
	.type	math_prime_util__sieve__prime_vectors__iterate__2, @function
math_prime_util__sieve__prime_vectors__iterate__2:
.LFB68:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA68
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%rdx, %r14
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%r8, %rbx
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	leaq	80(%rsp), %rax
	movq	%rsp, %rdi
	movl	%esi, 24(%rsp)
	movq	%rax, 32(%rsp)
.LEHB20:
	call	system__secondary_stack__ss_mark@PLT
	movl	24(%rsp), %eax
	cmpl	$1, %eax
	je	.L1080
	cmpl	$2, %eax
	je	.L1095
	cmpl	$3, %eax
	je	.L1096
	cmpl	$4, %eax
	jne	.L1084
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.LEHE20:
.L1094:
	leaq	32+math_prime_util__sieve__prime_vectors__math_prime_util__sieve__prime_vectors__iterator_math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rdx
	movl	24(%rsp), %ecx
	leaq	8(%rax), %rbx
	movq	%rbp, 16(%rax)
	movq	.LC27(%rip), %xmm0
	movq	%rdx, %xmm1
	movl	$-1, 24(%rax)
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, (%rax)
	cmpl	$2, %ecx
	jne	.L1085
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1080:
	.cfi_restore_state
	leaq	32+math_prime_util__sieve__prime_vectors__math_prime_util__sieve__prime_vectors__iterator_math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rax
	movq	%rbp, 16(%rbx)
	addq	$8, %rbx
	movq	.LC27(%rip), %xmm0
	movq	%rax, %xmm2
	movl	$-1, 16(%rbx)
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, -8(%rbx)
.L1085:
	movq	%rsp, %rdi
.LEHB21:
	call	system__secondary_stack__ss_release@PLT
.LEHE21:
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1095:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB22:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L1094
	.p2align 4,,10
	.p2align 3
.L1096:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L1094
.L1084:
	movl	$2058, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE22:
.L1089:
	movq	%rax, %rbx
	jmp	.L1087
	.section	.gcc_except_table
.LLSDA68:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE68-.LLSDACSB68
.LLSDACSB68:
	.uleb128 .LEHB20-.LFB68
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L1089-.LFB68
	.uleb128 0
	.uleb128 .LEHB21-.LFB68
	.uleb128 .LEHE21-.LEHB21
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB22-.LFB68
	.uleb128 .LEHE22-.LEHB22
	.uleb128 .L1089-.LFB68
	.uleb128 0
.LLSDACSE68:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC68
	.type	math_prime_util__sieve__prime_vectors__iterate__2.cold, @function
math_prime_util__sieve__prime_vectors__iterate__2.cold:
.LFSB68:
.L1087:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L1088
	movq	%rsp, %rdi
.LEHB23:
	call	system__secondary_stack__ss_release@PLT
.L1088:
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE23:
	.cfi_endproc
.LFE68:
	.section	.gcc_except_table
.LLSDAC68:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC68-.LLSDACSBC68
.LLSDACSBC68:
	.uleb128 .LEHB23-.LCOLDB28
	.uleb128 .LEHE23-.LEHB23
	.uleb128 0
	.uleb128 0
.LLSDACSEC68:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__iterate__2, .-math_prime_util__sieve__prime_vectors__iterate__2
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__iterate__2.cold, .-math_prime_util__sieve__prime_vectors__iterate__2.cold
.LCOLDE28:
	.text
.LHOTE28:
	.section	.text.unlikely
	.align 2
.LCOLDB30:
	.text
.LHOTB30:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__iterate__2Xn
	.type	math_prime_util__sieve__byte_vectors__iterate__2Xn, @function
math_prime_util__sieve__byte_vectors__iterate__2Xn:
.LFB266:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA266
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%rdx, %r14
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%r8, %rbx
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	leaq	80(%rsp), %rax
	movq	%rsp, %rdi
	movl	%esi, 24(%rsp)
	movq	%rax, 32(%rsp)
.LEHB24:
	call	system__secondary_stack__ss_mark@PLT
	movl	24(%rsp), %eax
	cmpl	$1, %eax
	je	.L1098
	cmpl	$2, %eax
	je	.L1113
	cmpl	$3, %eax
	je	.L1114
	cmpl	$4, %eax
	jne	.L1102
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.LEHE24:
.L1112:
	leaq	32+math_prime_util__sieve__byte_vectors__math_prime_util__sieve__byte_vectors__iterator_math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rdx
	movl	24(%rsp), %ecx
	leaq	8(%rax), %rbx
	movq	%rbp, 16(%rax)
	movq	.LC29(%rip), %xmm0
	movq	%rdx, %xmm1
	movl	$-1, 24(%rax)
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, (%rax)
	cmpl	$2, %ecx
	jne	.L1103
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1098:
	.cfi_restore_state
	leaq	32+math_prime_util__sieve__byte_vectors__math_prime_util__sieve__byte_vectors__iterator_math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rax
	movq	%rbp, 16(%rbx)
	addq	$8, %rbx
	movq	.LC29(%rip), %xmm0
	movq	%rax, %xmm2
	movl	$-1, 16(%rbx)
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, -8(%rbx)
.L1103:
	movq	%rsp, %rdi
.LEHB25:
	call	system__secondary_stack__ss_release@PLT
.LEHE25:
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1113:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB26:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L1112
	.p2align 4,,10
	.p2align 3
.L1114:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L1112
.L1102:
	movl	$2058, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE26:
.L1107:
	movq	%rax, %rbx
	jmp	.L1105
	.section	.gcc_except_table
.LLSDA266:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE266-.LLSDACSB266
.LLSDACSB266:
	.uleb128 .LEHB24-.LFB266
	.uleb128 .LEHE24-.LEHB24
	.uleb128 .L1107-.LFB266
	.uleb128 0
	.uleb128 .LEHB25-.LFB266
	.uleb128 .LEHE25-.LEHB25
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB26-.LFB266
	.uleb128 .LEHE26-.LEHB26
	.uleb128 .L1107-.LFB266
	.uleb128 0
.LLSDACSE266:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC266
	.type	math_prime_util__sieve__byte_vectors__iterate__2Xn.cold, @function
math_prime_util__sieve__byte_vectors__iterate__2Xn.cold:
.LFSB266:
.L1105:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L1106
	movq	%rsp, %rdi
.LEHB27:
	call	system__secondary_stack__ss_release@PLT
.L1106:
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE27:
	.cfi_endproc
.LFE266:
	.section	.gcc_except_table
.LLSDAC266:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC266-.LLSDACSBC266
.LLSDACSBC266:
	.uleb128 .LEHB27-.LCOLDB30
	.uleb128 .LEHE27-.LEHB27
	.uleb128 0
	.uleb128 0
.LLSDACSEC266:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__byte_vectors__iterate__2Xn, .-math_prime_util__sieve__byte_vectors__iterate__2Xn
	.section	.text.unlikely
	.size	math_prime_util__sieve__byte_vectors__iterate__2Xn.cold, .-math_prime_util__sieve__byte_vectors__iterate__2Xn.cold
.LCOLDE30:
	.text
.LHOTE30:
	.section	.text.unlikely
	.align 2
.LCOLDB31:
	.text
.LHOTB31:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__iterate__3
	.type	math_prime_util__sieve__prime_vectors__iterate__3, @function
math_prime_util__sieve__prime_vectors__iterate__3:
.LFB70:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA70
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%r8, %r14
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdx, %rbx
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	leaq	80(%rsp), %rax
	movq	%rsp, %rdi
	movl	%ecx, 24(%rsp)
	movq	%rax, 32(%rsp)
.LEHB28:
	call	system__secondary_stack__ss_mark@PLT
	movl	24(%rsp), %eax
	cmpl	$1, %eax
	je	.L1116
	cmpl	$2, %eax
	je	.L1131
	cmpl	$3, %eax
	je	.L1132
	cmpl	$4, %eax
	jne	.L1120
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.LEHE28:
.L1130:
	movq	.LC27(%rip), %xmm0
	leaq	32+math_prime_util__sieve__prime_vectors__math_prime_util__sieve__prime_vectors__iterator_math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rdx
	movl	24(%rsp), %ecx
	movl	%ebx, 24(%rax)
	movq	%rdx, %xmm1
	movq	%rbp, 16(%rax)
	leaq	8(%rax), %rbx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, (%rax)
	cmpl	$2, %ecx
	jne	.L1121
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1116:
	.cfi_restore_state
	movq	.LC27(%rip), %xmm0
	movq	80(%rsp), %rax
	movl	%ebx, 24(%rax)
	movq	%rbp, 16(%rax)
	leaq	32+math_prime_util__sieve__prime_vectors__math_prime_util__sieve__prime_vectors__iterator_math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rax
	movq	%rax, %xmm2
	movq	80(%rsp), %rax
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, (%rax)
	leaq	8(%rax), %rbx
.L1121:
	movq	%rsp, %rdi
.LEHB29:
	call	system__secondary_stack__ss_release@PLT
.LEHE29:
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1131:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB30:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L1130
	.p2align 4,,10
	.p2align 3
.L1132:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L1130
.L1120:
	movl	$2111, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE30:
.L1125:
	movq	%rax, %rbx
	jmp	.L1123
	.section	.gcc_except_table
.LLSDA70:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE70-.LLSDACSB70
.LLSDACSB70:
	.uleb128 .LEHB28-.LFB70
	.uleb128 .LEHE28-.LEHB28
	.uleb128 .L1125-.LFB70
	.uleb128 0
	.uleb128 .LEHB29-.LFB70
	.uleb128 .LEHE29-.LEHB29
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB30-.LFB70
	.uleb128 .LEHE30-.LEHB30
	.uleb128 .L1125-.LFB70
	.uleb128 0
.LLSDACSE70:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC70
	.type	math_prime_util__sieve__prime_vectors__iterate__3.cold, @function
math_prime_util__sieve__prime_vectors__iterate__3.cold:
.LFSB70:
.L1123:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L1124
	movq	%rsp, %rdi
.LEHB31:
	call	system__secondary_stack__ss_release@PLT
.L1124:
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE31:
	.cfi_endproc
.LFE70:
	.section	.gcc_except_table
.LLSDAC70:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC70-.LLSDACSBC70
.LLSDACSBC70:
	.uleb128 .LEHB31-.LCOLDB31
	.uleb128 .LEHE31-.LEHB31
	.uleb128 0
	.uleb128 0
.LLSDACSEC70:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__iterate__3, .-math_prime_util__sieve__prime_vectors__iterate__3
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__iterate__3.cold, .-math_prime_util__sieve__prime_vectors__iterate__3.cold
.LCOLDE31:
	.text
.LHOTE31:
	.section	.text.unlikely
	.align 2
.LCOLDB32:
	.text
.LHOTB32:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__iterate__3Xn
	.type	math_prime_util__sieve__byte_vectors__iterate__3Xn, @function
math_prime_util__sieve__byte_vectors__iterate__3Xn:
.LFB268:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA268
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%r8, %r14
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdx, %rbx
	subq	$48, %rsp
	.cfi_def_cfa_offset 80
	leaq	80(%rsp), %rax
	movq	%rsp, %rdi
	movl	%ecx, 24(%rsp)
	movq	%rax, 32(%rsp)
.LEHB32:
	call	system__secondary_stack__ss_mark@PLT
	movl	24(%rsp), %eax
	cmpl	$1, %eax
	je	.L1134
	cmpl	$2, %eax
	je	.L1149
	cmpl	$3, %eax
	je	.L1150
	cmpl	$4, %eax
	jne	.L1138
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.LEHE32:
.L1148:
	movq	.LC29(%rip), %xmm0
	leaq	32+math_prime_util__sieve__byte_vectors__math_prime_util__sieve__byte_vectors__iterator_math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rdx
	movl	24(%rsp), %ecx
	movl	%ebx, 24(%rax)
	movq	%rdx, %xmm1
	movq	%rbp, 16(%rax)
	leaq	8(%rax), %rbx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, (%rax)
	cmpl	$2, %ecx
	jne	.L1139
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1134:
	.cfi_restore_state
	movq	.LC29(%rip), %xmm0
	movq	80(%rsp), %rax
	movl	%ebx, 24(%rax)
	movq	%rbp, 16(%rax)
	leaq	32+math_prime_util__sieve__byte_vectors__math_prime_util__sieve__byte_vectors__iterator_math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rax
	movq	%rax, %xmm2
	movq	80(%rsp), %rax
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, (%rax)
	leaq	8(%rax), %rbx
.L1139:
	movq	%rsp, %rdi
.LEHB33:
	call	system__secondary_stack__ss_release@PLT
.LEHE33:
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1149:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB34:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L1148
	.p2align 4,,10
	.p2align 3
.L1150:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L1148
.L1138:
	movl	$2111, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE34:
.L1143:
	movq	%rax, %rbx
	jmp	.L1141
	.section	.gcc_except_table
.LLSDA268:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE268-.LLSDACSB268
.LLSDACSB268:
	.uleb128 .LEHB32-.LFB268
	.uleb128 .LEHE32-.LEHB32
	.uleb128 .L1143-.LFB268
	.uleb128 0
	.uleb128 .LEHB33-.LFB268
	.uleb128 .LEHE33-.LEHB33
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB34-.LFB268
	.uleb128 .LEHE34-.LEHB34
	.uleb128 .L1143-.LFB268
	.uleb128 0
.LLSDACSE268:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC268
	.type	math_prime_util__sieve__byte_vectors__iterate__3Xn.cold, @function
math_prime_util__sieve__byte_vectors__iterate__3Xn.cold:
.LFSB268:
.L1141:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L1142
	movq	%rsp, %rdi
.LEHB35:
	call	system__secondary_stack__ss_release@PLT
.L1142:
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE35:
	.cfi_endproc
.LFE268:
	.section	.gcc_except_table
.LLSDAC268:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC268-.LLSDACSBC268
.LLSDACSBC268:
	.uleb128 .LEHB35-.LCOLDB32
	.uleb128 .LEHE35-.LEHB35
	.uleb128 0
	.uleb128 0
.LLSDACSEC268:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__byte_vectors__iterate__3Xn, .-math_prime_util__sieve__byte_vectors__iterate__3Xn
	.section	.text.unlikely
	.size	math_prime_util__sieve__byte_vectors__iterate__3Xn.cold, .-math_prime_util__sieve__byte_vectors__iterate__3Xn.cold
.LCOLDE32:
	.text
.LHOTE32:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__vectorSO__2
	.type	math_prime_util__sieve__prime_vectors__vectorSO__2, @function
math_prime_util__sieve__prime_vectors__vectorSO__2:
.LFB604:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__sieve__prime_vectors__write
	.cfi_endproc
.LFE604:
	.size	math_prime_util__sieve__prime_vectors__vectorSO__2, .-math_prime_util__sieve__prime_vectors__vectorSO__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__vectorSO__2Xn
	.type	math_prime_util__sieve__byte_vectors__vectorSO__2Xn, @function
math_prime_util__sieve__byte_vectors__vectorSO__2Xn:
.LFB606:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__sieve__byte_vectors__writeXn
	.cfi_endproc
.LFE606:
	.size	math_prime_util__sieve__byte_vectors__vectorSO__2Xn, .-math_prime_util__sieve__byte_vectors__vectorSO__2Xn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T561bXn, @function
math_prime_util__sieve__byte_vectors__T561bXn:
.LFB622:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movl	%edx, 12(%rsp)
	call	ada__tags__offset_to_top@PLT
	movl	12(%rsp), %edx
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdi
	leaq	(%rbx,%rax), %rsi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root__root_controlledSR@PLT
	.cfi_endproc
.LFE622:
	.size	math_prime_util__sieve__byte_vectors__T561bXn, .-math_prime_util__sieve__byte_vectors__T561bXn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T564bXn, @function
math_prime_util__sieve__byte_vectors__T564bXn:
.LFB624:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movl	%edx, 12(%rsp)
	call	ada__tags__offset_to_top@PLT
	movl	12(%rsp), %edx
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdi
	leaq	(%rbx,%rax), %rsi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root__root_controlledSW@PLT
	.cfi_endproc
.LFE624:
	.size	math_prime_util__sieve__byte_vectors__T564bXn, .-math_prime_util__sieve__byte_vectors__T564bXn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T567bXn, @function
math_prime_util__sieve__byte_vectors__T567bXn:
.LFB626:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movl	%edx, 12(%rsp)
	call	ada__tags__offset_to_top@PLT
	movl	12(%rsp), %edx
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbp, %rdi
	leaq	(%rbx,%rax), %rsi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root__root_controlledSO@PLT
	.cfi_endproc
.LFE626:
	.size	math_prime_util__sieve__byte_vectors__T567bXn, .-math_prime_util__sieve__byte_vectors__T567bXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__previous__4
	.type	math_prime_util__sieve__prime_vectors__previous__4, @function
math_prime_util__sieve__prime_vectors__previous__4:
.LFB84:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1164
	leal	-1(%rdx), %eax
	testl	%edx, %edx
	jle	.L1165
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1165:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1164:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE84:
	.size	math_prime_util__sieve__prime_vectors__previous__4, .-math_prime_util__sieve__prime_vectors__previous__4
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__previous__4Xn
	.type	math_prime_util__sieve__byte_vectors__previous__4Xn, @function
math_prime_util__sieve__byte_vectors__previous__4Xn:
.LFB282:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1171
	leal	-1(%rdx), %eax
	testl	%edx, %edx
	jle	.L1172
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1172:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1171:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE282:
	.size	math_prime_util__sieve__byte_vectors__previous__4Xn, .-math_prime_util__sieve__byte_vectors__previous__4Xn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T591s, @function
math_prime_util__sieve__prime_vectors__T591s:
.LFB639:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1178
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L1176
	xorl	%eax, %eax
	xorl	%ecx, %ecx
.L1176:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1178:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE639:
	.size	math_prime_util__sieve__prime_vectors__T591s, .-math_prime_util__sieve__prime_vectors__T591s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T591bXn, @function
math_prime_util__sieve__byte_vectors__T591bXn:
.LFB640:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1184
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L1182
	xorl	%eax, %eax
	xorl	%ecx, %ecx
.L1182:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1184:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE640:
	.size	math_prime_util__sieve__byte_vectors__T591bXn, .-math_prime_util__sieve__byte_vectors__T591bXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__next__4
	.type	math_prime_util__sieve__prime_vectors__next__4, @function
math_prime_util__sieve__prime_vectors__next__4:
.LFB79:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1190
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L1188
	xorl	%eax, %eax
	xorl	%ecx, %ecx
.L1188:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1190:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE79:
	.size	math_prime_util__sieve__prime_vectors__next__4, .-math_prime_util__sieve__prime_vectors__next__4
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__next__4Xn
	.type	math_prime_util__sieve__byte_vectors__next__4Xn, @function
math_prime_util__sieve__byte_vectors__next__4Xn:
.LFB277:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1196
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L1194
	xorl	%eax, %eax
	xorl	%ecx, %ecx
.L1194:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1196:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE277:
	.size	math_prime_util__sieve__byte_vectors__next__4Xn, .-math_prime_util__sieve__byte_vectors__next__4Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSO
	.type	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSO, @function
math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSO:
.LFB129:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$4, %eax
	movq	%rsi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movq	%rdi, 8(%rsp)
	call	ada__finalization__controlledSW__2@PLT
	movq	8(%rbx), %rsi
	movq	8(%rsp), %rdi
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	system__stream_attributes__w_as@PLT
	.cfi_endproc
.LFE129:
	.size	math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSO, .-math_prime_util__sieve__prime_vectors__implementation__reference_control_typeSO
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSO
	.type	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSO, @function
math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSO:
.LFB327:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$4, %eax
	movq	%rsi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movq	%rdi, 8(%rsp)
	call	ada__finalization__controlledSW__2@PLT
	movq	8(%rbx), %rsi
	movq	8(%rsp), %rdi
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	system__stream_attributes__w_as@PLT
	.cfi_endproc
.LFE327:
	.size	math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSO, .-math_prime_util__sieve__byte_vectors__implementation__reference_control_typeSO
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__swap__2
	.type	math_prime_util__sieve__prime_vectors__swap__2, @function
math_prime_util__sieve__prime_vectors__swap__2:
.LFB106:
	.cfi_startproc
	cmpl	%edx, %r8d
	je	.L1201
	movq	8(%rdi), %rax
	movslq	%r8d, %r8
	movslq	%edx, %rdx
	movq	8(%rax,%r8,8), %rsi
	movq	8(%rax,%rdx,8), %rcx
	movq	%rsi, 8(%rax,%rdx,8)
	movq	8(%rdi), %rax
	movq	%rcx, 8(%rax,%r8,8)
.L1201:
	ret
	.cfi_endproc
.LFE106:
	.size	math_prime_util__sieve__prime_vectors__swap__2, .-math_prime_util__sieve__prime_vectors__swap__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__swap__2Xn
	.type	math_prime_util__sieve__byte_vectors__swap__2Xn, @function
math_prime_util__sieve__byte_vectors__swap__2Xn:
.LFB304:
	.cfi_startproc
	cmpl	%edx, %r8d
	je	.L1203
	movq	8(%rdi), %rax
	movslq	%r8d, %r8
	movslq	%edx, %rdx
	movzbl	4(%rax,%r8), %esi
	movzbl	4(%rax,%rdx), %ecx
	movb	%sil, 4(%rax,%rdx)
	movq	8(%rdi), %rax
	movb	%cl, 4(%rax,%r8)
.L1203:
	ret
	.cfi_endproc
.LFE304:
	.size	math_prime_util__sieve__byte_vectors__swap__2Xn, .-math_prime_util__sieve__byte_vectors__swap__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__vectorFD
	.type	math_prime_util__sieve__prime_vectors__vectorFD, @function
math_prime_util__sieve__prime_vectors__vectorFD:
.LFB152:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L1205
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1205:
	ret
	.cfi_endproc
.LFE152:
	.size	math_prime_util__sieve__prime_vectors__vectorFD, .-math_prime_util__sieve__prime_vectors__vectorFD
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__vectorDF__2
	.type	math_prime_util__sieve__prime_vectors__vectorDF__2, @function
math_prime_util__sieve__prime_vectors__vectorDF__2:
.LFB159:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L1207
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1207:
	ret
	.cfi_endproc
.LFE159:
	.size	math_prime_util__sieve__prime_vectors__vectorDF__2, .-math_prime_util__sieve__prime_vectors__vectorDF__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__append_vector
	.type	math_prime_util__sieve__prime_vectors__append_vector, @function
math_prime_util__sieve__prime_vectors__append_vector:
.LFB26:
	.cfi_startproc
	movl	16(%rsi), %edx
	testl	%edx, %edx
	js	.L1209
	movq	%rsi, %rdx
	movl	16(%rdi), %esi
	cmpl	$2147483647, %esi
	je	.L1215
	addl	$1, %esi
	jmp	math_prime_util__sieve__prime_vectors__insert_vector
	.p2align 4,,10
	.p2align 3
.L1209:
	ret
.L1215:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$197, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE26:
	.size	math_prime_util__sieve__prime_vectors__append_vector, .-math_prime_util__sieve__prime_vectors__append_vector
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T597s, @function
math_prime_util__sieve__prime_vectors__T597s:
.LFB641:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1221
	leal	-1(%rdx), %eax
	testl	%edx, %edx
	jle	.L1222
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1222:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1221:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE641:
	.size	math_prime_util__sieve__prime_vectors__T597s, .-math_prime_util__sieve__prime_vectors__T597s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T597bXn, @function
math_prime_util__sieve__byte_vectors__T597bXn:
.LFB642:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1228
	leal	-1(%rdx), %eax
	testl	%edx, %edx
	jle	.L1229
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1229:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1228:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE642:
	.size	math_prime_util__sieve__byte_vectors__T597bXn, .-math_prime_util__sieve__byte_vectors__T597bXn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T572bXn, @function
math_prime_util__sieve__byte_vectors__T572bXn:
.LFB628:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	call	ada__tags__offset_to_top@PLT
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	ada__tags__offset_to_top@PLT
	leaq	(%rbx,%r12), %rdi
	popq	%rbx
	.cfi_def_cfa_offset 24
	leaq	0(%rbp,%rax), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root__Oeq@PLT
	.cfi_endproc
.LFE628:
	.size	math_prime_util__sieve__byte_vectors__T572bXn, .-math_prime_util__sieve__byte_vectors__T572bXn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T577bXn, @function
math_prime_util__sieve__byte_vectors__T577bXn:
.LFB630:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	call	ada__tags__offset_to_top@PLT
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	ada__tags__offset_to_top@PLT
	leaq	(%rbx,%r12), %rdi
	popq	%rbx
	.cfi_def_cfa_offset 24
	leaq	0(%rbp,%rax), %rsi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	system__finalization_root___assign@PLT
	.cfi_endproc
.LFE630:
	.size	math_prime_util__sieve__byte_vectors__T577bXn, .-math_prime_util__sieve__byte_vectors__T577bXn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__implementation__T138s, @function
math_prime_util__sieve__prime_vectors__implementation__T138s:
.LFB149:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	movl	$16, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%esi, %ebp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	system__secondary_stack__ss_allocate@PLT
	movq	%r12, %rdi
	movq	%rax, %rbx
	leaq	32+math_prime_util__sieve__prime_vectors__implementation__reference_control_typeT(%rip), %rax
	movq	%rax, %xmm0
	movl	$4, %eax
	movq	%rbx, %rsi
	cmpl	%eax, %ebp
	movups	%xmm0, (%rbx)
	cmovle	%ebp, %eax
	movl	%eax, %edx
	call	ada__finalization__controlledSR__2@PLT
	movq	%r12, %rdi
	call	system__stream_attributes__i_as@PLT
	movq	%rax, 8(%rbx)
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE149:
	.size	math_prime_util__sieve__prime_vectors__implementation__T138s, .-math_prime_util__sieve__prime_vectors__implementation__T138s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__implementation__T138bXn, @function
math_prime_util__sieve__byte_vectors__implementation__T138bXn:
.LFB347:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	movl	$16, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%esi, %ebp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	system__secondary_stack__ss_allocate@PLT
	movq	%r12, %rdi
	movq	%rax, %rbx
	leaq	32+math_prime_util__sieve__byte_vectors__implementation__reference_control_typeT(%rip), %rax
	movq	%rax, %xmm0
	movl	$4, %eax
	movq	%rbx, %rsi
	cmpl	%eax, %ebp
	movups	%xmm0, (%rbx)
	cmovle	%ebp, %eax
	movl	%eax, %edx
	call	ada__finalization__controlledSR__2@PLT
	movq	%r12, %rdi
	call	system__stream_attributes__i_as@PLT
	movq	%rax, 8(%rbx)
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE347:
	.size	math_prime_util__sieve__byte_vectors__implementation__T138bXn, .-math_prime_util__sieve__byte_vectors__implementation__T138bXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__assign
	.type	math_prime_util__sieve__prime_vectors__assign, @function
math_prime_util__sieve__prime_vectors__assign:
.LFB29:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L1238
	movl	$-1, 16(%rdi)
	movl	16(%rsi), %eax
	testl	%eax, %eax
	js	.L1238
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__sieve__prime_vectors__insert_vector
	.p2align 4,,10
	.p2align 3
.L1238:
	ret
	.cfi_endproc
.LFE29:
	.size	math_prime_util__sieve__prime_vectors__assign, .-math_prime_util__sieve__prime_vectors__assign
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__assignXn
	.type	math_prime_util__sieve__byte_vectors__assignXn, @function
math_prime_util__sieve__byte_vectors__assignXn:
.LFB227:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L1240
	movl	$-1, 16(%rdi)
	movl	16(%rsi), %eax
	testl	%eax, %eax
	js	.L1240
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__sieve__byte_vectors__insert_vectorXn
	.p2align 4,,10
	.p2align 3
.L1240:
	ret
	.cfi_endproc
.LFE227:
	.size	math_prime_util__sieve__byte_vectors__assignXn, .-math_prime_util__sieve__byte_vectors__assignXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__vectorFDXn
	.type	math_prime_util__sieve__byte_vectors__vectorFDXn, @function
math_prime_util__sieve__byte_vectors__vectorFDXn:
.LFB350:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L1242
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1242:
	ret
	.cfi_endproc
.LFE350:
	.size	math_prime_util__sieve__byte_vectors__vectorFDXn, .-math_prime_util__sieve__byte_vectors__vectorFDXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__vectorDF__2Xn
	.type	math_prime_util__sieve__byte_vectors__vectorDF__2Xn, @function
math_prime_util__sieve__byte_vectors__vectorDF__2Xn:
.LFB357:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L1244
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1244:
	ret
	.cfi_endproc
.LFE357:
	.size	math_prime_util__sieve__byte_vectors__vectorDF__2Xn, .-math_prime_util__sieve__byte_vectors__vectorDF__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__append__3
	.type	math_prime_util__sieve__prime_vectors__append__3, @function
math_prime_util__sieve__prime_vectors__append__3:
.LFB27:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	8(%rdi), %rax
	movq	%rsi, %rdx
	movl	16(%rdi), %esi
	testq	%rax, %rax
	je	.L1247
	cmpl	%esi, (%rax)
	je	.L1247
	cmpl	$2147483647, %esi
	je	.L1256
	addl	$1, %esi
	movslq	%esi, %rcx
	movq	%rdx, 8(%rax,%rcx,8)
	movl	%esi, 16(%rdi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1247:
	.cfi_restore_state
	cmpl	$2147483647, %esi
	je	.L1257
	addl	$1, %esi
	movl	$1, %ecx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__sieve__prime_vectors__insert__4
.L1256:
	.cfi_restore_state
	movl	$223, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1257:
	movl	$229, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE27:
	.size	math_prime_util__sieve__prime_vectors__append__3, .-math_prime_util__sieve__prime_vectors__append__3
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T588s, @function
math_prime_util__sieve__prime_vectors__T588s:
.LFB643:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1262
	ret
	.p2align 4,,10
	.p2align 3
.L1262:
	movl	16(%rcx), %eax
	xorl	%esi, %esi
	movq	%rsi, %rdx
	testl	%eax, %eax
	cmovs	%rsi, %rcx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE643:
	.size	math_prime_util__sieve__prime_vectors__T588s, .-math_prime_util__sieve__prime_vectors__T588s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T588bXn, @function
math_prime_util__sieve__byte_vectors__T588bXn:
.LFB644:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1267
	ret
	.p2align 4,,10
	.p2align 3
.L1267:
	movl	16(%rcx), %eax
	xorl	%esi, %esi
	movq	%rsi, %rdx
	testl	%eax, %eax
	cmovs	%rsi, %rcx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE644:
	.size	math_prime_util__sieve__byte_vectors__T588bXn, .-math_prime_util__sieve__byte_vectors__T588bXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__read
	.type	math_prime_util__sieve__prime_vectors__read, @function
math_prime_util__sieve__prime_vectors__read:
.LFB91:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, (%rsp)
	movq	%rbp, 8(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	movq	%rsi, %rbp
	movq	%r12, 16(%rsp)
	movq	%r13, 24(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	movq	%rdi, %r13
	movl	$-1, 16(%rsi)
	call	system__stream_attributes__i_u@PLT
	movq	8(%rbp), %r12
	movl	%eax, %ebx
	testq	%r12, %r12
	je	.L1269
	movl	(%r12), %eax
	testl	%eax, %eax
	js	.L1269
	cmpl	$2147483647, %eax
	je	.L1282
	addl	$1, %eax
	cmpl	%eax, %ebx
	jg	.L1281
	testl	%ebx, %ebx
	jle	.L1268
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
.L1274:
	leal	-1(%rbx), %r14d
	xorl	%ebx, %ebx
	jmp	.L1275
	.p2align 4,,10
	.p2align 3
.L1283:
	movq	8(%rbp), %r12
	addq	$1, %rbx
.L1275:
	movq	%r13, %rdi
	call	system__stream_attributes__i_lu@PLT
	movq	%rax, 8(%r12,%rbx,8)
	movl	%ebx, 16(%rbp)
	cmpq	%r14, %rbx
	jne	.L1283
	movq	32(%rsp), %r14
	.cfi_restore 14
.L1268:
	movq	(%rsp), %rbx
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r12
	movq	24(%rsp), %r13
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1269:
	.cfi_restore_state
	testl	%ebx, %ebx
	jle	.L1268
.L1281:
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r14, 32(%rsp)
	.cfi_remember_state
	.cfi_offset 14, -16
	call	math_prime_util__sieve__prime_vectors__reserve_capacity
	movq	8(%rbp), %r12
	jmp	.L1274
.L1282:
	.cfi_restore_state
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	call	math_prime_util__sieve__prime_vectors__capacity.part.0
	.cfi_endproc
.LFE91:
	.size	math_prime_util__sieve__prime_vectors__read, .-math_prime_util__sieve__prime_vectors__read
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__vectorSR__2
	.type	math_prime_util__sieve__prime_vectors__vectorSR__2, @function
math_prime_util__sieve__prime_vectors__vectorSR__2:
.LFB169:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__sieve__prime_vectors__read
	.cfi_endproc
.LFE169:
	.size	math_prime_util__sieve__prime_vectors__vectorSR__2, .-math_prime_util__sieve__prime_vectors__vectorSR__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__readXn
	.type	math_prime_util__sieve__byte_vectors__readXn, @function
math_prime_util__sieve__byte_vectors__readXn:
.LFB289:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, (%rsp)
	movq	%rbp, 8(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	movq	%rsi, %rbp
	movq	%r12, 16(%rsp)
	movq	%r13, 24(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	movq	%rdi, %r13
	movl	$-1, 16(%rsi)
	call	system__stream_attributes__i_u@PLT
	movq	8(%rbp), %r12
	movl	%eax, %ebx
	testq	%r12, %r12
	je	.L1286
	movl	(%r12), %eax
	testl	%eax, %eax
	js	.L1286
	cmpl	$2147483647, %eax
	je	.L1299
	addl	$1, %eax
	cmpl	%eax, %ebx
	jg	.L1298
	testl	%ebx, %ebx
	jle	.L1285
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
.L1291:
	leal	-1(%rbx), %r14d
	xorl	%ebx, %ebx
	jmp	.L1292
	.p2align 4,,10
	.p2align 3
.L1300:
	movq	8(%rbp), %r12
	addq	$1, %rbx
.L1292:
	movq	%r13, %rdi
	call	system__stream_attributes__i_ssu@PLT
	movb	%al, 4(%r12,%rbx)
	movl	%ebx, 16(%rbp)
	cmpq	%r14, %rbx
	jne	.L1300
	movq	32(%rsp), %r14
	.cfi_restore 14
.L1285:
	movq	(%rsp), %rbx
	movq	8(%rsp), %rbp
	movq	16(%rsp), %r12
	movq	24(%rsp), %r13
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1286:
	.cfi_restore_state
	testl	%ebx, %ebx
	jle	.L1285
.L1298:
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r14, 32(%rsp)
	.cfi_remember_state
	.cfi_offset 14, -16
	call	math_prime_util__sieve__byte_vectors__reserve_capacityXn
	movq	8(%rbp), %r12
	jmp	.L1291
.L1299:
	.cfi_restore_state
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	call	math_prime_util__sieve__byte_vectors__capacityXn.part.0
	.cfi_endproc
.LFE289:
	.size	math_prime_util__sieve__byte_vectors__readXn, .-math_prime_util__sieve__byte_vectors__readXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__vectorSR__2Xn
	.type	math_prime_util__sieve__byte_vectors__vectorSR__2Xn, @function
math_prime_util__sieve__byte_vectors__vectorSR__2Xn:
.LFB367:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__sieve__byte_vectors__readXn
	.cfi_endproc
.LFE367:
	.size	math_prime_util__sieve__byte_vectors__vectorSR__2Xn, .-math_prime_util__sieve__byte_vectors__vectorSR__2Xn
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T594s, @function
math_prime_util__sieve__prime_vectors__T594s:
.LFB645:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1306
	ret
	.p2align 4,,10
	.p2align 3
.L1306:
	movl	16(%rcx), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	movl	$0, %edx
	cmovs	%rdx, %rcx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE645:
	.size	math_prime_util__sieve__prime_vectors__T594s, .-math_prime_util__sieve__prime_vectors__T594s
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__byte_vectors__T594bXn, @function
math_prime_util__sieve__byte_vectors__T594bXn:
.LFB646:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1311
	ret
	.p2align 4,,10
	.p2align 3
.L1311:
	movl	16(%rcx), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	movl	$0, %edx
	cmovs	%rdx, %rcx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE646:
	.size	math_prime_util__sieve__byte_vectors__T594bXn, .-math_prime_util__sieve__byte_vectors__T594bXn
	.section	.text.unlikely
	.align 2
.LCOLDB33:
	.text
.LHOTB33:
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__cacheTVFD, @function
math_prime_util__sieve__cacheTVFD:
.LFB401:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA401
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -24
	movq	%rdi, %rbx
.LEHB36:
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE36:
	movq	16(%rbx), %rdi
	movl	$-1, 24(%rbx)
	movq	$0, 16(%rbx)
	testq	%rdi, %rdi
	je	.L1312
	movq	%r14, 16(%rsp)
	.cfi_offset 14, -16
	movl	%eax, %r14d
.LEHB37:
	call	__gnat_free@PLT
.LEHE37:
	movq	16(%rsp), %r14
	.cfi_restore 14
.L1312:
	movq	8(%rsp), %rbx
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
.L1318:
	.cfi_def_cfa_offset 32
	.cfi_offset 14, -16
	movq	%rax, %rbx
	jmp	.L1315
	.section	.gcc_except_table
	.align 4
.LLSDA401:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT401-.LLSDATTD401
.LLSDATTD401:
	.byte	0x1
	.uleb128 .LLSDACSE401-.LLSDACSB401
.LLSDACSB401:
	.uleb128 .LEHB36-.LFB401
	.uleb128 .LEHE36-.LEHB36
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB37-.LFB401
	.uleb128 .LEHE37-.LEHB37
	.uleb128 .L1318-.LFB401
	.uleb128 0x1
.LLSDACSE401:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT401:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC401
	.type	math_prime_util__sieve__cacheTVFD.cold, @function
math_prime_util__sieve__cacheTVFD.cold:
.LFSB401:
.L1315:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1321
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB38:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	je	.L1317
	movq	16(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	jmp	.L1312
.L1321:
	.cfi_restore_state
	call	_Unwind_Resume@PLT
.L1317:
	movl	$74, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.LEHE38:
	.cfi_endproc
.LFE401:
	.section	.gcc_except_table
	.align 4
.LLSDAC401:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC401-.LLSDATTDC401
.LLSDATTDC401:
	.byte	0x1
	.uleb128 .LLSDACSEC401-.LLSDACSBC401
.LLSDACSBC401:
	.uleb128 .LEHB38-.LCOLDB33
	.uleb128 .LEHE38-.LEHB38
	.uleb128 0
	.uleb128 0
.LLSDACSEC401:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC401:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__cacheTVFD, .-math_prime_util__sieve__cacheTVFD
	.section	.text.unlikely
	.size	math_prime_util__sieve__cacheTVFD.cold, .-math_prime_util__sieve__cacheTVFD.cold
.LCOLDE33:
	.text
.LHOTE33:
	.section	.text.unlikely
	.align 2
.LCOLDB34:
	.text
.LHOTB34:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors___assign__2
	.type	math_prime_util__sieve__prime_vectors___assign__2, @function
math_prime_util__sieve__prime_vectors___assign__2:
.LFB157:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA157
	subq	$664, %rsp
	.cfi_def_cfa_offset 672
	movq	%rbx, 640(%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%rbp, 648(%rsp)
	.cfi_offset 6, -24
	movq	%rsi, %rbp
.LEHB39:
	call	*system__soft_links__abort_defer(%rip)
.LEHE39:
	cmpq	%rbp, %rbx
	jne	.L1323
.L1325:
	movq	640(%rsp), %rbx
	movq	648(%rsp), %rbp
	addq	$664, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
.LEHB40:
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE40:
	.p2align 4,,10
	.p2align 3
.L1323:
	.cfi_restore_state
	movq	8(%rbx), %rdi
	movl	$-1, 16(%rbx)
	movq	$0, 8(%rbx)
	testq	%rdi, %rdi
	je	.L1326
.LEHB41:
	call	__gnat_free@PLT
.L1326:
	movdqu	0(%rbp), %xmm0
	movq	(%rbx), %rax
	movq	%rbx, %rdi
	movups	%xmm0, (%rbx)
	movdqu	16(%rbp), %xmm0
	movq	%rax, (%rbx)
	movups	%xmm0, 16(%rbx)
	call	math_prime_util__sieve__prime_vectors__adjust__2
.LEHE41:
	jmp	.L1325
.L1332:
	movq	%rax, %rbp
	jmp	.L1327
.L1334:
	jmp	.L1335
	.section	.gcc_except_table
	.align 4
.LLSDA157:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT157-.LLSDATTD157
.LLSDATTD157:
	.byte	0x1
	.uleb128 .LLSDACSE157-.LLSDACSB157
.LLSDACSB157:
	.uleb128 .LEHB39-.LFB157
	.uleb128 .LEHE39-.LEHB39
	.uleb128 .L1334-.LFB157
	.uleb128 0
	.uleb128 .LEHB40-.LFB157
	.uleb128 .LEHE40-.LEHB40
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB41-.LFB157
	.uleb128 .LEHE41-.LEHB41
	.uleb128 .L1332-.LFB157
	.uleb128 0x3
.LLSDACSE157:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT157:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC157
	.type	math_prime_util__sieve__prime_vectors___assign__2.cold, @function
math_prime_util__sieve__prime_vectors___assign__2.cold:
.LFSB157:
.L1327:
	.cfi_def_cfa_offset 672
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	subq	$1, %rdx
	jne	.L1337
	movq	%rax, %rdi
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movq	%rax, %r14
.LEHB42:
	call	__gnat_set_exception_parameter@PLT
	movq	%rsp, %rdi
	call	__gnat_raise_from_controlled_operation@PLT
.LEHE42:
.L1331:
	movq	656(%rsp), %r14
	.cfi_restore 14
.L1335:
	movq	%r14, 656(%rsp)
	movq	%rax, %rbx
	.cfi_offset 14, -16
.L1329:
.LEHB43:
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE43:
.L1337:
	.cfi_restore 14
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	movq	%rax, %rbx
	jmp	.L1329
.L1333:
	movq	%rax, %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
.LEHB44:
	call	__gnat_end_handler_v1@PLT
.LEHE44:
	jmp	.L1329
	.cfi_endproc
.LFE157:
	.section	.gcc_except_table
	.align 4
.LLSDAC157:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC157-.LLSDATTDC157
.LLSDATTDC157:
	.byte	0x1
	.uleb128 .LLSDACSEC157-.LLSDACSBC157
.LLSDACSBC157:
	.uleb128 .LEHB42-.LCOLDB34
	.uleb128 .LEHE42-.LEHB42
	.uleb128 .L1333-.LCOLDB34
	.uleb128 0
	.uleb128 .LEHB43-.LCOLDB34
	.uleb128 .LEHE43-.LEHB43
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB44-.LCOLDB34
	.uleb128 .LEHE44-.LEHB44
	.uleb128 .L1331-.LCOLDB34
	.uleb128 0
.LLSDACSEC157:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC157:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors___assign__2, .-math_prime_util__sieve__prime_vectors___assign__2
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors___assign__2.cold, .-math_prime_util__sieve__prime_vectors___assign__2.cold
.LCOLDE34:
	.text
.LHOTE34:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__set_lengthXn
	.type	math_prime_util__sieve__byte_vectors__set_lengthXn, @function
math_prime_util__sieve__byte_vectors__set_lengthXn:
.LFB302:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %ecx
	cmpl	$2147483647, %ecx
	je	.L1352
	movl	%esi, %eax
	leal	1(%rcx), %esi
	movl	%esi, %edx
	subl	%eax, %edx
	jo	.L1341
	testl	%edx, %edx
	jns	.L1353
	cmpl	$-2147483648, %edx
	je	.L1354
	negl	%edx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__sieve__byte_vectors__insert_spaceXn
	.p2align 4,,10
	.p2align 3
.L1353:
	.cfi_restore_state
	je	.L1338
	subl	%edx, %ecx
	movl	$-1, %eax
	cmpl	%edx, %esi
	cmovg	%ecx, %eax
	movl	%eax, 16(%rdi)
.L1338:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L1341:
	.cfi_restore_state
	movl	$2993, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1352:
	call	math_prime_util__sieve__byte_vectors__lengthXn.part.0
.L1354:
	movl	$3010, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE302:
	.size	math_prime_util__sieve__byte_vectors__set_lengthXn, .-math_prime_util__sieve__byte_vectors__set_lengthXn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert_vector__2
	.type	math_prime_util__sieve__prime_vectors__insert_vector__2, @function
math_prime_util__sieve__prime_vectors__insert_vector__2:
.LFB58:
	.cfi_startproc
	movl	16(%rcx), %r8d
	testl	%r8d, %r8d
	js	.L1355
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L1357
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L1359
.L1358:
	leal	1(%rax), %esi
.L1359:
	movq	%rcx, %rdx
	jmp	math_prime_util__sieve__prime_vectors__insert_vector
	.p2align 4,,10
	.p2align 3
.L1355:
	ret
	.p2align 4,,10
	.p2align 3
.L1357:
	cmpl	$2147483647, %eax
	jne	.L1358
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1468, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE58:
	.size	math_prime_util__sieve__prime_vectors__insert_vector__2, .-math_prime_util__sieve__prime_vectors__insert_vector__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert__5
	.type	math_prime_util__sieve__prime_vectors__insert__5, @function
math_prime_util__sieve__prime_vectors__insert__5:
.LFB60:
	.cfi_startproc
	testl	%r8d, %r8d
	je	.L1363
	movl	16(%rdi), %eax
	movq	%rcx, %r9
	testq	%rsi, %rsi
	je	.L1365
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L1367
.L1366:
	leal	1(%rax), %esi
.L1367:
	movl	%r8d, %ecx
	movq	%r9, %rdx
	jmp	math_prime_util__sieve__prime_vectors__insert__4
	.p2align 4,,10
	.p2align 3
.L1363:
	ret
	.p2align 4,,10
	.p2align 3
.L1365:
	cmpl	$2147483647, %eax
	jne	.L1366
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1543, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE60:
	.size	math_prime_util__sieve__prime_vectors__insert__5, .-math_prime_util__sieve__prime_vectors__insert__5
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__set_length
	.type	math_prime_util__sieve__prime_vectors__set_length, @function
math_prime_util__sieve__prime_vectors__set_length:
.LFB104:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %ecx
	cmpl	$2147483647, %ecx
	je	.L1385
	movl	%esi, %eax
	leal	1(%rcx), %esi
	movl	%esi, %edx
	subl	%eax, %edx
	jo	.L1374
	testl	%edx, %edx
	jns	.L1386
	cmpl	$-2147483648, %edx
	je	.L1387
	negl	%edx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__sieve__prime_vectors__insert_space
	.p2align 4,,10
	.p2align 3
.L1386:
	.cfi_restore_state
	je	.L1371
	subl	%edx, %ecx
	movl	$-1, %eax
	cmpl	%edx, %esi
	cmovg	%ecx, %eax
	movl	%eax, 16(%rdi)
.L1371:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L1374:
	.cfi_restore_state
	movl	$2993, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1385:
	call	math_prime_util__sieve__prime_vectors__length.part.0
.L1387:
	movl	$3010, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE104:
	.size	math_prime_util__sieve__prime_vectors__set_length, .-math_prime_util__sieve__prime_vectors__set_length
	.section	.text.unlikely
	.align 2
.LCOLDB35:
	.text
.LHOTB35:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors___assign__2Xn
	.type	math_prime_util__sieve__byte_vectors___assign__2Xn, @function
math_prime_util__sieve__byte_vectors___assign__2Xn:
.LFB355:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA355
	subq	$664, %rsp
	.cfi_def_cfa_offset 672
	movq	%rbx, 640(%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%rbp, 648(%rsp)
	.cfi_offset 6, -24
	movq	%rsi, %rbp
.LEHB45:
	call	*system__soft_links__abort_defer(%rip)
.LEHE45:
	cmpq	%rbp, %rbx
	jne	.L1389
.L1391:
	movq	640(%rsp), %rbx
	movq	648(%rsp), %rbp
	addq	$664, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
.LEHB46:
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE46:
	.p2align 4,,10
	.p2align 3
.L1389:
	.cfi_restore_state
	movq	8(%rbx), %rdi
	movl	$-1, 16(%rbx)
	movq	$0, 8(%rbx)
	testq	%rdi, %rdi
	je	.L1392
.LEHB47:
	call	__gnat_free@PLT
.L1392:
	movdqu	0(%rbp), %xmm0
	movq	(%rbx), %rax
	movq	%rbx, %rdi
	movups	%xmm0, (%rbx)
	movdqu	16(%rbp), %xmm0
	movq	%rax, (%rbx)
	movups	%xmm0, 16(%rbx)
	call	math_prime_util__sieve__byte_vectors__adjust__2Xn
.LEHE47:
	jmp	.L1391
.L1398:
	movq	%rax, %rbp
	jmp	.L1393
.L1400:
	jmp	.L1401
	.section	.gcc_except_table
	.align 4
.LLSDA355:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT355-.LLSDATTD355
.LLSDATTD355:
	.byte	0x1
	.uleb128 .LLSDACSE355-.LLSDACSB355
.LLSDACSB355:
	.uleb128 .LEHB45-.LFB355
	.uleb128 .LEHE45-.LEHB45
	.uleb128 .L1400-.LFB355
	.uleb128 0
	.uleb128 .LEHB46-.LFB355
	.uleb128 .LEHE46-.LEHB46
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB47-.LFB355
	.uleb128 .LEHE47-.LEHB47
	.uleb128 .L1398-.LFB355
	.uleb128 0x3
.LLSDACSE355:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT355:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC355
	.type	math_prime_util__sieve__byte_vectors___assign__2Xn.cold, @function
math_prime_util__sieve__byte_vectors___assign__2Xn.cold:
.LFSB355:
.L1393:
	.cfi_def_cfa_offset 672
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	subq	$1, %rdx
	jne	.L1403
	movq	%rax, %rdi
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movq	%rax, %r14
.LEHB48:
	call	__gnat_set_exception_parameter@PLT
	movq	%rsp, %rdi
	call	__gnat_raise_from_controlled_operation@PLT
.LEHE48:
.L1397:
	movq	656(%rsp), %r14
	.cfi_restore 14
.L1401:
	movq	%r14, 656(%rsp)
	movq	%rax, %rbx
	.cfi_offset 14, -16
.L1395:
.LEHB49:
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE49:
.L1403:
	.cfi_restore 14
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	movq	%rax, %rbx
	jmp	.L1395
.L1399:
	movq	%rax, %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
.LEHB50:
	call	__gnat_end_handler_v1@PLT
.LEHE50:
	jmp	.L1395
	.cfi_endproc
.LFE355:
	.section	.gcc_except_table
	.align 4
.LLSDAC355:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC355-.LLSDATTDC355
.LLSDATTDC355:
	.byte	0x1
	.uleb128 .LLSDACSEC355-.LLSDACSBC355
.LLSDACSBC355:
	.uleb128 .LEHB48-.LCOLDB35
	.uleb128 .LEHE48-.LEHB48
	.uleb128 .L1399-.LCOLDB35
	.uleb128 0
	.uleb128 .LEHB49-.LCOLDB35
	.uleb128 .LEHE49-.LEHB49
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB50-.LCOLDB35
	.uleb128 .LEHE50-.LEHB50
	.uleb128 .L1397-.LCOLDB35
	.uleb128 0
.LLSDACSEC355:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC355:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__byte_vectors___assign__2Xn, .-math_prime_util__sieve__byte_vectors___assign__2Xn
	.section	.text.unlikely
	.size	math_prime_util__sieve__byte_vectors___assign__2Xn.cold, .-math_prime_util__sieve__byte_vectors___assign__2Xn.cold
.LCOLDE35:
	.text
.LHOTE35:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__insert__8
	.type	math_prime_util__sieve__prime_vectors__insert__8, @function
math_prime_util__sieve__prime_vectors__insert__8:
.LFB63:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%r8, %r11
	testl	%r9d, %r9d
	jne	.L1405
	testq	%rsi, %rsi
	je	.L1411
	cmpl	16(%rdi), %edx
	jle	.L1413
.L1411:
	xorl	%edi, %edi
	jmp	.L1406
	.p2align 4,,10
	.p2align 3
.L1405:
	movl	16(%rdi), %r8d
	movq	%rcx, %r10
	testq	%rsi, %rsi
	je	.L1407
	movl	%edx, %eax
	cmpl	%r8d, %edx
	jg	.L1408
.L1409:
	movl	%r9d, %ecx
	xorl	%edx, %edx
	movl	%eax, %esi
	movq	%r11, 24(%rsp)
	movq	%rdi, (%rsp)
	movq	%r10, 16(%rsp)
	movl	%eax, 12(%rsp)
	call	math_prime_util__sieve__prime_vectors__insert__4
	movl	12(%rsp), %r9d
	movq	(%rsp), %rdi
	movq	24(%rsp), %r11
.L1406:
	movl	%r11d, %eax
	movl	%r9d, %ecx
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movq	%rax, %rdx
	movq	%rdi, %rax
	movabsq	$-4294967296, %rdi
	movq	%rdx, %rsi
	andq	%rdi, %rsi
	orq	%rsi, %rcx
	movq	%rcx, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L1407:
	.cfi_restore_state
	cmpl	$2147483647, %r8d
	je	.L1414
.L1408:
	leal	1(%r8), %eax
	jmp	.L1409
	.p2align 4,,10
	.p2align 3
.L1413:
	movl	%edx, %r9d
	jmp	.L1406
.L1414:
	movl	$1585, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE63:
	.size	math_prime_util__sieve__prime_vectors__insert__8, .-math_prime_util__sieve__prime_vectors__insert__8
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__insert__8Xn
	.type	math_prime_util__sieve__byte_vectors__insert__8Xn, @function
math_prime_util__sieve__byte_vectors__insert__8Xn:
.LFB261:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%r8, %r11
	testl	%r9d, %r9d
	jne	.L1416
	testq	%rsi, %rsi
	je	.L1422
	cmpl	16(%rdi), %edx
	jle	.L1424
.L1422:
	xorl	%edi, %edi
	jmp	.L1417
	.p2align 4,,10
	.p2align 3
.L1416:
	movl	16(%rdi), %r8d
	movq	%rcx, %r10
	testq	%rsi, %rsi
	je	.L1418
	movl	%edx, %eax
	cmpl	%r8d, %edx
	jg	.L1419
.L1420:
	movl	%r9d, %ecx
	xorl	%edx, %edx
	movl	%eax, %esi
	movq	%r11, 24(%rsp)
	movq	%rdi, (%rsp)
	movq	%r10, 16(%rsp)
	movl	%eax, 12(%rsp)
	call	math_prime_util__sieve__byte_vectors__insert__4Xn
	movl	12(%rsp), %r9d
	movq	(%rsp), %rdi
	movq	24(%rsp), %r11
.L1417:
	movl	%r11d, %eax
	movl	%r9d, %ecx
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movq	%rax, %rdx
	movq	%rdi, %rax
	movabsq	$-4294967296, %rdi
	movq	%rdx, %rsi
	andq	%rdi, %rsi
	orq	%rsi, %rcx
	movq	%rcx, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L1418:
	.cfi_restore_state
	cmpl	$2147483647, %r8d
	je	.L1425
.L1419:
	leal	1(%r8), %eax
	jmp	.L1420
	.p2align 4,,10
	.p2align 3
.L1424:
	movl	%edx, %r9d
	jmp	.L1417
.L1425:
	movl	$1585, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE261:
	.size	math_prime_util__sieve__byte_vectors__insert__8Xn, .-math_prime_util__sieve__byte_vectors__insert__8Xn
	.section	.text.unlikely
	.align 2
.LCOLDB36:
	.text
.LHOTB36:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__put_image
	.type	math_prime_util__sieve__prime_vectors__put_image, @function
math_prime_util__sieve__prime_vectors__put_image:
.LFB87:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA87
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	leaq	160(%rsp), %rax
	movq	%rsi, 24(%rsp)
	movq	%rax, 80(%rsp)
.LEHB51:
	call	system__put_images__array_before@PLT
.LEHE51:
	leaq	56(%rsp), %rax
	leaq	32(%rsp), %rdi
	movq	$0, 56(%rsp)
	movq	%rax, 16(%rsp)
	leaq	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	movq	%rax, 8(%rsp)
.LEHB52:
	call	system__secondary_stack__ss_mark@PLT
	leaq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 8(%rsp)
	call	*system__soft_links__enter_master(%rip)
	leaq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 8(%rsp)
	call	*system__soft_links__current_master(%rip)
	leaq	56(%rsp), %rax
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rax, 16(%rsp)
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 8(%rsp)
	call	math_prime_util__sieve__prime_vectors__iterate__2
	movq	%rax, %rbp
	leaq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	%rbp, %rdi
	leaq	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 8(%rsp)
	call	ada__tags__base_address@PLT
	leaq	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rbx
	leaq	56(%rsp), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%rdx, 16(%rsp)
	movq	%rbx, 8(%rsp)
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	0(%rbp), %rax
	movq	(%rax), %rax
	testb	$1, %al
	jne	.L1458
.L1427:
	movq	%rbp, %rdi
	call	*%rax
	movq	%rdx, %r15
	movq	%rax, %rbx
	movl	%edx, %r13d
	testl	%edx, %edx
	jne	.L1428
	testq	%rax, %rax
	je	.L1434
.L1428:
	movq	24(%rsp), %rax
	movq	8(%rax), %rax
	jmp	.L1436
	.p2align 4,,10
	.p2align 3
.L1445:
	movq	24(%rsp), %rax
	movq	%r12, %rdi
	movq	8(%rax), %rax
	movq	%rax, (%rsp)
	call	system__put_images__simple_array_between@PLT
	movq	(%rsp), %rax
.L1436:
	movslq	%r13d, %rsi
	movq	%r12, %rdi
	movq	8(%rax,%rsi,8), %rsi
	call	system__put_images__put_image_long_long_unsigned@PLT
	movq	0(%rbp), %rsi
	movq	%r15, %rcx
	movl	%r13d, %edi
	movabsq	$-4294967296, %rax
	andq	%rax, %rcx
	movq	8(%rsi), %rsi
	orq	%rdi, %rcx
	movq	%rcx, %r15
	movq	%rbx, %rcx
	movq	%rsi, %rax
	movq	%r15, %rdx
	testb	$1, %al
	jne	.L1459
.L1433:
	movq	%rcx, %rsi
	movq	%rbp, %rdi
	call	*%rax
.LEHE52:
	movq	%rdx, %r15
	movq	%rax, %rbx
	movl	%edx, %r13d
	testl	%edx, %edx
	jne	.L1445
	testq	%rax, %rax
	jne	.L1445
.L1434:
.LEHB53:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebx
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE53:
	movq	8(%rsp), %rsi
	movq	16(%rsp), %rdi
.LEHB54:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE54:
	leaq	32(%rsp), %rdi
.LEHB55:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
.L1429:
	movq	%r12, %rdi
	call	system__put_images__array_after@PLT
.LEHE55:
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L1459:
	.cfi_restore_state
	movq	-1(%rsi), %r10
	movq	7(%rsi), %rax
	jmp	.L1433
.L1458:
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1427
.L1442:
	movq	%rax, %r12
	jmp	.L1437
.L1443:
	movq	%rax, %rbp
	jmp	.L1430
	.section	.gcc_except_table
	.align 4
.LLSDA87:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT87-.LLSDATTD87
.LLSDATTD87:
	.byte	0x1
	.uleb128 .LLSDACSE87-.LLSDACSB87
.LLSDACSB87:
	.uleb128 .LEHB51-.LFB87
	.uleb128 .LEHE51-.LEHB51
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB52-.LFB87
	.uleb128 .LEHE52-.LEHB52
	.uleb128 .L1442-.LFB87
	.uleb128 0
	.uleb128 .LEHB53-.LFB87
	.uleb128 .LEHE53-.LEHB53
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB54-.LFB87
	.uleb128 .LEHE54-.LEHB54
	.uleb128 .L1443-.LFB87
	.uleb128 0x1
	.uleb128 .LEHB55-.LFB87
	.uleb128 .LEHE55-.LEHB55
	.uleb128 0
	.uleb128 0
.LLSDACSE87:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT87:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC87
	.type	math_prime_util__sieve__prime_vectors__put_image.cold, @function
math_prime_util__sieve__prime_vectors__put_image.cold:
.LFSB87:
.L1437:
	.cfi_def_cfa_offset 160
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
.LEHB56:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebp
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE56:
	movq	8(%rsp), %rsi
	movq	16(%rsp), %rdi
.LEHB57:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE57:
	xorl	%ebx, %ebx
.L1441:
	leaq	32(%rsp), %rdi
	xorl	$1, %ebp
.LEHB58:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	testb	%bl, %bpl
	je	.L1456
.L1432:
	movl	$2362, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1430:
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1460
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	leaq	32(%rsp), %rdi
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	andb	$1, %bl
	jne	.L1429
	jmp	.L1432
.L1444:
	subq	$1, %rdx
	movq	%rax, %rbx
	movq	%rax, %rdi
	jne	.L1461
	call	__gnat_begin_handler_v1@PLT
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movl	$1, %ebx
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	jmp	.L1441
.L1456:
	movq	%r12, %rdi
	call	_Unwind_Resume@PLT
.L1460:
	call	_Unwind_Resume@PLT
.L1461:
	call	_Unwind_Resume@PLT
.LEHE58:
	.cfi_endproc
.LFE87:
	.section	.gcc_except_table
	.align 4
.LLSDAC87:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC87-.LLSDATTDC87
.LLSDATTDC87:
	.byte	0x1
	.uleb128 .LLSDACSEC87-.LLSDACSBC87
.LLSDACSBC87:
	.uleb128 .LEHB56-.LCOLDB36
	.uleb128 .LEHE56-.LEHB56
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB57-.LCOLDB36
	.uleb128 .LEHE57-.LEHB57
	.uleb128 .L1444-.LCOLDB36
	.uleb128 0x1
	.uleb128 .LEHB58-.LCOLDB36
	.uleb128 .LEHE58-.LEHB58
	.uleb128 0
	.uleb128 0
.LLSDACSEC87:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC87:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__put_image, .-math_prime_util__sieve__prime_vectors__put_image
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__put_image.cold, .-math_prime_util__sieve__prime_vectors__put_image.cold
.LCOLDE36:
	.text
.LHOTE36:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__vectorPI__2
	.type	math_prime_util__sieve__prime_vectors__vectorPI__2, @function
math_prime_util__sieve__prime_vectors__vectorPI__2:
.LFB167:
	.cfi_startproc
	jmp	math_prime_util__sieve__prime_vectors__put_image
	.cfi_endproc
.LFE167:
	.size	math_prime_util__sieve__prime_vectors__vectorPI__2, .-math_prime_util__sieve__prime_vectors__vectorPI__2
	.section	.text.unlikely
	.align 2
.LCOLDB37:
	.text
.LHOTB37:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__put_imageXn
	.type	math_prime_util__sieve__byte_vectors__put_imageXn, @function
math_prime_util__sieve__byte_vectors__put_imageXn:
.LFB285:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA285
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	leaq	160(%rsp), %rax
	movq	%rsi, 24(%rsp)
	movq	%rax, 80(%rsp)
.LEHB59:
	call	system__put_images__array_before@PLT
.LEHE59:
	leaq	56(%rsp), %rax
	leaq	32(%rsp), %rdi
	movq	$0, 56(%rsp)
	movq	%rax, 16(%rsp)
	leaq	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn(%rip), %rax
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	movq	%rax, 8(%rsp)
.LEHB60:
	call	system__secondary_stack__ss_mark@PLT
	leaq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn(%rip), %rax
	movq	%rax, 8(%rsp)
	call	*system__soft_links__enter_master(%rip)
	leaq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn(%rip), %rax
	movq	%rax, 8(%rsp)
	call	*system__soft_links__current_master(%rip)
	leaq	56(%rsp), %rax
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rax, 16(%rsp)
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn(%rip), %rax
	movq	%rax, 8(%rsp)
	call	math_prime_util__sieve__byte_vectors__iterate__2Xn
	movq	%rax, %rbp
	leaq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	%rbp, %rdi
	leaq	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn(%rip), %rax
	movq	%rax, 8(%rsp)
	call	ada__tags__base_address@PLT
	leaq	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn(%rip), %rbx
	leaq	56(%rsp), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%rdx, 16(%rsp)
	movq	%rbx, 8(%rsp)
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	0(%rbp), %rax
	movq	(%rax), %rax
	testb	$1, %al
	jne	.L1495
.L1464:
	movq	%rbp, %rdi
	call	*%rax
	movq	%rdx, %r15
	movq	%rax, %rbx
	movl	%edx, %r13d
	testl	%edx, %edx
	jne	.L1465
	testq	%rax, %rax
	je	.L1471
.L1465:
	movq	24(%rsp), %rax
	movq	8(%rax), %rax
	jmp	.L1473
	.p2align 4,,10
	.p2align 3
.L1482:
	movq	24(%rsp), %rax
	movq	%r12, %rdi
	movq	8(%rax), %rax
	movq	%rax, (%rsp)
	call	system__put_images__simple_array_between@PLT
	movq	(%rsp), %rax
.L1473:
	movslq	%r13d, %rsi
	movq	%r12, %rdi
	movzbl	4(%rax,%rsi), %esi
	call	system__put_images__put_image_unsigned@PLT
	movq	0(%rbp), %rsi
	movq	%r15, %rcx
	movl	%r13d, %edi
	movabsq	$-4294967296, %rax
	andq	%rax, %rcx
	movq	8(%rsi), %rsi
	orq	%rdi, %rcx
	movq	%rcx, %r15
	movq	%rbx, %rcx
	movq	%rsi, %rax
	movq	%r15, %rdx
	testb	$1, %al
	jne	.L1496
.L1470:
	movq	%rcx, %rsi
	movq	%rbp, %rdi
	call	*%rax
.LEHE60:
	movq	%rdx, %r15
	movq	%rax, %rbx
	movl	%edx, %r13d
	testl	%edx, %edx
	jne	.L1482
	testq	%rax, %rax
	jne	.L1482
.L1471:
.LEHB61:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebx
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE61:
	movq	8(%rsp), %rsi
	movq	16(%rsp), %rdi
.LEHB62:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE62:
	leaq	32(%rsp), %rdi
.LEHB63:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
.L1466:
	movq	%r12, %rdi
	call	system__put_images__array_after@PLT
.LEHE63:
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L1496:
	.cfi_restore_state
	movq	-1(%rsi), %r10
	movq	7(%rsi), %rax
	jmp	.L1470
.L1495:
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1464
.L1479:
	movq	%rax, %r12
	jmp	.L1474
.L1480:
	movq	%rax, %rbp
	jmp	.L1467
	.section	.gcc_except_table
	.align 4
.LLSDA285:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT285-.LLSDATTD285
.LLSDATTD285:
	.byte	0x1
	.uleb128 .LLSDACSE285-.LLSDACSB285
.LLSDACSB285:
	.uleb128 .LEHB59-.LFB285
	.uleb128 .LEHE59-.LEHB59
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB60-.LFB285
	.uleb128 .LEHE60-.LEHB60
	.uleb128 .L1479-.LFB285
	.uleb128 0
	.uleb128 .LEHB61-.LFB285
	.uleb128 .LEHE61-.LEHB61
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB62-.LFB285
	.uleb128 .LEHE62-.LEHB62
	.uleb128 .L1480-.LFB285
	.uleb128 0x1
	.uleb128 .LEHB63-.LFB285
	.uleb128 .LEHE63-.LEHB63
	.uleb128 0
	.uleb128 0
.LLSDACSE285:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT285:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC285
	.type	math_prime_util__sieve__byte_vectors__put_imageXn.cold, @function
math_prime_util__sieve__byte_vectors__put_imageXn.cold:
.LFSB285:
.L1474:
	.cfi_def_cfa_offset 160
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
.LEHB64:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebp
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE64:
	movq	8(%rsp), %rsi
	movq	16(%rsp), %rdi
.LEHB65:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE65:
	xorl	%ebx, %ebx
.L1478:
	leaq	32(%rsp), %rdi
	xorl	$1, %ebp
.LEHB66:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	testb	%bl, %bpl
	je	.L1493
.L1469:
	movl	$2362, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1467:
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1497
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	leaq	32(%rsp), %rdi
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	andb	$1, %bl
	jne	.L1466
	jmp	.L1469
.L1481:
	subq	$1, %rdx
	movq	%rax, %rbx
	movq	%rax, %rdi
	jne	.L1498
	call	__gnat_begin_handler_v1@PLT
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movl	$1, %ebx
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	jmp	.L1478
.L1493:
	movq	%r12, %rdi
	call	_Unwind_Resume@PLT
.L1497:
	call	_Unwind_Resume@PLT
.L1498:
	call	_Unwind_Resume@PLT
.LEHE66:
	.cfi_endproc
.LFE285:
	.section	.gcc_except_table
	.align 4
.LLSDAC285:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC285-.LLSDATTDC285
.LLSDATTDC285:
	.byte	0x1
	.uleb128 .LLSDACSEC285-.LLSDACSBC285
.LLSDACSBC285:
	.uleb128 .LEHB64-.LCOLDB37
	.uleb128 .LEHE64-.LEHB64
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB65-.LCOLDB37
	.uleb128 .LEHE65-.LEHB65
	.uleb128 .L1481-.LCOLDB37
	.uleb128 0x1
	.uleb128 .LEHB66-.LCOLDB37
	.uleb128 .LEHE66-.LEHB66
	.uleb128 0
	.uleb128 0
.LLSDACSEC285:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC285:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__byte_vectors__put_imageXn, .-math_prime_util__sieve__byte_vectors__put_imageXn
	.section	.text.unlikely
	.size	math_prime_util__sieve__byte_vectors__put_imageXn.cold, .-math_prime_util__sieve__byte_vectors__put_imageXn.cold
.LCOLDE37:
	.text
.LHOTE37:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__vectorPI__2Xn
	.type	math_prime_util__sieve__byte_vectors__vectorPI__2Xn, @function
math_prime_util__sieve__byte_vectors__vectorPI__2Xn:
.LFB365:
	.cfi_startproc
	jmp	math_prime_util__sieve__byte_vectors__put_imageXn
	.cfi_endproc
.LFE365:
	.size	math_prime_util__sieve__byte_vectors__vectorPI__2Xn, .-math_prime_util__sieve__byte_vectors__vectorPI__2Xn
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__vectorDA__2Xn
	.type	math_prime_util__sieve__byte_vectors__vectorDA__2Xn, @function
math_prime_util__sieve__byte_vectors__vectorDA__2Xn:
.LFB356:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -40
	movl	16(%rdi), %ebp
	cmpl	$-1, %ebp
	je	.L1504
	movq	%rbx, (%rsp)
	.cfi_offset 3, -48
	movq	%rdi, %rbx
	movq	%r12, 16(%rsp)
	.cfi_offset 12, -32
	movslq	%ebp, %r12
	movq	%r13, 24(%rsp)
	movq	%r14, 32(%rsp)
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	movq	8(%rdi), %r14
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	leaq	8(%r12), %rdi
	andq	$-4, %rdi
	call	__gnat_malloc@PLT
	leaq	1(%r12), %rdx
	leaq	4(%r14), %rsi
	movl	%ebp, (%rax)
	movq	%rax, %r13
	leaq	4(%rax), %rdi
	call	memcpy@PLT
	movq	%r13, 8(%rbx)
	movq	16(%rsp), %r12
	.cfi_restore 12
	movq	24(%rsp), %r13
	.cfi_restore 13
	movq	32(%rsp), %r14
	.cfi_restore 14
	movl	%ebp, 16(%rbx)
	movq	(%rsp), %rbx
	.cfi_restore 3
	movq	8(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1504:
	.cfi_def_cfa_offset 48
	movq	$0, 8(%rdi)
	movq	8(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE356:
	.size	math_prime_util__sieve__byte_vectors__vectorDA__2Xn, .-math_prime_util__sieve__byte_vectors__vectorDA__2Xn
	.section	.text.unlikely
	.align 2
.LCOLDB38:
	.text
.LHOTB38:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD
	.type	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD, @function
math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD:
.LFB121:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA121
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
.LEHB67:
	call	*system__soft_links__enter_master(%rip)
	call	*system__soft_links__current_master(%rip)
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	movq	64(%rax), %rax
	testb	$1, %al
	jne	.L1513
.L1506:
	movl	$1, %esi
	movq	%rbx, %rdi
	call	*%rax
.LEHE67:
.LEHB68:
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE68:
.L1513:
	.cfi_restore_state
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1506
.L1508:
	movq	%rax, %rbx
	jmp	.L1507
	.section	.gcc_except_table
.LLSDA121:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE121-.LLSDACSB121
.LLSDACSB121:
	.uleb128 .LEHB67-.LFB121
	.uleb128 .LEHE67-.LEHB67
	.uleb128 .L1508-.LFB121
	.uleb128 0
	.uleb128 .LEHB68-.LFB121
	.uleb128 .LEHE68-.LEHB68
	.uleb128 0
	.uleb128 0
.LLSDACSE121:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC121
	.type	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold, @function
math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold:
.LFSB121:
.L1507:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
.LEHB69:
	call	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B16s___finalizer.12
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE69:
	.cfi_endproc
.LFE121:
	.section	.gcc_except_table
.LLSDAC121:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC121-.LLSDACSBC121
.LLSDACSBC121:
	.uleb128 .LEHB69-.LCOLDB38
	.uleb128 .LEHE69-.LEHB69
	.uleb128 0
	.uleb128 0
.LLSDACSEC121:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD, .-math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold, .-math_prime_util__sieve__prime_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold
.LCOLDE38:
	.text
.LHOTE38:
	.section	.text.unlikely
	.align 2
.LCOLDB39:
	.text
.LHOTB39:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn
	.type	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn, @function
math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn:
.LFB319:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA319
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
.LEHB70:
	call	*system__soft_links__enter_master(%rip)
	call	*system__soft_links__current_master(%rip)
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	movq	64(%rax), %rax
	testb	$1, %al
	jne	.L1522
.L1515:
	movl	$1, %esi
	movq	%rbx, %rdi
	call	*%rax
.LEHE70:
.LEHB71:
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE71:
.L1522:
	.cfi_restore_state
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1515
.L1517:
	movq	%rax, %rbx
	jmp	.L1516
	.section	.gcc_except_table
.LLSDA319:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE319-.LLSDACSB319
.LLSDACSB319:
	.uleb128 .LEHB70-.LFB319
	.uleb128 .LEHE70-.LEHB70
	.uleb128 .L1517-.LFB319
	.uleb128 0
	.uleb128 .LEHB71-.LFB319
	.uleb128 .LEHE71-.LEHB71
	.uleb128 0
	.uleb128 0
.LLSDACSE319:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC319
	.type	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn.cold, @function
math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn.cold:
.LFSB319:
.L1516:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
.LEHB72:
	call	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B16b___finalizerXn.29
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE72:
	.cfi_endproc
.LFE319:
	.section	.gcc_except_table
.LLSDAC319:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC319-.LLSDACSBC319
.LLSDACSBC319:
	.uleb128 .LEHB72-.LCOLDB39
	.uleb128 .LEHE72-.LEHB72
	.uleb128 0
	.uleb128 0
.LLSDACSEC319:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn, .-math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn
	.section	.text.unlikely
	.size	math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn.cold, .-math_prime_util__sieve__byte_vectors__vector_iterator_interfaces__Treversible_iteratorCFDXn.cold
.LCOLDE39:
	.text
.LHOTE39:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__byte_vectors__append__2Xn
	.type	math_prime_util__sieve__byte_vectors__append__2Xn, @function
math_prime_util__sieve__byte_vectors__append__2Xn:
.LFB223:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	cmpl	$1, %edx
	je	.L1537
	testl	%edx, %edx
	je	.L1523
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L1538
	movl	%edx, %ecx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movzbl	%sil, %edx
	leal	1(%rax), %esi
	jmp	math_prime_util__sieve__byte_vectors__insert__4Xn
	.p2align 4,,10
	.p2align 3
.L1537:
	.cfi_restore_state
	movq	8(%rdi), %rdx
	movl	16(%rdi), %eax
	testq	%rdx, %rdx
	je	.L1525
	cmpl	(%rdx), %eax
	je	.L1525
	cmpl	$2147483647, %eax
	je	.L1539
	addl	$1, %eax
	movslq	%eax, %rcx
	movb	%sil, 4(%rdx,%rcx)
	movl	%eax, 16(%rdi)
.L1523:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1525:
	.cfi_restore_state
	cmpl	$2147483647, %eax
	je	.L1540
	movzbl	%sil, %edx
	movl	$1, %ecx
	leal	1(%rax), %esi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__sieve__byte_vectors__insert__4Xn
.L1538:
	.cfi_restore_state
	call	math_prime_util__sieve__byte_vectors__append_slow_pathXn.part.0
.L1540:
	movl	$229, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1539:
	movl	$223, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE223:
	.size	math_prime_util__sieve__byte_vectors__append__2Xn, .-math_prime_util__sieve__byte_vectors__append__2Xn
	.section	.text.unlikely
	.align 2
.LCOLDB40:
	.text
.LHOTB40:
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__cache__ensureN.constprop.0, @function
math_prime_util__sieve__cache__ensureN.constprop.0:
.LFB699:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA699
	subq	$200, %rsp
	.cfi_def_cfa_offset 208
	leaq	208(%rsp), %rax
	movq	%rax, 40(%rsp)
	movl	24+math_prime_util__sieve__cache(%rip), %eax
	testl	%eax, %eax
	js	.L1542
	cmpq	%rdi, math_prime_util__sieve__cache(%rip)
	jnb	.L1541
.L1542:
	leaq	208(%rsp), %rax
	movq	%rbx, 152(%rsp)
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	movq	%rdi, (%rsp)
	movq	%rax, 104(%rsp)
	leaq	32+math_prime_util__sieve__byte_vectors__vectorT(%rip), %rax
	movq	%rbp, 160(%rsp)
	movq	%rax, %xmm0
	xorl	%eax, %eax
	movq	%r12, 168(%rsp)
	movl	%eax, %edi
	movq	%r13, 176(%rsp)
	movq	%r14, 184(%rsp)
	movq	%r15, 192(%rsp)
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	$0, 16(%rsp)
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	$0, 80(%rsp)
	movq	$0, 88(%rsp)
	movq	$0, 96(%rsp)
	movl	$-1, 128(%rsp)
	movaps	%xmm0, 112(%rsp)
	xchgl	132(%rsp), %edi
	xchgl	136(%rsp), %eax
	leaq	math_prime_util__sieve__byte_vectors__vectorFDXn(%rip), %rsi
	leaq	80(%rsp), %rdx
	leaq	112(%rsp), %rdi
.LEHB73:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	%rbx, %rdi
	call	math_prime_util__int__sqrtint@PLT
	movq	%rax, %r12
	movabsq	$-8608480567731124087, %rax
	mulq	%rbx
	shrq	$4, %rdx
	leaq	1(%rdx), %rax
	cmpq	$2147483647, %rax
	ja	.L1598
	leal	1(%rdx), %esi
	leaq	112(%rsp), %rdi
	call	math_prime_util__sieve__byte_vectors__set_lengthXn
	movl	128(%rsp), %eax
	testl	%eax, %eax
	js	.L1545
	movl	%eax, %edx
	xorl	%eax, %eax
	leaq	1(%rdx), %rcx
	.p2align 5
	.p2align 4
	.p2align 3
.L1546:
	movq	120(%rsp), %rdx
	movb	$0, 4(%rdx,%rax)
	addq	$1, %rax
	cmpq	%rcx, %rax
	jne	.L1546
.L1545:
	movq	120(%rsp), %rax
	xorl	%ebp, %ebp
	leaq	64+math_prime_util__sieve__wheel(%rip), %r13
	movabsq	$-8608480567731124087, %r15
	movb	$1, 4(%rax)
	movq	%r12, %rax
	mulq	%r15
	shrq	$4, %rdx
	leaq	1(%rdx), %r14
	imulq	$30, %r14, %rax
	leaq	math_prime_util__sieve__masks(%rip), %r14
	movq	%rax, 8(%rsp)
	.p2align 4
	.p2align 3
.L1552:
	leaq	math_prime_util__sieve__wheel(%rip), %rbx
	.p2align 4
	.p2align 3
.L1548:
	movq	(%rbx), %rcx
	addq	%rbp, %rcx
	cmpq	$6, %rcx
	seta	%dl
	cmpq	%rcx, %r12
	setnb	%al
	testb	%al, %dl
	je	.L1550
	movq	%rcx, %rax
	mulq	%r15
	movq	%rcx, %rax
	shrq	$4, %rdx
	imulq	$30, %rdx, %rsi
	subq	%rsi, %rax
	movzbl	(%r14,%rax), %eax
	testb	%al, %al
	je	.L1550
	movabsq	$64424509439, %rdi
	cmpq	%rcx, %rdi
	jb	.L1599
	movq	120(%rsp), %rsi
	testb	%al, 4(%rsi,%rdx)
	jne	.L1550
	movq	(%rsp), %rdx
	xorl	%esi, %esi
	leaq	112(%rsp), %rdi
	call	math_prime_util__sieve__mark
	.p2align 4
	.p2align 3
.L1550:
	addq	$8, %rbx
	cmpq	%rbx, %r13
	jne	.L1548
	addq	$30, %rbp
	cmpq	%rbp, 8(%rsp)
	jne	.L1552
	movdqa	112(%rsp), %xmm0
	leaq	32+math_prime_util__sieve__byte_vectors__vectorT(%rip), %rax
	leaq	48(%rsp), %rdi
	movaps	%xmm0, 48(%rsp)
	movdqa	128(%rsp), %xmm0
	movq	%rax, 48(%rsp)
	movaps	%xmm0, 64(%rsp)
	call	math_prime_util__sieve__byte_vectors__adjust__2Xn
.LEHE73:
	leaq	16(%rsp), %rbx
.LEHB74:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %r12d
	call	*system__soft_links__abort_defer(%rip)
.LEHE74:
	leaq	math_prime_util__sieve__byte_vectors__vectorFDXn(%rip), %rsi
	leaq	80(%rsp), %rdi
.LEHB75:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE75:
.LEHB76:
	call	*system__soft_links__abort_undefer(%rip)
.L1553:
	leaq	16(%rsp), %rbx
	leaq	math_prime_util__sieve__byte_vectors__vectorFDXn(%rip), %rsi
	movq	%rbx, %rdx
	leaq	48(%rsp), %rdi
	call	system__finalization_primitives__attach_object_to_node@PLT
.LEHE76:
.LEHB77:
	call	*system__soft_links__abort_defer(%rip)
	leaq	48(%rsp), %rsi
	leaq	8+math_prime_util__sieve__cache(%rip), %rdi
	call	math_prime_util__sieve__byte_vectors___assign__2Xn
.LEHE77:
.LEHB78:
	call	*system__soft_links__abort_undefer(%rip)
.LEHE78:
.LEHB79:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebp
	call	*system__soft_links__abort_defer(%rip)
.LEHE79:
	leaq	math_prime_util__sieve__byte_vectors__vectorFDXn(%rip), %rsi
	movq	%rbx, %rdi
.LEHB80:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE80:
.LEHB81:
	call	*system__soft_links__abort_undefer(%rip)
.LEHE81:
.L1564:
	movq	(%rsp), %rax
	movq	152(%rsp), %rbx
	.cfi_restore 3
	movq	160(%rsp), %rbp
	.cfi_restore 6
	movq	168(%rsp), %r12
	.cfi_restore 12
	movq	%rax, math_prime_util__sieve__cache(%rip)
	movq	176(%rsp), %r13
	.cfi_restore 13
	movq	184(%rsp), %r14
	.cfi_restore 14
	movq	192(%rsp), %r15
	.cfi_restore 15
.L1541:
	addq	$200, %rsp
	.cfi_def_cfa_offset 8
	ret
.L1599:
	.cfi_def_cfa_offset 208
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	$20, %esi
	leaq	.LC13(%rip), %rdi
.LEHB82:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1598:
	movl	$58, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE82:
.L1590:
	jmp	.L1591
.L1576:
	movq	%rax, %rbp
	jmp	.L1559
.L1575:
	movq	%rax, %rbp
	jmp	.L1568
.L1579:
	movq	%rax, %rbx
	jmp	.L1565
.L1577:
	movq	%rax, %rbp
	jmp	.L1554
	.section	.gcc_except_table
	.align 4
.LLSDA699:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT699-.LLSDATTD699
.LLSDATTD699:
	.byte	0x1
	.uleb128 .LLSDACSE699-.LLSDACSB699
.LLSDACSB699:
	.uleb128 .LEHB73-.LFB699
	.uleb128 .LEHE73-.LEHB73
	.uleb128 .L1576-.LFB699
	.uleb128 0
	.uleb128 .LEHB74-.LFB699
	.uleb128 .LEHE74-.LEHB74
	.uleb128 .L1590-.LFB699
	.uleb128 0
	.uleb128 .LEHB75-.LFB699
	.uleb128 .LEHE75-.LEHB75
	.uleb128 .L1577-.LFB699
	.uleb128 0x3
	.uleb128 .LEHB76-.LFB699
	.uleb128 .LEHE76-.LEHB76
	.uleb128 .L1590-.LFB699
	.uleb128 0
	.uleb128 .LEHB77-.LFB699
	.uleb128 .LEHE77-.LEHB77
	.uleb128 .L1575-.LFB699
	.uleb128 0
	.uleb128 .LEHB78-.LFB699
	.uleb128 .LEHE78-.LEHB78
	.uleb128 .L1590-.LFB699
	.uleb128 0
	.uleb128 .LEHB79-.LFB699
	.uleb128 .LEHE79-.LEHB79
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB80-.LFB699
	.uleb128 .LEHE80-.LEHB80
	.uleb128 .L1579-.LFB699
	.uleb128 0x5
	.uleb128 .LEHB81-.LFB699
	.uleb128 .LEHE81-.LEHB81
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB82-.LFB699
	.uleb128 .LEHE82-.LEHB82
	.uleb128 .L1576-.LFB699
	.uleb128 0
.LLSDACSE699:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.byte	0x2
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
	.long	DW.ref.__gnat_others_value-.
.LLSDATT699:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC699
	.type	math_prime_util__sieve__cache__ensureN.constprop.0.cold, @function
math_prime_util__sieve__cache__ensureN.constprop.0.cold:
.LFSB699:
	nop
.L1574:
	.cfi_def_cfa_offset 208
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
.L1591:
	movq	%rax, %rbp
	jmp	.L1556
.L1559:
	leaq	16(%rsp), %rbx
.LEHB83:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %r12d
	call	*system__soft_links__abort_defer(%rip)
.LEHE83:
	leaq	math_prime_util__sieve__byte_vectors__vectorFDXn(%rip), %rsi
	leaq	80(%rsp), %rdi
.LEHB84:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE84:
	xorl	%r13d, %r13d
.L1563:
	leaq	16(%rsp), %rbx
.LEHB85:
	call	*system__soft_links__abort_undefer(%rip)
	xorl	$1, %r12d
	testb	%r13b, %r12b
	je	.L1560
	movl	$53, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1568:
	call	*system__soft_links__abort_undefer(%rip)
.LEHE85:
.L1556:
.LEHB86:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %r12d
	call	*system__soft_links__abort_defer(%rip)
.LEHE86:
	leaq	math_prime_util__sieve__byte_vectors__vectorFDXn(%rip), %rsi
	movq	%rbx, %rdi
.LEHB87:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE87:
	xorl	%ebx, %ebx
.L1572:
.LEHB88:
	call	*system__soft_links__abort_undefer(%rip)
	xorl	$1, %r12d
	testb	%bl, %r12b
	je	.L1596
.L1567:
	movl	$88, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1565:
	movq	%rax, %rdi
	cmpq	$2, %rdx
	jne	.L1600
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	call	*system__soft_links__abort_undefer(%rip)
	andb	$1, %bpl
	jne	.L1564
	jmp	.L1567
.L1580:
	movq	%rax, %rbx
	movq	%rax, %rdi
	cmpq	$2, %rdx
	jne	.L1601
	call	__gnat_begin_handler_v1@PLT
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movl	$1, %ebx
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	jmp	.L1572
.L1596:
	movq	%rbp, %rdi
	call	_Unwind_Resume@PLT
.LEHE88:
.L1554:
	subq	$1, %rdx
	jne	.L1560
	movq	%rax, %rdi
	leaq	16(%rsp), %rbx
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbp, %rdi
	movq	%rax, %rsi
.LEHB89:
	call	__gnat_end_handler_v1@PLT
	leaq	16(%rsp), %rbx
	call	*system__soft_links__abort_undefer(%rip)
	andb	$1, %r12b
	jne	.L1553
	movl	$53, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.LEHE89:
.L1560:
	leaq	16(%rsp), %rbx
	jmp	.L1556
.L1600:
.LEHB90:
	call	_Unwind_Resume@PLT
.L1601:
	call	_Unwind_Resume@PLT
.LEHE90:
.L1578:
	subq	$1, %rdx
	movq	%rax, %r13
	jne	.L1602
	movq	%rax, %rdi
	leaq	16(%rsp), %rbx
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%r13, %rdi
	movq	%rax, %rsi
.LEHB91:
	call	__gnat_end_handler_v1@PLT
.LEHE91:
	movl	$1, %r13d
	jmp	.L1563
.L1602:
	movq	%rax, %rbp
	leaq	16(%rsp), %rbx
	jmp	.L1556
	.cfi_endproc
.LFE699:
	.section	.gcc_except_table
	.align 4
.LLSDAC699:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC699-.LLSDATTDC699
.LLSDATTDC699:
	.byte	0x1
	.uleb128 .LLSDACSEC699-.LLSDACSBC699
.LLSDACSBC699:
	.uleb128 .LEHB83-.LCOLDB40
	.uleb128 .LEHE83-.LEHB83
	.uleb128 .L1574-.LCOLDB40
	.uleb128 0
	.uleb128 .LEHB84-.LCOLDB40
	.uleb128 .LEHE84-.LEHB84
	.uleb128 .L1578-.LCOLDB40
	.uleb128 0x3
	.uleb128 .LEHB85-.LCOLDB40
	.uleb128 .LEHE85-.LEHB85
	.uleb128 .L1574-.LCOLDB40
	.uleb128 0
	.uleb128 .LEHB86-.LCOLDB40
	.uleb128 .LEHE86-.LEHB86
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB87-.LCOLDB40
	.uleb128 .LEHE87-.LEHB87
	.uleb128 .L1580-.LCOLDB40
	.uleb128 0x5
	.uleb128 .LEHB88-.LCOLDB40
	.uleb128 .LEHE88-.LEHB88
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB89-.LCOLDB40
	.uleb128 .LEHE89-.LEHB89
	.uleb128 .L1574-.LCOLDB40
	.uleb128 0
	.uleb128 .LEHB90-.LCOLDB40
	.uleb128 .LEHE90-.LEHB90
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB91-.LCOLDB40
	.uleb128 .LEHE91-.LEHB91
	.uleb128 .L1574-.LCOLDB40
	.uleb128 0
.LLSDACSEC699:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.byte	0x2
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC699:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__cache__ensureN.constprop.0, .-math_prime_util__sieve__cache__ensureN.constprop.0
	.section	.text.unlikely
	.size	math_prime_util__sieve__cache__ensureN.constprop.0.cold, .-math_prime_util__sieve__cache__ensureN.constprop.0.cold
.LCOLDE40:
	.text
.LHOTE40:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__vectorDA__2
	.type	math_prime_util__sieve__prime_vectors__vectorDA__2, @function
math_prime_util__sieve__prime_vectors__vectorDA__2:
.LFB158:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -32
	movl	16(%rdi), %ebp
	cmpl	$-1, %ebp
	je	.L1607
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
.L1607:
	.cfi_def_cfa_offset 64
	movq	$0, 8(%rdi)
	movq	32(%rsp), %rbp
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE158:
	.size	math_prime_util__sieve__prime_vectors__vectorDA__2, .-math_prime_util__sieve__prime_vectors__vectorDA__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__append__2
	.type	math_prime_util__sieve__prime_vectors__append__2, @function
math_prime_util__sieve__prime_vectors__append__2:
.LFB25:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rsi, %rax
	cmpl	$1, %edx
	je	.L1622
	testl	%edx, %edx
	je	.L1608
	movl	16(%rdi), %esi
	cmpl	$2147483647, %esi
	je	.L1623
	movl	%edx, %ecx
	addl	$1, %esi
	movq	%rax, %rdx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__sieve__prime_vectors__insert__4
	.p2align 4,,10
	.p2align 3
.L1622:
	.cfi_restore_state
	movq	8(%rdi), %rdx
	movl	16(%rdi), %esi
	testq	%rdx, %rdx
	je	.L1610
	cmpl	(%rdx), %esi
	je	.L1610
	cmpl	$2147483647, %esi
	je	.L1624
	addl	$1, %esi
	movslq	%esi, %rcx
	movq	%rax, 8(%rdx,%rcx,8)
	movl	%esi, 16(%rdi)
.L1608:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1610:
	.cfi_restore_state
	cmpl	$2147483647, %esi
	je	.L1625
	addl	$1, %esi
	movl	$1, %ecx
	movq	%rax, %rdx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__sieve__prime_vectors__insert__4
.L1623:
	.cfi_restore_state
	call	math_prime_util__sieve__prime_vectors__append_slow_path.part.0
.L1625:
	movl	$229, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1624:
	movl	$223, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE25:
	.size	math_prime_util__sieve__prime_vectors__append__2, .-math_prime_util__sieve__prime_vectors__append__2
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__busy
	.type	math_prime_util__sieve__prime_vectors__implementation__busy, @function
math_prime_util__sieve__prime_vectors__implementation__busy:
.LFB536:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE536:
	.size	math_prime_util__sieve__prime_vectors__implementation__busy, .-math_prime_util__sieve__prime_vectors__implementation__busy
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__lock
	.type	math_prime_util__sieve__prime_vectors__implementation__lock, @function
math_prime_util__sieve__prime_vectors__implementation__lock:
.LFB540:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE540:
	.size	math_prime_util__sieve__prime_vectors__implementation__lock, .-math_prime_util__sieve__prime_vectors__implementation__lock
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__tc_check
	.type	math_prime_util__sieve__prime_vectors__implementation__tc_check, @function
math_prime_util__sieve__prime_vectors__implementation__tc_check:
.LFB544:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE544:
	.size	math_prime_util__sieve__prime_vectors__implementation__tc_check, .-math_prime_util__sieve__prime_vectors__implementation__tc_check
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__te_check
	.type	math_prime_util__sieve__prime_vectors__implementation__te_check, @function
math_prime_util__sieve__prime_vectors__implementation__te_check:
.LFB546:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE546:
	.size	math_prime_util__sieve__prime_vectors__implementation__te_check, .-math_prime_util__sieve__prime_vectors__implementation__te_check
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__unbusy
	.type	math_prime_util__sieve__prime_vectors__implementation__unbusy, @function
math_prime_util__sieve__prime_vectors__implementation__unbusy:
.LFB538:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE538:
	.size	math_prime_util__sieve__prime_vectors__implementation__unbusy, .-math_prime_util__sieve__prime_vectors__implementation__unbusy
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__unlock
	.type	math_prime_util__sieve__prime_vectors__implementation__unlock, @function
math_prime_util__sieve__prime_vectors__implementation__unlock:
.LFB542:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE542:
	.size	math_prime_util__sieve__prime_vectors__implementation__unlock, .-math_prime_util__sieve__prime_vectors__implementation__unlock
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__implementation__zero_counts
	.type	math_prime_util__sieve__prime_vectors__implementation__zero_counts, @function
math_prime_util__sieve__prime_vectors__implementation__zero_counts:
.LFB14:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE14:
	.size	math_prime_util__sieve__prime_vectors__implementation__zero_counts, .-math_prime_util__sieve__prime_vectors__implementation__zero_counts
	.section	.text.unlikely
	.align 2
.LCOLDB41:
	.text
.LHOTB41:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__Oconcat
	.type	math_prime_util__sieve__prime_vectors__Oconcat, @function
math_prime_util__sieve__prime_vectors__Oconcat:
.LFB15:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA15
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	%rsp, %rdx
	movq	$0, (%rsp)
	movq	%rax, 24(%rsp)
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
.LEHB92:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movl	$-1, 16(%rbx)
	leaq	32+math_prime_util__sieve__prime_vectors__vectorT(%rip), %rax
	movq	%rax, %xmm0
	xorl	%eax, %eax
	movups	%xmm0, (%rbx)
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	16(%rbp), %esi
	cmpl	$2147483647, %esi
	je	.L1653
	movl	16(%r12), %eax
	cmpl	$2147483647, %eax
	je	.L1654
	addl	$1, %esi
	addl	$1, %eax
	addl	%eax, %esi
	jo	.L1637
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__reserve_capacity
	movl	16(%rbp), %edx
	testl	%edx, %edx
	js	.L1643
	movl	16(%rbx), %esi
	cmpl	$2147483647, %esi
	je	.L1655
	addl	$1, %esi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__insert_vector
.L1643:
	movl	16(%r12), %eax
	testl	%eax, %eax
	js	.L1640
	movl	16(%rbx), %esi
	cmpl	$2147483647, %esi
	je	.L1656
	addl	$1, %esi
	movq	%r12, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__insert_vector
.L1640:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE92:
.LEHB93:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE93:
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L1637:
	.cfi_restore_state
	movl	$66, %esi
	leaq	.LC14(%rip), %rdi
.LEHB94:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1654:
	call	math_prime_util__sieve__prime_vectors__length.part.0
.L1653:
	call	math_prime_util__sieve__prime_vectors__length.part.0
.L1656:
	movl	$197, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1655:
	movl	$197, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE94:
.L1647:
	movq	%rax, %rbx
	jmp	.L1646
	.section	.gcc_except_table
.LLSDA15:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE15-.LLSDACSB15
.LLSDACSB15:
	.uleb128 .LEHB92-.LFB15
	.uleb128 .LEHE92-.LEHB92
	.uleb128 .L1647-.LFB15
	.uleb128 0
	.uleb128 .LEHB93-.LFB15
	.uleb128 .LEHE93-.LEHB93
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB94-.LFB15
	.uleb128 .LEHE94-.LEHB94
	.uleb128 .L1647-.LFB15
	.uleb128 0
.LLSDACSE15:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC15
	.type	math_prime_util__sieve__prime_vectors__Oconcat.cold, @function
math_prime_util__sieve__prime_vectors__Oconcat.cold:
.LFSB15:
.L1646:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	%rsp, %r10
.LEHB95:
	call	math_prime_util__sieve__prime_vectors__Oconcat__R770s___finalizer.0
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE95:
	.cfi_endproc
.LFE15:
	.section	.gcc_except_table
.LLSDAC15:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC15-.LLSDACSBC15
.LLSDACSBC15:
	.uleb128 .LEHB95-.LCOLDB41
	.uleb128 .LEHE95-.LEHB95
	.uleb128 0
	.uleb128 0
.LLSDACSEC15:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__Oconcat, .-math_prime_util__sieve__prime_vectors__Oconcat
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__Oconcat.cold, .-math_prime_util__sieve__prime_vectors__Oconcat.cold
.LCOLDE41:
	.text
.LHOTE41:
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T376s, @function
math_prime_util__sieve__prime_vectors__T376s:
.LFB186:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movl	$32, %edi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__sieve__prime_vectors__Oconcat
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE186:
	.size	math_prime_util__sieve__prime_vectors__T376s, .-math_prime_util__sieve__prime_vectors__T376s
	.section	.text.unlikely
	.align 2
.LCOLDB42:
	.text
.LHOTB42:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__Oconcat__2
	.type	math_prime_util__sieve__prime_vectors__Oconcat__2, @function
math_prime_util__sieve__prime_vectors__Oconcat__2:
.LFB17:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA17
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	%rsp, %rdx
	movq	$0, (%rsp)
	movq	%rax, 24(%rsp)
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
.LEHB96:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movl	$-1, 16(%rbx)
	leaq	32+math_prime_util__sieve__prime_vectors__vectorT(%rip), %rax
	movq	%rax, %xmm0
	xorl	%eax, %eax
	movups	%xmm0, (%rbx)
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	16(%r12), %esi
	cmpl	$2147483647, %esi
	je	.L1676
	cmpl	$2147483646, %esi
	je	.L1677
	addl	$2, %esi
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__reserve_capacity
	movl	16(%r12), %eax
	testl	%eax, %eax
	js	.L1662
	movl	16(%rbx), %esi
	cmpl	$2147483647, %esi
	je	.L1678
	addl	$1, %esi
	movq	%r12, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__insert_vector
.L1662:
	movq	8(%rbx), %rax
	movl	16(%rbx), %esi
	testq	%rax, %rax
	je	.L1664
	cmpl	(%rax), %esi
	je	.L1664
	cmpl	$2147483647, %esi
	je	.L1679
	addl	$1, %esi
	movslq	%esi, %rdx
	movq	%rbp, 8(%rax,%rdx,8)
	movl	%esi, 16(%rbx)
	jmp	.L1666
	.p2align 4,,10
	.p2align 3
.L1664:
	cmpl	$2147483647, %esi
	je	.L1680
	addl	$1, %esi
	movl	$1, %ecx
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__insert__4
.L1666:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE96:
.LEHB97:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE97:
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L1677:
	.cfi_restore_state
	movl	$75, %esi
	leaq	.LC14(%rip), %rdi
.LEHB98:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1676:
	call	math_prime_util__sieve__prime_vectors__length.part.0
.L1678:
	movl	$197, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1680:
	movl	$229, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1679:
	movl	$223, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE98:
.L1669:
	movq	%rax, %rbx
	jmp	.L1668
	.section	.gcc_except_table
.LLSDA17:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE17-.LLSDACSB17
.LLSDACSB17:
	.uleb128 .LEHB96-.LFB17
	.uleb128 .LEHE96-.LEHB96
	.uleb128 .L1669-.LFB17
	.uleb128 0
	.uleb128 .LEHB97-.LFB17
	.uleb128 .LEHE97-.LEHB97
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB98-.LFB17
	.uleb128 .LEHE98-.LEHB98
	.uleb128 .L1669-.LFB17
	.uleb128 0
.LLSDACSE17:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC17
	.type	math_prime_util__sieve__prime_vectors__Oconcat__2.cold, @function
math_prime_util__sieve__prime_vectors__Oconcat__2.cold:
.LFSB17:
.L1668:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	%rsp, %r10
.LEHB99:
	call	math_prime_util__sieve__prime_vectors__Oconcat__R779s___finalizer__2.1
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE99:
	.cfi_endproc
.LFE17:
	.section	.gcc_except_table
.LLSDAC17:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC17-.LLSDACSBC17
.LLSDACSBC17:
	.uleb128 .LEHB99-.LCOLDB42
	.uleb128 .LEHE99-.LEHB99
	.uleb128 0
	.uleb128 0
.LLSDACSEC17:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__Oconcat__2, .-math_prime_util__sieve__prime_vectors__Oconcat__2
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__Oconcat__2.cold, .-math_prime_util__sieve__prime_vectors__Oconcat__2.cold
.LCOLDE42:
	.text
.LHOTE42:
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T377s, @function
math_prime_util__sieve__prime_vectors__T377s:
.LFB187:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movl	$32, %edi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__sieve__prime_vectors__Oconcat__2
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE187:
	.size	math_prime_util__sieve__prime_vectors__T377s, .-math_prime_util__sieve__prime_vectors__T377s
	.section	.text.unlikely
	.align 2
.LCOLDB43:
	.text
.LHOTB43:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__Oconcat__3
	.type	math_prime_util__sieve__prime_vectors__Oconcat__3, @function
math_prime_util__sieve__prime_vectors__Oconcat__3:
.LFB19:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA19
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	%rsp, %rdx
	movq	$0, (%rsp)
	movq	%rax, 24(%rsp)
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
.LEHB100:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movl	$-1, 16(%rbx)
	leaq	32+math_prime_util__sieve__prime_vectors__vectorT(%rip), %rax
	movq	%rax, %xmm0
	xorl	%eax, %eax
	movups	%xmm0, (%rbx)
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	16(%rbp), %esi
	cmpl	$2147483647, %esi
	je	.L1700
	cmpl	$2147483646, %esi
	je	.L1701
	addl	$2, %esi
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__reserve_capacity
	movq	8(%rbx), %rax
	movl	16(%rbx), %esi
	testq	%rax, %rax
	je	.L1686
	cmpl	(%rax), %esi
	je	.L1686
	cmpl	$2147483647, %esi
	je	.L1702
	addl	$1, %esi
	movslq	%esi, %rdx
	movq	%r12, 8(%rax,%rdx,8)
	movl	%esi, 16(%rbx)
	jmp	.L1688
	.p2align 4,,10
	.p2align 3
.L1686:
	cmpl	$2147483647, %esi
	je	.L1703
	addl	$1, %esi
	movl	$1, %ecx
	movq	%r12, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__insert__4
.L1688:
	movl	16(%rbp), %eax
	testl	%eax, %eax
	js	.L1690
	movl	16(%rbx), %esi
	cmpl	$2147483647, %esi
	je	.L1704
	addl	$1, %esi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__insert_vector
.L1690:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE100:
.LEHB101:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE101:
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L1701:
	.cfi_restore_state
	movl	$84, %esi
	leaq	.LC14(%rip), %rdi
.LEHB102:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1700:
	call	math_prime_util__sieve__prime_vectors__length.part.0
.L1704:
	movl	$197, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1703:
	movl	$229, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1702:
	movl	$223, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE102:
.L1693:
	movq	%rax, %rbx
	jmp	.L1692
	.section	.gcc_except_table
.LLSDA19:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE19-.LLSDACSB19
.LLSDACSB19:
	.uleb128 .LEHB100-.LFB19
	.uleb128 .LEHE100-.LEHB100
	.uleb128 .L1693-.LFB19
	.uleb128 0
	.uleb128 .LEHB101-.LFB19
	.uleb128 .LEHE101-.LEHB101
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB102-.LFB19
	.uleb128 .LEHE102-.LEHB102
	.uleb128 .L1693-.LFB19
	.uleb128 0
.LLSDACSE19:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC19
	.type	math_prime_util__sieve__prime_vectors__Oconcat__3.cold, @function
math_prime_util__sieve__prime_vectors__Oconcat__3.cold:
.LFSB19:
.L1692:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	%rsp, %r10
.LEHB103:
	call	math_prime_util__sieve__prime_vectors__Oconcat__R788s___finalizer__3.2
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE103:
	.cfi_endproc
.LFE19:
	.section	.gcc_except_table
.LLSDAC19:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC19-.LLSDACSBC19
.LLSDACSBC19:
	.uleb128 .LEHB103-.LCOLDB43
	.uleb128 .LEHE103-.LEHB103
	.uleb128 0
	.uleb128 0
.LLSDACSEC19:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__Oconcat__3, .-math_prime_util__sieve__prime_vectors__Oconcat__3
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__Oconcat__3.cold, .-math_prime_util__sieve__prime_vectors__Oconcat__3.cold
.LCOLDE43:
	.text
.LHOTE43:
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T378s, @function
math_prime_util__sieve__prime_vectors__T378s:
.LFB188:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movl	$32, %edi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__sieve__prime_vectors__Oconcat__3
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE188:
	.size	math_prime_util__sieve__prime_vectors__T378s, .-math_prime_util__sieve__prime_vectors__T378s
	.section	.text.unlikely
	.align 2
.LCOLDB44:
	.text
.LHOTB44:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__Oconcat__4
	.type	math_prime_util__sieve__prime_vectors__Oconcat__4, @function
math_prime_util__sieve__prime_vectors__Oconcat__4:
.LFB21:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA21
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	%rsp, %rdx
	movq	$0, (%rsp)
	movq	%rax, 24(%rsp)
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
.LEHB104:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movl	$-1, 16(%rbx)
	leaq	32+math_prime_util__sieve__prime_vectors__vectorT(%rip), %rax
	movq	%rax, %xmm0
	xorl	%eax, %eax
	movups	%xmm0, (%rbx)
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	$2, %esi
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__reserve_capacity
	movq	8(%rbx), %rax
	movl	16(%rbx), %esi
	testq	%rax, %rax
	je	.L1708
	cmpl	(%rax), %esi
	je	.L1708
	cmpl	$2147483647, %esi
	je	.L1727
	addl	$1, %esi
	movslq	%esi, %rdx
	movq	%r12, 8(%rax,%rdx,8)
	movq	8(%rbx), %rax
	movl	%esi, 16(%rbx)
	testq	%rax, %rax
	jne	.L1728
.L1712:
	cmpl	$2147483647, %esi
	je	.L1729
	addl	$1, %esi
	movl	$1, %ecx
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__insert__4
.L1714:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE104:
.LEHB105:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE105:
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1708:
	.cfi_restore_state
	cmpl	$2147483647, %esi
	je	.L1730
	addl	$1, %esi
	movl	$1, %ecx
	movq	%r12, %rdx
	movq	%rbx, %rdi
.LEHB106:
	call	math_prime_util__sieve__prime_vectors__insert__4
	movq	8(%rbx), %rax
	movl	16(%rbx), %esi
	testq	%rax, %rax
	je	.L1712
.L1728:
	cmpl	(%rax), %esi
	je	.L1712
	cmpl	$2147483647, %esi
	je	.L1731
	addl	$1, %esi
	movslq	%esi, %rdx
	movq	%rbp, 8(%rax,%rdx,8)
	movl	%esi, 16(%rbx)
	jmp	.L1714
.L1731:
	movl	$223, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1727:
	movl	$223, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1730:
	movl	$229, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1729:
	movl	$229, %esi
	leaq	.LC14(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE106:
.L1717:
	movq	%rax, %rbx
	jmp	.L1716
	.section	.gcc_except_table
.LLSDA21:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE21-.LLSDACSB21
.LLSDACSB21:
	.uleb128 .LEHB104-.LFB21
	.uleb128 .LEHE104-.LEHB104
	.uleb128 .L1717-.LFB21
	.uleb128 0
	.uleb128 .LEHB105-.LFB21
	.uleb128 .LEHE105-.LEHB105
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB106-.LFB21
	.uleb128 .LEHE106-.LEHB106
	.uleb128 .L1717-.LFB21
	.uleb128 0
.LLSDACSE21:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC21
	.type	math_prime_util__sieve__prime_vectors__Oconcat__4.cold, @function
math_prime_util__sieve__prime_vectors__Oconcat__4.cold:
.LFSB21:
.L1716:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	%rsp, %r10
.LEHB107:
	call	math_prime_util__sieve__prime_vectors__Oconcat__R797s___finalizer__4.3
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE107:
	.cfi_endproc
.LFE21:
	.section	.gcc_except_table
.LLSDAC21:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC21-.LLSDACSBC21
.LLSDACSBC21:
	.uleb128 .LEHB107-.LCOLDB44
	.uleb128 .LEHE107-.LEHB107
	.uleb128 0
	.uleb128 0
.LLSDACSEC21:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__Oconcat__4, .-math_prime_util__sieve__prime_vectors__Oconcat__4
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__Oconcat__4.cold, .-math_prime_util__sieve__prime_vectors__Oconcat__4.cold
.LCOLDE44:
	.text
.LHOTE44:
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T379s, @function
math_prime_util__sieve__prime_vectors__T379s:
.LFB189:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movl	$32, %edi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__sieve__prime_vectors__Oconcat__4
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE189:
	.size	math_prime_util__sieve__prime_vectors__T379s, .-math_prime_util__sieve__prime_vectors__T379s
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__append_slow_path
	.type	math_prime_util__sieve__prime_vectors__append_slow_path, @function
math_prime_util__sieve__prime_vectors__append_slow_path:
.LFB28:
	.cfi_startproc
	testl	%edx, %edx
	je	.L1734
	movq	%rsi, %rax
	movl	16(%rdi), %esi
	cmpl	$2147483647, %esi
	je	.L1740
	movl	%edx, %ecx
	addl	$1, %esi
	movq	%rax, %rdx
	jmp	math_prime_util__sieve__prime_vectors__insert__4
	.p2align 4,,10
	.p2align 3
.L1734:
	ret
.L1740:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__sieve__prime_vectors__append_slow_path.part.0
	.cfi_endproc
.LFE28:
	.size	math_prime_util__sieve__prime_vectors__append_slow_path, .-math_prime_util__sieve__prime_vectors__append_slow_path
	.section	.text.unlikely
	.align 2
.LCOLDB45:
	.text
.LHOTB45:
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__copy
	.type	math_prime_util__sieve__prime_vectors__copy, @function
math_prime_util__sieve__prime_vectors__copy:
.LFB35:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA35
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	%rax, 24(%rsp)
	movl	16(%rsi), %eax
	cmpl	$2147483647, %eax
	je	.L1751
	addl	$1, %eax
	movq	%rsi, %r12
	movq	%rdi, %rbx
	movq	$0, (%rsp)
	cmpl	%edx, %eax
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
	cmovge	%eax, %edx
	movl	%edx, %ebp
	movq	%rsp, %rdx
.LEHB108:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movl	$-1, 16(%rbx)
	leaq	32+math_prime_util__sieve__prime_vectors__vectorT(%rip), %rax
	movq	%rax, %xmm0
	xorl	%eax, %eax
	movups	%xmm0, (%rbx)
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	%ebp, %esi
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__reserve_capacity
	cmpq	%rbx, %r12
	je	.L1745
	movl	$-1, 16(%rbx)
	movl	16(%r12), %eax
	testl	%eax, %eax
	js	.L1745
	movq	%r12, %rdx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	math_prime_util__sieve__prime_vectors__insert_vector
.L1745:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE108:
.LEHB109:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__sieve__prime_vectors__vectorFD(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L1751:
	.cfi_restore_state
	call	math_prime_util__sieve__prime_vectors__length.part.0
.LEHE109:
.L1747:
	movq	%rax, %rbx
	jmp	.L1746
	.section	.gcc_except_table
.LLSDA35:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE35-.LLSDACSB35
.LLSDACSB35:
	.uleb128 .LEHB108-.LFB35
	.uleb128 .LEHE108-.LEHB108
	.uleb128 .L1747-.LFB35
	.uleb128 0
	.uleb128 .LEHB109-.LFB35
	.uleb128 .LEHE109-.LEHB109
	.uleb128 0
	.uleb128 0
.LLSDACSE35:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC35
	.type	math_prime_util__sieve__prime_vectors__copy.cold, @function
math_prime_util__sieve__prime_vectors__copy.cold:
.LFSB35:
.L1746:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	%rsp, %r10
.LEHB110:
	call	math_prime_util__sieve__prime_vectors__copy__R867s___finalizer.4
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE110:
	.cfi_endproc
.LFE35:
	.section	.gcc_except_table
.LLSDAC35:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC35-.LLSDACSBC35
.LLSDACSBC35:
	.uleb128 .LEHB110-.LCOLDB45
	.uleb128 .LEHE110-.LEHB110
	.uleb128 0
	.uleb128 0
.LLSDACSEC35:
	.section	.text.unlikely
	.text
	.size	math_prime_util__sieve__prime_vectors__copy, .-math_prime_util__sieve__prime_vectors__copy
	.section	.text.unlikely
	.size	math_prime_util__sieve__prime_vectors__copy.cold, .-math_prime_util__sieve__prime_vectors__copy.cold
.LCOLDE45:
	.text
.LHOTE45:
	.align 2
	.p2align 4
	.type	math_prime_util__sieve__prime_vectors__T380s, @function
math_prime_util__sieve__prime_vectors__T380s:
.LFB190:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%esi, %ebp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movl	$32, %edi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movl	%ebp, %edx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__sieve__prime_vectors__copy
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE190:
	.size	math_prime_util__sieve__prime_vectors__T380s, .-math_prime_util__sieve__prime_vectors__T380s
	.align 2
	.p2align 4
	.globl	math_prime_util__sieve__prime_vectors__element__2
	.type	math_prime_util__sieve__p