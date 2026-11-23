	.file	"math_prime_util-count-lmo.adb"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__is_empty
	.type	math_prime_util__count__lmo__storage__word_holders__is_empty, @function
math_prime_util__count__lmo__storage__word_holders__is_empty:
.LFB17:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	sete	%al
	ret
	.cfi_endproc
.LFE17:
	.size	math_prime_util__count__lmo__storage__word_holders__is_empty, .-math_prime_util__count__lmo__storage__word_holders__is_empty
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__is_empty
	.type	math_prime_util__count__lmo__storage__factor_holders__is_empty, @function
math_prime_util__count__lmo__storage__factor_holders__is_empty:
.LFB53:
	.cfi_startproc
	cmpq	$0, 8(%rdi)
	sete	%al
	ret
	.cfi_endproc
.LFE53:
	.size	math_prime_util__count__lmo__storage__factor_holders__is_empty, .-math_prime_util__count__lmo__storage__factor_holders__is_empty
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders___size__3
	.type	math_prime_util__count__lmo__storage__word_holders___size__3, @function
math_prime_util__count__lmo__storage__word_holders___size__3:
.LFB82:
	.cfi_startproc
	movl	$192, %eax
	ret
	.cfi_endproc
.LFE82:
	.size	math_prime_util__count__lmo__storage__word_holders___size__3, .-math_prime_util__count__lmo__storage__word_holders___size__3
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders___size__4
	.type	math_prime_util__count__lmo__storage__word_holders___size__4, @function
math_prime_util__count__lmo__storage__word_holders___size__4:
.LFB92:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE92:
	.size	math_prime_util__count__lmo__storage__word_holders___size__4, .-math_prime_util__count__lmo__storage__word_holders___size__4
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__Oeq__2
	.type	math_prime_util__count__lmo__storage__word_holders__Oeq__2, @function
math_prime_util__count__lmo__storage__word_holders__Oeq__2:
.LFB2:
	.cfi_startproc
	movq	8(%rdi), %rcx
	movq	8(%rsi), %rsi
	cmpq	%rsi, %rcx
	je	.L18
	testq	%rcx, %rcx
	setne	%al
	testq	%rsi, %rsi
	setne	%dl
	andb	%dl, %al
	je	.L26
	movq	16(%rcx), %rdi
	movq	16(%rsi), %r9
	movslq	4(%rdi), %rdx
	movslq	(%rdi), %r8
	movslq	4(%r9), %rdi
	movslq	(%r9), %r9
	cmpl	%r8d, %edx
	jge	.L9
	cmpl	%r9d, %edi
	jge	.L28
.L26:
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	addq	$1, %rdx
	subq	%r8, %rdx
	cmpl	%r9d, %edi
	jge	.L12
	testq	%rdx, %rdx
	je	.L14
.L15:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L18:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L12:
	addq	$1, %rdi
	subq	%r9, %rdi
	cmpq	%rdx, %rdi
	jne	.L15
.L14:
	salq	$3, %rdx
.L17:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	8(%rsi), %rsi
	movq	8(%rcx), %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L28:
	addq	$1, %rdi
	cmpq	%rdi, %r9
	jne	.L15
	xorl	%edx, %edx
	jmp	.L17
	.cfi_endproc
.LFE2:
	.size	math_prime_util__count__lmo__storage__word_holders__Oeq__2, .-math_prime_util__count__lmo__storage__word_holders__Oeq__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__Oeq__2
	.type	math_prime_util__count__lmo__storage__factor_holders__Oeq__2, @function
math_prime_util__count__lmo__storage__factor_holders__Oeq__2:
.LFB38:
	.cfi_startproc
	movq	8(%rdi), %rcx
	movq	8(%rsi), %rsi
	cmpq	%rsi, %rcx
	je	.L41
	testq	%rcx, %rcx
	setne	%al
	testq	%rsi, %rsi
	setne	%dl
	andb	%dl, %al
	je	.L49
	movq	16(%rcx), %rdi
	movq	16(%rsi), %r9
	movslq	4(%rdi), %rdx
	movslq	(%rdi), %r8
	movslq	4(%r9), %rdi
	movslq	(%r9), %r9
	cmpl	%r8d, %edx
	jge	.L32
	cmpl	%r9d, %edi
	jge	.L51
.L49:
	ret
	.p2align 4,,10
	.p2align 3
.L32:
	addq	$1, %rdx
	subq	%r8, %rdx
	cmpl	%r9d, %edi
	jge	.L35
	testq	%rdx, %rdx
	je	.L37
.L38:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L41:
	movl	$1, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L35:
	addq	$1, %rdi
	subq	%r9, %rdi
	cmpq	%rdx, %rdi
	jne	.L38
.L37:
	addq	%rdx, %rdx
.L40:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	8(%rsi), %rsi
	movq	8(%rcx), %rdi
	call	memcmp@PLT
	testl	%eax, %eax
	sete	%al
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L51:
	addq	$1, %rdi
	cmpq	%rdi, %r9
	jne	.L38
	xorl	%edx, %edx
	jmp	.L40
	.cfi_endproc
.LFE38:
	.size	math_prime_util__count__lmo__storage__factor_holders__Oeq__2, .-math_prime_util__count__lmo__storage__factor_holders__Oeq__2
	.section	.rodata
.LC20:
	.ascii	"math_prime_util-count-lmo.adb"
	.zero	1
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__compute__B_12__sieve_phi.26, @function
math_prime_util__count__lmo__compute__B_12__sieve_phi.26:
.LFB194:
	.cfi_startproc
	leaq	1(%rdi), %rcx
	subq	8(%r10), %rcx
	movq	%rcx, %rax
	shrq	$32, %rax
	jne	.L57
	shrq	%rcx
	movq	$-1, %rax
	movl	%ecx, %esi
	salq	%cl, %rax
	movabsq	$6148914691236517205, %rcx
	sarl	$6, %esi
	notq	%rax
	andq	48(%r10,%rsi,8), %rax
	movq	%rax, %rdx
	shrq	%rdx
	andq	%rcx, %rdx
	movabsq	$3689348814741910323, %rcx
	subq	%rdx, %rax
	movq	%rax, %rdx
	shrq	$2, %rax
	andq	%rcx, %rdx
	andq	%rcx, %rax
	movabsq	$1085102592571150095, %rcx
	addq	%rdx, %rax
	movq	%rax, %rdx
	shrq	$4, %rdx
	addq	%rax, %rdx
	movslq	120180(%r10,%rsi,4), %rax
	addq	32(%r10), %rax
	andq	%rcx, %rdx
	movabsq	$72340172838076673, %rcx
	imulq	%rcx, %rdx
	shrq	$56, %rdx
	addq	%rdx, %rax
	ret
.L57:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$238, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE194:
	.size	math_prime_util__count__lmo__compute__B_12__sieve_phi.26, .-math_prime_util__count__lmo__compute__B_12__sieve_phi.26
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__word_holders__copy__B778b__R786b___finalizer.3, @function
math_prime_util__count__lmo__storage__word_holders__copy__B778b__R786b___finalizer.3:
.LFB12:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%r10, %rbx
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbx, %rdi
	leaq	math_prime_util__count__lmo__storage__word_holders__holderFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
	.cfi_endproc
.LFE12:
	.size	math_prime_util__count__lmo__storage__word_holders__copy__B778b__R786b___finalizer.3, .-math_prime_util__count__lmo__storage__word_holders__copy__B778b__R786b___finalizer.3
	.set	math_prime_util__count__lmo__storage__word_holders__holderSI__R47b___finalizer__2Xnn.16,math_prime_util__count__lmo__storage__word_holders__copy__B778b__R786b___finalizer.3
	.set	math_prime_util__count__lmo__storage__word_holders__to_holder__R912b___finalizer.7,math_prime_util__count__lmo__storage__word_holders__copy__B778b__R786b___finalizer.3
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__factor_holders__copy__B1007b__R1015b___finalizer.11, @function
math_prime_util__count__lmo__storage__factor_holders__copy__B1007b__R1015b___finalizer.11:
.LFB48:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%r10, %rbx
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbx, %rdi
	leaq	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	*system__soft_links__abort_undefer(%rip)
	.cfi_endproc
.LFE48:
	.size	math_prime_util__count__lmo__storage__factor_holders__copy__B1007b__R1015b___finalizer.11, .-math_prime_util__count__lmo__storage__factor_holders__copy__B1007b__R1015b___finalizer.11
	.set	math_prime_util__count__lmo__storage__factor_holders__holderSI__R327b___finalizer__2Xnn.20,math_prime_util__count__lmo__storage__factor_holders__copy__B1007b__R1015b___finalizer.11
	.set	math_prime_util__count__lmo__storage__factor_holders__to_holder__R1141b___finalizer.15,math_prime_util__count__lmo__storage__factor_holders__copy__B1007b__R1015b___finalizer.11
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC21:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Element: container is empty"
	.section	.rodata
	.align 8
.LC2:
	.long	1
	.long	74
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__element
	.type	math_prime_util__count__lmo__storage__word_holders__element, @function
math_prime_util__count__lmo__storage__word_holders__element:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L69
	movq	16(%rax), %rax
	movq	%rdi, %rbp
	movl	$8, %edi
	movslq	(%rax), %rsi
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%rsi, %rax
	leaq	16(,%rax,8), %rax
	cmpl	%edx, %esi
	movl	$8, %esi
	cmovle	%rax, %rdi
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rax, %rbx
	movq	8(%rbp), %rax
	movq	16(%rax), %rdx
	movq	8(%rax), %rdi
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %ecx
	movq	%xmm0, (%rbx)
	movslq	%esi, %r8
	movslq	%ecx, %rax
	subq	%r8, %rax
	cmpl	%ecx, %esi
	movq	%rdi, %rsi
	leaq	8(,%rax,8), %rax
	leaq	8(%rbx), %rdi
	cmovle	%rax, %rdx
	call	memcpy@PLT
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbx, %rdx
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L69:
	.cfi_restore_state
	leaq	.LC21(%rip), %rsi
	leaq	.LC2(%rip), %rdx
	leaq	constraint_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE14:
	.size	math_prime_util__count__lmo__storage__word_holders__element, .-math_prime_util__count__lmo__storage__word_holders__element
	.section	.rodata.str1.8
	.align 8
.LC22:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Element: container is empty"
	.section	.rodata
	.align 8
.LC6:
	.long	1
	.long	76
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__element
	.type	math_prime_util__count__lmo__storage__factor_holders__element, @function
math_prime_util__count__lmo__storage__factor_holders__element:
.LFB50:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L77
	movq	16(%rax), %rax
	movq	%rdi, %rbp
	movl	$8, %edi
	movslq	(%rax), %rsi
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%rsi, %rax
	leaq	13(%rax,%rax), %rax
	andq	$-4, %rax
	cmpl	%edx, %esi
	movl	$4, %esi
	cmovle	%rax, %rdi
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rax, %rbx
	movq	8(%rbp), %rax
	movq	16(%rax), %rdx
	movq	8(%rax), %rdi
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %ecx
	movq	%xmm0, (%rbx)
	movslq	%esi, %r8
	movslq	%ecx, %rax
	subq	%r8, %rax
	cmpl	%ecx, %esi
	movq	%rdi, %rsi
	leaq	2(%rax,%rax), %rax
	leaq	8(%rbx), %rdi
	cmovle	%rax, %rdx
	call	memcpy@PLT
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rbx, %rdx
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L77:
	.cfi_restore_state
	leaq	.LC22(%rip), %rsi
	leaq	.LC6(%rip), %rdx
	leaq	constraint_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE50:
	.size	math_prime_util__count__lmo__storage__factor_holders__element, .-math_prime_util__count__lmo__storage__factor_holders__element
	.section	.rodata.str1.8
	.align 8
.LC23:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Query_Element: container is empty"
	.section	.rodata
.LC24:
	.ascii	"a-coinho.adb"
	.zero	1
	.align 8
.LC5:
	.long	1
	.long	80
	.section	.text.unlikely,"ax",@progbits
	.align 2
.LCOLDB25:
	.text
.LHOTB25:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__query_element
	.type	math_prime_util__count__lmo__storage__word_holders__query_element, @function
math_prime_util__count__lmo__storage__word_holders__query_element:
.LFB19:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA19
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rdx
	movq	%rbx, (%rsp)
	testq	%rdx, %rdx
	.cfi_offset 3, -32
	je	.L93
	movl	16(%rdi), %eax
	movq	%rdi, %rbx
	cmpl	$2147483647, %eax
	je	.L94
	addl	$1, %eax
	movl	%eax, 16(%rdi)
	movq	%rsi, %rax
	movq	8(%rdx), %rdi
	movq	16(%rdx), %rdx
	testb	$1, %al
	jne	.L95
.L81:
	movq	%rdx, %rsi
.LEHB0:
	call	*%rax
.LEHE0:
	subl	$1, 16(%rbx)
	movq	(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
.L93:
	.cfi_restore_state
	leaq	.LC23(%rip), %rsi
	leaq	.LC5(%rip), %rdx
	movq	%r14, 8(%rsp)
	leaq	constraint_error(%rip), %rdi
	movq	%r15, 16(%rsp)
.LEHB1:
	.cfi_remember_state
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__gnat_raise_exception@PLT
.L95:
	.cfi_restore_state
	movq	-1(%rsi), %r10
	movq	7(%rsi), %rax
	jmp	.L81
.L94:
	movl	$306, %esi
	leaq	.LC24(%rip), %rdi
	movq	%r14, 8(%rsp)
	movq	%r15, 16(%rsp)
	.cfi_remember_state
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE1:
.L85:
	.cfi_restore_state
	movq	%r14, 8(%rsp)
	.cfi_offset 14, -24
	movq	%rax, %r14
	jmp	.L82
	.section	.gcc_except_table,"a",@progbits
	.align 4
.LLSDA19:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT19-.LLSDATTD19
.LLSDATTD19:
	.byte	0x1
	.uleb128 .LLSDACSE19-.LLSDACSB19
.LLSDACSB19:
	.uleb128 .LEHB0-.LFB19
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L85-.LFB19
	.uleb128 0x1
	.uleb128 .LEHB1-.LFB19
	.uleb128 .LEHE1-.LEHB1
	.uleb128 0
	.uleb128 0
.LLSDACSE19:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT19:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC19
	.type	math_prime_util__count__lmo__storage__word_holders__query_element.cold, @function
math_prime_util__count__lmo__storage__word_holders__query_element.cold:
.LFSB19:
.L82:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 14, -24
	subq	$1, %rdx
	movq	%r15, 16(%rsp)
	.cfi_offset 15, -16
	movq	%rax, %rdi
	jne	.L92
	call	__gnat_begin_handler_v1@PLT
	subl	$1, 16(%rbx)
	movq	%r14, %rdi
	movq	%rax, %r15
.LEHB2:
	call	__gnat_reraise_zcx@PLT
.LEHE2:
.L86:
	movq	%rax, %rbx
	movq	%r14, %rdi
	movq	%rax, %rdx
	movq	%r15, %rsi
.LEHB3:
	call	__gnat_end_handler_v1@PLT
	movq	%rbx, %rdi
.L92:
	call	_Unwind_Resume@PLT
.LEHE3:
	.cfi_endproc
.LFE19:
	.section	.gcc_except_table
	.align 4
.LLSDAC19:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC19-.LLSDATTDC19
.LLSDATTDC19:
	.byte	0x1
	.uleb128 .LLSDACSEC19-.LLSDACSBC19
.LLSDACSBC19:
	.uleb128 .LEHB2-.LCOLDB25
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L86-.LCOLDB25
	.uleb128 0
	.uleb128 .LEHB3-.LCOLDB25
	.uleb128 .LEHE3-.LEHB3
	.uleb128 0
	.uleb128 0
.LLSDACSEC19:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC19:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__query_element, .-math_prime_util__count__lmo__storage__word_holders__query_element
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__query_element.cold, .-math_prime_util__count__lmo__storage__word_holders__query_element.cold
.LCOLDE25:
	.text
.LHOTE25:
	.section	.rodata.str1.8
	.align 8
.LC26:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Query_Element: container is empty"
	.section	.rodata
	.align 8
.LC12:
	.long	1
	.long	82
	.section	.text.unlikely
	.align 2
.LCOLDB27:
	.text
.LHOTB27:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__query_element
	.type	math_prime_util__count__lmo__storage__factor_holders__query_element, @function
math_prime_util__count__lmo__storage__factor_holders__query_element:
.LFB55:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA55
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rdx
	movq	%rbx, (%rsp)
	testq	%rdx, %rdx
	.cfi_offset 3, -32
	je	.L111
	movl	16(%rdi), %eax
	movq	%rdi, %rbx
	cmpl	$2147483647, %eax
	je	.L112
	addl	$1, %eax
	movl	%eax, 16(%rdi)
	movq	%rsi, %rax
	movq	8(%rdx), %rdi
	movq	16(%rdx), %rdx
	testb	$1, %al
	jne	.L113
.L99:
	movq	%rdx, %rsi
.LEHB4:
	call	*%rax
.LEHE4:
	subl	$1, 16(%rbx)
	movq	(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
.L111:
	.cfi_restore_state
	leaq	.LC26(%rip), %rsi
	leaq	.LC12(%rip), %rdx
	movq	%r14, 8(%rsp)
	leaq	constraint_error(%rip), %rdi
	movq	%r15, 16(%rsp)
.LEHB5:
	.cfi_remember_state
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__gnat_raise_exception@PLT
.L113:
	.cfi_restore_state
	movq	-1(%rsi), %r10
	movq	7(%rsi), %rax
	jmp	.L99
.L112:
	movl	$306, %esi
	leaq	.LC24(%rip), %rdi
	movq	%r14, 8(%rsp)
	movq	%r15, 16(%rsp)
	.cfi_remember_state
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE5:
.L103:
	.cfi_restore_state
	movq	%r14, 8(%rsp)
	.cfi_offset 14, -24
	movq	%rax, %r14
	jmp	.L100
	.section	.gcc_except_table
	.align 4
.LLSDA55:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT55-.LLSDATTD55
.LLSDATTD55:
	.byte	0x1
	.uleb128 .LLSDACSE55-.LLSDACSB55
.LLSDACSB55:
	.uleb128 .LEHB4-.LFB55
	.uleb128 .LEHE4-.LEHB4
	.uleb128 .L103-.LFB55
	.uleb128 0x1
	.uleb128 .LEHB5-.LFB55
	.uleb128 .LEHE5-.LEHB5
	.uleb128 0
	.uleb128 0
.LLSDACSE55:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT55:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC55
	.type	math_prime_util__count__lmo__storage__factor_holders__query_element.cold, @function
math_prime_util__count__lmo__storage__factor_holders__query_element.cold:
.LFSB55:
.L100:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 14, -24
	subq	$1, %rdx
	movq	%r15, 16(%rsp)
	.cfi_offset 15, -16
	movq	%rax, %rdi
	jne	.L110
	call	__gnat_begin_handler_v1@PLT
	subl	$1, 16(%rbx)
	movq	%r14, %rdi
	movq	%rax, %r15
.LEHB6:
	call	__gnat_reraise_zcx@PLT
.LEHE6:
.L104:
	movq	%rax, %rbx
	movq	%r14, %rdi
	movq	%rax, %rdx
	movq	%r15, %rsi
.LEHB7:
	call	__gnat_end_handler_v1@PLT
	movq	%rbx, %rdi
.L110:
	call	_Unwind_Resume@PLT
.LEHE7:
	.cfi_endproc
.LFE55:
	.section	.gcc_except_table
	.align 4
.LLSDAC55:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC55-.LLSDATTDC55
.LLSDATTDC55:
	.byte	0x1
	.uleb128 .LLSDACSEC55-.LLSDACSBC55
.LLSDACSBC55:
	.uleb128 .LEHB6-.LCOLDB27
	.uleb128 .LEHE6-.LEHB6
	.uleb128 .L104-.LCOLDB27
	.uleb128 0
	.uleb128 .LEHB7-.LCOLDB27
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
.LLSDACSEC55:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC55:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__query_element, .-math_prime_util__count__lmo__storage__factor_holders__query_element
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__query_element.cold, .-math_prime_util__count__lmo__storage__factor_holders__query_element.cold
.LCOLDE27:
	.text
.LHOTE27:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__adjust__2
	.type	math_prime_util__count__lmo__storage__word_holders__adjust__2, @function
math_prime_util__count__lmo__storage__word_holders__adjust__2:
.LFB3:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L115
	movl	16(%rdi), %edx
	testl	%edx, %edx
	je	.L125
	movq	16(%rax), %rax
	movl	$8, %edi
	movslq	(%rax), %rsi
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%rsi, %rax
	leaq	16(,%rax,8), %rax
	cmpl	%edx, %esi
	cmovle	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	%rax, %rcx
	movq	8(%rbx), %rax
	movq	%rcx, 8(%rsp)
	movq	16(%rax), %rdx
	movq	8(%rax), %r9
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %edi
	movq	%xmm0, (%rcx)
	movslq	%esi, %r8
	movslq	%edi, %rax
	subq	%r8, %rax
	cmpl	%esi, %edi
	leaq	8(%rcx), %r8
	movq	%r9, %rsi
	leaq	8(,%rax,8), %rax
	movq	%r8, %rdi
	movq	%r8, (%rsp)
	cmovge	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%r8, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	%rax, 8(%rbx)
.L115:
	movl	$0, 16(%rbx)
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L125:
	.cfi_restore_state
	lock addl	$1, (%rax)
	movl	$0, 16(%rbx)
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE3:
	.size	math_prime_util__count__lmo__storage__word_holders__adjust__2, .-math_prime_util__count__lmo__storage__word_holders__adjust__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__adjust__2
	.type	math_prime_util__count__lmo__storage__factor_holders__adjust__2, @function
math_prime_util__count__lmo__storage__factor_holders__adjust__2:
.LFB39:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L127
	movl	16(%rdi), %edx
	testl	%edx, %edx
	je	.L137
	movq	16(%rax), %rax
	movl	$8, %edi
	movslq	(%rax), %rsi
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%rsi, %rax
	leaq	13(%rax,%rax), %rax
	andq	$-4, %rax
	cmpl	%edx, %esi
	cmovle	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	%rax, %rcx
	movq	8(%rbx), %rax
	movq	%rcx, 8(%rsp)
	movq	16(%rax), %rdx
	movq	8(%rax), %r9
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %edi
	movq	%xmm0, (%rcx)
	movslq	%esi, %r8
	movslq	%edi, %rax
	subq	%r8, %rax
	cmpl	%esi, %edi
	leaq	8(%rcx), %r8
	movq	%r9, %rsi
	leaq	2(%rax,%rax), %rax
	movq	%r8, %rdi
	movq	%r8, (%rsp)
	cmovge	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%r8, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	%rax, 8(%rbx)
.L127:
	movl	$0, 16(%rbx)
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L137:
	.cfi_restore_state
	lock addl	$1, (%rax)
	movl	$0, 16(%rbx)
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE39:
	.size	math_prime_util__count__lmo__storage__factor_holders__adjust__2, .-math_prime_util__count__lmo__storage__factor_holders__adjust__2
	.section	.rodata.str1.8
	.align 8
.LC28:
	.string	"MATH_PRIME_UTIL.COUNT.LMO.STORAGE.WORD_HOLDERS.REFERENCE_CONTROL_TYPE"
	.section	.rodata
	.align 8
.LC17:
	.long	1
	.long	69
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_control_typePI__2
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typePI__2, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typePI__2:
.LFB93:
	.cfi_startproc
	leaq	.LC28(%rip), %rsi
	leaq	.LC17(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE93:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typePI__2, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typePI__2
	.section	.rodata.str1.8
	.align 8
.LC29:
	.string	"MATH_PRIME_UTIL.COUNT.LMO.STORAGE.FACTOR_HOLDERS.REFERENCE_CONTROL_TYPE"
	.section	.rodata
	.align 8
.LC18:
	.long	1
	.long	71
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_control_typePI__2
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typePI__2, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typePI__2:
.LFB149:
	.cfi_startproc
	leaq	.LC29(%rip), %rsi
	leaq	.LC18(%rip), %rdx
	jmp	system__put_images__put_image_unknown@PLT
	.cfi_endproc
.LFE149:
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typePI__2, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typePI__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSR__2
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSR__2, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typeSR__2:
.LFB94:
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
.LFE94:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSR__2, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typeSR__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSR__2
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSR__2, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSR__2:
.LFB150:
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
.LFE150:
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSR__2, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSR__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSW__2
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSW__2, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typeSW__2:
.LFB95:
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
.LFE95:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSW__2, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typeSW__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSW__2
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSW__2, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSW__2:
.LFB151:
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
.LFE151:
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSW__2, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSW__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__Oeq__4
	.type	math_prime_util__count__lmo__storage__word_holders__Oeq__4, @function
math_prime_util__count__lmo__storage__word_holders__Oeq__4:
.LFB99:
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
	je	.L148
	movq	8(%rbx), %rax
	cmpq	%rax, 8(%rbp)
	sete	%al
.L148:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE99:
	.size	math_prime_util__count__lmo__storage__word_holders__Oeq__4, .-math_prime_util__count__lmo__storage__word_holders__Oeq__4
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__Oeq__4
	.type	math_prime_util__count__lmo__storage__factor_holders__Oeq__4, @function
math_prime_util__count__lmo__storage__factor_holders__Oeq__4:
.LFB155:
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
	je	.L154
	movq	8(%rbx), %rax
	cmpq	%rax, 8(%rbp)
	sete	%al
.L154:
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE155:
	.size	math_prime_util__count__lmo__storage__factor_holders__Oeq__4, .-math_prime_util__count__lmo__storage__factor_holders__Oeq__4
	.section	.rodata.str1.8
	.align 8
.LC30:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Swap: attempt to tamper with elements"
	.section	.rodata
	.align 8
.LC4:
	.long	1
	.long	84
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__swap
	.type	math_prime_util__count__lmo__storage__word_holders__swap, @function
math_prime_util__count__lmo__storage__word_holders__swap:
.LFB30:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %edx
	testl	%edx, %edx
	jne	.L165
	movl	16(%rsi), %eax
	testl	%eax, %eax
	jne	.L165
	movq	8(%rdi), %rax
	movq	8(%rsi), %rdx
	cmpq	%rdx, %rax
	je	.L160
	movq	%rdx, 8(%rdi)
	movq	%rax, 8(%rsi)
.L160:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L165:
	.cfi_restore_state
	leaq	.LC30(%rip), %rsi
	leaq	.LC4(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE30:
	.size	math_prime_util__count__lmo__storage__word_holders__swap, .-math_prime_util__count__lmo__storage__word_holders__swap
	.section	.rodata.str1.8
	.align 8
.LC31:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Swap: attempt to tamper with elements"
	.section	.rodata
	.align 8
.LC0:
	.long	1
	.long	86
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__swap
	.type	math_prime_util__count__lmo__storage__factor_holders__swap, @function
math_prime_util__count__lmo__storage__factor_holders__swap:
.LFB66:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	16(%rdi), %edx
	testl	%edx, %edx
	jne	.L171
	movl	16(%rsi), %eax
	testl	%eax, %eax
	jne	.L171
	movq	8(%rdi), %rax
	movq	8(%rsi), %rdx
	cmpq	%rdx, %rax
	je	.L166
	movq	%rdx, 8(%rdi)
	movq	%rax, 8(%rsi)
.L166:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L171:
	.cfi_restore_state
	leaq	.LC31(%rip), %rsi
	leaq	.LC0(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE66:
	.size	math_prime_util__count__lmo__storage__factor_holders__swap, .-math_prime_util__count__lmo__storage__factor_holders__swap
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__adjust__4
	.type	math_prime_util__count__lmo__storage__factor_holders__adjust__4, @function
math_prime_util__count__lmo__storage__factor_holders__adjust__4:
.LFB40:
	.cfi_startproc
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L172
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	8(%rdi), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L181
	addl	$1, %eax
	movl	%eax, 16(%rdx)
.L172:
	ret
.L181:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$98, %esi
	leaq	.LC24(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE40:
	.size	math_prime_util__count__lmo__storage__factor_holders__adjust__4, .-math_prime_util__count__lmo__storage__factor_holders__adjust__4
	.section	.rodata.str1.8
	.align 8
.LC32:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Clear: attempt to tamper with elements"
	.section	.rodata
	.align 8
.LC1:
	.long	1
	.long	85
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__word_holders__clear.part.0, @function
math_prime_util__count__lmo__storage__word_holders__clear.part.0:
.LFB248:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC32(%rip), %rsi
	leaq	.LC1(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE248:
	.size	math_prime_util__count__lmo__storage__word_holders__clear.part.0, .-math_prime_util__count__lmo__storage__word_holders__clear.part.0
	.section	.rodata.str1.8
	.align 8
.LC33:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Finalize: attempt to tamper with elements"
	.section	.rodata
	.align 8
.LC3:
	.long	1
	.long	88
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__word_holders__finalize__2.part.0, @function
math_prime_util__count__lmo__storage__word_holders__finalize__2.part.0:
.LFB250:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC33(%rip), %rsi
	leaq	.LC3(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE250:
	.size	math_prime_util__count__lmo__storage__word_holders__finalize__2.part.0, .-math_prime_util__count__lmo__storage__word_holders__finalize__2.part.0
	.section	.rodata.str1.8
	.align 8
.LC34:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Clear: attempt to tamper with elements"
	.section	.rodata
	.align 8
.LC10:
	.long	1
	.long	87
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__factor_holders__clear.part.0, @function
math_prime_util__count__lmo__storage__factor_holders__clear.part.0:
.LFB255:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC34(%rip), %rsi
	leaq	.LC10(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE255:
	.size	math_prime_util__count__lmo__storage__factor_holders__clear.part.0, .-math_prime_util__count__lmo__storage__factor_holders__clear.part.0
	.section	.rodata.str1.8
	.align 8
.LC35:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Finalize: attempt to tamper with elements"
	.section	.rodata
	.align 8
.LC11:
	.long	1
	.long	90
	.text
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__factor_holders__finalize__2.part.0, @function
math_prime_util__count__lmo__storage__factor_holders__finalize__2.part.0:
.LFB257:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC35(%rip), %rsi
	leaq	.LC11(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE257:
	.size	math_prime_util__count__lmo__storage__factor_holders__finalize__2.part.0, .-math_prime_util__count__lmo__storage__factor_holders__finalize__2.part.0
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders___size__3
	.type	math_prime_util__count__lmo__storage__factor_holders___size__3, @function
math_prime_util__count__lmo__storage__factor_holders___size__3:
.LFB266:
	.cfi_startproc
	movl	$192, %eax
	ret
	.cfi_endproc
.LFE266:
	.size	math_prime_util__count__lmo__storage__factor_holders___size__3, .-math_prime_util__count__lmo__storage__factor_holders___size__3
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders___size__4
	.type	math_prime_util__count__lmo__storage__factor_holders___size__4, @function
math_prime_util__count__lmo__storage__factor_holders___size__4:
.LFB272:
	.cfi_startproc
	movl	$128, %eax
	ret
	.cfi_endproc
.LFE272:
	.size	math_prime_util__count__lmo__storage__factor_holders___size__4, .-math_prime_util__count__lmo__storage__factor_holders___size__4
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__compute__B_12__remove.24, @function
math_prime_util__count__lmo__compute__B_12__remove.24:
.LFB193:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	40(%r10), %rdx
	movl	%esi, %esi
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	leaq	(%rdx,%rsi,8), %rbp
	movq	%rbx, 8(%rsp)
	movq	0(%rbp), %rdx
	movq	%r12, 24(%rsp)
	movq	%rdx, 32(%r10)
	cmpl	%edi, %esi
	.cfi_offset 3, -40
	.cfi_offset 12, -24
	jl	.L193
	movq	24(%r10), %r8
	movq	16(%r10), %r11
	movslq	%edi, %rdx
	movq	%rsi, %rax
	subl	%edi, %eax
	movq	8(%r10), %rsi
	movq	(%r10), %rdi
	movq	%r13, 32(%rsp)
	movq	(%r8), %r8
	leaq	0(,%r11,8), %rbx
	movq	%r8, %r9
	subq	%rbx, %r9
	leaq	(%r9,%rdx,8), %r9
	subq	%r11, %rdx
	xorl	%r11d, %r11d
	addq	%rax, %rdx
	leaq	8(%r8,%rdx,8), %rbx
	.cfi_offset 13, -16
	.p2align 4
	.p2align 3
.L199:
	movq	(%r9), %r13
	xorl	%edx, %edx
	movq	%rsi, %rax
	divq	%r13
	movq	%rsi, %rax
	subq	%rdx, %rax
	movq	%r11, %rdx
	cmpq	%rsi, %rax
	cmovb	%r13, %rdx
	addq	%rdx, %rax
	movq	%r11, %rdx
	testb	$1, %al
	cmove	%r13, %rdx
	addq	%rdx, %rax
	cmpq	%rdi, %rax
	jnb	.L196
	addq	%r13, %r13
	subq	%rsi, %rax
	.p2align 6
	.p2align 4
	.p2align 3
.L198:
	movq	%rax, %rcx
	shrq	%rcx
	cmpq	$2147483647, %rcx
	ja	.L211
	movl	%ecx, %r12d
	movl	$1, %edx
	addq	%r13, %rax
	sarl	$6, %r12d
	salq	%cl, %rdx
	notq	%rdx
	andq	%rdx, 48(%r10,%r12,8)
	leaq	(%rsi,%rax), %rdx
	cmpq	%rdi, %rdx
	jb	.L198
.L196:
	addq	$8, %r9
	cmpq	%r9, %rbx
	jne	.L199
	movq	32(%rsp), %r13
	.cfi_restore 13
.L193:
	movl	120176(%r10), %ebx
	movl	$0, 120180(%r10)
	movl	%ebx, %eax
	leal	126(%rbx), %r11d
	addl	$63, %eax
	cmovns	%eax, %r11d
	sarl	$6, %r11d
	testl	%ebx, %ebx
	jle	.L200
	movabsq	$6148914691236517205, %r8
	movl	%r11d, %r9d
	xorl	%edx, %edx
	movabsq	$3689348814741910323, %rcx
	movabsq	$1085102592571150095, %rdi
	movabsq	$72340172838076673, %rsi
	.p2align 4
	.p2align 3
.L204:
	movq	48(%r10,%rdx,8), %rax
	movq	%rax, %r12
	shrq	%r12
	andq	%r8, %r12
	subq	%r12, %rax
	movq	%rax, %r12
	shrq	$2, %rax
	andq	%rcx, %rax
	andq	%rcx, %r12
	addq	%rax, %r12
	movq	%r12, %rax
	shrq	$4, %rax
	addq	%r12, %rax
	andq	%rdi, %rax
	imulq	%rsi, %rax
	shrq	$56, %rax
	addl	120180(%r10,%rdx,4), %eax
	jo	.L212
	movl	%eax, 120184(%r10,%rdx,4)
	addq	$1, %rdx
	cmpq	%r9, %rdx
	jne	.L204
.L200:
	cmpl	$2147483584, %ebx
	jg	.L213
	movslq	%r11d, %r11
	movq	8(%rsp), %rbx
	movq	24(%rsp), %r12
	movslq	120180(%r10,%r11,4), %rax
	addq	%rax, 0(%rbp)
	movq	16(%rsp), %rbp
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
.L211:
	.cfi_def_cfa_offset 48
	.cfi_offset 13, -16
	movl	$224, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L212:
	.cfi_restore 13
	movl	$230, %esi
	leaq	.LC20(%rip), %rdi
	movq	%r13, 32(%rsp)
	.cfi_remember_state
	.cfi_offset 13, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L213:
	.cfi_restore_state
	movl	$233, %esi
	leaq	.LC20(%rip), %rdi
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE193:
	.size	math_prime_util__count__lmo__compute__B_12__remove.24, .-math_prime_util__count__lmo__compute__B_12__remove.24
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__compute, @function
math_prime_util__count__lmo__compute:
.LFB191:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	movq	%rdx, %r14
	leaq	32(%rbp), %rdx
	pushq	%r13
	.cfi_offset 13, -40
	movl	%ecx, %r13d
	pushq	%r12
	pushq	%rbx
	subq	$180440, %rsp
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	24(%rbp), %rax
	movq	%rdx, -180280(%rbp)
	movq	40(%rbp), %rdx
	movq	%rsi, -180352(%rbp)
	movl	4(%rax), %esi
	movq	16(%rbp), %rbx
	movq	%rdi, -180328(%rbp)
	movslq	(%rdx), %rcx
	movl	%r8d, -180400(%rbp)
	movq	%rcx, -180336(%rbp)
	movq	%rcx, -180288(%rbp)
	cmpl	$-1073741824, %esi
	js	.L370
	movslq	(%rax), %rcx
	movq	32(%rbp), %r12
	movl	$-2, %r15d
	movq	$0, -180296(%rbp)
	movq	%rcx, %rax
	movq	%rcx, -180344(%rbp)
	movq	%rcx, %rdx
	negq	%rax
	movw	%r15w, (%rbx,%rax,2)
	movl	$1, %eax
	subq	-180336(%rbp), %rax
	movq	$2, (%r12,%rax,8)
	testl	%esi, %esi
	jle	.L216
	leaq	(%rcx,%rcx), %rax
	addl	%esi, %esi
	leaq	2(%rbx), %rdi
	movl	$1073741825, %r9d
	movl	%r13d, -180368(%rbp)
	subq	%rax, %rdi
	leal	3(%rsi), %r10d
	movl	$3, %ecx
	movq	%r14, -180360(%rbp)
	movl	$9, %r8d
	movl	$1, %r11d
	movq	%rdx, %r13
	jmp	.L244
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L217:
	addl	$2, %ecx
	addq	$2, %rdi
	addl	$6, %r8d
	addl	$1, %r9d
	cmpl	%r10d, %ecx
	je	.L371
.L244:
	cmpw	$-1, (%rdi)
	jne	.L217
	testl	%r9d, %r9d
	js	.L372
	leal	715827882(%rcx), %eax
	cmpl	$1431655764, %eax
	ja	.L373
	cmpl	$2147483647, %r11d
	je	.L374
	addl	$1, %r11d
	movl	%ecx, %r14d
	movl	%r8d, %edx
	movslq	%r11d, %rax
	subq	-180336(%rbp), %rax
	movq	%r14, (%r12,%rax,8)
	cmpl	$65534, %ecx
	jle	.L221
	cmpl	%r8d, %esi
	jl	.L217
.L223:
	leal	(%rcx,%rcx), %r15d
	jmp	.L231
	.p2align 4,,10
	.p2align 3
.L225:
	testw	%r14w, %r14w
	je	.L227
	xorl	$1, %r14d
	movw	%r14w, (%rbx,%rax,2)
.L227:
	addl	%r15d, %edx
	jo	.L375
	cmpl	%esi, %edx
	jg	.L224
.L231:
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	cltq
	subq	%r13, %rax
	movzwl	(%rbx,%rax,2), %r14d
	cmpw	$-1, %r14w
	jne	.L225
	cmpl	$65535, %ecx
	jg	.L376
	movw	%cx, (%rbx,%rax,2)
	jmp	.L227
.L221:
	movw	%cx, (%rdi)
	cmpl	%r8d, %esi
	jge	.L223
.L224:
	movl	%esi, %eax
	cltd
	idivl	%ecx
	cmpl	%ecx, %eax
	jl	.L217
	movl	%ecx, %r15d
	movq	%r15, %rdx
	imulq	%r15, %rdx
	movslq	%edx, %rax
	cmpq	%rax, %rdx
	jne	.L352
	cmpl	%esi, %edx
	jg	.L217
	movl	%edx, %eax
	xorl	%r14d, %r14d
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	cltq
	subq	%r13, %rax
	movw	%r14w, (%rbx,%rax,2)
	leal	(%rcx,%rcx), %r14d
	imulq	%r15, %r14
	movslq	%r14d, %rax
	cmpq	%rax, %r14
	je	.L369
	jmp	.L236
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L242:
	cmpl	%esi, %edx
	jg	.L217
	movl	%edx, %eax
	xorl	%r15d, %r15d
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	cltq
	subq	%r13, %rax
	movw	%r15w, (%rbx,%rax,2)
.L369:
	addl	%r14d, %edx
	jno	.L242
.L236:
	movl	$148, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L371:
	movq	-180360(%rbp), %r14
	movl	-180368(%rbp), %r13d
.L216:
	addq	$1, %r14
	shrq	%r14
	movq	%r14, %rax
	subq	-180344(%rbp), %rax
	movq	%r14, -180392(%rbp)
	movl	%r14d, -180380(%rbp)
	cmpw	$13, (%rbx,%rax,2)
	ja	.L245
	movq	-180344(%rbp), %rax
	addq	$1, -180392(%rbp)
	movl	-180380(%rbp), %edx
	movq	-180392(%rbp), %rcx
	negq	%rax
	leaq	(%rbx,%rax,2), %rax
	jmp	.L247
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L248:
	addq	$1, %rcx
	cmpl	$2147483647, %edx
	je	.L377
.L247:
	addl	$1, %edx
	cmpw	$13, (%rax,%rcx,2)
	jbe	.L248
	movl	%edx, -180380(%rbp)
	movq	%rcx, -180392(%rbp)
.L245:
	movq	-180392(%rbp), %rax
	xorl	%edx, %edx
	leaq	(%rax,%rax), %r15
	movq	-180336(%rbp), %rax
	negq	%rax
	salq	$3, %rax
	movq	%rax, -180376(%rbp)
	addq	%r12, %rax
	jmp	.L249
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L250:
	addq	$1, %rdx
	cmpq	$2147483647, %rdx
	je	.L378
.L249:
	cmpq	8(%rax,%rdx,8), %r15
	jnb	.L250
	movl	%edx, -180360(%rbp)
	movl	%edx, %edi
	cmpl	$6, %edx
	jle	.L251
	movq	-180376(%rbp), %rcx
	movl	$6, %esi
	movq	56(%r12,%rcx), %rcx
	jmp	.L253
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L379:
	addl	$1, %esi
	addq	$8, %rax
	cmpl	%edi, %esi
	je	.L361
.L253:
	movq	%rcx, %rdx
	movq	64(%rax), %rcx
	imulq	%rcx, %rdx
	cmpq	%rdx, %r15
	jnb	.L379
.L361:
	movl	%esi, -180384(%rbp)
	testl	%r13d, %r13d
	je	.L254
	movl	-180400(%rbp), %ecx
	movl	-180384(%rbp), %eax
	movl	-180360(%rbp), %edx
	cmpl	%eax, %ecx
	cmovge	%ecx, %eax
	subl	%eax, %edx
	movl	%eax, -180448(%rbp)
	movl	%edx, %eax
	subl	$1, %eax
	js	.L255
	movl	%eax, %eax
	movq	-180352(%rbp), %rsi
	leal	-1(%r13), %ecx
	leaq	-180320(%rbp), %rdi
	imulq	%rdx, %rax
	movl	%ecx, %edx
	movl	%ecx, -180444(%rbp)
	addq	$1, %rsi
	shrq	%rax
	leaq	(%rax,%rdx), %r12
	call	math_prime_util__sieve__prev_prime@PLT
	movl	-180380(%rbp), %eax
	movq	-180312(%rbp), %r9
	leal	-1(%rax), %r8d
	testl	%eax, %eax
	je	.L258
	movq	-180344(%rbp), %rsi
	movq	%rbx, %rcx
	movslq	math_prime_util__count__lmo__TTphi_tableSP1___L(%rip), %r14
	movq	%r9, -180424(%rbp)
	movq	%rbx, -180432(%rbp)
	movl	$1073741824, %edi
	xorl	%r9d, %r9d
	movq	math_prime_util__count__lmo__phi_table(%rip), %r11
	leaq	(%rsi,%rsi), %rax
	movq	%r15, -180408(%rbp)
	movq	-180328(%rbp), %r10
	subq	%rax, %rcx
	movl	%r8d, %eax
	movl	%r8d, -180416(%rbp)
	subq	%rsi, %rax
	movq	%rcx, -180368(%rbp)
	movl	$1, %esi
	leaq	2(%rbx,%rax,2), %r13
	movl	$30030, %eax
	subq	%r14, %rax
	movq	%rax, %rbx
	jmp	.L265
	.p2align 4,,10
	.p2align 3
.L382:
	testl	%edi, %edi
	js	.L380
	movl	%esi, %r8d
	movq	%r10, %rax
	xorl	%edx, %edx
	divq	%r8
	movq	%rax, %r8
	movabsq	$-8382426561100251127, %rax
	mulq	%r8
	movq	%r8, %rax
	shrq	$14, %rdx
	imulq	$30030, %rdx, %r15
	subq	%r15, %rax
	cmpq	$2147483647, %rax
	ja	.L264
	movslq	(%r11,%rbx,4), %rax
	imulq	%rdx, %rax
	imull	$30030, %edx, %edx
	addq	%r9, %rax
	subl	%edx, %r8d
	movslq	%r8d, %r8
	subq	%r14, %r8
	movslq	(%r11,%r8,4), %r9
	addq	%rax, %r9
.L259:
	addq	$2, %rcx
	addl	$2, %esi
	addl	$1, %edi
	cmpq	%r13, %rcx
	je	.L381
.L265:
	movzwl	(%rcx), %eax
	cmpw	$13, %ax
	jbe	.L259
	testb	$1, %al
	jne	.L382
	testl	%edi, %edi
	js	.L383
	movl	%esi, %r8d
	movq	%r10, %rax
	xorl	%edx, %edx
	divq	%r8
	movq	%rax, %r8
	movabsq	$-8382426561100251127, %rax
	mulq	%r8
	movq	%r8, %rax
	shrq	$14, %rdx
	imulq	$30030, %rdx, %r15
	subq	%r15, %rax
	cmpq	$2147483647, %rax
	ja	.L264
	movslq	(%r11,%rbx,4), %rax
	addq	$2, %rcx
	addl	$2, %esi
	addl	$1, %edi
	imulq	%rdx, %rax
	imull	$30030, %edx, %edx
	addq	%r12, %rax
	subl	%edx, %r8d
	movslq	%r8d, %r8
	subq	%r14, %r8
	movslq	(%r11,%r8,4), %r12
	addq	%rax, %r12
	cmpq	%r13, %rcx
	jne	.L265
.L381:
	movq	32(%rbp), %rcx
	movq	-180408(%rbp), %r15
	movl	$7, %eax
	xorl	%edx, %edx
	subq	-180336(%rbp), %rax
	movl	-180416(%rbp), %r8d
	movq	%r9, -180352(%rbp)
	movq	(%rcx,%rax,8), %r10
	movq	%r15, %rax
	movq	%rcx, -180408(%rbp)
	movq	-180424(%rbp), %r9
	movq	-180432(%rbp), %rbx
	divq	%r10
	leaq	1(%rax), %rcx
	shrq	%rcx
	cmpl	%ecx, %r8d
	jl	.L267
	movq	-180368(%rbp), %rax
	movq	%rbx, -180416(%rbp)
	leal	1(%rcx,%rcx), %edi
	movq	%r9, -180368(%rbp)
	movq	-180352(%rbp), %r9
	leaq	(%rax,%rcx,2), %rsi
	movl	-180380(%rbp), %eax
	addl	$1073741824, %ecx
	movq	%r15, -180336(%rbp)
	leal	1073741824(%rax), %r13d
	movl	$30030, %eax
	subq	%r14, %rax
	movq	%rax, %rbx
	jmp	.L272
	.p2align 4,,10
	.p2align 3
.L386:
	testl	%ecx, %ecx
	js	.L384
	movl	%edi, %r8d
	movq	-180328(%rbp), %rax
	xorl	%edx, %edx
	imulq	%r10, %r8
	divq	%r8
	movq	%rax, %r8
	movabsq	$-8382426561100251127, %rax
	mulq	%r8
	movq	%r8, %rax
	shrq	$14, %rdx
	imulq	$30030, %rdx, %r15
	subq	%r15, %rax
	cmpq	$2147483647, %rax
	ja	.L264
	movslq	(%r11,%rbx,4), %rax
	imulq	%rdx, %rax
	imull	$30030, %edx, %edx
	addq	%r12, %rax
	subl	%edx, %r8d
	movslq	%r8d, %r8
	subq	%r14, %r8
	movslq	(%r11,%r8,4), %r12
	addq	%rax, %r12
.L268:
	addl	$1, %ecx
	addq	$2, %rsi
	addl	$2, %edi
	cmpl	%r13d, %ecx
	je	.L385
.L272:
	movzwl	(%rsi), %edx
	movq	%rdx, %rax
	cmpq	%rdx, %r10
	jnb	.L268
	testb	$1, %al
	jne	.L386
	testl	%ecx, %ecx
	js	.L387
	movl	%edi, %r8d
	movq	-180328(%rbp), %rax
	xorl	%edx, %edx
	imulq	%r10, %r8
	divq	%r8
	movq	%rax, %r8
	movabsq	$-8382426561100251127, %rax
	mulq	%r8
	movq	%r8, %rax
	shrq	$14, %rdx
	imulq	$30030, %rdx, %r15
	subq	%r15, %rax
	cmpq	$2147483647, %rax
	ja	.L264
	movslq	(%r11,%rbx,4), %rax
	addl	$1, %ecx
	addq	$2, %rsi
	addl	$2, %edi
	imulq	%rdx, %rax
	imull	$30030, %edx, %edx
	addq	%r9, %rax
	subl	%edx, %r8d
	movslq	%r8d, %r8
	subq	%r14, %r8
	movslq	(%r11,%r8,4), %rdx
	leaq	(%rdx,%rax), %r9
	cmpl	%r13d, %ecx
	jne	.L272
.L385:
	movq	%r9, -180352(%rbp)
	movq	-180336(%rbp), %r15
	movq	-180368(%rbp), %r9
	movq	-180416(%rbp), %rbx
.L267:
	movl	-180448(%rbp), %r14d
	xorl	%esi, %esi
	movq	%r9, -180336(%rbp)
	leaq	2(%r14), %r13
	movq	%r14, -180456(%rbp)
	leaq	0(,%r13,8), %rdx
	leaq	15(%rdx), %rax
	shrq	$4, %rax
	salq	$4, %rax
	subq	%rax, %rsp
	movq	%rsp, %rdi
	movq	%rsp, -180264(%rbp)
	call	memset@PLT
	leaq	15(,%r13,4), %rax
	movq	-180336(%rbp), %r9
	shrq	$4, %rax
	salq	$4, %rax
	subq	%rax, %rsp
	leaq	8(%rsp,%r14,4), %rdx
	andl	$1, %r14d
	movq	%rsp, -180368(%rbp)
	movq	%rsp, %rax
	je	.L365
	movq	-180368(%rbp), %rax
	movl	-180380(%rbp), %ecx
	addq	$4, %rax
	movl	%ecx, -4(%rax)
	cmpq	%rdx, %rax
	je	.L360
.L365:
	movl	-180380(%rbp), %ecx
.L273:
	movl	%ecx, (%rax)
	addq	$8, %rax
	movl	%ecx, -4(%rax)
	cmpq	%rdx, %rax
	jne	.L273
.L360:
	xorl	%esi, %esi
	leaq	-60124(%rbp), %rdi
	movl	$60068, %edx
	movq	%r9, -180336(%rbp)
	call	memset@PLT
	movl	-180384(%rbp), %ecx
	cmpl	%ecx, -180400(%rbp)
	movq	$0, -180272(%rbp)
	movq	-180336(%rbp), %r9
	jle	.L274
	movq	-180368(%rbp), %rsi
	movq	-180376(%rbp), %rdx
	movl	%ecx, %eax
	movq	%r15, -180336(%rbp)
	movl	-180360(%rbp), %edi
	movl	-180448(%rbp), %r14d
	leaq	(%rsi,%rax,4), %r11
	leaq	8(%rdx,%rax,8), %r8
	movq	-180408(%rbp), %rax
	movq	-180328(%rbp), %r13
	leal	1(%rcx), %esi
	movl	%edi, %ecx
	addq	%rax, %r8
	leaq	(%rax,%rdx), %r10
	.p2align 4
	.p2align 3
.L275:
	cmpl	%ecx, %esi
	jge	.L277
	movq	(%r8), %r15
	movq	%r13, %rax
	xorl	%edx, %edx
	imulq	%r15, %r15
	divq	%r15
	movl	%ecx, %edx
	leaq	(%r10,%rdx,8), %rdx
	jmp	.L279
	.p2align 4
	.p2align 4,,10
	.p2align 3
.L388:
	subl	$1, %ecx
	subq	$8, %rdx
	cmpl	%ecx, %esi
	je	.L277
.L279:
	cmpq	(%rdx), %rax
	jb	.L388
.L277:
	movl	%edi, %eax
	movl	%ecx, (%r11)
	subl	%ecx, %eax
	js	.L389
	movl	%eax, %eax
	addq	%rax, %r12
	cmpl	%esi, %r14d
	je	.L390
	addl	$1, %esi
	addq	$4, %r11
	addq	$8, %r8
	cmpl	$-2147483648, %esi
	jne	.L275
	movl	$248, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L390:
	movq	-180336(%rbp), %r15
.L274:
	movq	-180328(%rbp), %rax
	xorl	%edx, %edx
	leaq	1(%r15), %rcx
	divq	%rcx
	addq	$1, %rax
	movq	%rax, -180440(%rbp)
	je	.L282
	movq	-180344(%rbp), %rax
	movq	-180368(%rbp), %rcx
	movq	%r9, %r13
	negq	%rax
	leaq	(%rbx,%rax,2), %r15
	movl	-180384(%rbp), %eax
	movq	%rax, -180400(%rbp)
	leaq	(%rcx,%rax,4), %rax
	xorl	%ecx, %ecx
	movq	%rax, -180464(%rbp)
	movl	-180448(%rbp), %eax
	movl	%eax, -180432(%rbp)
.L312:
	movq	-180440(%rbp), %rsi
	leaq	1921920(%rcx), %rax
	cmpq	%rsi, %rax
	cmova	%rsi, %rax
	movq	%rax, -180304(%rbp)
	movq	%rax, %r10
	subq	%rcx, %rax
	leaq	1(%rax), %rbx
	shrq	%rbx
	cmpq	$2147483647, %rbx
	ja	.L391
	xorl	%esi, %esi
	leaq	-180256(%rbp), %rdi
	movl	$120128, %edx
	movq	%r10, -180336(%rbp)
	movq	%rcx, -180344(%rbp)
	movl	%ebx, -60128(%rbp)
	call	memset@PLT
	testl	%ebx, %ebx
	movq	-180336(%rbp), %r10
	jne	.L392
.L285:
	movq	-180328(%rbp), %rax
	xorl	%edx, %edx
	divq	%r10
	movq	%rax, -180336(%rbp)
	cmpl	$7, -180384(%rbp)
	jg	.L393
.L289:
	movl	-180432(%rbp), %ecx
	cmpl	%ecx, -180384(%rbp)
	jl	.L394
.L306:
	movl	-180448(%rbp), %r14d
	movl	-180432(%rbp), %edi
	leaq	-180304(%rbp), %r10
	movl	%r14d, %esi
	call	math_prime_util__count__lmo__compute__B_12__remove.24
	movl	-180444(%rbp), %ebx
	cmpl	%ebx, -180360(%rbp)
	jg	.L308
	cmpq	%r13, -180336(%rbp)
	jnb	.L308
	movl	%ebx, %eax
	movl	%ebx, %ecx
	subq	-180456(%rbp), %rcx
	movq	%r15, -180376(%rbp)
	subl	%r14d, %eax
	movq	-180352(%rbp), %r15
	movq	%r13, %r14
	movq	%rcx, %r13
	subl	%ecx, %eax
	movl	%eax, -180344(%rbp)
	jmp	.L310
	.p2align 4,,10
	.p2align 3
.L396:
	cmpl	-180360(%rbp), %ebx
	jl	.L315
.L310:
	movl	-180344(%rbp), %eax
	addl	%r13d, %eax
	js	.L395
	movq	-180328(%rbp), %rax
	xorl	%edx, %edx
	addq	%r13, %r12
	subl	$1, %ebx
	leaq	-180304(%rbp), %r10
	subq	$1, %r13
	divq	%r14
	movq	%rax, %rdi
	call	math_prime_util__count__lmo__compute__B_12__sieve_phi.26
	movq	%r14, %rsi
	leaq	-180320(%rbp), %rdi
	addq	%rax, %r15
	call	math_prime_util__sieve__prev_prime@PLT
	movq	-180312(%rbp), %r14
	cmpq	%r14, -180336(%rbp)
	jb	.L396
.L315:
	movl	%ebx, -180444(%rbp)
	movq	%r14, %r13
	movq	%r15, -180352(%rbp)
	movq	-180376(%rbp), %r15
.L308:
	movq	-180304(%rbp), %rcx
	movq	%rcx, -180296(%rbp)
	cmpq	-180440(%rbp), %rcx
	jb	.L312
.L282:
	movq	%r12, %rax
	subq	-180352(%rbp), %rax
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L392:
	.cfi_restore_state
	movq	-180344(%rbp), %rcx
	subl	$1, %ebx
	movabsq	$2635249153387078802, %rdi
	movabsq	$3353953467947191203, %r8
	movabsq	$5675921253449092805, %r14
	leaq	1(%rcx), %rsi
	xorl	%ecx, %ecx
	.p2align 4
	.p2align 3
.L286:
	movabsq	$-6148914691236517205, %rax
	mulq	%rsi
	movq	%rdx, %rax
	andq	$-2, %rdx
	shrq	%rax
	addq	%rax, %rdx
	cmpq	%rsi, %rdx
	je	.L287
	movabsq	$-3689348814741910323, %rax
	mulq	%rsi
	movq	%rdx, %rax
	andq	$-4, %rdx
	shrq	$2, %rax
	addq	%rax, %rdx
	cmpq	%rsi, %rdx
	je	.L287
	movabsq	$7905747460161236407, %rax
	imulq	%rsi, %rax
	cmpq	%rax, %rdi
	jnb	.L287
	movq	%rsi, %rax
	mulq	%r8
	shrq	%rdx
	leaq	(%rdx,%rdx,4), %rax
	leaq	(%rdx,%rax,2), %rax
	cmpq	%rsi, %rax
	je	.L287
	movq	%rsi, %rax
	mulq	%r14
	shrq	$2, %rdx
	leaq	(%rdx,%rdx,2), %rax
	leaq	(%rdx,%rax,4), %rax
	cmpq	%rsi, %rax
	je	.L287
	movl	%ecx, %eax
	movl	$1, %edx
	sarl	$6, %eax
	salq	%cl, %rdx
	orq	%rdx, -180256(%rbp,%rax,8)
	.p2align 4
	.p2align 3
.L287:
	cmpl	%ecx, %ebx
	je	.L285
	addl	$1, %ecx
	addq	$2, %rsi
	cmpl	$1073741824, %ecx
	jne	.L286
	movl	$264, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L393:
	movq	%r12, -180344(%rbp)
	movl	$7, %r8d
	movq	%r13, -180472(%rbp)
	jmp	.L298
	.p2align 4,,10
	.p2align 3
.L290:
	cmpl	%r9d, %r10d
	movq	-180368(%rbp), %rax
	cmovg	%r9d, %r10d
	movl	%r10d, (%rax,%r11,4)
	cmpq	-180400(%rbp), %r8
	je	.L397
.L298:
	movl	%r8d, %edi
	leaq	-180304(%rbp), %r10
	movl	%r8d, %esi
	movq	%r8, -180376(%rbp)
	call	math_prime_util__count__lmo__compute__B_12__remove.24
	movq	-180376(%rbp), %r8
	movq	32(%rbp), %rax
	movq	%r8, %r11
	addq	$1, %r8
	movq	%r8, %rdx
	subq	-180288(%rbp), %rdx
	movq	(%rax,%rdx,8), %r12
	movq	-180336(%rbp), %rax
	xorl	%edx, %edx
	divq	%r12
	leaq	1(%rax), %r9
	movq	-180392(%rbp), %rax
	shrq	%r9
	cmpq	%rax, %r9
	cmova	%rax, %r9
	movl	-180380(%rbp), %eax
	cmpl	%r9d, %eax
	cmovle	%eax, %r9d
	movq	-180368(%rbp), %rax
	movl	(%rax,%r11,4), %r10d
	cmpl	%r9d, %r10d
	jle	.L290
	movl	%r10d, %ebx
	movq	%r15, %rax
	movq	%r8, -180376(%rbp)
	movl	%r9d, %r13d
	leaq	-1(%rbx), %r15
	leal	-1(%r10,%r10), %r14d
	movq	%r12, %rbx
	movl	%r10d, -180408(%rbp)
	movq	%r11, -180416(%rbp)
	movq	%rax, %r12
	movl	%r9d, -180424(%rbp)
	jmp	.L297
	.p2align 4,,10
	.p2align 3
.L399:
	cmpl	$-1073741824, %r15d
	js	.L294
	testl	%r14d, %r14d
	js	.L294
	movl	%r14d, %edi
	movq	-180328(%rbp), %rax
	xorl	%edx, %edx
	leaq	-180304(%rbp), %r10
	imulq	%rbx, %rdi
	divq	%rdi
	movq	%rax, %rdi
	call	math_prime_util__count__lmo__compute__B_12__sieve_phi.26
	addq	%rax, -180344(%rbp)
.L291:
	subl	$2, %r14d
	cmpq	%r13, %r15
	je	.L398
.L314:
	subq	$1, %r15
.L297:
	movzwl	(%r12,%r15,2), %edx
	movq	%rdx, %rax
	cmpq	%rdx, %rbx
	jnb	.L291
	testb	$1, %al
	jne	.L399
	cmpl	$-1073741824, %r15d
	js	.L296
	testl	%r14d, %r14d
	js	.L296
	movl	%r14d, %edi
	movq	-180328(%rbp), %rax
	xorl	%edx, %edx
	leaq	-180304(%rbp), %r10
	imulq	%rbx, %rdi
	subl	$2, %r14d
	divq	%rdi
	movq	%rax, %rdi
	call	math_prime_util__count__lmo__compute__B_12__sieve_phi.26
	addq	%rax, -180352(%rbp)
	cmpq	%r13, %r15
	jne	.L314
.L398:
	movq	-180376(%rbp), %r8
	movl	-180408(%rbp), %r10d
	movq	%r12, %r15
	movq	-180416(%rbp), %r11
	movl	-180424(%rbp), %r9d
	jmp	.L290
.L394:
	movl	-180384(%rbp), %eax
	movq	-180464(%rbp), %r14
	movq	%r13, -180416(%rbp)
	movq	%r15, -180424(%rbp)
	leal	2(%rax), %r8d
	movq	-180400(%rbp), %rax
	movq	%r14, -180344(%rbp)
	movl	%r8d, %r15d
	addq	$1, %rax
	movq	%rax, -180376(%rbp)
	leal	2(%rcx), %eax
	movl	%eax, -180408(%rbp)
	.p2align 4
	.p2align 3
.L304:
	leal	-2(%r15), %edi
	leaq	-180304(%rbp), %r10
	movl	%edi, %esi
	call	math_prime_util__count__lmo__compute__B_12__remove.24
	cmpl	$-2147483648, %r15d
	je	.L300
	movq	-180344(%rbp), %rax
	movl	(%rax), %esi
	cmpl	%esi, %r15d
	jg	.L301
	movq	-180288(%rbp), %r13
	movq	-180376(%rbp), %rbx
	subq	%r13, %rbx
	movq	%rbx, %r14
	movslq	%esi, %rbx
	jmp	.L303
	.p2align 4,,10
	.p2align 3
.L400:
	movq	-180328(%rbp), %rax
	xorl	%edx, %edx
	leaq	-180304(%rbp), %r10
	divq	%rcx
	movq	%rax, %rdi
	call	math_prime_util__count__lmo__compute__B_12__sieve_phi.26
	movq	-180344(%rbp), %rsi
	addq	%rax, %r12
	leal	-1(%rbx), %eax
	subq	$1, %rbx
	movl	%eax, (%rsi)
	cmpl	%ebx, %r15d
	jg	.L301
.L303:
	movq	32(%rbp), %rax
	movq	%rbx, %rdx
	subq	%r13, %rdx
	movq	(%rax,%r14,8), %rcx
	imulq	(%rax,%rdx,8), %rcx
	cmpq	%rcx, -180336(%rbp)
	jb	.L400
.L301:
	addq	$4, -180344(%rbp)
	addl	$1, %r15d
	addq	$1, -180376(%rbp)
	cmpl	%r15d, -180408(%rbp)
	jne	.L304
	movl	-180432(%rbp), %eax
	movq	-180368(%rbp), %rcx
	movq	-180416(%rbp), %r13
	movq	-180424(%rbp), %r15
	movq	%rax, %r9
	movl	-180384(%rbp), %r11d
	leaq	(%rcx,%rax,4), %rax
	jmp	.L307
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L401:
	subl	$1, %r9d
	subq	$4, %rax
	cmpl	%r11d, %r9d
	je	.L364
.L307:
	cmpl	%r9d, -4(%rax)
	jle	.L401
.L364:
	movl	%r9d, -180432(%rbp)
	jmp	.L306
.L397:
	movq	-180344(%rbp), %r12
	movq	-180472(%rbp), %r13
	jmp	.L289
.L258:
	movq	$0, -180352(%rbp)
	movq	32(%rbp), %rax
	movq	%rax, -180408(%rbp)
	jmp	.L267
.L378:
	movl	$160, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L300:
	movl	$298, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L296:
	movl	$289, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L294:
	movl	$286, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L375:
	movl	$142, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L251:
	testl	%r13d, %r13d
	je	.L254
.L255:
	movl	$170, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L395:
	movl	$313, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L391:
	movl	$259, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L374:
	movl	$131, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L264:
	movl	$72, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L387:
	movl	$189, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L389:
	movl	$254, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L380:
	movl	$178, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L254:
	movl	$169, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L377:
	movl	$156, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L372:
	movl	$128, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L370:
	movl	$110, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L383:
	movl	$180, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L384:
	movl	$187, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L352:
	movl	$145, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.p2align 4,,10
	.p2align 3
.L376:
	movl	$138, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L373:
	movl	$129, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE191:
	.size	math_prime_util__count__lmo__compute, .-math_prime_util__count__lmo__compute
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSO__2
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSO__2, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typeSO__2:
.LFB98:
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
.LFE98:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSO__2, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typeSO__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSO__2
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSO__2, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSO__2:
.LFB154:
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
.LFE154:
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSO__2, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSO__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__adjust__4
	.type	math_prime_util__count__lmo__storage__word_holders__adjust__4, @function
math_prime_util__count__lmo__storage__word_holders__adjust__4:
.LFB4:
	.cfi_startproc
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L406
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	8(%rdi), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L415
	addl	$1, %eax
	movl	%eax, 16(%rdx)
.L406:
	ret
.L415:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$98, %esi
	leaq	.LC24(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE4:
	.size	math_prime_util__count__lmo__storage__word_holders__adjust__4, .-math_prime_util__count__lmo__storage__word_holders__adjust__4
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_control_typeDA__2
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typeDA__2, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typeDA__2:
.LFB101:
	.cfi_startproc
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L416
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	8(%rdi), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L425
	addl	$1, %eax
	movl	%eax, 16(%rdx)
.L416:
	ret
.L425:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$98, %esi
	leaq	.LC24(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE101:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typeDA__2, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typeDA__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDA__2
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDA__2, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDA__2:
.LFB157:
	.cfi_startproc
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L426
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	8(%rdi), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L435
	addl	$1, %eax
	movl	%eax, 16(%rdx)
.L426:
	ret
.L435:
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$98, %esi
	leaq	.LC24(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE157:
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDA__2, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDA__2
	.section	.rodata
	.align 8
.LC8:
	.zero	8
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__holderFDXnn
	.type	math_prime_util__count__lmo__storage__word_holders__holderFDXnn, @function
math_prime_util__count__lmo__storage__word_holders__holderFDXnn:
.LFB81:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L451
	movq	8(%rdi), %rax
	movq	%rdi, %rdx
	testq	%rax, %rax
	je	.L436
	lock subl	$1, (%rax)
	je	.L452
.L439:
	movq	$0, 8(%rdx)
.L436:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L452:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L440
	subq	$8, %rdi
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rcx
	movq	(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L440:
	movq	%rax, %rdi
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rdx
	jmp	.L439
.L451:
	call	math_prime_util__count__lmo__storage__word_holders__finalize__2.part.0
	.cfi_endproc
.LFE81:
	.size	math_prime_util__count__lmo__storage__word_holders__holderFDXnn, .-math_prime_util__count__lmo__storage__word_holders__holderFDXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__holderDF__2
	.type	math_prime_util__count__lmo__storage__word_holders__holderDF__2, @function
math_prime_util__count__lmo__storage__word_holders__holderDF__2:
.LFB88:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L468
	movq	8(%rdi), %rax
	movq	%rdi, %rdx
	testq	%rax, %rax
	je	.L453
	lock subl	$1, (%rax)
	je	.L469
.L456:
	movq	$0, 8(%rdx)
.L453:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L469:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L457
	subq	$8, %rdi
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rcx
	movq	(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L457:
	movq	%rax, %rdi
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rdx
	jmp	.L456
.L468:
	call	math_prime_util__count__lmo__storage__word_holders__finalize__2.part.0
	.cfi_endproc
.LFE88:
	.size	math_prime_util__count__lmo__storage__word_holders__holderDF__2, .-math_prime_util__count__lmo__storage__word_holders__holderDF__2
	.section	.rodata
	.align 8
.LC15:
	.zero	8
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn, @function
math_prime_util__count__lmo__storage__factor_holders__holderFDXnn:
.LFB137:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L485
	movq	8(%rdi), %rax
	movq	%rdi, %rdx
	testq	%rax, %rax
	je	.L470
	lock subl	$1, (%rax)
	je	.L486
.L473:
	movq	$0, 8(%rdx)
.L470:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L486:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L474
	subq	$8, %rdi
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rcx
	movq	(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L474:
	movq	%rax, %rdi
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rdx
	jmp	.L473
.L485:
	call	math_prime_util__count__lmo__storage__factor_holders__finalize__2.part.0
	.cfi_endproc
.LFE137:
	.size	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn, .-math_prime_util__count__lmo__storage__factor_holders__holderFDXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__holderDF__2
	.type	math_prime_util__count__lmo__storage__factor_holders__holderDF__2, @function
math_prime_util__count__lmo__storage__factor_holders__holderDF__2:
.LFB144:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L502
	movq	8(%rdi), %rax
	movq	%rdi, %rdx
	testq	%rax, %rax
	je	.L487
	lock subl	$1, (%rax)
	je	.L503
.L490:
	movq	$0, 8(%rdx)
.L487:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L503:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L491
	subq	$8, %rdi
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rcx
	movq	(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L491:
	movq	%rax, %rdi
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rdx
	jmp	.L490
.L502:
	call	math_prime_util__count__lmo__storage__factor_holders__finalize__2.part.0
	.cfi_endproc
.LFE144:
	.size	math_prime_util__count__lmo__storage__factor_holders__holderDF__2, .-math_prime_util__count__lmo__storage__factor_holders__holderDF__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_control_typeFDXnn
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typeFDXnn, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typeFDXnn:
.LFB91:
	.cfi_startproc
	movq	8(%rdi), %rdx
	testq	%rdx, %rdx
	je	.L518
	movq	8(%rdx), %rdx
	movq	%rdi, %rax
	lock subl	$1, (%rdx)
	jne	.L519
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdx), %rdi
	testq	%rdi, %rdi
	je	.L507
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rcx
	movq	(%rsp), %rdx
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rax
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rdx)
.L507:
	movq	%rdx, %rdi
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rax
	movq	8(%rax), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rax)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L518:
	ret
	.p2align 4,,10
	.p2align 3
.L519:
	movq	8(%rdi), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rdi)
	ret
	.cfi_endproc
.LFE91:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typeFDXnn, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typeFDXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_control_typeDF__2
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typeDF__2, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typeDF__2:
.LFB102:
	.cfi_startproc
	movq	8(%rdi), %rdx
	testq	%rdx, %rdx
	je	.L536
	movq	8(%rdx), %rdx
	movq	%rdi, %rax
	lock subl	$1, (%rdx)
	jne	.L537
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdx), %rdi
	testq	%rdi, %rdi
	je	.L525
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rcx
	movq	(%rsp), %rdx
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rax
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rdx)
.L525:
	movq	%rdx, %rdi
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rax
	movq	8(%rax), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rax)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L536:
	ret
	.p2align 4,,10
	.p2align 3
.L537:
	movq	8(%rdi), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rdi)
	ret
	.cfi_endproc
.LFE102:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typeDF__2, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typeDF__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeFDXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeFDXnn, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typeFDXnn:
.LFB147:
	.cfi_startproc
	movq	8(%rdi), %rdx
	testq	%rdx, %rdx
	je	.L554
	movq	8(%rdx), %rdx
	movq	%rdi, %rax
	lock subl	$1, (%rdx)
	jne	.L555
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdx), %rdi
	testq	%rdi, %rdi
	je	.L543
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rcx
	movq	(%rsp), %rdx
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rax
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rdx)
.L543:
	movq	%rdx, %rdi
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rax
	movq	8(%rax), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rax)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L554:
	ret
	.p2align 4,,10
	.p2align 3
.L555:
	movq	8(%rdi), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rdi)
	ret
	.cfi_endproc
.LFE147:
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeFDXnn, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typeFDXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDF__2
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDF__2, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDF__2:
.LFB158:
	.cfi_startproc
	movq	8(%rdi), %rdx
	testq	%rdx, %rdx
	je	.L572
	movq	8(%rdx), %rdx
	movq	%rdi, %rax
	lock subl	$1, (%rdx)
	jne	.L573
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdx), %rdi
	testq	%rdi, %rdi
	je	.L561
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rcx
	movq	(%rsp), %rdx
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rax
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rdx)
.L561:
	movq	%rdx, %rdi
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rax
	movq	8(%rax), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rax)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L572:
	ret
	.p2align 4,,10
	.p2align 3
.L573:
	movq	8(%rdi), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rdi)
	ret
	.cfi_endproc
.LFE158:
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDF__2, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typeDF__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__clear
	.type	math_prime_util__count__lmo__storage__word_holders__clear, @function
math_prime_util__count__lmo__storage__word_holders__clear:
.LFB6:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L591
	movq	8(%rdi), %rax
	movq	%rdi, %rdx
	testq	%rax, %rax
	je	.L576
	lock subl	$1, (%rax)
	je	.L592
.L579:
	movq	$0, 8(%rdx)
.L576:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L592:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L580
	subq	$8, %rdi
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rcx
	movq	(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L580:
	movq	%rax, %rdi
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rdx
	jmp	.L579
.L591:
	call	math_prime_util__count__lmo__storage__word_holders__clear.part.0
	.cfi_endproc
.LFE6:
	.size	math_prime_util__count__lmo__storage__word_holders__clear, .-math_prime_util__count__lmo__storage__word_holders__clear
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__finalize__2
	.type	math_prime_util__count__lmo__storage__word_holders__finalize__2, @function
math_prime_util__count__lmo__storage__word_holders__finalize__2:
.LFB15:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L608
	movq	8(%rdi), %rax
	movq	%rdi, %rdx
	testq	%rax, %rax
	je	.L593
	lock subl	$1, (%rax)
	je	.L609
.L596:
	movq	$0, 8(%rdx)
.L593:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L609:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L597
	subq	$8, %rdi
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rcx
	movq	(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L597:
	movq	%rax, %rdi
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rdx
	jmp	.L596
.L608:
	call	math_prime_util__count__lmo__storage__word_holders__finalize__2.part.0
	.cfi_endproc
.LFE15:
	.size	math_prime_util__count__lmo__storage__word_holders__finalize__2, .-math_prime_util__count__lmo__storage__word_holders__finalize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__clear
	.type	math_prime_util__count__lmo__storage__factor_holders__clear, @function
math_prime_util__count__lmo__storage__factor_holders__clear:
.LFB42:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L625
	movq	8(%rdi), %rax
	movq	%rdi, %rdx
	testq	%rax, %rax
	je	.L610
	lock subl	$1, (%rax)
	je	.L626
.L613:
	movq	$0, 8(%rdx)
.L610:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L626:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L614
	subq	$8, %rdi
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rcx
	movq	(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L614:
	movq	%rax, %rdi
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rdx
	jmp	.L613
.L625:
	call	math_prime_util__count__lmo__storage__factor_holders__clear.part.0
	.cfi_endproc
.LFE42:
	.size	math_prime_util__count__lmo__storage__factor_holders__clear, .-math_prime_util__count__lmo__storage__factor_holders__clear
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__finalize__2
	.type	math_prime_util__count__lmo__storage__factor_holders__finalize__2, @function
math_prime_util__count__lmo__storage__factor_holders__finalize__2:
.LFB51:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L642
	movq	8(%rdi), %rax
	movq	%rdi, %rdx
	testq	%rax, %rax
	je	.L627
	lock subl	$1, (%rax)
	je	.L643
.L630:
	movq	$0, 8(%rdx)
.L627:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L643:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L631
	subq	$8, %rdi
	movq	%rdx, 8(%rsp)
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rcx
	movq	(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L631:
	movq	%rax, %rdi
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rdx
	jmp	.L630
.L642:
	call	math_prime_util__count__lmo__storage__factor_holders__finalize__2.part.0
	.cfi_endproc
.LFE51:
	.size	math_prime_util__count__lmo__storage__factor_holders__finalize__2, .-math_prime_util__count__lmo__storage__factor_holders__finalize__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__finalize__4
	.type	math_prime_util__count__lmo__storage__word_holders__finalize__4, @function
math_prime_util__count__lmo__storage__word_holders__finalize__4:
.LFB16:
	.cfi_startproc
	movq	8(%rdi), %rdx
	testq	%rdx, %rdx
	je	.L658
	movq	8(%rdx), %rdx
	movq	%rdi, %rax
	lock subl	$1, (%rdx)
	jne	.L659
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdx), %rdi
	testq	%rdi, %rdi
	je	.L647
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rcx
	movq	(%rsp), %rdx
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rax
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rdx)
.L647:
	movq	%rdx, %rdi
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rax
	movq	8(%rax), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rax)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L658:
	ret
	.p2align 4,,10
	.p2align 3
.L659:
	movq	8(%rdi), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rdi)
	ret
	.cfi_endproc
.LFE16:
	.size	math_prime_util__count__lmo__storage__word_holders__finalize__4, .-math_prime_util__count__lmo__storage__word_holders__finalize__4
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__finalize__4
	.type	math_prime_util__count__lmo__storage__factor_holders__finalize__4, @function
math_prime_util__count__lmo__storage__factor_holders__finalize__4:
.LFB52:
	.cfi_startproc
	movq	8(%rdi), %rdx
	testq	%rdx, %rdx
	je	.L676
	movq	8(%rdx), %rdx
	movq	%rdi, %rax
	lock subl	$1, (%rdx)
	jne	.L677
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdx), %rdi
	testq	%rdi, %rdi
	je	.L665
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	movq	%rdx, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rcx
	movq	(%rsp), %rdx
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	8(%rsp), %rax
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rdx)
.L665:
	movq	%rdx, %rdi
	movq	%rax, (%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rax
	movq	8(%rax), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rax)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L676:
	ret
	.p2align 4,,10
	.p2align 3
.L677:
	movq	8(%rdi), %rdx
	subl	$1, 16(%rdx)
	movq	$0, 8(%rdi)
	ret
	.cfi_endproc
.LFE52:
	.size	math_prime_util__count__lmo__storage__factor_holders__finalize__4, .-math_prime_util__count__lmo__storage__factor_holders__finalize__4
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__holderDA__2
	.type	math_prime_util__count__lmo__storage__word_holders__holderDA__2, @function
math_prime_util__count__lmo__storage__word_holders__holderDA__2:
.LFB87:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L681
	movl	16(%rdi), %edx
	testl	%edx, %edx
	je	.L691
	movq	16(%rax), %rax
	movl	$8, %edi
	movslq	(%rax), %rsi
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%rsi, %rax
	leaq	16(,%rax,8), %rax
	cmpl	%edx, %esi
	cmovle	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	%rax, %rcx
	movq	8(%rbx), %rax
	movq	%rcx, 8(%rsp)
	movq	16(%rax), %rdx
	movq	8(%rax), %r9
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %edi
	movq	%xmm0, (%rcx)
	movslq	%esi, %r8
	movslq	%edi, %rax
	subq	%r8, %rax
	cmpl	%esi, %edi
	leaq	8(%rcx), %r8
	movq	%r9, %rsi
	leaq	8(,%rax,8), %rax
	movq	%r8, %rdi
	movq	%r8, (%rsp)
	cmovge	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%r8, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	%rax, 8(%rbx)
.L681:
	movl	$0, 16(%rbx)
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L691:
	.cfi_restore_state
	lock addl	$1, (%rax)
	movl	$0, 16(%rbx)
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE87:
	.size	math_prime_util__count__lmo__storage__word_holders__holderDA__2, .-math_prime_util__count__lmo__storage__word_holders__holderDA__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__holderDA__2
	.type	math_prime_util__count__lmo__storage__factor_holders__holderDA__2, @function
math_prime_util__count__lmo__storage__factor_holders__holderDA__2:
.LFB143:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L693
	movl	16(%rdi), %edx
	testl	%edx, %edx
	je	.L703
	movq	16(%rax), %rax
	movl	$8, %edi
	movslq	(%rax), %rsi
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%rsi, %rax
	leaq	13(%rax,%rax), %rax
	andq	$-4, %rax
	cmpl	%edx, %esi
	cmovle	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	%rax, %rcx
	movq	8(%rbx), %rax
	movq	%rcx, 8(%rsp)
	movq	16(%rax), %rdx
	movq	8(%rax), %r9
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %edi
	movq	%xmm0, (%rcx)
	movslq	%esi, %r8
	movslq	%edi, %rax
	subq	%r8, %rax
	cmpl	%esi, %edi
	leaq	8(%rcx), %r8
	movq	%r9, %rsi
	leaq	2(%rax,%rax), %rax
	movq	%r8, %rdi
	movq	%r8, (%rsp)
	cmovge	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	(%rsp), %r8
	movq	8(%rsp), %rcx
	movq	%r8, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	%rax, 8(%rbx)
.L693:
	movl	$0, 16(%rbx)
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L703:
	.cfi_restore_state
	lock addl	$1, (%rax)
	movl	$0, 16(%rbx)
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE143:
	.size	math_prime_util__count__lmo__storage__factor_holders__holderDA__2, .-math_prime_util__count__lmo__storage__factor_holders__holderDA__2
	.section	.rodata
.LC36:
	.ascii	"a-coinho.ads"
	.zero	1
	.section	.text.unlikely
	.align 2
.LCOLDB37:
	.text
.LHOTB37:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn:
.LFB108:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA108
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rbx, (%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%r14, 16(%rsp)
.LEHB8:
	.cfi_offset 14, -16
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE8:
	movl	%eax, %r14d
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L704
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -24
	movq	8(%rax), %rbp
	lock subl	$1, 0(%rbp)
	je	.L706
.L708:
	movq	24(%rbx), %rax
	movq	8(%rsp), %rbp
	.cfi_restore 6
	subl	$1, 16(%rax)
	movq	$0, 24(%rbx)
.L704:
	movq	(%rsp), %rbx
	movq	16(%rsp), %r14
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L706:
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -24
	movq	8(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L707
	subq	$8, %rdi
.LEHB9:
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rbp)
.L707:
	movq	%rbp, %rdi
	call	__gnat_free@PLT
.LEHE9:
	jmp	.L708
.L712:
	movq	%rax, %rbx
	jmp	.L709
	.section	.gcc_except_table
	.align 4
.LLSDA108:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT108-.LLSDATTD108
.LLSDATTD108:
	.byte	0x1
	.uleb128 .LLSDACSE108-.LLSDACSB108
.LLSDACSB108:
	.uleb128 .LEHB8-.LFB108
	.uleb128 .LEHE8-.LEHB8
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB9-.LFB108
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L712-.LFB108
	.uleb128 0x1
.LLSDACSE108:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT108:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC108
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn.cold, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn.cold:
.LFSB108:
.L709:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L721
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB10:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	je	.L711
	movq	8(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	jmp	.L704
.L721:
	.cfi_restore_state
	call	_Unwind_Resume@PLT
.L711:
	movl	$158, %esi
	leaq	.LC36(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.LEHE10:
	.cfi_endproc
.LFE108:
	.section	.gcc_except_table
	.align 4
.LLSDAC108:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC108-.LLSDATTDC108
.LLSDATTDC108:
	.byte	0x1
	.uleb128 .LLSDACSEC108-.LLSDACSBC108
.LLSDACSBC108:
	.uleb128 .LEHB10-.LCOLDB37
	.uleb128 .LEHE10-.LEHB10
	.uleb128 0
	.uleb128 0
.LLSDACSEC108:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC108:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn.cold, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn.cold
.LCOLDE37:
	.text
.LHOTE37:
	.section	.text.unlikely
	.align 2
.LCOLDB38:
	.text
.LHOTB38:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn:
.LFB115:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA115
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rbx, (%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%r14, 16(%rsp)
.LEHB11:
	.cfi_offset 14, -16
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE11:
	movl	%eax, %r14d
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L722
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -24
	movq	8(%rax), %rbp
	lock subl	$1, 0(%rbp)
	je	.L724
.L726:
	movq	24(%rbx), %rax
	movq	8(%rsp), %rbp
	.cfi_restore 6
	subl	$1, 16(%rax)
	movq	$0, 24(%rbx)
.L722:
	movq	(%rsp), %rbx
	movq	16(%rsp), %r14
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L724:
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -24
	movq	8(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L725
	subq	$8, %rdi
.LEHB12:
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rbp)
.L725:
	movq	%rbp, %rdi
	call	__gnat_free@PLT
.LEHE12:
	jmp	.L726
.L730:
	movq	%rax, %rbx
	jmp	.L727
	.section	.gcc_except_table
	.align 4
.LLSDA115:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT115-.LLSDATTD115
.LLSDATTD115:
	.byte	0x1
	.uleb128 .LLSDACSE115-.LLSDACSB115
.LLSDACSB115:
	.uleb128 .LEHB11-.LFB115
	.uleb128 .LEHE11-.LEHB11
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB12-.LFB115
	.uleb128 .LEHE12-.LEHB12
	.uleb128 .L730-.LFB115
	.uleb128 0x1
.LLSDACSE115:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT115:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC115
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn.cold, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn.cold:
.LFSB115:
.L727:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L739
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB13:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	je	.L729
	movq	8(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	jmp	.L722
.L739:
	.cfi_restore_state
	call	_Unwind_Resume@PLT
.L729:
	movl	$180, %esi
	leaq	.LC36(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.LEHE13:
	.cfi_endproc
.LFE115:
	.section	.gcc_except_table
	.align 4
.LLSDAC115:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC115-.LLSDATTDC115
.LLSDATTDC115:
	.byte	0x1
	.uleb128 .LLSDACSEC115-.LLSDACSBC115
.LLSDACSBC115:
	.uleb128 .LEHB13-.LCOLDB38
	.uleb128 .LEHE13-.LEHB13
	.uleb128 0
	.uleb128 0
.LLSDACSEC115:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC115:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn, .-math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn.cold, .-math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn.cold
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
	.globl	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeFDXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeFDXnn, @function
math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeFDXnn:
.LFB164:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA164
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rbx, (%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%r14, 16(%rsp)
.LEHB14:
	.cfi_offset 14, -16
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE14:
	movl	%eax, %r14d
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L740
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -24
	movq	8(%rax), %rbp
	lock subl	$1, 0(%rbp)
	je	.L742
.L744:
	movq	24(%rbx), %rax
	movq	8(%rsp), %rbp
	.cfi_restore 6
	subl	$1, 16(%rax)
	movq	$0, 24(%rbx)
.L740:
	movq	(%rsp), %rbx
	movq	16(%rsp), %r14
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L742:
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -24
	movq	8(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L743
	subq	$8, %rdi
.LEHB15:
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rbp)
.L743:
	movq	%rbp, %rdi
	call	__gnat_free@PLT
.LEHE15:
	jmp	.L744
.L748:
	movq	%rax, %rbx
	jmp	.L745
	.section	.gcc_except_table
	.align 4
.LLSDA164:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT164-.LLSDATTD164
.LLSDATTD164:
	.byte	0x1
	.uleb128 .LLSDACSE164-.LLSDACSB164
.LLSDACSB164:
	.uleb128 .LEHB14-.LFB164
	.uleb128 .LEHE14-.LEHB14
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB15-.LFB164
	.uleb128 .LEHE15-.LEHB15
	.uleb128 .L748-.LFB164
	.uleb128 0x1
.LLSDACSE164:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT164:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC164
	.type	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeFDXnn.cold, @function
math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeFDXnn.cold:
.LFSB164:
.L745:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L757
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB16:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	je	.L747
	movq	8(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	jmp	.L740
.L757:
	.cfi_restore_state
	call	_Unwind_Resume@PLT
.L747:
	movl	$158, %esi
	leaq	.LC36(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.LEHE16:
	.cfi_endproc
.LFE164:
	.section	.gcc_except_table
	.align 4
.LLSDAC164:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC164-.LLSDATTDC164
.LLSDATTDC164:
	.byte	0x1
	.uleb128 .LLSDACSEC164-.LLSDACSBC164
.LLSDACSBC164:
	.uleb128 .LEHB16-.LCOLDB39
	.uleb128 .LEHE16-.LEHB16
	.uleb128 0
	.uleb128 0
.LLSDACSEC164:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC164:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeFDXnn, .-math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeFDXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeFDXnn.cold, .-math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeFDXnn.cold
.LCOLDE39:
	.text
.LHOTE39:
	.section	.text.unlikely
	.align 2
.LCOLDB40:
	.text
.LHOTB40:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_typeFDXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_typeFDXnn, @function
math_prime_util__count__lmo__storage__factor_holders__reference_typeFDXnn:
.LFB171:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA171
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rbx, (%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%r14, 16(%rsp)
.LEHB17:
	.cfi_offset 14, -16
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE17:
	movl	%eax, %r14d
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L758
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -24
	movq	8(%rax), %rbp
	lock subl	$1, 0(%rbp)
	je	.L760
.L762:
	movq	24(%rbx), %rax
	movq	8(%rsp), %rbp
	.cfi_restore 6
	subl	$1, 16(%rax)
	movq	$0, 24(%rbx)
.L758:
	movq	(%rsp), %rbx
	movq	16(%rsp), %r14
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L760:
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -24
	movq	8(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L761
	subq	$8, %rdi
.LEHB18:
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rbp)
.L761:
	movq	%rbp, %rdi
	call	__gnat_free@PLT
.LEHE18:
	jmp	.L762
.L766:
	movq	%rax, %rbx
	jmp	.L763
	.section	.gcc_except_table
	.align 4
.LLSDA171:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT171-.LLSDATTD171
.LLSDATTD171:
	.byte	0x1
	.uleb128 .LLSDACSE171-.LLSDACSB171
.LLSDACSB171:
	.uleb128 .LEHB17-.LFB171
	.uleb128 .LEHE17-.LEHB17
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB18-.LFB171
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L766-.LFB171
	.uleb128 0x1
.LLSDACSE171:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT171:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC171
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_typeFDXnn.cold, @function
math_prime_util__count__lmo__storage__factor_holders__reference_typeFDXnn.cold:
.LFSB171:
.L763:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L775
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB19:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	je	.L765
	movq	8(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	jmp	.L758
.L775:
	.cfi_restore_state
	call	_Unwind_Resume@PLT
.L765:
	movl	$180, %esi
	leaq	.LC36(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.LEHE19:
	.cfi_endproc
.LFE171:
	.section	.gcc_except_table
	.align 4
.LLSDAC171:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC171-.LLSDATTDC171
.LLSDATTDC171:
	.byte	0x1
	.uleb128 .LLSDACSEC171-.LLSDACSBC171
.LLSDACSBC171:
	.uleb128 .LEHB19-.LCOLDB40
	.uleb128 .LEHE19-.LEHB19
	.uleb128 0
	.uleb128 0
.LLSDACSEC171:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC171:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_typeFDXnn, .-math_prime_util__count__lmo__storage__factor_holders__reference_typeFDXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_typeFDXnn.cold, .-math_prime_util__count__lmo__storage__factor_holders__reference_typeFDXnn.cold
.LCOLDE40:
	.text
.LHOTE40:
	.section	.rodata.str1.8
	.align 8
.LC41:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Assign: attempt to tamper with elements"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__assign
	.type	math_prime_util__count__lmo__storage__word_holders__assign, @function
math_prime_util__count__lmo__storage__word_holders__assign:
.LFB5:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L792
	movq	8(%rdi), %rdx
	movq	8(%rsi), %rax
	movq	%rdi, %rcx
	cmpq	%rax, %rdx
	je	.L776
	testq	%rdx, %rdx
	je	.L779
	lock subl	$1, (%rdx)
	jne	.L793
	movq	8(%rdx), %rdi
	testq	%rdi, %rdi
	je	.L781
	subq	$8, %rdi
	movq	%rsi, 24(%rsp)
	movq	%rcx, 16(%rsp)
	movq	%rdx, 8(%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rax
	movq	8(%rsp), %rdx
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	movq	24(%rsp), %rsi
	movq	16(%rsp), %rcx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rdx)
.L781:
	movq	%rdx, %rdi
	movq	%rsi, 16(%rsp)
	movq	%rcx, 8(%rsp)
	call	__gnat_free@PLT
	movq	16(%rsp), %rsi
	movq	8(%rsp), %rcx
	movq	8(%rsi), %rax
.L779:
	movq	%rax, 8(%rcx)
	testq	%rax, %rax
	je	.L776
.L794:
	lock addl	$1, (%rax)
.L776:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L793:
	.cfi_restore_state
	movq	8(%rsi), %rax
	movq	%rax, 8(%rcx)
	testq	%rax, %rax
	jne	.L794
	jmp	.L776
.L792:
	leaq	.LC41(%rip), %rsi
	leaq	.LC0(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE5:
	.size	math_prime_util__count__lmo__storage__word_holders__assign, .-math_prime_util__count__lmo__storage__word_holders__assign
	.section	.rodata.str1.8
	.align 8
.LC42:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Assign: attempt to tamper with elements"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__assign
	.type	math_prime_util__count__lmo__storage__factor_holders__assign, @function
math_prime_util__count__lmo__storage__factor_holders__assign:
.LFB41:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	16(%rdi), %eax
	testl	%eax, %eax
	jne	.L811
	movq	8(%rdi), %rdx
	movq	8(%rsi), %rax
	movq	%rdi, %rcx
	cmpq	%rax, %rdx
	je	.L795
	testq	%rdx, %rdx
	je	.L798
	lock subl	$1, (%rdx)
	jne	.L812
	movq	8(%rdx), %rdi
	testq	%rdi, %rdi
	je	.L800
	subq	$8, %rdi
	movq	%rsi, 24(%rsp)
	movq	%rcx, 16(%rsp)
	movq	%rdx, 8(%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rax
	movq	8(%rsp), %rdx
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	movq	24(%rsp), %rsi
	movq	16(%rsp), %rcx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rdx)
.L800:
	movq	%rdx, %rdi
	movq	%rsi, 16(%rsp)
	movq	%rcx, 8(%rsp)
	call	__gnat_free@PLT
	movq	16(%rsp), %rsi
	movq	8(%rsp), %rcx
	movq	8(%rsi), %rax
.L798:
	movq	%rax, 8(%rcx)
	testq	%rax, %rax
	je	.L795
.L813:
	lock addl	$1, (%rax)
.L795:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L812:
	.cfi_restore_state
	movq	8(%rsi), %rax
	movq	%rax, 8(%rcx)
	testq	%rax, %rax
	jne	.L813
	jmp	.L795
.L811:
	leaq	.LC42(%rip), %rsi
	leaq	.LC3(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE41:
	.size	math_prime_util__count__lmo__storage__factor_holders__assign, .-math_prime_util__count__lmo__storage__factor_holders__assign
	.section	.rodata.str1.8
	.align 8
.LC43:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Move: attempt to tamper with elements"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__move
	.type	math_prime_util__count__lmo__storage__word_holders__move, @function
math_prime_util__count__lmo__storage__word_holders__move:
.LFB18:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	16(%rdi), %edx
	testl	%edx, %edx
	jne	.L828
	movl	16(%rsi), %eax
	testl	%eax, %eax
	jne	.L828
	movq	8(%rdi), %rax
	movq	8(%rsi), %rcx
	movq	%rdi, %rdx
	cmpq	%rcx, %rax
	je	.L814
	testq	%rax, %rax
	je	.L818
	lock subl	$1, (%rax)
	jne	.L829
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L820
	subq	$8, %rdi
	movq	%rsi, 24(%rsp)
	movq	%rdx, 16(%rsp)
	movq	%rax, 8(%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rcx
	movq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	24(%rsp), %rsi
	movq	16(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L820:
	movq	%rax, %rdi
	movq	%rsi, 16(%rsp)
	movq	%rdx, 8(%rsp)
	call	__gnat_free@PLT
	movq	16(%rsp), %rsi
	movq	8(%rsp), %rdx
	movq	8(%rsi), %rcx
.L818:
	movq	%rcx, 8(%rdx)
	movq	$0, 8(%rsi)
.L814:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L829:
	.cfi_restore_state
	movq	8(%rsi), %rcx
	jmp	.L818
.L828:
	leaq	.LC43(%rip), %rsi
	leaq	.LC4(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE18:
	.size	math_prime_util__count__lmo__storage__word_holders__move, .-math_prime_util__count__lmo__storage__word_holders__move
	.section	.rodata.str1.8
	.align 8
.LC44:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Move: attempt to tamper with elements"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__move
	.type	math_prime_util__count__lmo__storage__factor_holders__move, @function
math_prime_util__count__lmo__storage__factor_holders__move:
.LFB54:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movl	16(%rdi), %edx
	testl	%edx, %edx
	jne	.L844
	movl	16(%rsi), %eax
	testl	%eax, %eax
	jne	.L844
	movq	8(%rdi), %rax
	movq	8(%rsi), %rcx
	movq	%rdi, %rdx
	cmpq	%rcx, %rax
	je	.L830
	testq	%rax, %rax
	je	.L834
	lock subl	$1, (%rax)
	jne	.L845
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L836
	subq	$8, %rdi
	movq	%rsi, 24(%rsp)
	movq	%rdx, 16(%rsp)
	movq	%rax, 8(%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rcx
	movq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rcx, %xmm1
	movq	24(%rsp), %rsi
	movq	16(%rsp), %rdx
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rax)
.L836:
	movq	%rax, %rdi
	movq	%rsi, 16(%rsp)
	movq	%rdx, 8(%rsp)
	call	__gnat_free@PLT
	movq	16(%rsp), %rsi
	movq	8(%rsp), %rdx
	movq	8(%rsi), %rcx
.L834:
	movq	%rcx, 8(%rdx)
	movq	$0, 8(%rsi)
.L830:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L845:
	.cfi_restore_state
	movq	8(%rsi), %rcx
	jmp	.L834
.L844:
	leaq	.LC44(%rip), %rsi
	leaq	.LC0(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE54:
	.size	math_prime_util__count__lmo__storage__factor_holders__move, .-math_prime_util__count__lmo__storage__factor_holders__move
	.section	.text.unlikely
	.align 2
.LCOLDB45:
	.text
.LHOTB45:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders___assign__3
	.type	math_prime_util__count__lmo__storage__factor_holders___assign__3, @function
math_prime_util__count__lmo__storage__factor_holders___assign__3:
.LFB142:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA142
	subq	$664, %rsp
	.cfi_def_cfa_offset 672
	movq	%rbx, 640(%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%rbp, 648(%rsp)
	.cfi_offset 6, -24
	movq	%rsi, %rbp
.LEHB20:
	call	*system__soft_links__abort_defer(%rip)
.LEHE20:
	cmpq	%rbp, %rbx
	jne	.L880
.L847:
	movq	640(%rsp), %rbx
	movq	648(%rsp), %rbp
	addq	$664, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
.LEHB21:
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE21:
	.p2align 4,,10
	.p2align 3
.L880:
	.cfi_restore_state
	movl	16(%rbx), %ecx
	movq	%r12, 656(%rsp)
	testl	%ecx, %ecx
	.cfi_offset 12, -16
	jne	.L881
	movq	8(%rbx), %r12
	testq	%r12, %r12
	je	.L849
	lock subl	$1, (%r12)
	je	.L882
.L850:
	movq	$0, 8(%rbx)
.L849:
	movq	(%rbx), %rax
	movdqu	0(%rbp), %xmm0
	movups	%xmm0, (%rbx)
	movq	16(%rbp), %rdx
	movq	%rax, (%rbx)
	movq	8(%rbx), %rax
	movq	%rdx, 16(%rbx)
	testq	%rax, %rax
	je	.L852
	movl	16(%rbx), %edx
	testl	%edx, %edx
	je	.L883
	movq	16(%rax), %rax
	movl	$8, %edi
	movslq	(%rax), %rsi
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%rsi, %rax
	leaq	13(%rax,%rax), %rax
	andq	$-4, %rax
	cmpl	%edx, %esi
	cmovle	%rax, %rdi
.LEHB22:
	call	__gnat_malloc@PLT
	movq	%rax, %rbp
	movq	8(%rbx), %rax
	leaq	8(%rbp), %r12
	movq	16(%rax), %rdx
	movq	8(%rax), %rdi
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %ecx
	movq	%xmm0, 0(%rbp)
	movslq	%esi, %r8
	movslq	%ecx, %rax
	subq	%r8, %rax
	cmpl	%ecx, %esi
	movq	%rdi, %rsi
	movq	%r12, %rdi
	leaq	2(%rax,%rax), %rax
	cmovle	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	%r12, 8(%rax)
	movq	%rbp, 16(%rax)
	movq	%rax, 8(%rbx)
.L852:
	movl	$0, 16(%rbx)
	movq	656(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	jmp	.L847
	.p2align 4,,10
	.p2align 3
.L882:
	.cfi_restore_state
	movq	8(%r12), %rdi
	testq	%rdi, %rdi
	je	.L851
	subq	$8, %rdi
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, 8(%r12)
.L851:
	movq	%r12, %rdi
	call	__gnat_free@PLT
	jmp	.L850
	.p2align 4,,10
	.p2align 3
.L883:
	lock addl	$1, (%rax)
	jmp	.L852
.L881:
	call	math_prime_util__count__lmo__storage__factor_holders__finalize__2.part.0
.LEHE22:
.L877:
	.cfi_restore 12
	jmp	.L878
.L863:
	.cfi_offset 12, -16
	movq	%rax, %rbp
	jmp	.L856
	.section	.gcc_except_table
	.align 4
.LLSDA142:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT142-.LLSDATTD142
.LLSDATTD142:
	.byte	0x1
	.uleb128 .LLSDACSE142-.LLSDACSB142
.LLSDACSB142:
	.uleb128 .LEHB20-.LFB142
	.uleb128 .LEHE20-.LEHB20
	.uleb128 .L877-.LFB142
	.uleb128 0
	.uleb128 .LEHB21-.LFB142
	.uleb128 .LEHE21-.LEHB21
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB22-.LFB142
	.uleb128 .LEHE22-.LEHB22
	.uleb128 .L863-.LFB142
	.uleb128 0x3
.LLSDACSE142:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT142:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC142
	.type	math_prime_util__count__lmo__storage__factor_holders___assign__3.cold, @function
math_prime_util__count__lmo__storage__factor_holders___assign__3.cold:
.LFSB142:
	nop
.L862:
	.cfi_def_cfa_offset 672
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	656(%rsp), %r12
	.cfi_restore 12
.L878:
	movq	%r12, 656(%rsp)
	.cfi_offset 12, -16
	movq	%rax, %rbx
.L858:
.LEHB23:
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE23:
.L856:
	subq	$1, %rdx
	movq	%rax, %rbx
	jne	.L858
	movq	%rax, %rdi
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movq	%rax, %r12
.LEHB24:
	call	__gnat_set_exception_parameter@PLT
	movq	%rsp, %rdi
	call	__gnat_raise_from_controlled_operation@PLT
.LEHE24:
.L864:
	movq	%rax, %rdx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
.LEHB25:
	call	__gnat_end_handler_v1@PLT
.LEHE25:
	jmp	.L858
	.cfi_endproc
.LFE142:
	.section	.gcc_except_table
	.align 4
.LLSDAC142:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC142-.LLSDATTDC142
.LLSDATTDC142:
	.byte	0x1
	.uleb128 .LLSDACSEC142-.LLSDACSBC142
.LLSDACSBC142:
	.uleb128 .LEHB23-.LCOLDB45
	.uleb128 .LEHE23-.LEHB23
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB24-.LCOLDB45
	.uleb128 .LEHE24-.LEHB24
	.uleb128 .L864-.LCOLDB45
	.uleb128 0
	.uleb128 .LEHB25-.LCOLDB45
	.uleb128 .LEHE25-.LEHB25
	.uleb128 .L862-.LCOLDB45
	.uleb128 0
.LLSDACSEC142:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC142:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders___assign__3, .-math_prime_util__count__lmo__storage__factor_holders___assign__3
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders___assign__3.cold, .-math_prime_util__count__lmo__storage__factor_holders___assign__3.cold
.LCOLDE45:
	.text
.LHOTE45:
	.section	.text.unlikely
	.align 2
.LCOLDB46:
	.text
.LHOTB46:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders___assign__3
	.type	math_prime_util__count__lmo__storage__word_holders___assign__3, @function
math_prime_util__count__lmo__storage__word_holders___assign__3:
.LFB86:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA86
	subq	$664, %rsp
	.cfi_def_cfa_offset 672
	movq	%rbx, 640(%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%rbp, 648(%rsp)
	.cfi_offset 6, -24
	movq	%rsi, %rbp
.LEHB26:
	call	*system__soft_links__abort_defer(%rip)
.LEHE26:
	cmpq	%rbp, %rbx
	jne	.L918
.L885:
	movq	640(%rsp), %rbx
	movq	648(%rsp), %rbp
	addq	$664, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
.LEHB27:
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE27:
	.p2align 4,,10
	.p2align 3
.L918:
	.cfi_restore_state
	movl	16(%rbx), %ecx
	movq	%r12, 656(%rsp)
	testl	%ecx, %ecx
	.cfi_offset 12, -16
	jne	.L919
	movq	8(%rbx), %r12
	testq	%r12, %r12
	je	.L887
	lock subl	$1, (%r12)
	je	.L920
.L888:
	movq	$0, 8(%rbx)
.L887:
	movq	(%rbx), %rax
	movdqu	0(%rbp), %xmm0
	movups	%xmm0, (%rbx)
	movq	16(%rbp), %rdx
	movq	%rax, (%rbx)
	movq	8(%rbx), %rax
	movq	%rdx, 16(%rbx)
	testq	%rax, %rax
	je	.L890
	movl	16(%rbx), %edx
	testl	%edx, %edx
	je	.L921
	movq	16(%rax), %rax
	movl	$8, %edi
	movslq	(%rax), %rsi
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%rsi, %rax
	leaq	16(,%rax,8), %rax
	cmpl	%edx, %esi
	cmovle	%rax, %rdi
.LEHB28:
	call	__gnat_malloc@PLT
	movq	%rax, %rbp
	movq	8(%rbx), %rax
	leaq	8(%rbp), %r12
	movq	16(%rax), %rdx
	movq	8(%rax), %rdi
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %ecx
	movq	%xmm0, 0(%rbp)
	movslq	%esi, %r8
	movslq	%ecx, %rax
	subq	%r8, %rax
	cmpl	%ecx, %esi
	movq	%rdi, %rsi
	movq	%r12, %rdi
	leaq	8(,%rax,8), %rax
	cmovle	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	%r12, 8(%rax)
	movq	%rbp, 16(%rax)
	movq	%rax, 8(%rbx)
.L890:
	movl	$0, 16(%rbx)
	movq	656(%rsp), %r12
	.cfi_remember_state
	.cfi_restore 12
	jmp	.L885
	.p2align 4,,10
	.p2align 3
.L920:
	.cfi_restore_state
	movq	8(%r12), %rdi
	testq	%rdi, %rdi
	je	.L889
	subq	$8, %rdi
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, 8(%r12)
.L889:
	movq	%r12, %rdi
	call	__gnat_free@PLT
	jmp	.L888
	.p2align 4,,10
	.p2align 3
.L921:
	lock addl	$1, (%rax)
	jmp	.L890
.L919:
	call	math_prime_util__count__lmo__storage__word_holders__finalize__2.part.0
.LEHE28:
.L915:
	.cfi_restore 12
	jmp	.L916
.L901:
	.cfi_offset 12, -16
	movq	%rax, %rbp
	jmp	.L894
	.section	.gcc_except_table
	.align 4
.LLSDA86:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT86-.LLSDATTD86
.LLSDATTD86:
	.byte	0x1
	.uleb128 .LLSDACSE86-.LLSDACSB86
.LLSDACSB86:
	.uleb128 .LEHB26-.LFB86
	.uleb128 .LEHE26-.LEHB26
	.uleb128 .L915-.LFB86
	.uleb128 0
	.uleb128 .LEHB27-.LFB86
	.uleb128 .LEHE27-.LEHB27
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB28-.LFB86
	.uleb128 .LEHE28-.LEHB28
	.uleb128 .L901-.LFB86
	.uleb128 0x3
.LLSDACSE86:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT86:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC86
	.type	math_prime_util__count__lmo__storage__word_holders___assign__3.cold, @function
math_prime_util__count__lmo__storage__word_holders___assign__3.cold:
.LFSB86:
	nop
.L900:
	.cfi_def_cfa_offset 672
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	656(%rsp), %r12
	.cfi_restore 12
.L916:
	movq	%r12, 656(%rsp)
	.cfi_offset 12, -16
	movq	%rax, %rbx
.L896:
.LEHB29:
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE29:
.L894:
	subq	$1, %rdx
	movq	%rax, %rbx
	jne	.L896
	movq	%rax, %rdi
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movq	%rax, %r12
.LEHB30:
	call	__gnat_set_exception_parameter@PLT
	movq	%rsp, %rdi
	call	__gnat_raise_from_controlled_operation@PLT
.LEHE30:
.L902:
	movq	%rax, %rdx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
.LEHB31:
	call	__gnat_end_handler_v1@PLT
.LEHE31:
	jmp	.L896
	.cfi_endproc
.LFE86:
	.section	.gcc_except_table
	.align 4
.LLSDAC86:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC86-.LLSDATTDC86
.LLSDATTDC86:
	.byte	0x1
	.uleb128 .LLSDACSEC86-.LLSDACSBC86
.LLSDACSBC86:
	.uleb128 .LEHB29-.LCOLDB46
	.uleb128 .LEHE29-.LEHB29
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB30-.LCOLDB46
	.uleb128 .LEHE30-.LEHB30
	.uleb128 .L902-.LCOLDB46
	.uleb128 0
	.uleb128 .LEHB31-.LCOLDB46
	.uleb128 .LEHE31-.LEHB31
	.uleb128 .L900-.LCOLDB46
	.uleb128 0
.LLSDACSEC86:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC86:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders___assign__3, .-math_prime_util__count__lmo__storage__word_holders___assign__3
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders___assign__3.cold, .-math_prime_util__count__lmo__storage__word_holders___assign__3.cold
.LCOLDE46:
	.text
.LHOTE46:
	.section	.text.unlikely
	.align 2
.LCOLDB47:
	.text
.LHOTB47:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders___assign__4
	.type	math_prime_util__count__lmo__storage__word_holders___assign__4, @function
math_prime_util__count__lmo__storage__word_holders___assign__4:
.LFB100:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA100
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$640, %rsp
	.cfi_def_cfa_offset 672
.LEHB32:
	call	*system__soft_links__abort_defer(%rip)
.LEHE32:
	cmpq	%rbp, %rbx
	jne	.L948
.L923:
	addq	$640, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
.LEHB33:
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE33:
	.p2align 4,,10
	.p2align 3
.L948:
	.cfi_restore_state
	movq	8(%rbx), %rax
	testq	%rax, %rax
	je	.L924
	movq	8(%rax), %rax
	movq	%rax, %r14
	lock subl	$1, (%rax)
	jne	.L927
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L926
	subq	$8, %rdi
.LEHB34:
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%r14)
.L926:
	movq	%r14, %rdi
	call	__gnat_free@PLT
.L927:
	movq	8(%rbx), %rax
	subl	$1, 16(%rax)
	movq	$0, 8(%rbx)
.L924:
	movq	(%rbx), %rax
	movdqu	0(%rbp), %xmm0
	movups	%xmm0, (%rbx)
	movq	%rax, (%rbx)
	movq	8(%rbx), %rax
	testq	%rax, %rax
	je	.L923
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	8(%rbx), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L949
	addl	$1, %eax
	movl	%eax, 16(%rdx)
	jmp	.L923
.L949:
	movl	$98, %esi
	leaq	.LC24(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE34:
.L934:
	movq	%rax, %rbp
	jmp	.L929
.L945:
	jmp	.L946
	.section	.gcc_except_table
	.align 4
.LLSDA100:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT100-.LLSDATTD100
.LLSDATTD100:
	.byte	0x1
	.uleb128 .LLSDACSE100-.LLSDACSB100
.LLSDACSB100:
	.uleb128 .LEHB32-.LFB100
	.uleb128 .LEHE32-.LEHB32
	.uleb128 .L945-.LFB100
	.uleb128 0
	.uleb128 .LEHB33-.LFB100
	.uleb128 .LEHE33-.LEHB33
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB34-.LFB100
	.uleb128 .LEHE34-.LEHB34
	.uleb128 .L934-.LFB100
	.uleb128 0x3
.LLSDACSE100:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT100:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC100
	.type	math_prime_util__count__lmo__storage__word_holders___assign__4.cold, @function
math_prime_util__count__lmo__storage__word_holders___assign__4.cold:
.LFSB100:
.L929:
	.cfi_def_cfa_offset 672
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rbx
	jne	.L931
	movq	%rax, %rdi
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movq	%rax, %r14
.LEHB35:
	call	__gnat_set_exception_parameter@PLT
	movq	%rsp, %rdi
	call	__gnat_raise_from_controlled_operation@PLT
.LEHE35:
.L933:
.L946:
	movq	%rax, %rbx
.L931:
.LEHB36:
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE36:
.L935:
	movq	%rax, %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
.LEHB37:
	call	__gnat_end_handler_v1@PLT
.LEHE37:
	jmp	.L931
	.cfi_endproc
.LFE100:
	.section	.gcc_except_table
	.align 4
.LLSDAC100:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC100-.LLSDATTDC100
.LLSDATTDC100:
	.byte	0x1
	.uleb128 .LLSDACSEC100-.LLSDACSBC100
.LLSDACSBC100:
	.uleb128 .LEHB35-.LCOLDB47
	.uleb128 .LEHE35-.LEHB35
	.uleb128 .L935-.LCOLDB47
	.uleb128 0
	.uleb128 .LEHB36-.LCOLDB47
	.uleb128 .LEHE36-.LEHB36
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB37-.LCOLDB47
	.uleb128 .LEHE37-.LEHB37
	.uleb128 .L933-.LCOLDB47
	.uleb128 0
.LLSDACSEC100:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC100:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders___assign__4, .-math_prime_util__count__lmo__storage__word_holders___assign__4
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders___assign__4.cold, .-math_prime_util__count__lmo__storage__word_holders___assign__4.cold
.LCOLDE47:
	.text
.LHOTE47:
	.section	.text.unlikely
	.align 2
.LCOLDB48:
	.text
.LHOTB48:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders___assign__4
	.type	math_prime_util__count__lmo__storage__factor_holders___assign__4, @function
math_prime_util__count__lmo__storage__factor_holders___assign__4:
.LFB156:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA156
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$640, %rsp
	.cfi_def_cfa_offset 672
.LEHB38:
	call	*system__soft_links__abort_defer(%rip)
.LEHE38:
	cmpq	%rbp, %rbx
	jne	.L976
.L951:
	addq	$640, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
.LEHB39:
	jmp	*system__soft_links__abort_undefer(%rip)
.LEHE39:
	.p2align 4,,10
	.p2align 3
.L976:
	.cfi_restore_state
	movq	8(%rbx), %rax
	testq	%rax, %rax
	je	.L952
	movq	8(%rax), %rax
	movq	%rax, %r14
	lock subl	$1, (%rax)
	jne	.L955
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L954
	subq	$8, %rdi
.LEHB40:
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%r14)
.L954:
	movq	%r14, %rdi
	call	__gnat_free@PLT
.L955:
	movq	8(%rbx), %rax
	subl	$1, 16(%rax)
	movq	$0, 8(%rbx)
.L952:
	movq	(%rbx), %rax
	movdqu	0(%rbp), %xmm0
	movups	%xmm0, (%rbx)
	movq	%rax, (%rbx)
	movq	8(%rbx), %rax
	testq	%rax, %rax
	je	.L951
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	8(%rbx), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L977
	addl	$1, %eax
	movl	%eax, 16(%rdx)
	jmp	.L951
.L977:
	movl	$98, %esi
	leaq	.LC24(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE40:
.L962:
	movq	%rax, %rbp
	jmp	.L957
.L973:
	jmp	.L974
	.section	.gcc_except_table
	.align 4
.LLSDA156:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT156-.LLSDATTD156
.LLSDATTD156:
	.byte	0x1
	.uleb128 .LLSDACSE156-.LLSDACSB156
.LLSDACSB156:
	.uleb128 .LEHB38-.LFB156
	.uleb128 .LEHE38-.LEHB38
	.uleb128 .L973-.LFB156
	.uleb128 0
	.uleb128 .LEHB39-.LFB156
	.uleb128 .LEHE39-.LEHB39
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB40-.LFB156
	.uleb128 .LEHE40-.LEHB40
	.uleb128 .L962-.LFB156
	.uleb128 0x3
.LLSDACSE156:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT156:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC156
	.type	math_prime_util__count__lmo__storage__factor_holders___assign__4.cold, @function
math_prime_util__count__lmo__storage__factor_holders___assign__4.cold:
.LFSB156:
.L957:
	.cfi_def_cfa_offset 672
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rbx
	jne	.L959
	movq	%rax, %rdi
	call	__gnat_begin_handler_v1@PLT
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	movq	%rax, %r14
.LEHB41:
	call	__gnat_set_exception_parameter@PLT
	movq	%rsp, %rdi
	call	__gnat_raise_from_controlled_operation@PLT
.LEHE41:
.L961:
.L974:
	movq	%rax, %rbx
.L959:
.LEHB42:
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE42:
.L963:
	movq	%rax, %rdx
	movq	%r14, %rsi
	movq	%rbp, %rdi
	movq	%rax, %rbx
.LEHB43:
	call	__gnat_end_handler_v1@PLT
.LEHE43:
	jmp	.L959
	.cfi_endproc
.LFE156:
	.section	.gcc_except_table
	.align 4
.LLSDAC156:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC156-.LLSDATTDC156
.LLSDATTDC156:
	.byte	0x1
	.uleb128 .LLSDACSEC156-.LLSDACSBC156
.LLSDACSBC156:
	.uleb128 .LEHB41-.LCOLDB48
	.uleb128 .LEHE41-.LEHB41
	.uleb128 .L963-.LCOLDB48
	.uleb128 0
	.uleb128 .LEHB42-.LCOLDB48
	.uleb128 .LEHE42-.LEHB42
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB43-.LCOLDB48
	.uleb128 .LEHE43-.LEHB43
	.uleb128 .L961-.LCOLDB48
	.uleb128 0
.LLSDACSEC156:
	.byte	0
	.byte	0
	.byte	0x1
	.byte	0x7d
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC156:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders___assign__4, .-math_prime_util__count__lmo__storage__factor_holders___assign__4
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders___assign__4.cold, .-math_prime_util__count__lmo__storage__factor_holders___assign__4.cold
.LCOLDE48:
	.text
.LHOTE48:
	.section	.rodata.str1.8
	.align 8
.LC49:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Replace_Element: attempt to tamper with elements"
	.section	.rodata
	.align 8
.LC7:
	.long	1
	.long	95
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__replace_element
	.type	math_prime_util__count__lmo__storage__word_holders__replace_element, @function
math_prime_util__count__lmo__storage__word_holders__replace_element:
.LFB29:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdx, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	movslq	4(%rdx), %rax
	movslq	(%rdx), %rdx
	movl	16(%rdi), %ecx
	cmpl	%edx, %eax
	jge	.L979
	testl	%ecx, %ecx
	jne	.L980
	movq	8(%rdi), %rax
	xorl	%r13d, %r13d
	testq	%rax, %rax
	jne	.L982
	movl	$8, %edi
.L1004:
	call	__gnat_malloc@PLT
	movq	%r13, %rdx
	movq	%r12, %rsi
	movq	%rax, %rcx
	movq	(%rbx), %rax
	leaq	8(%rcx), %rbx
	movq	%rax, (%rcx)
	movq	%rbx, %rdi
	movq	%rcx, (%rsp)
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	(%rsp), %rcx
	movq	%rbx, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	%rax, 8(%rbp)
	addq	$40, %rsp
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
	.p2align 4,,10
	.p2align 3
.L979:
	.cfi_restore_state
	testl	%ecx, %ecx
	jne	.L980
	subq	%rdx, %rax
	leaq	8(,%rax,8), %r13
	movq	8(%rdi), %rax
	leaq	8(%r13), %rdi
	testq	%rax, %rax
	je	.L1004
.L982:
	leaq	.LC8(%rip), %rdx
	pxor	%xmm0, %xmm0
	movq	%rdx, %xmm1
	movl	(%rax), %edx
	punpcklqdq	%xmm1, %xmm0
	movq	8(%rbp), %rax
	cmpl	$1, %edx
	jne	.L985
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L986
	subq	$8, %rdi
	movaps	%xmm0, (%rsp)
	call	__gnat_free@PLT
	movq	8(%rbp), %rax
	movdqa	(%rsp), %xmm0
	movups	%xmm0, 8(%rax)
.L986:
	movslq	(%rbx), %rsi
	movslq	4(%rbx), %rax
	movl	$8, %edi
	movq	%rax, %rcx
	subq	%rsi, %rax
	leaq	16(,%rax,8), %rax
	cmpl	%esi, %ecx
	cmovge	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	%r13, %rdx
	movq	%r12, %rsi
	movq	%rax, %rcx
	movq	(%rbx), %rax
	leaq	8(%rcx), %rdi
	movq	%rcx, (%rsp)
	movq	%rax, (%rcx)
	call	memcpy@PLT
	movq	(%rsp), %rcx
	movq	%rax, %rdi
	movq	8(%rbp), %rax
	movq	%rdi, 8(%rax)
	movq	%rcx, 16(%rax)
	addq	$40, %rsp
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
	.p2align 4,,10
	.p2align 3
.L985:
	.cfi_restore_state
	lock subl	$1, (%rax)
	jne	.L988
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L989
	subq	$8, %rdi
	movq	%rax, (%rsp)
	movaps	%xmm0, 16(%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rax
	movdqa	16(%rsp), %xmm0
	movups	%xmm0, 8(%rax)
.L989:
	movq	%rax, %rdi
	call	__gnat_free@PLT
.L988:
	movslq	4(%rbx), %rax
	movslq	(%rbx), %rsi
	movl	$8, %edi
	movq	%rax, %rcx
	subq	%rsi, %rax
	leaq	16(,%rax,8), %rax
	cmpl	%esi, %ecx
	cmovge	%rax, %rdi
	jmp	.L1004
.L980:
	leaq	.LC49(%rip), %rsi
	leaq	.LC7(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE29:
	.size	math_prime_util__count__lmo__storage__word_holders__replace_element, .-math_prime_util__count__lmo__storage__word_holders__replace_element
	.section	.rodata.str1.8
	.align 8
.LC50:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Replace_Element: attempt to tamper with elements"
	.section	.rodata
	.align 8
.LC14:
	.long	1
	.long	97
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__replace_element
	.type	math_prime_util__count__lmo__storage__factor_holders__replace_element, @function
math_prime_util__count__lmo__storage__factor_holders__replace_element:
.LFB65:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdx, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	movslq	4(%rdx), %rax
	movslq	(%rdx), %rdx
	movl	16(%rdi), %ecx
	cmpl	%edx, %eax
	jge	.L1006
	testl	%ecx, %ecx
	jne	.L1007
	movq	8(%rdi), %rax
	xorl	%r13d, %r13d
	testq	%rax, %rax
	jne	.L1009
	movl	$8, %edi
.L1031:
	call	__gnat_malloc@PLT
	movq	%r13, %rdx
	movq	%r12, %rsi
	movq	%rax, %rcx
	movq	(%rbx), %rax
	leaq	8(%rcx), %rbx
	movq	%rax, (%rcx)
	movq	%rbx, %rdi
	movq	%rcx, (%rsp)
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	(%rsp), %rcx
	movq	%rbx, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	%rax, 8(%rbp)
	addq	$40, %rsp
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
	.p2align 4,,10
	.p2align 3
.L1006:
	.cfi_restore_state
	testl	%ecx, %ecx
	jne	.L1007
	subq	%rdx, %rax
	leaq	2(%rax,%rax), %r13
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L1032
.L1009:
	leaq	.LC15(%rip), %rdx
	pxor	%xmm0, %xmm0
	movq	%rdx, %xmm1
	movl	(%rax), %edx
	punpcklqdq	%xmm1, %xmm0
	movq	8(%rbp), %rax
	cmpl	$1, %edx
	jne	.L1012
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1013
	subq	$8, %rdi
	movaps	%xmm0, (%rsp)
	call	__gnat_free@PLT
	movq	8(%rbp), %rax
	movdqa	(%rsp), %xmm0
	movups	%xmm0, 8(%rax)
.L1013:
	movslq	(%rbx), %rsi
	movslq	4(%rbx), %rax
	movl	$8, %edi
	movq	%rax, %rcx
	subq	%rsi, %rax
	leaq	13(%rax,%rax), %rax
	andq	$-4, %rax
	cmpl	%esi, %ecx
	cmovge	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	%r13, %rdx
	movq	%r12, %rsi
	movq	%rax, %rcx
	movq	(%rbx), %rax
	leaq	8(%rcx), %rdi
	movq	%rcx, (%rsp)
	movq	%rax, (%rcx)
	call	memcpy@PLT
	movq	(%rsp), %rcx
	movq	%rax, %rdi
	movq	8(%rbp), %rax
	movq	%rdi, 8(%rax)
	movq	%rcx, 16(%rax)
	addq	$40, %rsp
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
	.p2align 4,,10
	.p2align 3
.L1012:
	.cfi_restore_state
	lock subl	$1, (%rax)
	jne	.L1015
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1016
	subq	$8, %rdi
	movq	%rax, (%rsp)
	movaps	%xmm0, 16(%rsp)
	call	__gnat_free@PLT
	movq	(%rsp), %rax
	movdqa	16(%rsp), %xmm0
	movups	%xmm0, 8(%rax)
.L1016:
	movq	%rax, %rdi
	call	__gnat_free@PLT
.L1015:
	movslq	4(%rbx), %rax
	movslq	(%rbx), %rsi
	movl	$8, %edi
	movq	%rax, %rcx
	subq	%rsi, %rax
	leaq	13(%rax,%rax), %rax
	andq	$-4, %rax
	cmpl	%esi, %ecx
	cmovge	%rax, %rdi
	jmp	.L1031
	.p2align 4,,10
	.p2align 3
.L1032:
	leaq	11(%r13), %rdi
	andq	$-4, %rdi
	jmp	.L1031
.L1007:
	leaq	.LC50(%rip), %rsi
	leaq	.LC14(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE65:
	.size	math_prime_util__count__lmo__storage__factor_holders__replace_element, .-math_prime_util__count__lmo__storage__factor_holders__replace_element
	.section	.text.unlikely
	.align 2
.LCOLDB51:
	.text
.LHOTB51:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__copy
	.type	math_prime_util__count__lmo__storage__word_holders__copy, @function
math_prime_util__count__lmo__storage__word_holders__copy:
.LFB9:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA9
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$80, %rsp
	.cfi_def_cfa_offset 112
	leaq	112(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	8(%rsi), %rax
	testq	%rax, %rax
	je	.L1048
	movl	16(%rsi), %edx
	movq	%rsi, %r12
	testl	%edx, %edx
	je	.L1049
	movq	16(%rax), %rax
	movl	$8, %edi
	movslq	(%rax), %r8
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%r8, %rax
	leaq	16(,%rax,8), %rax
	cmpl	%edx, %r8d
	cmovle	%rax, %rdi
.LEHB44:
	call	__gnat_malloc@PLT
	movq	%rax, %rbp
	movq	8(%r12), %rax
	leaq	8(%rbp), %r12
	movq	16(%rax), %rdx
	movq	8(%rax), %rdi
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %ecx
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %esi
	movq	%xmm0, 0(%rbp)
	movslq	%ecx, %r8
	movslq	%esi, %rax
	subq	%r8, %rax
	cmpl	%ecx, %esi
	movq	%rdi, %rsi
	movq	%r12, %rdi
	leaq	8(,%rax,8), %rax
	cmovge	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
.LEHE44:
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	%rbp, 16(%rax)
	movq	%rsp, %rdx
	movq	%rbx, %rdi
	leaq	math_prime_util__count__lmo__storage__word_holders__holderFDXnn(%rip), %rbp
	movq	%r12, 8(%rax)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbx)
	leaq	32+math_prime_util__count__lmo__storage__word_holders__holderT(%rip), %rax
	movl	$0, 16(%rbx)
	movq	%rax, (%rbx)
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
.LEHB45:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE45:
.LEHB46:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE46:
.L1033:
	addq	$80, %rsp
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
.L1049:
	.cfi_restore_state
	lock addl	$1, (%rax)
	leaq	32+ada__finalization__controlledT(%rip), %rax
	leaq	math_prime_util__count__lmo__storage__word_holders__holderFDXnn(%rip), %rbp
	movq	%rax, (%rdi)
	movq	8(%rsi), %rax
	leaq	24(%rsp), %rdx
	movq	%rbp, %rsi
	movl	$0, 16(%rdi)
	movq	%rax, 8(%rdi)
	leaq	32+math_prime_util__count__lmo__storage__word_holders__holderT(%rip), %rax
	movq	%rax, (%rdi)
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	$0, 40(%rsp)
.LEHB47:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	24(%rsp), %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE47:
.LEHB48:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbp, %rsi
	leaq	24(%rsp), %rdi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE48:
	addq	$80, %rsp
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
.L1048:
	.cfi_restore_state
	leaq	32+math_prime_util__count__lmo__storage__word_holders__holderT(%rip), %rax
	movl	$0, 16(%rdi)
	leaq	48(%rsp), %rdx
	movq	%rax, %xmm0
	leaq	math_prime_util__count__lmo__storage__word_holders__holderFDXnn(%rip), %rbp
	movq	$0, 48(%rsp)
	movups	%xmm0, (%rdi)
	movq	%rbp, %rsi
	movq	$0, 56(%rsp)
	movq	$0, 64(%rsp)
.LEHB49:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	48(%rsp), %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE49:
.LEHB50:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbp, %rsi
	leaq	48(%rsp), %rdi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE50:
	jmp	.L1033
.L1044:
	movq	%rax, %rbx
	jmp	.L1039
.L1046:
	movq	%rax, %rbx
	jmp	.L1041
.L1045:
	movq	%rax, %rbx
	jmp	.L1040
	.section	.gcc_except_table
.LLSDA9:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE9-.LLSDACSB9
.LLSDACSB9:
	.uleb128 .LEHB44-.LFB9
	.uleb128 .LEHE44-.LEHB44
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB45-.LFB9
	.uleb128 .LEHE45-.LEHB45
	.uleb128 .L1046-.LFB9
	.uleb128 0
	.uleb128 .LEHB46-.LFB9
	.uleb128 .LEHE46-.LEHB46
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB47-.LFB9
	.uleb128 .LEHE47-.LEHB47
	.uleb128 .L1045-.LFB9
	.uleb128 0
	.uleb128 .LEHB48-.LFB9
	.uleb128 .LEHE48-.LEHB48
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB49-.LFB9
	.uleb128 .LEHE49-.LEHB49
	.uleb128 .L1044-.LFB9
	.uleb128 0
	.uleb128 .LEHB50-.LFB9
	.uleb128 .LEHE50-.LEHB50
	.uleb128 0
	.uleb128 0
.LLSDACSE9:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC9
	.type	math_prime_util__count__lmo__storage__word_holders__copy.cold, @function
math_prime_util__count__lmo__storage__word_holders__copy.cold:
.LFSB9:
.L1039:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
.LEHB51:
	call	*system__soft_links__abort_defer(%rip)
	leaq	48(%rsp), %rdi
	movq	%rbp, %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1041:
	movq	%rsp, %r10
	call	math_prime_util__count__lmo__storage__word_holders__copy__B778b__R786b___finalizer.3
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1040:
	call	*system__soft_links__abort_defer(%rip)
	leaq	24(%rsp), %rdi
	movq	%rbp, %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE51:
	.cfi_endproc
.LFE9:
	.section	.gcc_except_table
.LLSDAC9:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC9-.LLSDACSBC9
.LLSDACSBC9:
	.uleb128 .LEHB51-.LCOLDB51
	.uleb128 .LEHE51-.LEHB51
	.uleb128 0
	.uleb128 0
.LLSDACSEC9:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__copy, .-math_prime_util__count__lmo__storage__word_holders__copy
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__copy.cold, .-math_prime_util__count__lmo__storage__word_holders__copy.cold
.LCOLDE51:
	.text
.LHOTE51:
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__word_holders__T188bXnn, @function
math_prime_util__count__lmo__storage__word_holders__T188bXnn:
.LFB128:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$8, %esi
	movq	%rdi, %rbx
	movl	$24, %edi
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__count__lmo__storage__word_holders__copy
	movq	8(%rsp), %rax
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE128:
	.size	math_prime_util__count__lmo__storage__word_holders__T188bXnn, .-math_prime_util__count__lmo__storage__word_holders__T188bXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__detach
	.type	math_prime_util__count__lmo__storage__word_holders__detach, @function
math_prime_util__count__lmo__storage__word_holders__detach:
.LFB13:
	.cfi_startproc
	movl	16(%rdi), %eax
	testl	%eax, %eax
	je	.L1072
.L1069:
	ret
	.p2align 4,,10
	.p2align 3
.L1072:
	movq	8(%rdi), %rax
	movl	(%rax), %eax
	cmpl	$1, %eax
	je	.L1069
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	8(%rdi), %r8
	movq	%rdi, (%rsp)
	movl	$8, %edi
	movq	16(%r8), %rax
	movq	%r8, 24(%rsp)
	movslq	(%rax), %r9
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%r9, %rax
	leaq	16(,%rax,8), %rax
	cmpl	%edx, %r9d
	cmovle	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	(%rsp), %rcx
	movq	%rax, %r9
	movq	8(%rcx), %rax
	movq	%rcx, 16(%rsp)
	movq	%r9, 8(%rsp)
	movq	16(%rax), %rdx
	movq	8(%rax), %r11
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %edi
	movq	%xmm0, (%r9)
	movslq	%esi, %r10
	movslq	%edi, %rax
	subq	%r10, %rax
	cmpl	%esi, %edi
	leaq	8(%r9), %r10
	movq	%r11, %rsi
	leaq	8(,%rax,8), %rax
	movq	%r10, %rdi
	movq	%r10, (%rsp)
	cmovge	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	(%rsp), %r10
	movq	8(%rsp), %r9
	movq	16(%rsp), %rcx
	movq	24(%rsp), %r8
	movq	%r10, 8(%rax)
	movq	%r9, 16(%rax)
	movq	%rax, 8(%rcx)
	lock subl	$1, (%r8)
	jne	.L1052
	movq	8(%r8), %rdi
	testq	%rdi, %rdi
	je	.L1056
	subq	$8, %rdi
	movq	%r8, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rax
	movq	(%rsp), %r8
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, 8(%r8)
.L1056:
	movq	%r8, %rdi
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1052:
	.cfi_restore_state
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE13:
	.size	math_prime_util__count__lmo__storage__word_holders__detach, .-math_prime_util__count__lmo__storage__word_holders__detach
	.section	.rodata.str1.8
	.align 8
.LC52:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Update_Element: container is empty"
	.section	.rodata
	.align 8
.LC9:
	.long	1
	.long	81
	.section	.text.unlikely
	.align 2
.LCOLDB53:
	.text
.LHOTB53:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__update_element
	.type	math_prime_util__count__lmo__storage__word_holders__update_element, @function
math_prime_util__count__lmo__storage__word_holders__update_element:
.LFB34:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA34
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	cmpq	$0, 8(%rdi)
	movq	%rbx, (%rsp)
	movq	%rbp, 8(%rsp)
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	je	.L1088
	movq	%rdi, %rbx
	movq	%rsi, %rbp
.LEHB52:
	call	math_prime_util__count__lmo__storage__word_holders__detach
.LEHE52:
	movl	16(%rbx), %eax
	cmpl	$2147483647, %eax
	je	.L1089
	addl	$1, %eax
	movl	%eax, 16(%rbx)
	movq	8(%rbx), %rax
	movq	8(%rax), %rdi
	movq	16(%rax), %rsi
	movq	%rbp, %rax
	testb	$1, %al
	jne	.L1090
.L1076:
.LEHB53:
	call	*%rax
.LEHE53:
	subl	$1, 16(%rbx)
	movq	8(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	movq	(%rsp), %rbx
	.cfi_restore 3
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
.L1090:
	.cfi_restore_state
	movq	-1(%rbp), %r10
	movq	7(%rbp), %rax
	jmp	.L1076
.L1089:
	movl	$520, %esi
	leaq	.LC24(%rip), %rdi
	movq	%r14, 16(%rsp)
.LEHB54:
	.cfi_remember_state
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1088:
	.cfi_restore_state
	leaq	.LC52(%rip), %rsi
	leaq	.LC9(%rip), %rdx
	movq	%r14, 16(%rsp)
	leaq	constraint_error(%rip), %rdi
	.cfi_remember_state
	.cfi_offset 14, -16
	call	__gnat_raise_exception@PLT
.LEHE54:
.L1080:
	.cfi_restore_state
	movq	%rax, %rbp
	jmp	.L1077
	.section	.gcc_except_table
	.align 4
.LLSDA34:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT34-.LLSDATTD34
.LLSDATTD34:
	.byte	0x1
	.uleb128 .LLSDACSE34-.LLSDACSB34
.LLSDACSB34:
	.uleb128 .LEHB52-.LFB34
	.uleb128 .LEHE52-.LEHB52
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB53-.LFB34
	.uleb128 .LEHE53-.LEHB53
	.uleb128 .L1080-.LFB34
	.uleb128 0x1
	.uleb128 .LEHB54-.LFB34
	.uleb128 .LEHE54-.LEHB54
	.uleb128 0
	.uleb128 0
.LLSDACSE34:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT34:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC34
	.type	math_prime_util__count__lmo__storage__word_holders__update_element.cold, @function
math_prime_util__count__lmo__storage__word_holders__update_element.cold:
.LFSB34:
.L1077:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	subq	$1, %rdx
	movq	%r14, 16(%rsp)
	.cfi_offset 14, -16
	movq	%rax, %rdi
	jne	.L1087
	call	__gnat_begin_handler_v1@PLT
	subl	$1, 16(%rbx)
	movq	%rbp, %rdi
	movq	%rax, %r14
.LEHB55:
	call	__gnat_reraise_zcx@PLT
.LEHE55:
.L1081:
	movq	%rax, %rbx
	movq	%rbp, %rdi
	movq	%rax, %rdx
	movq	%r14, %rsi
.LEHB56:
	call	__gnat_end_handler_v1@PLT
	movq	%rbx, %rdi
.L1087:
	call	_Unwind_Resume@PLT
.LEHE56:
	.cfi_endproc
.LFE34:
	.section	.gcc_except_table
	.align 4
.LLSDAC34:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC34-.LLSDATTDC34
.LLSDATTDC34:
	.byte	0x1
	.uleb128 .LLSDACSEC34-.LLSDACSBC34
.LLSDACSBC34:
	.uleb128 .LEHB55-.LCOLDB53
	.uleb128 .LEHE55-.LEHB55
	.uleb128 .L1081-.LCOLDB53
	.uleb128 0
	.uleb128 .LEHB56-.LCOLDB53
	.uleb128 .LEHE56-.LEHB56
	.uleb128 0
	.uleb128 0
.LLSDACSEC34:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC34:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__update_element, .-math_prime_util__count__lmo__storage__word_holders__update_element
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__update_element.cold, .-math_prime_util__count__lmo__storage__word_holders__update_element.cold
.LCOLDE53:
	.text
.LHOTE53:
	.section	.rodata.str1.8
	.align 8
.LC54:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Read: attempt to stream reference"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__read__2
	.type	math_prime_util__count__lmo__storage__word_holders__read__2, @function
math_prime_util__count__lmo__storage__word_holders__read__2:
.LFB24:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC54(%rip), %rsi
	leaq	.LC5(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE24:
	.size	math_prime_util__count__lmo__storage__word_holders__read__2, .-math_prime_util__count__lmo__storage__word_holders__read__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__read__3
	.type	math_prime_util__count__lmo__storage__word_holders__read__3, @function
math_prime_util__count__lmo__storage__word_holders__read__3:
.LFB286:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	math_prime_util__count__lmo__storage__word_holders__read__2
	.cfi_endproc
.LFE286:
	.size	math_prime_util__count__lmo__storage__word_holders__read__3, .-math_prime_util__count__lmo__storage__word_holders__read__3
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference__2
	.type	math_prime_util__count__lmo__storage__word_holders__reference__2, @function
math_prime_util__count__lmo__storage__word_holders__reference__2:
.LFB26:
	.cfi_startproc
	lock addl	$1, (%rdi)
	ret
	.cfi_endproc
.LFE26:
	.size	math_prime_util__count__lmo__storage__word_holders__reference__2, .-math_prime_util__count__lmo__storage__word_holders__reference__2
	.section	.text.unlikely
	.align 2
.LCOLDB55:
	.text
.LHOTB55:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__to_holder
	.type	math_prime_util__count__lmo__storage__word_holders__to_holder, @function
math_prime_util__count__lmo__storage__word_holders__to_holder:
.LFB31:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA31
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	leaq	96(%rsp), %rax
	movq	%rax, 40(%rsp)
	movslq	4(%rdx), %rax
	movslq	(%rdx), %rdx
	cmpl	%edx, %eax
	jl	.L1099
	subq	%rdx, %rax
	leaq	8(,%rax,8), %r13
	leaq	8(%r13), %rdi
.L1097:
	movq	%rsi, 8(%rsp)
.LEHB57:
	call	__gnat_malloc@PLT
	movq	8(%rsp), %rsi
	movq	%r13, %rdx
	movq	%rax, %rbp
	movq	(%r12), %rax
	leaq	8(%rbp), %r12
	movq	%rax, 0(%rbp)
	movq	%r12, %rdi
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
.LEHE57:
	movl	$1, %edx
	xchgl	(%rax), %edx
	leaq	math_prime_util__count__lmo__storage__word_holders__holderFDXnn(%rip), %rsi
	movq	%r12, 8(%rax)
	leaq	16(%rsp), %rdx
	movq	%rbx, %rdi
	movq	%rbp, 16(%rax)
	movq	%rax, 8(%rbx)
	leaq	32+math_prime_util__count__lmo__storage__word_holders__holderT(%rip), %rax
	movl	$0, 16(%rbx)
	movq	%rax, (%rbx)
	movq	$0, 16(%rsp)
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
.LEHB58:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	16(%rsp), %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE58:
.LEHB59:
	call	*system__soft_links__abort_defer(%rip)
	leaq	16(%rsp), %rdi
	leaq	math_prime_util__count__lmo__storage__word_holders__holderFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE59:
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
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1099:
	.cfi_restore_state
	xorl	%r13d, %r13d
	movl	$8, %edi
	jmp	.L1097
.L1100:
	movq	%rax, %rbx
	jmp	.L1098
	.section	.gcc_except_table
.LLSDA31:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE31-.LLSDACSB31
.LLSDACSB31:
	.uleb128 .LEHB57-.LFB31
	.uleb128 .LEHE57-.LEHB57
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB58-.LFB31
	.uleb128 .LEHE58-.LEHB58
	.uleb128 .L1100-.LFB31
	.uleb128 0
	.uleb128 .LEHB59-.LFB31
	.uleb128 .LEHE59-.LEHB59
	.uleb128 0
	.uleb128 0
.LLSDACSE31:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC31
	.type	math_prime_util__count__lmo__storage__word_holders__to_holder.cold, @function
math_prime_util__count__lmo__storage__word_holders__to_holder.cold:
.LFSB31:
.L1098:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	leaq	16(%rsp), %r10
.LEHB60:
	call	math_prime_util__count__lmo__storage__word_holders__to_holder__R912b___finalizer.7
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE60:
	.cfi_endproc
.LFE31:
	.section	.gcc_except_table
.LLSDAC31:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC31-.LLSDACSBC31
.LLSDACSBC31:
	.uleb128 .LEHB60-.LCOLDB55
	.uleb128 .LEHE60-.LEHB60
	.uleb128 0
	.uleb128 0
.LLSDACSEC31:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__to_holder, .-math_prime_util__count__lmo__storage__word_holders__to_holder
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__to_holder.cold, .-math_prime_util__count__lmo__storage__word_holders__to_holder.cold
.LCOLDE55:
	.text
.LHOTE55:
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__word_holders__T187bXnn, @function
math_prime_util__count__lmo__storage__word_holders__T187bXnn:
.LFB127:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	movl	$24, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	movl	$8, %esi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__count__lmo__storage__word_holders__to_holder
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE127:
	.size	math_prime_util__count__lmo__storage__word_holders__T187bXnn, .-math_prime_util__count__lmo__storage__word_holders__T187bXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__unreference
	.type	math_prime_util__count__lmo__storage__word_holders__unreference, @function
math_prime_util__count__lmo__storage__word_holders__unreference:
.LFB33:
	.cfi_startproc
	lock subl	$1, (%rdi)
	jne	.L1106
	movq	%rdi, %rax
	movq	8(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L1113
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rdx
	movq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rdx, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movq	%rax, %rdi
	movups	%xmm0, 8(%rax)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1106:
	ret
	.p2align 4,,10
	.p2align 3
.L1113:
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.cfi_endproc
.LFE33:
	.size	math_prime_util__count__lmo__storage__word_holders__unreference, .-math_prime_util__count__lmo__storage__word_holders__unreference
	.section	.rodata.str1.8
	.align 8
.LC56:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Write: attempt to stream reference"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__write__2
	.type	math_prime_util__count__lmo__storage__word_holders__write__2, @function
math_prime_util__count__lmo__storage__word_holders__write__2:
.LFB37:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC56(%rip), %rsi
	leaq	.LC9(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE37:
	.size	math_prime_util__count__lmo__storage__word_holders__write__2, .-math_prime_util__count__lmo__storage__word_holders__write__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__write__3
	.type	math_prime_util__count__lmo__storage__word_holders__write__3, @function
math_prime_util__count__lmo__storage__word_holders__write__3:
.LFB284:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	math_prime_util__count__lmo__storage__word_holders__write__2
	.cfi_endproc
.LFE284:
	.size	math_prime_util__count__lmo__storage__word_holders__write__3, .-math_prime_util__count__lmo__storage__word_holders__write__3
	.section	.text.unlikely
	.align 2
.LCOLDB57:
	.text
.LHOTB57:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__copy
	.type	math_prime_util__count__lmo__storage__factor_holders__copy, @function
math_prime_util__count__lmo__storage__factor_holders__copy:
.LFB45:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA45
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$80, %rsp
	.cfi_def_cfa_offset 112
	leaq	112(%rsp), %rax
	movq	%rax, 72(%rsp)
	movq	8(%rsi), %rax
	testq	%rax, %rax
	je	.L1135
	movl	16(%rsi), %edx
	movq	%rsi, %r12
	testl	%edx, %edx
	je	.L1136
	movq	16(%rax), %rax
	movl	$8, %edi
	movslq	(%rax), %r8
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%r8, %rax
	leaq	13(%rax,%rax), %rax
	andq	$-4, %rax
	cmpl	%edx, %r8d
	cmovle	%rax, %rdi
.LEHB61:
	call	__gnat_malloc@PLT
	movq	%rax, %rbp
	movq	8(%r12), %rax
	leaq	8(%rbp), %r12
	movq	16(%rax), %rdx
	movq	8(%rax), %rdi
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %ecx
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %esi
	movq	%xmm0, 0(%rbp)
	movslq	%ecx, %r8
	movslq	%esi, %rax
	subq	%r8, %rax
	cmpl	%ecx, %esi
	movq	%rdi, %rsi
	movq	%r12, %rdi
	leaq	2(%rax,%rax), %rax
	cmovge	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
.LEHE61:
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	%rbp, 16(%rax)
	movq	%rsp, %rdx
	movq	%rbx, %rdi
	leaq	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn(%rip), %rbp
	movq	%r12, 8(%rax)
	movq	%rbp, %rsi
	movq	%rax, 8(%rbx)
	leaq	32+math_prime_util__count__lmo__storage__factor_holders__holderT(%rip), %rax
	movl	$0, 16(%rbx)
	movq	%rax, (%rbx)
	movq	$0, (%rsp)
	movq	$0, 8(%rsp)
	movq	$0, 16(%rsp)
.LEHB62:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE62:
.LEHB63:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbp, %rsi
	movq	%rsp, %rdi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE63:
.L1120:
	addq	$80, %rsp
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
.L1136:
	.cfi_restore_state
	lock addl	$1, (%rax)
	leaq	32+ada__finalization__controlledT(%rip), %rax
	leaq	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn(%rip), %rbp
	movq	%rax, (%rdi)
	movq	8(%rsi), %rax
	leaq	24(%rsp), %rdx
	movq	%rbp, %rsi
	movl	$0, 16(%rdi)
	movq	%rax, 8(%rdi)
	leaq	32+math_prime_util__count__lmo__storage__factor_holders__holderT(%rip), %rax
	movq	%rax, (%rdi)
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
	movq	$0, 40(%rsp)
.LEHB64:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	24(%rsp), %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE64:
.LEHB65:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbp, %rsi
	leaq	24(%rsp), %rdi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE65:
	addq	$80, %rsp
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
.L1135:
	.cfi_restore_state
	leaq	32+math_prime_util__count__lmo__storage__factor_holders__holderT(%rip), %rax
	movl	$0, 16(%rdi)
	leaq	48(%rsp), %rdx
	movq	%rax, %xmm0
	leaq	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn(%rip), %rbp
	movq	$0, 48(%rsp)
	movups	%xmm0, (%rdi)
	movq	%rbp, %rsi
	movq	$0, 56(%rsp)
	movq	$0, 64(%rsp)
.LEHB66:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	48(%rsp), %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE66:
.LEHB67:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rbp, %rsi
	leaq	48(%rsp), %rdi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE67:
	jmp	.L1120
.L1131:
	movq	%rax, %rbx
	jmp	.L1126
.L1133:
	movq	%rax, %rbx
	jmp	.L1128
.L1132:
	movq	%rax, %rbx
	jmp	.L1127
	.section	.gcc_except_table
.LLSDA45:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE45-.LLSDACSB45
.LLSDACSB45:
	.uleb128 .LEHB61-.LFB45
	.uleb128 .LEHE61-.LEHB61
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB62-.LFB45
	.uleb128 .LEHE62-.LEHB62
	.uleb128 .L1133-.LFB45
	.uleb128 0
	.uleb128 .LEHB63-.LFB45
	.uleb128 .LEHE63-.LEHB63
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB64-.LFB45
	.uleb128 .LEHE64-.LEHB64
	.uleb128 .L1132-.LFB45
	.uleb128 0
	.uleb128 .LEHB65-.LFB45
	.uleb128 .LEHE65-.LEHB65
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB66-.LFB45
	.uleb128 .LEHE66-.LEHB66
	.uleb128 .L1131-.LFB45
	.uleb128 0
	.uleb128 .LEHB67-.LFB45
	.uleb128 .LEHE67-.LEHB67
	.uleb128 0
	.uleb128 0
.LLSDACSE45:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC45
	.type	math_prime_util__count__lmo__storage__factor_holders__copy.cold, @function
math_prime_util__count__lmo__storage__factor_holders__copy.cold:
.LFSB45:
.L1126:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
.LEHB68:
	call	*system__soft_links__abort_defer(%rip)
	leaq	48(%rsp), %rdi
	movq	%rbp, %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1128:
	movq	%rsp, %r10
	call	math_prime_util__count__lmo__storage__factor_holders__copy__B1007b__R1015b___finalizer.11
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.L1127:
	call	*system__soft_links__abort_defer(%rip)
	leaq	24(%rsp), %rdi
	movq	%rbp, %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE68:
	.cfi_endproc
.LFE45:
	.section	.gcc_except_table
.LLSDAC45:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC45-.LLSDACSBC45
.LLSDACSBC45:
	.uleb128 .LEHB68-.LCOLDB57
	.uleb128 .LEHE68-.LEHB68
	.uleb128 0
	.uleb128 0
.LLSDACSEC45:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__copy, .-math_prime_util__count__lmo__storage__factor_holders__copy
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__copy.cold, .-math_prime_util__count__lmo__storage__factor_holders__copy.cold
.LCOLDE57:
	.text
.LHOTE57:
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__factor_holders__T468bXnn, @function
math_prime_util__count__lmo__storage__factor_holders__T468bXnn:
.LFB184:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$8, %esi
	movq	%rdi, %rbx
	movl	$24, %edi
	subq	$16, %rsp
	.cfi_def_cfa_offset 32
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__count__lmo__storage__factor_holders__copy
	movq	8(%rsp), %rax
	addq	$16, %rsp
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE184:
	.size	math_prime_util__count__lmo__storage__factor_holders__T468bXnn, .-math_prime_util__count__lmo__storage__factor_holders__T468bXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__detach
	.type	math_prime_util__count__lmo__storage__factor_holders__detach, @function
math_prime_util__count__lmo__storage__factor_holders__detach:
.LFB49:
	.cfi_startproc
	movl	16(%rdi), %eax
	testl	%eax, %eax
	je	.L1159
.L1156:
	ret
	.p2align 4,,10
	.p2align 3
.L1159:
	movq	8(%rdi), %rax
	movl	(%rax), %eax
	cmpl	$1, %eax
	je	.L1156
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	8(%rdi), %r8
	movq	%rdi, (%rsp)
	movl	$8, %edi
	movq	16(%r8), %rax
	movq	%r8, 24(%rsp)
	movslq	(%rax), %r9
	movslq	4(%rax), %rax
	movq	%rax, %rdx
	subq	%r9, %rax
	leaq	13(%rax,%rax), %rax
	andq	$-4, %rax
	cmpl	%edx, %r9d
	cmovle	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	(%rsp), %rcx
	movq	%rax, %r9
	movq	8(%rcx), %rax
	movq	%rcx, 16(%rsp)
	movq	%r9, 8(%rsp)
	movq	16(%rax), %rdx
	movq	8(%rax), %r11
	movq	(%rdx), %xmm0
	xorl	%edx, %edx
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %edi
	movq	%xmm0, (%r9)
	movslq	%esi, %r10
	movslq	%edi, %rax
	subq	%r10, %rax
	cmpl	%esi, %edi
	leaq	8(%r9), %r10
	movq	%r11, %rsi
	leaq	2(%rax,%rax), %rax
	movq	%r10, %rdi
	movq	%r10, (%rsp)
	cmovge	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	(%rsp), %r10
	movq	8(%rsp), %r9
	movq	16(%rsp), %rcx
	movq	24(%rsp), %r8
	movq	%r10, 8(%rax)
	movq	%r9, 16(%rax)
	movq	%rax, 8(%rcx)
	lock subl	$1, (%r8)
	jne	.L1139
	movq	8(%r8), %rdi
	testq	%rdi, %rdi
	je	.L1143
	subq	$8, %rdi
	movq	%r8, (%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rax
	movq	(%rsp), %r8
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm2
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, 8(%r8)
.L1143:
	movq	%r8, %rdi
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1139:
	.cfi_restore_state
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE49:
	.size	math_prime_util__count__lmo__storage__factor_holders__detach, .-math_prime_util__count__lmo__storage__factor_holders__detach
	.section	.rodata.str1.8
	.align 8
.LC58:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Update_Element: container is empty"
	.section	.rodata
	.align 8
.LC16:
	.long	1
	.long	83
	.section	.text.unlikely
	.align 2
.LCOLDB59:
	.text
.LHOTB59:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__update_element
	.type	math_prime_util__count__lmo__storage__factor_holders__update_element, @function
math_prime_util__count__lmo__storage__factor_holders__update_element:
.LFB70:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA70
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	cmpq	$0, 8(%rdi)
	movq	%rbx, (%rsp)
	movq	%rbp, 8(%rsp)
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	je	.L1175
	movq	%rdi, %rbx
	movq	%rsi, %rbp
.LEHB69:
	call	math_prime_util__count__lmo__storage__factor_holders__detach
.LEHE69:
	movl	16(%rbx), %eax
	cmpl	$2147483647, %eax
	je	.L1176
	addl	$1, %eax
	movl	%eax, 16(%rbx)
	movq	8(%rbx), %rax
	movq	8(%rax), %rdi
	movq	16(%rax), %rsi
	movq	%rbp, %rax
	testb	$1, %al
	jne	.L1177
.L1163:
.LEHB70:
	call	*%rax
.LEHE70:
	subl	$1, 16(%rbx)
	movq	8(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	movq	(%rsp), %rbx
	.cfi_restore 3
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
.L1177:
	.cfi_restore_state
	movq	-1(%rbp), %r10
	movq	7(%rbp), %rax
	jmp	.L1163
.L1176:
	movl	$520, %esi
	leaq	.LC24(%rip), %rdi
	movq	%r14, 16(%rsp)
.LEHB71:
	.cfi_remember_state
	.cfi_offset 14, -16
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.L1175:
	.cfi_restore_state
	leaq	.LC58(%rip), %rsi
	leaq	.LC16(%rip), %rdx
	movq	%r14, 16(%rsp)
	leaq	constraint_error(%rip), %rdi
	.cfi_remember_state
	.cfi_offset 14, -16
	call	__gnat_raise_exception@PLT
.LEHE71:
.L1167:
	.cfi_restore_state
	movq	%rax, %rbp
	jmp	.L1164
	.section	.gcc_except_table
	.align 4
.LLSDA70:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT70-.LLSDATTD70
.LLSDATTD70:
	.byte	0x1
	.uleb128 .LLSDACSE70-.LLSDACSB70
.LLSDACSB70:
	.uleb128 .LEHB69-.LFB70
	.uleb128 .LEHE69-.LEHB69
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB70-.LFB70
	.uleb128 .LEHE70-.LEHB70
	.uleb128 .L1167-.LFB70
	.uleb128 0x1
	.uleb128 .LEHB71-.LFB70
	.uleb128 .LEHE71-.LEHB71
	.uleb128 0
	.uleb128 0
.LLSDACSE70:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT70:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC70
	.type	math_prime_util__count__lmo__storage__factor_holders__update_element.cold, @function
math_prime_util__count__lmo__storage__factor_holders__update_element.cold:
.LFSB70:
.L1164:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	subq	$1, %rdx
	movq	%r14, 16(%rsp)
	.cfi_offset 14, -16
	movq	%rax, %rdi
	jne	.L1174
	call	__gnat_begin_handler_v1@PLT
	subl	$1, 16(%rbx)
	movq	%rbp, %rdi
	movq	%rax, %r14
.LEHB72:
	call	__gnat_reraise_zcx@PLT
.LEHE72:
.L1168:
	movq	%rax, %rbx
	movq	%rbp, %rdi
	movq	%rax, %rdx
	movq	%r14, %rsi
.LEHB73:
	call	__gnat_end_handler_v1@PLT
	movq	%rbx, %rdi
.L1174:
	call	_Unwind_Resume@PLT
.LEHE73:
	.cfi_endproc
.LFE70:
	.section	.gcc_except_table
	.align 4
.LLSDAC70:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC70-.LLSDATTDC70
.LLSDATTDC70:
	.byte	0x1
	.uleb128 .LLSDACSEC70-.LLSDACSBC70
.LLSDACSBC70:
	.uleb128 .LEHB72-.LCOLDB59
	.uleb128 .LEHE72-.LEHB72
	.uleb128 .L1168-.LCOLDB59
	.uleb128 0
	.uleb128 .LEHB73-.LCOLDB59
	.uleb128 .LEHE73-.LEHB73
	.uleb128 0
	.uleb128 0
.LLSDACSEC70:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC70:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__update_element, .-math_prime_util__count__lmo__storage__factor_holders__update_element
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__update_element.cold, .-math_prime_util__count__lmo__storage__factor_holders__update_element.cold
.LCOLDE59:
	.text
.LHOTE59:
	.section	.rodata.str1.8
	.align 8
.LC60:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Read: attempt to stream reference"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__read__2
	.type	math_prime_util__count__lmo__storage__factor_holders__read__2, @function
math_prime_util__count__lmo__storage__factor_holders__read__2:
.LFB60:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC60(%rip), %rsi
	leaq	.LC12(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE60:
	.size	math_prime_util__count__lmo__storage__factor_holders__read__2, .-math_prime_util__count__lmo__storage__factor_holders__read__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__read__3
	.type	math_prime_util__count__lmo__storage__factor_holders__read__3, @function
math_prime_util__count__lmo__storage__factor_holders__read__3:
.LFB290:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	math_prime_util__count__lmo__storage__factor_holders__read__2
	.cfi_endproc
.LFE290:
	.size	math_prime_util__count__lmo__storage__factor_holders__read__3, .-math_prime_util__count__lmo__storage__factor_holders__read__3
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference__2
	.type	math_prime_util__count__lmo__storage__factor_holders__reference__2, @function
math_prime_util__count__lmo__storage__factor_holders__reference__2:
.LFB282:
	.cfi_startproc
	lock addl	$1, (%rdi)
	ret
	.cfi_endproc
.LFE282:
	.size	math_prime_util__count__lmo__storage__factor_holders__reference__2, .-math_prime_util__count__lmo__storage__factor_holders__reference__2
	.section	.text.unlikely
	.align 2
.LCOLDB61:
	.text
.LHOTB61:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__to_holder
	.type	math_prime_util__count__lmo__storage__factor_holders__to_holder, @function
math_prime_util__count__lmo__storage__factor_holders__to_holder:
.LFB67:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA67
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdi, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	leaq	96(%rsp), %rax
	movq	%rax, 40(%rsp)
	movslq	4(%rdx), %rax
	movslq	(%rdx), %rdx
	cmpl	%edx, %eax
	jl	.L1186
	subq	%rdx, %rax
	leaq	2(%rax,%rax), %r13
	leaq	11(%r13), %rdi
	andq	$-4, %rdi
.L1184:
	movq	%rsi, 8(%rsp)
.LEHB74:
	call	__gnat_malloc@PLT
	movq	8(%rsp), %rsi
	movq	%r13, %rdx
	movq	%rax, %rbp
	movq	(%r12), %rax
	leaq	8(%rbp), %r12
	movq	%rax, 0(%rbp)
	movq	%r12, %rdi
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
.LEHE74:
	movl	$1, %edx
	xchgl	(%rax), %edx
	leaq	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn(%rip), %rsi
	movq	%r12, 8(%rax)
	leaq	16(%rsp), %rdx
	movq	%rbx, %rdi
	movq	%rbp, 16(%rax)
	movq	%rax, 8(%rbx)
	leaq	32+math_prime_util__count__lmo__storage__factor_holders__holderT(%rip), %rax
	movl	$0, 16(%rbx)
	movq	%rax, (%rbx)
	movq	$0, 16(%rsp)
	movq	$0, 24(%rsp)
	movq	$0, 32(%rsp)
.LEHB75:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	16(%rsp), %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE75:
.LEHB76:
	call	*system__soft_links__abort_defer(%rip)
	leaq	16(%rsp), %rdi
	leaq	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE76:
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
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1186:
	.cfi_restore_state
	xorl	%r13d, %r13d
	movl	$8, %edi
	jmp	.L1184
.L1187:
	movq	%rax, %rbx
	jmp	.L1185
	.section	.gcc_except_table
.LLSDA67:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE67-.LLSDACSB67
.LLSDACSB67:
	.uleb128 .LEHB74-.LFB67
	.uleb128 .LEHE74-.LEHB74
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB75-.LFB67
	.uleb128 .LEHE75-.LEHB75
	.uleb128 .L1187-.LFB67
	.uleb128 0
	.uleb128 .LEHB76-.LFB67
	.uleb128 .LEHE76-.LEHB76
	.uleb128 0
	.uleb128 0
.LLSDACSE67:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC67
	.type	math_prime_util__count__lmo__storage__factor_holders__to_holder.cold, @function
math_prime_util__count__lmo__storage__factor_holders__to_holder.cold:
.LFSB67:
.L1185:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 13, -16
	leaq	16(%rsp), %r10
.LEHB77:
	call	math_prime_util__count__lmo__storage__factor_holders__to_holder__R1141b___finalizer.15
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE77:
	.cfi_endproc
.LFE67:
	.section	.gcc_except_table
.LLSDAC67:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC67-.LLSDACSBC67
.LLSDACSBC67:
	.uleb128 .LEHB77-.LCOLDB61
	.uleb128 .LEHE77-.LEHB77
	.uleb128 0
	.uleb128 0
.LLSDACSEC67:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__to_holder, .-math_prime_util__count__lmo__storage__factor_holders__to_holder
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__to_holder.cold, .-math_prime_util__count__lmo__storage__factor_holders__to_holder.cold
.LCOLDE61:
	.text
.LHOTE61:
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__factor_holders__T467bXnn, @function
math_prime_util__count__lmo__storage__factor_holders__T467bXnn:
.LFB183:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	movl	$24, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	movl	$8, %esi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movq	%rbp, %rsi
	movq	%rbx, %rdx
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__count__lmo__storage__factor_holders__to_holder
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE183:
	.size	math_prime_util__count__lmo__storage__factor_holders__T467bXnn, .-math_prime_util__count__lmo__storage__factor_holders__T467bXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__unreference
	.type	math_prime_util__count__lmo__storage__factor_holders__unreference, @function
math_prime_util__count__lmo__storage__factor_holders__unreference:
.LFB69:
	.cfi_startproc
	lock subl	$1, (%rdi)
	jne	.L1193
	movq	%rdi, %rax
	movq	8(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L1200
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rdx
	movq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rdx, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movq	%rax, %rdi
	movups	%xmm0, 8(%rax)
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	jmp	__gnat_free@PLT
	.p2align 4,,10
	.p2align 3
.L1193:
	ret
	.p2align 4,,10
	.p2align 3
.L1200:
	movq	%rax, %rdi
	jmp	__gnat_free@PLT
	.cfi_endproc
.LFE69:
	.size	math_prime_util__count__lmo__storage__factor_holders__unreference, .-math_prime_util__count__lmo__storage__factor_holders__unreference
	.section	.rodata.str1.8
	.align 8
.LC62:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Write: attempt to stream reference"
	.text
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__write__2
	.type	math_prime_util__count__lmo__storage__factor_holders__write__2, @function
math_prime_util__count__lmo__storage__factor_holders__write__2:
.LFB73:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC62(%rip), %rsi
	leaq	.LC16(%rip), %rdx
	leaq	program_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
	.cfi_endproc
.LFE73:
	.size	math_prime_util__count__lmo__storage__factor_holders__write__2, .-math_prime_util__count__lmo__storage__factor_holders__write__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__write__3
	.type	math_prime_util__count__lmo__storage__factor_holders__write__3, @function
math_prime_util__count__lmo__storage__factor_holders__write__3:
.LFB288:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	math_prime_util__count__lmo__storage__factor_holders__write__2
	.cfi_endproc
.LFE288:
	.size	math_prime_util__count__lmo__storage__factor_holders__write__3, .-math_prime_util__count__lmo__storage__factor_holders__write__3
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__wordsIP
	.type	math_prime_util__count__lmo__wordsIP, @function
math_prime_util__count__lmo__wordsIP:
.LFB74:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE74:
	.size	math_prime_util__count__lmo__wordsIP, .-math_prime_util__count__lmo__wordsIP
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__words_932SW
	.type	math_prime_util__count__lmo__words_932SW, @function
math_prime_util__count__lmo__words_932SW:
.LFB75:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	movl	(%rdx), %ebx
	cmpl	4(%rdx), %ebx
	jg	.L1208
	subl	$1, %ebx
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	movslq	%ebx, %rbx
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	movq	%rbx, %rax
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	negq	%rax
	leaq	(%rsi,%rax,8), %r13
	.p2align 4
	.p2align 3
.L1210:
	movq	0(%r13,%rbx,8), %rsi
	movq	%r12, %rdi
	addq	$1, %rbx
	call	system__stream_attributes__w_lu@PLT
	cmpl	%ebx, 4(%rbp)
	jne	.L1210
	movq	16(%rsp), %rbp
	.cfi_restore 6
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
.L1208:
	movq	8(%rsp), %rbx
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE75:
	.size	math_prime_util__count__lmo__words_932SW, .-math_prime_util__count__lmo__words_932SW
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__words_928SO
	.type	math_prime_util__count__lmo__words_928SO, @function
math_prime_util__count__lmo__words_928SO:
.LFB76:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movl	(%rdx), %esi
	call	system__stream_attributes__w_i@PLT
	movl	4(%rbp), %esi
	movq	%r12, %rdi
	call	system__stream_attributes__w_i@PLT
	movl	0(%rbp), %ebx
	cmpl	4(%rbp), %ebx
	jg	.L1213
	subl	$1, %ebx
	movslq	%ebx, %rbx
	movq	%rbx, %rax
	negq	%rax
	leaq	0(%r13,%rax,8), %r13
	.p2align 4
	.p2align 3
.L1215:
	movq	0(%r13,%rbx,8), %rsi
	movq	%r12, %rdi
	addq	$1, %rbx
	call	system__stream_attributes__w_lu@PLT
	cmpl	%ebx, 4(%rbp)
	jne	.L1215
.L1213:
	addq	$8, %rsp
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
	.cfi_endproc
.LFE76:
	.size	math_prime_util__count__lmo__words_928SO, .-math_prime_util__count__lmo__words_928SO
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__write
	.type	math_prime_util__count__lmo__storage__word_holders__write, @function
math_prime_util__count__lmo__storage__word_holders__write:
.LFB35:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	cmpq	$0, 8(%rsi)
	movl	%edx, %ebx
	sete	%sil
	movzbl	%sil, %esi
	call	system__stream_attributes__w_b@PLT
	movq	8(%rbp), %rax
	testq	%rax, %rax
	je	.L1218
	cmpl	$4, %ebx
	movl	$4, %ecx
	movq	8(%rax), %rsi
	movq	16(%rax), %rdx
	cmovle	%ebx, %ecx
	movq	%r12, %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__count__lmo__words_928SO
	.p2align 4,,10
	.p2align 3
.L1218:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE35:
	.size	math_prime_util__count__lmo__storage__word_holders__write, .-math_prime_util__count__lmo__storage__word_holders__write
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__holderSW__2
	.type	math_prime_util__count__lmo__storage__word_holders__holderSW__2, @function
math_prime_util__count__lmo__storage__word_holders__holderSW__2:
.LFB120:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	cmpq	$0, 8(%rsi)
	movl	%edx, %ebx
	sete	%sil
	movzbl	%sil, %esi
	call	system__stream_attributes__w_b@PLT
	movq	8(%rbp), %rax
	testq	%rax, %rax
	je	.L1221
	cmpl	$4, %ebx
	movl	$4, %ecx
	movq	8(%rax), %rsi
	movq	16(%rax), %rdx
	cmovle	%ebx, %ecx
	movq	%r12, %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__count__lmo__words_928SO
	.p2align 4,,10
	.p2align 3
.L1221:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE120:
	.size	math_prime_util__count__lmo__storage__word_holders__holderSW__2, .-math_prime_util__count__lmo__storage__word_holders__holderSW__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__holderSO__2
	.type	math_prime_util__count__lmo__storage__word_holders__holderSO__2, @function
math_prime_util__count__lmo__storage__word_holders__holderSO__2:
.LFB268:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	cmpq	$0, 8(%rsi)
	movl	%edx, %ebx
	sete	%sil
	movzbl	%sil, %esi
	call	system__stream_attributes__w_b@PLT
	movq	8(%rbp), %rax
	testq	%rax, %rax
	je	.L1224
	cmpl	$4, %ebx
	movl	$4, %ecx
	movq	8(%rax), %rsi
	movq	16(%rax), %rdx
	cmovle	%ebx, %ecx
	movq	%r12, %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__count__lmo__words_928SO
	.p2align 4,,10
	.p2align 3
.L1224:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE268:
	.size	math_prime_util__count__lmo__storage__word_holders__holderSO__2, .-math_prime_util__count__lmo__storage__word_holders__holderSO__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__words_840SR
	.type	math_prime_util__count__lmo__words_840SR, @function
math_prime_util__count__lmo__words_840SR:
.LFB77:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	movl	(%rdx), %ebx
	cmpl	4(%rdx), %ebx
	jg	.L1227
	subl	$1, %ebx
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	movslq	%ebx, %rbx
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	movq	%rbx, %rax
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	negq	%rax
	leaq	(%rsi,%rax,8), %r13
	.p2align 4
	.p2align 3
.L1229:
	movq	%r12, %rdi
	call	system__stream_attributes__i_lu@PLT
	movq	%rax, 0(%r13,%rbx,8)
	addq	$1, %rbx
	cmpl	%ebx, 4(%rbp)
	jne	.L1229
	movq	16(%rsp), %rbp
	.cfi_restore 6
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
.L1227:
	movq	8(%rsp), %rbx
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE77:
	.size	math_prime_util__count__lmo__words_840SR, .-math_prime_util__count__lmo__words_840SR
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__words_833SI
	.type	math_prime_util__count__lmo__words_833SI, @function
math_prime_util__count__lmo__words_833SI:
.LFB78:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -40
	movq	%rdi, %r12
	movq	%rbx, 8(%rsp)
	movq	%r14, 40(%rsp)
	movq	%r13, 32(%rsp)
	.cfi_offset 3, -56
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	call	system__stream_attributes__i_i@PLT
	movq	%r12, %rdi
	movl	%eax, %ebx
	call	system__stream_attributes__i_i@PLT
	movl	%eax, %r14d
	cmpl	%eax, %ebx
	jg	.L1233
	movslq	%ebx, %rdx
	cltq
	movl	$8, %esi
	movq	%rbp, 16(%rsp)
	subq	%rdx, %rax
	movq	%r15, 48(%rsp)
	.cfi_offset 6, -48
	.cfi_offset 15, -16
	leaq	16(,%rax,8), %rdi
	call	system__secondary_stack__ss_allocate@PLT
	movl	%ebx, (%rax)
	subl	$1, %ebx
	movq	%rax, %rbp
	movq	%rax, %r13
	movslq	%ebx, %rbx
	movl	%r14d, 4(%rax)
	leaq	8(%rax), %r14
	movq	%rbx, %rax
	negq	%rax
	leaq	0(%rbp,%rax,8), %r15
	.p2align 4
	.p2align 3
.L1234:
	movq	%r12, %rdi
	call	system__stream_attributes__i_lu@PLT
	movq	%rax, 8(%r15,%rbx,8)
	addq	$1, %rbx
	cmpl	%ebx, 4(%rbp)
	jne	.L1234
	movq	16(%rsp), %rbp
	.cfi_restore 6
	movq	48(%rsp), %r15
	.cfi_restore 15
.L1235:
	movq	%r14, %rax
	movq	%r13, %rdx
	movq	8(%rsp), %rbx
	movq	24(%rsp), %r12
	movq	32(%rsp), %r13
	movq	40(%rsp), %r14
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1233:
	.cfi_restore_state
	movl	$8, %esi
	movl	$8, %edi
	call	system__secondary_stack__ss_allocate@PLT
	movl	%r14d, 4(%rax)
	movq	%rax, %r13
	leaq	8(%rax), %r14
	movl	%ebx, (%rax)
	jmp	.L1235
	.cfi_endproc
.LFE78:
	.size	math_prime_util__count__lmo__words_833SI, .-math_prime_util__count__lmo__words_833SI
	.section	.text.unlikely
	.align 2
.LCOLDB63:
	.text
.LHOTB63:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__read
	.type	math_prime_util__count__lmo__storage__word_holders__read, @function
math_prime_util__count__lmo__storage__word_holders__read:
.LFB22:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA22
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	leaq	96(%rsp), %rax
	movq	%rax, 40(%rsp)
	movl	16(%rsi), %eax
	movq	%rbx, 56(%rsp)
	testl	%eax, %eax
	movq	%rbp, 64(%rsp)
	movq	%r12, 72(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	jne	.L1261
	movq	8(%rsi), %rax
	movq	%rdi, %rbp
	movq	%rsi, %rbx
	movl	%edx, %r12d
	testq	%rax, %rax
	je	.L1241
	lock subl	$1, (%rax)
	je	.L1262
.L1242:
	movq	$0, 8(%rbx)
.L1241:
	movq	%rbp, %rdi
.LEHB78:
	call	system__stream_attributes__i_b@PLT
	testb	%al, %al
	je	.L1263
.L1239:
	movq	56(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	movq	64(%rsp), %rbp
	.cfi_restore 6
	movq	72(%rsp), %r12
	.cfi_restore 12
	addq	$88, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1262:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1243
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rdx
	movq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, 8(%rax)
.L1243:
	movq	%rax, %rdi
	call	__gnat_free@PLT
.LEHE78:
	jmp	.L1242
	.p2align 4,,10
	.p2align 3
.L1263:
	movl	$4, %eax
	leaq	16(%rsp), %rdi
	movq	%r14, 80(%rsp)
	cmpl	%eax, %r12d
	cmovg	%eax, %r12d
.LEHB79:
	.cfi_offset 14, -16
	call	system__secondary_stack__ss_mark@PLT
	movl	%r12d, %esi
	movq	%rbp, %rdi
	call	math_prime_util__count__lmo__words_833SI
	movslq	(%rdx), %r8
	movq	%rax, %r14
	movslq	4(%rdx), %rax
	movl	$8, %edi
	movq	%rdx, %r12
	movq	%rax, %rcx
	subq	%r8, %rax
	leaq	16(,%rax,8), %rax
	cmpl	%ecx, %r8d
	cmovle	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	(%r12), %xmm0
	movq	%rax, %rbp
	xorl	%edx, %edx
	leaq	8(%rbp), %r12
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %ecx
	movq	%xmm0, (%rax)
	movslq	%esi, %rdi
	movslq	%ecx, %rax
	subq	%rdi, %rax
	cmpl	%ecx, %esi
	movq	%r12, %rdi
	movq	%r14, %rsi
	leaq	8(,%rax,8), %rax
	cmovle	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
.LEHE79:
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	%r12, 8(%rax)
	leaq	16(%rsp), %rdi
	movq	%rbp, 16(%rax)
	movq	%rax, 8(%rbx)
.LEHB80:
	call	system__secondary_stack__ss_release@PLT
	movq	80(%rsp), %r14
	.cfi_restore 14
	jmp	.L1239
.L1261:
	movq	%r14, 80(%rsp)
	.cfi_offset 14, -16
	call	math_prime_util__count__lmo__storage__word_holders__clear.part.0
.LEHE80:
.L1250:
	movq	%rax, %rbx
	jmp	.L1247
	.section	.gcc_except_table
.LLSDA22:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE22-.LLSDACSB22
.LLSDACSB22:
	.uleb128 .LEHB78-.LFB22
	.uleb128 .LEHE78-.LEHB78
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB79-.LFB22
	.uleb128 .LEHE79-.LEHB79
	.uleb128 .L1250-.LFB22
	.uleb128 0
	.uleb128 .LEHB80-.LFB22
	.uleb128 .LEHE80-.LEHB80
	.uleb128 0
	.uleb128 0
.LLSDACSE22:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC22
	.type	math_prime_util__count__lmo__storage__word_holders__read.cold, @function
math_prime_util__count__lmo__storage__word_holders__read.cold:
.LFSB22:
.L1247:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 14, -16
	leaq	16(%rsp), %rdi
.LEHB81:
	call	system__secondary_stack__ss_release@PLT
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE81:
	.cfi_endproc
.LFE22:
	.section	.gcc_except_table
.LLSDAC22:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC22-.LLSDACSBC22
.LLSDACSBC22:
	.uleb128 .LEHB81-.LCOLDB63
	.uleb128 .LEHE81-.LEHB81
	.uleb128 0
	.uleb128 0
.LLSDACSEC22:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__read, .-math_prime_util__count__lmo__storage__word_holders__read
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__read.cold, .-math_prime_util__count__lmo__storage__word_holders__read.cold
.LCOLDE63:
	.text
.LHOTE63:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__holderSR__2
	.type	math_prime_util__count__lmo__storage__word_holders__holderSR__2, @function
math_prime_util__count__lmo__storage__word_holders__holderSR__2:
.LFB119:
	.cfi_startproc
	movl	$4, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__count__lmo__storage__word_holders__read
	.cfi_endproc
.LFE119:
	.size	math_prime_util__count__lmo__storage__word_holders__holderSR__2, .-math_prime_util__count__lmo__storage__word_holders__holderSR__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__words_824PI
	.type	math_prime_util__count__lmo__words_824PI, @function
math_prime_util__count__lmo__words_824PI:
.LFB79:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%rsi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movslq	(%rdx), %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	call	system__put_images__array_before@PLT
	movslq	(%r12), %rbx
	cmpl	4(%r12), %ebx
	jg	.L1266
	negq	%r13
	leaq	(%r14,%r13,8), %r13
	jmp	.L1268
	.p2align 4,,10
	.p2align 3
.L1271:
	movq	%rbp, %rdi
	call	system__put_images__simple_array_between@PLT
	cmpl	$2147483647, %ebx
	je	.L1270
	addq	$1, %rbx
.L1268:
	movq	0(%r13,%rbx,8), %rsi
	movq	%rbp, %rdi
	call	system__put_images__put_image_long_long_unsigned@PLT
	cmpl	%ebx, 4(%r12)
	jne	.L1271
.L1266:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	system__put_images__array_after@PLT
.L1270:
	.cfi_restore_state
	movl	$13, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE79:
	.size	math_prime_util__count__lmo__words_824PI, .-math_prime_util__count__lmo__words_824PI
	.section	.text.unlikely
	.align 2
.LCOLDB64:
	.text
.LHOTB64:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__put_image
	.type	math_prime_util__count__lmo__storage__word_holders__put_image, @function
math_prime_util__count__lmo__storage__word_holders__put_image:
.LFB20:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA20
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	%rax, 24(%rsp)
.LEHB82:
	call	system__put_images__array_before@PLT
.LEHE82:
	cmpq	$0, 8(%rbp)
	je	.L1273
	movq	%rsp, %rdi
.LEHB83:
	call	system__secondary_stack__ss_mark@PLT
	movq	%rbp, %rdi
	call	math_prime_util__count__lmo__storage__word_holders__element
	movq	%rax, %rsi
	movq	%rbx, %rdi
	call	math_prime_util__count__lmo__words_824PI
.LEHE83:
	movq	%rsp, %rdi
.LEHB84:
	call	system__secondary_stack__ss_release@PLT
.L1273:
	movq	%rbx, %rdi
	call	system__put_images__array_after@PLT
.LEHE84:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L1275:
	.cfi_restore_state
	movq	%rax, %rbx
	jmp	.L1274
	.section	.gcc_except_table
.LLSDA20:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE20-.LLSDACSB20
.LLSDACSB20:
	.uleb128 .LEHB82-.LFB20
	.uleb128 .LEHE82-.LEHB82
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB83-.LFB20
	.uleb128 .LEHE83-.LEHB83
	.uleb128 .L1275-.LFB20
	.uleb128 0
	.uleb128 .LEHB84-.LFB20
	.uleb128 .LEHE84-.LEHB84
	.uleb128 0
	.uleb128 0
.LLSDACSE20:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC20
	.type	math_prime_util__count__lmo__storage__word_holders__put_image.cold, @function
math_prime_util__count__lmo__storage__word_holders__put_image.cold:
.LFSB20:
.L1274:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	movq	%rsp, %rdi
.LEHB85:
	call	system__secondary_stack__ss_release@PLT
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE85:
	.cfi_endproc
.LFE20:
	.section	.gcc_except_table
.LLSDAC20:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC20-.LLSDACSBC20
.LLSDACSBC20:
	.uleb128 .LEHB85-.LCOLDB64
	.uleb128 .LEHE85-.LEHB85
	.uleb128 0
	.uleb128 0
.LLSDACSEC20:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__put_image, .-math_prime_util__count__lmo__storage__word_holders__put_image
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__put_image.cold, .-math_prime_util__count__lmo__storage__word_holders__put_image.cold
.LCOLDE64:
	.text
.LHOTE64:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__holderPI__2
	.type	math_prime_util__count__lmo__storage__word_holders__holderPI__2, @function
math_prime_util__count__lmo__storage__word_holders__holderPI__2:
.LFB121:
	.cfi_startproc
	jmp	math_prime_util__count__lmo__storage__word_holders__put_image
	.cfi_endproc
.LFE121:
	.size	math_prime_util__count__lmo__storage__word_holders__holderPI__2, .-math_prime_util__count__lmo__storage__word_holders__holderPI__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__holderIPXnn
	.type	math_prime_util__count__lmo__storage__word_holders__holderIPXnn, @function
math_prime_util__count__lmo__storage__word_holders__holderIPXnn:
.LFB80:
	.cfi_startproc
	testl	%esi, %esi
	jne	.L1280
	leaq	32+math_prime_util__count__lmo__storage__word_holders__holderT(%rip), %rax
	movq	%rax, (%rdi)
.L1281:
	movq	$0, 8(%rdi)
	movl	$0, 16(%rdi)
	ret
	.p2align 4,,10
	.p2align 3
.L1280:
	cmpl	$3, %esi
	jne	.L1281
	ret
	.cfi_endproc
.LFE80:
	.size	math_prime_util__count__lmo__storage__word_holders__holderIPXnn, .-math_prime_util__count__lmo__storage__word_holders__holderIPXnn
	.section	.text.unlikely
	.align 2
.LCOLDB65:
	.text
.LHOTB65:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__holderSI__2
	.type	math_prime_util__count__lmo__storage__word_holders__holderSI__2, @function
math_prime_util__count__lmo__storage__word_holders__holderSI__2:
.LFB83:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA83
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	leaq	math_prime_util__count__lmo__storage__word_holders__holderFDXnn(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	$0, (%rsp)
	movq	%rax, 24(%rsp)
	movl	$4, %eax
	movq	$0, 8(%rsp)
	cmpl	%eax, %edx
	movq	$0, 16(%rsp)
	cmovle	%edx, %eax
	movq	%rsp, %rdx
	movl	%eax, %ebp
.LEHB86:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	32+math_prime_util__count__lmo__storage__word_holders__holderT(%rip), %rax
	movl	%ebp, %edx
	movq	%rbx, %rsi
	movq	%r12, %rdi
	movl	$0, 16(%rbx)
	movq	%rax, %xmm0
	movups	%xmm0, (%rbx)
	call	math_prime_util__count__lmo__storage__word_holders__read
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE86:
.LEHB87:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__count__lmo__storage__word_holders__holderFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE87:
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
.L1289:
	.cfi_restore_state
	movq	%rax, %rbx
	jmp	.L1288
	.section	.gcc_except_table
.LLSDA83:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE83-.LLSDACSB83
.LLSDACSB83:
	.uleb128 .LEHB86-.LFB83
	.uleb128 .LEHE86-.LEHB86
	.uleb128 .L1289-.LFB83
	.uleb128 0
	.uleb128 .LEHB87-.LFB83
	.uleb128 .LEHE87-.LEHB87
	.uleb128 0
	.uleb128 0
.LLSDACSE83:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC83
	.type	math_prime_util__count__lmo__storage__word_holders__holderSI__2.cold, @function
math_prime_util__count__lmo__storage__word_holders__holderSI__2.cold:
.LFSB83:
.L1288:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	%rsp, %r10
.LEHB88:
	call	math_prime_util__count__lmo__storage__word_holders__holderSI__R47b___finalizer__2Xnn.16
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE88:
	.cfi_endproc
.LFE83:
	.section	.gcc_except_table
.LLSDAC83:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC83-.LLSDACSBC83
.LLSDACSBC83:
	.uleb128 .LEHB88-.LCOLDB65
	.uleb128 .LEHE88-.LEHB88
	.uleb128 0
	.uleb128 0
.LLSDACSEC83:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__holderSI__2, .-math_prime_util__count__lmo__storage__word_holders__holderSI__2
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__holderSI__2.cold, .-math_prime_util__count__lmo__storage__word_holders__holderSI__2.cold
.LCOLDE65:
	.text
.LHOTE65:
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__word_holders__T185bXnn, @function
math_prime_util__count__lmo__storage__word_holders__T185bXnn:
.LFB126:
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
	movl	$24, %edi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movl	%ebp, %edx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__count__lmo__storage__word_holders__holderSI__2
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE126:
	.size	math_prime_util__count__lmo__storage__word_holders__T185bXnn, .-math_prime_util__count__lmo__storage__word_holders__T185bXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__TholderCFDXnn
	.type	math_prime_util__count__lmo__storage__word_holders__TholderCFDXnn, @function
math_prime_util__count__lmo__storage__word_holders__TholderCFDXnn:
.LFB89:
	.cfi_startproc
	movq	(%rdi), %rax
	movq	-24(%rax), %rax
	movq	64(%rax), %rax
	testb	$1, %al
	jne	.L1300
.L1296:
	movl	$1, %esi
	jmp	*%rax
.L1300:
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1296
	.cfi_endproc
.LFE89:
	.size	math_prime_util__count__lmo__storage__word_holders__TholderCFDXnn, .-math_prime_util__count__lmo__storage__word_holders__TholderCFDXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_control_typeIPXnn
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typeIPXnn, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typeIPXnn:
.LFB90:
	.cfi_startproc
	testl	%esi, %esi
	jne	.L1302
	leaq	32+math_prime_util__count__lmo__storage__word_holders__reference_control_typeT(%rip), %rax
	movq	%rax, (%rdi)
.L1303:
	movq	$0, 8(%rdi)
	ret
	.p2align 4,,10
	.p2align 3
.L1302:
	cmpl	$3, %esi
	jne	.L1303
	ret
	.cfi_endproc
.LFE90:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typeIPXnn, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typeIPXnn
	.section	.text.unlikely
	.align 2
.LCOLDB66:
	.text
.LHOTB66:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2:
.LFB96:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA96
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	leaq	math_prime_util__count__lmo__storage__word_holders__reference_control_typeFDXnn(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	$0, (%rsp)
	movq	%rax, 24(%rsp)
	movl	$4, %eax
	movq	$0, 8(%rsp)
	cmpl	%eax, %edx
	movq	$0, 16(%rsp)
	cmovle	%edx, %eax
	movq	%rsp, %rdx
	movl	%eax, %ebp
.LEHB89:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	32+math_prime_util__count__lmo__storage__word_holders__reference_control_typeT(%rip), %rax
	movl	%ebp, %edx
	movq	%rbx, %rsi
	movq	%r12, %rdi
	movq	%rax, %xmm0
	movups	%xmm0, (%rbx)
	call	ada__finalization__controlledSR__2@PLT
	movq	%r12, %rdi
	call	system__stream_attributes__i_as@PLT
	movq	%rax, 8(%rbx)
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE89:
.LEHB90:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__count__lmo__storage__word_holders__reference_control_typeFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE90:
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
.L1311:
	.cfi_restore_state
	movq	%rax, %rbx
	jmp	.L1310
	.section	.gcc_except_table
.LLSDA96:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE96-.LLSDACSB96
.LLSDACSB96:
	.uleb128 .LEHB89-.LFB96
	.uleb128 .LEHE89-.LEHB89
	.uleb128 .L1311-.LFB96
	.uleb128 0
	.uleb128 .LEHB90-.LFB96
	.uleb128 .LEHE90-.LEHB90
	.uleb128 0
	.uleb128 0
.LLSDACSE96:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC96
	.type	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2.cold, @function
math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2.cold:
.LFSB96:
.L1310:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
.LEHB91:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__count__lmo__storage__word_holders__reference_control_typeFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE91:
	.cfi_endproc
.LFE96:
	.section	.gcc_except_table
.LLSDAC96:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC96-.LLSDACSBC96
.LLSDACSBC96:
	.uleb128 .LEHB91-.LCOLDB66
	.uleb128 .LEHE91-.LEHB91
	.uleb128 0
	.uleb128 0
.LLSDACSEC96:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2.cold, .-math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2.cold
.LCOLDE66:
	.text
.LHOTE66:
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__word_holders__T254bXnn, @function
math_prime_util__count__lmo__storage__word_holders__T254bXnn:
.LFB129:
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
	movl	$16, %edi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movl	%ebp, %edx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__count__lmo__storage__word_holders__reference_control_typeSI__2
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE129:
	.size	math_prime_util__count__lmo__storage__word_holders__T254bXnn, .-math_prime_util__count__lmo__storage__word_holders__T254bXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__Treference_control_typeCFDXnn
	.type	math_prime_util__count__lmo__storage__word_holders__Treference_control_typeCFDXnn, @function
math_prime_util__count__lmo__storage__word_holders__Treference_control_typeCFDXnn:
.LFB103:
	.cfi_startproc
	movq	(%rdi), %rax
	movq	-24(%rax), %rax
	movq	64(%rax), %rax
	testb	$1, %al
	jne	.L1322
.L1318:
	movl	$1, %esi
	jmp	*%rax
.L1322:
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1318
	.cfi_endproc
.LFE103:
	.size	math_prime_util__count__lmo__storage__word_holders__Treference_control_typeCFDXnn, .-math_prime_util__count__lmo__storage__word_holders__Treference_control_typeCFDXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeEQXnn
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeEQXnn, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeEQXnn:
.LFB104:
	.cfi_startproc
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	je	.L1324
.L1327:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1324:
	testq	%rax, %rax
	je	.L1326
	movq	8(%rsi), %rax
	cmpq	%rax, 8(%rdi)
	jne	.L1327
.L1326:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, %rdx
	leaq	16(%rsi), %rsi
	movq	%rdi, %rcx
	leaq	16(%rdi), %rdi
	movq	%rdx, 8(%rsp)
	movq	%rcx, (%rsp)
	call	ada__finalization__Oeq__3@PLT
	testb	%al, %al
	je	.L1323
	movq	8(%rsp), %rdx
	movq	(%rsp), %rcx
	movq	24(%rdx), %rax
	cmpq	%rax, 24(%rcx)
	sete	%al
.L1323:
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE104:
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeEQXnn, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeEQXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDIXnn
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDIXnn, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDIXnn:
.LFB105:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE105:
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDIXnn, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDIXnn
	.section	.text.unlikely
	.align 2
.LCOLDB67:
	.text
.LHOTB67:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn:
.LFB106:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA106
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.LEHB92:
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE92:
	movl	%eax, %r14d
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1338
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	24(%rbx), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L1349
	addl	$1, %eax
	movl	%eax, 16(%rdx)
.L1338:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L1349:
	.cfi_restore_state
	movl	$98, %esi
	leaq	.LC24(%rip), %rdi
.LEHB93:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE93:
.L1344:
	movq	%rax, %rbx
	jmp	.L1341
	.section	.gcc_except_table
	.align 4
.LLSDA106:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT106-.LLSDATTD106
.LLSDATTD106:
	.byte	0x1
	.uleb128 .LLSDACSE106-.LLSDACSB106
.LLSDACSB106:
	.uleb128 .LEHB92-.LFB106
	.uleb128 .LEHE92-.LEHB92
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB93-.LFB106
	.uleb128 .LEHE93-.LEHB93
	.uleb128 .L1344-.LFB106
	.uleb128 0x1
.LLSDACSE106:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT106:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC106
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn.cold, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn.cold:
.LFSB106:
.L1341:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1350
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB94:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	jne	.L1338
	movl	$158, %esi
	leaq	.LC36(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1350:
	call	_Unwind_Resume@PLT
.LEHE94:
	.cfi_endproc
.LFE106:
	.section	.gcc_except_table
	.align 4
.LLSDAC106:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC106-.LLSDATTDC106
.LLSDATTDC106:
	.byte	0x1
	.uleb128 .LLSDACSEC106-.LLSDACSBC106
.LLSDACSBC106:
	.uleb128 .LEHB94-.LCOLDB67
	.uleb128 .LEHE94-.LEHB94
	.uleb128 0
	.uleb128 0
.LLSDACSEC106:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC106:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn.cold, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn.cold
.LCOLDE67:
	.text
.LHOTE67:
	.section	.rodata.str1.8
	.align 8
.LC68:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Constant_Reference: container is empty"
	.section	.text.unlikely
	.align 2
.LCOLDB69:
	.text
.LHOTB69:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__constant_reference
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference:
.LFB7:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA7
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	leaq	112(%rsp), %rax
	movq	%r14, 88(%rsp)
	movq	%rax, 72(%rsp)
	movq	8(%rsi), %rax
	movq	%r15, 96(%rsp)
	movq	%rbx, 80(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	.cfi_offset 3, -32
	testq	%rax, %rax
	je	.L1371
	movdqu	8(%rax), %xmm0
	movq	%rdi, %rbx
	movq	%rsi, 40(%rsp)
	leaq	32+math_prime_util__count__lmo__storage__word_holders__reference_control_typeT(%rip), %rax
	leaq	16(%rsp), %rdi
	leaq	48(%rsp), %rdx
	movq	$0, 48(%rsp)
	leaq	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn(%rip), %rsi
	movq	%rax, 32(%rsp)
	movq	$0, 56(%rsp)
	movq	$0, 64(%rsp)
	movaps	%xmm0, 16(%rsp)
.LEHB95:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	40(%rsp), %rax
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	40(%rsp), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L1372
	addl	$1, %eax
	movl	$1, %esi
	movq	%rbx, %rdi
	movl	%eax, 16(%rdx)
	movdqa	16(%rsp), %xmm0
	movups	%xmm0, (%rbx)
	movdqa	32(%rsp), %xmm0
	movups	%xmm0, 16(%rbx)
	call	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDAXnn
.LEHE95:
.LEHB96:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %r14d
	call	*system__soft_links__abort_defer(%rip)
.LEHE96:
	leaq	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn(%rip), %rsi
	leaq	48(%rsp), %rdi
.LEHB97:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE97:
.LEHB98:
	call	*system__soft_links__abort_undefer(%rip)
.L1366:
	movq	%rbx, %rax
	movq	88(%rsp), %r14
	movq	80(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	movq	96(%rsp), %r15
	addq	$104, %rsp
	.cfi_def_cfa_offset 8
	ret
.L1371:
	.cfi_restore_state
	leaq	.LC68(%rip), %rsi
	leaq	.LC1(%rip), %rdx
	leaq	constraint_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
.LEHE98:
.L1372:
	movl	$158, %esi
	leaq	.LC24(%rip), %rdi
.LEHB99:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE99:
.L1364:
	movq	%rax, %rdi
	jmp	.L1355
.L1363:
	movq	%rax, %r14
	jmp	.L1358
	.section	.gcc_except_table
	.align 4
.LLSDA7:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT7-.LLSDATTD7
.LLSDATTD7:
	.byte	0x1
	.uleb128 .LLSDACSE7-.LLSDACSB7
.LLSDACSB7:
	.uleb128 .LEHB95-.LFB7
	.uleb128 .LEHE95-.LEHB95
	.uleb128 .L1363-.LFB7
	.uleb128 0
	.uleb128 .LEHB96-.LFB7
	.uleb128 .LEHE96-.LEHB96
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB97-.LFB7
	.uleb128 .LEHE97-.LEHB97
	.uleb128 .L1364-.LFB7
	.uleb128 0x1
	.uleb128 .LEHB98-.LFB7
	.uleb128 .LEHE98-.LEHB98
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB99-.LFB7
	.uleb128 .LEHE99-.LEHB99
	.uleb128 .L1363-.LFB7
	.uleb128 0
.LLSDACSE7:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT7:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC7
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference.cold, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference.cold:
.LFSB7:
.L1355:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	subq	$1, %rdx
	jne	.L1370
	movq	%rax, 8(%rsp)
	call	__gnat_begin_handler_v1@PLT
	movq	8(%rsp), %rdi
	xorl	%edx, %edx
	movq	%rax, %rsi
.LEHB100:
	call	__gnat_end_handler_v1@PLT
	call	*system__soft_links__abort_undefer(%rip)
	andb	$1, %r14b
	jne	.L1366
.L1357:
	movl	$152, %esi
	leaq	.LC24(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1358:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %r15d
	call	*system__soft_links__abort_defer(%rip)
.LEHE100:
	leaq	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeFDXnn(%rip), %rsi
	leaq	48(%rsp), %rdi
.LEHB101:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE101:
	xorl	%ebx, %ebx
.L1362:
.LEHB102:
	call	*system__soft_links__abort_undefer(%rip)
	movl	%r15d, %eax
	xorl	$1, %eax
	testb	%bl, %al
	jne	.L1357
	movq	%r14, %rdi
.L1370:
	call	_Unwind_Resume@PLT
.L1365:
	subq	$1, %rdx
	movq	%rax, %rbx
	movq	%rax, %rdi
	jne	.L1370
	call	__gnat_begin_handler_v1@PLT
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movl	$1, %ebx
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
.LEHE102:
	jmp	.L1362
	.cfi_endproc
.LFE7:
	.section	.gcc_except_table
	.align 4
.LLSDAC7:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC7-.LLSDATTDC7
.LLSDATTDC7:
	.byte	0x1
	.uleb128 .LLSDACSEC7-.LLSDACSBC7
.LLSDACSBC7:
	.uleb128 .LEHB100-.LCOLDB69
	.uleb128 .LEHE100-.LEHB100
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB101-.LCOLDB69
	.uleb128 .LEHE101-.LEHB101
	.uleb128 .L1365-.LCOLDB69
	.uleb128 0x1
	.uleb128 .LEHB102-.LCOLDB69
	.uleb128 .LEHE102-.LEHB102
	.uleb128 0
	.uleb128 0
.LLSDACSEC7:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC7:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference, .-math_prime_util__count__lmo__storage__word_holders__constant_reference
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference.cold, .-math_prime_util__count__lmo__storage__word_holders__constant_reference.cold
.LCOLDE69:
	.text
.LHOTE69:
	.section	.text.unlikely
	.align 2
.LCOLDB70:
	.text
.LHOTB70:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDFXnn
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDFXnn, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDFXnn:
.LFB107:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA107
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rbx, (%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%r14, 16(%rsp)
.LEHB103:
	.cfi_offset 14, -16
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE103:
	movl	%eax, %r14d
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1373
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -24
	movq	8(%rax), %rbp
	lock subl	$1, 0(%rbp)
	je	.L1375
.L1377:
	movq	24(%rbx), %rax
	movq	8(%rsp), %rbp
	.cfi_restore 6
	subl	$1, 16(%rax)
	movq	$0, 24(%rbx)
.L1373:
	movq	(%rsp), %rbx
	movq	16(%rsp), %r14
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1375:
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -24
	movq	8(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L1376
	subq	$8, %rdi
.LEHB104:
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rbp)
.L1376:
	movq	%rbp, %rdi
	call	__gnat_free@PLT
.LEHE104:
	jmp	.L1377
.L1381:
	movq	%rax, %rbx
	jmp	.L1378
	.section	.gcc_except_table
	.align 4
.LLSDA107:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT107-.LLSDATTD107
.LLSDATTD107:
	.byte	0x1
	.uleb128 .LLSDACSE107-.LLSDACSB107
.LLSDACSB107:
	.uleb128 .LEHB103-.LFB107
	.uleb128 .LEHE103-.LEHB103
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB104-.LFB107
	.uleb128 .LEHE104-.LEHB104
	.uleb128 .L1381-.LFB107
	.uleb128 0x1
.LLSDACSE107:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT107:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC107
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDFXnn.cold, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDFXnn.cold:
.LFSB107:
.L1378:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1390
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB105:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	je	.L1380
	movq	8(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	jmp	.L1373
.L1390:
	.cfi_restore_state
	call	_Unwind_Resume@PLT
.L1380:
	movl	$158, %esi
	leaq	.LC36(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.LEHE105:
	.cfi_endproc
.LFE107:
	.section	.gcc_except_table
	.align 4
.LLSDAC107:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC107-.LLSDATTDC107
.LLSDATTDC107:
	.byte	0x1
	.uleb128 .LLSDACSEC107-.LLSDACSBC107
.LLSDACSBC107:
	.uleb128 .LEHB105-.LCOLDB70
	.uleb128 .LEHE105-.LEHB105
	.uleb128 0
	.uleb128 0
.LLSDACSEC107:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC107:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDFXnn, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDFXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDFXnn.cold, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeDFXnn.cold
.LCOLDE70:
	.text
.LHOTE70:
	.section	.rodata.str1.8
	.align 8
.LC71:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders: uninitialized reference"
	.section	.text.unlikely
	.align 2
.LCOLDB72:
	.text
.LHOTB72:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeIPXnn
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeIPXnn, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeIPXnn:
.LFB109:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA109
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, 24(%rsp)
	movq	%rsi, (%rdi)
	leaq	.LC71(%rip), %rsi
	movq	%rdx, 8(%rdi)
	leaq	.LC18(%rip), %rdx
	leaq	program_error(%rip), %rdi
.LEHB106:
	.cfi_offset 3, -24
	call	__gnat_raise_exception@PLT
.LEHE106:
.L1396:
	movq	%rax, %rbx
	jmp	.L1392
	.section	.gcc_except_table
	.align 4
.LLSDA109:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT109-.LLSDATTD109
.LLSDATTD109:
	.byte	0x1
	.uleb128 .LLSDACSE109-.LLSDACSB109
.LLSDACSB109:
	.uleb128 .LEHB106-.LFB109
	.uleb128 .LEHE106-.LEHB106
	.uleb128 .L1396-.LFB109
	.uleb128 0x1
.LLSDACSE109:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
	.long	DW.ref.__gnat_others_value-.
.LLSDATT109:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC109
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeIPXnn.cold, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeIPXnn.cold:
.LFSB109:
.L1392:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -24
	subq	$1, %rdx
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	movq	%rax, %rdi
	jne	.L1399
	call	__gnat_begin_handler_v1@PLT
	movq	%rax, %r14
.LEHB107:
	call	ada__exceptions__triggered_by_abort@PLT
.L1394:
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE107:
.L1397:
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r14, %rsi
	movq	%rax, 8(%rsp)
.LEHB108:
	call	__gnat_end_handler_v1@PLT
	movq	8(%rsp), %rdi
.L1399:
	call	_Unwind_Resume@PLT
.LEHE108:
	.cfi_endproc
.LFE109:
	.section	.gcc_except_table
	.align 4
.LLSDAC109:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC109-.LLSDATTDC109
.LLSDATTDC109:
	.byte	0x1
	.uleb128 .LLSDACSEC109-.LLSDACSBC109
.LLSDACSBC109:
	.uleb128 .LEHB107-.LCOLDB72
	.uleb128 .LEHE107-.LEHB107
	.uleb128 .L1397-.LCOLDB72
	.uleb128 0
	.uleb128 .LEHB108-.LCOLDB72
	.uleb128 .LEHE108-.LEHB108
	.uleb128 0
	.uleb128 0
.LLSDACSEC109:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC109:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeIPXnn, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeIPXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeIPXnn.cold, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeIPXnn.cold
.LCOLDE72:
	.text
.LHOTE72:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_typeEQXnn
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeEQXnn, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeEQXnn:
.LFB111:
	.cfi_startproc
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	je	.L1401
.L1404:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1401:
	testq	%rax, %rax
	je	.L1403
	movq	8(%rsi), %rax
	cmpq	%rax, 8(%rdi)
	jne	.L1404
.L1403:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, %rdx
	leaq	16(%rsi), %rsi
	movq	%rdi, %rcx
	leaq	16(%rdi), %rdi
	movq	%rdx, 8(%rsp)
	movq	%rcx, (%rsp)
	call	ada__finalization__Oeq__3@PLT
	testb	%al, %al
	je	.L1400
	movq	8(%rsp), %rdx
	movq	(%rsp), %rcx
	movq	24(%rdx), %rax
	cmpq	%rax, 24(%rcx)
	sete	%al
.L1400:
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE111:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeEQXnn, .-math_prime_util__count__lmo__storage__word_holders__reference_typeEQXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_typeDIXnn
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeDIXnn, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeDIXnn:
.LFB260:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE260:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeDIXnn, .-math_prime_util__count__lmo__storage__word_holders__reference_typeDIXnn
	.section	.text.unlikely
	.align 2
.LCOLDB73:
	.text
.LHOTB73:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn:
.LFB113:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA113
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.LEHB109:
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE109:
	movl	%eax, %r14d
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1415
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	24(%rbx), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L1426
	addl	$1, %eax
	movl	%eax, 16(%rdx)
.L1415:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L1426:
	.cfi_restore_state
	movl	$98, %esi
	leaq	.LC24(%rip), %rdi
.LEHB110:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE110:
.L1421:
	movq	%rax, %rbx
	jmp	.L1418
	.section	.gcc_except_table
	.align 4
.LLSDA113:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT113-.LLSDATTD113
.LLSDATTD113:
	.byte	0x1
	.uleb128 .LLSDACSE113-.LLSDACSB113
.LLSDACSB113:
	.uleb128 .LEHB109-.LFB113
	.uleb128 .LEHE109-.LEHB109
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB110-.LFB113
	.uleb128 .LEHE110-.LEHB110
	.uleb128 .L1421-.LFB113
	.uleb128 0x1
.LLSDACSE113:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT113:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC113
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn.cold, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn.cold:
.LFSB113:
.L1418:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1427
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB111:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	jne	.L1415
	movl	$180, %esi
	leaq	.LC36(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1427:
	call	_Unwind_Resume@PLT
.LEHE111:
	.cfi_endproc
.LFE113:
	.section	.gcc_except_table
	.align 4
.LLSDAC113:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC113-.LLSDATTDC113
.LLSDATTDC113:
	.byte	0x1
	.uleb128 .LLSDACSEC113-.LLSDACSBC113
.LLSDACSBC113:
	.uleb128 .LEHB111-.LCOLDB73
	.uleb128 .LEHE111-.LEHB111
	.uleb128 0
	.uleb128 0
.LLSDACSEC113:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC113:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn, .-math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn.cold, .-math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn.cold
.LCOLDE73:
	.text
.LHOTE73:
	.section	.rodata.str1.8
	.align 8
.LC74:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Word_Holders.Reference: container is empty"
	.section	.text.unlikely
	.align 2
.LCOLDB75:
	.text
.LHOTB75:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference
	.type	math_prime_util__count__lmo__storage__word_holders__reference, @function
math_prime_util__count__lmo__storage__word_holders__reference:
.LFB27:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA27
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	cmpq	$0, 8(%rsi)
	leaq	112(%rsp), %rax
	movq	%r14, 96(%rsp)
	movq	%rax, 72(%rsp)
	movq	%rbx, 80(%rsp)
	movq	%rbp, 88(%rsp)
	.cfi_offset 14, -16
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	je	.L1448
	movq	%rsi, %rbx
	movq	%rdi, %rbp
	movq	%rsi, %rdi
.LEHB112:
	call	math_prime_util__count__lmo__storage__word_holders__detach
.LEHE112:
	movq	8(%rbx), %rax
	leaq	16(%rsp), %rdi
	leaq	48(%rsp), %rdx
	movq	$0, 48(%rsp)
	leaq	math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn(%rip), %rsi
	movq	$0, 56(%rsp)
	movdqu	8(%rax), %xmm0
	leaq	32+math_prime_util__count__lmo__storage__word_holders__reference_control_typeT(%rip), %rax
	movq	$0, 64(%rsp)
	movq	%rbx, 40(%rsp)
	movq	%rax, 32(%rsp)
	movaps	%xmm0, 16(%rsp)
.LEHB113:
	call	system__finalization_primitives__attach_object_to_node@PLT
	movq	40(%rsp), %rax
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	40(%rsp), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L1449
	addl	$1, %eax
	movl	$1, %esi
	movq	%rbp, %rdi
	movl	%eax, 16(%rdx)
	movdqa	16(%rsp), %xmm0
	movups	%xmm0, 0(%rbp)
	movdqa	32(%rsp), %xmm0
	movups	%xmm0, 16(%rbp)
	call	math_prime_util__count__lmo__storage__word_holders__reference_typeDAXnn
.LEHE113:
.LEHB114:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebx
	call	*system__soft_links__abort_defer(%rip)
.LEHE114:
	leaq	math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn(%rip), %rsi
	leaq	48(%rsp), %rdi
.LEHB115:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE115:
.LEHB116:
	call	*system__soft_links__abort_undefer(%rip)
.L1443:
	movq	%rbp, %rax
	movq	80(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	movq	88(%rsp), %rbp
	.cfi_restore 6
	movq	96(%rsp), %r14
	addq	$104, %rsp
	.cfi_def_cfa_offset 8
	ret
.L1448:
	.cfi_restore_state
	leaq	.LC74(%rip), %rsi
	leaq	.LC6(%rip), %rdx
	leaq	constraint_error(%rip), %rdi
	call	__gnat_raise_exception@PLT
.LEHE116:
.L1449:
	movl	$395, %esi
	leaq	.LC24(%rip), %rdi
.LEHB117:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE117:
.L1441:
	movq	%rax, %rdi
	jmp	.L1432
.L1440:
	movq	%rax, %r14
	jmp	.L1435
	.section	.gcc_except_table
	.align 4
.LLSDA27:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT27-.LLSDATTD27
.LLSDATTD27:
	.byte	0x1
	.uleb128 .LLSDACSE27-.LLSDACSB27
.LLSDACSB27:
	.uleb128 .LEHB112-.LFB27
	.uleb128 .LEHE112-.LEHB112
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB113-.LFB27
	.uleb128 .LEHE113-.LEHB113
	.uleb128 .L1440-.LFB27
	.uleb128 0
	.uleb128 .LEHB114-.LFB27
	.uleb128 .LEHE114-.LEHB114
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB115-.LFB27
	.uleb128 .LEHE115-.LEHB115
	.uleb128 .L1441-.LFB27
	.uleb128 0x1
	.uleb128 .LEHB116-.LFB27
	.uleb128 .LEHE116-.LEHB116
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB117-.LFB27
	.uleb128 .LEHE117-.LEHB117
	.uleb128 .L1440-.LFB27
	.uleb128 0
.LLSDACSE27:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT27:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC27
	.type	math_prime_util__count__lmo__storage__word_holders__reference.cold, @function
math_prime_util__count__lmo__storage__word_holders__reference.cold:
.LFSB27:
.L1432:
	.cfi_def_cfa_offset 112
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	jne	.L1447
	movq	%rax, 8(%rsp)
	call	__gnat_begin_handler_v1@PLT
	movq	8(%rsp), %rdi
	xorl	%edx, %edx
	movq	%rax, %rsi
.LEHB118:
	call	__gnat_end_handler_v1@PLT
	call	*system__soft_links__abort_undefer(%rip)
	andb	$1, %bl
	jne	.L1443
.L1434:
	movl	$389, %esi
	leaq	.LC24(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1435:
	call	ada__exceptions__triggered_by_abort@PLT
	movl	%eax, %ebp
	call	*system__soft_links__abort_defer(%rip)
.LEHE118:
	leaq	math_prime_util__count__lmo__storage__word_holders__reference_typeFDXnn(%rip), %rsi
	leaq	48(%rsp), %rdi
.LEHB119:
	call	system__finalization_primitives__finalize_object@PLT
.LEHE119:
	xorl	%ebx, %ebx
.L1439:
.LEHB120:
	call	*system__soft_links__abort_undefer(%rip)
	xorl	$1, %ebp
	testb	%bl, %bpl
	jne	.L1434
	movq	%r14, %rdi
.L1447:
	call	_Unwind_Resume@PLT
.L1442:
	subq	$1, %rdx
	movq	%rax, %rbx
	movq	%rax, %rdi
	jne	.L1447
	call	__gnat_begin_handler_v1@PLT
	movq	%rbx, %rdi
	xorl	%edx, %edx
	movl	$1, %ebx
	movq	%rax, %rsi
	call	__gnat_end_handler_v1@PLT
.LEHE120:
	jmp	.L1439
	.cfi_endproc
.LFE27:
	.section	.gcc_except_table
	.align 4
.LLSDAC27:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC27-.LLSDATTDC27
.LLSDATTDC27:
	.byte	0x1
	.uleb128 .LLSDACSEC27-.LLSDACSBC27
.LLSDACSBC27:
	.uleb128 .LEHB118-.LCOLDB75
	.uleb128 .LEHE118-.LEHB118
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB119-.LCOLDB75
	.uleb128 .LEHE119-.LEHB119
	.uleb128 .L1442-.LCOLDB75
	.uleb128 0x1
	.uleb128 .LEHB120-.LCOLDB75
	.uleb128 .LEHE120-.LEHB120
	.uleb128 0
	.uleb128 0
.LLSDACSEC27:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC27:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__reference, .-math_prime_util__count__lmo__storage__word_holders__reference
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__reference.cold, .-math_prime_util__count__lmo__storage__word_holders__reference.cold
.LCOLDE75:
	.text
.LHOTE75:
	.section	.text.unlikely
	.align 2
.LCOLDB76:
	.text
.LHOTB76:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_typeDFXnn
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeDFXnn, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeDFXnn:
.LFB114:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA114
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rbx, (%rsp)
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	%r14, 16(%rsp)
.LEHB121:
	.cfi_offset 14, -16
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE121:
	movl	%eax, %r14d
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1450
	movq	%rbp, 8(%rsp)
	.cfi_offset 6, -24
	movq	8(%rax), %rbp
	lock subl	$1, 0(%rbp)
	je	.L1452
.L1454:
	movq	24(%rbx), %rax
	movq	8(%rsp), %rbp
	.cfi_restore 6
	subl	$1, 16(%rax)
	movq	$0, 24(%rbx)
.L1450:
	movq	(%rsp), %rbx
	movq	16(%rsp), %r14
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1452:
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -24
	movq	8(%rbp), %rdi
	testq	%rdi, %rdi
	je	.L1453
	subq	$8, %rdi
.LEHB122:
	call	__gnat_free@PLT
	leaq	.LC8(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rbp)
.L1453:
	movq	%rbp, %rdi
	call	__gnat_free@PLT
.LEHE122:
	jmp	.L1454
.L1458:
	movq	%rax, %rbx
	jmp	.L1455
	.section	.gcc_except_table
	.align 4
.LLSDA114:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT114-.LLSDATTD114
.LLSDATTD114:
	.byte	0x1
	.uleb128 .LLSDACSE114-.LLSDACSB114
.LLSDACSB114:
	.uleb128 .LEHB121-.LFB114
	.uleb128 .LEHE121-.LEHB121
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB122-.LFB114
	.uleb128 .LEHE122-.LEHB122
	.uleb128 .L1458-.LFB114
	.uleb128 0x1
.LLSDACSE114:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT114:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC114
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeDFXnn.cold, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeDFXnn.cold:
.LFSB114:
.L1455:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1467
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB123:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	je	.L1457
	movq	8(%rsp), %rbp
	.cfi_remember_state
	.cfi_restore 6
	jmp	.L1450
.L1467:
	.cfi_restore_state
	call	_Unwind_Resume@PLT
.L1457:
	movl	$180, %esi
	leaq	.LC36(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.LEHE123:
	.cfi_endproc
.LFE114:
	.section	.gcc_except_table
	.align 4
.LLSDAC114:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC114-.LLSDATTDC114
.LLSDATTDC114:
	.byte	0x1
	.uleb128 .LLSDACSEC114-.LLSDACSBC114
.LLSDACSBC114:
	.uleb128 .LEHB123-.LCOLDB76
	.uleb128 .LEHE123-.LEHB123
	.uleb128 0
	.uleb128 0
.LLSDACSEC114:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC114:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeDFXnn, .-math_prime_util__count__lmo__storage__word_holders__reference_typeDFXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeDFXnn.cold, .-math_prime_util__count__lmo__storage__word_holders__reference_typeDFXnn.cold
.LCOLDE76:
	.text
.LHOTE76:
	.section	.text.unlikely
	.align 2
.LCOLDB77:
	.text
.LHOTB77:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_typeIPXnn
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeIPXnn, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeIPXnn:
.LFB116:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA116
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, 24(%rsp)
	movq	%rsi, (%rdi)
	leaq	.LC71(%rip), %rsi
	movq	%rdx, 8(%rdi)
	leaq	.LC18(%rip), %rdx
	leaq	program_error(%rip), %rdi
.LEHB124:
	.cfi_offset 3, -24
	call	__gnat_raise_exception@PLT
.LEHE124:
.L1473:
	movq	%rax, %rbx
	jmp	.L1469
	.section	.gcc_except_table
	.align 4
.LLSDA116:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT116-.LLSDATTD116
.LLSDATTD116:
	.byte	0x1
	.uleb128 .LLSDACSE116-.LLSDACSB116
.LLSDACSB116:
	.uleb128 .LEHB124-.LFB116
	.uleb128 .LEHE124-.LEHB124
	.uleb128 .L1473-.LFB116
	.uleb128 0x1
.LLSDACSE116:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
	.long	DW.ref.__gnat_others_value-.
.LLSDATT116:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC116
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeIPXnn.cold, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeIPXnn.cold:
.LFSB116:
.L1469:
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -24
	subq	$1, %rdx
	movq	%r14, 32(%rsp)
	.cfi_offset 14, -16
	movq	%rax, %rdi
	jne	.L1476
	call	__gnat_begin_handler_v1@PLT
	movq	%rax, %r14
.LEHB125:
	call	ada__exceptions__triggered_by_abort@PLT
.L1471:
	movq	%rbx, %rdi
	call	__gnat_reraise_zcx@PLT
.LEHE125:
.L1474:
	movq	%rbx, %rdi
	movq	%rax, %rdx
	movq	%r14, %rsi
	movq	%rax, 8(%rsp)
.LEHB126:
	call	__gnat_end_handler_v1@PLT
	movq	8(%rsp), %rdi
.L1476:
	call	_Unwind_Resume@PLT
.LEHE126:
	.cfi_endproc
.LFE116:
	.section	.gcc_except_table
	.align 4
.LLSDAC116:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC116-.LLSDATTDC116
.LLSDATTDC116:
	.byte	0x1
	.uleb128 .LLSDACSEC116-.LLSDACSBC116
.LLSDACSBC116:
	.uleb128 .LEHB125-.LCOLDB77
	.uleb128 .LEHE125-.LEHB125
	.uleb128 .L1474-.LCOLDB77
	.uleb128 0
	.uleb128 .LEHB126-.LCOLDB77
	.uleb128 .LEHE126-.LEHB126
	.uleb128 0
	.uleb128 0
.LLSDACSEC116:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC116:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeIPXnn, .-math_prime_util__count__lmo__storage__word_holders__reference_typeIPXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeIPXnn.cold, .-math_prime_util__count__lmo__storage__word_holders__reference_typeIPXnn.cold
.LCOLDE77:
	.text
.LHOTE77:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__shared_holderIPXnn
	.type	math_prime_util__count__lmo__storage__word_holders__shared_holderIPXnn, @function
math_prime_util__count__lmo__storage__word_holders__shared_holderIPXnn:
.LFB118:
	.cfi_startproc
	movl	$1, %eax
	xchgl	(%rdi), %eax
	leaq	.LC8(%rip), %rax
	pxor	%xmm0, %xmm0
	movq	%rax, %xmm1
	punpcklqdq	%xmm1, %xmm0
	movups	%xmm0, 8(%rdi)
	ret
	.cfi_endproc
.LFE118:
	.size	math_prime_util__count__lmo__storage__word_holders__shared_holderIPXnn, .-math_prime_util__count__lmo__storage__word_holders__shared_holderIPXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSW
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSW, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSW:
.LFB122:
	.cfi_startproc
	movl	$4, %eax
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	call	math_prime_util__count__lmo__storage__word_holders__write__2
	.cfi_endproc
.LFE122:
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSW, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSW
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSR
	.type	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSR, @function
math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSR:
.LFB123:
	.cfi_startproc
	movl	$4, %eax
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	call	math_prime_util__count__lmo__storage__word_holders__read__2
	.cfi_endproc
.LFE123:
	.size	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSR, .-math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSR
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_typeSW
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeSW, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeSW:
.LFB276:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSW
	.cfi_endproc
.LFE276:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeSW, .-math_prime_util__count__lmo__storage__word_holders__reference_typeSW
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__word_holders__reference_typeSR
	.type	math_prime_util__count__lmo__storage__word_holders__reference_typeSR, @function
math_prime_util__count__lmo__storage__word_holders__reference_typeSR:
.LFB274:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	math_prime_util__count__lmo__storage__word_holders__constant_reference_typeSR
	.cfi_endproc
.LFE274:
	.size	math_prime_util__count__lmo__storage__word_holders__reference_typeSR, .-math_prime_util__count__lmo__storage__word_holders__reference_typeSR
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__factorsIP
	.type	math_prime_util__count__lmo__factorsIP, @function
math_prime_util__count__lmo__factorsIP:
.LFB130:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE130:
	.size	math_prime_util__count__lmo__factorsIP, .-math_prime_util__count__lmo__factorsIP
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__factors_1161SW
	.type	math_prime_util__count__lmo__factors_1161SW, @function
math_prime_util__count__lmo__factors_1161SW:
.LFB131:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	movl	(%rdx), %ebx
	cmpl	4(%rdx), %ebx
	jg	.L1487
	subl	$1, %ebx
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	movslq	%ebx, %rbx
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	movq	%rbx, %rax
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	negq	%rax
	leaq	(%rsi,%rax,2), %r13
	.p2align 4
	.p2align 3
.L1489:
	movzwl	0(%r13,%rbx,2), %esi
	movq	%r12, %rdi
	addq	$1, %rbx
	call	system__stream_attributes__w_su@PLT
	cmpl	%ebx, 4(%rbp)
	jne	.L1489
	movq	16(%rsp), %rbp
	.cfi_restore 6
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
.L1487:
	movq	8(%rsp), %rbx
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE131:
	.size	math_prime_util__count__lmo__factors_1161SW, .-math_prime_util__count__lmo__factors_1161SW
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__factors_1157SO
	.type	math_prime_util__count__lmo__factors_1157SO, @function
math_prime_util__count__lmo__factors_1157SO:
.LFB132:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movl	(%rdx), %esi
	call	system__stream_attributes__w_i@PLT
	movl	4(%rbp), %esi
	movq	%r12, %rdi
	call	system__stream_attributes__w_i@PLT
	movl	0(%rbp), %ebx
	cmpl	4(%rbp), %ebx
	jg	.L1492
	subl	$1, %ebx
	movslq	%ebx, %rbx
	movq	%rbx, %rax
	negq	%rax
	leaq	0(%r13,%rax,2), %r13
	.p2align 4
	.p2align 3
.L1494:
	movzwl	0(%r13,%rbx,2), %esi
	movq	%r12, %rdi
	addq	$1, %rbx
	call	system__stream_attributes__w_su@PLT
	cmpl	%ebx, 4(%rbp)
	jne	.L1494
.L1492:
	addq	$8, %rsp
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
	.cfi_endproc
.LFE132:
	.size	math_prime_util__count__lmo__factors_1157SO, .-math_prime_util__count__lmo__factors_1157SO
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__write
	.type	math_prime_util__count__lmo__storage__factor_holders__write, @function
math_prime_util__count__lmo__storage__factor_holders__write:
.LFB71:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	cmpq	$0, 8(%rsi)
	movl	%edx, %ebx
	sete	%sil
	movzbl	%sil, %esi
	call	system__stream_attributes__w_b@PLT
	movq	8(%rbp), %rax
	testq	%rax, %rax
	je	.L1497
	cmpl	$4, %ebx
	movl	$4, %ecx
	movq	8(%rax), %rsi
	movq	16(%rax), %rdx
	cmovle	%ebx, %ecx
	movq	%r12, %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__count__lmo__factors_1157SO
	.p2align 4,,10
	.p2align 3
.L1497:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE71:
	.size	math_prime_util__count__lmo__storage__factor_holders__write, .-math_prime_util__count__lmo__storage__factor_holders__write
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__holderSW__2
	.type	math_prime_util__count__lmo__storage__factor_holders__holderSW__2, @function
math_prime_util__count__lmo__storage__factor_holders__holderSW__2:
.LFB176:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	cmpq	$0, 8(%rsi)
	movl	%edx, %ebx
	sete	%sil
	movzbl	%sil, %esi
	call	system__stream_attributes__w_b@PLT
	movq	8(%rbp), %rax
	testq	%rax, %rax
	je	.L1500
	cmpl	$4, %ebx
	movl	$4, %ecx
	movq	8(%rax), %rsi
	movq	16(%rax), %rdx
	cmovle	%ebx, %ecx
	movq	%r12, %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__count__lmo__factors_1157SO
	.p2align 4,,10
	.p2align 3
.L1500:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE176:
	.size	math_prime_util__count__lmo__storage__factor_holders__holderSW__2, .-math_prime_util__count__lmo__storage__factor_holders__holderSW__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__holderSO__2
	.type	math_prime_util__count__lmo__storage__factor_holders__holderSO__2, @function
math_prime_util__count__lmo__storage__factor_holders__holderSO__2:
.LFB270:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	cmpq	$0, 8(%rsi)
	movl	%edx, %ebx
	sete	%sil
	movzbl	%sil, %esi
	call	system__stream_attributes__w_b@PLT
	movq	8(%rbp), %rax
	testq	%rax, %rax
	je	.L1503
	cmpl	$4, %ebx
	movl	$4, %ecx
	movq	8(%rax), %rsi
	movq	16(%rax), %rdx
	cmovle	%ebx, %ecx
	movq	%r12, %rdi
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	math_prime_util__count__lmo__factors_1157SO
	.p2align 4,,10
	.p2align 3
.L1503:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE270:
	.size	math_prime_util__count__lmo__storage__factor_holders__holderSO__2, .-math_prime_util__count__lmo__storage__factor_holders__holderSO__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__factors_1069SR
	.type	math_prime_util__count__lmo__factors_1069SR, @function
math_prime_util__count__lmo__factors_1069SR:
.LFB133:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rbx, 8(%rsp)
	.cfi_offset 3, -40
	movl	(%rdx), %ebx
	cmpl	4(%rdx), %ebx
	jg	.L1506
	subl	$1, %ebx
	movq	%rbp, 16(%rsp)
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	movslq	%ebx, %rbx
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -24
	movq	%rdi, %r12
	movq	%rbx, %rax
	movq	%r13, 32(%rsp)
	.cfi_offset 13, -16
	negq	%rax
	leaq	(%rsi,%rax,2), %r13
	.p2align 4
	.p2align 3
.L1508:
	movq	%r12, %rdi
	call	system__stream_attributes__i_su@PLT
	movw	%ax, 0(%r13,%rbx,2)
	addq	$1, %rbx
	cmpl	%ebx, 4(%rbp)
	jne	.L1508
	movq	16(%rsp), %rbp
	.cfi_restore 6
	movq	24(%rsp), %r12
	.cfi_restore 12
	movq	32(%rsp), %r13
	.cfi_restore 13
.L1506:
	movq	8(%rsp), %rbx
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE133:
	.size	math_prime_util__count__lmo__factors_1069SR, .-math_prime_util__count__lmo__factors_1069SR
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__factors_1062SI
	.type	math_prime_util__count__lmo__factors_1062SI, @function
math_prime_util__count__lmo__factors_1062SI:
.LFB134:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%r12, 24(%rsp)
	.cfi_offset 12, -40
	movq	%rdi, %r12
	movq	%rbx, 8(%rsp)
	movq	%r14, 40(%rsp)
	movq	%r13, 32(%rsp)
	.cfi_offset 3, -56
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	call	system__stream_attributes__i_i@PLT
	movq	%r12, %rdi
	movl	%eax, %ebx
	call	system__stream_attributes__i_i@PLT
	movl	%eax, %r14d
	cmpl	%eax, %ebx
	jg	.L1512
	movslq	%ebx, %rdx
	cltq
	movl	$4, %esi
	movq	%rbp, 16(%rsp)
	subq	%rdx, %rax
	movq	%r15, 48(%rsp)
	.cfi_offset 6, -48
	.cfi_offset 15, -16
	leaq	13(%rax,%rax), %rdi
	andq	$-4, %rdi
	call	system__secondary_stack__ss_allocate@PLT
	movl	%ebx, (%rax)
	subl	$1, %ebx
	movq	%rax, %rbp
	movq	%rax, %r13
	movslq	%ebx, %rbx
	movl	%r14d, 4(%rax)
	leaq	8(%rax), %r14
	movq	%rbx, %rax
	negq	%rax
	leaq	0(%rbp,%rax,2), %r15
	.p2align 4
	.p2align 3
.L1513:
	movq	%r12, %rdi
	call	system__stream_attributes__i_su@PLT
	movw	%ax, 8(%r15,%rbx,2)
	addq	$1, %rbx
	cmpl	%ebx, 4(%rbp)
	jne	.L1513
	movq	16(%rsp), %rbp
	.cfi_restore 6
	movq	48(%rsp), %r15
	.cfi_restore 15
.L1514:
	movq	%r14, %rax
	movq	%r13, %rdx
	movq	8(%rsp), %rbx
	movq	24(%rsp), %r12
	movq	32(%rsp), %r13
	movq	40(%rsp), %r14
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1512:
	.cfi_restore_state
	movl	$4, %esi
	movl	$8, %edi
	call	system__secondary_stack__ss_allocate@PLT
	movl	%r14d, 4(%rax)
	movq	%rax, %r13
	leaq	8(%rax), %r14
	movl	%ebx, (%rax)
	jmp	.L1514
	.cfi_endproc
.LFE134:
	.size	math_prime_util__count__lmo__factors_1062SI, .-math_prime_util__count__lmo__factors_1062SI
	.section	.text.unlikely
	.align 2
.LCOLDB78:
	.text
.LHOTB78:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__read
	.type	math_prime_util__count__lmo__storage__factor_holders__read, @function
math_prime_util__count__lmo__storage__factor_holders__read:
.LFB58:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA58
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	leaq	96(%rsp), %rax
	movq	%rax, 40(%rsp)
	movl	16(%rsi), %eax
	movq	%rbx, 56(%rsp)
	testl	%eax, %eax
	movq	%rbp, 64(%rsp)
	movq	%r12, 72(%rsp)
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	jne	.L1540
	movq	8(%rsi), %rax
	movq	%rdi, %rbp
	movq	%rsi, %rbx
	movl	%edx, %r12d
	testq	%rax, %rax
	je	.L1520
	lock subl	$1, (%rax)
	je	.L1541
.L1521:
	movq	$0, 8(%rbx)
.L1520:
	movq	%rbp, %rdi
.LEHB127:
	call	system__stream_attributes__i_b@PLT
	testb	%al, %al
	je	.L1542
.L1518:
	movq	56(%rsp), %rbx
	.cfi_remember_state
	.cfi_restore 3
	movq	64(%rsp), %rbp
	.cfi_restore 6
	movq	72(%rsp), %r12
	.cfi_restore 12
	addq	$88, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L1541:
	.cfi_restore_state
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	je	.L1522
	subq	$8, %rdi
	movq	%rax, 8(%rsp)
	call	__gnat_free@PLT
	leaq	.LC15(%rip), %rdx
	movq	8(%rsp), %rax
	pxor	%xmm0, %xmm0
	movq	%rdx, %xmm2
	punpcklqdq	%xmm2, %xmm0
	movups	%xmm0, 8(%rax)
.L1522:
	movq	%rax, %rdi
	call	__gnat_free@PLT
.LEHE127:
	jmp	.L1521
	.p2align 4,,10
	.p2align 3
.L1542:
	movl	$4, %eax
	leaq	16(%rsp), %rdi
	movq	%r14, 80(%rsp)
	cmpl	%eax, %r12d
	cmovg	%eax, %r12d
.LEHB128:
	.cfi_offset 14, -16
	call	system__secondary_stack__ss_mark@PLT
	movl	%r12d, %esi
	movq	%rbp, %rdi
	call	math_prime_util__count__lmo__factors_1062SI
	movslq	(%rdx), %r8
	movq	%rax, %r14
	movslq	4(%rdx), %rax
	movl	$8, %edi
	movq	%rdx, %r12
	movq	%rax, %rcx
	subq	%r8, %rax
	leaq	13(%rax,%rax), %rax
	andq	$-4, %rax
	cmpl	%ecx, %r8d
	cmovle	%rax, %rdi
	call	__gnat_malloc@PLT
	movq	(%r12), %xmm0
	movq	%rax, %rbp
	xorl	%edx, %edx
	leaq	8(%rbp), %r12
	movd	%xmm0, %esi
	pshufd	$0xe5, %xmm0, %xmm1
	movd	%xmm1, %ecx
	movq	%xmm0, (%rax)
	movslq	%esi, %rdi
	movslq	%ecx, %rax
	subq	%rdi, %rax
	cmpl	%ecx, %esi
	movq	%r12, %rdi
	movq	%r14, %rsi
	leaq	2(%rax,%rax), %rax
	cmovle	%rax, %rdx
	call	memcpy@PLT
	movl	$24, %edi
	call	__gnat_malloc@PLT
.LEHE128:
	movl	$1, %edx
	xchgl	(%rax), %edx
	movq	%r12, 8(%rax)
	leaq	16(%rsp), %rdi
	movq	%rbp, 16(%rax)
	movq	%rax, 8(%rbx)
.LEHB129:
	call	system__secondary_stack__ss_release@PLT
	movq	80(%rsp), %r14
	.cfi_restore 14
	jmp	.L1518
.L1540:
	movq	%r14, 80(%rsp)
	.cfi_offset 14, -16
	call	math_prime_util__count__lmo__storage__factor_holders__clear.part.0
.LEHE129:
.L1529:
	movq	%rax, %rbx
	jmp	.L1526
	.section	.gcc_except_table
.LLSDA58:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE58-.LLSDACSB58
.LLSDACSB58:
	.uleb128 .LEHB127-.LFB58
	.uleb128 .LEHE127-.LEHB127
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB128-.LFB58
	.uleb128 .LEHE128-.LEHB128
	.uleb128 .L1529-.LFB58
	.uleb128 0
	.uleb128 .LEHB129-.LFB58
	.uleb128 .LEHE129-.LEHB129
	.uleb128 0
	.uleb128 0
.LLSDACSE58:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC58
	.type	math_prime_util__count__lmo__storage__factor_holders__read.cold, @function
math_prime_util__count__lmo__storage__factor_holders__read.cold:
.LFSB58:
.L1526:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -40
	.cfi_offset 6, -32
	.cfi_offset 12, -24
	.cfi_offset 14, -16
	leaq	16(%rsp), %rdi
.LEHB130:
	call	system__secondary_stack__ss_release@PLT
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE130:
	.cfi_endproc
.LFE58:
	.section	.gcc_except_table
.LLSDAC58:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC58-.LLSDACSBC58
.LLSDACSBC58:
	.uleb128 .LEHB130-.LCOLDB78
	.uleb128 .LEHE130-.LEHB130
	.uleb128 0
	.uleb128 0
.LLSDACSEC58:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__read, .-math_prime_util__count__lmo__storage__factor_holders__read
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__read.cold, .-math_prime_util__count__lmo__storage__factor_holders__read.cold
.LCOLDE78:
	.text
.LHOTE78:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__holderSR__2
	.type	math_prime_util__count__lmo__storage__factor_holders__holderSR__2, @function
math_prime_util__count__lmo__storage__factor_holders__holderSR__2:
.LFB175:
	.cfi_startproc
	movl	$4, %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	jmp	math_prime_util__count__lmo__storage__factor_holders__read
	.cfi_endproc
.LFE175:
	.size	math_prime_util__count__lmo__storage__factor_holders__holderSR__2, .-math_prime_util__count__lmo__storage__factor_holders__holderSR__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__factors_1053PI
	.type	math_prime_util__count__lmo__factors_1053PI, @function
math_prime_util__count__lmo__factors_1053PI:
.LFB135:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movq	%rsi, %r14
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movslq	(%rdx), %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	call	system__put_images__array_before@PLT
	movslq	(%r12), %rbx
	cmpl	4(%r12), %ebx
	jg	.L1545
	negq	%r13
	leaq	(%r14,%r13,2), %r13
	jmp	.L1547
	.p2align 4,,10
	.p2align 3
.L1550:
	movq	%rbp, %rdi
	call	system__put_images__simple_array_between@PLT
	cmpl	$2147483647, %ebx
	je	.L1549
	addq	$1, %rbx
.L1547:
	movzwl	0(%r13,%rbx,2), %esi
	movq	%rbp, %rdi
	call	system__put_images__put_image_unsigned@PLT
	cmpl	%ebx, 4(%r12)
	jne	.L1550
.L1545:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%rbp, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	jmp	system__put_images__array_after@PLT
.L1549:
	.cfi_restore_state
	movl	$14, %esi
	leaq	.LC20(%rip), %rdi
	call	__gnat_rcheck_CE_Overflow_Check@PLT
	.cfi_endproc
.LFE135:
	.size	math_prime_util__count__lmo__factors_1053PI, .-math_prime_util__count__lmo__factors_1053PI
	.section	.text.unlikely
	.align 2
.LCOLDB79:
	.text
.LHOTB79:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__put_image
	.type	math_prime_util__count__lmo__storage__factor_holders__put_image, @function
math_prime_util__count__lmo__storage__factor_holders__put_image:
.LFB56:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA56
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	%rax, 24(%rsp)
.LEHB131:
	call	system__put_images__array_before@PLT
.LEHE131:
	cmpq	$0, 8(%rbp)
	je	.L1552
	movq	%rsp, %rdi
.LEHB132:
	call	system__secondary_stack__ss_mark@PLT
	movq	%rbp, %rdi
	call	math_prime_util__count__lmo__storage__factor_holders__element
	movq	%rax, %rsi
	movq	%rbx, %rdi
	call	math_prime_util__count__lmo__factors_1053PI
.LEHE132:
	movq	%rsp, %rdi
.LEHB133:
	call	system__secondary_stack__ss_release@PLT
.L1552:
	movq	%rbx, %rdi
	call	system__put_images__array_after@PLT
.LEHE133:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L1554:
	.cfi_restore_state
	movq	%rax, %rbx
	jmp	.L1553
	.section	.gcc_except_table
.LLSDA56:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE56-.LLSDACSB56
.LLSDACSB56:
	.uleb128 .LEHB131-.LFB56
	.uleb128 .LEHE131-.LEHB131
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB132-.LFB56
	.uleb128 .LEHE132-.LEHB132
	.uleb128 .L1554-.LFB56
	.uleb128 0
	.uleb128 .LEHB133-.LFB56
	.uleb128 .LEHE133-.LEHB133
	.uleb128 0
	.uleb128 0
.LLSDACSE56:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC56
	.type	math_prime_util__count__lmo__storage__factor_holders__put_image.cold, @function
math_prime_util__count__lmo__storage__factor_holders__put_image.cold:
.LFSB56:
.L1553:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	movq	%rsp, %rdi
.LEHB134:
	call	system__secondary_stack__ss_release@PLT
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE134:
	.cfi_endproc
.LFE56:
	.section	.gcc_except_table
.LLSDAC56:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC56-.LLSDACSBC56
.LLSDACSBC56:
	.uleb128 .LEHB134-.LCOLDB79
	.uleb128 .LEHE134-.LEHB134
	.uleb128 0
	.uleb128 0
.LLSDACSEC56:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__put_image, .-math_prime_util__count__lmo__storage__factor_holders__put_image
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__put_image.cold, .-math_prime_util__count__lmo__storage__factor_holders__put_image.cold
.LCOLDE79:
	.text
.LHOTE79:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__holderPI__2
	.type	math_prime_util__count__lmo__storage__factor_holders__holderPI__2, @function
math_prime_util__count__lmo__storage__factor_holders__holderPI__2:
.LFB177:
	.cfi_startproc
	jmp	math_prime_util__count__lmo__storage__factor_holders__put_image
	.cfi_endproc
.LFE177:
	.size	math_prime_util__count__lmo__storage__factor_holders__holderPI__2, .-math_prime_util__count__lmo__storage__factor_holders__holderPI__2
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__holderIPXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__holderIPXnn, @function
math_prime_util__count__lmo__storage__factor_holders__holderIPXnn:
.LFB136:
	.cfi_startproc
	testl	%esi, %esi
	jne	.L1559
	leaq	32+math_prime_util__count__lmo__storage__factor_holders__holderT(%rip), %rax
	movq	%rax, (%rdi)
.L1560:
	movq	$0, 8(%rdi)
	movl	$0, 16(%rdi)
	ret
	.p2align 4,,10
	.p2align 3
.L1559:
	cmpl	$3, %esi
	jne	.L1560
	ret
	.cfi_endproc
.LFE136:
	.size	math_prime_util__count__lmo__storage__factor_holders__holderIPXnn, .-math_prime_util__count__lmo__storage__factor_holders__holderIPXnn
	.section	.text.unlikely
	.align 2
.LCOLDB80:
	.text
.LHOTB80:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__holderSI__2
	.type	math_prime_util__count__lmo__storage__factor_holders__holderSI__2, @function
math_prime_util__count__lmo__storage__factor_holders__holderSI__2:
.LFB139:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA139
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	leaq	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	$0, (%rsp)
	movq	%rax, 24(%rsp)
	movl	$4, %eax
	movq	$0, 8(%rsp)
	cmpl	%eax, %edx
	movq	$0, 16(%rsp)
	cmovle	%edx, %eax
	movq	%rsp, %rdx
	movl	%eax, %ebp
.LEHB135:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	32+math_prime_util__count__lmo__storage__factor_holders__holderT(%rip), %rax
	movl	%ebp, %edx
	movq	%rbx, %rsi
	movq	%r12, %rdi
	movl	$0, 16(%rbx)
	movq	%rax, %xmm0
	movups	%xmm0, (%rbx)
	call	math_prime_util__count__lmo__storage__factor_holders__read
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE135:
.LEHB136:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__count__lmo__storage__factor_holders__holderFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE136:
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
.L1568:
	.cfi_restore_state
	movq	%rax, %rbx
	jmp	.L1567
	.section	.gcc_except_table
.LLSDA139:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE139-.LLSDACSB139
.LLSDACSB139:
	.uleb128 .LEHB135-.LFB139
	.uleb128 .LEHE135-.LEHB135
	.uleb128 .L1568-.LFB139
	.uleb128 0
	.uleb128 .LEHB136-.LFB139
	.uleb128 .LEHE136-.LEHB136
	.uleb128 0
	.uleb128 0
.LLSDACSE139:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC139
	.type	math_prime_util__count__lmo__storage__factor_holders__holderSI__2.cold, @function
math_prime_util__count__lmo__storage__factor_holders__holderSI__2.cold:
.LFSB139:
.L1567:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	%rsp, %r10
.LEHB137:
	call	math_prime_util__count__lmo__storage__factor_holders__holderSI__R327b___finalizer__2Xnn.20
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE137:
	.cfi_endproc
.LFE139:
	.section	.gcc_except_table
.LLSDAC139:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC139-.LLSDACSBC139
.LLSDACSBC139:
	.uleb128 .LEHB137-.LCOLDB80
	.uleb128 .LEHE137-.LEHB137
	.uleb128 0
	.uleb128 0
.LLSDACSEC139:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__holderSI__2, .-math_prime_util__count__lmo__storage__factor_holders__holderSI__2
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__holderSI__2.cold, .-math_prime_util__count__lmo__storage__factor_holders__holderSI__2.cold
.LCOLDE80:
	.text
.LHOTE80:
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__factor_holders__T465bXnn, @function
math_prime_util__count__lmo__storage__factor_holders__T465bXnn:
.LFB182:
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
	movl	$24, %edi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movl	%ebp, %edx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__count__lmo__storage__factor_holders__holderSI__2
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE182:
	.size	math_prime_util__count__lmo__storage__factor_holders__T465bXnn, .-math_prime_util__count__lmo__storage__factor_holders__T465bXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__TholderCFDXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__TholderCFDXnn, @function
math_prime_util__count__lmo__storage__factor_holders__TholderCFDXnn:
.LFB145:
	.cfi_startproc
	movq	(%rdi), %rax
	movq	-24(%rax), %rax
	movq	64(%rax), %rax
	testb	$1, %al
	jne	.L1579
.L1575:
	movl	$1, %esi
	jmp	*%rax
.L1579:
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1575
	.cfi_endproc
.LFE145:
	.size	math_prime_util__count__lmo__storage__factor_holders__TholderCFDXnn, .-math_prime_util__count__lmo__storage__factor_holders__TholderCFDXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeIPXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeIPXnn, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typeIPXnn:
.LFB146:
	.cfi_startproc
	testl	%esi, %esi
	jne	.L1581
	leaq	32+math_prime_util__count__lmo__storage__factor_holders__reference_control_typeT(%rip), %rax
	movq	%rax, (%rdi)
.L1582:
	movq	$0, 8(%rdi)
	ret
	.p2align 4,,10
	.p2align 3
.L1581:
	cmpl	$3, %esi
	jne	.L1582
	ret
	.cfi_endproc
.LFE146:
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeIPXnn, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typeIPXnn
	.section	.text.unlikely
	.align 2
.LCOLDB81:
	.text
.LHOTB81:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2:
.LFB152:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA152
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %r12
	leaq	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeFDXnn(%rip), %rsi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	subq	$32, %rsp
	.cfi_def_cfa_offset 64
	leaq	64(%rsp), %rax
	movq	$0, (%rsp)
	movq	%rax, 24(%rsp)
	movl	$4, %eax
	movq	$0, 8(%rsp)
	cmpl	%eax, %edx
	movq	$0, 16(%rsp)
	cmovle	%edx, %eax
	movq	%rsp, %rdx
	movl	%eax, %ebp
.LEHB138:
	call	system__finalization_primitives__attach_object_to_node@PLT
	leaq	32+math_prime_util__count__lmo__storage__factor_holders__reference_control_typeT(%rip), %rax
	movl	%ebp, %edx
	movq	%rbx, %rsi
	movq	%r12, %rdi
	movq	%rax, %xmm0
	movups	%xmm0, (%rbx)
	call	ada__finalization__controlledSR__2@PLT
	movq	%r12, %rdi
	call	system__stream_attributes__i_as@PLT
	movq	%rax, 8(%rbx)
	movq	%rsp, %rdi
	call	system__finalization_primitives__suppress_object_finalize_at_end@PLT
.LEHE138:
.LEHB139:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
.LEHE139:
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
.L1590:
	.cfi_restore_state
	movq	%rax, %rbx
	jmp	.L1589
	.section	.gcc_except_table
.LLSDA152:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE152-.LLSDACSB152
.LLSDACSB152:
	.uleb128 .LEHB138-.LFB152
	.uleb128 .LEHE138-.LEHB138
	.uleb128 .L1590-.LFB152
	.uleb128 0
	.uleb128 .LEHB139-.LFB152
	.uleb128 .LEHE139-.LEHB139
	.uleb128 0
	.uleb128 0
.LLSDACSE152:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC152
	.type	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2.cold, @function
math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2.cold:
.LFSB152:
.L1589:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
.LEHB140:
	call	*system__soft_links__abort_defer(%rip)
	movq	%rsp, %rdi
	leaq	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeFDXnn(%rip), %rsi
	call	system__finalization_primitives__finalize_object@PLT
	call	*system__soft_links__abort_undefer(%rip)
	movq	%rbx, %rdi
	call	_Unwind_Resume@PLT
.LEHE140:
	.cfi_endproc
.LFE152:
	.section	.gcc_except_table
.LLSDAC152:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC152-.LLSDACSBC152
.LLSDACSBC152:
	.uleb128 .LEHB140-.LCOLDB81
	.uleb128 .LEHE140-.LEHB140
	.uleb128 0
	.uleb128 0
.LLSDACSEC152:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2.cold, .-math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2.cold
.LCOLDE81:
	.text
.LHOTE81:
	.align 2
	.p2align 4
	.type	math_prime_util__count__lmo__storage__factor_holders__T534bXnn, @function
math_prime_util__count__lmo__storage__factor_holders__T534bXnn:
.LFB185:
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
	movl	$16, %edi
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	call	system__secondary_stack__ss_allocate@PLT
	movl	%ebp, %edx
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movq	%rax, 8(%rsp)
	call	math_prime_util__count__lmo__storage__factor_holders__reference_control_typeSI__2
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE185:
	.size	math_prime_util__count__lmo__storage__factor_holders__T534bXnn, .-math_prime_util__count__lmo__storage__factor_holders__T534bXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__Treference_control_typeCFDXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__Treference_control_typeCFDXnn, @function
math_prime_util__count__lmo__storage__factor_holders__Treference_control_typeCFDXnn:
.LFB159:
	.cfi_startproc
	movq	(%rdi), %rax
	movq	-24(%rax), %rax
	movq	64(%rax), %rax
	testb	$1, %al
	jne	.L1601
.L1597:
	movl	$1, %esi
	jmp	*%rax
.L1601:
	movq	-1(%rax), %r10
	movq	7(%rax), %rax
	jmp	.L1597
	.cfi_endproc
.LFE159:
	.size	math_prime_util__count__lmo__storage__factor_holders__Treference_control_typeCFDXnn, .-math_prime_util__count__lmo__storage__factor_holders__Treference_control_typeCFDXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeEQXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeEQXnn, @function
math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeEQXnn:
.LFB160:
	.cfi_startproc
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	je	.L1603
.L1606:
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L1603:
	testq	%rax, %rax
	je	.L1605
	movq	8(%rsi), %rax
	cmpq	%rax, 8(%rdi)
	jne	.L1606
.L1605:
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, %rdx
	leaq	16(%rsi), %rsi
	movq	%rdi, %rcx
	leaq	16(%rdi), %rdi
	movq	%rdx, 8(%rsp)
	movq	%rcx, (%rsp)
	call	ada__finalization__Oeq__3@PLT
	testb	%al, %al
	je	.L1602
	movq	8(%rsp), %rdx
	movq	(%rsp), %rcx
	movq	24(%rdx), %rax
	cmpq	%rax, 24(%rcx)
	sete	%al
.L1602:
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE160:
	.size	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeEQXnn, .-math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeEQXnn
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDIXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDIXnn, @function
math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDIXnn:
.LFB262:
	.cfi_startproc
	ret
	.cfi_endproc
.LFE262:
	.size	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDIXnn, .-math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDIXnn
	.section	.text.unlikely
	.align 2
.LCOLDB82:
	.text
.LHOTB82:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDAXnn
	.type	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDAXnn, @function
math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDAXnn:
.LFB162:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA162
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
.LEHB141:
	call	ada__exceptions__triggered_by_abort@PLT
.LEHE141:
	movl	%eax, %r14d
	movq	24(%rbx), %rax
	testq	%rax, %rax
	je	.L1617
	movq	8(%rax), %rax
	lock addl	$1, (%rax)
	movq	24(%rbx), %rdx
	movl	16(%rdx), %eax
	cmpl	$2147483647, %eax
	je	.L1628
	addl	$1, %eax
	movl	%eax, 16(%rdx)
.L1617:
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L1628:
	.cfi_restore_state
	movl	$98, %esi
	leaq	.LC24(%rip), %rdi
.LEHB142:
	call	__gnat_rcheck_CE_Overflow_Check@PLT
.LEHE142:
.L1623:
	movq	%rax, %rbx
	jmp	.L1620
	.section	.gcc_except_table
	.align 4
.LLSDA162:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATT162-.LLSDATTD162
.LLSDATTD162:
	.byte	0x1
	.uleb128 .LLSDACSE162-.LLSDACSB162
.LLSDACSB162:
	.uleb128 .LEHB141-.LFB162
	.uleb128 .LEHE141-.LEHB141
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB142-.LFB162
	.uleb128 .LEHE142-.LEHB142
	.uleb128 .L1623-.LFB162
	.uleb128 0x1
.LLSDACSE162:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATT162:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDAC162
	.type	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDAXnn.cold, @function
math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDAXnn.cold:
.LFSB162:
.L1620:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -24
	.cfi_offset 14, -16
	subq	$1, %rdx
	movq	%rax, %rdi
	jne	.L1629
	call	__gnat_begin_handler_v1@PLT
	xorl	%edx, %edx
	movq	%rbx, %rdi
	movq	%rax, %rsi
.LEHB143:
	call	__gnat_end_handler_v1@PLT
	andb	$1, %r14b
	jne	.L1617
	movl	$158, %esi
	leaq	.LC36(%rip), %rdi
	call	__gnat_rcheck_PE_Finalize_Raised_Exception@PLT
.L1629:
	call	_Unwind_Resume@PLT
.LEHE143:
	.cfi_endproc
.LFE162:
	.section	.gcc_except_table
	.align 4
.LLSDAC162:
	.byte	0xff
	.byte	0x9b
	.uleb128 .LLSDATTC162-.LLSDATTDC162
.LLSDATTDC162:
	.byte	0x1
	.uleb128 .LLSDACSEC162-.LLSDACSBC162
.LLSDACSBC162:
	.uleb128 .LEHB143-.LCOLDB82
	.uleb128 .LEHE143-.LEHB143
	.uleb128 0
	.uleb128 0
.LLSDACSEC162:
	.byte	0x1
	.byte	0
	.align 4
	.long	DW.ref.__gnat_others_value-.
.LLSDATTC162:
	.section	.text.unlikely
	.text
	.size	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDAXnn, .-math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDAXnn
	.section	.text.unlikely
	.size	math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDAXnn.cold, .-math_prime_util__count__lmo__storage__factor_holders__constant_reference_typeDAXnn.cold
.LCOLDE82:
	.text
.LHOTE82:
	.section	.rodata.str1.8
	.align 8
.LC83:
	.string	"Math_Prime_Util.Count.Lmo.Storage.Factor_Holders.Constant_Reference: container is empty"
	.section	.text.unlikely
	.align 2
.LCOLDB84:
	.text
.LHOTB84:
	.align 2
	.p2align 4
	.globl	math_prime_util__count__lmo__storage__factor_holders__constant_reference
	.type	math_prime_util__count__lmo__storage__factor_holders__constant_reference, @function
math_prime_util__count__lmo__storage__factor_holders__constant_reference:
.LFB43:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gnat_personality_v0
	.cfi_lsda 0x1b,.LLSDA43
	subq	$104, %rsp
	.cfi_def_cfa_offset 112
	leaq	112(%rsp), %rax
	movq	%r14, 88(%rsp)
	movq	%rax, 72(%rsp)
	movq	8(%rsi), %rax
	movq	%r15, 96(%rsp)
	movq	%rbx, 80(%rsp)
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	.cfi_offset 3, -32
	testq	%rax, %rax
	je	.L1650
	movdqu	8(%rax), %xmm0
	movq	%rdi, %rbx
	movq	%rsi, 40(%rsp)
	leaq	32+math_prime_util__count__lmo__storage__factor_holders__reference_control_typeT(%