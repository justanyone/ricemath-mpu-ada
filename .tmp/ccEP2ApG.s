	.file	"math_prime_util-factor.adb"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__finalize
	.type	math_prime_util__factor__u64_vectors__implementation__finalize, @function
math_prime_util__factor__u64_vectors__implementation__finalize:
.LFB4:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	je	.L1
	movq	$0, 8(%rdi)
.L1:
	ret
	.cfi_endproc
.LFE4:
	.size	math_prime_util__factor__u64_vectors__implementation__finalize, .-math_prime_util__factor__u64_vectors__implementation__finalize
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__finalize__2
	.type	math_prime_util__factor__u64_vectors__implementation__finalize__2, @function
math_prime_util__factor__u64_vectors__implementation__finalize__2:
.LFB5:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE5:
	.size	math_prime_util__factor__u64_vectors__implementation__finalize__2, .-math_prime_util__factor__u64_vectors__implementation__finalize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__finalize__3
	.type	math_prime_util__factor__u64_vectors__implementation__finalize__3, @function
math_prime_util__factor__u64_vectors__implementation__finalize__3:
.LFB6:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE6:
	.size	math_prime_util__factor__u64_vectors__implementation__finalize__3, .-math_prime_util__factor__u64_vectors__implementation__finalize__3
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__initialize__2
	.type	math_prime_util__factor__u64_vectors__implementation__initialize__2, @function
math_prime_util__factor__u64_vectors__implementation__initialize__2:
.LFB7:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE7:
	.size	math_prime_util__factor__u64_vectors__implementation__initialize__2, .-math_prime_util__factor__u64_vectors__implementation__initialize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__initialize__3
	.type	math_prime_util__factor__u64_vectors__implementation__initialize__3, @function
math_prime_util__factor__u64_vectors__implementation__initialize__3:
.LFB8:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE8:
	.size	math_prime_util__factor__u64_vectors__implementation__initialize__3, .-math_prime_util__factor__u64_vectors__implementation__initialize__3
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__capacity
	.type	math_prime_util__factor__u64_vectors__capacity, @function
math_prime_util__factor__u64_vectors__capacity:
.LFB30:
	.cfi_startproc
	movq	8(%rdi), %rdx
	xorl	%eax, %eax
	testq	%rdx, %rdx
	je	.L8
	movl	(%rdx), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
.L8:
	ret
	.cfi_endproc
.LFE30:
	.size	math_prime_util__factor__u64_vectors__capacity, .-math_prime_util__factor__u64_vectors__capacity
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__clear
	.type	math_prime_util__factor__u64_vectors__clear, @function
math_prime_util__factor__u64_vectors__clear:
.LFB31:
	.cfi_startproc
	movl	$0, 16(%rdi)
	ret
	.cfi_endproc
.LFE31:
	.size	math_prime_util__factor__u64_vectors__clear, .-math_prime_util__factor__u64_vectors__clear
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__constant_reference
	.type	math_prime_util__factor__u64_vectors__constant_reference, @function
math_prime_util__factor__u64_vectors__constant_reference:
.LFB32:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	(%rdx,%rcx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__factor__u64_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE32:
	.size	math_prime_util__factor__u64_vectors__constant_reference, .-math_prime_util__factor__u64_vectors__constant_reference
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__constant_reference__2
	.type	math_prime_util__factor__u64_vectors__constant_reference__2, @function
math_prime_util__factor__u64_vectors__constant_reference__2:
.LFB33:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	(%rcx,%rdx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__factor__u64_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE33:
	.size	math_prime_util__factor__u64_vectors__constant_reference__2, .-math_prime_util__factor__u64_vectors__constant_reference__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__contains
	.type	math_prime_util__factor__u64_vectors__contains, @function
math_prime_util__factor__u64_vectors__contains:
.LFB34:
	.cfi_startproc
	movl	16(%rdi), %edx
	testl	%edx, %edx
	jle	.L16
	movq	8(%rdi), %rax
	leaq	(%rax,%rdx,8), %rdx
	jmp	.L18
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L21:
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L16
.L18:
	cmpq	8(%rax), %rsi
	jne	.L21
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L16:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE34:
	.size	math_prime_util__factor__u64_vectors__contains, .-math_prime_util__factor__u64_vectors__contains
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__element
	.type	math_prime_util__factor__u64_vectors__element, @function
math_prime_util__factor__u64_vectors__element:
.LFB41:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movq	(%rax,%rsi,8), %rax
	ret
	.cfi_endproc
.LFE41:
	.size	math_prime_util__factor__u64_vectors__element, .-math_prime_util__factor__u64_vectors__element
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__finalize__4
	.type	math_prime_util__factor__u64_vectors__finalize__4, @function
math_prime_util__factor__u64_vectors__finalize__4:
.LFB46:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE46:
	.size	math_prime_util__factor__u64_vectors__finalize__4, .-math_prime_util__factor__u64_vectors__finalize__4
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__find
	.type	math_prime_util__factor__u64_vectors__find, @function
math_prime_util__factor__u64_vectors__find:
.LFB47:
	.cfi_startproc
	movq	%rcx, %r8
	movl	16(%rdi), %ecx
	cmpl	%ecx, %r8d
	jg	.L25
	movslq	%r8d, %rdx
	subl	%r8d, %ecx
	movq	8(%rdi), %rax
	leaq	1(%rdx,%rcx), %rcx
	jmp	.L28
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L26:
	addq	$1, %rdx
	cmpq	%rcx, %rdx
	je	.L25
.L28:
	cmpq	%rsi, (%rax,%rdx,8)
	jne	.L26
	movq	%rdi, %rsi
	xorl	%edi, %edi
	jmp	.L27
	.p2align 4,,10
	.p2align 3
.L25:
	xorl	%esi, %esi
	xorl	%edi, %edi
	movl	$1, %edx
.L27:
	movabsq	$-4294967296, %rcx
	movq	%rdi, %rax
	movl	%edx, %edx
	andq	%rcx, %rax
	orq	%rdx, %rax
	movq	%rax, %rdi
	movq	%rsi, %rax
	movq	%rdi, %rdx
	ret
	.cfi_endproc
.LFE47:
	.size	math_prime_util__factor__u64_vectors__find, .-math_prime_util__factor__u64_vectors__find
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__find_index
	.type	math_prime_util__factor__u64_vectors__find_index, @function
math_prime_util__factor__u64_vectors__find_index:
.LFB48:
	.cfi_startproc
	movq	%rdi, %rax
	movl	%edx, %edi
	movl	16(%rax), %ecx
	cmpl	%edx, %ecx
	jl	.L35
	movq	8(%rax), %rdx
	subl	%edi, %ecx
	movslq	%edi, %rax
	leaq	1(%rax,%rcx), %rcx
	jmp	.L34
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L37:
	addq	$1, %rax
	cmpq	%rcx, %rax
	je	.L35
.L34:
	cmpq	%rsi, (%rdx,%rax,8)
	jne	.L37
	ret
	.p2align 4,,10
	.p2align 3
.L35:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE48:
	.size	math_prime_util__factor__u64_vectors__find_index, .-math_prime_util__factor__u64_vectors__find_index
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__first
	.type	math_prime_util__factor__u64_vectors__first, @function
math_prime_util__factor__u64_vectors__first:
.LFB49:
	.cfi_startproc
	movq	%rdi, %rax
	movq	%rdi, %rsi
	xorl	%edi, %edi
	movl	16(%rax), %eax
	testl	%eax, %eax
	jle	.L41
.L40:
	movabsq	$-4294967296, %rax
	movq	%rdi, %rdx
	andq	%rax, %rdx
	movq	%rsi, %rax
	orq	$1, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L41:
	xorl	%esi, %esi
	xorl	%edi, %edi
	jmp	.L40
	.cfi_endproc
.LFE49:
	.size	math_prime_util__factor__u64_vectors__first, .-math_prime_util__factor__u64_vectors__first
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__first_element
	.type	math_prime_util__factor__u64_vectors__first_element, @function
math_prime_util__factor__u64_vectors__first_element:
.LFB51:
	.cfi_startproc
	movq	8(%rdi), %rax
	movq	8(%rax), %rax
	ret
	.cfi_endproc
.LFE51:
	.size	math_prime_util__factor__u64_vectors__first_element, .-math_prime_util__factor__u64_vectors__first_element
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__first_index
	.type	math_prime_util__factor__u64_vectors__first_index, @function
math_prime_util__factor__u64_vectors__first_index:
.LFB52:
	.cfi_startproc
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE52:
	.size	math_prime_util__factor__u64_vectors__first_index, .-math_prime_util__factor__u64_vectors__first_index
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__is_empty
	.type	math_prime_util__factor__u64_vectors__is_empty, @function
math_prime_util__factor__u64_vectors__is_empty:
.LFB66:
	.cfi_startproc
	movl	16(%rdi), %eax
	testl	%eax, %eax
	setle	%al
	ret
	.cfi_endproc
.LFE66:
	.size	math_prime_util__factor__u64_vectors__is_empty, .-math_prime_util__factor__u64_vectors__is_empty
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__iterate
	.type	math_prime_util__factor__u64_vectors__iterate, @function
math_prime_util__factor__u64_vectors__iterate:
.LFB67:
	.cfi_startproc
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%r14, 56(%rsp)
	.cfi_offset 14, -24
	movl	16(%rdi), %r14d
	testl	%r14d, %r14d
	jle	.L45
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
	xorl	%ebp, %ebp
	movq	%r15, 64(%rsp)
	.cfi_offset 15, -16
	movabsq	$-4294967296, %r15
	.p2align 4
	.p2align 3
.L48:
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
	jne	.L54
.L47:
	call	*%rax
	cmpl	%ebp, %r14d
	jne	.L48
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
.L45:
	movq	56(%rsp), %r14
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
.L54:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	movq	-1(%rbx), %r10
	movq	7(%rbx), %rax
	jmp	.L47
	.cfi_endproc
.LFE67:
	.size	math_prime_util__factor__u64_vectors__iterate, .-math_prime_util__factor__u64_vectors__iterate
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__last
	.type	math_prime_util__factor__u64_vectors__last, @function
math_prime_util__factor__u64_vectors__last:
.LFB72:
	.cfi_startproc
	movl	16(%rdi), %ecx
	movq	%rdi, %rax
	xorl	%edx, %edx
	testl	%ecx, %ecx
	jg	.L57
	xorl	%eax, %eax
	xorl	%edx, %edx
	movl	$1, %ecx
.L57:
	movabsq	$-4294967296, %rdi
	movl	%ecx, %esi
	movq	%rdx, %rcx
	andq	%rdi, %rcx
	orq	%rsi, %rcx
	movq	%rcx, %rdx
	ret
	.cfi_endproc
.LFE72:
	.size	math_prime_util__factor__u64_vectors__last, .-math_prime_util__factor__u64_vectors__last
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__last_element
	.type	math_prime_util__factor__u64_vectors__last_element, @function
math_prime_util__factor__u64_vectors__last_element:
.LFB74:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	16(%rdi), %rdx
	movq	(%rax,%rdx,8), %rax
	ret
	.cfi_endproc
.LFE74:
	.size	math_prime_util__factor__u64_vectors__last_element, .-math_prime_util__factor__u64_vectors__last_element
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__last_index
	.type	math_prime_util__factor__u64_vectors__last_index, @function
math_prime_util__factor__u64_vectors__last_index:
.LFB75:
	.cfi_startproc
	movl	16(%rdi), %eax
	ret
	.cfi_endproc
.LFE75:
	.size	math_prime_util__factor__u64_vectors__last_index, .-math_prime_util__factor__u64_vectors__last_index
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__move
	.type	math_prime_util__factor__u64_vectors__move, @function
math_prime_util__factor__u64_vectors__move:
.LFB77:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L60
	movq	8(%rdi), %rax
	movq	8(%rsi), %rdx
	movq	%rdx, 8(%rdi)
	movq	%rax, 8(%rsi)
	movl	16(%rsi), %eax
	movl	%eax, 16(%rdi)
	movl	$0, 16(%rsi)
.L60:
	ret
	.cfi_endproc
.LFE77:
	.size	math_prime_util__factor__u64_vectors__move, .-math_prime_util__factor__u64_vectors__move
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__query_element
	.type	math_prime_util__factor__u64_vectors__query_element, @function
math_prime_util__factor__u64_vectors__query_element:
.LFB89:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movq	(%rax,%rsi,8), %rdi
	testb	$1, %dl
	jne	.L67
	jmp	*%rdx
.L67:
	movq	-1(%rdx), %r10
	movq	7(%rdx), %rdx
	jmp	*%rdx
	.cfi_endproc
.LFE89:
	.size	math_prime_util__factor__u64_vectors__query_element, .-math_prime_util__factor__u64_vectors__query_element
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__reference
	.type	math_prime_util__factor__u64_vectors__reference, @function
math_prime_util__factor__u64_vectors__reference:
.LFB95:
	.cfi_startproc
	movq	8(%rsi), %rdx
	movslq	%ecx, %rcx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	(%rdx,%rcx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__factor__u64_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE95:
	.size	math_prime_util__factor__u64_vectors__reference, .-math_prime_util__factor__u64_vectors__reference
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__reference__2
	.type	math_prime_util__factor__u64_vectors__reference__2, @function
math_prime_util__factor__u64_vectors__reference__2:
.LFB96:
	.cfi_startproc
	movq	8(%rsi), %rcx
	movslq	%edx, %rdx
	addq	$20, %rsi
	movq	%rdi, %rax
	movq	%rsi, 16(%rdi)
	leaq	(%rcx,%rdx,8), %rdx
	movq	%rdx, (%rdi)
	leaq	32+math_prime_util__factor__u64_vectors__implementation__reference_control_typeT(%rip), %rdi
	movq	%rdi, 8(%rax)
	ret
	.cfi_endproc
.LFE96:
	.size	math_prime_util__factor__u64_vectors__reference__2, .-math_prime_util__factor__u64_vectors__reference__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__replace_element
	.type	math_prime_util__factor__u64_vectors__replace_element, @function
math_prime_util__factor__u64_vectors__replace_element:
.LFB97:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%esi, %rsi
	movq	%rdx, (%rax,%rsi,8)
	ret
	.cfi_endproc
.LFE97:
	.size	math_prime_util__factor__u64_vectors__replace_element, .-math_prime_util__factor__u64_vectors__replace_element
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__replace_element__2
	.type	math_prime_util__factor__u64_vectors__replace_element__2, @function
math_prime_util__factor__u64_vectors__replace_element__2:
.LFB98:
	.cfi_startproc
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movq	%rcx, (%rax,%rdx,8)
	ret
	.cfi_endproc
.LFE98:
	.size	math_prime_util__factor__u64_vectors__replace_element__2, .-math_prime_util__factor__u64_vectors__replace_element__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__reverse_find
	.type	math_prime_util__factor__u64_vectors__reverse_find, @function
math_prime_util__factor__u64_vectors__reverse_find:
.LFB101:
	.cfi_startproc
	movq	%rdx, %rax
	movl	16(%rdi), %edx
	cmpl	%ecx, %edx
	cmovle	%edx, %ecx
	testq	%rax, %rax
	cmovne	%ecx, %edx
	testl	%edx, %edx
	jle	.L74
	movl	%edx, %edx
	movq	8(%rdi), %rax
	addq	$1, %rdx
	jmp	.L77
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L75:
	cmpq	$1, %rdx
	je	.L74
.L77:
	subq	$1, %rdx
	cmpq	%rsi, (%rax,%rdx,8)
	jne	.L75
	movq	%rdi, %rsi
	xorl	%edi, %edi
	jmp	.L76
	.p2align 4,,10
	.p2align 3
.L74:
	xorl	%esi, %esi
	xorl	%edi, %edi
	movl	$1, %edx
.L76:
	movabsq	$-4294967296, %rcx
	movq	%rdi, %rax
	movl	%edx, %edx
	andq	%rcx, %rax
	orq	%rdx, %rax
	movq	%rax, %rdi
	movq	%rsi, %rax
	movq	%rdi, %rdx
	ret
	.cfi_endproc
.LFE101:
	.size	math_prime_util__factor__u64_vectors__reverse_find, .-math_prime_util__factor__u64_vectors__reverse_find
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__reverse_find_index
	.type	math_prime_util__factor__u64_vectors__reverse_find_index, @function
math_prime_util__factor__u64_vectors__reverse_find_index:
.LFB102:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	testl	%edx, %edx
	jle	.L86
	movl	%edx, %edx
	leaq	1(%rdx), %rax
	movq	8(%rdi), %rdx
	jmp	.L85
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L88:
	cmpq	$1, %rax
	je	.L86
.L85:
	subq	$1, %rax
	cmpq	%rsi, (%rdx,%rax,8)
	jne	.L88
	ret
	.p2align 4,,10
	.p2align 3
.L86:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE102:
	.size	math_prime_util__factor__u64_vectors__reverse_find_index, .-math_prime_util__factor__u64_vectors__reverse_find_index
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__reverse_iterate
	.type	math_prime_util__factor__u64_vectors__reverse_iterate, @function
math_prime_util__factor__u64_vectors__reverse_iterate:
.LFB103:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%r15, 48(%rsp)
	.cfi_offset 15, -16
	movl	16(%rdi), %r15d
	testl	%r15d, %r15d
	jle	.L89
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
.L92:
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
	jne	.L98
.L91:
	call	*%rax
	cmpq	$1, %r15
	jne	.L92
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
.L89:
	movq	48(%rsp), %r15
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
.L98:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	movq	-1(%rbx), %r10
	movq	7(%rbx), %rax
	jmp	.L91
	.cfi_endproc
.LFE103:
	.size	math_prime_util__factor__u64_vectors__reverse_iterate, .-math_prime_util__factor__u64_vectors__reverse_iterate
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__swap
	.type	math_prime_util__factor__u64_vectors__swap, @function
math_prime_util__factor__u64_vectors__swap:
.LFB105:
	.cfi_startproc
	cmpl	%edx, %esi
	je	.L99
	movq	8(%rdi), %rax
	movslq	%edx, %rdx
	movslq	%esi, %rsi
	movq	(%rax,%rdx,8), %r8
	movq	(%rax,%rsi,8), %rcx
	movq	%r8, (%rax,%rsi,8)
	movq	8(%rdi), %rax
	movq	%rcx, (%rax,%rdx,8)
.L99:
	ret
	.cfi_endproc
.LFE105:
	.size	math_prime_util__factor__u64_vectors__swap, .-math_prime_util__factor__u64_vectors__swap
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__to_cursor
	.type	math_prime_util__factor__u64_vectors__to_cursor, @function
math_prime_util__factor__u64_vectors__to_cursor:
.LFB107:
	.cfi_startproc
	testl	%esi, %esi
	jle	.L102
	movq	%rdi, %r8
	xorl	%r9d, %r9d
	cmpl	%esi, 16(%rdi)
	jge	.L104
.L102:
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	movl	$1, %esi
.L104:
	movabsq	$-4294967296, %rax
	movq	%r9, %rdx
	movl	%esi, %esi
	andq	%rax, %rdx
	movq	%r8, %rax
	orq	%rsi, %rdx
	ret
	.cfi_endproc
.LFE107:
	.size	math_prime_util__factor__u64_vectors__to_cursor, .-math_prime_util__factor__u64_vectors__to_cursor
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__update_element
	.type	math_prime_util__factor__u64_vectors__update_element, @function
math_prime_util__factor__u64_vectors__update_element:
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
	movq	0(%rbp,%rbx,8), %rdi
	testb	$1, %dl
	jne	.L111
.L106:
	call	*%rdx
	movq	%rax, 0(%rbp,%rbx,8)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L111:
	.cfi_restore_state
	movq	-1(%rdx), %r10
	movq	7(%rdx), %rdx
	jmp	.L106
	.cfi_endproc
.LFE113:
	.size	math_prime_util__factor__u64_vectors__update_element, .-math_prime_util__factor__u64_vectors__update_element
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__update_element__2
	.type	math_prime_util__factor__u64_vectors__update_element__2, @function
math_prime_util__factor__u64_vectors__update_element__2:
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
	movq	0(%rbp,%rbx,8), %rdi
	testb	$1, %cl
	jne	.L118
.L113:
	call	*%rcx
	movq	%rax, 0(%rbp,%rbx,8)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L118:
	.cfi_restore_state
	movq	-1(%rcx), %r10
	movq	7(%rcx), %rcx
	jmp	.L113
	.cfi_endproc
.LFE114:
	.size	math_prime_util__factor__u64_vectors__update_element__2, .-math_prime_util__factor__u64_vectors__update_element__2
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B11s___finalizer.11, @function
math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B11s___finalizer.11:
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
	.size	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B11s___finalizer.11, .-math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B11s___finalizer.11
	.set	math_prime_util__factor__u64_vectors__TiteratorCFD__B350s___finalizer.16,math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B11s___finalizer.11
	.set	math_prime_util__factor__u64_vectors__implementation__Twith_lockCFD__B125s___finalizer.14,math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B11s___finalizer.11
	.set	math_prime_util__factor__u64_vectors__implementation__Twith_busyCFD__B114s___finalizer.13,math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B11s___finalizer.11
	.set	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B20s___finalizer.12,math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Tforward_iteratorCFD__B11s___finalizer.11
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation___size
	.type	math_prime_util__factor__u64_vectors__implementation___size, @function
math_prime_util__factor__u64_vectors__implementation___size:
.LFB124:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE124:
	.size	math_prime_util__factor__u64_vectors__implementation___size, .-math_prime_util__factor__u64_vectors__implementation___size
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__reference_control_typeDA
	.type	math_prime_util__factor__u64_vectors__implementation__reference_control_typeDA, @function
math_prime_util__factor__u64_vectors__implementation__reference_control_typeDA:
.LFB132:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE132:
	.size	math_prime_util__factor__u64_vectors__implementation__reference_control_typeDA, .-math_prime_util__factor__u64_vectors__implementation__reference_control_typeDA
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors___size__2
	.type	math_prime_util__factor__u64_vectors___size__2, @function
math_prime_util__factor__u64_vectors___size__2:
.LFB153:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE153:
	.size	math_prime_util__factor__u64_vectors___size__2, .-math_prime_util__factor__u64_vectors___size__2
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T584s, @function
math_prime_util__factor__u64_vectors__T584s:
.LFB318:
	.cfi_startproc
	movq	(%rdi), %rax
	movzbl	%sil, %esi
	addq	-16(%rax), %rdi
	jmp	system__finalization_root__root_controlledDA@PLT
	.cfi_endproc
.LFE318:
	.size	math_prime_util__factor__u64_vectors__T584s, .-math_prime_util__factor__u64_vectors__T584s
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0, @function
math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0:
.LFB16:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%r10, %rbx
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbx, %rdi
	leaq	math_prime_util__factor__u64_vectors__vectorFD(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
	.cfi_endproc
.LFE16:
	.size	math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0, .-math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0
	.set	math_prime_util__factor__u64_vectors__vectorSI__R292s___finalizer__2.15,math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0
	.set	math_prime_util__factor__u64_vectors__to_vector__R1478s___finalizer__2.10,math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0
	.set	math_prime_util__factor__u64_vectors__to_vector__R1448s___finalizer.9,math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0
	.set	math_prime_util__factor__u64_vectors__empty__R911s___finalizer.5,math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0
	.set	math_prime_util__factor__u64_vectors__copy__R873s___finalizer.4,math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0
	.set	math_prime_util__factor__u64_vectors__Oconcat__R803s___finalizer__4.3,math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0
	.set	math_prime_util__factor__u64_vectors__Oconcat__R794s___finalizer__3.2,math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0
	.set	math_prime_util__factor__u64_vectors__Oconcat__R785s___finalizer__2.1,math_prime_util__factor__u64_vectors__Oconcat__R776s___finalizer.0
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__adjust__2
	.type	math_prime_util__factor__u64_vectors__adjust__2, @function
math_prime_util__factor__u64_vectors__adjust__2:
.LFB24:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rbx, 40(%rsp)
	.cfi_offset 3, -24
	movl	16(%rdi), %ebx
	testl	%ebx, %ebx
	jne	.L128
	movq	$0, 8(%rdi)
	movq	40(%rsp), %rbx
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L128:
	.cfi_restore_state
	movq	%r14, 48(%rsp)
	.cfi_offset 14, -16
	movslq	%ebx, %rdx
	movq	8(%rdi), %r14
	movl	$0, 16(%rdi)
	salq	$3, %rdx
	movq	$0, 8(%rdi)
	movq	%rdi, 24(%rsp)
	leaq	8(%rdx), %rdi
	movq	%rdx, 16(%rsp)
	call	__gnat_malloc@PLT
	movq	16(%rsp), %rdx
	leaq	8(%r14), %rsi
	movl	%ebx, (%rax)
	leaq	8(%rax), %rdi
	movq	%rax, 8(%rsp)
	call	memcpy@PLT
	movq	24(%rsp), %rcx
	movq	8(%rsp), %r8
	movq	48(%rsp), %r14
	.cfi_restore 14
	movl	%ebx, 16(%rcx)
	movq	40(%rsp), %rbx
	movq	%r8, 8(%rcx)
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	math_prime_util__factor__u64_vectors__adjust__2, .-math_prime_util__factor__u64_vectors__adjust__2
	.section	.rodata
.LC8:
	.ascii	"a-convec.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__delete
	.type	math_prime_util__factor__u64_vectors__delete, @function
math_prime_util__factor__u64_vectors__delete:
.LFB37:
	.cfi_startproc
	movl	16(%rdi), %eax
	testl	%edx, %edx
	je	.L152
	cmpl	%esi, %eax
	jl	.L152
	movl	%eax, %ecx
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	subl	%esi, %ecx
	jo	.L136
	cmpl	$2147483647, %ecx
	je	.L136
	addl	$1, %ecx
	cmpl	%ecx, %edx
	jge	.L155
	subl	%edx, %eax
	movl	%eax, %ecx
	jo	.L139
	addl	%esi, %edx
	jo	.L156
	movq	8(%rdi), %r9
	movslq	%esi, %r10
	movq	%rdi, 8(%rsp)
	movslq	%ecx, %rdi
	subq	%r10, %rdi
	xorl	%eax, %eax
	cmpl	%ecx, %esi
	movslq	%edx, %rdx
	leaq	8(,%rdi,8), %rdi
	leaq	(%r9,%rdx,8), %rsi
	movl	%ecx, 4(%rsp)
	cmovle	%rdi, %rax
	leaq	(%r9,%r10,8), %rdi
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
.L152:
	ret
	.p2align 4,,10
	.p2align 3
.L155:
	.cfi_def_cfa_offset 32
	subl	$1, %esi
	movl	%esi, 16(%rdi)
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L136:
	.cfi_restore_state
	movl	$460, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L139:
	movl	$484, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L156:
	movl	$485, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE37:
	.size	math_prime_util__factor__u64_vectors__delete, .-math_prime_util__factor__u64_vectors__delete
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__delete__2
	.type	math_prime_util__factor__u64_vectors__delete__2, @function
math_prime_util__factor__u64_vectors__delete__2:
.LFB38:
	.cfi_startproc
	movq	%rdi, %rax
	movq	%rdx, %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	%ecx, %edx
	movl	%edi, %esi
	movq	%rax, %rdi
	call	math_prime_util__factor__u64_vectors__delete
	xorl	%eax, %eax
	movl	$1, %edx
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE38:
	.size	math_prime_util__factor__u64_vectors__delete__2, .-math_prime_util__factor__u64_vectors__delete__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__finalize__2
	.type	math_prime_util__factor__u64_vectors__finalize__2, @function
math_prime_util__factor__u64_vectors__finalize__2:
.LFB45:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$0, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L159
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L159:
	ret
	.cfi_endproc
.LFE45:
	.size	math_prime_util__factor__u64_vectors__finalize__2, .-math_prime_util__factor__u64_vectors__finalize__2
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC9:
	.string	"MATH_PRIME_UTIL.FACTOR.U64_VECTORS.IMPLEMENTATION.REFERENCE_CONTROL_TYPE"
	.section	.rodata
	.align 8
.LC0:
	.long	1
	.long	72
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__reference_control_typePI
	.type	math_prime_util__factor__u64_vectors__implementation__reference_control_typePI, @function
math_prime_util__factor__u64_vectors__implementation__reference_control_typePI:
.LFB125:
	.cfi_startproc
	leaq	.LC9(%rip), %rsi
	leaq	.LC0(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE125:
	.size	math_prime_util__factor__u64_vectors__implementation__reference_control_typePI, .-math_prime_util__factor__u64_vectors__implementation__reference_control_typePI
	.section	.rodata.str1.8
	.align 8
.LC10:
	.string	"MATH_PRIME_UTIL.FACTOR.U64_VECTORS.IMPLEMENTATION.WITH_BUSY"
	.section	.rodata
	.align 8
.LC4:
	.long	1
	.long	59
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__with_busyPI
	.type	math_prime_util__factor__u64_vectors__implementation__with_busyPI, @function
math_prime_util__factor__u64_vectors__implementation__with_busyPI:
.LFB137:
	.cfi_startproc
	leaq	.LC10(%rip), %rsi
	leaq	.LC4(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE137:
	.size	math_prime_util__factor__u64_vectors__implementation__with_busyPI, .-math_prime_util__factor__u64_vectors__implementation__with_busyPI
	.section	.rodata.str1.8
	.align 8
.LC11:
	.string	"MATH_PRIME_UTIL.FACTOR.U64_VECTORS.IMPLEMENTATION.WITH_LOCK"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__with_lockPI
	.type	math_prime_util__factor__u64_vectors__implementation__with_lockPI, @function
math_prime_util__factor__u64_vectors__implementation__with_lockPI:
.LFB143:
	.cfi_startproc
	leaq	.LC11(%rip), %rsi
	leaq	.LC4(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE143:
	.size	math_prime_util__factor__u64_vectors__implementation__with_lockPI, .-math_prime_util__factor__u64_vectors__implementation__with_lockPI
	.section	.rodata.str1.8
	.align 8
.LC12:
	.string	"MATH_PRIME_UTIL.FACTOR.U64_VECTORS.ITERATOR"
	.section	.rodata
	.align 8
.LC5:
	.long	1
	.long	43
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__iteratorPI__2
	.type	math_prime_util__factor__u64_vectors__iteratorPI__2, @function
math_prime_util__factor__u64_vectors__iteratorPI__2:
.LFB172:
	.cfi_startproc
	leaq	.LC12(%rip), %rsi
	leaq	.LC5(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE172:
	.size	math_prime_util__factor__u64_vectors__iteratorPI__2, .-math_prime_util__factor__u64_vectors__iteratorPI__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__reference_control_typeSR
	.type	math_prime_util__factor__u64_vectors__implementation__reference_control_typeSR, @function
math_prime_util__factor__u64_vectors__implementation__reference_control_typeSR:
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
	.size	math_prime_util__factor__u64_vectors__implementation__reference_control_typeSR, .-math_prime_util__factor__u64_vectors__implementation__reference_control_typeSR
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__reference_control_typeSW
	.type	math_prime_util__factor__u64_vectors__implementation__reference_control_typeSW, @function
math_prime_util__factor__u64_vectors__implementation__reference_control_typeSW:
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
	.size	math_prime_util__factor__u64_vectors__implementation__reference_control_typeSW, .-math_prime_util__factor__u64_vectors__implementation__reference_control_typeSW
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__Oeq__3
	.type	math_prime_util__factor__u64_vectors__implementation__Oeq__3, @function
math_prime_util__factor__u64_vectors__implementation__Oeq__3:
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
	je	.L169
	movq	8(%rbx), %rax
	cmpq	%rax, 8(%rbp)
	sete	%al
.L169:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE130:
	.size	math_prime_util__factor__u64_vectors__implementation__Oeq__3, .-math_prime_util__factor__u64_vectors__implementation__Oeq__3
	.section	.rodata
.LC13:
	.ascii	"math_prime_util-factor.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__factor__pp1_pow, @function
math_prime_util__factor__pp1_pow:
.LFB225:
	.cfi_startproc
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movq	%rdi, %rax
	movq	%rbp, 80(%rsp)
	.cfi_offset 6, -48
	movq	%rdx, %rbp
	movq	%r12, 88(%rsp)
	.cfi_offset 12, -40
	movq	%rdx, %r12
	mulq	%rdi
	movq	%r13, 96(%rsp)
	.cfi_offset 13, -32
	xorl	%r13d, %r13d
	movq	%r15, 112(%rsp)
	movq	%r13, %rcx
	.cfi_offset 15, -16
	movq	%rdi, %r15
	movq	%rsi, 8(%rsp)
	movq	%rax, %rdi
	movq	%rdx, %rsi
	movq	%rbp, %rdx
	movq	%rbx, 72(%rsp)
	.cfi_offset 3, -56
	xorl	%ebx, %ebx
	call	__umodti3@PLT
	leaq	-2(%rbp), %r9
	movq	%rbx, 24(%rsp)
	movq	%r9, %rcx
	movq	%r9, 16(%rsp)
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	cmpq	%rbp, %rcx
	movq	%rbx, %rdi
	sbbq	%r13, %rdi
	jnc	.L191
	leaq	(%r9,%rax), %rbx
.L177:
	cmpq	$1, 8(%rsp)
	ja	.L192
.L175:
	movq	%r15, %rax
	movq	72(%rsp), %rbx
	movq	80(%rsp), %rbp
	movq	88(%rsp), %r12
	movq	96(%rsp), %r13
	movq	112(%rsp), %r15
	addq	$120, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L192:
	.cfi_restore_state
	movq	8(%rsp), %rdi
	movl	$2, %esi
	movq	%r9, 32(%rsp)
	call	math_prime_util__int__logint@PLT
	movq	32(%rsp), %r9
	leaq	-1(%rax), %rcx
	cmpq	$2147483647, %rcx
	ja	.L193
	cmpl	$63, %ecx
	ja	.L175
	movq	%r14, 104(%rsp)
	.cfi_offset 14, -24
	movl	$1, %r14d
	salq	%cl, %r14
	movq	%rbp, %rcx
	movq	%r9, 56(%rsp)
	movq	$0, 40(%rsp)
	subq	%r15, %rcx
	movq	%rcx, 32(%rsp)
	movq	%rcx, 48(%rsp)
	jmp	.L188
	.p2align 4,,10
	.p2align 3
.L197:
	movq	%rbx, %rax
	movq	%r13, %rcx
	mulq	%rbx
	movq	%rax, %rdi
	movq	%rdx, %rsi
	movq	%r12, %rdx
	call	__umodti3@PLT
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rbx
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	cmpq	%r12, %rcx
	movq	%rbx, %rdi
	sbbq	%r13, %rdi
	jnc	.L194
	movq	56(%rsp), %rbx
	movq	%rbp, %r15
	addq	%rax, %rbx
.L186:
	shrq	%r14
	je	.L195
.L188:
	movq	%r15, %rax
	movq	%r13, %rcx
	mulq	%rbx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r12, %rdx
	call	__umodti3@PLT
	movq	32(%rsp), %rsi
	movq	40(%rsp), %rdi
	addq	%rax, %rsi
	adcq	%rdx, %rdi
	cmpq	%r12, %rsi
	movq	%rdi, %rcx
	sbbq	%r13, %rcx
	jnc	.L196
	movq	48(%rsp), %rdi
	leaq	(%rdi,%rax), %rbp
.L183:
	testq	%r14, 8(%rsp)
	jne	.L197
	movq	%r15, %rax
	movq	%r13, %rcx
	mulq	%r15
	movq	%rax, %rdi
	movq	%rdx, %rsi
	movq	%r12, %rdx
	call	__umodti3@PLT
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rbx
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	cmpq	%r12, %rcx
	movq	%rbx, %rdi
	sbbq	%r13, %rdi
	jnc	.L198
	movq	56(%rsp), %rbx
	shrq	%r14
	leaq	(%rbx,%rax), %r15
	movq	%rbp, %rbx
	jne	.L188
.L195:
	movq	104(%rsp), %r14
	.cfi_remember_state
	.cfi_restore 14
	jmp	.L175
	.p2align 4,,10
	.p2align 3
.L196:
	.cfi_restore_state
	movq	%rsi, %rax
	movq	%r12, %rdx
	movq	%rdi, %rsi
	movq	%r13, %rcx
	movq	%rax, %rdi
	call	__umodti3@PLT
	movq	%rax, %rbp
	jmp	.L183
	.p2align 4,,10
	.p2align 3
.L194:
	movq	%rcx, %rdi
	movq	%rbx, %rsi
	movq	%r12, %rdx
	movq	%r13, %rcx
	call	__umodti3@PLT
	movq	%rbp, %r15
	movq	%rax, %rbx
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L198:
	movq	%rcx, %rdi
	movq	%rbx, %rsi
	movq	%r12, %rdx
	movq	%r13, %rcx
	call	__umodti3@PLT
	movq	%rbp, %rbx
	movq	%rax, %r15
	jmp	.L186
	.p2align 4,,10
	.p2align 3
.L191:
	.cfi_restore 14
	movq	%rcx, %rdi
	movq	%rbx, %rsi
	movq	%rbp, %rdx
	movq	%r13, %rcx
	movq	%r9, 32(%rsp)
	call	__umodti3@PLT
	movq	32(%rsp), %r9
	movq	%rax, %rbx
	jmp	.L177
.L193:
	movl	$677, %esi
	leaq	.LC13(%rip), %rdi
	movq	%r14, 104(%rsp)
	.cfi_offset 14, -24
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE225:
	.size	math_prime_util__factor__pp1_pow, .-math_prime_util__factor__pp1_pow
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC14:
	.string	"small prime table"
	.section	.rodata
	.align 8
.LC7:
	.long	1
	.long	17
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__factor__build_primes, @function
math_prime_util__factor__build_primes:
.LFB212:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$2012, %edx
	movq	%rdi, %rbx
	movl	$1, %esi
	subq	$2016, %rsp
	.cfi_def_cfa_offset 2032
	movq	%rsp, %rdi
	call	memset@PLT
	movq	%rbx, %rdi
	movl	$2440, %edx
	xorl	%esi, %esi
	call	memset@PLT
	leaq	2(%rsp), %rdi
	movl	$2, %ecx
	xorl	%r8d, %r8d
	jmp	.L204
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L200:
	addq	$1, %rcx
	addq	$1, %rdi
	cmpq	$2012, %rcx
	je	.L210
.L204:
	cmpb	$0, (%rdi)
	je	.L200
	cmpl	$2147483647, %r8d
	je	.L211
	movl	%ecx, %esi
	leal	1(%r8), %eax
	imull	%ecx, %esi
	movq	%rcx, -8(%rbx,%rax,8)
	movq	%rax, %r8
	cmpl	$2011, %esi
	jg	.L200
	movl	%esi, %eax
	addq	%rsp, %rax
	subl	%eax, %esi
	.p2align 5
	.p2align 4
	.p2align 3
.L203:
	movb	$0, (%rax)
	addq	%rcx, %rax
	leal	(%rsi,%rax), %edx
	cmpl	$2011, %edx
	jle	.L203
	jmp	.L200
.L210:
	cmpl	$305, %r8d
	jne	.L205
	cmpq	$2011, 2432(%rbx)
	jne	.L205
	addq	$2016, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L211:
	.cfi_restore_state
	movl	$170, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L205:
	leaq	.LC14(%rip), %rsi
	leaq	.LC7(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE212:
	.size	math_prime_util__factor__build_primes, .-math_prime_util__factor__build_primes
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T562s, @function
math_prime_util__factor__u64_vectors__T562s:
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
	leaq	.LC12(%rip), %rsi
	leaq	.LC5(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE192:
	.size	math_prime_util__factor__u64_vectors__T562s, .-math_prime_util__factor__u64_vectors__T562s
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T581s, @function
math_prime_util__factor__u64_vectors__T581s:
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
	.size	math_prime_util__factor__u64_vectors__T581s, .-math_prime_util__factor__u64_vectors__T581s
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T576s, @function
math_prime_util__factor__u64_vectors__T576s:
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
	.size	math_prime_util__factor__u64_vectors__T576s, .-math_prime_util__factor__u64_vectors__T576s
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T571s, @function
math_prime_util__factor__u64_vectors__T571s:
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
	.size	math_prime_util__factor__u64_vectors__T571s, .-math_prime_util__factor__u64_vectors__T571s
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T568s, @function
math_prime_util__factor__u64_vectors__T568s:
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
	.size	math_prime_util__factor__u64_vectors__T568s, .-math_prime_util__factor__u64_vectors__T568s
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T565s, @function
math_prime_util__factor__u64_vectors__T565s:
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
	.size	math_prime_util__factor__u64_vectors__T565s, .-math_prime_util__factor__u64_vectors__T565s
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation___assign__3
	.type	math_prime_util__factor__u64_vectors__implementation___assign__3, @function
math_prime_util__factor__u64_vectors__implementation___assign__3:
.LFB131:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L224
	movq	(%rdi), %rax
	movdqu	(%rsi), %xmm0
	movups	%xmm0, (%rdi)
	movq	%rax, (%rdi)
.L224:
	ret
	.cfi_endproc
.LFE131:
	.size	math_prime_util__factor__u64_vectors__implementation___assign__3, .-math_prime_util__factor__u64_vectors__implementation___assign__3
	.align 2
	.p2align 4
	.type	math_prime_util__factor__found, @function
math_prime_util__factor__found:
.LFB206:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, %r8
	cmpq	$1, %rdx
	jbe	.L227
	movq	%rdx, %rcx
	cmpq	%rsi, %rdx
	jnb	.L227
	movq	%rsi, %rax
	xorl	%edx, %edx
	divq	%rcx
	testq	%rdx, %rdx
	jne	.L227
	movq	%rax, 8(%rsp)
	movl	$520, %edx
	xorl	%esi, %esi
	movq	%rcx, (%rsp)
	cmpq	%rax, %rcx
	jnb	.L230
	call	memset@PLT
	movq	(%rsp), %rcx
	movq	8(%rsp), %r9
	movq	%rax, %rdi
	movl	$2, (%rax)
	movq	%rcx, 8(%rax)
	movq	%r9, 16(%rax)
	movq	%rdi, %rax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L227:
	.cfi_restore_state
	movl	$520, %edx
	xorl	%esi, %esi
	movq	%r8, (%rsp)
	call	memset@PLT
	movq	(%rsp), %r8
	movq	%rax, %rdi
	movl	$1, (%rax)
	movq	%r8, 8(%rax)
	movq	%rdi, %rax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L230:
	.cfi_restore_state
	call	memset@PLT
	movq	8(%rsp), %r9
	movq	(%rsp), %rcx
	movq	%rax, %rdi
	movl	$2, (%rax)
	movq	%r9, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	%rdi, %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE206:
	.size	math_prime_util__factor__found, .-math_prime_util__factor__found
	.align 2
	.p2align 4
	.type	math_prime_util__factor__raw_holf, @function
math_prime_util__factor__raw_holf:
.LFB217:
	.cfi_startproc
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	movq	%rdi, 24(%rsp)
	movq	%rsi, %rdi
	movq	%rbx, 40(%rsp)
	.cfi_offset 3, -56
	movq	%rdx, %rbx
	movq	%r14, 72(%rsp)
	.cfi_offset 14, -24
	movq	%rsi, %r14
	call	math_prime_util__int__is_square@PLT
	testb	%al, %al
	jne	.L277
	movq	%r14, %rax
	shrq	$58, %rax
	je	.L278
	testq	%rbx, %rbx
	jne	.L279
.L237:
	movq	24(%rsp), %rbx
	movl	$520, %edx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	memset@PLT
	movl	$1, (%rbx)
	movq	%r14, 8(%rbx)
.L232:
	movq	24(%rsp), %rax
	movq	40(%rsp), %rbx
	movq	72(%rsp), %r14
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L278:
	.cfi_restore_state
	movq	%r14, %rax
	movq	%r13, 64(%rsp)
	.cfi_offset 13, -32
	movl	$720, %r13d
	shrq	$51, %rax
	jne	.L280
.L236:
	testq	%rbx, %rbx
	je	.L274
	imulq	%r14, %r13
	movq	%rbp, 48(%rsp)
	movq	%r12, 56(%rsp)
	movq	%r15, 80(%rsp)
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 15, -16
	movq	%r13, %rbp
	jmp	.L242
	.p2align 4,,10
	.p2align 3
.L238:
	subq	$1, %rbx
	addq	%r13, %rbp
	jc	.L281
	testq	%rbx, %rbx
	je	.L275
.L242:
	movq	%rbp, %rdi
	call	math_prime_util__int__sqrtint@PLT
	leaq	1(%rax), %r15
	movq	%r15, %r12
	imulq	%r15, %r12
	subq	%rbp, %r12
	movq	%r12, %rdi
	call	math_prime_util__int__is_square@PLT
	testb	%al, %al
	je	.L238
	movq	%r12, %rdi
	call	math_prime_util__int__sqrtint@PLT
	cmpq	%r15, %rax
	jnb	.L238
	movq	%r15, %rsi
	movq	%r14, %rdi
	subq	%rax, %rsi
	call	math_prime_util__int__gcd@PLT
	cmpq	$1, %rax
	seta	%cl
	cmpq	%r14, %rax
	setb	%dl
	testb	%dl, %cl
	je	.L238
	.p2align 4
	.p2align 3
.L276:
	movq	%rax, %rdx
.L252:
	movq	24(%rsp), %rdi
	movq	%r14, %rsi
	call	math_prime_util__factor__found
	movq	48(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	movq	56(%rsp), %r12
	.cfi_restore 12
	movq	64(%rsp), %r13
	.cfi_restore 13
	movq	80(%rsp), %r15
	.cfi_restore 15
	jmp	.L232
	.p2align 4,,10
	.p2align 3
.L275:
	.cfi_restore_state
	movq	48(%rsp), %rbp
	.cfi_restore 6
	movq	56(%rsp), %r12
	.cfi_restore 12
	movq	64(%rsp), %r13
	.cfi_restore 13
	movq	80(%rsp), %r15
	.cfi_restore 15
	jmp	.L237
	.p2align 4,,10
	.p2align 3
.L277:
	movq	%r14, %rdi
	call	math_prime_util__int__sqrtint@PLT
	movq	24(%rsp), %rdi
	movq	%r14, %rsi
	movq	%rax, %rdx
	call	math_prime_util__factor__found
	jmp	.L232
	.p2align 4,,10
	.p2align 3
.L280:
	.cfi_offset 13, -32
	movq	%r14, %rax
	movl	$480, %r13d
	shrq	$53, %rax
	je	.L236
	movq	%r14, %rax
	movl	$360, %r13d
	shrq	$54, %rax
	je	.L236
	movabsq	$72057594037927935, %rax
	cmpq	%r14, %rax
	sbbq	%r13, %r13
	andq	$-30, %r13
	addq	$60, %r13
	jmp	.L236
.L281:
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 15, -16
	testq	%rbx, %rbx
	je	.L275
.L243:
	testq	%r14, %r14
	js	.L244
	pxor	%xmm2, %xmm2
	cvtsi2sdq	%r14, %xmm2
	movsd	%xmm2, 8(%rsp)
.L245:
	movq	%r14, %r12
	xorl	%r13d, %r13d
	xorl	%ebp, %ebp
	jmp	.L253
	.p2align 4,,10
	.p2align 3
.L283:
	cvttsd2siq	%xmm0, %r8
.L249:
	leaq	1(%r8), %r15
	movq	%r13, %rcx
	movq	%r15, %rax
	mulq	%r15
	movq	%rax, %rdi
	movq	%rdx, %rsi
	movq	%r12, %rdx
	call	__umodti3@PLT
	movq	%rax, %rdi
	movq	%rax, 16(%rsp)
	call	math_prime_util__int__is_square@PLT
	testb	%al, %al
	jne	.L282
	cmpq	%rbx, %rbp
	je	.L275
.L253:
	addq	$1, %rbp
	js	.L246
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rbp, %xmm0
.L247:
	mulsd	8(%rsp), %xmm0
	call	ada__numerics__long_elementary_functions__sqrt@PLT
	comisd	.LC15(%rip), %xmm0
	jb	.L283
	subsd	.LC15(%rip), %xmm0
	movabsq	$-9223372036854775808, %rax
	cvttsd2siq	%xmm0, %r8
	xorq	%rax, %r8
	jmp	.L249
	.p2align 4,,10
	.p2align 3
.L246:
	movq	%rbp, %rax
	movq	%rbp, %rdx
	pxor	%xmm0, %xmm0
	shrq	%rax
	andl	$1, %edx
	orq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm0, %xmm0
	jmp	.L247
	.p2align 4,,10
	.p2align 3
.L282:
	movq	16(%rsp), %rdi
	call	math_prime_util__int__sqrtint@PLT
	cmpq	%r15, %rax
	jnb	.L251
	movq	%r15, %rdi
	movq	%r14, %rsi
	subq	%rax, %rdi
	call	math_prime_util__int__gcd@PLT
	movq	%rax, %rdx
	jmp	.L252
	.p2align 4,,10
	.p2align 3
.L244:
	movq	%r14, %rax
	movq	%r14, %rdx
	pxor	%xmm0, %xmm0
	shrq	%rax
	andl	$1, %edx
	orq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm0, %xmm0
	movsd	%xmm0, 8(%rsp)
	jmp	.L245
	.p2align 4,,10
	.p2align 3
.L251:
	subq	%r15, %rax
	movq	%r14, %rsi
	movq	%rax, %rdi
	call	math_prime_util__int__gcd@PLT
	jmp	.L276
	.p2align 4,,10
	.p2align 3
.L279:
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 15
	movq	%rbp, 48(%rsp)
	movq	%r12, 56(%rsp)
	movq	%r13, 64(%rsp)
	movq	%r15, 80(%rsp)
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 15, -16
	jmp	.L243
.L274:
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 15
	movq	64(%rsp), %r13
	.cfi_restore 13
	jmp	.L237
	.cfi_endproc
.LFE217:
	.size	math_prime_util__factor__raw_holf, .-math_prime_util__factor__raw_holf
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__length.part.0, @function
math_prime_util__factor__u64_vectors__length.part.0:
.LFB323:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	$2205, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE323:
	.size	math_prime_util__factor__u64_vectors__length.part.0, .-math_prime_util__factor__u64_vectors__length.part.0
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__length
	.type	math_prime_util__factor__u64_vectors__length, @function
math_prime_util__factor__u64_vectors__length:
.LFB76:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$-2147483648, %eax
	je	.L291
	ret
.L291:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__factor__u64_vectors__length.part.0
	.cfi_endproc
.LFE76:
	.size	math_prime_util__factor__u64_vectors__length, .-math_prime_util__factor__u64_vectors__length
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__write
	.type	math_prime_util__factor__u64_vectors__write, @function
math_prime_util__factor__u64_vectors__write:
.LFB115:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	movl	16(%rsi), %esi
	cmpl	$-2147483648, %esi
	je	.L298
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	call	system__stream_attributes__w_u@PLT
	movl	16(%rbp), %eax
	testl	%eax, %eax
	jle	.L292
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	movl	$1, %ebx
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	leaq	1(%rax), %r13
	.p2align 4
	.p2align 3
.L295:
	movq	8(%rbp), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	system__stream_attributes__w_lu@PLT
	cmpq	%rbx, %r13
	jne	.L295
	movq	8(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %r13
	.cfi_restore 13
.L292:
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
.L298:
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	movq	%r12, 24(%rsp)
	movq	%r13, 32(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__factor__u64_vectors__length.part.0
	.cfi_endproc
.LFE115:
	.size	math_prime_util__factor__u64_vectors__write, .-math_prime_util__factor__u64_vectors__write
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__reverse_elements
	.type	math_prime_util__factor__u64_vectors__reverse_elements, @function
math_prime_util__factor__u64_vectors__reverse_elements:
.LFB100:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	$-2147483648, %eax
	je	.L307
	cmpl	$1, %eax
	jle	.L299
	movq	8(%rdi), %rcx
	movl	$1, %edx
	.p2align 5
	.p2align 4
	.p2align 3
.L302:
	movq	(%rcx,%rdx,8), %rsi
	movq	(%rcx,%rax,8), %rdi
	movq	%rdi, (%rcx,%rdx,8)
	addq	$1, %rdx
	movq	%rsi, (%rcx,%rax,8)
	subq	$1, %rax
	cmpl	%eax, %edx
	jl	.L302
.L299:
	ret
.L307:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__factor__u64_vectors__length.part.0
	.cfi_endproc
.LFE100:
	.size	math_prime_util__factor__u64_vectors__reverse_elements, .-math_prime_util__factor__u64_vectors__reverse_elements
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__Oeq__2
	.type	math_prime_util__factor__u64_vectors__Oeq__2, @function
math_prime_util__factor__u64_vectors__Oeq__2:
.LFB23:
	.cfi_startproc
	movl	16(%rdi), %eax
	cmpl	16(%rsi), %eax
	jne	.L313
	cmpl	$-2147483648, %eax
	je	.L320
	testl	%eax, %eax
	jg	.L312
.L315:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L312:
	movl	%eax, %edx
	movq	8(%rdi), %rdi
	movq	8(%rsi), %rcx
	movl	$1, %eax
	jmp	.L314
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L321:
	cmpq	%rax, %rdx
	je	.L315
	addq	$1, %rax
.L314:
	movq	(%rcx,%rax,8), %rsi
	cmpq	%rsi, (%rdi,%rax,8)
	je	.L321
.L313:
	xorl	%eax, %eax
	ret
.L320:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__factor__u64_vectors__length.part.0
	.cfi_endproc
.LFE23:
	.size	math_prime_util__factor__u64_vectors__Oeq__2, .-math_prime_util__factor__u64_vectors__Oeq__2
	.section	.text.unlikely,"ax",@progbits
	.align 2
.LCOLDB16:
	.text
.LHOTB16:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert__4
	.type	math_prime_util__factor__u64_vectors__insert__4, @function
math_prime_util__factor__u64_vectors__insert__4:
.LFB56:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA56
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movl	16(%rdi), %eax
	cmpl	$-2147483648, %eax
	je	.L417
	testl	%ecx, %ecx
	je	.L322
	movq	%rbx, 40(%rsp)
	.cfi_offset 3, -40
	movl	%eax, %ebx
	addl	%ecx, %ebx
	movq	%rbp, 48(%rsp)
	movq	%r12, 56(%rsp)
	movq	%r13, 64(%rsp)
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	jo	.L326
	movq	8(%rdi), %rbp
	movq	%rdi, %r12
	movq	%rdx, %r13
	testq	%rbp, %rbp
	je	.L418
	movl	0(%rbp), %edx
	movl	%esi, %r8d
	xorl	%esi, %esi
	testl	%edx, %edx
	cmovns	%edx, %esi
	cmpl	%ebx, %esi
	jge	.L419
	testl	%edx, %edx
	movl	$1, %eax
	cmovle	%eax, %edx
	cmpl	%edx, %ebx
	jg	.L343
	jmp	.L340
	.p2align 4,,10
	.p2align 3
.L422:
	cmpl	$-1073741824, %edx
	js	.L420
	addl	%edx, %edx
	cmpl	%edx, %ebx
	jle	.L421
.L343:
	cmpl	$1073741823, %edx
	jle	.L422
	movabsq	$17179869184, %rdi
	movl	$2147483647, %edx
.L341:
	movl	%ecx, 24(%rsp)
	movl	%r8d, 20(%rsp)
	movl	%edx, 8(%rsp)
.LEHB0:
	call	__gnat_malloc@PLT
	movl	20(%rsp), %r8d
	movl	8(%rsp), %edx
	movq	8(%r12), %r9
	movl	16(%r12), %r10d
	movq	%rax, %rbp
	cmpl	$1, %r8d
	movl	%edx, (%rax)
	movl	24(%rsp), %ecx
	jle	.L423
	leal	-1(%r8), %edx
	leaq	8(%r9), %rsi
	movl	%ecx, 28(%rsp)
	salq	$3, %rdx
	leaq	8(%rax), %rdi
	movl	%r8d, 20(%rsp)
	movq	%r9, 8(%rsp)
	movl	%r10d, 24(%rsp)
	call	memmove@PLT
	movl	20(%rsp), %r8d
	cmpl	24(%rsp), %r8d
	movq	8(%rsp), %r9
	movl	28(%rsp), %ecx
	movq	%rax, %rdi
	jle	.L347
	cmpl	%r8d, %ebx
	jge	.L348
.L349:
	movq	%rbp, 8(%r12)
	movq	64(%rsp), %r13
	.cfi_remember_state
	.cfi_restore 13
	movq	%r9, %rdi
	movl	%ebx, 16(%r12)
	movq	48(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	56(%rsp), %r12
	.cfi_restore 12
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L418:
	.cfi_restore_state
	movslq	%ebx, %rbp
	leaq	8(,%rbp,8), %rdi
	call	__gnat_malloc@PLT
	movl	%ebx, (%rax)
	movq	%rax, %rdx
	testl	%ebx, %ebx
	jg	.L424
.L329:
	movq	%rdx, 8(%r12)
.L333:
	movq	48(%rsp), %rbp
	.cfi_restore 6
	movq	64(%rsp), %r13
	.cfi_restore 13
	movl	%ebx, 16(%r12)
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	56(%rsp), %r12
	.cfi_restore 12
.L322:
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L419:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	cmpl	%r8d, %eax
	jl	.L425
	addl	%r8d, %ecx
	jo	.L336
	cmpl	%ecx, %ebx
	jl	.L338
	movslq	%ecx, %rax
	movslq	%ebx, %rdx
	movslq	%r8d, %rsi
	movl	%ecx, 20(%rsp)
	subq	%rax, %rdx
	leaq	0(%rbp,%rsi,8), %rsi
	leaq	0(%rbp,%rax,8), %rdi
	movl	%r8d, 8(%rsp)
	leaq	8(,%rdx,8), %rdx
	call	memmove@PLT
	movl	20(%rsp), %ecx
	movl	8(%rsp), %r8d
	cmpl	$-2147483648, %ecx
	je	.L426
.L338:
	leal	-1(%rcx), %eax
	cmpl	%eax, %r8d
	jg	.L333
	subl	%r8d, %ecx
	movslq	%r8d, %rsi
	leal	-1(%rcx), %edx
	leaq	0(%rbp,%rsi,8), %rax
	addq	%rsi, %rdx
	leaq	8(%rbp,%rdx,8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$8, %ecx
	je	.L339
	movq	%r13, (%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L333
	.p2align 5
	.p2align 4
	.p2align 3
.L339:
	movq	%r13, (%rax)
	addq	$16, %rax
	movq	%r13, -8(%rax)
	cmpq	%rdx, %rax
	je	.L333
	movq	%r13, (%rax)
	addq	$16, %rax
	movq	%r13, -8(%rax)
	cmpq	%rdx, %rax
	jne	.L339
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L425:
	cmpl	%r8d, %ebx
	jl	.L333
	movl	%ebx, %edx
	movslq	%r8d, %rcx
	subl	%r8d, %edx
	leaq	0(%rbp,%rcx,8), %rax
	addq	%rcx, %rdx
	leaq	8(%rbp,%rdx,8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$8, %ecx
	je	.L334
	movq	%r13, (%rax)
	addq	$8, %rax
	cmpq	%rax, %rdx
	je	.L333
	.p2align 5
	.p2align 4
	.p2align 3
.L334:
	movq	%r13, (%rax)
	addq	$16, %rax
	movq	%r13, -8(%rax)
	cmpq	%rax, %rdx
	je	.L333
	movq	%r13, (%rax)
	addq	$16, %rax
	movq	%r13, -8(%rax)
	cmpq	%rax, %rdx
	jne	.L334
	jmp	.L333
	.p2align 4,,10
	.p2align 3
.L421:
	leal	1(%rdx), %edi
	movslq	%edi, %rdi
	salq	$3, %rdi
	jmp	.L341
	.p2align 4,,10
	.p2align 3
.L423:
	cmpl	%r10d, %r8d
	jg	.L348
	movl	%ecx, %eax
	addl	%r8d, %eax
	jo	.L352
	movl	%eax, %ecx
	cmpl	$-2147483648, %eax
	je	.L353
	leal	-1(%rax), %edx
	leaq	8(%rbp), %rdi
	cmpl	%edx, %r8d
	jle	.L354
	cltq
	movslq	%r8d, %rdx
.L355:
	movl	%ebx, %ecx
	subq	%rax, %rcx
	leaq	8(,%rcx,8), %rsi
	jmp	.L362
	.p2align 4,,10
	.p2align 3
.L347:
	addl	%r8d, %ecx
	jo	.L352
	cmpl	$-2147483648, %ecx
	je	.L353
	leal	-1(%rcx), %eax
	movslq	%r8d, %rdx
	cmpl	%eax, %r8d
	jg	.L360
.L354:
	movl	%ecx, %esi
	movslq	%r8d, %rdx
	subl	%r8d, %esi
	leaq	0(%rbp,%rdx,8), %rax
	subl	$1, %esi
	addq	%rdx, %rsi
	leaq	(%rdi,%rsi,8), %rsi
	movq	%rsi, %rdi
	subq	%rax, %rdi
	andl	$8, %edi
	je	.L361
	movq	%r13, (%rax)
	addq	$8, %rax
	cmpq	%rsi, %rax
	je	.L360
	.p2align 4
	.p2align 4
	.p2align 3
.L361:
	movq	%r13, (%rax)
	addq	$16, %rax
	movq	%r13, -8(%rax)
	cmpq	%rsi, %rax
	jne	.L361
.L360:
	movslq	%ecx, %rax
	xorl	%esi, %esi
	cmpl	%ecx, %ebx
	jge	.L355
.L362:
	leaq	(%r9,%rdx,8), %rcx
	leaq	0(%rbp,%rax,8), %rdi
	movq	%rsi, %rdx
	movq	%r9, 8(%rsp)
	movq	%rcx, %rsi
	call	memmove@PLT
	movq	8(%rsp), %r9
	jmp	.L349
	.p2align 4,,10
	.p2align 3
.L348:
	movl	%ebx, %ecx
	movslq	%r8d, %rdx
	subl	%r8d, %ecx
	leaq	0(%rbp,%rdx,8), %rax
	leaq	1(%rdx,%rcx), %rdx
	leaq	0(%rbp,%rdx,8), %rdx
	movq	%rdx, %rcx
	subq	%rax, %rcx
	andl	$8, %ecx
	je	.L346
	movq	%r13, (%rax)
	addq	$8, %rax
	cmpq	%rdx, %rax
	je	.L349
	.p2align 5
	.p2align 4
	.p2align 3
.L346:
	movq	%r13, (%rax)
	addq	$16, %rax
	movq	%r13, -8(%rax)
	cmpq	%rdx, %rax
	je	.L349
	movq	%r13, (%rax)
	addq	$16, %rax
	movq	%r13, -8(%rax)
	cmpq	%rdx, %rax
	jne	.L346
	jmp	.L349
.L424:
	leaq	(%rax,%rbp,8), %rcx
	andl	$1, %ebp
	je	.L330
	movq	%r13, 8(%rax)
	leaq	8(%rax), %rax
	cmpq	%rcx, %rax
	je	.L329
	.p2align 4
	.p2align 4
	.p2align 3
.L330:
	movq	%r13, 8(%rax)
	addq	$16, %rax
	movq	%r13, (%rax)
	cmpq	%rcx, %rax
	jne	.L330
	jmp	.L329
.L340:
	movl	%edx, %eax
	leaq	8(,%rax,8), %rdi
	jmp	.L341
.L420:
	movl	$1235, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L417:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	movq	%rbx, 40(%rsp)
	movq	%rbp, 48(%rsp)
	movq	%r12, 56(%rsp)
	movq	%r13, 64(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__factor__u64_vectors__length.part.0
.L326:
	movl	$1037, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L426:
	movl	$1212, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L336:
	movl	$1206, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE0:
.L353:
	movl	$1291, %esi
	leaq	.LC8(%rip), %rdi
.LEHB1:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L352:
	movl	$1286, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE1:
.L368:
	movq	%rax, %rbx
	jmp	.L363
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
	.uleb128 .L368-.LFB56
	.uleb128 0x1
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
	.type	math_prime_util__factor__u64_vectors__insert__4.cold, @function
math_prime_util__factor__u64_vectors__insert__4.cold:
.LFSB56:
.L363:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L413
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rdi
	movq	%rax, %r12
.LEHB2:
	call	__gnat_free@PLT
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE2:
.L369:
	movq	%rax, %rbp
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r12, %rsi
.LEHB3:
	call	__gnat_end_handler_v1@PLT
	movq	%rbp, %rdi
.L413:
	call	_Unwind_Resume@PLT
.LEHE3:
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
	.uleb128 .LEHB2-.LCOLDB16
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L369-.LCOLDB16
	.uleb128 0
	.uleb128 .LEHB3-.LCOLDB16
	.uleb128 .LEHE3-.LEHB3
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
	.size	math_prime_util__factor__u64_vectors__insert__4, .-math_prime_util__factor__u64_vectors__insert__4
	.section	.text.unlikely
	.size	math_prime_util__factor__u64_vectors__insert__4.cold, .-math_prime_util__factor__u64_vectors__insert__4.cold
.LCOLDE16:
	.text
.LHOTE16:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert__6
	.type	math_prime_util__factor__u64_vectors__insert__6, @function
math_prime_util__factor__u64_vectors__insert__6:
.LFB61:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rcx, %r10
	movq	%rsi, %rax
	movl	%edx, %esi
	movl	48(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L428
	testq	%rax, %rax
	je	.L433
	cmpl	%edx, 16(%rdi)
	movl	$1, %eax
	cmovl	%rax, %rsi
	movl	$0, %eax
	cmovl	%rax, %rdi
.L429:
	movl	%r9d, %eax
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movq	%rax, %rdx
	movq	%rdi, %rax
	movabsq	$-4294967296, %rdi
	movq	%rdx, %rcx
	andq	%rdi, %rcx
	orq	%rsi, %rcx
	movq	%rcx, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L428:
	.cfi_restore_state
	movl	16(%rdi), %r11d
	testq	%rax, %rax
	je	.L430
	cmpl	%r11d, %edx
	jle	.L432
.L431:
	leal	1(%r11), %esi
.L432:
	movq	%r10, %rdx
	movq	%r9, 24(%rsp)
	movl	%esi, 12(%rsp)
	movq	%rdi, (%rsp)
	movq	%r8, 16(%rsp)
	call	math_prime_util__factor__u64_vectors__insert__4
	movq	(%rsp), %rdi
	movl	12(%rsp), %esi
	movq	24(%rsp), %r9
	jmp	.L429
	.p2align 4,,10
	.p2align 3
.L430:
	cmpl	$2147483647, %r11d
	jne	.L431
	movl	$1585, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L433:
	movl	$1, %esi
	xorl	%edi, %edi
	jmp	.L429
	.cfi_endproc
.LFE61:
	.size	math_prime_util__factor__u64_vectors__insert__6, .-math_prime_util__factor__u64_vectors__insert__6
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert__7
	.type	math_prime_util__factor__u64_vectors__insert__7, @function
math_prime_util__factor__u64_vectors__insert__7:
.LFB62:
	.cfi_startproc
	movl	%edx, %ecx
	xorl	%edx, %edx
	jmp	math_prime_util__factor__u64_vectors__insert__4
	.cfi_endproc
.LFE62:
	.size	math_prime_util__factor__u64_vectors__insert__7, .-math_prime_util__factor__u64_vectors__insert__7
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__prepend__2
	.type	math_prime_util__factor__u64_vectors__prepend__2, @function
math_prime_util__factor__u64_vectors__prepend__2:
.LFB81:
	.cfi_startproc
	movl	%edx, %ecx
	movq	%rsi, %rdx
	movl	$1, %esi
	jmp	math_prime_util__factor__u64_vectors__insert__4
	.cfi_endproc
.LFE81:
	.size	math_prime_util__factor__u64_vectors__prepend__2, .-math_prime_util__factor__u64_vectors__prepend__2
	.section	.text.unlikely
	.align 2
.LCOLDB17:
	.text
.LHOTB17:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert_space
	.type	math_prime_util__factor__u64_vectors__insert_space, @function
math_prime_util__factor__u64_vectors__insert_space:
.LFB64:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA64
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movl	16(%rdi), %eax
	cmpl	$-2147483648, %eax
	je	.L477
	movl	%edx, %ecx
	testl	%edx, %edx
	je	.L438
	movq	%rbx, 16(%rsp)
	.cfi_offset 3, -48
	movl	%eax, %ebx
	addl	%edx, %ebx
	movq	%rbp, 24(%rsp)
	movq	%r13, 40(%rsp)
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	jo	.L442
	movslq	%esi, %rbp
	movq	8(%rdi), %rsi
	movq	%rdi, %r13
	testq	%rsi, %rsi
	je	.L478
	movl	(%rsi), %edx
	cmpl	%ebx, %edx
	jge	.L479
	testl	%edx, %edx
	movl	$1, %eax
	movq	%r12, 32(%rsp)
	cmovle	%eax, %edx
	movq	%r14, 48(%rsp)
	cmpl	%edx, %ebx
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	jg	.L454
	jmp	.L451
	.p2align 4,,10
	.p2align 3
.L482:
	cmpl	$-1073741824, %edx
	js	.L480
	addl	%edx, %edx
	cmpl	%edx, %ebx
	jle	.L481
.L454:
	cmpl	$1073741823, %edx
	jle	.L482
	movabsq	$17179869184, %rdi
	movl	$2147483647, %edx
.L452:
	movl	%edx, 8(%rsp)
	movl	%ecx, 12(%rsp)
.LEHB4:
	call	__gnat_malloc@PLT
	movl	8(%rsp), %edx
	xorl	%r8d, %r8d
	movq	8(%r13), %r14
	leaq	8(%rax), %rdi
	movq	%rax, %r12
	movl	%edx, (%rax)
	leal	-1(%rbp), %edx
	leaq	8(%r14), %rsi
	salq	$3, %rdx
	cmpl	$1, %ebp
	cmovle	%r8, %rdx
	call	memmove@PLT
	cmpl	%ebp, 16(%r13)
	jl	.L456
	movl	12(%rsp), %ecx
	addl	%ebp, %ecx
	jo	.L458
	movslq	%ecx, %rsi
	movslq	%ebx, %rax
	xorl	%r8d, %r8d
	subq	%rsi, %rax
	cmpl	%ecx, %ebx
	leaq	(%r12,%rsi,8), %rdi
	leaq	8(,%rax,8), %rdx
	leaq	(%r14,%rbp,8), %rsi
	cmovl	%r8, %rdx
	call	memmove@PLT
.L456:
	movq	%r12, 8(%r13)
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	%r14, %rdi
	movq	32(%rsp), %r12
	.cfi_restore 12
	movq	48(%rsp), %r14
	.cfi_restore 14
	movl	%ebx, 16(%r13)
	movq	16(%rsp), %rbx
	.cfi_restore 3
	movq	40(%rsp), %r13
	.cfi_restore 13
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L479:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 13, -24
	cmpl	%ebp, %eax
	jl	.L446
	addl	%ebp, %ecx
	jo	.L448
	movslq	%ecx, %rdi
	movslq	%ebx, %rax
	xorl	%edx, %edx
	subq	%rdi, %rax
	cmpl	%ecx, %ebx
	leaq	(%rsi,%rdi,8), %rdi
	leaq	8(,%rax,8), %rax
	leaq	(%rsi,%rbp,8), %rsi
	cmovge	%rax, %rdx
	call	memmove@PLT
.L446:
	movl	%ebx, 16(%r13)
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	16(%rsp), %rbx
	.cfi_restore 3
	movq	40(%rsp), %r13
	.cfi_restore 13
.L438:
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L481:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	leal	1(%rdx), %edi
	movslq	%edi, %rdi
	salq	$3, %rdi
	jmp	.L452
	.p2align 4,,10
	.p2align 3
.L478:
	.cfi_restore 12
	.cfi_restore 14
	movslq	%ebx, %rax
	leaq	8(,%rax,8), %rdi
	call	__gnat_malloc@PLT
	movl	%ebx, 16(%r13)
	movl	%ebx, (%rax)
	movq	16(%rsp), %rbx
	.cfi_restore 3
	movq	%rax, 8(%r13)
	movq	24(%rsp), %rbp
	.cfi_restore 6
	movq	40(%rsp), %r13
	.cfi_restore 13
	jmp	.L438
.L451:
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	leal	1(%rdx), %edi
	salq	$3, %rdi
	jmp	.L452
.L480:
	movl	$1891, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L477:
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
	call	math_prime_util__factor__u64_vectors__length.part.0
.L442:
	.cfi_restore 12
	.cfi_restore 14
	movl	$1700, %esi
	leaq	.LC8(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE4:
.L458:
	movl	$1939, %esi
	leaq	.LC8(%rip), %rdi
.LEHB5:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE5:
.L448:
	.cfi_restore 12
	.cfi_restore 14
	movl	$1861, %esi
	leaq	.LC8(%rip), %rdi
	movq	%r12, 32(%rsp)
	movq	%r14, 48(%rsp)
	.cfi_offset 12, -32
	.cfi_offset 14, -16
.LEHB6:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE6:
.L468:
	movq	%rax, %rbx
	jmp	.L461
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
	.uleb128 .LEHB4-.LFB64
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB5-.LFB64
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L468-.LFB64
	.uleb128 0x1
	.uleb128 .LEHB6-.LFB64
	.uleb128 .LEHE6-.LEHB6
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
	.type	math_prime_util__factor__u64_vectors__insert_space.cold, @function
math_prime_util__factor__u64_vectors__insert_space.cold:
.LFSB64:
.L461:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -32
	.cfi_offset 13, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L476
	call	__gnat_begin_handler_v1@PLT
	movq	%r12, %rdi
	movq	%rax, %r13
.LEHB7:
	call	__gnat_free@PLT
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE7:
.L469:
	movq	%rax, %rbp
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r13, %rsi
.LEHB8:
	call	__gnat_end_handler_v1@PLT
	movq	%rbp, %rdi
.L476:
	call	_Unwind_Resume@PLT
.LEHE8:
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
	.uleb128 .LEHB7-.LCOLDB17
	.uleb128 .LEHE7-.LEHB7
	.uleb128 .L469-.LCOLDB17
	.uleb128 0
	.uleb128 .LEHB8-.LCOLDB17
	.uleb128 .LEHE8-.LEHB8
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
	.size	math_prime_util__factor__u64_vectors__insert_space, .-math_prime_util__factor__u64_vectors__insert_space
	.section	.text.unlikely
	.size	math_prime_util__factor__u64_vectors__insert_space.cold, .-math_prime_util__factor__u64_vectors__insert_space.cold
.LCOLDE17:
	.text
.LHOTE17:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert_space__2
	.type	math_prime_util__factor__u64_vectors__insert_space__2, @function
math_prime_util__factor__u64_vectors__insert_space__2:
.LFB65:
	.cfi_startproc
	movq	%rcx, %r10
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rdi, %rax
	movl	%edx, %ecx
	testl	%r9d, %r9d
	jne	.L484
	testq	%rsi, %rsi
	je	.L489
	cmpl	%edx, 16(%rdi)
	movl	$1, %edx
	cmovl	%rdx, %rcx
	movl	$0, %edx
	cmovl	%rdx, %rax
.L485:
	movl	%r8d, %r8d
	movq	%rax, %r10
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movabsq	$-4294967296, %rdx
	movq	%r8, %rax
	andq	%rdx, %rax
	orq	%rcx, %rax
	movq	%rax, %r11
	movq	%r10, %rax
	movq	%r11, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L484:
	.cfi_restore_state
	movl	16(%rdi), %edi
	movq	%r8, %r11
	testq	%rsi, %rsi
	je	.L486
	cmpl	%edi, %edx
	jle	.L488
.L487:
	leal	1(%rdi), %ecx
.L488:
	movl	%ecx, %esi
	movq	%rax, %rdi
	movl	%r9d, %edx
	movq	%r8, 40(%rsp)
	movl	%ecx, 36(%rsp)
	movq	%rax, 8(%rsp)
	movq	%r10, 16(%rsp)
	movq	%r11, 24(%rsp)
	call	math_prime_util__factor__u64_vectors__insert_space
	movq	8(%rsp), %rax
	movl	36(%rsp), %ecx
	movq	40(%rsp), %r8
	jmp	.L485
	.p2align 4,,10
	.p2align 3
.L486:
	cmpl	$2147483647, %edi
	jne	.L487
	movl	$2006, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L489:
	movl	$1, %ecx
	xorl	%eax, %eax
	jmp	.L485
	.cfi_endproc
.LFE65:
	.size	math_prime_util__factor__u64_vectors__insert_space__2, .-math_prime_util__factor__u64_vectors__insert_space__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert_vector
	.type	math_prime_util__factor__u64_vectors__insert_vector, @function
math_prime_util__factor__u64_vectors__insert_vector:
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
	cmpl	$-2147483648, %ebx
	je	.L520
	movq	%rdx, %r13
	movl	%ebx, %edx
	movq	%rdi, %r12
	movl	%esi, %ebp
	call	math_prime_util__factor__u64_vectors__insert_space
	testl	%ebx, %ebx
	je	.L492
	leal	-1(%rbp), %eax
	movl	%eax, %ecx
	addl	%ebx, %ecx
	jo	.L496
	movq	8(%r12), %rdx
	cmpq	%r13, %r12
	jne	.L521
	xorl	%r13d, %r13d
	testl	%eax, %eax
	cmovns	%eax, %r13d
	xorl	%r8d, %r8d
	addl	%r13d, %eax
	seto	%r8b
	jo	.L522
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
	leaq	(%rdx,%r9,8), %rdi
	movq	%rsi, %rdx
	movq	%rax, %rsi
	call	memmove@PLT
	cmpl	%ebx, %r13d
	je	.L492
	movl	12(%rsp), %ecx
	movl	8(%rsp), %r8d
	cmpl	$2147483647, %ecx
	je	.L523
	movl	16(%r12), %esi
	leal	1(%rcx), %eax
	cmpl	%esi, %eax
	jg	.L505
	movslq	%eax, %rdi
	movslq	%esi, %rdx
	subq	%rdi, %rdx
	movl	$2147483649, %edi
	addq	%rdi, %rdx
	shrq	$32, %rdx
	jne	.L509
	addl	$1, %esi
	subl	%eax, %esi
	movl	%esi, %r8d
.L505:
	movl	%eax, %r9d
	subl	%r8d, %r9d
	jo	.L509
	cltq
	movslq	%r9d, %rdi
	movq	8(%r12), %rsi
	movq	%rax, %rdx
	subq	%rdi, %rdx
	leaq	(%rsi,%rdi,8), %rdi
	leaq	(%rsi,%rax,8), %rsi
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
.L521:
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
	leaq	(%rdx,%r8,8), %rdi
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
.L492:
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
.L520:
	.cfi_restore_state
	call	math_prime_util__factor__u64_vectors__length.part.0
.L496:
	movl	$1349, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L509:
	movl	$1435, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L523:
	movl	$1418, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L522:
	movl	$1392, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE57:
	.size	math_prime_util__factor__u64_vectors__insert_vector, .-math_prime_util__factor__u64_vectors__insert_vector
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert_vector__3
	.type	math_prime_util__factor__u64_vectors__insert_vector__3, @function
math_prime_util__factor__u64_vectors__insert_vector__3:
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
	jle	.L533
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L527
	cmpl	%eax, %edx
	jle	.L529
.L528:
	leal	1(%rax), %ebx
.L529:
	movq	%rcx, %rdx
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r9, 8(%rsp)
	movq	%r8, (%rsp)
	call	math_prime_util__factor__u64_vectors__insert_vector
	movq	8(%rsp), %r9
.L526:
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
.L533:
	.cfi_restore_state
	testq	%rsi, %rsi
	je	.L530
	cmpl	16(%rdi), %edx
	movl	$1, %eax
	cmovg	%rax, %rbx
	movl	$0, %eax
	cmovg	%rax, %rbp
	jmp	.L526
	.p2align 4,,10
	.p2align 3
.L527:
	cmpl	$2147483647, %eax
	jne	.L528
	movl	$1508, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L530:
	movl	$1, %ebx
	xorl	%ebp, %ebp
	jmp	.L526
	.cfi_endproc
.LFE59:
	.size	math_prime_util__factor__u64_vectors__insert_vector__3, .-math_prime_util__factor__u64_vectors__insert_vector__3
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__prepend_vector
	.type	math_prime_util__factor__u64_vectors__prepend_vector, @function
math_prime_util__factor__u64_vectors__prepend_vector:
.LFB82:
	.cfi_startproc
	movq	%rsi, %rdx
	movl	$1, %esi
	jmp	math_prime_util__factor__u64_vectors__insert_vector
	.cfi_endproc
.LFE82:
	.size	math_prime_util__factor__u64_vectors__prepend_vector, .-math_prime_util__factor__u64_vectors__prepend_vector
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__reserve_capacity
	.type	math_prime_util__factor__u64_vectors__reserve_capacity, @function
math_prime_util__factor__u64_vectors__reserve_capacity:
.LFB99:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	movl	16(%rdi), %ecx
	cmpl	$-2147483648, %ecx
	je	.L547
	movq	8(%rdi), %r8
	movq	%rdi, %rbx
	testl	%esi, %esi
	je	.L548
	testq	%r8, %r8
	je	.L549
	movl	(%r8), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	cmpl	%ecx, %esi
	jle	.L550
	cmpl	%eax, %esi
	je	.L535
	movslq	%esi, %rax
	movl	%esi, (%rsp)
	leaq	8(,%rax,8), %rdi
	call	__gnat_malloc@PLT
	movl	(%rsp), %esi
	xorl	%edx, %edx
	movq	8(%rbx), %r8
	movq	%rax, %rcx
	movl	%esi, (%rax)
	movl	16(%rbx), %eax
	leaq	8(%rcx), %rdi
	leaq	8(%r8), %rsi
	movq	%rcx, (%rsp)
	testl	%eax, %eax
	movq	%r8, 8(%rsp)
	cmovns	%eax, %edx
	salq	$3, %rdx
	call	memmove@PLT
	movq	(%rsp), %rcx
	movq	8(%rsp), %rdi
	movq	%rcx, 8(%rbx)
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L550:
	.cfi_restore_state
	cmpl	%eax, %ecx
	jl	.L546
.L535:
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L548:
	.cfi_restore_state
	testl	%ecx, %ecx
	jne	.L538
	movq	$0, 8(%rdi)
	testq	%r8, %r8
	je	.L535
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	movq	%r8, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L538:
	.cfi_restore_state
	movl	(%r8), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	cmpl	%ecx, %eax
	jle	.L535
.L546:
	movslq	%ecx, %rdx
	movq	%r8, 24(%rsp)
	salq	$3, %rdx
	movl	%ecx, (%rsp)
	leaq	8(%rdx), %rdi
	movq	%rdx, 16(%rsp)
	call	__gnat_malloc@PLT
	movl	(%rsp), %ecx
	leaq	8(%rax), %rdi
	movl	%ecx, (%rax)
	movq	24(%rsp), %r8
	movq	16(%rsp), %rdx
	movq	%rax, 8(%rsp)
	leaq	8(%r8), %rsi
	movq	%r8, (%rsp)
	call	memcpy@PLT
	movq	8(%rsp), %r9
	movq	(%rsp), %rdi
	movq	%r9, 8(%rbx)
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L549:
	.cfi_restore_state
	movslq	%esi, %rax
	movl	%esi, (%rsp)
	leaq	8(,%rax,8), %rdi
	call	__gnat_malloc@PLT
	movl	(%rsp), %esi
	movq	%rax, 8(%rbx)
	movl	%esi, (%rax)
	jmp	.L535
.L547:
	call	math_prime_util__factor__u64_vectors__length.part.0
	.cfi_endproc
.LFE99:
	.size	math_prime_util__factor__u64_vectors__reserve_capacity, .-math_prime_util__factor__u64_vectors__reserve_capacity
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__read
	.type	math_prime_util__factor__u64_vectors__read, @function
math_prime_util__factor__u64_vectors__read:
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
	movl	$0, 16(%rsi)
	call	system__stream_attributes__i_u@PLT
	movq	8(%rbp), %r12
	movl	%eax, %ebx
	testq	%r12, %r12
	je	.L561
	movl	(%r12), %eax
	xorl	%edx, %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	cmpl	%eax, %ebx
	jg	.L560
	testl	%ebx, %ebx
	jle	.L551
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
.L556:
	leal	-1(%rbx), %r14d
	movl	$1, %ebx
	addq	$2, %r14
	jmp	.L557
	.p2align 4,,10
	.p2align 3
.L562:
	movq	8(%rbp), %r12
.L557:
	movq	%r13, %rdi
	call	system__stream_attributes__i_lu@PLT
	movq	%rax, (%r12,%rbx,8)
	movl	%ebx, 16(%rbp)
	addq	$1, %rbx
	cmpq	%r14, %rbx
	jne	.L562
	movq	32(%rsp), %r14
	.cfi_restore 14
.L551:
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
.L561:
	.cfi_restore_state
	testl	%eax, %eax
	jle	.L551
.L560:
	movl	%ebx, %esi
	movq	%rbp, %rdi
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	call	math_prime_util__factor__u64_vectors__reserve_capacity
	movq	8(%rbp), %r12
	jmp	.L556
	.cfi_endproc
.LFE91:
	.size	math_prime_util__factor__u64_vectors__read, .-math_prime_util__factor__u64_vectors__read
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__vectorSR__2
	.type	math_prime_util__factor__u64_vectors__vectorSR__2, @function
math_prime_util__factor__u64_vectors__vectorSR__2:
.LFB169:
	.cfi_startproc
	movl	$3, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__factor__u64_vectors__read
	.cfi_endproc
.LFE169:
	.size	math_prime_util__factor__u64_vectors__vectorSR__2, .-math_prime_util__factor__u64_vectors__vectorSR__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__delete_first
	.type	math_prime_util__factor__u64_vectors__delete_first, @function
math_prime_util__factor__u64_vectors__delete_first:
.LFB39:
	.cfi_startproc
	testl	%esi, %esi
	je	.L564
	movl	16(%rdi), %eax
	cmpl	$-2147483648, %eax
	je	.L574
	cmpl	%eax, %esi
	jl	.L567
	movl	$0, 16(%rdi)
	ret
	.p2align 4,,10
	.p2align 3
.L564:
	ret
	.p2align 4,,10
	.p2align 3
.L567:
	movl	%esi, %edx
	movl	$1, %esi
	jmp	math_prime_util__factor__u64_vectors__delete
.L574:
	pushq	%rax
	.cfi_def_cfa_offset 16
	call	math_prime_util__factor__u64_vectors__length.part.0
	.cfi_endproc
.LFE39:
	.size	math_prime_util__factor__u64_vectors__delete_first, .-math_prime_util__factor__u64_vectors__delete_first
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__append__3
	.type	math_prime_util__factor__u64_vectors__append__3, @function
math_prime_util__factor__u64_vectors__append__3:
.LFB27:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	8(%rdi), %rax
	movq	%rsi, %rdx
	movl	16(%rdi), %esi
	testq	%rax, %rax
	je	.L576
	cmpl	%esi, (%rax)
	je	.L576
	cmpl	$2147483647, %esi
	je	.L585
	addl	$1, %esi
	movslq	%esi, %rcx
	movq	%rdx, (%rax,%rcx,8)
	movl	%esi, 16(%rdi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L576:
	.cfi_restore_state
	cmpl	$2147483647, %esi
	je	.L586
	addl	$1, %esi
	movl	$1, %ecx
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__factor__u64_vectors__insert__4
.L585:
	.cfi_restore_state
	movl	$223, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L586:
	movl	$229, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE27:
	.size	math_prime_util__factor__u64_vectors__append__3, .-math_prime_util__factor__u64_vectors__append__3
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert__5
	.type	math_prime_util__factor__u64_vectors__insert__5, @function
math_prime_util__factor__u64_vectors__insert__5:
.LFB60:
	.cfi_startproc
	testl	%r8d, %r8d
	je	.L587
	movl	16(%rdi), %eax
	movq	%rcx, %r9
	testq	%rsi, %rsi
	je	.L589
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L591
.L590:
	leal	1(%rax), %esi
.L591:
	movl	%r8d, %ecx
	movq	%r9, %rdx
	jmp	math_prime_util__factor__u64_vectors__insert__4
	.p2align 4,,10
	.p2align 3
.L587:
	ret
	.p2align 4,,10
	.p2align 3
.L589:
	cmpl	$2147483647, %eax
	jne	.L590
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1543, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE60:
	.size	math_prime_util__factor__u64_vectors__insert__5, .-math_prime_util__factor__u64_vectors__insert__5
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__append_vector
	.type	math_prime_util__factor__u64_vectors__append_vector, @function
math_prime_util__factor__u64_vectors__append_vector:
.LFB26:
	.cfi_startproc
	movl	16(%rsi), %edx
	testl	%edx, %edx
	jle	.L595
	movq	%rsi, %rdx
	movl	16(%rdi), %esi
	cmpl	$2147483647, %esi
	je	.L601
	addl	$1, %esi
	jmp	math_prime_util__factor__u64_vectors__insert_vector
	.p2align 4,,10
	.p2align 3
.L595:
	ret
.L601:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$197, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE26:
	.size	math_prime_util__factor__u64_vectors__append_vector, .-math_prime_util__factor__u64_vectors__append_vector
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert_vector__2
	.type	math_prime_util__factor__u64_vectors__insert_vector__2, @function
math_prime_util__factor__u64_vectors__insert_vector__2:
.LFB58:
	.cfi_startproc
	movl	16(%rcx), %r8d
	testl	%r8d, %r8d
	jle	.L602
	movl	16(%rdi), %eax
	testq	%rsi, %rsi
	je	.L604
	movl	%edx, %esi
	cmpl	%eax, %edx
	jle	.L606
.L605:
	leal	1(%rax), %esi
.L606:
	movq	%rcx, %rdx
	jmp	math_prime_util__factor__u64_vectors__insert_vector
	.p2align 4,,10
	.p2align 3
.L602:
	ret
	.p2align 4,,10
	.p2align 3
.L604:
	cmpl	$2147483647, %eax
	jne	.L605
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1468, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE58:
	.size	math_prime_util__factor__u64_vectors__insert_vector__2, .-math_prime_util__factor__u64_vectors__insert_vector__2
	.align 2
	.p2align 4
	.type	math_prime_util__factor__raw_squfof, @function
math_prime_util__factor__raw_squfof:
.LFB231:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$1, %eax
	pxor	%xmm0, %xmm0
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$1496, %rsp
	.cfi_def_cfa_offset 1552
	movq	%rsi, 56(%rsp)
	movq	%rdx, 24(%rsp)
	leaq	116(%rsp), %rdx
	.p2align 6
	.p2align 4
	.p2align 3
.L611:
	leaq	-9(%rax,%rax,8), %rcx
	addq	$36, %rdx
	movl	$-1, 112(%rsp,%rcx,4)
	leaq	(%rax,%rax,8), %rcx
	addq	$1, %rax
	movups	%xmm0, -36(%rdx)
	movq	$0, -20(%rdx)
	movl	$0, 104(%rsp,%rcx,4)
	cmpq	$39, %rax
	jne	.L611
	movq	56(%rsp), %rax
	xorl	%ecx, %ecx
	shrq	$62, %rax
	jne	.L615
	movl	$38, 68(%rsp)
	movq	%rbp, 104(%rsp)
.L612:
	movl	68(%rsp), %esi
	cmpq	24(%rsp), %rcx
	setb	%dl
	testl	%esi, %esi
	setg	%al
	testb	%al, %dl
	je	.L688
	movl	$1, %r9d
	movq	%rcx, %r10
	.p2align 4
	.p2align 3
.L614:
	leaq	-1(%r9), %r13
	leaq	0(%r13,%r13,8), %rax
	leaq	0(,%rax,4), %rcx
	movl	112(%rsp,%rax,4), %eax
	testl	%eax, %eax
	je	.L616
	leaq	-8+math_prime_util__factor__multipliers(%rip), %rax
	movq	(%rax,%r9,8), %rsi
	js	.L689
.L617:
	cmpl	$1, 68(%rsp)
	je	.L647
	leaq	0(,%r9,8), %rax
	movq	%rax, 32(%rsp)
	addq	%r9, %rax
	movl	104(%rsp,%rax,4), %eax
	movl	%eax, 64(%rsp)
.L648:
	movq	56(%rsp), %rax
	movq	%r10, 48(%rsp)
	movq	%rsi, 80(%rsp)
	imulq	%rsi, %rax
	movl	$0, 96(%rsp)
	movq	%r13, 72(%rsp)
	movq	%r9, 40(%rsp)
	movq	%rax, 88(%rsp)
	leaq	0(%r13,%r13,8), %rax
	movl	116(%rsp,%rax,4), %ecx
	movl	120(%rsp,%rax,4), %ebx
	movl	124(%rsp,%rax,4), %r12d
	movq	32(%rsp), %rax
	addq	%r9, %rax
	movl	96(%rsp,%rax,4), %edx
	movl	100(%rsp,%rax,4), %r15d
	movl	92(%rsp,%rax,4), %ebp
	movl	64(%rsp), %eax
	movl	%edx, %r9d
	leal	(%r15,%rax), %r11d
.L645:
	testb	$1, %r15b
	je	.L630
	movl	%ebx, %eax
	leal	(%rcx,%rcx), %esi
	imull	%r12d, %eax
	subl	%eax, %esi
	imull	%ebx, %esi
	addl	%ebp, %esi
	je	.L686
	subl	%ecx, %eax
	xorl	%edx, %edx
	movl	%r12d, %ebp
	addl	$1, %r15d
	movl	%eax, %ecx
	leal	(%r9,%rax), %eax
	movl	%esi, %r12d
	divl	%esi
	movl	%eax, %ebx
.L630:
	cmpl	%r11d, %r15d
	jnb	.L690
	movl	%ebp, %eax
	movl	%r11d, 8(%rsp)
	movl	%r15d, %ebp
	movl	%r9d, %r14d
	movl	%r12d, %r15d
	movl	%eax, %r12d
	jmp	.L632
	.p2align 4,,10
	.p2align 3
.L693:
	subl	%ecx, %r13d
	xorl	%edx, %edx
	movl	%r8d, (%rsp)
	leal	(%r14,%r13), %eax
	divl	%r12d
	movl	%eax, %ebx
	movl	%r12d, %eax
	movq	%rax, %rdi
	movq	%rax, 16(%rsp)
	call	math_prime_util__int__is_square@PLT
	testb	%al, %al
	jne	.L691
	movl	%r12d, %ecx
	imull	%ebx, %ecx
	addl	(%rsp), %ecx
	subl	%ecx, %r13d
	imull	%ebx, %r13d
	addl	%r13d, %r15d
	je	.L686
	leal	(%r14,%rcx), %eax
	xorl	%edx, %edx
	addl	$2, %ebp
	divl	%r15d
	movl	%eax, %ebx
	cmpl	8(%rsp), %ebp
	jnb	.L692
.L632:
	movl	%r15d, %r13d
	movl	%ecx, %r8d
	imull	%ebx, %r13d
	subl	%r13d, %r8d
	leal	(%rcx,%r8), %eax
	imull	%ebx, %eax
	addl	%eax, %r12d
	jne	.L693
.L686:
	movq	40(%rsp), %r9
	movq	48(%rsp), %r10
.L633:
	movl	64(%rsp), %eax
	addq	%rax, %r10
.L616:
	addq	$1, %r9
	cmpq	$39, %r9
	je	.L694
.L646:
	cmpq	24(%rsp), %r10
	jb	.L614
.L688:
	movq	104(%rsp), %rbp
.L615:
	movl	$520, %edx
	xorl	%esi, %esi
	movq	%rbp, %rdi
	call	memset@PLT
	movq	56(%rsp), %rax
	movl	$1, 0(%rbp)
	movq	%rax, 8(%rbp)
.L610:
	addq	$1496, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%rbp, %rax
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
	.p2align 4,,10
	.p2align 3
.L689:
	.cfi_restore_state
	testq	%rsi, %rsi
	je	.L618
	movabsq	$4611686018427387903, %rax
	xorl	%edx, %edx
	divq	%rsi
	cmpq	56(%rsp), %rax
	jnb	.L618
	addq	$1, %r9
	subl	$1, 68(%rsp)
	movl	$0, 112(%rsp,%rcx)
	cmpq	$39, %r9
	jne	.L646
.L694:
	movq	%r10, %rcx
	jmp	.L612
	.p2align 4,,10
	.p2align 3
.L647:
	movq	24(%rsp), %rax
	subq	%r10, %rax
	shrq	$32, %rax
	jne	.L695
	movl	24(%rsp), %edx
	leaq	0(,%r9,8), %rax
	movq	%rax, 32(%rsp)
	addq	%r9, %rax
	subl	%r10d, %edx
	movl	%edx, 64(%rsp)
	movl	%edx, 104(%rsp,%rax,4)
	jmp	.L648
	.p2align 4,,10
	.p2align 3
.L618:
	movq	56(%rsp), %rbx
	movq	%r10, 16(%rsp)
	movq	%r9, 8(%rsp)
	imulq	%rsi, %rbx
	movq	%rsi, (%rsp)
	movq	%rbx, %rdi
	call	math_prime_util__int__sqrtint@PLT
	movq	8(%rsp), %r9
	movl	$4294967295, %r8d
	leaq	0(%r13,%r13,8), %rdi
	movq	%rax, %r12
	movq	(%rsp), %rsi
	movq	16(%rsp), %r10
	movl	$1, 112(%rsp,%rdi,4)
	leaq	0(,%r9,8), %rax
	cmpq	%r12, %r8
	leaq	(%rax,%r9), %r11
	movq	%rax, 32(%rsp)
	movl	$1, 92(%rsp,%r11,4)
	jb	.L696
	movq	%r12, %rax
	movl	%r12d, 96(%rsp,%r11,4)
	imulq	%r12, %rax
	movl	%r12d, 116(%rsp,%rdi,4)
	subq	%rax, %rbx
	cmpq	%rbx, %r8
	jb	.L697
	movl	%ebx, 124(%rsp,%rdi,4)
	testl	%ebx, %ebx
	je	.L698
	leaq	(%r12,%r12), %rax
	xorl	%edx, %edx
	divq	%rbx
	cmpq	%rax, %r8
	jb	.L699
	movl	%eax, 120(%rsp,%rdi,4)
	movl	$0, 100(%rsp,%r11,4)
	cmpq	%rsi, %r8
	jb	.L700
	pxor	%xmm0, %xmm0
	movq	%r10, 16(%rsp)
	movq	%r9, 8(%rsp)
	cvtsi2sdq	%r12, %xmm0
	movq	%rsi, (%rsp)
	call	ada__numerics__long_elementary_functions__sqrt@PLT
	movq	(%rsp), %rsi
	movq	8(%rsp), %r9
	mulsd	.LC18(%rip), %xmm0
	movq	16(%rsp), %r10
	comisd	.LC15(%rip), %xmm0
	jnb	.L624
	cvttsd2siq	%xmm0, %rax
.L625:
	movq	%rax, %rdi
	shrq	$32, %rdi
	jne	.L701
	cmpl	$19, %eax
	movl	$20, %edx
	movl	$20, %ecx
	cmova	%rax, %rdx
	cmovbe	%ecx, %eax
	cmpq	%rdx, 24(%rsp)
	jb	.L628
	movq	32(%rsp), %rdx
	addq	%r9, %rdx
	movl	%eax, 104(%rsp,%rdx,4)
	jmp	.L617
	.p2align 4,,10
	.p2align 3
.L691:
	movl	8(%rsp), %r11d
	movq	16(%rsp), %rdi
	movl	%r14d, %r9d
	movl	%r12d, %eax
	movl	%r9d, 100(%rsp)
	movl	(%rsp), %r14d
	movl	%r15d, %r12d
	movl	%ebp, %r15d
	movl	%r11d, (%rsp)
	movl	%eax, %ebp
	call	math_prime_util__int__sqrtint@PLT
	movl	$4294967295, %edi
	movl	(%rsp), %r11d
	movl	100(%rsp), %r9d
	cmpq	%rax, %rdi
	movq	%rax, %rsi
	jb	.L702
	leal	(%r9,%r14), %ecx
	movq	32(%rsp), %rax
	addl	$1, %r15d
	xorl	%edx, %edx
	addq	40(%rsp), %rax
	movl	%r15d, 100(%rsp,%rax,4)
	movl	%ecx, %eax
	divl	%esi
	subl	%edx, %ecx
	leal	(%rcx,%r13), %eax
	movq	%rax, %rcx
	imulq	%rax, %rax
	movq	%rax, %rdx
	movq	88(%rsp), %rax
	subq	%rdx, %rax
	xorl	%edx, %edx
	divq	%rsi
	cmpq	%rax, %rdi
	jb	.L703
	movl	%eax, %edi
	testl	%eax, %eax
	je	.L686
	leal	(%r9,%rcx), %eax
	xorl	%edx, %edx
	movl	96(%rsp), %r8d
	divl	%edi
	movl	%esi, %edx
	jmp	.L641
	.p2align 4,,10
	.p2align 3
.L706:
	subl	%ecx, %esi
	cmpl	%esi, %ecx
	je	.L639
	cmpl	$2147483647, %r8d
	je	.L704
	leal	(%r9,%rsi), %eax
	xorl	%edx, %edx
	addl	$1, %r8d
	divl	%edi
	movl	%r10d, %edx
	cmpl	$8000000, %r8d
	jg	.L705
	movl	%esi, %ecx
.L641:
	movl	%edi, %esi
	movl	%edi, %r10d
	leal	(%rcx,%rcx), %edi
	imull	%eax, %esi
	subl	%esi, %edi
	imull	%edi, %eax
	addl	%edx, %eax
	movl	%eax, %edi
	jne	.L706
	jmp	.L686
	.p2align 4,,10
	.p2align 3
.L692:
	movl	%r12d, %eax
	movq	40(%rsp), %r9
	movq	48(%rsp), %r10
	movl	%r15d, %r12d
	movq	72(%rsp), %r13
	movl	%ebp, %r15d
	movl	%eax, %ebp
.L637:
	leaq	0(%r13,%r13,8), %rax
	movl	%ecx, 116(%rsp,%rax,4)
	movl	%ebx, 120(%rsp,%rax,4)
	movl	%r12d, 124(%rsp,%rax,4)
	movq	32(%rsp), %rax
	addq	%r9, %rax
	movl	%ebp, 92(%rsp,%rax,4)
	movl	%r15d, 100(%rsp,%rax,4)
	jmp	.L633
	.p2align 4,,10
	.p2align 3
.L628:
	movq	32(%rsp), %rax
	movl	24(%rsp), %edx
	addq	%r9, %rax
	movl	%edx, 104(%rsp,%rax,4)
	jmp	.L617
	.p2align 4,,10
	.p2align 3
.L624:
	subsd	.LC15(%rip), %xmm0
	movabsq	$-9223372036854775808, %rdi
	cvttsd2siq	%xmm0, %rax
	xorq	%rdi, %rax
	jmp	.L625
.L705:
	movq	72(%rsp), %r13
	movq	40(%rsp), %r9
	movq	48(%rsp), %r10
	leaq	0(%r13,%r13,8), %rax
	movl	$0, 112(%rsp,%rax,4)
	.p2align 4
	.p2align 3
.L642:
	subl	$1, 68(%rsp)
	jmp	.L633
.L639:
	movq	88(%rsp), %rsi
	movl	%ecx, %edi
	movl	%r9d, 8(%rsp)
	movl	%r11d, (%rsp)
	movl	%r8d, 96(%rsp)
	call	math_prime_util__int__gcd@PLT
	movl	(%rsp), %r11d
	movl	8(%rsp), %r9d
	movq	%rax, %rdi
	shrq	$32, %rdi
	jne	.L707
	cmpl	$1, %eax
	ja	.L644
	movl	%r12d, %eax
	movl	%r13d, %ecx
	movl	%ebp, %r12d
	movl	%eax, %ebp
	jmp	.L645
.L644:
	movq	40(%rsp), %r9
	movq	48(%rsp), %r10
	movq	%rax, %rdi
	movq	%rax, %r14
	movq	80(%rsp), %rsi
	movq	72(%rsp), %r13
	movq	%r9, 8(%rsp)
	movq	%r10, (%rsp)
	call	math_prime_util__int__gcd@PLT
	xorl	%edx, %edx
	movq	(%rsp), %r10
	movq	8(%rsp), %r9
	movq	%rax, %rcx
	movq	%r14, %rax
	divq	%rcx
	cmpq	$1, %rax
	ja	.L708
	leaq	0(%r13,%r13,8), %rax
	movl	$0, 112(%rsp,%rax,4)
	jmp	.L642
.L690:
	movq	40(%rsp), %r9
	movq	48(%rsp), %r10
	movq	72(%rsp), %r13
	jmp	.L637
.L698:
	movq	104(%rsp), %rbp
	movq	56(%rsp), %rsi
	movq	%r12, %rdx
	movq	%rbp, %rdi
	call	math_prime_util__factor__found
	jmp	.L610
.L708:
	movq	104(%rsp), %rbp
	movq	56(%rsp), %rsi
	movq	%rax, %rdx
	movq	%rbp, %rdi
	call	math_prime_util__factor__found
	jmp	.L610
.L704:
	movl	$826, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L703:
	movl	$810, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L696:
	movl	$862, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L695:
	movl	$885, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L697:
	movl	$865, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L707:
	movl	$832, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L702:
	movl	$807, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L701:
	movl	$873, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L700:
	movl	$872, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L699:
	movl	$870, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE231:
	.size	math_prime_util__factor__raw_squfof, .-math_prime_util__factor__raw_squfof
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__iteratorDF__2
	.type	math_prime_util__factor__u64_vectors__iteratorDF__2, @function
math_prime_util__factor__u64_vectors__iteratorDF__2:
.LFB359:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE359:
	.size	math_prime_util__factor__u64_vectors__iteratorDF__2, .-math_prime_util__factor__u64_vectors__iteratorDF__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__adjust
	.type	math_prime_util__factor__u64_vectors__implementation__adjust, @function
math_prime_util__factor__u64_vectors__implementation__adjust:
.LFB347:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE347:
	.size	math_prime_util__factor__u64_vectors__implementation__adjust, .-math_prime_util__factor__u64_vectors__implementation__adjust
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__last__3
	.type	math_prime_util__factor__u64_vectors__last__3, @function
math_prime_util__factor__u64_vectors__last__3:
.LFB73:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rdx
	testl	%eax, %eax
	jne	.L712
	movl	16(%rdx), %eax
	xorl	%ecx, %ecx
	movl	$0, %edi
	testl	%eax, %eax
	cmovle	%rcx, %rdx
	movl	%edi, %ecx
	movq	%rdx, %rsi
	movl	$1, %edx
	cmovg	%eax, %edx
	movq	%rcx, %rax
	movabsq	$-4294967296, %rcx
	andq	%rcx, %rax
	orq	%rdx, %rax
	movq	%rax, %rdx
	movq	%rsi, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L712:
	xchgq	%rdx, %rax
	ret
	.cfi_endproc
.LFE73:
	.size	math_prime_util__factor__u64_vectors__last__3, .-math_prime_util__factor__u64_vectors__last__3
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__first__3
	.type	math_prime_util__factor__u64_vectors__first__3, @function
math_prime_util__factor__u64_vectors__first__3:
.LFB50:
	.cfi_startproc
	movl	24(%rdi), %eax
	movq	16(%rdi), %rdx
	testl	%eax, %eax
	jne	.L716
	movl	16(%rdx), %ecx
	xorl	%eax, %eax
	testl	%ecx, %ecx
	cmovle	%rax, %rdx
	movq	%rdx, %rax
	movl	$1, %edx
	ret
	.p2align 4,,10
	.p2align 3
.L716:
	xchgq	%rdx, %rax
	ret
	.cfi_endproc
.LFE50:
	.size	math_prime_util__factor__u64_vectors__first__3, .-math_prime_util__factor__u64_vectors__first__3
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation___size__2
	.type	math_prime_util__factor__u64_vectors__implementation___size__2, @function
math_prime_util__factor__u64_vectors__implementation___size__2:
.LFB349:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE349:
	.size	math_prime_util__factor__u64_vectors__implementation___size__2, .-math_prime_util__factor__u64_vectors__implementation___size__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation___size__3
	.type	math_prime_util__factor__u64_vectors__implementation___size__3, @function
math_prime_util__factor__u64_vectors__implementation___size__3:
.LFB351:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE351:
	.size	math_prime_util__factor__u64_vectors__implementation___size__3, .-math_prime_util__factor__u64_vectors__implementation___size__3
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__reference_control_typeDF
	.type	math_prime_util__factor__u64_vectors__implementation__reference_control_typeDF, @function
math_prime_util__factor__u64_vectors__implementation__reference_control_typeDF:
.LFB353:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE353:
	.size	math_prime_util__factor__u64_vectors__implementation__reference_control_typeDF, .-math_prime_util__factor__u64_vectors__implementation__reference_control_typeDF
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__with_busyDF
	.type	math_prime_util__factor__u64_vectors__implementation__with_busyDF, @function
math_prime_util__factor__u64_vectors__implementation__with_busyDF:
.LFB355:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE355:
	.size	math_prime_util__factor__u64_vectors__implementation__with_busyDF, .-math_prime_util__factor__u64_vectors__implementation__with_busyDF
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__with_lockDF
	.type	math_prime_util__factor__u64_vectors__implementation__with_lockDF, @function
math_prime_util__factor__u64_vectors__implementation__with_lockDF:
.LFB357:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE357:
	.size	math_prime_util__factor__u64_vectors__implementation__with_lockDF, .-math_prime_util__factor__u64_vectors__implementation__with_lockDF
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors___size__4
	.type	math_prime_util__factor__u64_vectors___size__4, @function
math_prime_util__factor__u64_vectors___size__4:
.LFB361:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE361:
	.size	math_prime_util__factor__u64_vectors___size__4, .-math_prime_util__factor__u64_vectors___size__4
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T587s, @function
math_prime_util__factor__u64_vectors__T587s:
.LFB372:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE372:
	.size	math_prime_util__factor__u64_vectors__T587s, .-math_prime_util__factor__u64_vectors__T587s
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T559s, @function
math_prime_util__factor__u64_vectors__T559s:
.LFB373:
	.cfi_startproc
	movl	$256, %eax
	ret
	.cfi_endproc
.LFE373:
	.size	math_prime_util__factor__u64_vectors__T559s, .-math_prime_util__factor__u64_vectors__T559s
	.section	.text.unlikely
	.align 2
.LCOLDB21:
	.text
.LHOTB21:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__iterate__2
	.type	math_prime_util__factor__u64_vectors__iterate__2, @function
math_prime_util__factor__u64_vectors__iterate__2:
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
.LEHB9:
	call	system__secondary_stack__ss_mark@PLT
	movl	24(%rsp), %eax
	cmpl	$1, %eax
	je	.L728
	cmpl	$2, %eax
	je	.L743
	cmpl	$3, %eax
	je	.L744
	cmpl	$4, %eax
	jne	.L732
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.LEHE9:
.L742:
	leaq	32+math_prime_util__factor__u64_vectors__math_prime_util__factor__u64_vectors__iterator_math_prime_util__factor__u64_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rdx
	movl	24(%rsp), %ecx
	leaq	8(%rax), %rbx
	movq	%rbp, 16(%rax)
	movq	.LC20(%rip), %xmm0
	movq	%rdx, %xmm1
	movl	$0, 24(%rax)
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, (%rax)
	cmpl	$2, %ecx
	jne	.L733
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
.L728:
	.cfi_restore_state
	leaq	32+math_prime_util__factor__u64_vectors__math_prime_util__factor__u64_vectors__iterator_math_prime_util__factor__u64_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rax
	movq	%rbp, 16(%rbx)
	addq	$8, %rbx
	movq	.LC20(%rip), %xmm0
	movq	%rax, %xmm2
	movl	$0, 16(%rbx)
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, -8(%rbx)
.L733:
	movq	%rsp, %rdi
.LEHB10:
	call	system__secondary_stack__ss_release@PLT
.LEHE10:
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
.L743:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB11:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L742
	.p2align 4,,10
	.p2align 3
.L744:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L742
.L732:
	movl	$2058, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE11:
.L737:
	movq	%rax, %rbx
	jmp	.L735
	.section	.gcc_except_table
.LLSDA68:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE68-.LLSDACSB68
.LLSDACSB68:
	.uleb128 .LEHB9-.LFB68
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L737-.LFB68
	.uleb128 0
	.uleb128 .LEHB10-.LFB68
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB11-.LFB68
	.uleb128 .LEHE11-.LEHB11
	.uleb128 .L737-.LFB68
	.uleb128 0
.LLSDACSE68:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC68
	.type	math_prime_util__factor__u64_vectors__iterate__2.cold, @function
math_prime_util__factor__u64_vectors__iterate__2.cold:
.LFSB68:
.L735:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L736
	movq	%rsp, %rdi
.LEHB12:
	call	system__secondary_stack__ss_release@PLT
.L736:
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE12:
	.cfi_endproc
.LFE68:
	.section	.gcc_except_table
.LLSDAC68:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC68-.LLSDACSBC68
.LLSDACSBC68:
	.uleb128 .LEHB12-.LCOLDB21
	.uleb128 .LEHE12-.LEHB12
	.uleb128 0
	.uleb128 0
.LLSDACSEC68:
	.section	.text.unlikely
	.text
	.size	math_prime_util__factor__u64_vectors__iterate__2, .-math_prime_util__factor__u64_vectors__iterate__2
	.section	.text.unlikely
	.size	math_prime_util__factor__u64_vectors__iterate__2.cold, .-math_prime_util__factor__u64_vectors__iterate__2.cold
.LCOLDE21:
	.text
.LHOTE21:
	.section	.text.unlikely
	.align 2
.LCOLDB22:
	.text
.LHOTB22:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__iterate__3
	.type	math_prime_util__factor__u64_vectors__iterate__3, @function
math_prime_util__factor__u64_vectors__iterate__3:
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
.LEHB13:
	call	system__secondary_stack__ss_mark@PLT
	movl	24(%rsp), %eax
	cmpl	$1, %eax
	je	.L746
	cmpl	$2, %eax
	je	.L761
	cmpl	$3, %eax
	je	.L762
	cmpl	$4, %eax
	jne	.L750
	movl	$8, %edx
	movl	$32, %esi
	movq	%r14, %rdi
	call	system__storage_pools__allocate_any@PLT
.LEHE13:
.L760:
	movq	.LC20(%rip), %xmm0
	leaq	32+math_prime_util__factor__u64_vectors__math_prime_util__factor__u64_vectors__iterator_math_prime_util__factor__u64_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rdx
	movl	24(%rsp), %ecx
	movl	%ebx, 24(%rax)
	movq	%rdx, %xmm1
	movq	%rbp, 16(%rax)
	leaq	8(%rax), %rbx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, (%rax)
	cmpl	$2, %ecx
	jne	.L751
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
.L746:
	.cfi_restore_state
	movq	.LC20(%rip), %xmm0
	movq	80(%rsp), %rax
	movl	%ebx, 24(%rax)
	movq	%rbp, 16(%rax)
	leaq	32+math_prime_util__factor__u64_vectors__math_prime_util__factor__u64_vectors__iterator_math_prime_util__factor__u64_vectors__vector_iterator_interfaces__reversible_iterator1T(%rip), %rax
	movq	%rax, %xmm2
	movq	80(%rsp), %rax
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, (%rax)
	leaq	8(%rax), %rbx
.L751:
	movq	%rsp, %rdi
.LEHB14:
	call	system__secondary_stack__ss_release@PLT
.LEHE14:
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
.L761:
	.cfi_restore_state
	movl	$8, %esi
	movl	$32, %edi
.LEHB15:
	call	system__secondary_stack__ss_allocate@PLT
	jmp	.L760
	.p2align 4,,10
	.p2align 3
.L762:
	movl	$32, %edi
	call	__gnat_malloc@PLT
	jmp	.L760
.L750:
	movl	$2111, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_PE_Build_In_Place_Mismatch@PLT
.LEHE15:
.L755:
	movq	%rax, %rbx
	jmp	.L753
	.section	.gcc_except_table
.LLSDA70:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE70-.LLSDACSB70
.LLSDACSB70:
	.uleb128 .LEHB13-.LFB70
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L755-.LFB70
	.uleb128 0
	.uleb128 .LEHB14-.LFB70
	.uleb128 .LEHE14-.LEHB14
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB15-.LFB70
	.uleb128 .LEHE15-.LEHB15
	.uleb128 .L755-.LFB70
	.uleb128 0
.LLSDACSE70:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC70
	.type	math_prime_util__factor__u64_vectors__iterate__3.cold, @function
math_prime_util__factor__u64_vectors__iterate__3.cold:
.LFSB70:
.L753:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	cmpl	$2, 24(%rsp)
	je	.L754
	movq	%rsp, %rdi
.LEHB16:
	call	system__secondary_stack__ss_release@PLT
.L754:
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE16:
	.cfi_endproc
.LFE70:
	.section	.gcc_except_table
.LLSDAC70:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC70-.LLSDACSBC70
.LLSDACSBC70:
	.uleb128 .LEHB16-.LCOLDB22
	.uleb128 .LEHE16-.LEHB16
	.uleb128 0
	.uleb128 0
.LLSDACSEC70:
	.section	.text.unlikely
	.text
	.size	math_prime_util__factor__u64_vectors__iterate__3, .-math_prime_util__factor__u64_vectors__iterate__3
	.section	.text.unlikely
	.size	math_prime_util__factor__u64_vectors__iterate__3.cold, .-math_prime_util__factor__u64_vectors__iterate__3.cold
.LCOLDE22:
	.text
.LHOTE22:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__implementation__reference_control_typeSO
	.type	math_prime_util__factor__u64_vectors__implementation__reference_control_typeSO, @function
math_prime_util__factor__u64_vectors__implementation__reference_control_typeSO:
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
	.size	math_prime_util__factor__u64_vectors__implementation__reference_control_typeSO, .-math_prime_util__factor__u64_vectors__implementation__reference_control_typeSO
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__previous__4
	.type	math_prime_util__factor__u64_vectors__previous__4, @function
math_prime_util__factor__u64_vectors__previous__4:
.LFB84:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L770
	leal	-1(%rdx), %eax
	cmpl	$1, %edx
	jle	.L771
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L771:
	xorl	%ecx, %ecx
	movl	$1, %eax
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L770:
	xorl	%eax, %eax
	movl	$1, %edx
	ret
	.cfi_endproc
.LFE84:
	.size	math_prime_util__factor__u64_vectors__previous__4, .-math_prime_util__factor__u64_vectors__previous__4
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T595s, @function
math_prime_util__factor__u64_vectors__T595s:
.LFB374:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L777
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L775
	xorl	%ecx, %ecx
	movl	$1, %eax
.L775:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L777:
	xorl	%eax, %eax
	movl	$1, %edx
	ret
	.cfi_endproc
.LFE374:
	.size	math_prime_util__factor__u64_vectors__T595s, .-math_prime_util__factor__u64_vectors__T595s
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__next__4
	.type	math_prime_util__factor__u64_vectors__next__4, @function
math_prime_util__factor__u64_vectors__next__4:
.LFB79:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L783
	leal	1(%rdx), %eax
	cmpl	16(%rsi), %edx
	jl	.L781
	xorl	%ecx, %ecx
	movl	$1, %eax
.L781:
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L783:
	xorl	%eax, %eax
	movl	$1, %edx
	ret
	.cfi_endproc
.LFE79:
	.size	math_prime_util__factor__u64_vectors__next__4, .-math_prime_util__factor__u64_vectors__next__4
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__swap__2
	.type	math_prime_util__factor__u64_vectors__swap__2, @function
math_prime_util__factor__u64_vectors__swap__2:
.LFB106:
	.cfi_startproc
	cmpl	%edx, %r8d
	je	.L784
	movq	8(%rdi), %rax
	movslq	%r8d, %r8
	movslq	%edx, %rdx
	movq	(%rax,%r8,8), %rsi
	movq	(%rax,%rdx,8), %rcx
	movq	%rsi, (%rax,%rdx,8)
	movq	8(%rdi), %rax
	movq	%rcx, (%rax,%r8,8)
.L784:
	ret
	.cfi_endproc
.LFE106:
	.size	math_prime_util__factor__u64_vectors__swap__2, .-math_prime_util__factor__u64_vectors__swap__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__vectorFD
	.type	math_prime_util__factor__u64_vectors__vectorFD, @function
math_prime_util__factor__u64_vectors__vectorFD:
.LFB152:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$0, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L786
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L786:
	ret
	.cfi_endproc
.LFE152:
	.size	math_prime_util__factor__u64_vectors__vectorFD, .-math_prime_util__factor__u64_vectors__vectorFD
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__vectorDF__2
	.type	math_prime_util__factor__u64_vectors__vectorDF__2, @function
math_prime_util__factor__u64_vectors__vectorDF__2:
.LFB159:
	.cfi_startproc
	movq	8(%rdi), %rax
	movl	$0, 16(%rdi)
	movq	$0, 8(%rdi)
	testq	%rax, %rax
	je	.L788
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L788:
	ret
	.cfi_endproc
.LFE159:
	.size	math_prime_util__factor__u64_vectors__vectorDF__2, .-math_prime_util__factor__u64_vectors__vectorDF__2
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__implementation__T142s, @function
math_prime_util__factor__u64_vectors__implementation__T142s:
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
	leaq	32+math_prime_util__factor__u64_vectors__implementation__reference_control_typeT(%rip), %rax
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
	.size	math_prime_util__factor__u64_vectors__implementation__T142s, .-math_prime_util__factor__u64_vectors__implementation__T142s
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__assign
	.type	math_prime_util__factor__u64_vectors__assign, @function
math_prime_util__factor__u64_vectors__assign:
.LFB29:
	.cfi_startproc
	cmpq	%rsi, %rdi
	je	.L792
	movl	$0, 16(%rdi)
	movl	16(%rsi), %eax
	testl	%eax, %eax
	jle	.L792
	movq	%rsi, %rdx
	movl	$1, %esi
	jmp	math_prime_util__factor__u64_vectors__insert_vector
	.p2align 4,,10
	.p2align 3
.L792:
	ret
	.cfi_endproc
.LFE29:
	.size	math_prime_util__factor__u64_vectors__assign, .-math_prime_util__factor__u64_vectors__assign
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T601s, @function
math_prime_util__factor__u64_vectors__T601s:
.LFB375:
	.cfi_startproc
	movq	%rsi, %rcx
	testq	%rsi, %rsi
	je	.L799
	leal	-1(%rdx), %eax
	cmpl	$1, %edx
	jle	.L800
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L800:
	xorl	%ecx, %ecx
	movl	$1, %eax
	movq	%rax, %rdx
	movq	%rcx, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L799:
	xorl	%eax, %eax
	movl	$1, %edx
	ret
	.cfi_endproc
.LFE375:
	.size	math_prime_util__factor__u64_vectors__T601s, .-math_prime_util__factor__u64_vectors__T601s
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T598s, @function
math_prime_util__factor__u64_vectors__T598s:
.LFB376:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rdx
	testl	%eax, %eax
	jne	.L802
	movl	16(%rdx), %eax
	xorl	%ecx, %ecx
	movl	$0, %edi
	testl	%eax, %eax
	cmovle	%rcx, %rdx
	movl	%edi, %ecx
	movq	%rdx, %rsi
	movl	$1, %edx
	cmovg	%eax, %edx
	movq	%rcx, %rax
	movabsq	$-4294967296, %rcx
	andq	%rcx, %rax
	orq	%rdx, %rax
	movq	%rax, %rdx
	movq	%rsi, %rax
	ret
	.p2align 4,,10
	.p2align 3
.L802:
	xchgq	%rdx, %rax
	ret
	.cfi_endproc
.LFE376:
	.size	math_prime_util__factor__u64_vectors__T598s, .-math_prime_util__factor__u64_vectors__T598s
	.align 2
	.p2align 4
	.type	math_prime_util__factor__u64_vectors__T592s, @function
math_prime_util__factor__u64_vectors__T592s:
.LFB377:
	.cfi_startproc
	movl	16(%rdi), %eax
	movq	8(%rdi), %rdx
	testl	%eax, %eax
	jne	.L806
	movl	16(%rdx), %ecx
	xorl	%eax, %eax
	testl	%ecx, %ecx
	cmovle	%rax, %rdx
	movq	%rdx, %rax
	movl	$1, %edx
	ret
	.p2align 4,,10
	.p2align 3
.L806:
	xchgq	%rdx, %rax
	ret
	.cfi_endproc
.LFE377:
	.size	math_prime_util__factor__u64_vectors__T592s, .-math_prime_util__factor__u64_vectors__T592s
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__vectorSW__2
	.type	math_prime_util__factor__u64_vectors__vectorSW__2, @function
math_prime_util__factor__u64_vectors__vectorSW__2:
.LFB168:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	movl	16(%rsi), %esi
	cmpl	$-2147483648, %esi
	je	.L815
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	call	system__stream_attributes__w_u@PLT
	movl	16(%rbp), %eax
	testl	%eax, %eax
	jle	.L809
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	movl	$1, %ebx
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	leaq	1(%rax), %r13
	.p2align 4
	.p2align 3
.L812:
	movq	8(%rbp), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	system__stream_attributes__w_lu@PLT
	cmpq	%rbx, %r13
	jne	.L812
	movq	8(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %r13
	.cfi_restore 13
.L809:
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
.L815:
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	movq	%r12, 24(%rsp)
	movq	%r13, 32(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__factor__u64_vectors__length.part.0
	.cfi_endproc
.LFE168:
	.size	math_prime_util__factor__u64_vectors__vectorSW__2, .-math_prime_util__factor__u64_vectors__vectorSW__2
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__vectorSO__2
	.type	math_prime_util__factor__u64_vectors__vectorSO__2, @function
math_prime_util__factor__u64_vectors__vectorSO__2:
.LFB363:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	movl	16(%rsi), %esi
	cmpl	$-2147483648, %esi
	je	.L822
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	call	system__stream_attributes__w_u@PLT
	movl	16(%rbp), %eax
	testl	%eax, %eax
	jle	.L816
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	movl	$1, %ebx
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	leaq	1(%rax), %r13
	.p2align 4
	.p2align 3
.L819:
	movq	8(%rbp), %rax
	movq	%r12, %rdi
	movq	(%rax,%rbx,8), %rsi
	addq	$1, %rbx
	call	system__stream_attributes__w_lu@PLT
	cmpq	%r13, %rbx
	jne	.L819
	movq	8(%rsp), %rbx
	.cfi_restore 3
	movq	32(%rsp), %r13
	.cfi_restore 13
.L816:
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
.L822:
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	movq	%r12, 24(%rsp)
	movq	%r13, 32(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	call	math_prime_util__factor__u64_vectors__length.part.0
	.cfi_endproc
.LFE363:
	.size	math_prime_util__factor__u64_vectors__vectorSO__2, .-math_prime_util__factor__u64_vectors__vectorSO__2
	.section	.text.unlikely
	.align 2
.LCOLDB23:
	.text
.LHOTB23:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors___assign__2
	.type	math_prime_util__factor__u64_vectors___assign__2, @function
math_prime_util__factor__u64_vectors___assign__2:
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
.LEHB17:
	call	*system__soft_links__abort_defer(%rip)
.LEHE17:
	cmpq	%rbp, %rbx
	jne	.L824
.L826:
	movq	640(%rsp), %rbx
	movq	648(%rsp), %rbp
	addq	$664, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
.LEHB18:
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE18:
	.p2align 4,,10
	.p2align 3
.L824:
	.cfi_restore_state
	movq	8(%rbx), %rdi
	movl	$0, 16(%rbx)
	movq	$0, 8(%rbx)
	testq	%rdi, %rdi
	je	.L827
.LEHB19:
	call	__gnat_free@PLT
.L827:
	movdqu	0(%rbp), %xmm0
	movq	(%rbx), %rax
	movq	%rbx, %rdi
	movups	%xmm0, (%rbx)
	movdqu	16(%rbp), %xmm0
	movq	%rax, (%rbx)
	movups	%xmm0, 16(%rbx)
	call	math_prime_util__factor__u64_vectors__adjust__2
.LEHE19:
	jmp	.L826
.L833:
	movq	%rax, %rbp
	jmp	.L828
.L835:
	jmp	.L836
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
	.uleb128 .LEHB17-.LFB157
	.uleb128 .LEHE17-.LEHB17
	.uleb128 .L835-.LFB157
	.uleb128 0
	.uleb128 .LEHB18-.LFB157
	.uleb128 .LEHE18-.LEHB18
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB19-.LFB157
	.uleb128 .LEHE19-.LEHB19
	.uleb128 .L833-.LFB157
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
	.type	math_prime_util__factor__u64_vectors___assign__2.cold, @function
math_prime_util__factor__u64_vectors___assign__2.cold:
.LFSB157:
.L828:
	.cfi_def_cfa_offset 672
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	subq	$1, %rdx
	jne	.L838
	movq	%rax, %rdi
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movq	%rax, %r14
.LEHB20:
	call	__gnat_set_exception_parameter@PLT
	movq	%rsp, %rdi
	call	__gnat_raise_from_controlled_operation@PLT
.LEHE20:
.L832:
	movq	656(%rsp), %r14
	.cfi_restore 14
.L836:
	movq	%r14, 656(%rsp)
	movq	%rax, %rbx
	.cfi_offset 14, -16
.L830:
.LEHB21:
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE21:
.L838:
	.cfi_restore 14
	movq	%r14, 656(%rsp)
	.cfi_offset 14, -16
	movq	%rax, %rbx
	jmp	.L830
.L834:
	movq	%rax, %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
.LEHB22:
	call	__gnat_end_handler_v1@PLT
.LEHE22:
	jmp	.L830
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
	.uleb128 .LEHB20-.LCOLDB23
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L834-.LCOLDB23
	.uleb128 0
	.uleb128 .LEHB21-.LCOLDB23
	.uleb128 .LEHE21-.LEHB21
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB22-.LCOLDB23
	.uleb128 .LEHE22-.LEHB22
	.uleb128 .L832-.LCOLDB23
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
	.size	math_prime_util__factor__u64_vectors___assign__2, .-math_prime_util__factor__u64_vectors___assign__2
	.section	.text.unlikely
	.size	math_prime_util__factor__u64_vectors___assign__2.cold, .-math_prime_util__factor__u64_vectors___assign__2.cold
.LCOLDE23:
	.text
.LHOTE23:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__set_length
	.type	math_prime_util__factor__u64_vectors__set_length, @function
math_prime_util__factor__u64_vectors__set_length:
.LFB104:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	%esi, %eax
	movl	16(%rdi), %esi
	cmpl	$-2147483648, %esi
	je	.L857
	movl	%esi, %edx
	subl	%eax, %edx
	jo	.L842
	testl	%edx, %edx
	jns	.L858
	cmpl	$-2147483648, %edx
	je	.L848
	cmpl	$2147483647, %esi
	je	.L848
	negl	%edx
	addl	$1, %esi
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__factor__u64_vectors__insert_space
	.p2align 4,,10
	.p2align 3
.L858:
	.cfi_restore_state
	je	.L839
	movl	%esi, %ecx
	xorl	%eax, %eax
	subl	%edx, %ecx
	cmpl	%edx, %esi
	cmovg	%ecx, %eax
	movl	%eax, 16(%rdi)
.L839:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L842:
	.cfi_restore_state
	movl	$2993, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L848:
	movl	$3010, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L857:
	call	math_prime_util__factor__u64_vectors__length.part.0
	.cfi_endproc
.LFE104:
	.size	math_prime_util__factor__u64_vectors__set_length, .-math_prime_util__factor__u64_vectors__set_length
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__delete_last
	.type	math_prime_util__factor__u64_vectors__delete_last, @function
math_prime_util__factor__u64_vectors__delete_last:
.LFB40:
	.cfi_startproc
	testl	%esi, %esi
	je	.L870
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %eax
	cmpl	$-2147483648, %eax
	je	.L873
	cmpl	%eax, %esi
	jge	.L874
	subl	%esi, %eax
	jo	.L864
	movl	%eax, 16(%rdi)
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L874:
	.cfi_restore_state
	movl	$0, 16(%rdi)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L870:
	ret
.L873:
	.cfi_def_cfa_offset 16
	call	math_prime_util__factor__u64_vectors__length.part.0
.L864:
	movl	$589, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE40:
	.size	math_prime_util__factor__u64_vectors__delete_last, .-math_prime_util__factor__u64_vectors__delete_last
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__insert__8
	.type	math_prime_util__factor__u64_vectors__insert__8, @function
math_prime_util__factor__u64_vectors__insert__8:
.LFB63:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	%edx, %r10d
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	movq	%r8, %r13
	testl	%r9d, %r9d
	jne	.L876
	testq	%rsi, %rsi
	je	.L881
	cmpl	16(%rdi), %edx
	movl	$1, %eax
	cmovg	%eax, %r10d
	movl	$0, %eax
	cmovg	%rax, %rdi
.L877:
	movl	%r13d, %eax
	movl	%r10d, %esi
	movq	32(%rsp), %r13
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movq	%rax, %rdx
	movq	%rdi, %rax
	movabsq	$-4294967296, %rdi
	movq	%rdx, %rcx
	andq	%rdi, %rcx
	orq	%rsi, %rcx
	movq	%rcx, %rdx
	ret
	.p2align 4,,10
	.p2align 3
.L876:
	.cfi_restore_state
	movl	16(%rdi), %eax
	movl	%r9d, %ecx
	testq	%rsi, %rsi
	je	.L878
	cmpl	%eax, %edx
	jle	.L880
.L879:
	leal	1(%rax), %r10d
.L880:
	movl	%r10d, %esi
	xorl	%edx, %edx
	movl	%r10d, 12(%rsp)
	movq	%rdi, (%rsp)
	call	math_prime_util__factor__u64_vectors__insert__4
	movq	(%rsp), %rdi
	movl	12(%rsp), %r10d
	jmp	.L877
	.p2align 4,,10
	.p2align 3
.L878:
	cmpl	$2147483647, %eax
	jne	.L879
	movl	$1585, %esi
	leaq	.LC8(%rip), %rdi
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L881:
	.cfi_restore 12
	movl	$1, %r10d
	xorl	%edi, %edi
	jmp	.L877
	.cfi_endproc
.LFE63:
	.size	math_prime_util__factor__u64_vectors__insert__8, .-math_prime_util__factor__u64_vectors__insert__8
	.section	.text.unlikely
	.align 2
.LCOLDB24:
	.text
.LHOTB24:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__put_image
	.type	math_prime_util__factor__u64_vectors__put_image, @function
math_prime_util__factor__u64_vectors__put_image:
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
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
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
	movq	%rsi, 8(%rsp)
	movq	%rax, 80(%rsp)
.LEHB23:
	call	system__put_images__array_before@PLT
.LEHE23:
	leaq	56(%rsp), %rax
	leaq	32(%rsp), %rdi
	movq	$0, 56(%rsp)
	movq	%rax, 24(%rsp)
	leaq	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	$0, 64(%rsp)
	movq	$0, 72(%rsp)
	movq	%rax, 16(%rsp)
.LEHB24:
	call	system__secondary_stack__ss_mark@PLT
	leaq	56(%rsp), %rax
	movq	%rax, 24(%rsp)
	leaq	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 16(%rsp)
	call	*system__soft_links__enter_master(%rip)
	leaq	56(%rsp), %rax
	movq	%rax, 24(%rsp)
	leaq	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 16(%rsp)
	call	*system__soft_links__current_master(%rip)
	leaq	56(%rsp), %rax
	xorl	%r8d, %r8d
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movq	%rax, 24(%rsp)
	movl	$2, %esi
	movq	%rbx, %rdi
	leaq	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 16(%rsp)
	call	math_prime_util__factor__u64_vectors__iterate__2
	movq	%rax, %r12
	leaq	56(%rsp), %rax
	movq	%rax, 24(%rsp)
	movq	%r12, %rdi
	leaq	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rax
	movq	%rax, 16(%rsp)
	call	ada__tags__base_address@PLT
	leaq	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD(%rip), %rdi
	leaq	56(%rsp), %rdx
	movq	%rdi, 16(%rsp)
	movq	%rdi, %rsi
	movq	%rax, %rdi
	movq	%rdx, 24(%rsp)
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	(%r12), %rax
	movq	(%rax), %rax
	testb	$1, %al
	jne	.L916
.L885:
	movq	%r12, %rdi
	call	*%rax
	movq	%rdx, %r15
	movq	%rax, %rbp
	movl	%edx, %ebx
	cmpl	$1, %edx
	jne	.L886
	testq	%rax, %rax
	je	.L892
.L886:
	movq	8(%rsp), %rax
	movq	8(%rax), %rax
	jmp	.L894
	.p2align 4,,10
	.p2align 3
.L903:
	movq	8(%rsp), %rax
	movq	%r13, %rdi
	movq	8(%rax), %rax
	movq	%rax, (%rsp)
	call	system__put_images__simple_array_between@PLT
	movq	(%rsp), %rax
.L894:
	movslq	%ebx, %rcx
	movq	%r13, %rdi
	movq	(%rax,%rcx,8), %rsi
	call	system__put_images__put_image_long_long_unsigned@PLT
	movabsq	$-4294967296, %rax
	movq	(%r12), %rcx
	movl	%ebx, %esi
	movq	%r15, %rbx
	andq	%rax, %rbx
	movq	8(%rcx), %rcx
	orq	%rsi, %rbx
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	movq	%rcx, %rax
	testb	$1, %al
	jne	.L917
.L891:
	movq	%r12, %rdi
	call	*%rax
.LEHE24:
	movq	%rdx, %r15
	movq	%rax, %rbp
	movl	%edx, %ebx
	cmpl	$1, %edx
	jne	.L903
	testq	%rax, %rax
	jne	.L903
.L892:
.LEHB25:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebx
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE25:
	movq	16(%rsp), %rsi
	movq	24(%rsp), %rdi
.LEHB26:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE26:
	leaq	32(%rsp), %rdi
.LEHB27:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
.L887:
	movq	%r13, %rdi
	call	system__put_images__array_after@PLT
.LEHE27:
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
.L917:
	.cfi_restore_state
	movq	-1(%rcx), %r10
	movq	7(%rcx), %rax
	jmp	.L891
.L916:
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L885
.L900:
	movq	%rax, %r12
	jmp	.L895
.L901:
	movq	%rax, %rbp
	jmp	.L888
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
	.uleb128 .LEHB23-.LFB87
	.uleb128 .LEHE23-.LEHB23
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB24-.LFB87
	.uleb128 .LEHE24-.LEHB24
	.uleb128 .L900-.LFB87
	.uleb128 0
	.uleb128 .LEHB25-.LFB87
	.uleb128 .LEHE25-.LEHB25
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB26-.LFB87
	.uleb128 .LEHE26-.LEHB26
	.uleb128 .L901-.LFB87
	.uleb128 0x1
	.uleb128 .LEHB27-.LFB87
	.uleb128 .LEHE27-.LEHB27
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
	.type	math_prime_util__factor__u64_vectors__put_image.cold, @function
math_prime_util__factor__u64_vectors__put_image.cold:
.LFSB87:
.L895:
	.cfi_def_cfa_offset 160
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
.LEHB28:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebp
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
.LEHE28:
	movq	16(%rsp), %rsi
	movq	24(%rsp), %rdi
.LEHB29:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE29:
	xorl	%ebx, %ebx
.L899:
	leaq	32(%rsp), %rdi
	xorl	$1, %ebp
.LEHB30:
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	testb	%bl, %bpl
	je	.L914
.L890:
	movl	$2362, %esi
	leaq	.LC8(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L888:
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L918
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbp, %rdi
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	leaq	32(%rsp), %rdi
	call	system__secondary_stack__ss_release@PLT
	call	*system__soft_links__abort_undefer(%rip)
	andb	$1, %bl
	jne	.L887
	jmp	.L890
.L902:
	subq	$1, %rdx
	movq	%rax, %rbx
	movq	%rax, %rdi
	jne	.L919
	call	__gnat_begin_handler_v1@PLT
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movl	$1, %ebx
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
	jmp	.L899
.L914:
	movq	%r12, %rdi
	call	_Unwind_Resume@PLT
.L918:
	call	_Unwind_Resume@PLT
.L919:
	call	_Unwind_Resume@PLT
.LEHE30:
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
	.uleb128 .LEHB28-.LCOLDB24
	.uleb128 .LEHE28-.LEHB28
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB29-.LCOLDB24
	.uleb128 .LEHE29-.LEHB29
	.uleb128 .L902-.LCOLDB24
	.uleb128 0x1
	.uleb128 .LEHB30-.LCOLDB24
	.uleb128 .LEHE30-.LEHB30
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
	.size	math_prime_util__factor__u64_vectors__put_image, .-math_prime_util__factor__u64_vectors__put_image
	.section	.text.unlikely
	.size	math_prime_util__factor__u64_vectors__put_image.cold, .-math_prime_util__factor__u64_vectors__put_image.cold
.LCOLDE24:
	.text
.LHOTE24:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__vectorPI__2
	.type	math_prime_util__factor__u64_vectors__vectorPI__2, @function
math_prime_util__factor__u64_vectors__vectorPI__2:
.LFB167:
	.cfi_startproc
	jmp	math_prime_util__factor__u64_vectors__put_image
	.cfi_endproc
.LFE167:
	.size	math_prime_util__factor__u64_vectors__vectorPI__2, .-math_prime_util__factor__u64_vectors__vectorPI__2
	.section	.text.unlikely
	.align 2
.LCOLDB25:
	.text
.LHOTB25:
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD
	.type	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD, @function
math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD:
.LFB121:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA121
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
.LEHB31:
	call	*system__soft_links__enter_master(%rip)
	call	*system__soft_links__current_master(%rip)
	movq	(%rbx), %rax
	movq	-24(%rax), %rax
	movq	64(%rax), %rax
	testb	$1, %al
	jne	.L929
.L922:
	movl	$1, %esi
	movq	%rbx, %rdi
	call	*%rax
.LEHE31:
.LEHB32:
	call	*system__soft_links__abort_defer(%rip)
	call	*system__soft_links__complete_master(%rip)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE32:
.L929:
	.cfi_restore_state
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L922
.L924:
	movq	%rax, %rbx
	jmp	.L923
	.section	.gcc_except_table
.LLSDA121:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE121-.LLSDACSB121
.LLSDACSB121:
	.uleb128 .LEHB31-.LFB121
	.uleb128 .LEHE31-.LEHB31
	.uleb128 .L924-.LFB121
	.uleb128 0
	.uleb128 .LEHB32-.LFB121
	.uleb128 .LEHE32-.LEHB32
	.uleb128 0
	.uleb128 0
.LLSDACSE121:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC121
	.type	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold, @function
math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold:
.LFSB121:
.L923:
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
.LEHB33:
	call	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD__B20s___finalizer.12
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE33:
	.cfi_endproc
.LFE121:
	.section	.gcc_except_table
.LLSDAC121:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC121-.LLSDACSBC121
.LLSDACSBC121:
	.uleb128 .LEHB33-.LCOLDB25
	.uleb128 .LEHE33-.LEHB33
	.uleb128 0
	.uleb128 0
.LLSDACSEC121:
	.section	.text.unlikely
	.text
	.size	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD, .-math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD
	.section	.text.unlikely
	.size	math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold, .-math_prime_util__factor__u64_vectors__vector_iterator_interfaces__Treversible_iteratorCFD.cold
.LCOLDE25:
	.text
.LHOTE25:
	.section	.rodata
.LC26:
	.ascii	"a-cgcaso.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__factor__divisors__sort_buf__sort__sift.27, @function
math_prime_util__factor__divisors__sort_buf__sort__sift.27:
.LFB251:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdi, %rax
	movl	$4294967295, %r11d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%r10, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rbp, %rcx
	movabsq	$-9223372036854775808, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 64
	movq	24(%r10), %rdx
	movq	16(%r10), %r9
	movq	8(%r10), %rdi
	movabsq	$4611686018427387904, %r10
	movq	(%rdx), %r8
	movslq	12(%rdx), %rsi
	jmp	.L931
	.p2align 4,,10
	.p2align 3
.L953:
	leaq	1(%rdx), %rcx
	leal	1(%r14), %r13d
.L939:
	leaq	2147483647(%rax,%rsi), %rdx
	cmpq	%rdx, %r11
	jb	.L942
	movslq	%r13d, %r13
	leaq	-1(%rax,%rsi), %rax
	subq	%r8, %r13
	subq	%r8, %rax
	movq	(%rdi,%r13,8), %rdx
	movq	%rdx, (%rdi,%rax,8)
	movq	%rcx, %rdx
	movq	%rcx, %rax
	addq	%r10, %rdx
	js	.L951
.L931:
	leaq	(%rcx,%rcx), %rdx
	cmpq	%r9, %rdx
	jg	.L932
	movq	%rdx, %rcx
	addq	%rsi, %rcx
	jo	.L936
	cmpq	%rbx, %rcx
	je	.L936
	leaq	2147483647(%rcx), %r13
	cmpq	%r13, %r11
	jb	.L942
	leaq	-1(%rcx), %r14
	movl	%r14d, %r13d
	cmpq	%r9, %rdx
	jge	.L941
	cmpq	$2147483647, %r14
	je	.L952
	movq	%r14, %r15
	subq	%r8, %rcx
	subq	%r8, %r15
	movq	(%rdi,%rcx,8), %rcx
	cmpq	%rcx, (%rdi,%r15,8)
	jb	.L953
.L941:
	movq	%rdx, %rcx
	jmp	.L939
	.p2align 4,,10
	.p2align 3
.L932:
	cmpq	%rcx, %rbp
	je	.L944
	movq	(%r12), %r9
	movl	$4294967295, %r10d
	jmp	.L946
	.p2align 4,,10
	.p2align 3
.L955:
	cmpq	%rax, %r10
	jb	.L942
	subq	%r8, %rdx
	movq	%rbx, (%rdi,%rdx,8)
	cmpq	%rcx, %rbp
	je	.L954
.L946:
	movq	%rcx, %rax
	shrq	$63, %rcx
	addq	%rax, %rcx
	sarq	%rcx
	leaq	2147483647(%rcx,%rsi), %r11
	cmpq	%r11, %r10
	jb	.L942
	leaq	-1(%rcx,%rsi), %rdx
	subq	%r8, %rdx
	movq	(%rdi,%rdx,8), %rbx
	leaq	-1(%rax,%rsi), %rdx
	leaq	2147483647(%rax,%rsi), %rax
	cmpq	%r9, %rbx
	jb	.L955
.L945:
	shrq	$32, %rax
	jne	.L942
	movq	(%r12), %r9
.L947:
	subq	%r8, %rdx
	movq	%r9, (%rdi,%rdx,8)
	addq	$8, %rsp
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
	.p2align 4,,10
	.p2align 3
.L954:
	.cfi_restore_state
	leaq	-1(%rcx,%rsi), %rdx
	jmp	.L947
.L944:
	addq	%rsi, %rbp
	leaq	-1(%rbp), %rdx
	leaq	2147483647(%rbp), %rax
	jmp	.L945
.L942:
	movl	$51, %esi
	leaq	.LC26(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L936:
	movl	$49, %esi
	leaq	.LC26(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L951:
	movl	$67, %esi
	leaq	.LC26(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L952:
	movl	$76, %esi
	leaq	.LC26(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE251:
	.size	math_prime_util__factor__divisors__sort_buf__sort__sift.27, .-math_prime_util__factor__divisors__sort_buf__sort__sift.27
	.align 2
	.p2align 4
	.type	math_prime_util__factor__divisors__sort_buf.24, @function
math_prime_util__factor__divisors__sort_buf.24:
.LFB248:
	.cfi_startproc
	subq	$120, %rsp
	.cfi_def_cfa_offset 128
	movq	(%rsi), %xmm1
	leaq	128(%rsp), %rax
	movq	%rdi, 40(%rsp)
	movq	%rax, 16(%rsp)
	movd	%xmm1, %eax
	pshufd	$225, %xmm1, %xmm0
	cltq
	movd	%xmm0, %edx
	movq	%rsp, 56(%rsp)
	movq	%rax, (%rsp)
	movq	%xmm0, %rax
	shrq	$32, %rax
	movq	%xmm0, 8(%rsp)
	cmpl	%eax, %edx
	jl	.L956
	movslq	%edx, %rdx
	cltq
	movq	%rbx, 88(%rsp)
	subq	%rax, %rdx
	movq	%rbp, 96(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	leaq	1(%rdx), %rbx
	movq	%r12, 104(%rsp)
	movq	%r13, 112(%rsp)
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	cmpq	$1, %rbx
	jle	.L966
	movq	%rbx, %r13
	movq	%rdi, %r12
	movl	$4294967295, %ebp
	sarq	%r13
	addq	$1, %r13
	jmp	.L960
	.p2align 4,,10
	.p2align 3
.L964:
	movslq	12(%rsp), %rax
.L960:
	subq	$1, %r13
	leaq	2147483647(%rax,%r13), %rdx
	cmpq	%rdx, %rbp
	jb	.L961
	leaq	-1(%rax,%r13), %rax
	subq	(%rsp), %rax
	leaq	32(%rsp), %r10
	movq	%r13, %rdi
	movq	(%r12,%rax,8), %rax
	movq	%rbx, 48(%rsp)
	movq	%rax, 32(%rsp)
	call	math_prime_util__factor__divisors__sort_buf__sort__sift.27
	cmpq	$1, %r13
	jne	.L964
	movl	$4294967295, %ebp
	.p2align 4
	.p2align 3
.L959:
	movslq	12(%rsp), %rdx
	leaq	2147483647(%rdx,%rbx), %rcx
	cmpq	%rcx, %rbp
	jb	.L961
	movq	(%rsp), %rcx
	leaq	-1(%rdx,%rbx), %rax
	leaq	32(%rsp), %r10
	subq	$1, %rbx
	movl	$1, %edi
	movq	%rbx, 48(%rsp)
	subq	%rcx, %rdx
	subq	%rcx, %rax
	movq	(%r12,%rdx,8), %rdx
	movq	(%r12,%rax,8), %rsi
	movq	%rdx, (%r12,%rax,8)
	movq	%rsi, 32(%rsp)
	call	math_prime_util__factor__divisors__sort_buf__sort__sift.27
	cmpq	$1, %rbx
	jne	.L959
.L966:
	movq	88(%rsp), %rbx
	.cfi_restore 3
	movq	96(%rsp), %rbp
	.cfi_restore 6
	movq	104(%rsp), %r12
	.cfi_restore 12
	movq	112(%rsp), %r13
	.cfi_restore 13
.L956:
	addq	$120, %rsp
	.cfi_def_cfa_offset 8
	ret
.L961:
	.cfi_def_cfa_offset 128
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	movl	$51, %esi
	leaq	.LC26(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE248:
	.size	math_prime_util__factor__divisors__sort_buf.24, .-math_prime_util__factor__divisors__sort_buf.24
	.align 2
	.p2align 4
	.globl	math_prime_util__factor__u64_vectors__vectorDA__2
	.type	math_prime_util__factor__u64_vectors__vectorDA__2, @function
math_prime_util__factor__u64_vectors__vectorDA__2:
.LFB158:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rbx, 40(%rsp)
	.cfi_offset 3, -24
	movl	16(%rdi), %ebx
	testl	%ebx, %ebx
	jne	.L968
	movq	$0, 8(%rdi)
	movq	40(%rsp), %rbx
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L968:
	.cfi_restore_state
	movq	%r14, 48(%rsp)
	.cfi_offset 14, -16
	movslq	%ebx, %rdx
	movq	8(%rdi), %r14
	movl	$0, 16(%rdi)
	salq	$3, %rdx
	movq	$0, 8(%rdi)
	movq	%rdi, 24(%rsp)
	leaq	8(%rdx), %rdi
	movq	%rdx, 16(%rsp)
	call	__gnat_malloc@PLT
	movq	16(%rsp), %rdx
	leaq	8(%r14), %rsi
	movl	%ebx, (%rax)
	leaq	8(%rax), %rdi
	movq	%rax, 8(%rsp)
	call	memcpy@PLT
	movq	24(%rsp), %rcx
	movq	8(%rsp), %r8
	movq	48(%rsp), %r14
	.cfi_restore 14
	movl	%ebx, 16(%rcx)
	movq	40(%rsp), %rbx
	movq	%r8, 8(%rcx)
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE158:
	.size	math_prime_util__factor__u64_vectors__vectorDA__2, .-math_prime_util__factor__u64_vectors__vectorDA__2
	.align 2
	.p2align 4
	.type	math_prime_util__factor__c_trial.isra.0, @function
math_prime_util__factor__c_trial.isra.0:
.LFB403:
	.cfi_startproc
	movq	%rcx, %r8
	movl	$2, %ecx
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rsi, %r9
	cmpq	%rcx, %rsi
	cmovnb	%rsi, %rcx
	testq	%rdx, %rdx
	je	.L972
	movq	%rdx, %r11
	movq	%rdi, %rax
	xorl	%edx, %edx
	divq	%r11
	cmpq	%r11, %rax
	jnb	.L973
.L972:
	xorl	%eax, %eax
	movq	$-1, %r11
.L974:
	cmpq	$3, %rdi
	jbe	.L1012
	testb	%al, %al
	jne	.L1012
	cmpq	$2011, %r9
	jbe	.L1040
.L979:
	movabsq	$-8608480567731124087, %rax
	mulq	%rcx
	movq	%rcx, %rax
	shrq	$4, %rdx
	imulq	$30, %rdx, %rdx
	subq	%rdx, %rax
	cmpq	$2147483647, %rax
	ja	.L1041
	leaq	math_prime_util__factor__distance(%rip), %rdx
	addq	(%rdx,%rax,8), %rcx
	jc	.L1042
.L1000:
	cmpq	$1, %rdi
	jbe	.L1005
.L1047:
	xorl	%edx, %edx
	movq	%rdi, %rax
	divq	%rcx
	cmpq	%r11, %rax
	cmova	%r11, %rax
	cmpq	%rcx, %rax
	jnb	.L1043
	.p2align 4
	.p2align 3
.L1012:
	movl	(%r8), %eax
	cmpl	$2147483647, %eax
	je	.L1044
	addl	$1, %eax
	movl	%eax, (%r8)
	cltq
	movq	%rdi, (%r8,%rax,8)
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1040:
	.cfi_restore_state
	movq	%rbx, 40(%rsp)
	movq	%rbp, 48(%rsp)
	cmpq	$2, %r9
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	jbe	.L1045
.L982:
	cmpq	$2, %r11
	setne	%dl
	cmpq	$3, %r9
	setbe	%al
	testb	%al, %dl
	je	.L986
	movabsq	$-6148914691236517205, %r10
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, %rax
	andq	$-2, %rdx
	shrq	%rax
	addq	%rdx, %rax
	cmpq	%rax, %rdi
	jne	.L986
	movslq	(%r8), %rax
	movl	$2147483647, %ebx
	leal	1(%rax), %esi
	subl	%eax, %ebx
	leaq	(%r8,%rax,8), %rax
	movslq	%esi, %rsi
	movq	%rsi, %rdx
	addq	%rsi, %rbx
	negq	%rdx
	leaq	(%rax,%rdx,8), %rbp
	.p2align 6
	.p2align 4
	.p2align 3
.L988:
	cmpq	%rbx, %rsi
	je	.L983
	movq	%rdi, %rax
	movl	%esi, (%r8)
	movq	$3, 8(%rbp,%rsi,8)
	mulq	%r10
	addq	$1, %rsi
	movq	%rdx, %rdi
	shrq	%rdi
	movq	%rdi, %rax
	mulq	%r10
	movq	%rdx, %rax
	andq	$-2, %rdx
	shrq	%rax
	addq	%rax, %rdx
	cmpq	%rdi, %rdx
	je	.L988
.L986:
	cmpq	$4, %r11
	seta	%dl
	cmpq	$5, %r9
	setbe	%al
	testb	%al, %dl
	je	.L990
	movabsq	$-3689348814741910323, %r9
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rax
	andq	$-4, %rdx
	shrq	$2, %rax
	addq	%rdx, %rax
	cmpq	%rax, %rdi
	jne	.L990
	movslq	(%r8), %rax
	movl	$2147483647, %r10d
	leal	1(%rax), %esi
	subl	%eax, %r10d
	leaq	(%r8,%rax,8), %rax
	movslq	%esi, %rsi
	movq	%rsi, %rdx
	addq	%rsi, %r10
	negq	%rdx
	leaq	(%rax,%rdx,8), %rbx
	.p2align 6
	.p2align 4
	.p2align 3
.L992:
	cmpq	%r10, %rsi
	je	.L983
	movq	%rdi, %rax
	movl	%esi, (%r8)
	movq	$5, 8(%rbx,%rsi,8)
	mulq	%r9
	addq	$1, %rsi
	movq	%rdx, %rdi
	shrq	$2, %rdi
	movq	%rdi, %rax
	mulq	%r9
	movq	%rdx, %rax
	andq	$-4, %rdx
	shrq	$2, %rax
	addq	%rax, %rdx
	cmpq	%rdi, %rdx
	je	.L992
.L990:
	movl	$4, %eax
	leaq	-8+math_prime_util__factor__small(%rip), %rbp
	jmp	.L994
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L1046:
	addq	$1, %rax
	cmpq	$306, %rax
	je	.L1038
.L994:
	cmpq	%rcx, 0(%rbp,%rax,8)
	jb	.L1046
	movl	%eax, %r10d
	.p2align 4
	.p2align 3
.L999:
	movq	0(%rbp,%r10,8), %rcx
	movq	%rcx, %rax
	imulq	%rcx, %rax
	cmpq	%rax, %rdi
	jb	.L996
	cmpq	%rcx, %r11
	jb	.L996
	movq	%rdi, %rax
	xorl	%edx, %edx
	divq	%rcx
	testq	%rdx, %rdx
	jne	.L997
	movslq	(%r8), %rax
	movl	$2147483647, %ebx
	leal	1(%rax), %esi
	subl	%eax, %ebx
	leaq	(%r8,%rax,8), %rax
	movslq	%esi, %rsi
	movq	%rsi, %rdx
	addq	%rsi, %rbx
	negq	%rdx
	leaq	(%rax,%rdx,8), %r9
	.p2align 6
	.p2align 4
	.p2align 3
.L998:
	cmpq	%rbx, %rsi
	je	.L983
	movq	%rdi, %rax
	xorl	%edx, %edx
	movl	%esi, (%r8)
	divq	%rcx
	movq	%rcx, 8(%r9,%rsi,8)
	xorl	%edx, %edx
	addq	$1, %rsi
	movq	%rax, %rdi
	divq	%rcx
	testq	%rdx, %rdx
	je	.L998
.L997:
	addq	$1, %r10
	cmpl	$306, %r10d
	jne	.L999
.L1038:
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	48(%rsp), %rbp
	.cfi_restore 6
	movl	$2017, %ecx
	cmpq	$1, %rdi
	ja	.L1047
	.p2align 4
	.p2align 3
.L1005:
	cmpq	$1, %rdi
	jne	.L1012
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L973:
	.cfi_restore_state
	cmpq	%rcx, %r11
	setb	%al
	jmp	.L974
.L1042:
	cmpq	$1, %rdi
	ja	.L1012
	jmp	.L1005
.L1045:
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	testb	$1, %dil
	jne	.L982
	movslq	(%r8), %rsi
	movl	$2147483647, %edx
	leal	1(%rsi), %eax
	subl	%esi, %edx
	leaq	(%r8,%rsi,8), %rsi
	cltq
	movq	%rax, %r10
	addq	%rax, %rdx
	negq	%r10
	leaq	(%rsi,%r10,8), %rsi
	.p2align 5
	.p2align 4
	.p2align 3
.L984:
	cmpq	%rdx, %rax
	je	.L983
	shrq	%rdi
	movl	%eax, (%r8)
	movq	$2, 8(%rsi,%rax,8)
	addq	$1, %rax
	testb	$1, %dil
	je	.L984
	jmp	.L982
.L996:
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	48(%rsp), %rbp
	.cfi_restore 6
	cmpq	$2011, %rcx
	jbe	.L1000
	jmp	.L979
.L1043:
	movq	%rbp, 48(%rsp)
	movq	%r8, 24(%rsp)
	movq	%r11, 16(%rsp)
	movq	%rcx, 8(%rsp)
	movq	%rdi, (%rsp)
	.cfi_offset 6, -16
	call	math_prime_util__int__sqrtint@PLT
	movq	8(%rsp), %rcx
	movq	(%rsp), %rdi
	movabsq	$-8608480567731124087, %rdx
	movq	%rax, %rbp
	movq	16(%rsp), %r11
	movq	24(%rsp), %r8
	movq	%rcx, %rax
	mulq	%rdx
	movq	%rcx, %rax
	shrq	$4, %rdx
	imulq	$30, %rdx, %rdx
	subq	%rdx, %rax
	cmpq	$2147483647, %rax
	ja	.L1048
	cmpq	%rbp, %r11
	cmovbe	%r11, %rbp
	cmpq	%rcx, %rbp
	jb	.L1036
	movq	%rbx, 40(%rsp)
	leaq	math_prime_util__factor__next_w(%rip), %r11
	.cfi_offset 3, -24
	movl	%eax, %ebx
	jmp	.L1011
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L1009:
	movl	%ebx, %eax
	leaq	math_prime_util__factor__advance(%rip), %rbx
	addq	(%rbx,%rax,8), %rcx
	movl	(%r11,%rax,4), %ebx
	cmpq	%rcx, %rbp
	jb	.L1049
.L1011:
	movq	%rdi, %rax
	xorl	%edx, %edx
	divq	%rcx
	testq	%rdx, %rdx
	jne	.L1009
	movslq	(%r8), %rax
	movl	$2147483647, %r9d
	leal	1(%rax), %esi
	subl	%eax, %r9d
	leaq	(%r8,%rax,8), %rax
	movslq	%esi, %rsi
	movq	%rsi, %rdx
	addq	%rsi, %r9
	negq	%rdx
	leaq	(%rax,%rdx,8), %r10
	.p2align 6
	.p2align 4
	.p2align 3
.L1010:
	cmpq	%r9, %rsi
	je	.L983
	movq	%rdi, %rax
	xorl	%edx, %edx
	movl	%esi, (%r8)
	divq	%rcx
	movq	%rcx, 8(%r10,%rsi,8)
	xorl	%edx, %edx
	addq	$1, %rsi
	movq	%rax, %rdi
	divq	%rcx
	testq	%rdx, %rdx
	je	.L1010
	movq	%r8, 16(%rsp)
	movq	%rcx, 8(%rsp)
	movq	%rdi, (%rsp)
	call	math_prime_util__int__sqrtint@PLT
	movq	16(%rsp), %r8
	movq	(%rsp), %rdi
	leaq	math_prime_util__factor__next_w(%rip), %r11
	cmpq	%rax, %rbp
	movq	8(%rsp), %rcx
	cmova	%rax, %rbp
	jmp	.L1009
.L1049:
	movq	40(%rsp), %rbx
	.cfi_restore 3
	movq	48(%rsp), %rbp
	.cfi_restore 6
	jmp	.L1005
.L1044:
	movq	%rbx, 40(%rsp)
	movq	%rbp, 48(%rsp)
	.cfi_offset 3, -24
	.cfi_offset 6, -16
.L983:
	movl	$35, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1036:
	.cfi_restore 3
	movq	48(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	jmp	.L1012
.L1048:
	.cfi_restore_state
	movl	$282, %esi
	leaq	.LC13(%rip), %rdi
	movq	%rbx, 40(%rsp)
	.cfi_offset 3, -24
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1041:
	.cfi_restore 3
	.cfi_restore 6
	movl	$273, %esi
	leaq	.LC13(%rip), %rdi
	movq	%rbx, 40(%rsp)
	movq	%rbp, 48(%rsp)
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE403:
	.size	math_prime_util__factor__c_trial.isra.0, .-math_prime_util__factor__c_trial.isra.0
	.align 2
	.p2align 4
	.type	math_prime_util__factor__raw_brent, @function
math_prime_util__factor__raw_brent:
.LFB219:
	.cfi_startproc
	subq	$216, %rsp
	.cfi_def_cfa_offset 224
	movl	$4, %eax
	movq	%rdi, 144(%rsp)
	movq	%rdx, 88(%rsp)
	movq	%rbp, 176(%rsp)
	.cfi_offset 6, -48
	leaq	(%rsi,%rsi,2), %rbp
	movq	%rbx, 168(%rsp)
	xorq	$2, %rbp
	.cfi_offset 3, -56
	movq	%rcx, %rbx
	movq	%r13, 192(%rsp)
	.cfi_offset 13, -32
	movq	%rsi, %r13
.L1051:
	movq	%r13, %rcx
	movl	$2, %edx
	imulq	%rbp, %rcx
	subq	%rcx, %rdx
	imulq	%rdx, %rbp
	subl	$1, %eax
	jne	.L1051
	movl	$2, %esi
	movq	%r13, %rdi
	call	math_prime_util__int__logint@PLT
	movq	$32, 104(%rsp)
	addq	$1, %rax
	cmpq	$31, %rax
	jbe	.L1052
	movq	$64, 104(%rsp)
	cmpq	$35, %rax
	ja	.L1158
.L1052:
	cmpq	$0, 88(%rsp)
	je	.L1053
	movq	%r15, 208(%rsp)
	.cfi_offset 15, -16
	xorl	%r15d, %r15d
	xorl	%edi, %edi
	movq	%r13, %rdx
	movq	%r15, %rcx
	movl	$1, %esi
	negq	%rbp
	movq	%r12, 184(%rsp)
	movq	%r14, 200(%rsp)
	.cfi_offset 12, -40
	.cfi_offset 14, -24
	movq	%r13, %r14
	call	__umodti3@PLT
	movq	%r15, %rcx
	movq	%rax, %r12
	movq	%rax, 96(%rsp)
	mulq	%rbx
	movq	%r13, %rbx
	notq	%rbx
	shrq	$63, %rbx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r13, %rdx
	call	__umodti3@PLT
	movq	%rbp, (%rsp)
	movq	%r12, %rbp
	movl	$1, %r8d
	movq	%rax, 8(%rsp)
	movl	$11, %eax
	mulq	%r12
	movq	%rbx, 152(%rsp)
	movl	$6, 124(%rsp)
	movq	$1, 112(%rsp)
	movq	%rdx, 136(%rsp)
	movq	%rax, 128(%rsp)
	movq	%r12, %rax
	movq	%r13, %r12
	.p2align 4
	.p2align 3
.L1054:
	movq	88(%rsp), %rbx
	movq	112(%rsp), %r10
	movq	%rbp, 32(%rsp)
	movq	%r12, %r11
	movq	$0, 24(%rsp)
	cmpq	%r10, %rbx
	cmovbe	%rbx, %r10
	movq	8(%rsp), %rbx
	movq	%r10, 80(%rsp)
	movq	%rbx, 16(%rsp)
	movq	80(%rsp), %rbx
	testq	%rbx, %rbx
	je	.L1055
	.p2align 4
	.p2align 3
.L1164:
	movq	104(%rsp), %rdi
	movq	%rbx, %rax
	cmpq	%rbx, %rdi
	cmovbe	%rdi, %rax
	movq	%rax, 48(%rsp)
	testq	%r11, %r11
	jns	.L1159
	movq	8(%rsp), %rbx
	movq	32(%rsp), %rax
	cmpq	%rbx, 96(%rsp)
	je	.L1160
	mulq	%rax
	xorl	%edi, %edi
	xorl	%r9d, %r9d
	movq	%rax, %rcx
	movq	(%rsp), %rax
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	imulq	%rcx, %rax
	movq	%rbx, %rcx
	mulq	%r11
	addq	%rax, %rsi
	movq	%rdx, %rax
	adcq	%r9, %rdi
	xorl	%ebx, %ebx
	xorl	%edx, %edx
	movq	%rdi, %rsi
	xorl	%edi, %edi
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	addq	%rsi, %rcx
	adcq	%rdi, %rbx
	cmpq	%r14, %rcx
	movq	%rbx, %rax
	sbbq	%r15, %rax
	jc	.L1084
	movq	%rcx, %rax
	movq	$-1, %rdi
	movq	%rbx, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rdi
	movl	$0, %edi
	sbbq	%rdx, %rdi
	jc	.L1065
	subq	%r11, %rcx
.L1084:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rdx
	addq	%rcx, %rax
	adcq	$0, %rdx
	cmpq	%r14, %rax
	movq	%rdx, %rbx
	sbbq	%r15, %rbx
	jnc	.L1161
	movq	8(%rsp), %rax
	leaq	(%rcx,%rax), %r12
.L1086:
	movq	%r12, %rax
	movq	%rbp, %rcx
	subq	%rbp, %rax
	subq	%r12, %rcx
	cmpq	%r12, %rbp
	cmovnb	%rcx, %rax
	movq	%rax, %rbx
	movq	48(%rsp), %rax
	movq	%rbx, %r8
	movq	%rax, %r10
	cmpq	$1, %rax
	jne	.L1089
	jmp	.L1063
	.p2align 4,,10
	.p2align 3
.L1163:
	movq	%rcx, %rax
	movq	$-1, %rdi
	movq	%rbx, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rdi
	movl	$0, %edi
	sbbq	%rdx, %rdi
	jc	.L1065
	movq	%rcx, %r8
	subq	$1, %r10
	subq	%r11, %r8
	cmpq	$1, %r10
	je	.L1152
.L1089:
	movq	%r12, %rax
	xorl	%ebx, %ebx
	xorl	%edi, %edi
	mulq	%r12
	movq	%rax, %r12
	movq	(%rsp), %rax
	movq	%rdx, %r13
	movq	%r12, %rcx
	imulq	%r12, %rax
	movq	%r13, %r12
	mulq	%r11
	addq	%rax, %rcx
	movq	%rdx, %rax
	adcq	%rdi, %rbx
	xorl	%r13d, %r13d
	xorl	%edx, %edx
	movq	%rbx, %rcx
	xorl	%ebx, %ebx
	addq	%rax, %r12
	adcq	%rdx, %r13
	addq	%rcx, %r12
	adcq	%rbx, %r13
	cmpq	%r14, %r12
	movq	%r13, %rax
	sbbq	%r15, %rax
	jc	.L1091
	movq	%r12, %rax
	movq	%r13, %rdx
	movq	$-1, %rdi
	subq	%r14, %rax
	sbbq	%r15, %rdx
	xorl	%ebx, %ebx
	cmpq	%rax, %rdi
	sbbq	%rdx, %rbx
	jc	.L1065
	subq	%r11, %r12
.L1091:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rdx
	addq	%r12, %rax
	adcq	$0, %rdx
	cmpq	%r14, %rax
	movq	%rdx, %rbx
	sbbq	%r15, %rbx
	jnc	.L1162
	addq	8(%rsp), %r12
.L1093:
	movq	%r12, %rax
	movq	%rbp, %rcx
	subq	%rbp, %rax
	subq	%r12, %rcx
	cmpq	%r12, %rbp
	cmovb	%rax, %rcx
	movq	%r8, %rax
	xorl	%edi, %edi
	xorl	%r9d, %r9d
	mulq	%rcx
	movq	%rax, %rcx
	movq	(%rsp), %rax
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	imulq	%rcx, %rax
	movq	%rbx, %rcx
	mulq	%r11
	addq	%rax, %rsi
	movq	%rdx, %rax
	adcq	%r9, %rdi
	xorl	%ebx, %ebx
	xorl	%edx, %edx
	movq	%rdi, %rsi
	xorl	%edi, %edi
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	addq	%rsi, %rcx
	adcq	%rdi, %rbx
	cmpq	%r14, %rcx
	movq	%rbx, %rax
	sbbq	%r15, %rax
	jnc	.L1163
	subq	$1, %r10
	movq	%rcx, %r8
	cmpq	$1, %r10
	jne	.L1089
.L1152:
	movq	%r8, %rbx
.L1063:
	movq	48(%rsp), %rdi
	movq	%r11, %rsi
	subq	%rdi, 80(%rsp)
	subq	%rdi, 88(%rsp)
	movq	%rbx, %rdi
	movq	%r11, 48(%rsp)
	call	math_prime_util__int__gcd@PLT
	movq	48(%rsp), %r11
	movq	%rax, %r8
	movq	32(%rsp), %rax
	cmpq	$1, %r8
	jne	.L1153
	movq	80(%rsp), %rbx
	movq	%r12, 32(%rsp)
	testq	%rbx, %rbx
	jne	.L1164
.L1055:
	movq	%r11, %r12
	cmpq	$1, %r8
	jne	.L1122
	movq	32(%rsp), %rbp
	salq	112(%rsp)
.L1100:
	cmpq	$0, 88(%rsp)
	jne	.L1054
.L1156:
	movq	%r12, %r13
	movq	200(%rsp), %r14
	.cfi_restore 14
	movq	184(%rsp), %r12
	.cfi_restore 12
	movq	208(%rsp), %r15
	.cfi_restore 15
.L1053:
	movq	144(%rsp), %rbx
	movl	$520, %edx
	xorl	%esi, %esi
	movq	%rbx, %rdi
	call	memset@PLT
	movl	$1, (%rbx)
	movq	%r13, 8(%rbx)
.L1050:
	movq	144(%rsp), %rax
	movq	168(%rsp), %rbx
	movq	176(%rsp), %rbp
	movq	192(%rsp), %r13
	addq	$216, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1162:
	.cfi_def_cfa_offset 224
	.cfi_offset 12, -40
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r14, %rdx
	movq	%r15, %rcx
	movq	%r11, 72(%rsp)
	movq	%r10, 64(%rsp)
	movq	%r8, 56(%rsp)
	call	__umodti3@PLT
	movq	56(%rsp), %r8
	movq	64(%rsp), %r10
	movq	72(%rsp), %r11
	movq	%rax, %r12
	jmp	.L1093
	.p2align 4,,10
	.p2align 3
.L1160:
	movq	96(%rsp), %rbx
	xorl	%edi, %edi
	xorl	%r9d, %r9d
	leaq	(%rax,%rbx), %rcx
	mulq	%rcx
	movq	%rax, %rcx
	movq	(%rsp), %rax
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	imulq	%rcx, %rax
	movq	%rbx, %rcx
	mulq	%r11
	addq	%rax, %rsi
	movq	%rdx, %rax
	adcq	%r9, %rdi
	xorl	%ebx, %ebx
	xorl	%edx, %edx
	movq	%rdi, %rsi
	xorl	%edi, %edi
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	movq	%rcx, %r12
	addq	%rsi, %r12
	movq	%rbx, %r13
	adcq	%rdi, %r13
	cmpq	%r14, %r12
	movq	%r13, %rax
	sbbq	%r15, %rax
	jc	.L1073
	movq	%r12, %rax
	movq	$-1, %rbx
	movq	%r13, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rbx
	movl	$0, %ebx
	sbbq	%rdx, %rbx
	jc	.L1065
	subq	%r11, %r12
.L1073:
	movq	%r12, %rax
	movq	%rbp, %rcx
	subq	%r12, %rcx
	subq	%rbp, %rax
	cmpq	%r12, %rbp
	cmovnb	%rcx, %rax
	movq	%rax, %rbx
	movq	48(%rsp), %rax
	movq	%rbx, %rcx
	movq	%rax, %r10
	cmpq	$1, %rax
	jne	.L1076
	jmp	.L1063
	.p2align 4,,10
	.p2align 3
.L1165:
	movq	%rsi, %rax
	movq	$-1, %rbx
	movq	%rdi, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rbx
	movl	$0, %ebx
	sbbq	%rdx, %rbx
	jc	.L1065
	movq	%rsi, %r12
	subq	%r11, %r12
.L1078:
	movq	%r12, %rax
	movq	%rbp, %rdx
	subq	%rbp, %rax
	subq	%r12, %rdx
	cmpq	%r12, %rbp
	cmovb	%rax, %rdx
	movq	%rcx, %rax
	xorl	%edi, %edi
	xorl	%r9d, %r9d
	mulq	%rdx
	movq	%rax, %rcx
	movq	(%rsp), %rax
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	imulq	%rcx, %rax
	movq	%rbx, %rcx
	mulq	%r11
	addq	%rax, %rsi
	movq	%rdx, %rax
	adcq	%r9, %rdi
	xorl	%ebx, %ebx
	xorl	%edx, %edx
	movq	%rdi, %rsi
	xorl	%edi, %edi
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	addq	%rsi, %rcx
	adcq	%rdi, %rbx
	cmpq	%r14, %rcx
	movq	%rbx, %rax
	sbbq	%r15, %rax
	jc	.L1082
	movq	%rcx, %rax
	movq	$-1, %rdi
	movq	%rbx, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rdi
	movl	$0, %edi
	sbbq	%rdx, %rdi
	jc	.L1065
	subq	%r11, %rcx
.L1082:
	subq	$1, %r10
	cmpq	$1, %r10
	je	.L1150
.L1076:
	movq	8(%rsp), %rax
	xorl	%r9d, %r9d
	xorl	%r13d, %r13d
	addq	%r12, %rax
	mulq	%r12
	movq	%rax, %rsi
	movq	(%rsp), %rax
	movq	%rdx, %rdi
	movq	%rsi, %r8
	imulq	%rsi, %rax
	movq	%rdi, %rsi
	mulq	%r11
	addq	%rax, %r8
	movq	%rdx, %rax
	adcq	%r13, %r9
	xorl	%edi, %edi
	xorl	%edx, %edx
	movq	%r9, %r8
	xorl	%r9d, %r9d
	addq	%rax, %rsi
	adcq	%rdx, %rdi
	addq	%r8, %rsi
	adcq	%r9, %rdi
	cmpq	%r14, %rsi
	movq	%rdi, %rax
	sbbq	%r15, %rax
	jnc	.L1165
	movq	%rsi, %r12
	jmp	.L1078
	.p2align 4,,10
	.p2align 3
.L1150:
	movq	%rcx, %rbx
	jmp	.L1063
	.p2align 4,,10
	.p2align 3
.L1159:
	movq	32(%rsp), %rbx
	movq	8(%rsp), %rax
	addq	%rbx, %rax
	mulq	%rbx
	xorl	%ebx, %ebx
	movq	%rax, %r12
	movq	(%rsp), %rax
	movq	%rdx, %r13
	imulq	%r12, %rax
	mulq	%r11
	movq	%rax, %r8
	movq	%r12, %rax
	movq	%rdx, %r9
	xorl	%edx, %edx
	addq	%r8, %rax
	movq	%r13, %r12
	movq	%r9, %r8
	adcq	%rbx, %rdx
	xorl	%r13d, %r13d
	xorl	%r9d, %r9d
	movq	%rdx, %rax
	xorl	%edx, %edx
	addq	%r8, %r12
	adcq	%r9, %r13
	addq	%rax, %r12
	adcq	%rdx, %r13
	cmpq	%r14, %r12
	movq	%r13, %rax
	sbbq	%r15, %rax
	jc	.L1059
	movq	%r12, %rax
	movq	$-1, %rbx
	movq	%r13, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rbx
	movl	$0, %ebx
	sbbq	%rdx, %rbx
	jc	.L1065
	subq	%r11, %r12
.L1059:
	movq	%r12, %rax
	movq	%rbp, %rcx
	subq	%rbp, %rax
	subq	%r12, %rcx
	cmpq	%r12, %rbp
	cmovnb	%rcx, %rax
	movq	%rax, %rbx
	movq	48(%rsp), %rax
	movq	%rbx, %rsi
	movq	%rax, %r10
	cmpq	$1, %rax
	jne	.L1062
	jmp	.L1063
	.p2align 4,,10
	.p2align 3
.L1166:
	movq	%rcx, %rax
	movq	$-1, %rdi
	movq	%rbx, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rdi
	movl	$0, %edi
	sbbq	%rdx, %rdi
	jc	.L1065
	movq	%rcx, %r12
	subq	%r11, %r12
.L1066:
	movq	%r12, %rax
	movq	%rbp, %rdx
	subq	%rbp, %rax
	subq	%r12, %rdx
	cmpq	%r12, %rbp
	cmovb	%rax, %rdx
	movq	%rsi, %rax
	xorl	%r9d, %r9d
	xorl	%ebx, %ebx
	mulq	%rdx
	movq	%rax, %rsi
	movq	(%rsp), %rax
	movq	%rdx, %rdi
	movq	%rsi, %r8
	imulq	%rsi, %rax
	movq	%rdi, %rsi
	mulq	%r11
	addq	%rax, %r8
	movq	%rdx, %rax
	adcq	%rbx, %r9
	xorl	%edi, %edi
	xorl	%edx, %edx
	movq	%r9, %r8
	xorl	%r9d, %r9d
	addq	%rax, %rsi
	adcq	%rdx, %rdi
	addq	%r8, %rsi
	adcq	%r9, %rdi
	cmpq	%r14, %rsi
	movq	%rdi, %rax
	sbbq	%r15, %rax
	jc	.L1070
	movq	%rsi, %rax
	movq	$-1, %rbx
	movq	%rdi, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rbx
	movl	$0, %ebx
	sbbq	%rdx, %rbx
	jc	.L1065
	subq	%r11, %rsi
.L1070:
	subq	$1, %r10
	cmpq	$1, %r10
	je	.L1148
.L1062:
	movq	8(%rsp), %rax
	xorl	%r9d, %r9d
	xorl	%r13d, %r13d
	addq	%r12, %rax
	mulq	%r12
	movq	%rax, %rcx
	movq	(%rsp), %rax
	movq	%rdx, %rbx
	movq	%rcx, %r8
	imulq	%rcx, %rax
	movq	%rbx, %rcx
	mulq	%r11
	addq	%rax, %r8
	movq	%rdx, %rax
	adcq	%r13, %r9
	xorl	%ebx, %ebx
	xorl	%edx, %edx
	movq	%r9, %r8
	xorl	%r9d, %r9d
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	addq	%r8, %rcx
	adcq	%r9, %rbx
	cmpq	%r14, %rcx
	movq	%rbx, %rax
	sbbq	%r15, %rax
	jnc	.L1166
	movq	%rcx, %r12
	jmp	.L1066
	.p2align 4,,10
	.p2align 3
.L1148:
	movq	%rsi, %rbx
	jmp	.L1063
	.p2align 4,,10
	.p2align 3
.L1161:
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r14, %rdx
	movq	%r15, %rcx
	movq	%r11, 56(%rsp)
	call	__umodti3@PLT
	movq	56(%rsp), %r11
	movq	%rax, %r12
	jmp	.L1086
	.p2align 4,,10
	.p2align 3
.L1153:
	movq	%r11, %r12
	movq	32(%rsp), %r11
	cmpq	%r8, %r12
	je	.L1167
.L1101:
	testq	%r8, %r8
	je	.L1123
	cmpq	%r12, %r8
	jne	.L1111
.L1123:
	movl	124(%rsp), %eax
	testl	%eax, %eax
	je	.L1156
	subl	$1, %eax
	movq	136(%rsp), %rdx
	movq	%r15, %rcx
	movq	%r11, 16(%rsp)
	movl	%eax, 124(%rsp)
	movq	128(%rsp), %rax
	movq	%rdx, %rsi
	movq	%r14, %rdx
	movq	%r8, 32(%rsp)
	movq	%rax, %rdi
	call	__umodti3@PLT
	movq	16(%rsp), %r11
	movq	32(%rsp), %r8
	movq	%rax, %rcx
	movq	%rdx, %rbx
	addq	8(%rsp), %rcx
	adcq	$0, %rbx
	cmpq	%r14, %rcx
	movq	%rbx, %rdi
	sbbq	%r15, %rdi
	jnc	.L1168
	addq	%rax, 8(%rsp)
	movq	96(%rsp), %rbp
	movq	%r11, %rax
	jmp	.L1100
.L1168:
	movq	%rcx, %rdi
	movq	%rbx, %rsi
	movq	%r14, %rdx
	movq	%r15, %rcx
	call	__umodti3@PLT
	movq	96(%rsp), %rbp
	movq	32(%rsp), %r8
	movq	%rax, 8(%rsp)
	movq	16(%rsp), %rax
	jmp	.L1100
.L1122:
	movq	%rax, %r11
	cmpq	%r8, %r12
	jne	.L1101
.L1167:
	movq	8(%rsp), %rdi
	cmpq	%rdi, 96(%rsp)
	movq	%r11, 48(%rsp)
	movq	%r11, %rbx
	sete	%al
	orb	152(%rsp), %al
	movq	112(%rsp), %r13
	movq	$0, 40(%rsp)
	movq	%rdi, 32(%rsp)
	movb	%al, 16(%rsp)
	jmp	.L1110
	.p2align 4,,10
	.p2align 3
.L1169:
	movq	8(%rsp), %rax
	xorl	%edi, %edi
	xorl	%r9d, %r9d
	addq	%rbx, %rax
	mulq	%rbx
	movq	%rax, %rcx
	movq	(%rsp), %rax
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	imulq	%rcx, %rax
	movq	%rbx, %rcx
	mulq	%r12
	addq	%rax, %rsi
	movq	%rdx, %rax
	adcq	%r9, %rdi
	xorl	%ebx, %ebx
	xorl	%edx, %edx
	movq	%rdi, %rsi
	xorl	%edi, %edi
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	addq	%rsi, %rcx
	adcq	%rdi, %rbx
	cmpq	%r14, %rcx
	movq	%rbx, %rax
	sbbq	%r15, %rax
	jc	.L1103
	movq	%rcx, %rax
	movq	$-1, %rdi
	movq	%rbx, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rdi
	movl	$0, %edi
	sbbq	%rdx, %rdi
	jc	.L1065
	movq	%rcx, %rbx
	subq	%r12, %rbx
.L1104:
	movq	%rbx, %rax
	movq	%rbp, %rdi
	movq	%r12, %rsi
	subq	%rbp, %rax
	subq	%rbx, %rdi
	cmpq	%rbx, %rbp
	cmovb	%rax, %rdi
	call	math_prime_util__int__gcd@PLT
	cmpq	$1, %rax
	jne	.L1155
	testq	%r13, %r13
	je	.L1155
	subq	$1, %r13
.L1110:
	cmpb	$0, 16(%rsp)
	jne	.L1169
	movq	%rbx, %rax
	xorl	%edi, %edi
	xorl	%r9d, %r9d
	mulq	%rbx
	movq	%rax, %rcx
	movq	(%rsp), %rax
	movq	%rdx, %rbx
	movq	%rcx, %rsi
	imulq	%rcx, %rax
	movq	%rbx, %rcx
	mulq	%r12
	addq	%rax, %rsi
	movq	%rdx, %rax
	adcq	%r9, %rdi
	xorl	%ebx, %ebx
	xorl	%edx, %edx
	movq	%rdi, %rsi
	xorl	%edi, %edi
	addq	%rax, %rcx
	adcq	%rdx, %rbx
	addq	%rsi, %rcx
	adcq	%rdi, %rbx
	cmpq	%r14, %rcx
	movq	%rbx, %rax
	sbbq	%r15, %rax
	jc	.L1106
	movq	%rcx, %rax
	movq	$-1, %rdi
	movq	%rbx, %rdx
	subq	%r14, %rax
	sbbq	%r15, %rdx
	cmpq	%rax, %rdi
	movl	$0, %edi
	sbbq	%rdx, %rdi
	jc	.L1065
	subq	%r12, %rcx
.L1106:
	movq	32(%rsp), %rax
	movq	40(%rsp), %rdx
	addq	%rcx, %rax
	adcq	$0, %rdx
	cmpq	%r14, %rax
	movq	%rdx, %rbx
	sbbq	%r15, %rbx
	jnc	.L1170
	movq	8(%rsp), %rax
	leaq	(%rcx,%rax), %rbx
	jmp	.L1104
.L1103:
	movq	%rcx, %rbx
	jmp	.L1104
.L1170:
	movq	%rdx, %rsi
	movq	%rax, %rdi
	movq	%r14, %rdx
	movq	%r15, %rcx
	call	__umodti3@PLT
	movq	%rax, %rbx
	jmp	.L1104
.L1155:
	movq	%r13, 112(%rsp)
	movq	48(%rsp), %r11
	movq	%rax, %r8
	jmp	.L1101
.L1158:
	.cfi_restore 12
	.cfi_restore 14
	.cfi_restore 15
	movq	$160, 104(%rsp)
	cmpq	$40, %rax
	jbe	.L1052
	cmpq	$53, %rax
	sbbq	%rax, %rax
	andq	$-64, %rax
	addq	$320, %rax
	movq	%rax, 104(%rsp)
	jmp	.L1052
.L1065:
	.cfi_offset 12, -40
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	$151, %esi
	leaq	.LC13(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1111:
	movq	144(%rsp), %rdi
	movq	%r12, %rsi
	movq	%r8, %rdx
	call	math_prime_util__factor__found
	movq	184(%rsp), %r12
	.cfi_restore 12
	movq	200(%rsp), %r14
	.cfi_restore 14
	movq	208(%rsp), %r15
	.cfi_restore 15
	jmp	.L1050
	.cfi_endproc
.LFE219:
	.size	math_prime_util__factor__raw_brent, .-math_prime_util__factor__raw_brent
	.align 2
	.p2align 4
	.type	math_prime_util__factor__prepare, @function
math_prime_util__factor__prepare:
.LFB215:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$520, %edx
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rsi, %rbx
	xorl	%esi, %esi
	subq	$1072, %rsp
	.cfi_def_cfa_offset 1104
	leaq	544(%rsp), %rdi
	call	memset@PLT
	testq	%rbx, %rbx
	jne	.L1172
	movl	$520, %edx
	xorl	%esi, %esi
	leaq	16(%rsp), %rdi
	movl	$1, %r12d
	call	memset@PLT
	movl	$1, %r8d
	movq	%rax, %rcx
.L1173:
	movq	%rbp, %rdi
	movl	$520, %edx
	movq	%rcx, %rsi
	movq	%rbx, 24(%rsp)
	movl	%r8d, 16(%rsp)
	call	memcpy@PLT
	movq	%r12, 520(%rbp)
	addq	$1072, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1172:
	.cfi_restore_state
	leaq	544(%rsp), %rdx
	movl	$1, %eax
	testb	$1, %bl
	jne	.L1196
	.p2align 5
	.p2align 4
	.p2align 3
.L1177:
	shrq	%rbx
	movq	$2, 8(%rdx)
	movq	%rax, %r8
	addq	$8, %rdx
	addq	$1, %rax
	testb	$1, %bl
	je	.L1177
.L1178:
	movabsq	$-6148914691236517205, %rdi
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rdx, %rax
	andq	$-2, %rdx
	shrq	%rax
	addq	%rax, %rdx
	cmpq	%rbx, %rdx
	jne	.L1176
	leal	1(%r8), %ecx
	movl	$2147483647, %r9d
	subl	%r8d, %r9d
	movq	%rcx, %rdx
	movl	%r8d, %r8d
	leaq	544(%rsp,%r8,8), %rax
	negq	%rdx
	addq	%rcx, %r9
	leaq	(%rax,%rdx,8), %rsi
	jmp	.L1182
	.p2align 6
	.p2align 4,,10
	.p2align 3
.L1186:
	addq	$1, %rcx
.L1182:
	cmpq	%r9, %rcx
	je	.L1181
	movq	$3, 8(%rsi,%rcx,8)
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rdx, %rbx
	shrq	%rbx
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rdx, %rax
	andq	$-2, %rdx
	shrq	%rax
	addq	%rax, %rdx
	cmpq	%rbx, %rdx
	je	.L1186
	movl	%ecx, %r8d
.L1176:
	movabsq	$-3689348814741910323, %rdi
	movq	%rbx, %rax
	mulq	%rdi
	movq	%rdx, %rax
	andq	$-4, %rdx
	shrq	$2, %rax
	addq	%rax, %rdx
	cmpq	%rbx, %rdx
	jne	.L1180
	leal	1(%r8), %e