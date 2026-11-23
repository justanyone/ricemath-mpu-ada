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
	.set	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B111b___finalizer.152,math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B7s___finalizer.11
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
.LFB487:
	.cfi_startproc
	movq	(%rdi), %rax
	movzbl	%sil, %esi
	addq	-16(%rax), %rdi
	jmp	system__finalization_root__root_controlledDA@PLT
	.cfi_endproc
.LFE487:
	.size	math_prime_util__families__lucky_vectors__T580s, .-math_prime_util__families__lucky_vectors__T580s
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize.96, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize.96:
.LFB206:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L122
	movq	$0, 8(%rdi)
.L122:
	ret
	.cfi_endproc
.LFE206:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize.96, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize.96
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__2.90, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__2.90:
.LFB207:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE207:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__2.90, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__2.90
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__3.83, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__3.83:
.LFB208:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE208:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__3.83, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__finalize__3.83
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__2.91, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__2.91:
.LFB209:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE209:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__2.91, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__2.91
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__3.85, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__3.85:
.LFB210:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE210:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__3.85, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__initialize__3.85
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__clear.66, @function
math_prime_util__families__bitmask_sieve__word_vectors__clear.66:
.LFB233:
	.cfi_startproc
	movl	$-1, 16(%rdi)
	ret
	.cfi_endproc
.LFE233:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__clear.66, .-math_prime_util__families__bitmask_sieve__word_vectors__clear.66
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__constant_reference.164, @function
math_prime_util__families__bitmask_sieve__word_vectors__constant_reference.164:
.LFB234:
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
.LFE234:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__constant_reference.164, .-math_prime_util__families__bitmask_sieve__word_vectors__constant_reference.164
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__constant_reference__2.163, @function
math_prime_util__families__bitmask_sieve__word_vectors__constant_reference__2.163:
.LFB235:
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
.LFE235:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__constant_reference__2.163, .-math_prime_util__families__bitmask_sieve__word_vectors__constant_reference__2.163
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__contains.162, @function
math_prime_util__families__bitmask_sieve__word_vectors__contains.162:
.LFB236:
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
.LFE236:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__contains.162, .-math_prime_util__families__bitmask_sieve__word_vectors__contains.162
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__element.176, @function
math_prime_util__families__bitmask_sieve__word_vectors__element.176:
.LFB243:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movl	4(%rax,%rsi,4), %eax
	ret
	.cfi_endproc
.LFE243:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__element.176, .-math_prime_util__families__bitmask_sieve__word_vectors__element.176
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__finalize__4.26, @function
math_prime_util__families__bitmask_sieve__word_vectors__finalize__4.26:
.LFB248:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE248:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__finalize__4.26, .-math_prime_util__families__bitmask_sieve__word_vectors__finalize__4.26
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__find.161, @function
math_prime_util__families__bitmask_sieve__word_vectors__find.161:
.LFB249:
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
.LFE249:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__find.161, .-math_prime_util__families__bitmask_sieve__word_vectors__find.161
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__find_index.160, @function
math_prime_util__families__bitmask_sieve__word_vectors__find_index.160:
.LFB250:
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
.LFE250:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__find_index.160, .-math_prime_util__families__bitmask_sieve__word_vectors__find_index.160
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__first.37, @function
math_prime_util__families__bitmask_sieve__word_vectors__first.37:
.LFB251:
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
.LFE251:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__first.37, .-math_prime_util__families__bitmask_sieve__word_vectors__first.37
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__first_element.36, @function
math_prime_util__families__bitmask_sieve__word_vectors__first_element.36:
.LFB253:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	4(%rax), %eax
	ret
	.cfi_endproc
.LFE253:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__first_element.36, .-math_prime_util__families__bitmask_sieve__word_vectors__first_element.36
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__is_empty.67, @function
math_prime_util__families__bitmask_sieve__word_vectors__is_empty.67:
.LFB268:
	.cfi_startproc
	movl	16(%rdi), %eax
	shrl	$31, %eax
	ret
	.cfi_endproc
.LFE268:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__is_empty.67, .-math_prime_util__families__bitmask_sieve__word_vectors__is_empty.67
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__iterate.159, @function
math_prime_util__families__bitmask_sieve__word_vectors__iterate.159:
.LFB269:
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
.LFE269:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__iterate.159, .-math_prime_util__families__bitmask_sieve__word_vectors__iterate.159
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__last.35, @function
math_prime_util__families__bitmask_sieve__word_vectors__last.35:
.LFB274:
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
.LFE274:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__last.35, .-math_prime_util__families__bitmask_sieve__word_vectors__last.35
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__last_element.34, @function
math_prime_util__families__bitmask_sieve__word_vectors__last_element.34:
.LFB276:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	16(%rdi), %rdx
	movl	4(%rax,%rdx,4), %eax
	ret
	.cfi_endproc
.LFE276:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__last_element.34, .-math_prime_util__families__bitmask_sieve__word_vectors__last_element.34
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__last_index.175, @function
math_prime_util__families__bitmask_sieve__word_vectors__last_index.175:
.LFB277:
	.cfi_startproc
	movl	16(%rdi), %eax
	ret
	.cfi_endproc
.LFE277:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__last_index.175, .-math_prime_util__families__bitmask_sieve__word_vectors__last_index.175
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__move.62, @function
math_prime_util__families__bitmask_sieve__word_vectors__move.62:
.LFB279:
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
.LFE279:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__move.62, .-math_prime_util__families__bitmask_sieve__word_vectors__move.62
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__query_element.149, @function
math_prime_util__families__bitmask_sieve__word_vectors__query_element.149:
.LFB291:
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
.LFE291:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__query_element.149, .-math_prime_util__families__bitmask_sieve__word_vectors__query_element.149
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reference.148, @function
math_prime_util__families__bitmask_sieve__word_vectors__reference.148:
.LFB297:
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
.LFE297:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reference.148, .-math_prime_util__families__bitmask_sieve__word_vectors__reference.148
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reference__2.147, @function
math_prime_util__families__bitmask_sieve__word_vectors__reference__2.147:
.LFB298:
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
.LFE298:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reference__2.147, .-math_prime_util__families__bitmask_sieve__word_vectors__reference__2.147
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__replace_element.172, @function
math_prime_util__families__bitmask_sieve__word_vectors__replace_element.172:
.LFB299:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movl	%edx, 4(%rax,%rsi,4)
	ret
	.cfi_endproc
.LFE299:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__replace_element.172, .-math_prime_util__families__bitmask_sieve__word_vectors__replace_element.172
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__replace_element__2.64, @function
math_prime_util__families__bitmask_sieve__word_vectors__replace_element__2.64:
.LFB300:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movl	%ecx, 4(%rax,%rdx,4)
	ret
	.cfi_endproc
.LFE300:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__replace_element__2.64, .-math_prime_util__families__bitmask_sieve__word_vectors__replace_element__2.64
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reverse_find.146, @function
math_prime_util__families__bitmask_sieve__word_vectors__reverse_find.146:
.LFB303:
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
.LFE303:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reverse_find.146, .-math_prime_util__families__bitmask_sieve__word_vectors__reverse_find.146
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reverse_find_index.145, @function
math_prime_util__families__bitmask_sieve__word_vectors__reverse_find_index.145:
.LFB304:
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
.LFE304:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reverse_find_index.145, .-math_prime_util__families__bitmask_sieve__word_vectors__reverse_find_index.145
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reverse_iterate.143, @function
math_prime_util__families__bitmask_sieve__word_vectors__reverse_iterate.143:
.LFB305:
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
.LFE305:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reverse_iterate.143, .-math_prime_util__families__bitmask_sieve__word_vectors__reverse_iterate.143
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__swap.39, @function
math_prime_util__families__bitmask_sieve__word_vectors__swap.39:
.LFB307:
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
.LFE307:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__swap.39, .-math_prime_util__families__bitmask_sieve__word_vectors__swap.39
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__to_cursor.65, @function
math_prime_util__families__bitmask_sieve__word_vectors__to_cursor.65:
.LFB309:
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
.LFE309:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__to_cursor.65, .-math_prime_util__families__bitmask_sieve__word_vectors__to_cursor.65
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__update_element.141, @function
math_prime_util__families__bitmask_sieve__word_vectors__update_element.141:
.LFB315:
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
.LFE315:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__update_element.141, .-math_prime_util__families__bitmask_sieve__word_vectors__update_element.141
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__update_element__2.140, @function
math_prime_util__families__bitmask_sieve__word_vectors__update_element__2.140:
.LFB316:
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
.LFE316:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__update_element__2.140, .-math_prime_util__families__bitmask_sieve__word_vectors__update_element__2.140
	.section	.rodata
.LC12:
	.ascii	"math_prime_util-families.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__find.171, @function
math_prime_util__families__bitmask_sieve__find.171:
.LFB402:
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
	movl	$167, %esi
	leaq	.LC12(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L246:
	cmpl	$2147483647, %ecx
	jne	.L249
	movl	$181, %esi
	leaq	.LC12(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L261:
	movl	$170, %esi
	leaq	.LC12(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE402:
	.size	math_prime_util__families__bitmask_sieve__find.171, .-math_prime_util__families__bitmask_sieve__find.171
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0, @function
math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0:
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
	.size	math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0, .-math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__vectorSI__R288s___finalizer__2.15,math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__to_vector__R1466s___finalizer__2.10,math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__to_vector__R1436s___finalizer.9,math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__empty__R899s___finalizer.5,math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__copy__R861s___finalizer.4,math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__Oconcat__R791s___finalizer__4.3,math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__Oconcat__R782s___finalizer__3.2,math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0
	.set	math_prime_util__families__lucky_vectors__Oconcat__R773s___finalizer__2.1,math_prime_util__families__lucky_vectors__Oconcat__R764s___finalizer.0
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126, @function
math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126:
.LFB218:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%r10, %rbx
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbx, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
	.cfi_endproc
.LFE218:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126, .-math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	.set	math_prime_util__families__bitmask_sieve__word_vectors__vectorSI__R473b___finalizer__2.136,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	.set	math_prime_util__families__bitmask_sieve__word_vectors__to_vector__R1774b___finalizer__2.129,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	.set	math_prime_util__families__bitmask_sieve__word_vectors__to_vector__R1744b___finalizer.111,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	.set	math_prime_util__families__bitmask_sieve__word_vectors__empty__R1207b___finalizer.133,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	.set	math_prime_util__families__bitmask_sieve__word_vectors__copy__R1169b___finalizer.114,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	.set	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1099b___finalizer__4.117,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	.set	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1090b___finalizer__3.120,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	.set	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1081b___finalizer__2.123,math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.81, @function
math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.81:
.LFB226:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -32
	movl	16(%rdi), %ebp
	cmpl	$-1, %ebp
	je	.L270
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
.L270:
	.cfi_def_cfa_offset 64
	movq	$0, 8(%rdi)
	movq	32(%rsp), %rbp
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE226:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.81, .-math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.81
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
	je	.L275
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
.L275:
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
.LC13:
	.ascii	"a-convec.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__delete.46, @function
math_prime_util__families__bitmask_sieve__word_vectors__delete.46:
.LFB239:
	.cfi_startproc
	movl	16(%rdi), %eax
	testl	%edx, %edx
	je	.L297
	cmpl	%esi, %eax
	jl	.L297
	movl	%eax, %ecx
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	subl	%esi, %ecx
	jo	.L281
	cmpl	$2147483647, %ecx
	je	.L281
	addl	$1, %ecx
	cmpl	%ecx, %edx
	jge	.L300
	subl	%edx, %eax
	movl	%eax, %ecx
	jo	.L284
	addl	%esi, %edx
	jo	.L301
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
.L297:
	ret
	.p2align 4,,10
	.p2align 3
.L300:
	.cfi_def_cfa_offset 32
	subl	$1, %esi
	movl	%esi, 16(%rdi)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L281:
	.cfi_restore_state
	movl	$460, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L284:
	movl	$484, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L301:
	movl	$485, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE239:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__delete.46, .-math_prime_util__families__bitmask_sieve__word_vectors__delete.46
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__delete__2.45, @function
math_prime_util__families__bitmask_sieve__word_vectors__delete__2.45:
.LFB240:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rdx, %rsi
	movl	%ecx, %edx
	call	math_prime_util__families__bitmask_sieve__word_vectors__delete.46
	xorl	%eax, %eax
	xorl	%edx, %edx
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE240:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__delete__2.45, .-math_prime_util__families__bitmask_sieve__word_vectors__delete__2.45
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__delete
	.type	math_prime_util__families__lucky_vectors__delete, @function
math_prime_util__families__lucky_vectors__delete:
.LFB37:
	.cfi_startproc
	movl	16(%rdi), %eax
	testl	%edx, %edx
	je	.L325
	cmpl	%esi, %eax
	jl	.L325
	movl	%eax, %ecx
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	subl	%esi, %ecx
	jo	.L309
	cmpl	$2147483647, %ecx
	je	.L309
	addl	$1, %ecx
	cmpl	%ecx, %edx
	jge	.L328
	subl	%edx, %eax
	movl	%eax, %ecx
	jo	.L312
	addl	%esi, %edx
	jo	.L329
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
.L325:
	ret
	.p2align 4,,10
	.p2align 3
.L328:
	.cfi_def_cfa_offset 32
	subl	$1, %esi
	movl	%esi, 16(%rdi)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L309:
	.cfi_restore_state
	movl	$460, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L312:
	movl	$484, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L329:
	movl	$485, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE37:
	.size	math_prime_util__families__lucky_vectors__delete, .-math_prime_util__families__lucky_vectors__delete
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__delete__2
	.type	math_prime_util__families__lucky_vectors__delete__2, @function
math_prime_util__families__lucky_vectors__delete__2:
.LFB38:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rdx, %rsi
	movl	%ecx, %edx
	call	math_prime_util__families__lucky_vectors__delete
	xorl	%eax, %eax
	xorl	%edx, %edx
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE38:
	.size	math_prime_util__families__lucky_vectors__delete__2, .-math_prime_util__families__lucky_vectors__delete__2
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__finalize__2.80, @function
math_prime_util__families__bitmask_sieve__word_vectors__finalize__2.80:
.LFB247:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L332
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L332:
	ret
	.cfi_endproc
.LFE247:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__finalize__2.80, .-math_prime_util__families__bitmask_sieve__word_vectors__finalize__2.80
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__finalize__2
	.type	math_prime_util__families__lucky_vectors__finalize__2, @function
math_prime_util__families__lucky_vectors__finalize__2:
.LFB45:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L334
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L334:
	ret
	.cfi_endproc
.LFE45:
	.size	math_prime_util__families__lucky_vectors__finalize__2, .-math_prime_util__families__lucky_vectors__finalize__2
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC14:
	.string	"MATH_PRIME_UTIL.FAMILIES.LUCKY_VECTORS.IMPLEMENTATION.REFERENCE_CONTROL_TYPE"
	.section	.rodata
	.align 8
.LC0:
	.long	1
	.long	76
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__reference_control_typePI
	.type	math_prime_util__families__lucky_vectors__implementation__reference_control_typePI, @function
math_prime_util__families__lucky_vectors__implementation__reference_control_typePI:
.LFB125:
	.cfi_startproc
	leaq	.LC14(%rip), %rsi
	leaq	.LC0(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE125:
	.size	math_prime_util__families__lucky_vectors__implementation__reference_control_typePI, .-math_prime_util__families__lucky_vectors__implementation__reference_control_typePI
	.section	.rodata.str1.8
	.align 8
.LC15:
	.string	"MATH_PRIME_UTIL.FAMILIES.LUCKY_VECTORS.IMPLEMENTATION.WITH_BUSY"
	.section	.rodata
	.align 8
.LC4:
	.long	1
	.long	63
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__with_busyPI
	.type	math_prime_util__families__lucky_vectors__implementation__with_busyPI, @function
math_prime_util__families__lucky_vectors__implementation__with_busyPI:
.LFB137:
	.cfi_startproc
	leaq	.LC15(%rip), %rsi
	leaq	.LC4(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE137:
	.size	math_prime_util__families__lucky_vectors__implementation__with_busyPI, .-math_prime_util__families__lucky_vectors__implementation__with_busyPI
	.section	.rodata.str1.8
	.align 8
.LC16:
	.string	"MATH_PRIME_UTIL.FAMILIES.LUCKY_VECTORS.IMPLEMENTATION.WITH_LOCK"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__with_lockPI
	.type	math_prime_util__families__lucky_vectors__implementation__with_lockPI, @function
math_prime_util__families__lucky_vectors__implementation__with_lockPI:
.LFB143:
	.cfi_startproc
	leaq	.LC16(%rip), %rsi
	leaq	.LC4(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE143:
	.size	math_prime_util__families__lucky_vectors__implementation__with_lockPI, .-math_prime_util__families__lucky_vectors__implementation__with_lockPI
	.section	.rodata.str1.8
	.align 8
.LC17:
	.string	"MATH_PRIME_UTIL.FAMILIES.LUCKY_VECTORS.ITERATOR"
	.section	.rodata
	.align 8
.LC5:
	.long	1
	.long	47
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__iteratorPI__2
	.type	math_prime_util__families__lucky_vectors__iteratorPI__2, @function
math_prime_util__families__lucky_vectors__iteratorPI__2:
.LFB172:
	.cfi_startproc
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE172:
	.size	math_prime_util__families__lucky_vectors__iteratorPI__2, .-math_prime_util__families__lucky_vectors__iteratorPI__2
	.section	.rodata.str1.8
	.align 8
.LC18:
	.string	"MATH_PRIME_UTIL.FAMILIES.BITMASK_SIEVE.WORD_VECTORS.ITERATOR"
	.section	.rodata
	.align 8
.LC7:
	.long	1
	.long	60
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__iteratorPI__2.29, @function
math_prime_util__families__bitmask_sieve__word_vectors__iteratorPI__2.29:
.LFB384:
	.cfi_startproc
	leaq	.LC18(%rip), %rsi
	leaq	.LC7(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE384:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__iteratorPI__2.29, .-math_prime_util__families__bitmask_sieve__word_vectors__iteratorPI__2.29
	.section	.rodata.str1.8
	.align 8
.LC19:
	.string	"MATH_PRIME_UTIL.FAMILIES.BITMASK_SIEVE.WORD_VECTORS.IMPLEMENTATION.WITH_LOCK"
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_lockPI.88, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_lockPI.88:
.LFB346:
	.cfi_startproc
	leaq	.LC19(%rip), %rsi
	leaq	.LC0(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE346:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_lockPI.88, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_lockPI.88
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"MATH_PRIME_UTIL.FAMILIES.BITMASK_SIEVE.WORD_VECTORS.IMPLEMENTATION.WITH_BUSY"
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_busyPI.94, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_busyPI.94:
.LFB340:
	.cfi_startproc
	leaq	.LC20(%rip), %rsi
	leaq	.LC0(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE340:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_busyPI.94, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_busyPI.94
	.section	.rodata.str1.8
	.align 8
.LC21:
	.string	"MATH_PRIME_UTIL.FAMILIES.BITMASK_SIEVE.WORD_VECTORS.IMPLEMENTATION.REFERENCE_CONTROL_TYPE"
	.section	.rodata
	.align 8
.LC8:
	.long	1
	.long	89
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typePI.105, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typePI.105:
.LFB328:
	.cfi_startproc
	leaq	.LC21(%rip), %rsi
	leaq	.LC8(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE328:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typePI.105, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typePI.105
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__reference_control_typeSR
	.type	math_prime_util__families__lucky_vectors__implementation__reference_control_typeSR, @function
math_prime_util__families__lucky_vectors__implementation__reference_control_typeSR:
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
	.size	math_prime_util__families__lucky_vectors__implementation__reference_control_typeSR, .-math_prime_util__families__lucky_vectors__implementation__reference_control_typeSR
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSR.104, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSR.104:
.LFB329:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$5, %eax
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
.LFE329:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSR.104, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSR.104
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__reference_control_typeSW
	.type	math_prime_util__families__lucky_vectors__implementation__reference_control_typeSW, @function
math_prime_util__families__lucky_vectors__implementation__reference_control_typeSW:
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
	.size	math_prime_util__families__lucky_vectors__implementation__reference_control_typeSW, .-math_prime_util__families__lucky_vectors__implementation__reference_control_typeSW
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSW.103, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSW.103:
.LFB330:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$5, %eax
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
.LFE330:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSW.103, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSW.103
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__Oeq__3
	.type	math_prime_util__families__lucky_vectors__implementation__Oeq__3, @function
math_prime_util__families__lucky_vectors__implementation__Oeq__3:
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
	je	.L352
	movq	8(%rbx), %rax
	cmpq	%rax, 8(%rbp)
	sete	%al
.L352:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE130:
	.size	math_prime_util__families__lucky_vectors__implementation__Oeq__3, .-math_prime_util__families__lucky_vectors__implementation__Oeq__3
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__Oeq__3.101, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__Oeq__3.101:
.LFB333:
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
	je	.L358
	movq	8(%rbx), %rax
	cmpq	%rax, 8(%rbp)
	sete	%al
.L358:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE333:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__Oeq__3.101, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__Oeq__3.101
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T712b.30, @function
math_prime_util__families__bitmask_sieve__word_vectors__T712b.30:
.LFB381:
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
	leaq	.LC7(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE381:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T712b.30, .-math_prime_util__families__bitmask_sieve__word_vectors__T712b.30
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T558s, @function
math_prime_util__families__lucky_vectors__T558s:
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
	leaq	.LC17(%rip), %rsi
	leaq	.LC5(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE192:
	.size	math_prime_util__families__lucky_vectors__T558s, .-math_prime_util__families__lucky_vectors__T558s
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T561s, @function
math_prime_util__families__lucky_vectors__T561s:
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
	.size	math_prime_util__families__lucky_vectors__T561s, .-math_prime_util__families__lucky_vectors__T561s
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T564s, @function
math_prime_util__families__lucky_vectors__T564s:
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
	.size	math_prime_util__families__lucky_vectors__T564s, .-math_prime_util__families__lucky_vectors__T564s
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T567s, @function
math_prime_util__families__lucky_vectors__T567s:
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
	.size	math_prime_util__families__lucky_vectors__T567s, .-math_prime_util__families__lucky_vectors__T567s
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T572s, @function
math_prime_util__families__lucky_vectors__T572s:
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
	.size	math_prime_util__families__lucky_vectors__T572s, .-math_prime_util__families__lucky_vectors__T572s
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T577s, @function
math_prime_util__families__lucky_vectors__T577s:
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
	.size	math_prime_util__families__lucky_vectors__T577s, .-math_prime_util__families__lucky_vectors__T577s
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation___assign__3
	.type	math_prime_util__families__lucky_vectors__implementation___assign__3, @function
math_prime_util__families__lucky_vectors__implementation___assign__3:
.LFB131:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L378
	movq	(%rdi), %rax
	movdqu	(%rsi), %xmm0
	movups	%xmm0, (%rdi)
	movq	%rax, (%rdi)
.L378:
	ret
	.cfi_endproc
.LFE131:
	.size	math_prime_util__families__lucky_vectors__implementation___assign__3, .-math_prime_util__families__lucky_vectors__implementation___assign__3
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation___assign__3.100, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation___assign__3.100:
.LFB334:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L380
	movq	(%rdi), %rax
	movdqu	(%rsi), %xmm0
	movups	%xmm0, (%rdi)
	movq	%rax, (%rdi)
.L380:
	ret
	.cfi_endproc
.LFE334:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation___assign__3.100, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation___assign__3.100
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__capacity.part.0, @function
math_prime_util__families__lucky_vectors__capacity.part.0:
.LFB494:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$275, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE494:
	.size	math_prime_util__families__lucky_vectors__capacity.part.0, .-math_prime_util__families__lucky_vectors__capacity.part.0
	.set	math_prime_util__families__bitmask_sieve__word_vectors__capacity.71.part.0,math_prime_util__families__lucky_vectors__capacity.part.0
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__capacity
	.type	math_prime_util__families__lucky_vectors__capacity, @function
math_prime_util__families__lucky_vectors__capacity:
.LFB30:
	.cfi_startproc
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L385
	movl	(%rax), %eax
	testl	%eax, %eax
	js	.L385
	cmpl	$2147483647, %eax
	je	.L386
	addl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L385:
	xorl	%eax, %eax
	ret
.L386:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__lucky_vectors__capacity.part.0
	.cfi_endproc
.LFE30:
	.size	math_prime_util__families__lucky_vectors__capacity, .-math_prime_util__families__lucky_vectors__capacity
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__length.part.0, @function
math_prime_util__families__lucky_vectors__length.part.0:
.LFB495:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$2205, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE495:
	.size	math_prime_util__families__lucky_vectors__length.part.0, .-math_prime_util__families__lucky_vectors__length.part.0
	.set	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0,math_prime_util__families__lucky_vectors__length.part.0
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__length
	.type	math_prime_util__families__lucky_vectors__length, @function
math_prime_util__families__lucky_vectors__length:
.LFB76:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L400
	addl	$1, %eax
	ret
.L400:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__lucky_vectors__length.part.0
	.cfi_endproc
.LFE76:
	.size	math_prime_util__families__lucky_vectors__length, .-math_prime_util__families__lucky_vectors__length
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__write
	.type	math_prime_util__families__lucky_vectors__write, @function
math_prime_util__families__lucky_vectors__write:
.LFB115:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	movl	16(%rsi), %esi
	cmpl	$2147483647, %esi
	je	.L407
	addl	$1, %esi
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	call	system__stream_attributes__w_u@PLT
	movl	16(%rbp), %eax
	testl	%eax, %eax
	js	.L401
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	leaq	1(%rax), %r13
	.p2align 4
	.p2align 3
.L404:
	movq	8(%rbp), %rax
	movq	%r12, %rdi
	movq	8(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	system__stream_attributes__w_lu@PLT
	cmpq	%rbx, %r13
	jne	.L404
	movq	8(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %r13
	.cfi_restore 13
.L401:
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
.L407:
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	movq	%r12, 24(%rsp)
	movq	%r13, 32(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__families__lucky_vectors__length.part.0
	.cfi_endproc
.LFE115:
	.size	math_prime_util__families__lucky_vectors__write, .-math_prime_util__families__lucky_vectors__write
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__vectorSW__2
	.type	math_prime_util__families__lucky_vectors__vectorSW__2, @function
math_prime_util__families__lucky_vectors__vectorSW__2:
.LFB168:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__families__lucky_vectors__write
	.cfi_endproc
.LFE168:
	.size	math_prime_util__families__lucky_vectors__vectorSW__2, .-math_prime_util__families__lucky_vectors__vectorSW__2
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__reverse_elements
	.type	math_prime_util__families__lucky_vectors__reverse_elements, @function
math_prime_util__families__lucky_vectors__reverse_elements:
.LFB100:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L417
	testl	%eax, %eax
	jle	.L409
	movq	8(%rdi), %rcx
	xorl	%edx, %edx
	.p2align 5
	.p2align 4
	.p2align 3
.L412:
	movq	8(%rcx,%rdx,8), %rsi
	movq	8(%rcx,%rax,8), %rdi
	movq	%rdi, 8(%rcx,%rdx,8)
	addq	$1, %rdx
	movq	%rsi, 8(%rcx,%rax,8)
	subq	$1, %rax
	cmpl	%eax, %edx
	jl	.L412
.L409:
	ret
.L417:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__lucky_vectors__length.part.0
	.cfi_endproc
.LFE100:
	.size	math_prime_util__families__lucky_vectors__reverse_elements, .-math_prime_util__families__lucky_vectors__reverse_elements
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__Oeq__2
	.type	math_prime_util__families__lucky_vectors__Oeq__2, @function
math_prime_util__families__lucky_vectors__Oeq__2:
.LFB23:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	16(%rsi), %eax
	jne	.L423
	cmpl	$2147483647, %eax
	je	.L430
	testl	%eax, %eax
	jns	.L422
.L425:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L422:
	leal	1(%rax), %edx
	movq	8(%rsi), %rcx
	xorl	%eax, %eax
	movq	8(%rdi), %rsi
	salq	$3, %rdx
	jmp	.L424
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L431:
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L425
.L424:
	movq	8(%rcx,%rax), %rdi
	cmpq	%rdi, 8(%rsi,%rax)
	je	.L431
.L423:
	xorl	%eax, %eax
	ret
.L430:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__lucky_vectors__length.part.0
	.cfi_endproc
.LFE23:
	.size	math_prime_util__families__lucky_vectors__Oeq__2, .-math_prime_util__families__lucky_vectors__Oeq__2
	.section	.text.unlikely,"ax",@progbits
	.align 2
.LCOLDB22:
	.text
.LHOTB22:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert__4
	.type	math_prime_util__families__lucky_vectors__insert__4, @function
math_prime_util__families__lucky_vectors__insert__4:
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
	je	.L527
	movl	%ecx, %r8d
	testl	%ecx, %ecx
	je	.L432
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
	jo	.L528
	cmpl	$-2147483648, %ecx
	je	.L529
	movq	8(%rdi), %r12
	movq	%rdi, %rbx
	leal	-1(%rcx), %r13d
	testq	%r12, %r12
	je	.L530
	movl	%esi, %r9d
	movl	(%r12), %esi
	testl	%esi, %esi
	js	.L442
	cmpl	$2147483647, %esi
	je	.L443
	leal	1(%rsi), %eax
.L442:
	cmpl	%eax, %ecx
	jle	.L531
	testl	%eax, %eax
	movl	$1, %edx
	cmovle	%edx, %eax
	cmpl	%eax, %ecx
	jg	.L456
	jmp	.L453
	.p2align 4,,10
	.p2align 3
.L534:
	cmpl	$-1073741824, %eax
	js	.L532
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L533
.L456:
	cmpl	$1073741823, %eax
	jle	.L534
	movabsq	$17179869184, %rdi
	movl	$2147483646, %edx
.L454:
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
	jle	.L535
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
	jle	.L460
	cmpl	%r9d, %r13d
	jge	.L458
.L461:
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
.L531:
	.cfi_restore_state
	cmpl	%r9d, %edx
	jl	.L536
	addl	%r9d, %r8d
	jo	.L449
	cmpl	%r8d, %r13d
	jl	.L451
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
	je	.L537
.L451:
	leal	-1(%r8), %eax
	cmpl	%eax, %r9d
	jg	.L446
	subl	%r9d, %r8d
	movslq	%r9d, %rcx
	leal	-1(%r8), %edx
	leaq	(%r12,%rcx,8), %rax
	addq	%rcx, %rdx
	leaq	8(%r12,%rdx,8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$8, %ecx
	jne	.L520
	.p2align 4
	.p2align 4
	.p2align 3
.L452:
	movq	%rbp, 8(%rax)
	addq	$16, %rax
	movq	%rbp, (%rax)
	cmpq	%rdx, %rax
	jne	.L452
	.p2align 4
	.p2align 3
.L446:
	movl	%r13d, 16(%rbx)
	movq	56(%rsp), %r12
	.cfi_restore 12
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	64(%rsp), %r13
	.cfi_restore 13
.L432:
	movq	48(%rsp), %rbp
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L536:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	cmpl	%r9d, %r13d
	jl	.L446
	subl	%r9d, %ecx
	movslq	%r9d, %rsi
	leal	-1(%rcx), %edx
	leaq	(%r12,%rsi,8), %rax
	addq	%rsi, %rdx
	leaq	8(%r12,%rdx,8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$8, %ecx
	je	.L447
	movq	%rbp, 8(%rax)
	addq	$8, %rax
	cmpq	%rax, %rdx
	je	.L446
	.p2align 4
	.p2align 4
	.p2align 3
.L447:
	movq	%rbp, 8(%rax)
	addq	$16, %rax
	movq	%rbp, (%rax)
	cmpq	%rax, %rdx
	jne	.L447
	jmp	.L446
	.p2align 4,,10
	.p2align 3
.L533:
	leal	1(%rax), %edi
	leal	-1(%rax), %edx
	movslq	%edi, %rdi
	salq	$3, %rdi
	jmp	.L454
	.p2align 4,,10
	.p2align 3
.L535:
	cmpl	%r11d, %r9d
	jg	.L458
	movl	%r8d, %eax
	addl	%r9d, %eax
	jo	.L465
	movl	%eax, %r8d
	cmpl	$-2147483648, %eax
	je	.L466
	leal	-1(%rax), %edx
	leaq	8(%r12), %rdi
	cmpl	%edx, %r9d
	jle	.L467
	cltq
	movslq	%r9d, %rsi
.L468:
	movl	%ecx, %edx
	subq	%rax, %rdx
	salq	$3, %rdx
	jmp	.L475
	.p2align 4,,10
	.p2align 3
.L460:
	addl	%r9d, %r8d
	jo	.L465
	cmpl	$-2147483648, %r8d
	je	.L466
	leal	-1(%r8), %eax
	movslq	%r9d, %rsi
	cmpl	%eax, %r9d
	jg	.L473
.L467:
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
	je	.L474
	movq	%rbp, 8(%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L473
	.p2align 4
	.p2align 4
	.p2align 3
.L474:
	movq	%rbp, 8(%rax)
	addq	$16, %rax
	movq	%rbp, (%rax)
	cmpq	%rdx, %rax
	jne	.L474
.L473:
	movslq	%r8d, %rax
	xorl	%edx, %edx
	cmpl	%r8d, %r13d
	jge	.L468
.L475:
	leaq	8(%r10,%rsi,8), %rsi
	leaq	8(%r12,%rax,8), %rdi
	movq	%r10, 8(%rsp)
	call	memmove@PLT
	movq	8(%rsp), %r10
	jmp	.L461
	.p2align 4,,10
	.p2align 3
.L458:
	subl	%r9d, %ecx
	movslq	%r9d, %rdx
	subl	$1, %ecx
	leaq	(%r12,%rdx,8), %rax
	leaq	1(%rdx,%rcx), %rdx
	leaq	(%r12,%rdx,8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$8, %ecx
	je	.L462
	movq	%rbp, 8(%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L461
	.p2align 4
	.p2align 4
	.p2align 3
.L462:
	movq	%rbp, 8(%rax)
	addq	$16, %rax
	movq	%rbp, (%rax)
	cmpq	%rdx, %rax
	jne	.L462
	jmp	.L461
	.p2align 4,,10
	.p2align 3
.L530:
	movslq	%r13d, %rax
	leaq	16(,%rax,8), %rdi
	call	__gnat_malloc@PLT
	movl	%r13d, (%rax)
	movq	%rax, %rdx
	testl	%r13d, %r13d
	js	.L440
	movl	%r13d, %ecx
	leaq	8(%rax), %rax
	leaq	16(%rdx,%rcx,8), %rcx
	movq	%rcx, %rsi
	subq	%rax, %rsi
	andl	$8, %esi
	je	.L441
	movq	%rbp, (%rax)
	leaq	16(%rdx), %rax
	cmpq	%rcx, %rax
	je	.L440
	.p2align 4
	.p2align 4
	.p2align 3
.L441:
	movq	%rbp, (%rax)
	addq	$16, %rax
	movq	%rbp, -8(%rax)
	cmpq	%rcx, %rax
	jne	.L441
.L440:
	movl	%r13d, 16(%rbx)
	movq	56(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	%rdx, 8(%rbx)
	movq	64(%rsp), %r13
	.cfi_restore 13
	movq	40(%rsp), %rbx
	.cfi_restore 3
	jmp	.L432
	.p2align 4,,10
	.p2align 3
.L520:
	.cfi_restore_state
	movq	%rbp, 8(%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	jne	.L452
	jmp	.L446
.L453:
	leal	1(%rax), %edi
	leal	-1(%rax), %edx
	salq	$3, %rdi
	jmp	.L454
.L532:
	movl	$1235, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L529:
	movl	$1149, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L528:
	movl	$1037, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L527:
	.cfi_restore 3
	.cfi_restore 12
	.cfi_restore 13
	movq	%rbx, 40(%rsp)
	movq	%r12, 56(%rsp)
	movq	%r13, 64(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__families__lucky_vectors__length.part.0
.L537:
	movl	$1212, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE0:
.L466:
	movl	$1291, %esi
	leaq	.LC13(%rip), %rdi
.LEHB1:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L465:
	movl	$1286, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE1:
.L449:
	movl	$1206, %esi
	leaq	.LC13(%rip), %rdi
.LEHB2:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L443:
	movl	$1182, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE2:
.L481:
	movq	%rax, %rbx
	jmp	.L476
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
	.uleb128 .L481-.LFB56
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
	.type	math_prime_util__families__lucky_vectors__insert__4.cold, @function
math_prime_util__families__lucky_vectors__insert__4.cold:
.LFSB56:
.L476:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L526
	call	__gnat_begin_handler_v1@PLT
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB3:
	call	__gnat_free@PLT
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE3:
.L482:
	movq	%rax, %rbp
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r13, %rsi
.LEHB4:
	call	__gnat_end_handler_v1@PLT
	movq	%rbp, %rdi
.L526:
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
	.uleb128 .LEHB3-.LCOLDB22
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L482-.LCOLDB22
	.uleb128 0
	.uleb128 .LEHB4-.LCOLDB22
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
	.size	math_prime_util__families__lucky_vectors__insert__4, .-math_prime_util__families__lucky_vectors__insert__4
	.section	.text.unlikely
	.size	math_prime_util__families__lucky_vectors__insert__4.cold, .-math_prime_util__families__lucky_vectors__insert__4.cold
.LCOLDE22:
	.text
.LHOTE22:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert__6
	.type	math_prime_util__families__lucky_vectors__insert__6, @function
math_prime_util__families__lucky_vectors__insert__6:
.LFB61:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rcx, %r10
	movl	48(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L539
	testq	%rsi, %rsi
	je	.L545
	cmpl	%edx, 16(%rdi)
	jge	.L547
.L545:
	xorl	%edi, %edi
	jmp	.L540
	.p2align 4,,10
	.p2align 3
.L539:
	movl	16(%rdi), %r11d
	testq	%rsi, %rsi
	je	.L541
	movl	%edx, %eax
	cmpl	%r11d, %edx
	jg	.L542
.L543:
	movq	%r10, %rdx
	movl	%eax, %esi
	movq	%r9, 24(%rsp)
	movq	%rdi, (%rsp)
	movq	%r8, 16(%rsp)
	movl	%eax, 12(%rsp)
	call	math_prime_util__families__lucky_vectors__insert__4
	movl	12(%rsp), %ecx
	movq	(%rsp), %rdi
	movq	24(%rsp), %r9
.L540:
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
.L541:
	.cfi_restore_state
	cmpl	$2147483647, %r11d
	je	.L548
.L542:
	leal	1(%r11), %eax
	jmp	.L543
	.p2align 4,,10
	.p2align 3
.L547:
	movl	%edx, %ecx
	jmp	.L540
.L548:
	movl	$1585, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE61:
	.size	math_prime_util__families__lucky_vectors__insert__6, .-math_prime_util__families__lucky_vectors__insert__6
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert__7
	.type	math_prime_util__families__lucky_vectors__insert__7, @function
math_prime_util__families__lucky_vectors__insert__7:
.LFB62:
	.cfi_startproc
	movl	%edx, %ecx
	xorl	%edx, %edx
	jmp	math_prime_util__families__lucky_vectors__insert__4
	.cfi_endproc
.LFE62:
	.size	math_prime_util__families__lucky_vectors__insert__7, .-math_prime_util__families__lucky_vectors__insert__7
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__prepend__2
	.type	math_prime_util__families__lucky_vectors__prepend__2, @function
math_prime_util__families__lucky_vectors__prepend__2:
.LFB81:
	.cfi_startproc
	movl	%edx, %ecx
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__families__lucky_vectors__insert__4
	.cfi_endproc
.LFE81:
	.size	math_prime_util__families__lucky_vectors__prepend__2, .-math_prime_util__families__lucky_vectors__prepend__2
	.section	.text.unlikely
	.align 2
.LCOLDB23:
	.text
.LHOTB23:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert_space
	.type	math_prime_util__families__lucky_vectors__insert_space, @function
math_prime_util__families__lucky_vectors__insert_space:
.LFB64:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA64
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movl	%edx, %r8d
	movl	16(%rdi), %edx
	cmpl	$2147483647, %edx
	je	.L591
	testl	%r8d, %r8d
	je	.L551
	leal	1(%rdx), %ecx
	movq	%rbx, 16(%rsp)
	addl	%r8d, %ecx
	movq	%rbp, 24(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	jo	.L555
	movq	%r13, 40(%rsp)
	cmpl	$-2147483648, %ecx
	.cfi_offset 13, -24
	je	.L592
	movl	%esi, %ebx
	movq	8(%rdi), %rsi
	movq	%rdi, %rbp
	leal	-1(%rcx), %r13d
	testq	%rsi, %rsi
	je	.L593
	movl	(%rsi), %eax
	cmpl	%r13d, %eax
	jge	.L594
	xorl	%edx, %edx
	testl	%eax, %eax
	movq	%r12, 32(%rsp)
	cmovns	%eax, %edx
	movq	%r14, 48(%rsp)
	leal	1(%rdx), %eax
	cmpl	%eax, %ecx
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	jg	.L568
	jmp	.L565
	.p2align 4,,10
	.p2align 3
.L597:
	cmpl	$-1073741824, %eax
	js	.L595
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L596
.L568:
	cmpl	$1073741823, %eax
	jle	.L597
	movabsq	$17179869184, %rdi
	movl	$2147483646, %edx
.L566:
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
	jl	.L570
	movl	12(%rsp), %r8d
	addl	%ebx, %r8d
	jo	.L572
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
.L570:
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
.L594:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	cmpl	%ebx, %edx
	jl	.L560
	addl	%ebx, %r8d
	jo	.L562
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
.L560:
	movl	%r13d, 16(%rbp)
	movq	16(%rsp), %rbx
	.cfi_restore 3
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r13
	.cfi_restore 13
.L551:
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L596:
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
	jmp	.L566
	.p2align 4,,10
	.p2align 3
.L593:
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
	jmp	.L551
.L565:
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	leal	2(%rdx), %edi
	salq	$3, %rdi
	jmp	.L566
.L595:
	movl	$1891, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L592:
	.cfi_restore 12
	.cfi_restore 14
	movl	$1811, %esi
	leaq	.LC13(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L555:
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	movl	$1700, %esi
	leaq	.LC13(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r13, 40(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L591:
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
	call	math_prime_util__families__lucky_vectors__length.part.0
.LEHE5:
.L572:
	movl	$1939, %esi
	leaq	.LC13(%rip), %rdi
.LEHB6:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE6:
.L562:
	.cfi_restore 12
	.cfi_restore 14
	movl	$1861, %esi
	leaq	.LC13(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 14, -16
.LEHB7:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE7:
.L582:
	movq	%rax, %rbx
	jmp	.L575
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
	.uleb128 .L582-.LFB64
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
	.type	math_prime_util__families__lucky_vectors__insert_space.cold, @function
math_prime_util__families__lucky_vectors__insert_space.cold:
.LFSB64:
.L575:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L590
	call	__gnat_begin_handler_v1@PLT
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB8:
	call	__gnat_free@PLT
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE8:
.L583:
	movq	%rax, %rbp
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r13, %rsi
.LEHB9:
	call	__gnat_end_handler_v1@PLT
	movq	%rbp, %rdi
.L590:
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
	.uleb128 .LEHB8-.LCOLDB23
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L583-.LCOLDB23
	.uleb128 0
	.uleb128 .LEHB9-.LCOLDB23
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
	.size	math_prime_util__families__lucky_vectors__insert_space, .-math_prime_util__families__lucky_vectors__insert_space
	.section	.text.unlikely
	.size	math_prime_util__families__lucky_vectors__insert_space.cold, .-math_prime_util__families__lucky_vectors__insert_space.cold
.LCOLDE23:
	.text
.LHOTE23:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert_space__2
	.type	math_prime_util__families__lucky_vectors__insert_space__2, @function
math_prime_util__families__lucky_vectors__insert_space__2:
.LFB65:
	.cfi_startproc
	movq	%rdi, %rax
	movq	%rsi, %rdi
	movq	%rdx, %rsi
	movl	%r9d, %edx
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	testl	%edx, %edx
	jne	.L599
	testq	%rdi, %rdi
	je	.L605
	cmpl	%esi, 16(%rax)
	jge	.L607
.L605:
	xorl	%eax, %eax
	jmp	.L600
	.p2align 4,,10
	.p2align 3
.L599:
	movl	16(%rax), %r9d
	movq	%rcx, %r10
	movq	%r8, %r11
	testq	%rdi, %rdi
	je	.L601
	movl	%esi, %ecx
	cmpl	%r9d, %esi
	jg	.L602
.L603:
	movq	%rax, %rdi
	movl	%ecx, %esi
	movq	%r8, 40(%rsp)
	movq	%rax, 8(%rsp)
	movq	%r10, 16(%rsp)
	movq	%r11, 24(%rsp)
	movl	%ecx, 36(%rsp)
	call	math_prime_util__families__lucky_vectors__insert_space
	movl	36(%rsp), %edx
	movq	8(%rsp), %rax
	movq	40(%rsp), %r8
.L600:
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
.L601:
	.cfi_restore_state
	cmpl	$2147483647, %r9d
	je	.L608
.L602:
	leal	1(%r9), %ecx
	jmp	.L603
	.p2align 4,,10
	.p2align 3
.L607:
	movl	%esi, %edx
	jmp	.L600
.L608:
	movl	$2006, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE65:
	.size	math_prime_util__families__lucky_vectors__insert_space__2, .-math_prime_util__families__lucky_vectors__insert_space__2
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert_vector
	.type	math_prime_util__families__lucky_vectors__insert_vector, @function
math_prime_util__families__lucky_vectors__insert_vector:
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
	je	.L637
	addl	$1, %ebx
	movq	%rdx, %r13
	movq	%rdi, %r12
	movl	%esi, %ebp
	movl	%ebx, %edx
	call	math_prime_util__families__lucky_vectors__insert_space
	testl	%ebx, %ebx
	je	.L609
	leal	-1(%rbp), %eax
	xorl	%esi, %esi
	movl	%eax, %ecx
	addl	%ebx, %ecx
	seto	%sil
	jo	.L638
	movq	8(%r12), %rdx
	cmpq	%r13, %r12
	jne	.L639
	testl	%eax, %eax
	cmovns	%ebp, %esi
	xorl	%r8d, %r8d
	addl	%esi, %eax
	movl	%esi, %r13d
	seto	%r8b
	jo	.L640
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
	je	.L609
	movl	12(%rsp), %ecx
	movl	8(%rsp), %r8d
	cmpl	$2147483647, %ecx
	je	.L641
	movl	16(%r12), %esi
	leal	1(%rcx), %eax
	cmpl	%esi, %eax
	jg	.L623
	movslq	%eax, %rdi
	movslq	%esi, %rdx
	subq	%rdi, %rdx
	movl	$2147483649, %edi
	addq	%rdi, %rdx
	shrq	$32, %rdx
	jne	.L627
	addl	$1, %esi
	subl	%eax, %esi
	movl	%esi, %r8d
.L623:
	movl	%eax, %r9d
	subl	%r8d, %r9d
	jo	.L627
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
.L639:
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
.L609:
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
.L637:
	.cfi_restore_state
	call	math_prime_util__families__lucky_vectors__length.part.0
.L638:
	movl	$1349, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L627:
	movl	$1435, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L641:
	movl	$1418, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L640:
	movl	$1392, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE57:
	.size	math_prime_util__families__lucky_vectors__insert_vector, .-math_prime_util__families__lucky_vectors__insert_vector
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert_vector__3
	.type	math_prime_util__families__lucky_vectors__insert_vector__3, @function
math_prime_util__families__lucky_vectors__insert_vector__3:
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
	js	.L651
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L645
	cmpl	%eax, %edx
	jle	.L647
.L646:
	leal	1(%rax), %ebx
.L647:
	movq	%rcx, %rdx
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r9, 8(%rsp)
	movq	%r8, (%rsp)
	call	math_prime_util__families__lucky_vectors__insert_vector
	movq	8(%rsp), %r9
.L644:
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
.L651:
	.cfi_restore_state
	testq	%rsi, %rsi
	je	.L648
	xorl	%eax, %eax
	cmpl	16(%rdi), %edx
	cmovg	%rax, %rbx
	movl	$0, %eax
	cmovg	%rax, %rbp
	jmp	.L644
	.p2align 4,,10
	.p2align 3
.L645:
	cmpl	$2147483647, %eax
	jne	.L646
	movl	$1508, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L648:
	xorl	%ebx, %ebx
	xorl	%ebp, %ebp
	jmp	.L644
	.cfi_endproc
.LFE59:
	.size	math_prime_util__families__lucky_vectors__insert_vector__3, .-math_prime_util__families__lucky_vectors__insert_vector__3
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__prepend_vector
	.type	math_prime_util__families__lucky_vectors__prepend_vector, @function
math_prime_util__families__lucky_vectors__prepend_vector:
.LFB82:
	.cfi_startproc
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__families__lucky_vectors__insert_vector
	.cfi_endproc
.LFE82:
	.size	math_prime_util__families__lucky_vectors__prepend_vector, .-math_prime_util__families__lucky_vectors__prepend_vector
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__reserve_capacity
	.type	math_prime_util__families__lucky_vectors__reserve_capacity, @function
math_prime_util__families__lucky_vectors__reserve_capacity:
.LFB99:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movl	16(%rdi), %r8d
	cmpl	$2147483647, %r8d
	je	.L674
	movq	8(%rdi), %r9
	movq	%rdi, %rcx
	leal	1(%r8), %edx
	testl	%esi, %esi
	jne	.L655
	testl	%edx, %edx
	je	.L675
	movl	(%r9), %eax
	testl	%eax, %eax
	js	.L658
	cmpl	$2147483647, %eax
	je	.L659
	leal	1(%rax), %esi
.L658:
	cmpl	%esi, %edx
	jl	.L673
.L653:
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L655:
	.cfi_restore_state
	leal	-1(%rsi), %r10d
	testq	%r9, %r9
	je	.L676
	movl	(%r9), %eax
	cmpl	%edx, %esi
	jg	.L661
	testl	%eax, %eax
	js	.L667
	cmpl	$2147483647, %eax
	je	.L663
	addl	$1, %eax
.L662:
	cmpl	%edx, %eax
	jle	.L653
.L673:
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
.L661:
	.cfi_restore_state
	testl	%eax, %eax
	js	.L664
	cmpl	$2147483647, %eax
	je	.L677
	addl	$1, %eax
	cmpl	%eax, %esi
	je	.L653
.L664:
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
.L667:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L662
	.p2align 4,,10
	.p2align 3
.L675:
	movq	$0, 8(%rdi)
	testq	%r9, %r9
	je	.L653
	movq	%r9, %rdi
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L676:
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
	jmp	.L653
.L674:
	call	math_prime_util__families__lucky_vectors__length.part.0
.L659:
	movl	$2605, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L677:
	movl	$2795, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L663:
	movl	$2745, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE99:
	.size	math_prime_util__families__lucky_vectors__reserve_capacity, .-math_prime_util__families__lucky_vectors__reserve_capacity
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__length.69, @function
math_prime_util__families__bitmask_sieve__word_vectors__length.69:
.LFB278:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L683
	addl	$1, %eax
	ret
.L683:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
	.cfi_endproc
.LFE278:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__length.69, .-math_prime_util__families__bitmask_sieve__word_vectors__length.69
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__Oeq__2.165, @function
math_prime_util__families__bitmask_sieve__word_vectors__Oeq__2.165:
.LFB225:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	16(%rsi), %eax
	jne	.L689
	cmpl	$2147483647, %eax
	je	.L696
	testl	%eax, %eax
	jns	.L688
.L691:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L688:
	leal	1(%rax), %edx
	movq	8(%rsi), %rcx
	xorl	%eax, %eax
	movq	8(%rdi), %rsi
	salq	$2, %rdx
	jmp	.L690
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L697:
	addq	$4, %rax
	cmpq	%rax, %rdx
	je	.L691
.L690:
	movl	4(%rcx,%rax), %edi
	cmpl	%edi, 4(%rsi,%rax)
	je	.L697
.L689:
	xorl	%eax, %eax
	ret
.L696:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
	.cfi_endproc
.LFE225:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__Oeq__2.165, .-math_prime_util__families__bitmask_sieve__word_vectors__Oeq__2.165
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reverse_elements.41, @function
math_prime_util__families__bitmask_sieve__word_vectors__reverse_elements.41:
.LFB302:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L706
	testl	%eax, %eax
	jle	.L698
	movq	8(%rdi), %rcx
	xorl	%edx, %edx
	.p2align 5
	.p2align 4
	.p2align 3
.L701:
	movl	4(%rcx,%rdx,4), %esi
	movl	4(%rcx,%rax,4), %edi
	movl	%edi, 4(%rcx,%rdx,4)
	addq	$1, %rdx
	movl	%esi, 4(%rcx,%rax,4)
	subq	$1, %rax
	cmpl	%eax, %edx
	jl	.L701
.L698:
	ret
.L706:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
	.cfi_endproc
.LFE302:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reverse_elements.41, .-math_prime_util__families__bitmask_sieve__word_vectors__reverse_elements.41
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70, @function
math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70:
.LFB301:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movl	16(%rdi), %r8d
	cmpl	$2147483647, %r8d
	je	.L728
	movq	8(%rdi), %r9
	movq	%rdi, %rcx
	leal	1(%r8), %edx
	testl	%esi, %esi
	jne	.L709
	testl	%edx, %edx
	je	.L729
	movl	(%r9), %eax
	testl	%eax, %eax
	js	.L712
	cmpl	$2147483647, %eax
	je	.L713
	leal	1(%rax), %esi
.L712:
	cmpl	%esi, %edx
	jl	.L727
.L707:
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L709:
	.cfi_restore_state
	leal	-1(%rsi), %r10d
	testq	%r9, %r9
	je	.L730
	movl	(%r9), %eax
	cmpl	%edx, %esi
	jg	.L715
	testl	%eax, %eax
	js	.L721
	cmpl	$2147483647, %eax
	je	.L717
	addl	$1, %eax
.L716:
	cmpl	%edx, %eax
	jle	.L707
.L727:
	movslq	%edx, %rdx
	movq	%rcx, 40(%rsp)
	salq	$2, %rdx
	movq	%r9, 32(%rsp)
	leaq	4(%rdx), %rdi
	movl	%r8d, 8(%rsp)
	movq	%rdx, 24(%rsp)
	call	__gnat_malloc@PLT
	movl	8(%rsp), %r8d
	leaq	4(%rax), %rdi
	movl	%r8d, (%rax)
	movq	32(%rsp), %r9
	movq	24(%rsp), %rdx
	movq	%rax, 16(%rsp)
	leaq	4(%r9), %rsi
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
.L715:
	.cfi_restore_state
	testl	%eax, %eax
	js	.L718
	cmpl	$2147483647, %eax
	je	.L731
	addl	$1, %eax
	cmpl	%eax, %esi
	je	.L707
.L718:
	movslq	%r10d, %rax
	movq	%rcx, 16(%rsp)
	leaq	8(,%rax,4), %rdi
	movl	%r10d, 8(%rsp)
	call	__gnat_malloc@PLT
	movq	16(%rsp), %rcx
	movl	8(%rsp), %r10d
	movq	%rax, %r8
	movl	16(%rcx), %edx
	movq	8(%rcx), %r9
	movl	%r10d, (%rax)
	leaq	4(%r8), %rdi
	movq	%rcx, 24(%rsp)
	movq	%rdx, %rax
	leaq	4(%r9), %rsi
	movq	%r8, 8(%rsp)
	leaq	4(,%rdx,4), %rdx
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
.L721:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L716
	.p2align 4,,10
	.p2align 3
.L729:
	movq	$0, 8(%rdi)
	testq	%r9, %r9
	je	.L707
	movq	%r9, %rdi
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L730:
	.cfi_restore_state
	movslq	%r10d, %rax
	movq	%rdi, 16(%rsp)
	leaq	8(,%rax,4), %rdi
	movl	%r10d, 8(%rsp)
	call	__gnat_malloc@PLT
	movl	8(%rsp), %r10d
	movq	16(%rsp), %rcx
	movl	%r10d, (%rax)
	movq	%rax, 8(%rcx)
	jmp	.L707
.L728:
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.L713:
	movl	$2605, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L731:
	movl	$2795, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L717:
	movl	$2745, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE301:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70, .-math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70
	.section	.text.unlikely
	.align 2
.LCOLDB24:
	.text
.LHOTB24:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48:
.LFB266:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA266
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movl	%edx, %r8d
	movl	16(%rdi), %edx
	cmpl	$2147483647, %edx
	je	.L772
	testl	%r8d, %r8d
	je	.L732
	leal	1(%rdx), %ecx
	movq	%rbx, 16(%rsp)
	addl	%r8d, %ecx
	movq	%rbp, 24(%rsp)
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	jo	.L736
	movq	%r13, 40(%rsp)
	cmpl	$-2147483648, %ecx
	.cfi_offset 13, -24
	je	.L773
	movl	%esi, %ebx
	movq	8(%rdi), %rsi
	movq	%rdi, %rbp
	leal	-1(%rcx), %r13d
	testq	%rsi, %rsi
	je	.L774
	movl	(%rsi), %eax
	cmpl	%r13d, %eax
	jge	.L775
	xorl	%edx, %edx
	testl	%eax, %eax
	movq	%r12, 32(%rsp)
	cmovns	%eax, %edx
	movq	%r14, 48(%rsp)
	leal	1(%rdx), %eax
	cmpl	%eax, %ecx
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	jg	.L749
	jmp	.L746
	.p2align 4,,10
	.p2align 3
.L778:
	cmpl	$-1073741824, %eax
	js	.L776
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L777
.L749:
	cmpl	$1073741823, %eax
	jle	.L778
	movabsq	$8589934592, %rdi
	movl	$2147483646, %edx
.L747:
	movl	%edx, 4(%rsp)
	movl	%r8d, 12(%rsp)
	movl	%ecx, 8(%rsp)
.LEHB10:
	call	__gnat_malloc@PLT
	movl	4(%rsp), %edx
	xorl	%r9d, %r9d
	movq	8(%rbp), %r14
	leaq	4(%rax), %rdi
	movq	%rax, %r12
	movl	%edx, (%rax)
	movl	%ebx, %edx
	leaq	4(%r14), %rsi
	salq	$2, %rdx
	testl	%ebx, %ebx
	cmovle	%r9, %rdx
	call	memmove@PLT
	cmpl	%ebx, 16(%rbp)
	jl	.L751
	movl	12(%rsp), %r8d
	addl	%ebx, %r8d
	jo	.L753
	movslq	8(%rsp), %rdx
	movslq	%r8d, %rax
	xorl	%r9d, %r9d
	movslq	%ebx, %rbx
	leaq	4(%r14,%rbx,4), %rsi
	leaq	4(%r12,%rax,4), %rdi
	subq	%rax, %rdx
	salq	$2, %rdx
	cmpl	%r8d, %r13d
	cmovl	%r9, %rdx
	call	memmove@PLT
.L751:
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
.L775:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	cmpl	%ebx, %edx
	jl	.L741
	addl	%ebx, %r8d
	jo	.L743
	movslq	%r8d, %rax
	movslq	%ecx, %rdx
	xorl	%ecx, %ecx
	subq	%rax, %rdx
	leaq	4(%rsi,%rax,4), %rdi
	salq	$2, %rdx
	cmpl	%r8d, %r13d
	cmovl	%rcx, %rdx
	addl	$1, %ebx
	movslq	%ebx, %rbx
	leaq	(%rsi,%rbx,4), %rsi
	call	memmove@PLT
.L741:
	movl	%r13d, 16(%rbp)
	movq	16(%rsp), %rbx
	.cfi_restore 3
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r13
	.cfi_restore 13
.L732:
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L777:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	leal	1(%rax), %edi
	leal	-1(%rax), %edx
	movslq	%edi, %rdi
	salq	$2, %rdi
	jmp	.L747
	.p2align 4,,10
	.p2align 3
.L774:
	.cfi_restore 12
	.cfi_restore 14
	movslq	%r13d, %rax
	leaq	8(,%rax,4), %rdi
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
	jmp	.L732
.L746:
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	leal	2(%rdx), %edi
	salq	$2, %rdi
	jmp	.L747
.L776:
	movl	$1891, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L773:
	.cfi_restore 12
	.cfi_restore 14
	movl	$1811, %esi
	leaq	.LC13(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L736:
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	movl	$1700, %esi
	leaq	.LC13(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r13, 40(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L772:
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
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.LEHE10:
.L753:
	movl	$1939, %esi
	leaq	.LC13(%rip), %rdi
.LEHB11:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE11:
.L743:
	.cfi_restore 12
	.cfi_restore 14
	movl	$1861, %esi
	leaq	.LC13(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 14, -16
.LEHB12:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE12:
.L763:
	movq	%rax, %rbx
	jmp	.L756
	.section	.gcc_except_table
	.align 4
.LLSDA266:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT266-.LLSDATTD266
.LLSDATTD266:
	.byte	0x1
	.uleb128 .LLSDACSE266-.LLSDACSB266
.LLSDACSB266:
	.uleb128 .LEHB10-.LFB266
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB11-.LFB266
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L763-.LFB266
	.uleb128 0x1
	.uleb128 .LEHB12-.LFB266
	.uleb128 .LEHE12-.LEHB12
	.uleb128 0
	.uleb128 0
.LLSDACSE266:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT266:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC266
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48.cold:
.LFSB266:
.L756:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L771
	call	__gnat_begin_handler_v1@PLT
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB13:
	call	__gnat_free@PLT
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE13:
.L764:
	movq	%rax, %rbp
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r13, %rsi
.LEHB14:
	call	__gnat_end_handler_v1@PLT
	movq	%rbp, %rdi
.L771:
	call	_Unwind_Resume@PLT
.LEHE14:
	.cfi_endproc
.LFE266:
	.section	.gcc_except_table
	.align 4
.LLSDAC266:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC266-.LLSDATTDC266
.LLSDATTDC266:
	.byte	0x1
	.uleb128 .LLSDACSEC266-.LLSDACSBC266
.LLSDACSBC266:
	.uleb128 .LEHB13-.LCOLDB24
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L764-.LCOLDB24
	.uleb128 0
	.uleb128 .LEHB14-.LCOLDB24
	.uleb128 .LEHE14-.LEHB14
	.uleb128 0
	.uleb128 0
.LLSDACSEC266:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC266:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48, .-math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48.cold
.LCOLDE24:
	.text
.LHOTE24:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert_space__2.47, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert_space__2.47:
.LFB267:
	.cfi_startproc
	movq	%rdi, %rax
	movq	%rsi, %rdi
	movq	%rdx, %rsi
	movl	%r9d, %edx
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	testl	%edx, %edx
	jne	.L780
	testq	%rdi, %rdi
	je	.L786
	cmpl	%esi, 16(%rax)
	jge	.L788
.L786:
	xorl	%eax, %eax
	jmp	.L781
	.p2align 4,,10
	.p2align 3
.L780:
	movl	16(%rax), %r9d
	movq	%rcx, %r10
	movq	%r8, %r11
	testq	%rdi, %rdi
	je	.L782
	movl	%esi, %ecx
	cmpl	%r9d, %esi
	jg	.L783
.L784:
	movq	%rax, %rdi
	movl	%ecx, %esi
	movq	%r8, 40(%rsp)
	movq	%rax, 8(%rsp)
	movq	%r10, 16(%rsp)
	movq	%r11, 24(%rsp)
	movl	%ecx, 36(%rsp)
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48
	movl	36(%rsp), %edx
	movq	8(%rsp), %rax
	movq	40(%rsp), %r8
.L781:
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
.L782:
	.cfi_restore_state
	cmpl	$2147483647, %r9d
	je	.L789
.L783:
	leal	1(%r9), %ecx
	jmp	.L784
	.p2align 4,,10
	.p2align 3
.L788:
	movl	%esi, %edx
	jmp	.L781
.L789:
	movl	$2006, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE267:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert_space__2.47, .-math_prime_util__families__bitmask_sieve__word_vectors__insert_space__2.47
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61:
.LFB259:
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
	je	.L818
	addl	$1, %ebx
	movq	%rdx, %r13
	movq	%rdi, %r12
	movl	%esi, %ebp
	movl	%ebx, %edx
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48
	testl	%ebx, %ebx
	je	.L790
	leal	-1(%rbp), %eax
	xorl	%esi, %esi
	movl	%eax, %ecx
	addl	%ebx, %ecx
	seto	%sil
	jo	.L819
	movq	8(%r12), %rdx
	cmpq	%r13, %r12
	jne	.L820
	testl	%eax, %eax
	cmovns	%ebp, %esi
	xorl	%r8d, %r8d
	addl	%esi, %eax
	movl	%esi, %r13d
	seto	%r8b
	jo	.L821
	movslq	%ebp, %r9
	movslq	%eax, %rdi
	xorl	%esi, %esi
	movl	%ecx, 12(%rsp)
	subq	%r9, %rdi
	cmpl	%eax, %ebp
	leaq	4(%rdx), %rax
	movl	%r8d, 8(%rsp)
	leaq	4(,%rdi,4), %rdi
	cmovle	%rdi, %rsi
	leaq	4(%rdx,%r9,4), %rdi
	movq	%rsi, %rdx
	movq	%rax, %rsi
	call	memmove@PLT
	cmpl	%ebx, %r13d
	je	.L790
	movl	12(%rsp), %ecx
	movl	8(%rsp), %r8d
	cmpl	$2147483647, %ecx
	je	.L822
	movl	16(%r12), %esi
	leal	1(%rcx), %eax
	cmpl	%esi, %eax
	jg	.L804
	movslq	%eax, %rdi
	movslq	%esi, %rdx
	subq	%rdi, %rdx
	movl	$2147483649, %edi
	addq	%rdi, %rdx
	shrq	$32, %rdx
	jne	.L808
	addl	$1, %esi
	subl	%eax, %esi
	movl	%esi, %r8d
.L804:
	movl	%eax, %r9d
	subl	%r8d, %r9d
	jo	.L808
	cltq
	movslq	%r9d, %rdi
	movq	8(%r12), %rsi
	movq	%rax, %rdx
	subq	%rdi, %rdx
	leaq	4(%rsi,%rdi,4), %rdi
	leaq	4(%rsi,%rax,4), %rsi
	salq	$2, %rdx
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
.L820:
	.cfi_restore_state
	movslq	%ebp, %r8
	movslq	%ecx, %rdi
	xorl	%eax, %eax
	movq	8(%r13), %rsi
	subq	%r8, %rdi
	cmpl	%ecx, %ebp
	leaq	4(,%rdi,4), %rdi
	cmovle	%rdi, %rax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	leaq	4(%rdx,%r8,4), %rdi
	addq	$4, %rsi
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
.L790:
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
.L818:
	.cfi_restore_state
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.L819:
	movl	$1349, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L808:
	movl	$1435, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L822:
	movl	$1418, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L821:
	movl	$1392, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE259:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61, .-math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__prepend_vector.53, @function
math_prime_util__families__bitmask_sieve__word_vectors__prepend_vector.53:
.LFB284:
	.cfi_startproc
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
	.cfi_endproc
.LFE284:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__prepend_vector.53, .-math_prime_util__families__bitmask_sieve__word_vectors__prepend_vector.53
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector__3.59, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert_vector__3.59:
.LFB261:
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
	js	.L833
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L827
	cmpl	%eax, %edx
	jle	.L829
.L828:
	leal	1(%rax), %ebx
.L829:
	movq	%rcx, %rdx
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r9, 8(%rsp)
	movq	%r8, (%rsp)
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
	movq	8(%rsp), %r9
.L826:
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
.L833:
	.cfi_restore_state
	testq	%rsi, %rsi
	je	.L830
	xorl	%eax, %eax
	cmpl	16(%rdi), %edx
	cmovg	%rax, %rbx
	movl	$0, %eax
	cmovg	%rax, %rbp
	jmp	.L826
	.p2align 4,,10
	.p2align 3
.L827:
	cmpl	$2147483647, %eax
	jne	.L828
	movl	$1508, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L830:
	xorl	%ebx, %ebx
	xorl	%ebp, %ebp
	jmp	.L826
	.cfi_endproc
.LFE261:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector__3.59, .-math_prime_util__families__bitmask_sieve__word_vectors__insert_vector__3.59
	.section	.text.unlikely
	.align 2
.LCOLDB25:
	.text
.LHOTB25:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58:
.LFB258:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA258
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%rbp, 48(%rsp)
	.cfi_offset 6, -32
	movl	%edx, %ebp
	movl	16(%rdi), %edx
	cmpl	$2147483647, %edx
	je	.L931
	movl	%ecx, %r8d
	testl	%ecx, %ecx
	je	.L834
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
	jo	.L932
	cmpl	$-2147483648, %ecx
	je	.L933
	movq	8(%rdi), %r12
	movq	%rdi, %rbx
	leal	-1(%rcx), %r13d
	testq	%r12, %r12
	je	.L934
	movl	%esi, %r9d
	movl	(%r12), %esi
	testl	%esi, %esi
	js	.L844
	cmpl	$2147483647, %esi
	je	.L845
	leal	1(%rsi), %eax
.L844:
	cmpl	%eax, %ecx
	jle	.L935
	testl	%eax, %eax
	movl	$1, %edx
	cmovle	%edx, %eax
	cmpl	%eax, %ecx
	jg	.L858
	jmp	.L855
	.p2align 4,,10
	.p2align 3
.L938:
	cmpl	$-1073741824, %eax
	js	.L936
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L937
.L858:
	cmpl	$1073741823, %eax
	jle	.L938
	movabsq	$8589934592, %rdi
	movl	$2147483646, %edx
.L856:
	movl	%r8d, 24(%rsp)
	movl	%r9d, 20(%rsp)
	movl	%ecx, 16(%rsp)
	movl	%edx, 8(%rsp)
.LEHB15:
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
	jle	.L939
	movl	%r9d, %edx
	leaq	4(%r10), %rsi
	leaq	4(%rax), %rdi
	movl	%r8d, 28(%rsp)
	salq	$2, %rdx
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
	jle	.L862
	cmpl	%r9d, %r13d
	jge	.L860
.L863:
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
.L935:
	.cfi_restore_state
	cmpl	%r9d, %edx
	jl	.L940
	addl	%r9d, %r8d
	jo	.L851
	cmpl	%r8d, %r13d
	jl	.L853
	movslq	%r8d, %rax
	movslq	%ecx, %rdx
	leal	1(%r9), %ecx
	movl	%r8d, 16(%rsp)
	subq	%rax, %rdx
	movslq	%ecx, %rcx
	leaq	4(%r12,%rax,4), %rdi
	movl	%r9d, 8(%rsp)
	salq	$2, %rdx
	leaq	(%r12,%rcx,4), %rsi
	call	memmove@PLT
	movl	16(%rsp), %r8d
	movl	8(%rsp), %r9d
	cmpl	$-2147483648, %r8d
	je	.L941
.L853:
	leal	-1(%r8), %eax
	cmpl	%eax, %r9d
	jg	.L848
	subl	%r9d, %r8d
	movslq	%r9d, %rcx
	leal	-1(%r8), %edx
	leaq	(%r12,%rcx,4), %rax
	addq	%rcx, %rdx
	leaq	4(%r12,%rdx,4), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$4, %ecx
	jne	.L922
	.p2align 4
	.p2align 4
	.p2align 3
.L854:
	movl	%ebp, 4(%rax)
	addq	$8, %rax
	movl	%ebp, (%rax)
	cmpq	%rdx, %rax
	jne	.L854
	.p2align 4
	.p2align 3
.L848:
	movl	%r13d, 16(%rbx)
	movq	56(%rsp), %r12
	.cfi_restore 12
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	64(%rsp), %r13
	.cfi_restore 13
.L834:
	movq	48(%rsp), %rbp
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L940:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	cmpl	%r9d, %r13d
	jl	.L848
	subl	%r9d, %ecx
	movslq	%r9d, %rsi
	leal	-1(%rcx), %edx
	leaq	(%r12,%rsi,4), %rax
	addq	%rsi, %rdx
	leaq	4(%r12,%rdx,4), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$4, %ecx
	je	.L849
	movl	%ebp, 4(%rax)
	addq	$4, %rax
	cmpq	%rax, %rdx
	je	.L848
	.p2align 5
	.p2align 4
	.p2align 3
.L849:
	movl	%ebp, 4(%rax)
	addq	$8, %rax
	movl	%ebp, (%rax)
	cmpq	%rax, %rdx
	je	.L848
	movl	%ebp, 4(%rax)
	addq	$8, %rax
	movl	%ebp, (%rax)
	cmpq	%rax, %rdx
	jne	.L849
	jmp	.L848
	.p2align 4,,10
	.p2align 3
.L937:
	leal	1(%rax), %edi
	leal	-1(%rax), %edx
	movslq	%edi, %rdi
	salq	$2, %rdi
	jmp	.L856
	.p2align 4,,10
	.p2align 3
.L939:
	cmpl	%r11d, %r9d
	jg	.L860
	movl	%r8d, %eax
	addl	%r9d, %eax
	jo	.L867
	movl	%eax, %r8d
	cmpl	$-2147483648, %eax
	je	.L868
	leal	-1(%rax), %edx
	leaq	4(%r12), %rdi
	cmpl	%edx, %r9d
	jle	.L869
	cltq
	movslq	%r9d, %rsi
.L870:
	movl	%ecx, %edx
	subq	%rax, %rdx
	salq	$2, %rdx
	jmp	.L877
	.p2align 4,,10
	.p2align 3
.L862:
	addl	%r9d, %r8d
	jo	.L867
	cmpl	$-2147483648, %r8d
	je	.L868
	leal	-1(%r8), %eax
	movslq	%r9d, %rsi
	cmpl	%eax, %r9d
	jg	.L875
.L869:
	movl	%r8d, %edx
	movslq	%r9d, %rsi
	subl	%r9d, %edx
	leaq	(%r12,%rsi,4), %rax
	subl	$1, %edx
	addq	%rsi, %rdx
	leaq	(%rdi,%rdx,4), %rdx
	movq	%rdx, %rdi
	subq	%rax, %rdi
	andl	$4, %edi
	je	.L876
	movl	%ebp, 4(%rax)
	addq	$4, %rax
	cmpq	%rdx, %rax
	je	.L875
	.p2align 4
	.p2align 4
	.p2align 3
.L876:
	movl	%ebp, 4(%rax)
	addq	$8, %rax
	movl	%ebp, (%rax)
	cmpq	%rdx, %rax
	jne	.L876
.L875:
	movslq	%r8d, %rax
	xorl	%edx, %edx
	cmpl	%r8d, %r13d
	jge	.L870
.L877:
	leaq	4(%r10,%rsi,4), %rsi
	leaq	4(%r12,%rax,4), %rdi
	movq	%r10, 8(%rsp)
	call	memmove@PLT
	movq	8(%rsp), %r10
	jmp	.L863
	.p2align 4,,10
	.p2align 3
.L860:
	subl	%r9d, %ecx
	movslq	%r9d, %rdx
	subl	$1, %ecx
	leaq	(%r12,%rdx,4), %rax
	leaq	1(%rdx,%rcx), %rdx
	leaq	(%r12,%rdx,4), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$4, %ecx
	je	.L864
	movl	%ebp, 4(%rax)
	addq	$4, %rax
	cmpq	%rdx, %rax
	je	.L863
	.p2align 5
	.p2align 4
	.p2align 3
.L864:
	movl	%ebp, 4(%rax)
	addq	$8, %rax
	movl	%ebp, (%rax)
	cmpq	%rdx, %rax
	je	.L863
	movl	%ebp, 4(%rax)
	addq	$8, %rax
	movl	%ebp, (%rax)
	cmpq	%rdx, %rax
	jne	.L864
	jmp	.L863
	.p2align 4,,10
	.p2align 3
.L934:
	movslq	%r13d, %rax
	leaq	8(,%rax,4), %rdi
	call	__gnat_malloc@PLT
	movl	%r13d, (%rax)
	movq	%rax, %rdx
	testl	%r13d, %r13d
	js	.L842
	movl	%r13d, %ecx
	leaq	4(%rax), %rax
	leaq	8(%rdx,%rcx,4), %rcx
	movq	%rcx, %rsi
	subq	%rax, %rsi
	andl	$4, %esi
	je	.L843
	movl	%ebp, (%rax)
	leaq	8(%rdx), %rax
	cmpq	%rcx, %rax
	je	.L842
	.p2align 4
	.p2align 4
	.p2align 3
.L843:
	movl	%ebp, (%rax)
	addq	$8, %rax
	movl	%ebp, -4(%rax)
	cmpq	%rcx, %rax
	jne	.L843
.L842:
	movl	%r13d, 16(%rbx)
	movq	56(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	movq	%rdx, 8(%rbx)
	movq	64(%rsp), %r13
	.cfi_restore 13
	movq	40(%rsp), %rbx
	.cfi_restore 3
	jmp	.L834
	.p2align 4,,10
	.p2align 3
.L922:
	.cfi_restore_state
	movl	%ebp, 4(%rax)
	addq	$4, %rax
	cmpq	%rdx, %rax
	jne	.L854
	jmp	.L848
.L855:
	leal	1(%rax), %edi
	leal	-1(%rax), %edx
	salq	$2, %rdi
	jmp	.L856
.L936:
	movl	$1235, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L933:
	movl	$1149, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L932:
	movl	$1037, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L931:
	.cfi_restore 3
	.cfi_restore 12
	.cfi_restore 13
	movq	%rbx, 40(%rsp)
	movq	%r12, 56(%rsp)
	movq	%r13, 64(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.L941:
	movl	$1212, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE15:
.L868:
	movl	$1291, %esi
	leaq	.LC13(%rip), %rdi
.LEHB16:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L867:
	movl	$1286, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE16:
.L851:
	movl	$1206, %esi
	leaq	.LC13(%rip), %rdi
.LEHB17:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L845:
	movl	$1182, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE17:
.L883:
	movq	%rax, %rbx
	jmp	.L878
	.section	.gcc_except_table
	.align 4
.LLSDA258:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT258-.LLSDATTD258
.LLSDATTD258:
	.byte	0x1
	.uleb128 .LLSDACSE258-.LLSDACSB258
.LLSDACSB258:
	.uleb128 .LEHB15-.LFB258
	.uleb128 .LEHE15-.LEHB15
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB16-.LFB258
	.uleb128 .LEHE16-.LEHB16
	.uleb128 .L883-.LFB258
	.uleb128 0x1
	.uleb128 .LEHB17-.LFB258
	.uleb128 .LEHE17-.LEHB17
	.uleb128 0
	.uleb128 0
.LLSDACSE258:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT258:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC258
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58.cold:
.LFSB258:
.L878:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L928
	call	__gnat_begin_handler_v1@PLT
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB18:
	call	__gnat_free@PLT
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE18:
.L884:
	movq	%rax, %rbp
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r13, %rsi
.LEHB19:
	call	__gnat_end_handler_v1@PLT
	movq	%rbp, %rdi
.L928:
	call	_Unwind_Resume@PLT
.LEHE19:
	.cfi_endproc
.LFE258:
	.section	.gcc_except_table
	.align 4
.LLSDAC258:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC258-.LLSDATTDC258
.LLSDATTDC258:
	.byte	0x1
	.uleb128 .LLSDACSEC258-.LLSDACSBC258
.LLSDACSBC258:
	.uleb128 .LEHB18-.LCOLDB25
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L884-.LCOLDB25
	.uleb128 0
	.uleb128 .LEHB19-.LCOLDB25
	.uleb128 .LEHE19-.LEHB19
	.uleb128 0
	.uleb128 0
.LLSDACSEC258:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC258:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58, .-math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58.cold
.LCOLDE25:
	.text
.LHOTE25:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__prepend__2.52, @function
math_prime_util__families__bitmask_sieve__word_vectors__prepend__2.52:
.LFB283:
	.cfi_startproc
	movl	%edx, %ecx
	movl	%esi, %edx
	xorl	%esi, %esi
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
	.cfi_endproc
.LFE283:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__prepend__2.52, .-math_prime_util__families__bitmask_sieve__word_vectors__prepend__2.52
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert__7.55, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert__7.55:
.LFB264:
	.cfi_startproc
	movl	%edx, %ecx
	xorl	%edx, %edx
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
	.cfi_endproc
.LFE264:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert__7.55, .-math_prime_util__families__bitmask_sieve__word_vectors__insert__7.55
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert__6.56, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert__6.56:
.LFB263:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	%ecx, %r10d
	movl	48(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L945
	testq	%rsi, %rsi
	je	.L951
	cmpl	%edx, 16(%rdi)
	jge	.L953
.L951:
	xorl	%edi, %edi
	jmp	.L946
	.p2align 4,,10
	.p2align 3
.L945:
	movl	16(%rdi), %r11d
	testq	%rsi, %rsi
	je	.L947
	movl	%edx, %eax
	cmpl	%r11d, %edx
	jg	.L948
.L949:
	movl	%r10d, %edx
	movl	%eax, %esi
	movq	%r9, 24(%rsp)
	movq	%rdi, (%rsp)
	movq	%r8, 16(%rsp)
	movl	%eax, 12(%rsp)
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
	movl	12(%rsp), %ecx
	movq	(%rsp), %rdi
	movq	24(%rsp), %r9
.L946:
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
.L947:
	.cfi_restore_state
	cmpl	$2147483647, %r11d
	je	.L954
.L948:
	leal	1(%r11), %eax
	jmp	.L949
	.p2align 4,,10
	.p2align 3
.L953:
	movl	%edx, %ecx
	jmp	.L946
.L954:
	movl	$1585, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE263:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert__6.56, .-math_prime_util__families__bitmask_sieve__word_vectors__insert__6.56
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__write.33, @function
math_prime_util__families__bitmask_sieve__word_vectors__write.33:
.LFB317:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	movl	16(%rsi), %esi
	cmpl	$2147483647, %esi
	je	.L961
	addl	$1, %esi
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	call	system__stream_attributes__w_u@PLT
	movl	16(%rbp), %eax
	testl	%eax, %eax
	js	.L955
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	leaq	1(%rax), %r13
	.p2align 4
	.p2align 3
.L958:
	movq	8(%rbp), %rax
	movq	%r12, %rdi
	movl	4(%rax,%rbx,4), %esi
	addq	$1, %rbx
	call	system__stream_attributes__w_u@PLT
	cmpq	%rbx, %r13
	jne	.L958
	movq	8(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %r13
	.cfi_restore 13
.L955:
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
.L961:
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	movq	%r12, 24(%rsp)
	movq	%r13, 32(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
	.cfi_endproc
.LFE317:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__write.33, .-math_prime_util__families__bitmask_sieve__word_vectors__write.33
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__vectorSW__2.77, @function
math_prime_util__families__bitmask_sieve__word_vectors__vectorSW__2.77:
.LFB379:
	.cfi_startproc
	movl	$4, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__write.33
	.cfi_endproc
.LFE379:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__vectorSW__2.77, .-math_prime_util__families__bitmask_sieve__word_vectors__vectorSW__2.77
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43.part.0, @function
math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43.part.0:
.LFB497:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$589, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE497:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43.part.0, .-math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43.part.0
	.set	math_prime_util__families__lucky_vectors__delete_last.part.0,math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43.part.0
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43, @function
math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43:
.LFB242:
	.cfi_startproc
	testl	%esi, %esi
	je	.L976
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L979
	leal	1(%rax), %edx
	cmpl	%edx, %esi
	jge	.L980
	subl	%esi, %eax
	jo	.L970
	movl	%eax, 16(%rdi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L980:
	.cfi_restore_state
	movl	$-1, 16(%rdi)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L976:
	ret
.L979:
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.L970:
	call	math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43.part.0
	.cfi_endproc
.LFE242:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43, .-math_prime_util__families__bitmask_sieve__word_vectors__delete_last.43
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__capacity.71, @function
math_prime_util__families__bitmask_sieve__word_vectors__capacity.71:
.LFB232:
	.cfi_startproc
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L982
	movl	(%rax), %eax
	testl	%eax, %eax
	js	.L982
	cmpl	$2147483647, %eax
	je	.L983
	addl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L982:
	xorl	%eax, %eax
	ret
.L983:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__bitmask_sieve__word_vectors__capacity.71.part.0
	.cfi_endproc
.LFE232:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__capacity.71, .-math_prime_util__families__bitmask_sieve__word_vectors__capacity.71
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__delete_first.44, @function
math_prime_util__families__bitmask_sieve__word_vectors__delete_first.44:
.LFB241:
	.cfi_startproc
	testl	%esi, %esi
	je	.L990
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L1000
	addl	$1, %eax
	cmpl	%eax, %esi
	jl	.L993
	movl	$-1, 16(%rdi)
	ret
	.p2align 4,,10
	.p2align 3
.L990:
	ret
	.p2align 4,,10
	.p2align 3
.L993:
	movl	%esi, %edx
	xorl	%esi, %esi
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__delete.46
.L1000:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
	.cfi_endproc
.LFE241:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__delete_first.44, .-math_prime_util__families__bitmask_sieve__word_vectors__delete_first.44
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__append_vector
	.type	math_prime_util__families__lucky_vectors__append_vector, @function
math_prime_util__families__lucky_vectors__append_vector:
.LFB26:
	.cfi_startproc
	movl	16(%rsi), %edx
	testl	%edx, %edx
	js	.L1001
	movq	%rsi, %rdx
	movl	16(%rdi), %esi
	cmpl	$2147483647, %esi
	je	.L1007
	addl	$1, %esi
	jmp	math_prime_util__families__lucky_vectors__insert_vector
	.p2align 4,,10
	.p2align 3
.L1001:
	ret
.L1007:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$197, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE26:
	.size	math_prime_util__families__lucky_vectors__append_vector, .-math_prime_util__families__lucky_vectors__append_vector
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert_vector__2
	.type	math_prime_util__families__lucky_vectors__insert_vector__2, @function
math_prime_util__families__lucky_vectors__insert_vector__2:
.LFB58:
	.cfi_startproc
	movl	16(%rcx), %r8d
	testl	%r8d, %r8d
	js	.L1008
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L1010
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L1012
.L1011:
	leal	1(%rax), %esi
.L1012:
	movq	%rcx, %rdx
	jmp	math_prime_util__families__lucky_vectors__insert_vector
	.p2align 4,,10
	.p2align 3
.L1008:
	ret
	.p2align 4,,10
	.p2align 3
.L1010:
	cmpl	$2147483647, %eax
	jne	.L1011
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1468, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE58:
	.size	math_prime_util__families__lucky_vectors__insert_vector__2, .-math_prime_util__families__lucky_vectors__insert_vector__2
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__append__3
	.type	math_prime_util__families__lucky_vectors__append__3, @function
math_prime_util__families__lucky_vectors__append__3:
.LFB27:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	8(%rdi), %rax
	movq	%rsi, %rdx
	movl	16(%rdi), %esi
	testq	%rax, %rax
	je	.L1017
	cmpl	%esi, (%rax)
	je	.L1017
	cmpl	$2147483647, %esi
	je	.L1026
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
.L1017:
	.cfi_restore_state
	cmpl	$2147483647, %esi
	je	.L1027
	addl	$1, %esi
	movl	$1, %ecx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__families__lucky_vectors__insert__4
.L1026:
	.cfi_restore_state
	movl	$223, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1027:
	movl	$229, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE27:
	.size	math_prime_util__families__lucky_vectors__append__3, .-math_prime_util__families__lucky_vectors__append__3
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert__5
	.type	math_prime_util__families__lucky_vectors__insert__5, @function
math_prime_util__families__lucky_vectors__insert__5:
.LFB60:
	.cfi_startproc
	testl	%r8d, %r8d
	je	.L1028
	movl	16(%rdi), %eax
	movq	%rcx, %r9
	testq	%rsi, %rsi
	je	.L1030
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L1032
.L1031:
	leal	1(%rax), %esi
.L1032:
	movl	%r8d, %ecx
	movq	%r9, %rdx
	jmp	math_prime_util__families__lucky_vectors__insert__4
	.p2align 4,,10
	.p2align 3
.L1028:
	ret
	.p2align 4,,10
	.p2align 3
.L1030:
	cmpl	$2147483647, %eax
	jne	.L1031
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1543, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE60:
	.size	math_prime_util__families__lucky_vectors__insert__5, .-math_prime_util__families__lucky_vectors__insert__5
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__delete_first
	.type	math_prime_util__families__lucky_vectors__delete_first, @function
math_prime_util__families__lucky_vectors__delete_first:
.LFB39:
	.cfi_startproc
	testl	%esi, %esi
	je	.L1036
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L1046
	addl	$1, %eax
	cmpl	%eax, %esi
	jl	.L1039
	movl	$-1, 16(%rdi)
	ret
	.p2align 4,,10
	.p2align 3
.L1036:
	ret
	.p2align 4,,10
	.p2align 3
.L1039:
	movl	%esi, %edx
	xorl	%esi, %esi
	jmp	math_prime_util__families__lucky_vectors__delete
.L1046:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__lucky_vectors__length.part.0
	.cfi_endproc
.LFE39:
	.size	math_prime_util__families__lucky_vectors__delete_first, .-math_prime_util__families__lucky_vectors__delete_first
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__delete_last
	.type	math_prime_util__families__lucky_vectors__delete_last, @function
math_prime_util__families__lucky_vectors__delete_last:
.LFB40:
	.cfi_startproc
	testl	%esi, %esi
	je	.L1058
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %eax
	cmpl	$2147483647, %eax
	je	.L1061
	leal	1(%rax), %edx
	cmpl	%edx, %esi
	jge	.L1062
	subl	%esi, %eax
	jo	.L1052
	movl	%eax, 16(%rdi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1062:
	.cfi_restore_state
	movl	$-1, 16(%rdi)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1058:
	ret
.L1061:
	.cfi_def_cfa_offset 16
	call	math_prime_util__families__lucky_vectors__length.part.0
.L1052:
	call	math_prime_util__families__lucky_vectors__delete_last.part.0
	.cfi_endproc
.LFE40:
	.size	math_prime_util__families__lucky_vectors__delete_last, .-math_prime_util__families__lucky_vectors__delete_last
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors___size__4.31, @function
math_prime_util__families__bitmask_sieve__word_vectors___size__4.31:
.LFB569:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE569:
	.size	math_prime_util__families__bitmask_sieve__word_vectors___size__4.31, .-math_prime_util__families__bitmask_sieve__word_vectors___size__4.31
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__iteratorDF__2.28, @function
math_prime_util__families__bitmask_sieve__word_vectors__iteratorDF__2.28:
.LFB563:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE563:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__iteratorDF__2.28, .-math_prime_util__families__bitmask_sieve__word_vectors__iteratorDF__2.28
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation___size__3.89, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation___size__3.89:
.LFB543:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE543:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation___size__3.89, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation___size__3.89
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__adjust.97, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__adjust.97:
.LFB533:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE533:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__adjust.97, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__adjust.97
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__last__3.21, @function
math_prime_util__families__bitmask_sieve__word_vectors__last__3.21:
.LFB275:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1071
	ret
	.p2align 4,,10
	.p2align 3
.L1071:
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
.LFE275:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__last__3.21, .-math_prime_util__families__bitmask_sieve__word_vectors__last__3.21
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__first__3.23, @function
math_prime_util__families__bitmask_sieve__word_vectors__first__3.23:
.LFB252:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1076
	ret
	.p2align 4,,10
	.p2align 3
.L1076:
	movl	16(%rcx), %eax
	xorl	%esi, %esi
	movq	%rsi, %rdx
	testl	%eax, %eax
	cmovs	%rsi, %rcx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE252:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__first__3.23, .-math_prime_util__families__bitmask_sieve__word_vectors__first__3.23
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__last__3
	.type	math_prime_util__families__lucky_vectors__last__3, @function
math_prime_util__families__lucky_vectors__last__3:
.LFB73:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1081
	ret
	.p2align 4,,10
	.p2align 3
.L1081:
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
	.size	math_prime_util__families__lucky_vectors__last__3, .-math_prime_util__families__lucky_vectors__last__3
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__first__3
	.type	math_prime_util__families__lucky_vectors__first__3, @function
math_prime_util__families__lucky_vectors__first__3:
.LFB50:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1086
	ret
	.p2align 4,,10
	.p2align 3
.L1086:
	movl	16(%rcx), %eax
	xorl	%esi, %esi
	movq	%rsi, %rdx
	testl	%eax, %eax
	cmovs	%rsi, %rcx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE50:
	.size	math_prime_util__families__lucky_vectors__first__3, .-math_prime_util__families__lucky_vectors__first__3
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__previous__4.20, @function
math_prime_util__families__bitmask_sieve__word_vectors__previous__4.20:
.LFB286:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1092
	leal	-1(%rdx), %eax
	testl	%edx, %edx
	jle	.L1093
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1093:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1092:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE286:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__previous__4.20, .-math_prime_util__families__bitmask_sieve__word_vectors__previous__4.20
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__next__4.22, @function
math_prime_util__families__bitmask_sieve__word_vectors__next__4.22:
.LFB281:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1099
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L1097
	xorl	%eax, %eax
	xorl	%ecx, %ecx
.L1097:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1099:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE281:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__next__4.22, .-math_prime_util__families__bitmask_sieve__word_vectors__next__4.22
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__first_index.174, @function
math_prime_util__families__bitmask_sieve__word_vectors__first_index.174:
.LFB577:
	.cfi_startproc
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE577:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__first_index.174, .-math_prime_util__families__bitmask_sieve__word_vectors__first_index.174
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__adjust
	.type	math_prime_util__families__lucky_vectors__implementation__adjust, @function
math_prime_util__families__lucky_vectors__implementation__adjust:
.LFB531:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE531:
	.size	math_prime_util__families__lucky_vectors__implementation__adjust, .-math_prime_util__families__lucky_vectors__implementation__adjust
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation___size__2
	.type	math_prime_util__families__lucky_vectors__implementation___size__2, @function
math_prime_util__families__lucky_vectors__implementation___size__2:
.LFB535:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE535:
	.size	math_prime_util__families__lucky_vectors__implementation___size__2, .-math_prime_util__families__lucky_vectors__implementation___size__2
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation___size__3
	.type	math_prime_util__families__lucky_vectors__implementation___size__3, @function
math_prime_util__families__lucky_vectors__implementation___size__3:
.LFB537:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE537:
	.size	math_prime_util__families__lucky_vectors__implementation___size__3, .-math_prime_util__families__lucky_vectors__implementation___size__3
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation___size.106, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation___size.106:
.LFB539:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE539:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation___size.106, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation___size.106
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation___size__2.95, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation___size__2.95:
.LFB541:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE541:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation___size__2.95, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation___size__2.95
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__reference_control_typeDF
	.type	math_prime_util__families__lucky_vectors__implementation__reference_control_typeDF, @function
math_prime_util__families__lucky_vectors__implementation__reference_control_typeDF:
.LFB547:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE547:
	.size	math_prime_util__families__lucky_vectors__implementation__reference_control_typeDF, .-math_prime_util__families__lucky_vectors__implementation__reference_control_typeDF
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__with_busyDF
	.type	math_prime_util__families__lucky_vectors__implementation__with_busyDF, @function
math_prime_util__families__lucky_vectors__implementation__with_busyDF:
.LFB549:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE549:
	.size	math_prime_util__families__lucky_vectors__implementation__with_busyDF, .-math_prime_util__families__lucky_vectors__implementation__with_busyDF
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__with_lockDF
	.type	math_prime_util__families__lucky_vectors__implementation__with_lockDF, @function
math_prime_util__families__lucky_vectors__implementation__with_lockDF:
.LFB551:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE551:
	.size	math_prime_util__families__lucky_vectors__implementation__with_lockDF, .-math_prime_util__families__lucky_vectors__implementation__with_lockDF
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__iteratorDF__2
	.type	math_prime_util__families__lucky_vectors__iteratorDF__2, @function
math_prime_util__families__lucky_vectors__iteratorDF__2:
.LFB553:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE553:
	.size	math_prime_util__families__lucky_vectors__iteratorDF__2, .-math_prime_util__families__lucky_vectors__iteratorDF__2
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeDA.99, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeDA.99:
.LFB555:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE555:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeDA.99, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeDA.99
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeDF.98, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeDF.98:
.LFB557:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE557:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeDF.98, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeDF.98
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_busyDF.93, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_busyDF.93:
.LFB559:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE559:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_busyDF.93, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_busyDF.93
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_lockDF.87, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_lockDF.87:
.LFB561:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE561:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_lockDF.87, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__with_lockDF.87
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors___size__4
	.type	math_prime_util__families__lucky_vectors___size__4, @function
math_prime_util__families__lucky_vectors___size__4:
.LFB565:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE565:
	.size	math_prime_util__families__lucky_vectors___size__4, .-math_prime_util__families__lucky_vectors___size__4
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors___size__2.79, @function
math_prime_util__families__bitmask_sieve__word_vectors___size__2.79:
.LFB567:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE567:
	.size	math_prime_util__families__bitmask_sieve__word_vectors___size__2.79, .-math_prime_util__families__bitmask_sieve__word_vectors___size__2.79
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T718b.203, @function
math_prime_util__families__bitmask_sieve__word_vectors__T718b.203:
.LFB582:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE582:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T718b.203, .-math_prime_util__families__bitmask_sieve__word_vectors__T718b.203
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T703b.204, @function
math_prime_util__families__bitmask_sieve__word_vectors__T703b.204:
.LFB583:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE583:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T703b.204, .-math_prime_util__families__bitmask_sieve__word_vectors__T703b.204
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T583s, @function
math_prime_util__families__lucky_vectors__T583s:
.LFB584:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE584:
	.size	math_prime_util__families__lucky_vectors__T583s, .-math_prime_util__families__lucky_vectors__T583s
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T555s, @function
math_prime_util__families__lucky_vectors__T555s:
.LFB585:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE585:
	.size	math_prime_util__families__lucky_vectors__T555s, .-math_prime_util__families__lucky_vectors__T555s
	.section	.text.unlikely
	.align 2
.LCOLDB27:
	.text
.LHOTB27:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__iterate__2
	.type	math_prime_util__families__lucky_vectors__iterate__2, @function
math_prime_util__families__lucky_vectors__iterate__2:
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
	je	.L1121
	cmpl	$2, %eax
	je	.L1136
	cmpl	$3, %eax
	je	.L1137
	cmpl	$4, %eax
	jne	.L1125
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.LEHE20:
.L1135:
	leaq	32+math_prime_util__families__lucky_vectors__math_prime_util__families__lucky_vectors__iterator_math_prime_util__families__lucky_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rdx
	movl	24(%rsp), %ecx
	leaq	8(%rax), %rbx
	movq	%rbp, 16(%rax)
	movq	.LC26(%rip), %xmm0
	movq	%rdx, %xmm1
	movl	$-1, 24(%rax)
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, (%rax)
	cmpl	$2, %ecx
	jne	.L1126
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
.L1121:
	.cfi_restore_state
	leaq	32+math_prime_util__families__lucky_vectors__math_prime_util__families__lucky_vectors__iterator_math_prime_util__families__lucky_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rax
	movq	%rbp, 16(%rbx)
	addq	$8, %rbx
	movq	.LC26(%rip), %xmm0
	movq	%rax, %xmm2
	movl	$-1, 16(%rbx)
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, -8(%rbx)
.L1126:
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
.L1136:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB22:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L1135
	.p2align 4,,10
	.p2align 3
.L1137:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L1135
.L1125:
	movl	$2058, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE22:
.L1130:
	movq	%rax, %rbx
	jmp	.L1128
	.section	.gcc_except_table
.LLSDA68:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE68-.LLSDACSB68
.LLSDACSB68:
	.uleb128 .LEHB20-.LFB68
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L1130-.LFB68
	.uleb128 0
	.uleb128 .LEHB21-.LFB68
	.uleb128 .LEHE21-.LEHB21
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB22-.LFB68
	.uleb128 .LEHE22-.LEHB22
	.uleb128 .L1130-.LFB68
	.uleb128 0
.LLSDACSE68:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC68
	.type	math_prime_util__families__lucky_vectors__iterate__2.cold, @function
math_prime_util__families__lucky_vectors__iterate__2.cold:
.LFSB68:
.L1128:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L1129
	movq	%rsp, %rdi
.LEHB23:
	call	system__secondary_stack__ss_release@PLT
.L1129:
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
	.uleb128 .LEHB23-.LCOLDB27
	.uleb128 .LEHE23-.LEHB23
	.uleb128 0
	.uleb128 0
.LLSDACSEC68:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__lucky_vectors__iterate__2, .-math_prime_util__families__lucky_vectors__iterate__2
	.section	.text.unlikely
	.size	math_prime_util__families__lucky_vectors__iterate__2.cold, .-math_prime_util__families__lucky_vectors__iterate__2.cold
.LCOLDE27:
	.text
.LHOTE27:
	.section	.text.unlikely
	.align 2
.LCOLDB28:
	.text
.LHOTB28:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__iterate__3
	.type	math_prime_util__families__lucky_vectors__iterate__3, @function
math_prime_util__families__lucky_vectors__iterate__3:
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
.LEHB24:
	call	system__secondary_stack__ss_mark@PLT
	movl	24(%rsp), %eax
	cmpl	$1, %eax
	je	.L1139
	cmpl	$2, %eax
	je	.L1154
	cmpl	$3, %eax
	je	.L1155
	cmpl	$4, %eax
	jne	.L1143
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.LEHE24:
.L1153:
	movq	.LC26(%rip), %xmm0
	leaq	32+math_prime_util__families__lucky_vectors__math_prime_util__families__lucky_vectors__iterator_math_prime_util__families__lucky_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rdx
	movl	24(%rsp), %ecx
	movl	%ebx, 24(%rax)
	movq	%rdx, %xmm1
	movq	%rbp, 16(%rax)
	leaq	8(%rax), %rbx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, (%rax)
	cmpl	$2, %ecx
	jne	.L1144
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
.L1139:
	.cfi_restore_state
	movq	.LC26(%rip), %xmm0
	movq	80(%rsp), %rax
	movl	%ebx, 24(%rax)
	movq	%rbp, 16(%rax)
	leaq	32+math_prime_util__families__lucky_vectors__math_prime_util__families__lucky_vectors__iterator_math_prime_util__families__lucky_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rax
	movq	%rax, %xmm2
	movq	80(%rsp), %rax
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, (%rax)
	leaq	8(%rax), %rbx
.L1144:
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
.L1154:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB26:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L1153
	.p2align 4,,10
	.p2align 3
.L1155:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L1153
.L1143:
	movl	$2111, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE26:
.L1148:
	movq	%rax, %rbx
	jmp	.L1146
	.section	.gcc_except_table
.LLSDA70:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE70-.LLSDACSB70
.LLSDACSB70:
	.uleb128 .LEHB24-.LFB70
	.uleb128 .LEHE24-.LEHB24
	.uleb128 .L1148-.LFB70
	.uleb128 0
	.uleb128 .LEHB25-.LFB70
	.uleb128 .LEHE25-.LEHB25
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB26-.LFB70
	.uleb128 .LEHE26-.LEHB26
	.uleb128 .L1148-.LFB70
	.uleb128 0
.LLSDACSE70:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC70
	.type	math_prime_util__families__lucky_vectors__iterate__3.cold, @function
math_prime_util__families__lucky_vectors__iterate__3.cold:
.LFSB70:
.L1146:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L1147
	movq	%rsp, %rdi
.LEHB27:
	call	system__secondary_stack__ss_release@PLT
.L1147:
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE27:
	.cfi_endproc
.LFE70:
	.section	.gcc_except_table
.LLSDAC70:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC70-.LLSDACSBC70
.LLSDACSBC70:
	.uleb128 .LEHB27-.LCOLDB28
	.uleb128 .LEHE27-.LEHB27
	.uleb128 0
	.uleb128 0
.LLSDACSEC70:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__lucky_vectors__iterate__3, .-math_prime_util__families__lucky_vectors__iterate__3
	.section	.text.unlikely
	.size	math_prime_util__families__lucky_vectors__iterate__3.cold, .-math_prime_util__families__lucky_vectors__iterate__3.cold
.LCOLDE28:
	.text
.LHOTE28:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__vectorSO__2.76, @function
math_prime_util__families__bitmask_sieve__word_vectors__vectorSO__2.76:
.LFB545:
	.cfi_startproc
	movl	$4, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__write.33
	.cfi_endproc
.LFE545:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__vectorSO__2.76, .-math_prime_util__families__bitmask_sieve__word_vectors__vectorSO__2.76
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__vectorSO__2
	.type	math_prime_util__families__lucky_vectors__vectorSO__2, @function
math_prime_util__families__lucky_vectors__vectorSO__2:
.LFB571:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__families__lucky_vectors__write
	.cfi_endproc
.LFE571:
	.size	math_prime_util__families__lucky_vectors__vectorSO__2, .-math_prime_util__families__lucky_vectors__vectorSO__2
	.section	.text.unlikely
	.align 2
.LCOLDB29:
	.text
.LHOTB29:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__iterate__2.157, @function
math_prime_util__families__bitmask_sieve__word_vectors__iterate__2.157:
.LFB270:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA270
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%rdx, %r14
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%r10, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%r8, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	leaq	96(%rsp), %rax
	movq	%rsp, %rdi
	movl	%esi, 24(%rsp)
	movq	%rax, 32(%rsp)
.LEHB28:
	call	system__secondary_stack__ss_mark@PLT
	movl	24(%rsp), %eax
	cmpl	$1, %eax
	je	.L1159
	cmpl	$2, %eax
	je	.L1172
	cmpl	$3, %eax
	je	.L1173
	cmpl	$4, %eax
	jne	.L1162
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.L1171:
	movq	%rax, %rbx
.L1159:
	leaq	32+ada__finalization__limited_controlledT(%rip), %rax
	movq	%r12, 16(%rbx)
	xorl	%r8d, %r8d
	movl	$1, %edx
	movq	%rax, (%rbx)
	movq	$-8, %rcx
	movl	$-1, 24(%rbx)
	movq	624(%rbp), %rax
	movq	%rax, (%rbx)
	movq	616(%rbp), %rax
	movq	%rax, 8(%rbx)
	movq	$-8, -16(%rax)
	movq	608(%rbp), %rsi
	movq	624(%rbp), %rdi
	call	ada__tags__register_interface_offset@PLT
	movq	616(%rbp), %rax
	xorl	%r8d, %r8d
	movl	$1, %edx
	movq	$-8, %rcx
	movq	%rax, 8(%rbx)
	movq	$-8, -16(%rax)
	movq	600(%rbp), %rsi
	movq	624(%rbp), %rdi
	call	ada__tags__register_interface_offset@PLT
.LEHE28:
	addq	$8, %rbx
	cmpl	$2, 24(%rsp)
	je	.L1158
	movq	%rsp, %rdi
.LEHB29:
	call	system__secondary_stack__ss_release@PLT
.LEHE29:
.L1158:
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1172:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB30:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L1171
	.p2align 4,,10
	.p2align 3
.L1173:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L1171
.L1162:
	movl	$2058, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE30:
.L1166:
	movq	%rax, %rbx
	jmp	.L1164
	.section	.gcc_except_table
.LLSDA270:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE270-.LLSDACSB270
.LLSDACSB270:
	.uleb128 .LEHB28-.LFB270
	.uleb128 .LEHE28-.LEHB28
	.uleb128 .L1166-.LFB270
	.uleb128 0
	.uleb128 .LEHB29-.LFB270
	.uleb128 .LEHE29-.LEHB29
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB30-.LFB270
	.uleb128 .LEHE30-.LEHB30
	.uleb128 .L1166-.LFB270
	.uleb128 0
.LLSDACSE270:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC270
	.type	math_prime_util__families__bitmask_sieve__word_vectors__iterate__2.157.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__iterate__2.157.cold:
.LFSB270:
.L1164:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L1165
	movq	%rsp, %rdi
.LEHB31:
	call	system__secondary_stack__ss_release@PLT
.L1165:
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE31:
	.cfi_endproc
.LFE270:
	.section	.gcc_except_table
.LLSDAC270:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC270-.LLSDACSBC270
.LLSDACSBC270:
	.uleb128 .LEHB31-.LCOLDB29
	.uleb128 .LEHE31-.LEHB31
	.uleb128 0
	.uleb128 0
.LLSDACSEC270:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__iterate__2.157, .-math_prime_util__families__bitmask_sieve__word_vectors__iterate__2.157
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__iterate__2.157.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__iterate__2.157.cold
.LCOLDE29:
	.text
.LHOTE29:
	.section	.text.unlikely
	.align 2
.LCOLDB30:
	.text
.LHOTB30:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__iterate__3.155, @function
math_prime_util__families__bitmask_sieve__word_vectors__iterate__3.155:
.LFB272:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA272
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%r8, %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%r10, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$48, %rsp
	.cfi_def_cfa_offset 96
	leaq	96(%rsp), %rax
	movq	%rsp, %rdi
	movl	%ecx, 24(%rsp)
	movq	96(%rsp), %rbx
	movq	%rax, 32(%rsp)
.LEHB32:
	call	system__secondary_stack__ss_mark@PLT
	movl	24(%rsp), %eax
	cmpl	$1, %eax
	je	.L1175
	cmpl	$2, %eax
	je	.L1188
	cmpl	$3, %eax
	je	.L1189
	cmpl	$4, %eax
	jne	.L1178
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.L1187:
	movq	%rax, %rbx
.L1175:
	leaq	32+ada__finalization__limited_controlledT(%rip), %rax
	movq	%r13, 16(%rbx)
	xorl	%r8d, %r8d
	movl	$1, %edx
	movq	%rax, (%rbx)
	movq	$-8, %rcx
	movl	%r12d, 24(%rbx)
	movq	624(%rbp), %rax
	movq	%rax, (%rbx)
	movq	616(%rbp), %rax
	movq	%rax, 8(%rbx)
	movq	$-8, -16(%rax)
	movq	608(%rbp), %rsi
	movq	624(%rbp), %rdi
	call	ada__tags__register_interface_offset@PLT
	movq	616(%rbp), %rax
	xorl	%r8d, %r8d
	movl	$1, %edx
	movq	$-8, %rcx
	movq	%rax, 8(%rbx)
	movq	$-8, -16(%rax)
	movq	600(%rbp), %rsi
	movq	624(%rbp), %rdi
	call	ada__tags__register_interface_offset@PLT
.LEHE32:
	addq	$8, %rbx
	cmpl	$2, 24(%rsp)
	je	.L1174
	movq	%rsp, %rdi
.LEHB33:
	call	system__secondary_stack__ss_release@PLT
.LEHE33:
.L1174:
	addq	$48, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1188:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB34:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L1187
	.p2align 4,,10
	.p2align 3
.L1189:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L1187
.L1178:
	movl	$2111, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE34:
.L1182:
	movq	%rax, %rbx
	jmp	.L1180
	.section	.gcc_except_table
.LLSDA272:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE272-.LLSDACSB272
.LLSDACSB272:
	.uleb128 .LEHB32-.LFB272
	.uleb128 .LEHE32-.LEHB32
	.uleb128 .L1182-.LFB272
	.uleb128 0
	.uleb128 .LEHB33-.LFB272
	.uleb128 .LEHE33-.LEHB33
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB34-.LFB272
	.uleb128 .LEHE34-.LEHB34
	.uleb128 .L1182-.LFB272
	.uleb128 0
.LLSDACSE272:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC272
	.type	math_prime_util__families__bitmask_sieve__word_vectors__iterate__3.155.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__iterate__3.155.cold:
.LFSB272:
.L1180:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L1181
	movq	%rsp, %rdi
.LEHB35:
	call	system__secondary_stack__ss_release@PLT
.L1181:
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE35:
	.cfi_endproc
.LFE272:
	.section	.gcc_except_table
.LLSDAC272:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC272-.LLSDACSBC272
.LLSDACSBC272:
	.uleb128 .LEHB35-.LCOLDB30
	.uleb128 .LEHE35-.LEHB35
	.uleb128 0
	.uleb128 0
.LLSDACSEC272:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__iterate__3.155, .-math_prime_util__families__bitmask_sieve__word_vectors__iterate__3.155
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__iterate__3.155.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__iterate__3.155.cold
.LCOLDE30:
	.text
.LHOTE30:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__previous__4
	.type	math_prime_util__families__lucky_vectors__previous__4, @function
math_prime_util__families__lucky_vectors__previous__4:
.LFB84:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1195
	leal	-1(%rdx), %eax
	testl	%edx, %edx
	jle	.L1196
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1196:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1195:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE84:
	.size	math_prime_util__families__lucky_vectors__previous__4, .-math_prime_util__families__lucky_vectors__previous__4
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T591s, @function
math_prime_util__families__lucky_vectors__T591s:
.LFB586:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1202
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L1200
	xorl	%eax, %eax
	xorl	%ecx, %ecx
.L1200:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1202:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE586:
	.size	math_prime_util__families__lucky_vectors__T591s, .-math_prime_util__families__lucky_vectors__T591s
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__next__4
	.type	math_prime_util__families__lucky_vectors__next__4, @function
math_prime_util__families__lucky_vectors__next__4:
.LFB79:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1208
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L1206
	xorl	%eax, %eax
	xorl	%ecx, %ecx
.L1206:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1208:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE79:
	.size	math_prime_util__families__lucky_vectors__next__4, .-math_prime_util__families__lucky_vectors__next__4
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__implementation__reference_control_typeSO
	.type	math_prime_util__families__lucky_vectors__implementation__reference_control_typeSO, @function
math_prime_util__families__lucky_vectors__implementation__reference_control_typeSO:
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
	.size	math_prime_util__families__lucky_vectors__implementation__reference_control_typeSO, .-math_prime_util__families__lucky_vectors__implementation__reference_control_typeSO
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSO.102, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSO.102:
.LFB332:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$5, %eax
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
.LFE332:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSO.102, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__reference_control_typeSO.102
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__implementation__T193b.137, @function
math_prime_util__families__bitmask_sieve__word_vectors__implementation__T193b.137:
.LFB325:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%r10, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	movl	$16, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movl	%esi, %ebp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movq	%r12, %rdi
	movq	%rax, %rbx
	movq	632(%r13), %rax
	movq	$0, 8(%rbx)
	movq	%rbx, %rsi
	movq	%rax, (%rbx)
	movl	$5, %eax
	cmpl	%eax, %ebp
	cmovle	%ebp, %eax
	movl	%eax, %edx
	call	ada__finalization__controlledSR__2@PLT
	movq	%r12, %rdi
	call	system__stream_attributes__i_as@PLT
	movq	%rax, 8(%rbx)
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE325:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__implementation__T193b.137, .-math_prime_util__families__bitmask_sieve__word_vectors__implementation__T193b.137
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__swap__2.38, @function
math_prime_util__families__bitmask_sieve__word_vectors__swap__2.38:
.LFB308:
	.cfi_startproc
	cmpl	%edx, %r8d
	je	.L1215
	movq	8(%rdi), %rax
	movslq	%r8d, %r8
	movslq	%edx, %rdx
	movl	4(%rax,%r8,4), %esi
	movl	4(%rax,%rdx,4), %ecx
	movl	%esi, 4(%rax,%rdx,4)
	movq	8(%rdi), %rax
	movl	%ecx, 4(%rax,%r8,4)
.L1215:
	ret
	.cfi_endproc
.LFE308:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__swap__2.38, .-math_prime_util__families__bitmask_sieve__word_vectors__swap__2.38
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__swap__2
	.type	math_prime_util__families__lucky_vectors__swap__2, @function
math_prime_util__families__lucky_vectors__swap__2:
.LFB106:
	.cfi_startproc
	cmpl	%edx, %r8d
	je	.L1217
	movq	8(%rdi), %rax
	movslq	%r8d, %r8
	movslq	%edx, %rdx
	movq	8(%rax,%r8,8), %rsi
	movq	8(%rax,%rdx,8), %rcx
	movq	%rsi, 8(%rax,%rdx,8)
	movq	8(%rdi), %rax
	movq	%rcx, 8(%rax,%r8,8)
.L1217:
	ret
	.cfi_endproc
.LFE106:
	.size	math_prime_util__families__lucky_vectors__swap__2, .-math_prime_util__families__lucky_vectors__swap__2
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72, @function
math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72:
.LFB355:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L1219
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1219:
	ret
	.cfi_endproc
.LFE355:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72, .-math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__vectorDF__2.73, @function
math_prime_util__families__bitmask_sieve__word_vectors__vectorDF__2.73:
.LFB362:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L1221
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1221:
	ret
	.cfi_endproc
.LFE362:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__vectorDF__2.73, .-math_prime_util__families__bitmask_sieve__word_vectors__vectorDF__2.73
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__append_vector.51, @function
math_prime_util__families__bitmask_sieve__word_vectors__append_vector.51:
.LFB228:
	.cfi_startproc
	movl	16(%rsi), %edx
	testl	%edx, %edx
	js	.L1223
	movq	%rsi, %rdx
	movl	16(%rdi), %esi
	cmpl	$2147483647, %esi
	je	.L1229
	addl	$1, %esi
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
	.p2align 4,,10
	.p2align 3
.L1223:
	ret
.L1229:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$197, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE228:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__append_vector.51, .-math_prime_util__families__bitmask_sieve__word_vectors__append_vector.51
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T765b.197, @function
math_prime_util__families__bitmask_sieve__word_vectors__T765b.197:
.LFB587:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1235
	leal	-1(%rdx), %eax
	testl	%edx, %edx
	jle	.L1236
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1236:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1235:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE587:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T765b.197, .-math_prime_util__families__bitmask_sieve__word_vectors__T765b.197
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T597s, @function
math_prime_util__families__lucky_vectors__T597s:
.LFB588:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1242
	leal	-1(%rdx), %eax
	testl	%edx, %edx
	jle	.L1243
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1243:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1242:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE588:
	.size	math_prime_util__families__lucky_vectors__T597s, .-math_prime_util__families__lucky_vectors__T597s
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__implementation__T138s, @function
math_prime_util__families__lucky_vectors__implementation__T138s:
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
	leaq	32+math_prime_util__families__lucky_vectors__implementation__reference_control_typeT(%rip), %rax
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
	.size	math_prime_util__families__lucky_vectors__implementation__T138s, .-math_prime_util__families__lucky_vectors__implementation__T138s
	.section	.text.unlikely
	.align 2
.LCOLDB31:
	.text
.LHOTB31:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__TtreeBFD.18, @function
math_prime_util__families__bitmask_sieve__TtreeBFD.18:
.LFB398:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA398
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	movq	%rbx, 24(%rsp)
	movq	%r12, 40(%rsp)
	.cfi_offset 3, -56
	.cfi_offset 12, -40
	movslq	(%rdi), %r12
.LEHB36:
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE36:
	movslq	4(%rbp), %rbx
	cmpl	%ebx, 0(%rbp)
	jg	.L1246
	movq	%r13, 48(%rsp)
	.cfi_offset 13, -32
	leaq	8(%rbp), %r13
	movq	%r14, 56(%rsp)
	.cfi_offset 14, -24
	movl	%eax, %r14d
	movq	%r15, 64(%rsp)
	.cfi_offset 15, -16
	xorl	%r15d, %r15d
	.p2align 4
	.p2align 3
.L1251:
	movq	%rbx, %rax
	subq	%r12, %rax
	salq	$5, %rax
	movl	$-1, 16(%r13,%rax)
	movq	8(%r13,%rax), %rdi
	movq	$0, 8(%r13,%rax)
	testq	%rdi, %rdi
	je	.L1249
.LEHB37:
	call	__gnat_free@PLT
.LEHE37:
.L1249:
	subq	$1, %rbx
	leal	1(%rbx), %eax
	cmpl	0(%rbp), %eax
	jne	.L1251
	movl	%r14d, %eax
	xorl	$1, %eax
	testb	%al, %r15b
	jne	.L1261
	movq	48(%rsp), %r13
	.cfi_restore 13
	movq	56(%rsp), %r14
	.cfi_restore 14
	movq	64(%rsp), %r15
	.cfi_restore 15
.L1246:
	movq	24(%rsp), %rbx
	movq	32(%rsp), %rbp
	movq	40(%rsp), %r12
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
.L1261:
	.cfi_def_cfa_offset 80
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	$116, %esi
	leaq	.LC12(%rip), %rdi
.LEHB38:
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.LEHE38:
.L1254:
	movq	%rax, %rdi
	jmp	.L1252
	.section	.gcc_except_table
	.align 4
.LLSDA398:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT398-.LLSDATTD398
.LLSDATTD398:
	.byte	0x1
	.uleb128 .LLSDACSE398-.LLSDACSB398
.LLSDACSB398:
	.uleb128 .LEHB36-.LFB398
	.uleb128 .LEHE36-.LEHB36
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB37-.LFB398
	.uleb128 .LEHE37-.LEHB37
	.uleb128 .L1254-.LFB398
	.uleb128 0x1
	.uleb128 .LEHB38-.LFB398
	.uleb128 .LEHE38-.LEHB38
	.uleb128 0
	.uleb128 0
.LLSDACSE398:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT398:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC398
	.type	math_prime_util__families__bitmask_sieve__TtreeBFD.18.cold, @function
math_prime_util__families__bitmask_sieve__TtreeBFD.18.cold:
.LFSB398:
.L1252:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	subq	$1, %rdx
	jne	.L1262
	movq	%rax, 8(%rsp)
	movl	$1, %r15d
	call	__gnat_begin_handler_v1@PLT
	movq	8(%rsp), %rdi
	xorl	%edx, %edx
	movq	%rax, %rsi
.LEHB39:
	call	__gnat_end_handler_v1@PLT
	jmp	.L1249
.L1262:
	call	_Unwind_Resume@PLT
.LEHE39:
	.cfi_endproc
.LFE398:
	.section	.gcc_except_table
	.align 4
.LLSDAC398:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC398-.LLSDATTDC398
.LLSDATTDC398:
	.byte	0x1
	.uleb128 .LLSDACSEC398-.LLSDACSBC398
.LLSDACSBC398:
	.uleb128 .LEHB39-.LCOLDB31
	.uleb128 .LEHE39-.LEHB39
	.uleb128 0
	.uleb128 0
.LLSDACSEC398:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC398:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__TtreeBFD.18, .-math_prime_util__families__bitmask_sieve__TtreeBFD.18
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__TtreeBFD.18.cold, .-math_prime_util__families__bitmask_sieve__TtreeBFD.18.cold
.LCOLDE31:
	.text
.LHOTE31:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__vectorFD
	.type	math_prime_util__families__lucky_vectors__vectorFD, @function
math_prime_util__families__lucky_vectors__vectorFD:
.LFB152:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L1263
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1263:
	ret
	.cfi_endproc
.LFE152:
	.size	math_prime_util__families__lucky_vectors__vectorFD, .-math_prime_util__families__lucky_vectors__vectorFD
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__vectorDF__2
	.type	math_prime_util__families__lucky_vectors__vectorDF__2, @function
math_prime_util__families__lucky_vectors__vectorDF__2:
.LFB159:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$-1, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L1265
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1265:
	ret
	.cfi_endproc
.LFE159:
	.size	math_prime_util__families__lucky_vectors__vectorDF__2, .-math_prime_util__families__lucky_vectors__vectorDF__2
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__assign.63, @function
math_prime_util__families__bitmask_sieve__word_vectors__assign.63:
.LFB231:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L1267
	movl	$-1, 16(%rdi)
	movl	16(%rsi), %eax
	testl	%eax, %eax
	js	.L1267
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
	.p2align 4,,10
	.p2align 3
.L1267:
	ret
	.cfi_endproc
.LFE231:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__assign.63, .-math_prime_util__families__bitmask_sieve__word_vectors__assign.63
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__assign
	.type	math_prime_util__families__lucky_vectors__assign, @function
math_prime_util__families__lucky_vectors__assign:
.LFB29:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L1269
	movl	$-1, 16(%rdi)
	movl	16(%rsi), %eax
	testl	%eax, %eax
	js	.L1269
	movq	%rsi, %rdx
	xorl	%esi, %esi
	jmp	math_prime_util__families__lucky_vectors__insert_vector
	.p2align 4,,10
	.p2align 3
.L1269:
	ret
	.cfi_endproc
.LFE29:
	.size	math_prime_util__families__lucky_vectors__assign, .-math_prime_util__families__lucky_vectors__assign
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__append__3.50, @function
math_prime_util__families__bitmask_sieve__word_vectors__append__3.50:
.LFB229:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	8(%rdi), %rax
	movl	%esi, %edx
	movl	16(%rdi), %esi
	testq	%rax, %rax
	je	.L1272
	cmpl	%esi, (%rax)
	je	.L1272
	cmpl	$2147483647, %esi
	je	.L1281
	addl	$1, %esi
	movslq	%esi, %rcx
	movl	%edx, 4(%rax,%rcx,4)
	movl	%esi, 16(%rdi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1272:
	.cfi_restore_state
	cmpl	$2147483647, %esi
	je	.L1282
	addl	$1, %esi
	movl	$1, %ecx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
.L1281:
	.cfi_restore_state
	movl	$223, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1282:
	movl	$229, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE229:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__append__3.50, .-math_prime_util__families__bitmask_sieve__word_vectors__append__3.50
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T588s, @function
math_prime_util__families__lucky_vectors__T588s:
.LFB589:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1287
	ret
	.p2align 4,,10
	.p2align 3
.L1287:
	movl	16(%rcx), %eax
	xorl	%esi, %esi
	movq	%rsi, %rdx
	testl	%eax, %eax
	cmovs	%rsi, %rcx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE589:
	.size	math_prime_util__families__lucky_vectors__T588s, .-math_prime_util__families__lucky_vectors__T588s
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__read.32, @function
math_prime_util__families__bitmask_sieve__word_vectors__read.32:
.LFB293:
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
	je	.L1289
	movl	(%r12), %eax
	testl	%eax, %eax
	js	.L1289
	cmpl	$2147483647, %eax
	je	.L1302
	addl	$1, %eax
	cmpl	%eax, %ebx
	jg	.L1301
	testl	%ebx, %ebx
	jle	.L1288
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
.L1294:
	leal	-1(%rbx), %r14d
	xorl	%ebx, %ebx
	jmp	.L1295
	.p2align 4,,10
	.p2align 3
.L1303:
	movq	8(%rbp), %r12
	addq	$1, %rbx
.L1295:
	movq	%r13, %rdi
	call	system__stream_attributes__i_u@PLT
	movl	%eax, 4(%r12,%rbx,4)
	movl	%ebx, 16(%rbp)
	cmpq	%r14, %rbx
	jne	.L1303
	movq	32(%rsp), %r14
	.cfi_restore 14
.L1288:
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
.L1289:
	.cfi_restore_state
	testl	%ebx, %ebx
	jle	.L1288
.L1301:
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r14, 32(%rsp)
	.cfi_remember_state
	.cfi_offset 14, -16
	call	math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70
	movq	8(%rbp), %r12
	jmp	.L1294
.L1302:
	.cfi_restore_state
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	call	math_prime_util__families__bitmask_sieve__word_vectors__capacity.71.part.0
	.cfi_endproc
.LFE293:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__read.32, .-math_prime_util__families__bitmask_sieve__word_vectors__read.32
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__vectorSR__2.78, @function
math_prime_util__families__bitmask_sieve__word_vectors__vectorSR__2.78:
.LFB380:
	.cfi_startproc
	movl	$4, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__read.32
	.cfi_endproc
.LFE380:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__vectorSR__2.78, .-math_prime_util__families__bitmask_sieve__word_vectors__vectorSR__2.78
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__read
	.type	math_prime_util__families__lucky_vectors__read, @function
math_prime_util__families__lucky_vectors__read:
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
	je	.L1306
	movl	(%r12), %eax
	testl	%eax, %eax
	js	.L1306
	cmpl	$2147483647, %eax
	je	.L1319
	addl	$1, %eax
	cmpl	%eax, %ebx
	jg	.L1318
	testl	%ebx, %ebx
	jle	.L1305
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
.L1311:
	leal	-1(%rbx), %r14d
	xorl	%ebx, %ebx
	jmp	.L1312
	.p2align 4,,10
	.p2align 3
.L1320:
	movq	8(%rbp), %r12
	addq	$1, %rbx
.L1312:
	movq	%r13, %rdi
	call	system__stream_attributes__i_lu@PLT
	movq	%rax, 8(%r12,%rbx,8)
	movl	%ebx, 16(%rbp)
	cmpq	%r14, %rbx
	jne	.L1320
	movq	32(%rsp), %r14
	.cfi_restore 14
.L1305:
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
.L1306:
	.cfi_restore_state
	testl	%ebx, %ebx
	jle	.L1305
.L1318:
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r14, 32(%rsp)
	.cfi_remember_state
	.cfi_offset 14, -16
	call	math_prime_util__families__lucky_vectors__reserve_capacity
	movq	8(%rbp), %r12
	jmp	.L1311
.L1319:
	.cfi_restore_state
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	call	math_prime_util__families__lucky_vectors__capacity.part.0
	.cfi_endproc
.LFE91:
	.size	math_prime_util__families__lucky_vectors__read, .-math_prime_util__families__lucky_vectors__read
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__vectorSR__2
	.type	math_prime_util__families__lucky_vectors__vectorSR__2, @function
math_prime_util__families__lucky_vectors__vectorSR__2:
.LFB169:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__families__lucky_vectors__read
	.cfi_endproc
.LFE169:
	.size	math_prime_util__families__lucky_vectors__vectorSR__2, .-math_prime_util__families__lucky_vectors__vectorSR__2
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T759b.198, @function
math_prime_util__families__bitmask_sieve__word_vectors__T759b.198:
.LFB590:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1326
	ret
	.p2align 4,,10
	.p2align 3
.L1326:
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
.LFE590:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T759b.198, .-math_prime_util__families__bitmask_sieve__word_vectors__T759b.198
	.align 2
	.p2align 4
	.type	math_prime_util__families__lucky_vectors__T594s, @function
math_prime_util__families__lucky_vectors__T594s:
.LFB591:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1331
	ret
	.p2align 4,,10
	.p2align 3
.L1331:
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
.LFE591:
	.size	math_prime_util__families__lucky_vectors__T594s, .-math_prime_util__families__lucky_vectors__T594s
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T753b.199, @function
math_prime_util__families__bitmask_sieve__word_vectors__T753b.199:
.LFB592:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1337
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L1335
	xorl	%eax, %eax
	xorl	%ecx, %ecx
.L1335:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1337:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE592:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T753b.199, .-math_prime_util__families__bitmask_sieve__word_vectors__T753b.199
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T741b.201, @function
math_prime_util__families__bitmask_sieve__word_vectors__T741b.201:
.LFB593:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L1343
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L1341
	xorl	%eax, %eax
	xorl	%ecx, %ecx
.L1341:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1343:
	xorl	%eax, %eax
	xorl	%edx, %edx
	ret
	.cfi_endproc
.LFE593:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T741b.201, .-math_prime_util__families__bitmask_sieve__word_vectors__T741b.201
	.section	.text.unlikely
	.align 2
.LCOLDB32:
	.text
.LHOTB32:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors___assign__2.75, @function
math_prime_util__families__bitmask_sieve__word_vectors___assign__2.75:
.LFB360:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA360
	subq	$664, %rsp
	.cfi_def_cfa_offset 672
	movq	%rbx, 640(%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%rbp, 648(%rsp)
	.cfi_offset 6, -24
	movq	%rsi, %rbp
.LEHB40:
	call	*system__soft_links__abort_defer(%rip)
.LEHE40:
	cmpq	%rbp, %rbx
	jne	.L1345
.L1347:
	movq	640(%rsp), %rbx
	movq	648(%rsp), %rbp
	addq	$664, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
.LEHB41:
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE41:
	.p2align 4,,10
	.p2align 3
.L1345:
	.cfi_restore_state
	movq	8(%rbx), %rdi
	movl	$-1, 16(%rbx)
	movq	$0, 8(%rbx)
	testq	%rdi, %rdi
	je	.L1348
.LEHB42:
	call	__gnat_free@PLT
.L1348:
	movdqu	0(%rbp), %xmm0
	movq	(%rbx), %rax
	movq	%rbx, %rdi
	movups	%xmm0, (%rbx)
	movdqu	16(%rbp), %xmm0
	movq	%rax, (%rbx)
	movups	%xmm0, 16(%rbx)
	call	math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.81
.LEHE42:
	jmp	.L1347
.L1354:
	movq	%rax, %rbp
	jmp	.L1349
.L1356:
	jmp	.L1357
	.section	.gcc_except_table
	.align 4
.LLSDA360:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT360-.LLSDATTD360
.LLSDATTD360:
	.byte	0x1
	.uleb128 .LLSDACSE360-.LLSDACSB360
.LLSDACSB360:
	.uleb128 .LEHB40-.LFB360
	.uleb128 .LEHE40-.LEHB40
	.uleb128 .L1356-.LFB360
	.uleb128 0
	.uleb128 .LEHB41-.LFB360
	.uleb128 .LEHE41-.LEHB41
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB42-.LFB360
	.uleb128 .LEHE42-.LEHB42
	.uleb128 .L1354-.LFB360
	.uleb128 0x3
.LLSDACSE360:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT360:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC360
	.type	math_prime_util__families__bitmask_sieve__word_vectors___assign__2.75.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors___assign__2.75.cold:
.LFSB360:
.L1349:
	.cfi_def_cfa_offset 672
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	subq	$1, %rdx
	jne	.L1359
	movq	%rax, %rdi
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movq	%rax, %r14
.LEHB43:
	call	__gnat_set_exception_parameter@PLT
	movq	%rsp, %rdi
	call	__gnat_raise_from_controlled_operation@PLT
.LEHE43:
.L1353:
	movq	656(%rsp), %r14
	.cfi_restore 14
.L1357:
	movq	%r14, 656(%rsp)
	movq	%rax, %rbx
	.cfi_offset 14, -16
.L1351:
.LEHB44:
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE44:
.L1359:
	.cfi_restore 14
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	movq	%rax, %rbx
	jmp	.L1351
.L1355:
	movq	%rax, %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
.LEHB45:
	call	__gnat_end_handler_v1@PLT
.LEHE45:
	jmp	.L1351
	.cfi_endproc
.LFE360:
	.section	.gcc_except_table
	.align 4
.LLSDAC360:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC360-.LLSDATTDC360
.LLSDATTDC360:
	.byte	0x1
	.uleb128 .LLSDACSEC360-.LLSDACSBC360
.LLSDACSBC360:
	.uleb128 .LEHB43-.LCOLDB32
	.uleb128 .LEHE43-.LEHB43
	.uleb128 .L1355-.LCOLDB32
	.uleb128 0
	.uleb128 .LEHB44-.LCOLDB32
	.uleb128 .LEHE44-.LEHB44
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB45-.LCOLDB32
	.uleb128 .LEHE45-.LEHB45
	.uleb128 .L1353-.LCOLDB32
	.uleb128 0
.LLSDACSEC360:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC360:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors___assign__2.75, .-math_prime_util__families__bitmask_sieve__word_vectors___assign__2.75
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors___assign__2.75.cold, .-math_prime_util__families__bitmask_sieve__word_vectors___assign__2.75.cold
.LCOLDE32:
	.text
.LHOTE32:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T747b.200, @function
math_prime_util__families__bitmask_sieve__word_vectors__T747b.200:
.LFB594:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1364
	ret
	.p2align 4,,10
	.p2align 3
.L1364:
	movl	16(%rcx), %eax
	xorl	%esi, %esi
	movq	%rsi, %rdx
	testl	%eax, %eax
	cmovs	%rsi, %rcx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE594:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T747b.200, .-math_prime_util__families__bitmask_sieve__word_vectors__T747b.200
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T735b.202, @function
math_prime_util__families__bitmask_sieve__word_vectors__T735b.202:
.LFB595:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rcx
	movq	%rax, %rsi
	movq	%rax, %rdx
	movq	%rcx, %rax
	cmpl	$-1, %esi
	je	.L1369
	ret
	.p2align 4,,10
	.p2align 3
.L1369:
	movl	16(%rcx), %eax
	xorl	%esi, %esi
	movq	%rsi, %rdx
	testl	%eax, %eax
	cmovs	%rsi, %rcx
	movq	%rcx, %rax
	ret
	.cfi_endproc
.LFE595:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T735b.202, .-math_prime_util__families__bitmask_sieve__word_vectors__T735b.202
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__set_length
	.type	math_prime_util__families__lucky_vectors__set_length, @function
math_prime_util__families__lucky_vectors__set_length:
.LFB104:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %ecx
	cmpl	$2147483647, %ecx
	je	.L1384
	movl	%esi, %eax
	leal	1(%rcx), %esi
	movl	%esi, %edx
	subl	%eax, %edx
	jo	.L1373
	testl	%edx, %edx
	jns	.L1385
	cmpl	$-2147483648, %edx
	je	.L1386
	negl	%edx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__families__lucky_vectors__insert_space
	.p2align 4,,10
	.p2align 3
.L1385:
	.cfi_restore_state
	je	.L1370
	subl	%edx, %ecx
	movl	$-1, %eax
	cmpl	%edx, %esi
	cmovg	%ecx, %eax
	movl	%eax, 16(%rdi)
.L1370:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L1373:
	.cfi_restore_state
	movl	$2993, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1384:
	call	math_prime_util__families__lucky_vectors__length.part.0
.L1386:
	movl	$3010, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE104:
	.size	math_prime_util__families__lucky_vectors__set_length, .-math_prime_util__families__lucky_vectors__set_length
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector__2.60, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert_vector__2.60:
.LFB260:
	.cfi_startproc
	movl	16(%rcx), %r8d
	testl	%r8d, %r8d
	js	.L1387
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L1389
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L1391
.L1390:
	leal	1(%rax), %esi
.L1391:
	movq	%rcx, %rdx
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
	.p2align 4,,10
	.p2align 3
.L1387:
	ret
	.p2align 4,,10
	.p2align 3
.L1389:
	cmpl	$2147483647, %eax
	jne	.L1390
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1468, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE260:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector__2.60, .-math_prime_util__families__bitmask_sieve__word_vectors__insert_vector__2.60
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert__5.57, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert__5.57:
.LFB262:
	.cfi_startproc
	testl	%r8d, %r8d
	je	.L1395
	movl	16(%rdi), %eax
	movl	%ecx, %r9d
	testq	%rsi, %rsi
	je	.L1397
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L1399
.L1398:
	leal	1(%rax), %esi
.L1399:
	movl	%r8d, %ecx
	movl	%r9d, %edx
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
	.p2align 4,,10
	.p2align 3
.L1395:
	ret
	.p2align 4,,10
	.p2align 3
.L1397:
	cmpl	$2147483647, %eax
	jne	.L1398
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1543, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE262:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert__5.57, .-math_prime_util__families__bitmask_sieve__word_vectors__insert__5.57
	.section	.text.unlikely
	.align 2
.LCOLDB33:
	.text
.LHOTB33:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors___assign__2
	.type	math_prime_util__families__lucky_vectors___assign__2, @function
math_prime_util__families__lucky_vectors___assign__2:
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
.LEHB46:
	call	*system__soft_links__abort_defer(%rip)
.LEHE46:
	cmpq	%rbp, %rbx
	jne	.L1404
.L1406:
	movq	640(%rsp), %rbx
	movq	648(%rsp), %rbp
	addq	$664, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
.LEHB47:
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE47:
	.p2align 4,,10
	.p2align 3
.L1404:
	.cfi_restore_state
	movq	8(%rbx), %rdi
	movl	$-1, 16(%rbx)
	movq	$0, 8(%rbx)
	testq	%rdi, %rdi
	je	.L1407
.LEHB48:
	call	__gnat_free@PLT
.L1407:
	movdqu	0(%rbp), %xmm0
	movq	(%rbx), %rax
	movq	%rbx, %rdi
	movups	%xmm0, (%rbx)
	movdqu	16(%rbp), %xmm0
	movq	%rax, (%rbx)
	movups	%xmm0, 16(%rbx)
	call	math_prime_util__families__lucky_vectors__adjust__2
.LEHE48:
	jmp	.L1406
.L1413:
	movq	%rax, %rbp
	jmp	.L1408
.L1415:
	jmp	.L1416
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
	.uleb128 .LEHB46-.LFB157
	.uleb128 .LEHE46-.LEHB46
	.uleb128 .L1415-.LFB157
	.uleb128 0
	.uleb128 .LEHB47-.LFB157
	.uleb128 .LEHE47-.LEHB47
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB48-.LFB157
	.uleb128 .LEHE48-.LEHB48
	.uleb128 .L1413-.LFB157
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
	.type	math_prime_util__families__lucky_vectors___assign__2.cold, @function
math_prime_util__families__lucky_vectors___assign__2.cold:
.LFSB157:
.L1408:
	.cfi_def_cfa_offset 672
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	subq	$1, %rdx
	jne	.L1418
	movq	%rax, %rdi
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movq	%rax, %r14
.LEHB49:
	call	__gnat_set_exception_parameter@PLT
	movq	%rsp, %rdi
	call	__gnat_raise_from_controlled_operation@PLT
.LEHE49:
.L1412:
	movq	656(%rsp), %r14
	.cfi_restore 14
.L1416:
	movq	%r14, 656(%rsp)
	movq	%rax, %rbx
	.cfi_offset 14, -16
.L1410:
.LEHB50:
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE50:
.L1418:
	.cfi_restore 14
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	movq	%rax, %rbx
	jmp	.L1410
.L1414:
	movq	%rax, %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
.LEHB51:
	call	__gnat_end_handler_v1@PLT
.LEHE51:
	jmp	.L1410
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
	.uleb128 .LEHB49-.LCOLDB33
	.uleb128 .LEHE49-.LEHB49
	.uleb128 .L1414-.LCOLDB33
	.uleb128 0
	.uleb128 .LEHB50-.LCOLDB33
	.uleb128 .LEHE50-.LEHB50
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB51-.LCOLDB33
	.uleb128 .LEHE51-.LEHB51
	.uleb128 .L1412-.LCOLDB33
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
	.size	math_prime_util__families__lucky_vectors___assign__2, .-math_prime_util__families__lucky_vectors___assign__2
	.section	.text.unlikely
	.size	math_prime_util__families__lucky_vectors___assign__2.cold, .-math_prime_util__families__lucky_vectors___assign__2.cold
.LCOLDE33:
	.text
.LHOTE33:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__set_length.68, @function
math_prime_util__families__bitmask_sieve__word_vectors__set_length.68:
.LFB306:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %ecx
	cmpl	$2147483647, %ecx
	je	.L1433
	movl	%esi, %eax
	leal	1(%rcx), %esi
	movl	%esi, %edx
	subl	%eax, %edx
	jo	.L1422
	testl	%edx, %edx
	jns	.L1434
	cmpl	$-2147483648, %edx
	je	.L1435
	negl	%edx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert_space.48
	.p2align 4,,10
	.p2align 3
.L1434:
	.cfi_restore_state
	je	.L1419
	subl	%edx, %ecx
	movl	$-1, %eax
	cmpl	%edx, %esi
	cmovg	%ecx, %eax
	movl	%eax, 16(%rdi)
.L1419:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L1422:
	.cfi_restore_state
	movl	$2993, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1433:
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.L1435:
	movl	$3010, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE306:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__set_length.68, .-math_prime_util__families__bitmask_sieve__word_vectors__set_length.68
	.align 2
	.p2align 4
	.type	math_prime_util__families__simple_upper, @function
math_prime_util__families__simple_upper:
.LFB413:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	testq	%rdi, %rdi
	js	.L1437
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rdi, %xmm1
.L1438:
	movapd	%xmm1, %xmm0
	movsd	%xmm1, 8(%rsp)
	call	ada__numerics__long_elementary_functions__log@PLT
	cmpq	$7000, %rbx
	movsd	8(%rsp), %xmm1
	jbe	.L1463
	cmpq	$10016999, %rbx
	jbe	.L1464
	movsd	.LC34(%rip), %xmm3
.L1446:
	movsd	.LC43(%rip), %xmm2
	mulsd	%xmm0, %xmm2
	subsd	%xmm3, %xmm2
	movsd	.LC44(%rip), %xmm3
	divsd	%xmm0, %xmm3
	mulsd	%xmm0, %xmm0
	subsd	%xmm3, %xmm2
	movsd	.LC45(%rip), %xmm3
	divsd	%xmm0, %xmm3
	subsd	%xmm3, %xmm2
	divsd	%xmm2, %xmm1
.L1462:
	movapd	%xmm1, %xmm0
	call	system__fat_lflt__attr_long_float__floor@PLT
	pxor	%xmm1, %xmm1
	comisd	%xmm1, %xmm0
	jb	.L1456
	addsd	.LC38(%rip), %xmm0
.L1449:
	movsd	.LC39(%rip), %xmm1
	comisd	%xmm1, %xmm0
	jnb	.L1450
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	cvttsd2siq	%xmm0, %rax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1464:
	.cfi_restore_state
	movapd	%xmm1, %xmm2
	subsd	.LC40(%rip), %xmm2
	movsd	.LC42(%rip), %xmm3
	mulsd	.LC41(%rip), %xmm2
	subsd	%xmm2, %xmm3
	jmp	.L1446
	.p2align 4,,10
	.p2align 3
.L1450:
	subsd	%xmm1, %xmm0
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	cvttsd2siq	%xmm0, %rax
	btcq	$63, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1456:
	.cfi_restore_state
	subsd	.LC38(%rip), %xmm0
	jmp	.L1449
	.p2align 4,,10
	.p2align 3
.L1437:
	movq	%rdi, %rax
	movq	%rdi, %rdx
	pxor	%xmm1, %xmm1
	shrq	%rax
	andl	$1, %edx
	orq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm1
	addsd	%xmm1, %xmm1
	jmp	.L1438
	.p2align 4,,10
	.p2align 3
.L1463:
	mulsd	.LC35(%rip), %xmm1
	divsd	%xmm0, %xmm1
	addsd	.LC36(%rip), %xmm1
	jmp	.L1462
	.cfi_endproc
.LFE413:
	.size	math_prime_util__families__simple_upper, .-math_prime_util__families__simple_upper
	.align 2
	.p2align 4
	.type	math_prime_util__families__invert__linear.179, @function
math_prime_util__families__invert__linear.179:
.LFB417:
	.cfi_startproc
	movq	32(%r10), %rdx
	movq	24(%r10), %rsi
	cmpq	%rsi, %rdx
	je	.L1497
	movq	8(%r10), %rcx
	movq	(%r10), %rdi
	cmpq	%rcx, %rdx
	je	.L1494
	movq	16(%r10), %rax
	movq	%rdi, %r8
	subq	%rax, %r8
	js	.L1469
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%r8, %xmm1
	subq	%rsi, %rdx
	js	.L1471
.L1499:
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	mulsd	%xmm1, %xmm0
	subq	%rsi, %rcx
	js	.L1473
.L1500:
	pxor	%xmm2, %xmm2
	cvtsi2sdq	%rcx, %xmm2
.L1474:
	divsd	%xmm2, %xmm0
	addsd	.LC46(%rip), %xmm0
	comisd	%xmm1, %xmm0
	jb	.L1490
	testq	%r8, %r8
	je	.L1498
.L1494:
	leaq	-1(%rdi), %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1469:
	movq	%r8, %r9
	movq	%r8, %r10
	pxor	%xmm1, %xmm1
	shrq	%r9
	andl	$1, %r10d
	orq	%r10, %r9
	cvtsi2sdq	%r9, %xmm1
	addsd	%xmm1, %xmm1
	subq	%rsi, %rdx
	jns	.L1499
.L1471:
	movq	%rdx, %r9
	andl	$1, %edx
	pxor	%xmm0, %xmm0
	shrq	%r9
	orq	%rdx, %r9
	cvtsi2sdq	%r9, %xmm0
	addsd	%xmm0, %xmm0
	mulsd	%xmm1, %xmm0
	subq	%rsi, %rcx
	jns	.L1500
.L1473:
	movq	%rcx, %rdx
	andl	$1, %ecx
	pxor	%xmm2, %xmm2
	shrq	%rdx
	orq	%rcx, %rdx
	cvtsi2sdq	%rdx, %xmm2
	addsd	%xmm2, %xmm2
	jmp	.L1474
	.p2align 4,,10
	.p2align 3
.L1490:
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, 24(%rsp)
	movq	%rax, 16(%rsp)
	movq	%r8, 8(%rsp)
	call	system__fat_lflt__attr_long_float__floor@PLT
	pxor	%xmm1, %xmm1
	movq	8(%rsp), %r8
	movq	16(%rsp), %rax
	comisd	%xmm1, %xmm0
	movq	24(%rsp), %rdi
	jb	.L1491
	addsd	.LC38(%rip), %xmm0
	movsd	.LC39(%rip), %xmm1
	comisd	%xmm1, %xmm0
	jnb	.L1481
.L1503:
	cvttsd2siq	%xmm0, %rdx
	testq	%rdx, %rdx
	je	.L1501
.L1483:
	cmpq	%r8, %rdx
	jnb	.L1502
	addq	%rdx, %rax
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1497:
	movq	16(%r10), %rax
	addq	$1, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1491:
	.cfi_def_cfa_offset 48
	subsd	.LC38(%rip), %xmm0
	movsd	.LC39(%rip), %xmm1
	comisd	%xmm1, %xmm0
	jb	.L1503
.L1481:
	subsd	%xmm1, %xmm0
	cvttsd2siq	%xmm0, %rdx
	btcq	$63, %rdx
	testq	%rdx, %rdx
	jne	.L1483
.L1501:
	addq	$1, %rax
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1498:
	addq	$1, %rax
	ret
.L1502:
	.cfi_def_cfa_offset 48
	leaq	-1(%rdi), %rax
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE417:
	.size	math_prime_util__families__invert__linear.179, .-math_prime_util__families__invert__linear.179
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__insert__8.54, @function
math_prime_util__families__bitmask_sieve__word_vectors__insert__8.54:
.LFB265:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%r8, %r11
	testl	%r9d, %r9d
	jne	.L1505
	testq	%rsi, %rsi
	je	.L1511
	cmpl	16(%rdi), %edx
	jle	.L1513
.L1511:
	xorl	%edi, %edi
	jmp	.L1506
	.p2align 4,,10
	.p2align 3
.L1505:
	movl	16(%rdi), %r8d
	movq	%rcx, %r10
	testq	%rsi, %rsi
	je	.L1507
	movl	%edx, %eax
	cmpl	%r8d, %edx
	jg	.L1508
.L1509:
	movl	%r9d, %ecx
	xorl	%edx, %edx
	movl	%eax, %esi
	movq	%r11, 24(%rsp)
	movq	%rdi, (%rsp)
	movq	%r10, 16(%rsp)
	movl	%eax, 12(%rsp)
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
	movl	12(%rsp), %r9d
	movq	(%rsp), %rdi
	movq	24(%rsp), %r11
.L1506:
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
.L1507:
	.cfi_restore_state
	cmpl	$2147483647, %r8d
	je	.L1514
.L1508:
	leal	1(%r8), %eax
	jmp	.L1509
	.p2align 4,,10
	.p2align 3
.L1513:
	movl	%edx, %r9d
	jmp	.L1506
.L1514:
	movl	$1585, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE265:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__insert__8.54, .-math_prime_util__families__bitmask_sieve__word_vectors__insert__8.54
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__insert__8
	.type	math_prime_util__families__lucky_vectors__insert__8, @function
math_prime_util__families__lucky_vectors__insert__8:
.LFB63:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%r8, %r11
	testl	%r9d, %r9d
	jne	.L1516
	testq	%rsi, %rsi
	je	.L1522
	cmpl	16(%rdi), %edx
	jle	.L1524
.L1522:
	xorl	%edi, %edi
	jmp	.L1517
	.p2align 4,,10
	.p2align 3
.L1516:
	movl	16(%rdi), %r8d
	movq	%rcx, %r10
	testq	%rsi, %rsi
	je	.L1518
	movl	%edx, %eax
	cmpl	%r8d, %edx
	jg	.L1519
.L1520:
	movl	%r9d, %ecx
	xorl	%edx, %edx
	movl	%eax, %esi
	movq	%r11, 24(%rsp)
	movq	%rdi, (%rsp)
	movq	%r10, 16(%rsp)
	movl	%eax, 12(%rsp)
	call	math_prime_util__families__lucky_vectors__insert__4
	movl	12(%rsp), %r9d
	movq	(%rsp), %rdi
	movq	24(%rsp), %r11
.L1517:
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
.L1518:
	.cfi_restore_state
	cmpl	$2147483647, %r8d
	je	.L1525
.L1519:
	leal	1(%r8), %eax
	jmp	.L1520
	.p2align 4,,10
	.p2align 3
.L1524:
	movl	%edx, %r9d
	jmp	.L1517
.L1525:
	movl	$1585, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE63:
	.size	math_prime_util__families__lucky_vectors__insert__8, .-math_prime_util__families__lucky_vectors__insert__8
	.align 2
	.p2align 4
	.type	math_prime_util__families__simple_lower, @function
math_prime_util__families__simple_lower:
.LFB414:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	cmpq	$9000, %rdi
	jbe	.L1562
	testq	%rdi, %rdi
	js	.L1534
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rdi, %xmm1
.L1535:
	movapd	%xmm1, %xmm0
	movq	%rdi, 8(%rsp)
	movsd	%xmm1, (%rsp)
	call	ada__numerics__long_elementary_functions__log@PLT
	movq	8(%rsp), %rdi
	movsd	(%rsp), %xmm1
	movapd	%xmm0, %xmm2
	cmpq	$10000, %rdi
	jbe	.L1552
	cmpq	$1000000, %rdi
	jbe	.L1553
	cmpq	$10000000, %rdi
	ja	.L1537
	movsd	.LC52(%rip), %xmm0
	movapd	%xmm2, %xmm3
	divsd	.LC51(%rip), %xmm3
	subsd	%xmm3, %xmm0
	jmp	.L1536
	.p2align 4,,10
	.p2align 3
.L1534:
	movq	%rdi, %rax
	movq	%rdi, %rdx
	pxor	%xmm1, %xmm1
	shrq	%rax
	andl	$1, %edx
	orq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm1
	addsd	%xmm1, %xmm1
	jmp	.L1535
	.p2align 4,,10
	.p2align 3
.L1562:
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rdi, %xmm1
	movapd	%xmm1, %xmm0
	movsd	%xmm1, (%rsp)
	call	ada__numerics__long_elementary_functions__log@PLT
	movsd	(%rsp), %xmm1
	mulsd	.LC49(%rip), %xmm1
	divsd	%xmm0, %xmm1
	subsd	.LC50(%rip), %xmm1
	movapd	%xmm1, %xmm0
	call	system__fat_lflt__attr_long_float__floor@PLT
	pxor	%xmm1, %xmm1
	comisd	%xmm1, %xmm0
	jb	.L1557
	addsd	.LC38(%rip), %xmm0
.L1530:
	movsd	.LC39(%rip), %xmm1
	comisd	%xmm1, %xmm0
	jnb	.L1531
.L1561:
	cvttsd2siq	%xmm0, %rax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1552:
	.cfi_restore_state
	movsd	.LC47(%rip), %xmm0
.L1536:
	mulsd	%xmm1, %xmm0
	divsd	%xmm2, %xmm0
	call	system__fat_lflt__attr_long_float__floor@PLT
	pxor	%xmm1, %xmm1
	comisd	%xmm1, %xmm0
	movsd	.LC38(%rip), %xmm1
	jb	.L1558
	addsd	%xmm1, %xmm0
.L1542:
	comisd	.LC39(%rip), %xmm0
	jnb	.L1543
	cvttsd2siq	%xmm0, %rax
	testq	%rax, %rax
	js	.L1545
.L1563:
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
.L1546:
	mulsd	.LC58(%rip), %xmm0
	movsd	%xmm1, (%rsp)
	call	system__fat_lflt__attr_long_float__floor@PLT
	pxor	%xmm2, %xmm2
	comisd	%xmm2, %xmm0
	jb	.L1559
	addsd	(%rsp), %xmm0
.L1549:
	comisd	.LC39(%rip), %xmm0
	jb	.L1561
	subsd	.LC39(%rip), %xmm0
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	cvttsd2siq	%xmm0, %rax
	btcq	$63, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1543:
	.cfi_restore_state
	subsd	.LC39(%rip), %xmm0
	cvttsd2siq	%xmm0, %rax
	btcq	$63, %rax
	testq	%rax, %rax
	jns	.L1563
.L1545:
	movq	%rax, %rdx
	andl	$1, %eax
	pxor	%xmm0, %xmm0
	shrq	%rdx
	orq	%rax, %rdx
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
	jmp	.L1546
	.p2align 4,,10
	.p2align 3
.L1558:
	subsd	%xmm1, %xmm0
	jmp	.L1542
	.p2align 4,,10
	.p2align 3
.L1559:
	subsd	(%rsp), %xmm0
	jmp	.L1549
	.p2align 4,,10
	.p2align 3
.L1531:
	subsd	%xmm1, %xmm0
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	cvttsd2siq	%xmm0, %rax
	btcq	$63, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L1553:
	.cfi_restore_state
	movsd	.LC48(%rip), %xmm0
	jmp	.L1536
	.p2align 4,,10
	.p2align 3
.L1557:
	subsd	.LC38(%rip), %xmm0
	jmp	.L1530
	.p2align 4,,10
	.p2align 3
.L1537:
	cmpq	$100000000, %rdi
	jbe	.L1564
	movl	$4000000000, %eax
	movsd	%xmm1, 8(%rsp)
	movsd	%xmm0, (%rsp)
	cmpq	%rdi, %rax
	jb	.L1539
	call	ada__numerics__long_elementary_functions__log@PLT
	movsd	(%rsp), %xmm2
	mulsd	.LC55(%rip), %xmm0
	movsd	8(%rsp), %xmm1
	movapd	%xmm2, %xmm3
	divsd	%xmm0, %xmm3
	movsd	.LC56(%rip), %xmm0
	subsd	%xmm3, %xmm0
	jmp	.L1536
	.p2align 4,,10
	.p2align 3
.L1564:
	movsd	.LC54(%rip), %xmm0
	movapd	%xmm2, %xmm3
	divsd	.LC53(%rip), %xmm3
	subsd	%xmm3, %xmm0
	jmp	.L1536
	.p2align 4,,10
	.p2align 3
.L1539:
	call	ada__numerics__long_elementary_functions__log@PLT
	movsd	(%rsp), %xmm2
	mulsd	.LC55(%rip), %xmm0
	movsd	8(%rsp), %xmm1
	movapd	%xmm2, %xmm3
	divsd	%xmm0, %xmm3
	movsd	.LC57(%rip), %xmm0
	subsd	%xmm3, %xmm0
	jmp	.L1536
	.cfi_endproc
.LFE414:
	.size	math_prime_util__families__simple_lower, .-math_prime_util__families__simple_lower
	.section	.text.unlikely
	.align 2
.LCOLDB59:
	.text
.LHOTB59:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__put_image.150, @function
math_prime_util__families__bitmask_sieve__word_vectors__put_image.150:
.LFB289:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA289
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rsi, %r15
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
	movq	%r10, %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 160
	leaq	160(%rsp), %rax
	movq	%rsi, 24(%rsp)
	movq	%rax, 80(%rsp)
.LEHB52:
	call	system__put_images__array_before@PLT
.LEHE52:
	leaq	56(%rsp), %rax
	leaq	32(%rsp), %rdi
	movq	$0, 56(%rsp)
	movq	%rax, 8(%rsp)
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151(%rip), %rax
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	movq	%rax, 16(%rsp)
.LEHB53:
	call	system__secondary_stack__ss_mark@PLT
	leaq	56(%rsp), %rax
	movq	%rax, 8(%rsp)
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151(%rip), %rax
	movq	%rax, 16(%rsp)
	call	*system__soft_links__enter_master(%rip)
	leaq	56(%rsp), %rax
	movq	%rax, 8(%rsp)
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151(%rip), %rax
	movq	%rax, 16(%rsp)
	call	*system__soft_links__current_master(%rip)
	leaq	56(%rsp), %rax
	movq	%rbx, %r10
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	movq	%rax, 8(%rsp)
	xorl	%edx, %edx
	movl	$2, %esi
	movq	%r15, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151(%rip), %rax
	movq	%rax, 16(%rsp)
	call	math_prime_util__families__bitmask_sieve__word_vectors__iterate__2.157
	movq	%rax, %rbp
	leaq	56(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	%rbp, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151(%rip), %rax
	movq	%rax, 16(%rsp)
	call	ada__tags__base_address@PLT
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151(%rip), %rbx
	leaq	56(%rsp), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%rdx, 8(%rsp)
	movq	%rbx, 16(%rsp)
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	0(%rbp), %rax
	movq	(%rax), %rax
	testb	$1, %al
	jne	.L1597
.L1566:
	movq	%rbp, %rdi
	call	*%rax
	movq	%rdx, %r15
	movq	%rax, %rbx
	movl	%edx, %r13d
	testl	%edx, %edx
	jne	.L1567
	testq	%rax, %rax
	je	.L1573
.L1567:
	movq	24(%rsp), %rax
	movq	8(%rax), %rax
	jmp	.L1575
	.p2align 4,,10
	.p2align 3
.L1584:
	movq	24(%rsp), %rax
	movq	%r12, %rdi
	movq	8(%rax), %rax
	movq	%rax, (%rsp)
	call	system__put_images__simple_array_between@PLT
	movq	(%rsp), %rax
.L1575:
	movslq	%r13d, %rsi
	movq	%r12, %rdi
	movl	4(%rax,%rsi,4), %esi
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
	jne	.L1598
.L1572:
	movq	%rcx, %rsi
	movq	%rbp, %rdi
	call	*%rax
.LEHE53:
	movq	%rdx, %r15
	movq	%rax, %rbx
	movl	%edx, %r13d
	testl	%edx, %edx
	jne	.L1584
	testq	%rax, %rax
	jne	.L1584
.L1573:
.LEHB54:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebx
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE54:
	movq	16(%rsp), %rsi
	movq	8(%rsp), %rdi
.LEHB55:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE55:
	leaq	32(%rsp), %rdi
.LEHB56:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
.L1568:
	movq	%r12, %rdi
	call	system__put_images__array_after@PLT
.LEHE56:
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
.L1598:
	.cfi_restore_state
	movq	-1(%rsi), %r10
	movq	7(%rsi), %rax
	jmp	.L1572
.L1597:
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1566
.L1581:
	movq	%rax, %r12
	jmp	.L1576
.L1582:
	movq	%rax, %rbp
	jmp	.L1569
	.section	.gcc_except_table
	.align 4
.LLSDA289:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT289-.LLSDATTD289
.LLSDATTD289:
	.byte	0x1
	.uleb128 .LLSDACSE289-.LLSDACSB289
.LLSDACSB289:
	.uleb128 .LEHB52-.LFB289
	.uleb128 .LEHE52-.LEHB52
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB53-.LFB289
	.uleb128 .LEHE53-.LEHB53
	.uleb128 .L1581-.LFB289
	.uleb128 0
	.uleb128 .LEHB54-.LFB289
	.uleb128 .LEHE54-.LEHB54
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB55-.LFB289
	.uleb128 .LEHE55-.LEHB55
	.uleb128 .L1582-.LFB289
	.uleb128 0x1
	.uleb128 .LEHB56-.LFB289
	.uleb128 .LEHE56-.LEHB56
	.uleb128 0
	.uleb128 0
.LLSDACSE289:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT289:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC289
	.type	math_prime_util__families__bitmask_sieve__word_vectors__put_image.150.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__put_image.150.cold:
.LFSB289:
.L1576:
	.cfi_def_cfa_offset 160
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
.LEHB57:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebp
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE57:
	movq	16(%rsp), %rsi
	movq	8(%rsp), %rdi
.LEHB58:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE58:
	xorl	%ebx, %ebx
.L1580:
	leaq	32(%rsp), %rdi
	xorl	$1, %ebp
.LEHB59:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	testb	%bl, %bpl
	je	.L1595
.L1571:
	movl	$2362, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1569:
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1599
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	leaq	32(%rsp), %rdi
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	andb	$1, %bl
	jne	.L1568
	jmp	.L1571
.L1583:
	subq	$1, %rdx
	movq	%rax, %rbx
	movq	%rax, %rdi
	jne	.L1600
	call	__gnat_begin_handler_v1@PLT
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movl	$1, %ebx
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	jmp	.L1580
.L1595:
	movq	%r12, %rdi
	call	_Unwind_Resume@PLT
.L1599:
	call	_Unwind_Resume@PLT
.L1600:
	call	_Unwind_Resume@PLT
.LEHE59:
	.cfi_endproc
.LFE289:
	.section	.gcc_except_table
	.align 4
.LLSDAC289:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC289-.LLSDATTDC289
.LLSDATTDC289:
	.byte	0x1
	.uleb128 .LLSDACSEC289-.LLSDACSBC289
.LLSDACSBC289:
	.uleb128 .LEHB57-.LCOLDB59
	.uleb128 .LEHE57-.LEHB57
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB58-.LCOLDB59
	.uleb128 .LEHE58-.LEHB58
	.uleb128 .L1583-.LCOLDB59
	.uleb128 0x1
	.uleb128 .LEHB59-.LCOLDB59
	.uleb128 .LEHE59-.LEHB59
	.uleb128 0
	.uleb128 0
.LLSDACSEC289:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC289:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__put_image.150, .-math_prime_util__families__bitmask_sieve__word_vectors__put_image.150
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__put_image.150.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__put_image.150.cold
.LCOLDE59:
	.text
.LHOTE59:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__vectorPI__2.107, @function
math_prime_util__families__bitmask_sieve__word_vectors__vectorPI__2.107:
.LFB378:
	.cfi_startproc
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__put_image.150
	.cfi_endproc
.LFE378:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__vectorPI__2.107, .-math_prime_util__families__bitmask_sieve__word_vectors__vectorPI__2.107
	.section	.text.unlikely
	.align 2
.LCOLDB60:
	.text
.LHOTB60:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__put_image
	.type	math_prime_util__families__lucky_vectors__put_image, @function
math_prime_util__families__lucky_vectors__put_image:
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
.LEHB60:
	call	system__put_images__array_before@PLT
.LEHE60:
	leaq	56(%rsp), %rax
	leaq	32(%rsp), %rdi
	movq	$0, 56(%rsp)
	movq	%rax, 16(%rsp)
	leaq	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	movq	%rax, 8(%rsp)
.LEHB61:
	call	system__secondary_stack__ss_mark@PLT
	leaq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 8(%rsp)
	call	*system__soft_links__enter_master(%rip)
	leaq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	leaq	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 8(%rsp)
	call	*system__soft_links__current_master(%rip)
	leaq	56(%rsp), %rax
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rax, 16(%rsp)
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 8(%rsp)
	call	math_prime_util__families__lucky_vectors__iterate__2
	movq	%rax, %rbp
	leaq	56(%rsp), %rax
	movq	%rax, 16(%rsp)
	movq	%rbp, %rdi
	leaq	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 8(%rsp)
	call	ada__tags__base_address@PLT
	leaq	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rbx
	leaq	56(%rsp), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%rdx, 16(%rsp)
	movq	%rbx, 8(%rsp)
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	0(%rbp), %rax
	movq	(%rax), %rax
	testb	$1, %al
	jne	.L1634
.L1603:
	movq	%rbp, %rdi
	call	*%rax
	movq	%rdx, %r15
	movq	%rax, %rbx
	movl	%edx, %r13d
	testl	%edx, %edx
	jne	.L1604
	testq	%rax, %rax
	je	.L1610
.L1604:
	movq	24(%rsp), %rax
	movq	8(%rax), %rax
	jmp	.L1612
	.p2align 4,,10
	.p2align 3
.L1621:
	movq	24(%rsp), %rax
	movq	%r12, %rdi
	movq	8(%rax), %rax
	movq	%rax, (%rsp)
	call	system__put_images__simple_array_between@PLT
	movq	(%rsp), %rax
.L1612:
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
	jne	.L1635
.L1609:
	movq	%rcx, %rsi
	movq	%rbp, %rdi
	call	*%rax
.LEHE61:
	movq	%rdx, %r15
	movq	%rax, %rbx
	movl	%edx, %r13d
	testl	%edx, %edx
	jne	.L1621
	testq	%rax, %rax
	jne	.L1621
.L1610:
.LEHB62:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebx
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE62:
	movq	8(%rsp), %rsi
	movq	16(%rsp), %rdi
.LEHB63:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE63:
	leaq	32(%rsp), %rdi
.LEHB64:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
.L1605:
	movq	%r12, %rdi
	call	system__put_images__array_after@PLT
.LEHE64:
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
.L1635:
	.cfi_restore_state
	movq	-1(%rsi), %r10
	movq	7(%rsi), %rax
	jmp	.L1609
.L1634:
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1603
.L1618:
	movq	%rax, %r12
	jmp	.L1613
.L1619:
	movq	%rax, %rbp
	jmp	.L1606
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
	.uleb128 .LEHB60-.LFB87
	.uleb128 .LEHE60-.LEHB60
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB61-.LFB87
	.uleb128 .LEHE61-.LEHB61
	.uleb128 .L1618-.LFB87
	.uleb128 0
	.uleb128 .LEHB62-.LFB87
	.uleb128 .LEHE62-.LEHB62
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB63-.LFB87
	.uleb128 .LEHE63-.LEHB63
	.uleb128 .L1619-.LFB87
	.uleb128 0x1
	.uleb128 .LEHB64-.LFB87
	.uleb128 .LEHE64-.LEHB64
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
	.type	math_prime_util__families__lucky_vectors__put_image.cold, @function
math_prime_util__families__lucky_vectors__put_image.cold:
.LFSB87:
.L1613:
	.cfi_def_cfa_offset 160
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
.LEHB65:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebp
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE65:
	movq	8(%rsp), %rsi
	movq	16(%rsp), %rdi
.LEHB66:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE66:
	xorl	%ebx, %ebx
.L1617:
	leaq	32(%rsp), %rdi
	xorl	$1, %ebp
.LEHB67:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	testb	%bl, %bpl
	je	.L1632
.L1608:
	movl	$2362, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1606:
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1636
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	leaq	32(%rsp), %rdi
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	andb	$1, %bl
	jne	.L1605
	jmp	.L1608
.L1620:
	subq	$1, %rdx
	movq	%rax, %rbx
	movq	%rax, %rdi
	jne	.L1637
	call	__gnat_begin_handler_v1@PLT
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movl	$1, %ebx
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	jmp	.L1617
.L1632:
	movq	%r12, %rdi
	call	_Unwind_Resume@PLT
.L1636:
	call	_Unwind_Resume@PLT
.L1637:
	call	_Unwind_Resume@PLT
.LEHE67:
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
	.uleb128 .LEHB65-.LCOLDB60
	.uleb128 .LEHE65-.LEHB65
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB66-.LCOLDB60
	.uleb128 .LEHE66-.LEHB66
	.uleb128 .L1620-.LCOLDB60
	.uleb128 0x1
	.uleb128 .LEHB67-.LCOLDB60
	.uleb128 .LEHE67-.LEHB67
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
	.size	math_prime_util__families__lucky_vectors__put_image, .-math_prime_util__families__lucky_vectors__put_image
	.section	.text.unlikely
	.size	math_prime_util__families__lucky_vectors__put_image.cold, .-math_prime_util__families__lucky_vectors__put_image.cold
.LCOLDE60:
	.text
.LHOTE60:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__vectorPI__2
	.type	math_prime_util__families__lucky_vectors__vectorPI__2, @function
math_prime_util__families__lucky_vectors__vectorPI__2:
.LFB167:
	.cfi_startproc
	jmp	math_prime_util__families__lucky_vectors__put_image
	.cfi_endproc
.LFE167:
	.size	math_prime_util__families__lucky_vectors__vectorPI__2, .-math_prime_util__families__lucky_vectors__vectorPI__2
	.section	.text.unlikely
	.align 2
.LCOLDB61:
	.text
.LHOTB61:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD
	.type	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD, @function
math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD:
.LFB121:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA121
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
.LEHB68:
	call	*system__soft_links__enter_master(%rip)
	call	*system__soft_links__current_master(%rip)
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	movq	64(%rax), %rax
	testb	$1, %al
	jne	.L1647
.L1640:
	movl	$1, %esi
	movq	%rbx, %rdi
	call	*%rax
.LEHE68:
.LEHB69:
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE69:
.L1647:
	.cfi_restore_state
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1640
.L1642:
	movq	%rax, %rbx
	jmp	.L1641
	.section	.gcc_except_table
.LLSDA121:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE121-.LLSDACSB121
.LLSDACSB121:
	.uleb128 .LEHB68-.LFB121
	.uleb128 .LEHE68-.LEHB68
	.uleb128 .L1642-.LFB121
	.uleb128 0
	.uleb128 .LEHB69-.LFB121
	.uleb128 .LEHE69-.LEHB69
	.uleb128 0
	.uleb128 0
.LLSDACSE121:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC121
	.type	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold, @function
math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold:
.LFSB121:
.L1641:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
.LEHB70:
	call	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B16s___finalizer.12
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE70:
	.cfi_endproc
.LFE121:
	.section	.gcc_except_table
.LLSDAC121:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC121-.LLSDACSBC121
.LLSDACSBC121:
	.uleb128 .LEHB70-.LCOLDB61
	.uleb128 .LEHE70-.LEHB70
	.uleb128 0
	.uleb128 0
.LLSDACSEC121:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD, .-math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD
	.section	.text.unlikely
	.size	math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold, .-math_prime_util__families__lucky_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold
.LCOLDE61:
	.text
.LHOTE61:
	.section	.text.unlikely
	.align 2
.LCOLDB62:
	.text
.LHOTB62:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151, @function
math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151:
.LFB323:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA323
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
.LEHB71:
	call	*system__soft_links__enter_master(%rip)
	call	*system__soft_links__current_master(%rip)
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	movq	64(%rax), %rax
	testb	$1, %al
	jne	.L1656
.L1649:
	movl	$1, %esi
	movq	%rbx, %rdi
	call	*%rax
.LEHE71:
.LEHB72:
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE72:
.L1656:
	.cfi_restore_state
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1649
.L1651:
	movq	%rax, %rbx
	jmp	.L1650
	.section	.gcc_except_table
.LLSDA323:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE323-.LLSDACSB323
.LLSDACSB323:
	.uleb128 .LEHB71-.LFB323
	.uleb128 .LEHE71-.LEHB71
	.uleb128 .L1651-.LFB323
	.uleb128 0
	.uleb128 .LEHB72-.LFB323
	.uleb128 .LEHE72-.LEHB72
	.uleb128 0
	.uleb128 0
.LLSDACSE323:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC323
	.type	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151.cold:
.LFSB323:
.L1650:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
.LEHB73:
	call	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B111b___finalizer.152
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE73:
	.cfi_endproc
.LFE323:
	.section	.gcc_except_table
.LLSDAC323:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC323-.LLSDACSBC323
.LLSDACSBC323:
	.uleb128 .LEHB73-.LCOLDB62
	.uleb128 .LEHE73-.LEHB73
	.uleb128 0
	.uleb128 0
.LLSDACSEC323:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151, .-math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.151.cold
.LCOLDE62:
	.text
.LHOTE62:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__vectorDA__2.74, @function
math_prime_util__families__bitmask_sieve__word_vectors__vectorDA__2.74:
.LFB361:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -32
	movl	16(%rdi), %ebp
	cmpl	$-1, %ebp
	je	.L1661
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
.L1661:
	.cfi_def_cfa_offset 64
	movq	$0, 8(%rdi)
	movq	32(%rsp), %rbp
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE361:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__vectorDA__2.74, .-math_prime_util__families__bitmask_sieve__word_vectors__vectorDA__2.74
	.section	.text.unlikely
	.align 2
.LCOLDB63:
	.text
.LHOTB63:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T493b.131, @function
math_prime_util__families__bitmask_sieve__word_vectors__T493b.131:
.LFB364:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA364
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$8, %esi
	movq	%r10, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%edi, %ebp
	movl	$32, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
.LEHB74:
	call	system__secondary_stack__ss_allocate@PLT
.LEHE74:
	movq	%rsp, %rdx
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movq	%rax, %rbx
	leaq	64(%rsp), %rax
	movq	%rbx, %rdi
	movq	%rax, 24(%rsp)
	movq	$0, 16(%rsp)
.LEHB75:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	560(%r12), %rax
	movq	$0, 8(%rbx)
	movl	$-1, 16(%rbx)
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	%ebp, %esi
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE75:
.LEHB76:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE76:
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
.L1664:
	.cfi_restore_state
	movq	%rax, %rbx
	jmp	.L1663
	.section	.gcc_except_table
.LLSDA364:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE364-.LLSDACSB364
.LLSDACSB364:
	.uleb128 .LEHB74-.LFB364
	.uleb128 .LEHE74-.LEHB74
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB75-.LFB364
	.uleb128 .LEHE75-.LEHB75
	.uleb128 .L1664-.LFB364
	.uleb128 0
	.uleb128 .LEHB76-.LFB364
	.uleb128 .LEHE76-.LEHB76
	.uleb128 0
	.uleb128 0
.LLSDACSE364:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC364
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T493b.131.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__T493b.131.cold:
.LFSB364:
.L1663:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	%rsp, %r10
.LEHB77:
	call	math_prime_util__families__bitmask_sieve__word_vectors__empty__R1207b___finalizer.133
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE77:
	.cfi_endproc
.LFE364:
	.section	.gcc_except_table
.LLSDAC364:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC364-.LLSDACSBC364
.LLSDACSBC364:
	.uleb128 .LEHB77-.LCOLDB63
	.uleb128 .LEHE77-.LEHB77
	.uleb128 0
	.uleb128 0
.LLSDACSEC364:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T493b.131, .-math_prime_util__families__bitmask_sieve__word_vectors__T493b.131
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T493b.131.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__T493b.131.cold
.LCOLDE63:
	.text
.LHOTE63:
	.section	.text.unlikely
	.align 2
.LCOLDB64:
	.text
.LHOTB64:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T460b.134, @function
math_prime_util__families__bitmask_sieve__word_vectors__T460b.134:
.LFB353:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA353
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%r10, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	%esi, %r12d
	movl	$8, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	movl	$32, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
.LEHB78:
	call	system__secondary_stack__ss_allocate@PLT
.LEHE78:
	movq	%rsp, %rdx
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movq	%rax, %rbx
	leaq	80(%rsp), %rax
	movq	%rax, 24(%rsp)
	movl	$4, %eax
	movq	%rbx, %rdi
	movq	$0, 16(%rsp)
	cmpl	%eax, %r12d
	cmovg	%eax, %r12d
.LEHB79:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	560(%r13), %rax
	movq	$0, 8(%rbx)
	movl	$-1, 16(%rbx)
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	%r12d, %edx
	movq	%rbx, %rsi
	movq	%rbp, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__read.32
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE79:
.LEHB80:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE80:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L1670:
	.cfi_restore_state
	movq	%rax, %rbx
	jmp	.L1669
	.section	.gcc_except_table
.LLSDA353:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE353-.LLSDACSB353
.LLSDACSB353:
	.uleb128 .LEHB78-.LFB353
	.uleb128 .LEHE78-.LEHB78
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB79-.LFB353
	.uleb128 .LEHE79-.LEHB79
	.uleb128 .L1670-.LFB353
	.uleb128 0
	.uleb128 .LEHB80-.LFB353
	.uleb128 .LEHE80-.LEHB80
	.uleb128 0
	.uleb128 0
.LLSDACSE353:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC353
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T460b.134.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__T460b.134.cold:
.LFSB353:
.L1669:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	%rsp, %r10
.LEHB81:
	call	math_prime_util__families__bitmask_sieve__word_vectors__vectorSI__R473b___finalizer__2.136
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE81:
	.cfi_endproc
.LFE353:
	.section	.gcc_except_table
.LLSDAC353:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC353-.LLSDACSBC353
.LLSDACSBC353:
	.uleb128 .LEHB81-.LCOLDB64
	.uleb128 .LEHE81-.LEHB81
	.uleb128 0
	.uleb128 0
.LLSDACSEC353:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T460b.134, .-math_prime_util__families__bitmask_sieve__word_vectors__T460b.134
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T460b.134.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__T460b.134.cold
.LCOLDE64:
	.text
.LHOTE64:
	.section	.text.unlikely
	.align 2
.LCOLDB65:
	.text
.LHOTB65:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T560b.112, @function
math_prime_util__families__bitmask_sieve__word_vectors__T560b.112:
.LFB375:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA375
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	%esi, %r13d
	movl	$8, %esi
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%r10, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	movl	$32, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
.LEHB82:
	call	system__secondary_stack__ss_allocate@PLT
.LEHE82:
	movq	%rax, %rbx
	leaq	80(%rsp), %rax
	movq	%rax, 24(%rsp)
	movl	16(%rbp), %eax
	cmpl	$2147483647, %eax
	je	.L1684
	addl	$1, %eax
	movq	%rsp, %rdx
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	movq	%rbx, %rdi
	cmpl	%r13d, %eax
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	cmovge	%eax, %r13d
	movq	$0, 16(%rsp)
.LEHB83:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	560(%r12), %rax
	movq	$0, 8(%rbx)
	movl	$-1, 16(%rbx)
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	%r13d, %esi
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70
	cmpq	%rbx, %rbp
	je	.L1678
	movl	$-1, 16(%rbx)
	movl	16(%rbp), %eax
	testl	%eax, %eax
	js	.L1678
	movq	%rbp, %rdx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
.L1678:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE83:
.LEHB84:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L1684:
	.cfi_restore_state
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.LEHE84:
.L1680:
	movq	%rax, %rbx
	jmp	.L1679
	.section	.gcc_except_table
.LLSDA375:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE375-.LLSDACSB375
.LLSDACSB375:
	.uleb128 .LEHB82-.LFB375
	.uleb128 .LEHE82-.LEHB82
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB83-.LFB375
	.uleb128 .LEHE83-.LEHB83
	.uleb128 .L1680-.LFB375
	.uleb128 0
	.uleb128 .LEHB84-.LFB375
	.uleb128 .LEHE84-.LEHB84
	.uleb128 0
	.uleb128 0
.LLSDACSE375:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC375
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T560b.112.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__T560b.112.cold:
.LFSB375:
.L1679:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	%rsp, %r10
.LEHB85:
	call	math_prime_util__families__bitmask_sieve__word_vectors__copy__R1169b___finalizer.114
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE85:
	.cfi_endproc
.LFE375:
	.section	.gcc_except_table
.LLSDAC375:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC375-.LLSDACSBC375
.LLSDACSBC375:
	.uleb128 .LEHB85-.LCOLDB65
	.uleb128 .LEHE85-.LEHB85
	.uleb128 0
	.uleb128 0
.LLSDACSEC375:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T560b.112, .-math_prime_util__families__bitmask_sieve__word_vectors__T560b.112
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T560b.112.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__T560b.112.cold
.LCOLDE65:
	.text
.LHOTE65:
	.section	.text.unlikely
	.align 2
.LCOLDB66:
	.text
.LHOTB66:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T502b.124, @function
math_prime_util__families__bitmask_sieve__word_vectors__T502b.124:
.LFB367:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA367
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%r10, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r12
	movl	$8, %esi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	movl	$32, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
.LEHB86:
	call	system__secondary_stack__ss_allocate@PLT
.LEHE86:
	movq	%rsp, %rdx
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movq	%rax, %rbx
	leaq	80(%rsp), %rax
	movq	%rbx, %rdi
	movq	%rax, 24(%rsp)
	movq	$0, 16(%rsp)
.LEHB87:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	560(%r13), %rax
	movq	$0, 8(%rbx)
	movl	$-1, 16(%rbx)
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	16(%rbp), %esi
	cmpl	$2147483647, %esi
	je	.L1705
	movl	16(%r12), %eax
	cmpl	$2147483647, %eax
	je	.L1706
	addl	$1, %esi
	addl	$1, %eax
	addl	%eax, %esi
	jo	.L1689
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70
	movl	16(%rbp), %edx
	testl	%edx, %edx
	js	.L1695
	movl	16(%rbx), %esi
	cmpl	$2147483647, %esi
	je	.L1707
	addl	$1, %esi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
.L1695:
	movl	16(%r12), %eax
	testl	%eax, %eax
	js	.L1692
	movl	16(%rbx), %esi
	cmpl	$2147483647, %esi
	je	.L1708
	addl	$1, %esi
	movq	%r12, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
.L1692:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE87:
.LEHB88:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE88:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L1689:
	.cfi_restore_state
	movl	$66, %esi
	leaq	.LC13(%rip), %rdi
.LEHB89:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1706:
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.L1705:
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.L1708:
	movl	$197, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1707:
	movl	$197, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE89:
.L1699:
	movq	%rax, %rbx
	jmp	.L1698
	.section	.gcc_except_table
.LLSDA367:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE367-.LLSDACSB367
.LLSDACSB367:
	.uleb128 .LEHB86-.LFB367
	.uleb128 .LEHE86-.LEHB86
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB87-.LFB367
	.uleb128 .LEHE87-.LEHB87
	.uleb128 .L1699-.LFB367
	.uleb128 0
	.uleb128 .LEHB88-.LFB367
	.uleb128 .LEHE88-.LEHB88
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB89-.LFB367
	.uleb128 .LEHE89-.LEHB89
	.uleb128 .L1699-.LFB367
	.uleb128 0
.LLSDACSE367:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC367
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T502b.124.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__T502b.124.cold:
.LFSB367:
.L1698:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	%rsp, %r10
.LEHB90:
	call	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1072b___finalizer.126
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE90:
	.cfi_endproc
.LFE367:
	.section	.gcc_except_table
.LLSDAC367:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC367-.LLSDACSBC367
.LLSDACSBC367:
	.uleb128 .LEHB90-.LCOLDB66
	.uleb128 .LEHE90-.LEHB90
	.uleb128 0
	.uleb128 0
.LLSDACSEC367:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T502b.124, .-math_prime_util__families__bitmask_sieve__word_vectors__T502b.124
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T502b.124.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__T502b.124.cold
.LCOLDE66:
	.text
.LHOTE66:
	.section	.text.unlikely
	.align 2
.LCOLDB67:
	.text
.LHOTB67:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110, @function
math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110:
.LFB311:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA311
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	leaq	80(%rsp), %rax
	movq	%rbx, 56(%rsp)
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	movq	%rax, 40(%rsp)
	testl	%esi, %esi
	je	.L1715
	movq	%rbp, 64(%rsp)
	.cfi_offset 6, -16
	leal	-1(%rsi), %ebp
	movslq	%ebp, %rax
	movq	%r10, 8(%rsp)
	leaq	8(,%rax,4), %rdi
.LEHB91:
	call	__gnat_malloc@PLT
.LEHE91:
	leaq	32+ada__finalization__controlledT(%rip), %rcx
	movl	%ebp, 16(%rbx)
	movl	%ebp, (%rax)
	movq	%rax, 8(%rbx)
	xorl	%eax, %eax
	movq	$0, 16(%rsp)
	movl	%eax, %edx
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	%rcx, (%rbx)
	xchgl	20(%rbx), %edx
	xchgl	24(%rbx), %eax
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	movq	8(%rsp), %r10
	movq	560(%r10), %rax
	leaq	16(%rsp), %rdx
	movq	%rbx, %rdi
	movq	%rax, (%rbx)
.LEHB92:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	16(%rsp), %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE92:
.LEHB93:
	call	*system__soft_links__abort_defer(%rip)
	leaq	16(%rsp), %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rax
	movq	64(%rsp), %rbp
	.cfi_restore 6
	movq	56(%rsp), %rbx
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1715:
	.cfi_def_cfa_offset 80
	movdqu	568(%r10), %xmm0
	movups	%xmm0, (%rdi)
	movdqu	584(%r10), %xmm0
	movups	%xmm0, 16(%rdi)
	movq	560(%r10), %rax
	movq	%rax, (%rdi)
	call	math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.81
.LEHE93:
	movq	%rbx, %rax
	movq	56(%rsp), %rbx
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
.L1713:
	.cfi_def_cfa_offset 80
	.cfi_offset 6, -16
	movq	%rax, %rbx
	jmp	.L1712
	.section	.gcc_except_table
.LLSDA311:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE311-.LLSDACSB311
.LLSDACSB311:
	.uleb128 .LEHB91-.LFB311
	.uleb128 .LEHE91-.LEHB91
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB92-.LFB311
	.uleb128 .LEHE92-.LEHB92
	.uleb128 .L1713-.LFB311
	.uleb128 0
	.uleb128 .LEHB93-.LFB311
	.uleb128 .LEHE93-.LEHB93
	.uleb128 0
	.uleb128 0
.LLSDACSE311:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC311
	.type	math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110.cold:
.LFSB311:
.L1712:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	leaq	16(%rsp), %r10
.LEHB94:
	call	math_prime_util__families__bitmask_sieve__word_vectors__to_vector__R1744b___finalizer.111
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE94:
	.cfi_endproc
.LFE311:
	.section	.gcc_except_table
.LLSDAC311:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC311-.LLSDACSBC311
.LLSDACSBC311:
	.uleb128 .LEHB94-.LCOLDB67
	.uleb128 .LEHE94-.LEHB94
	.uleb128 0
	.uleb128 0
.LLSDACSEC311:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110, .-math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110.cold
.LCOLDE67:
	.text
.LHOTE67:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T564b.108, @function
math_prime_util__families__bitmask_sieve__word_vectors__T564b.108:
.LFB376:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%edi, %ebp
	movl	$32, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%esi, %ebx
	movl	$8, %esi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movq	%r10, 8(%rsp)
	call	system__secondary_stack__ss_allocate@PLT
	subl	%ebp, %ebx
	jo	.L1720
	cmpl	$2147483647, %ebx
	movq	8(%rsp), %r10
	je	.L1720
	leal	1(%rbx), %esi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L1720:
	.cfi_restore_state
	movl	$783, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE376:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T564b.108, .-math_prime_util__families__bitmask_sieve__word_vectors__T564b.108
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T496b.130, @function
math_prime_util__families__bitmask_sieve__word_vectors__T496b.130:
.LFB365:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$8, %esi
	movl	%edi, %ebx
	movl	$32, %edi
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	%r10, 8(%rsp)
	call	system__secondary_stack__ss_allocate@PLT
	movq	8(%rsp), %r10
	movl	%ebx, %esi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__families__bitmask_sieve__word_vectors__to_vector.110
	movq	8(%rsp), %rax
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE365:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T496b.130, .-math_prime_util__families__bitmask_sieve__word_vectors__T496b.130
	.section	.text.unlikely
	.align 2
.LCOLDB68:
	.text
.LHOTB68:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T508b.118, @function
math_prime_util__families__bitmask_sieve__word_vectors__T508b.118:
.LFB369:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA369
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%r10, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	%edi, %r12d
	movl	$32, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
.LEHB95:
	call	system__secondary_stack__ss_allocate@PLT
.LEHE95:
	movq	%rsp, %rdx
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movq	%rax, %rbx
	leaq	80(%rsp), %rax
	movq	%rbx, %rdi
	movq	%rax, 24(%rsp)
	movq	$0, 16(%rsp)
.LEHB96:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	560(%r13), %rax
	movq	$0, 8(%rbx)
	movl	$-1, 16(%rbx)
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	16(%rbp), %esi
	cmpl	$2147483647, %esi
	je	.L1745
	cmpl	$2147483646, %esi
	je	.L1746
	addl	$2, %esi
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70
	movq	8(%rbx), %rax
	movl	16(%rbx), %esi
	testq	%rax, %rax
	je	.L1731
	cmpl	(%rax), %esi
	je	.L1731
	cmpl	$2147483647, %esi
	je	.L1747
	addl	$1, %esi
	movslq	%esi, %rdx
	movl	%r12d, 4(%rax,%rdx,4)
	movl	%esi, 16(%rbx)
	jmp	.L1733
	.p2align 4,,10
	.p2align 3
.L1731:
	cmpl	$2147483647, %esi
	je	.L1748
	addl	$1, %esi
	movl	$1, %ecx
	movl	%r12d, %edx
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
.L1733:
	movl	16(%rbp), %eax
	testl	%eax, %eax
	js	.L1735
	movl	16(%rbx), %esi
	cmpl	$2147483647, %esi
	je	.L1749
	addl	$1, %esi
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
.L1735:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE96:
.LEHB97:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE97:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L1746:
	.cfi_restore_state
	movl	$84, %esi
	leaq	.LC13(%rip), %rdi
.LEHB98:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1745:
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.L1749:
	movl	$197, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1748:
	movl	$229, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1747:
	movl	$223, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE98:
.L1738:
	movq	%rax, %rbx
	jmp	.L1737
	.section	.gcc_except_table
.LLSDA369:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE369-.LLSDACSB369
.LLSDACSB369:
	.uleb128 .LEHB95-.LFB369
	.uleb128 .LEHE95-.LEHB95
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB96-.LFB369
	.uleb128 .LEHE96-.LEHB96
	.uleb128 .L1738-.LFB369
	.uleb128 0
	.uleb128 .LEHB97-.LFB369
	.uleb128 .LEHE97-.LEHB97
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB98-.LFB369
	.uleb128 .LEHE98-.LEHB98
	.uleb128 .L1738-.LFB369
	.uleb128 0
.LLSDACSE369:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC369
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T508b.118.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__T508b.118.cold:
.LFSB369:
.L1737:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	%rsp, %r10
.LEHB99:
	call	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1090b___finalizer__3.120
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE99:
	.cfi_endproc
.LFE369:
	.section	.gcc_except_table
.LLSDAC369:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC369-.LLSDACSBC369
.LLSDACSBC369:
	.uleb128 .LEHB99-.LCOLDB68
	.uleb128 .LEHE99-.LEHB99
	.uleb128 0
	.uleb128 0
.LLSDACSEC369:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T508b.118, .-math_prime_util__families__bitmask_sieve__word_vectors__T508b.118
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T508b.118.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__T508b.118.cold
.LCOLDE68:
	.text
.LHOTE68:
	.section	.text.unlikely
	.align 2
.LCOLDB69:
	.text
.LHOTB69:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T505b.121, @function
math_prime_util__families__bitmask_sieve__word_vectors__T505b.121:
.LFB368:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA368
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%r10, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	movl	$32, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movl	%esi, %ebp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
.LEHB100:
	call	system__secondary_stack__ss_allocate@PLT
.LEHE100:
	movq	%rsp, %rdx
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movq	%rax, %rbx
	leaq	80(%rsp), %rax
	movq	%rbx, %rdi
	movq	%rax, 24(%rsp)
	movq	$0, 16(%rsp)
.LEHB101:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	560(%r13), %rax
	movq	$0, 8(%rbx)
	movl	$-1, 16(%rbx)
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	16(%r12), %esi
	cmpl	$2147483647, %esi
	je	.L1767
	cmpl	$2147483646, %esi
	je	.L1768
	addl	$2, %esi
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70
	movl	16(%r12), %eax
	testl	%eax, %eax
	js	.L1753
	movl	16(%rbx), %esi
	cmpl	$2147483647, %esi
	je	.L1769
	addl	$1, %esi
	movq	%r12, %rdx
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert_vector.61
.L1753:
	movq	8(%rbx), %rax
	movl	16(%rbx), %esi
	testq	%rax, %rax
	je	.L1755
	cmpl	(%rax), %esi
	je	.L1755
	cmpl	$2147483647, %esi
	je	.L1770
	addl	$1, %esi
	movslq	%esi, %rdx
	movl	%ebp, 4(%rax,%rdx,4)
	movl	%esi, 16(%rbx)
	jmp	.L1757
	.p2align 4,,10
	.p2align 3
.L1755:
	cmpl	$2147483647, %esi
	je	.L1771
	addl	$1, %esi
	movl	$1, %ecx
	movl	%ebp, %edx
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
.L1757:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE101:
.LEHB102:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE102:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L1768:
	.cfi_restore_state
	movl	$75, %esi
	leaq	.LC13(%rip), %rdi
.LEHB103:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1767:
	call	math_prime_util__families__bitmask_sieve__word_vectors__length.69.part.0
.L1769:
	movl	$197, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1771:
	movl	$229, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1770:
	movl	$223, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE103:
.L1760:
	movq	%rax, %rbx
	jmp	.L1759
	.section	.gcc_except_table
.LLSDA368:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE368-.LLSDACSB368
.LLSDACSB368:
	.uleb128 .LEHB100-.LFB368
	.uleb128 .LEHE100-.LEHB100
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB101-.LFB368
	.uleb128 .LEHE101-.LEHB101
	.uleb128 .L1760-.LFB368
	.uleb128 0
	.uleb128 .LEHB102-.LFB368
	.uleb128 .LEHE102-.LEHB102
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB103-.LFB368
	.uleb128 .LEHE103-.LEHB103
	.uleb128 .L1760-.LFB368
	.uleb128 0
.LLSDACSE368:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC368
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T505b.121.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__T505b.121.cold:
.LFSB368:
.L1759:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	%rsp, %r10
.LEHB104:
	call	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1081b___finalizer__2.123
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE104:
	.cfi_endproc
.LFE368:
	.section	.gcc_except_table
.LLSDAC368:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC368-.LLSDACSBC368
.LLSDACSBC368:
	.uleb128 .LEHB104-.LCOLDB69
	.uleb128 .LEHE104-.LEHB104
	.uleb128 0
	.uleb128 0
.LLSDACSEC368:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T505b.121, .-math_prime_util__families__bitmask_sieve__word_vectors__T505b.121
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T505b.121.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__T505b.121.cold
.LCOLDE69:
	.text
.LHOTE69:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__append__2.168, @function
math_prime_util__families__bitmask_sieve__word_vectors__append__2.168:
.LFB227:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	%esi, %eax
	cmpl	$1, %edx
	je	.L1786
	testl	%edx, %edx
	je	.L1772
	movl	16(%rdi), %esi
	cmpl	$2147483647, %esi
	je	.L1787
	movl	%edx, %ecx
	addl	$1, %esi
	movl	%eax, %edx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
	.p2align 4,,10
	.p2align 3
.L1786:
	.cfi_restore_state
	movq	8(%rdi), %rdx
	movl	16(%rdi), %esi
	testq	%rdx, %rdx
	je	.L1774
	cmpl	(%rdx), %esi
	je	.L1774
	cmpl	$2147483647, %esi
	je	.L1788
	addl	$1, %esi
	movslq	%esi, %rcx
	movl	%eax, 4(%rdx,%rcx,4)
	movl	%esi, 16(%rdi)
.L1772:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1774:
	.cfi_restore_state
	cmpl	$2147483647, %esi
	je	.L1789
	addl	$1, %esi
	movl	$1, %ecx
	movl	%eax, %edx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
.L1787:
	.cfi_restore_state
	movl	$248, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1789:
	movl	$229, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1788:
	movl	$223, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE227:
	.size	math_prime_util__families__bitmask_sieve__word_vectors__append__2.168, .-math_prime_util__families__bitmask_sieve__word_vectors__append__2.168
	.section	.text.unlikely
	.align 2
.LCOLDB70:
	.text
.LHOTB70:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T499b.127, @function
math_prime_util__families__bitmask_sieve__word_vectors__T499b.127:
.LFB366:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA366
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%r10, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	%edi, %r12d
	movl	$32, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movl	%esi, %ebp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
.LEHB105:
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rax, %rbx
	leaq	80(%rsp), %rax
	movq	%rax, 24(%rsp)
	testl	%ebp, %ebp
	je	.L1804
	subl	$1, %ebp
	movslq	%ebp, %rax
	leaq	8(,%rax,4), %rdi
	call	__gnat_malloc@PLT
.LEHE105:
	movl	%ebp, (%rax)
	movq	%rax, %rdx
	testl	%ebp, %ebp
	js	.L1793
	movl	%ebp, %ecx
	leaq	4(%rax), %rax
	leaq	8(%rdx,%rcx,4), %rcx
	movq	%rcx, %rsi
	subq	%rax, %rsi
	andl	$4, %esi
	je	.L1794
	movl	%r12d, (%rax)
	leaq	8(%rdx), %rax
	cmpq	%rcx, %rax
	je	.L1793
	.p2align 4
	.p2align 4
	.p2align 3
.L1794:
	movl	%r12d, (%rax)
	addq	$8, %rax
	movl	%r12d, -4(%rax)
	cmpq	%rcx, %rax
	jne	.L1794
.L1793:
	leaq	32+ada__finalization__controlledT(%rip), %rax
	movq	$0, (%rsp)
	movq	$0, 16(%rsp)
	movq	$0, 8(%rsp)
	movl	%ebp, 16(%rbx)
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	movq	%rdx, 8(%rbx)
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	movq	560(%r13), %rax
	movq	%rax, (%rbx)
	movq	%rsp, %rdx
	movq	%rbx, %rdi
.LEHB106:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE106:
.LEHB107:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1804:
	.cfi_restore_state
	movdqu	568(%r13), %xmm0
	movq	%rbx, %rdi
	movups	%xmm0, (%rbx)
	movdqu	584(%r13), %xmm0
	movups	%xmm0, 16(%rbx)
	movq	560(%r13), %rax
	movq	%rax, (%rbx)
	call	math_prime_util__families__bitmask_sieve__word_vectors__adjust__2.81
.LEHE107:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L1796:
	.cfi_restore_state
	movq	%rax, %rbx
	jmp	.L1795
	.section	.gcc_except_table
.LLSDA366:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE366-.LLSDACSB366
.LLSDACSB366:
	.uleb128 .LEHB105-.LFB366
	.uleb128 .LEHE105-.LEHB105
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB106-.LFB366
	.uleb128 .LEHE106-.LEHB106
	.uleb128 .L1796-.LFB366
	.uleb128 0
	.uleb128 .LEHB107-.LFB366
	.uleb128 .LEHE107-.LEHB107
	.uleb128 0
	.uleb128 0
.LLSDACSE366:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC366
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T499b.127.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__T499b.127.cold:
.LFSB366:
.L1795:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	%rsp, %r10
.LEHB108:
	call	math_prime_util__families__bitmask_sieve__word_vectors__to_vector__R1774b___finalizer__2.129
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE108:
	.cfi_endproc
.LFE366:
	.section	.gcc_except_table
.LLSDAC366:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC366-.LLSDACSBC366
.LLSDACSBC366:
	.uleb128 .LEHB108-.LCOLDB70
	.uleb128 .LEHE108-.LEHB108
	.uleb128 0
	.uleb128 0
.LLSDACSEC366:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T499b.127, .-math_prime_util__families__bitmask_sieve__word_vectors__T499b.127
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T499b.127.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__T499b.127.cold
.LCOLDE70:
	.text
.LHOTE70:
	.section	.text.unlikely
	.align 2
.LCOLDB71:
	.text
.LHOTB71:
	.align 2
	.p2align 4
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T511b.115, @function
math_prime_util__families__bitmask_sieve__word_vectors__T511b.115:
.LFB370:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA370
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%r10, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	%edi, %r12d
	movl	$32, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movl	%esi, %ebp
	movl	$8, %esi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
.LEHB109:
	call	system__secondary_stack__ss_allocate@PLT
.LEHE109:
	movq	%rsp, %rdx
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movq	%rax, %rbx
	leaq	80(%rsp), %rax
	movq	%rbx, %rdi
	movq	%rax, 24(%rsp)
	movq	$0, 16(%rsp)
.LEHB110:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	560(%r13), %rax
	movq	$0, 8(%rbx)
	movl	$-1, 16(%rbx)
	movq	%rax, (%rbx)
	xorl	%eax, %eax
	movl	%eax, %ecx
	xchgl	20(%rbx), %ecx
	xchgl	24(%rbx), %eax
	movl	$2, %esi
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__reserve_capacity.70
	movq	8(%rbx), %rax
	movl	16(%rbx), %esi
	testq	%rax, %rax
	je	.L1806
	cmpl	(%rax), %esi
	je	.L1806
	cmpl	$2147483647, %esi
	je	.L1825
	addl	$1, %esi
	movslq	%esi, %rdx
	movl	%r12d, 4(%rax,%rdx,4)
	movq	8(%rbx), %rax
	movl	%esi, 16(%rbx)
	testq	%rax, %rax
	jne	.L1826
.L1810:
	cmpl	$2147483647, %esi
	je	.L1827
	addl	$1, %esi
	movl	$1, %ecx
	movl	%ebp, %edx
	movq	%rbx, %rdi
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
.L1812:
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE110:
.LEHB111:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__families__bitmask_sieve__word_vectors__vectorFD.72(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE111:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1806:
	.cfi_restore_state
	cmpl	$2147483647, %esi
	je	.L1828
	addl	$1, %esi
	movl	$1, %ecx
	movl	%r12d, %edx
	movq	%rbx, %rdi
.LEHB112:
	call	math_prime_util__families__bitmask_sieve__word_vectors__insert__4.58
	movq	8(%rbx), %rax
	movl	16(%rbx), %esi
	testq	%rax, %rax
	je	.L1810
.L1826:
	cmpl	(%rax), %esi
	je	.L1810
	cmpl	$2147483647, %esi
	je	.L1829
	addl	$1, %esi
	movslq	%esi, %rdx
	movl	%ebp, 4(%rax,%rdx,4)
	movl	%esi, 16(%rbx)
	jmp	.L1812
.L1829:
	movl	$223, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1825:
	movl	$223, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1828:
	movl	$229, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1827:
	movl	$229, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE112:
.L1815:
	movq	%rax, %rbx
	jmp	.L1814
	.section	.gcc_except_table
.LLSDA370:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE370-.LLSDACSB370
.LLSDACSB370:
	.uleb128 .LEHB109-.LFB370
	.uleb128 .LEHE109-.LEHB109
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB110-.LFB370
	.uleb128 .LEHE110-.LEHB110
	.uleb128 .L1815-.LFB370
	.uleb128 0
	.uleb128 .LEHB111-.LFB370
	.uleb128 .LEHE111-.LEHB111
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB112-.LFB370
	.uleb128 .LEHE112-.LEHB112
	.uleb128 .L1815-.LFB370
	.uleb128 0
.LLSDACSE370:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC370
	.type	math_prime_util__families__bitmask_sieve__word_vectors__T511b.115.cold, @function
math_prime_util__families__bitmask_sieve__word_vectors__T511b.115.cold:
.LFSB370:
.L1814:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movq	%rsp, %r10
.LEHB113:
	call	math_prime_util__families__bitmask_sieve__word_vectors__Oconcat__R1099b___finalizer__4.117
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE113:
	.cfi_endproc
.LFE370:
	.section	.gcc_except_table
.LLSDAC370:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC370-.LLSDACSBC370
.LLSDACSBC370:
	.uleb128 .LEHB113-.LCOLDB71
	.uleb128 .LEHE113-.LEHB113
	.uleb128 0
	.uleb128 0
.LLSDACSEC370:
	.section	.text.unlikely
	.text
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T511b.115, .-math_prime_util__families__bitmask_sieve__word_vectors__T511b.115
	.section	.text.unlikely
	.size	math_prime_util__families__bitmask_sieve__word_vectors__T511b.115.cold, .-math_prime_util__families__bitmask_sieve__word_vectors__T511b.115.cold
.LCOLDE71:
	.text
.LHOTE71:
	.align 2
	.p2align 4
	.globl	math_prime_util__families__lucky_vectors__vectorDA__2
	.type	math_prime_util__families__lucky_vectors__vectorDA__2, @function
math_prime_util__families__lucky_vectors__vectorDA__2:
.LFB158:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rbp, 32(%rsp)
	.cfi_offset 6, -32
	movl	16(%rdi), %ebp
	cmpl	$-1, %ebp
	je	.L1834
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
	