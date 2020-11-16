	.file	"shell.c"
	.text
	.globl	run_command
	.section	.data.rel.local,"aw"
	.align 32
	.type	run_command, @object
	.size	run_command, 80
run_command:
	.quad	run_cd
	.quad	run_echo
	.quad	run_history
	.quad	run_pwd
	.quad	run_exit
	.quad	run_ls
	.quad	run_cat
	.quad	run_date
	.quad	run_rm
	.quad	run_mkdir
	.comm	historyFile,8,8
	.comm	fileName,1000,32
	.globl	AbsolutePath
	.data
	.align 32
	.type	AbsolutePath, @object
	.size	AbsolutePath, 1000
AbsolutePath:
	.string	"/home/deadlocks/Codes/assignment1/1.2"
	.zero	962
	.section	.rodata
	.align 8
.LC0:
	.string	"Serious breakdown, terminating program"
.LC1:
	.string	"a+"
.LC2:
	.string	"Unable to open file"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	-999424(%rsp), %r11
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	subq	$1600, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$1000, %esi
	leaq	AbsolutePath(%rip), %rdi
	call	getcwd@PLT
	testq	%rax, %rax
	jne	.L2
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %eax
	jmp	.L3
.L2:
	leaq	AbsolutePath(%rip), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	leaq	AbsolutePath(%rip), %rax
	addq	%rdx, %rax
	movw	$47, (%rax)
	leaq	AbsolutePath(%rip), %rsi
	leaq	fileName(%rip), %rdi
	call	strcpy@PLT
	leaq	fileName(%rip), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	leaq	fileName(%rip), %rax
	addq	%rdx, %rax
	movabsq	$3348833620947331432, %rsi
	movq	%rsi, (%rax)
	movl	$7633012, 8(%rax)
	leaq	.LC1(%rip), %rsi
	leaq	fileName(%rip), %rdi
	call	fopen@PLT
	movq	%rax, historyFile(%rip)
	movq	historyFile(%rip), %rax
	testq	%rax, %rax
	jne	.L4
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$-1, %eax
	jmp	.L3
.L4:
	movq	historyFile(%rip), %rax
	movl	$0, %edx
	movl	$2, %esi
	movq	%rax, %rdi
	call	fseek@PLT
.L5:
	movl	$0, %eax
	call	show_terminal
	leaq	-1008(%rbp), %rax
	movq	%rax, %rdi
	call	read_command
	leaq	-1001008(%rbp), %rdx
	leaq	-1008(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	parse_command
	movl	%eax, -1001012(%rbp)
	movq	historyFile(%rip), %rax
	leaq	-1008(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	add_to_file
	movl	-1001012(%rbp), %edx
	leaq	-1001008(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	execute_command
	jmp	.L5
.L3:
	movq	-8(%rbp), %rsi
	xorq	%fs:40, %rsi
	je	.L6
	call	__stack_chk_fail@PLT
.L6:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
.LC3:
	.string	"String- |%s|\n"
	.text
	.globl	print_string
	.type	print_string, @function
print_string:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	print_string, .-print_string
	.section	.rodata
.LC4:
	.string	"Strings-"
.LC5:
	.string	"%d -> |%s|\n"
	.text
	.globl	print_strings
	.type	print_strings, @function
print_strings:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	movl	$0, -4(%rbp)
	jmp	.L9
.L10:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -4(%rbp)
.L9:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L10
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	print_strings, .-print_strings
	.globl	print_String
	.type	print_String, @function
print_String:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	print_String, .-print_String
	.globl	print_Strings
	.type	print_Strings, @function
print_Strings:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	movl	$0, -4(%rbp)
	jmp	.L13
.L14:
	movl	-4(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -4(%rbp)
.L13:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L14
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	print_Strings, .-print_Strings
	.globl	add_to_file
	.type	add_to_file, @function
add_to_file:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fputs@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$10, %edi
	call	fputc@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	add_to_file, .-add_to_file
	.globl	trim_ends
	.type	trim_ends, @function
trim_ends:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L17
.L18:
	addq	$1, -8(%rbp)
.L17:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L18
	subq	$1, -8(%rbp)
	jmp	.L19
.L20:
	movq	-8(%rbp), %rax
	movb	$0, (%rax)
	subq	$1, -8(%rbp)
.L19:
	call	__ctype_b_loc@PLT
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	jne	.L20
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L21
.L22:
	addq	$1, -8(%rbp)
.L21:
	call	__ctype_b_loc@PLT
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	jne	.L22
	movq	-8(%rbp), %rax
	cmpq	-24(%rbp), %rax
	je	.L26
	jmp	.L24
.L25:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %edx
	movq	-24(%rbp), %rax
	movb	%dl, (%rax)
	addq	$1, -24(%rbp)
	addq	$1, -8(%rbp)
.L24:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L25
	movq	-24(%rbp), %rax
	movb	$0, (%rax)
.L26:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	trim_ends, .-trim_ends
	.globl	not_a_command
	.type	not_a_command, @function
not_a_command:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L28
.L31:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	movq	%rax, %rdx
	movq	-32(%rbp), %rax
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L29
	movl	$0, %eax
	jmp	.L30
.L29:
	addl	$1, -4(%rbp)
.L28:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L31
	movl	$1, %eax
.L30:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	not_a_command, .-not_a_command
	.section	.rodata
.LC6:
	.string	"User couldn't be extracted"
	.align 8
.LC7:
	.string	"Error occured while accessing current working directory"
.LC8:
	.string	"%s:"
.LC9:
	.string	"%s$ "
	.text
	.globl	show_terminal
	.type	show_terminal, @function
show_terminal:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1024, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	call	getlogin@PLT
	movq	%rax, -1016(%rbp)
	cmpq	$0, -1016(%rbp)
	jne	.L33
	leaq	.LC6(%rip), %rdi
	call	puts@PLT
	jmp	.L38
.L33:
	leaq	-1008(%rbp), %rax
	movl	$1000, %esi
	movq	%rax, %rdi
	call	getcwd@PLT
	testq	%rax, %rax
	jne	.L35
	leaq	.LC7(%rip), %rdi
	call	puts@PLT
	jmp	.L38
.L35:
	movq	-1016(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC8(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-1008(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC9(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L38:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L37
	call	__stack_chk_fail@PLT
.L37:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	show_terminal, .-show_terminal
	.section	.rodata
	.align 8
.LC10:
	.string	"Error occured while reading input"
	.text
	.globl	read_command
	.type	read_command, @function
read_command:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	stdin(%rip), %rdx
	movq	-24(%rbp), %rax
	movl	$1000, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L40
	leaq	.LC10(%rip), %rdi
	call	puts@PLT
	jmp	.L44
.L40:
	movl	$0, -4(%rbp)
	jmp	.L42
.L43:
	addl	$1, -4(%rbp)
.L42:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$10, %al
	jne	.L43
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
.L44:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	read_command, .-read_command
	.globl	parse_command
	.type	parse_command, @function
parse_command:
.LFB16:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	trim_ends
	movl	$0, -20(%rbp)
	movl	$0, -16(%rbp)
	movl	$0, -12(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L46
.L53:
	call	__ctype_b_loc@PLT
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	je	.L47
	cmpl	$0, -20(%rbp)
	je	.L48
	movl	-16(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rdx
	movq	-48(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	cltq
	movb	$32, (%rdx,%rax)
	addl	$1, -12(%rbp)
	jmp	.L49
.L48:
	cmpl	$0, -12(%rbp)
	je	.L49
	movl	-16(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rdx
	movq	-48(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	cltq
	movb	$0, (%rdx,%rax)
	addl	$1, -16(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L49
.L47:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$34, %al
	jne	.L50
	cmpl	$0, -12(%rbp)
	je	.L51
	movl	-16(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rdx
	movq	-48(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	cltq
	movb	$0, (%rdx,%rax)
	addl	$1, -16(%rbp)
	movl	$0, -12(%rbp)
.L51:
	cmpl	$0, -20(%rbp)
	je	.L52
	movl	$0, -20(%rbp)
	jmp	.L49
.L52:
	movl	$1, -20(%rbp)
	jmp	.L49
.L50:
	movl	-16(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rdx
	movq	-48(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movq	-8(%rbp), %rax
	movzbl	(%rax), %edx
	movl	-12(%rbp), %eax
	cltq
	movb	%dl, (%rcx,%rax)
	addl	$1, -12(%rbp)
.L49:
	addq	$1, -8(%rbp)
.L46:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L53
	cmpl	$0, -12(%rbp)
	je	.L54
	movl	-16(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rdx
	movq	-48(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	cltq
	movb	$0, (%rdx,%rax)
	addl	$1, -16(%rbp)
	movl	$0, -12(%rbp)
.L54:
	movl	-16(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	parse_command, .-parse_command
	.section	.rodata
.LC11:
	.string	"Error not a valid command"
	.text
	.globl	execute_command
	.type	execute_command, @function
execute_command:
.LFB17:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movq	%rdi, -136(%rbp)
	movl	%esi, -140(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$25699, -112(%rbp)
	movw	$0, -104(%rbp)
	movq	$1869112165, -102(%rbp)
	movw	$0, -94(%rbp)
	movabsq	$34184295202646376, %rax
	movq	%rax, -92(%rbp)
	movw	$0, -84(%rbp)
	movq	$6584176, -82(%rbp)
	movw	$0, -74(%rbp)
	movq	$1953069157, -72(%rbp)
	movw	$0, -64(%rbp)
	movq	$29548, -62(%rbp)
	movw	$0, -54(%rbp)
	movq	$7627107, -52(%rbp)
	movw	$0, -44(%rbp)
	movq	$1702125924, -42(%rbp)
	movw	$0, -34(%rbp)
	movq	$28018, -32(%rbp)
	movw	$0, -24(%rbp)
	movabsq	$491394460525, %rax
	movq	%rax, -22(%rbp)
	movw	$0, -14(%rbp)
	movl	$10, -116(%rbp)
	cmpl	$0, -140(%rbp)
	je	.L65
	movl	-116(%rbp), %edx
	leaq	-112(%rbp), %rcx
	movq	-136(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	not_a_command
	testl	%eax, %eax
	je	.L59
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
.L59:
	movl	$0, -120(%rbp)
	jmp	.L60
.L63:
	leaq	-112(%rbp), %rcx
	movl	-120(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$2, %rax
	addq	%rdx, %rax
	addq	%rax, %rax
	leaq	(%rcx,%rax), %rdx
	movq	-136(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L61
	movl	-120(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	run_command(%rip), %rax
	movq	(%rdx,%rax), %rcx
	movl	-140(%rbp), %edx
	movq	-136(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	*%rcx
	jmp	.L56
.L61:
	addl	$1, -120(%rbp)
.L60:
	movl	-120(%rbp), %eax
	cmpl	-116(%rbp), %eax
	jl	.L63
	jmp	.L56
.L65:
	nop
.L56:
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L64
	call	__stack_chk_fail@PLT
.L64:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	execute_command, .-execute_command
	.section	.rodata
.LC12:
	.string	"Excess of arguments"
.LC13:
	.string	"~"
.LC14:
	.string	"/"
.LC15:
	.string	"Unable to open path"
.LC16:
	.string	"home"
.LC17:
	.string	"deadlocks"
.LC18:
	.string	"--help"
.LC19:
	.string	"Invalid Path"
	.text
	.globl	run_cd
	.type	run_cd, @function
run_cd:
.LFB18:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	cmpl	$2, -28(%rbp)
	jle	.L67
	leaq	.LC12(%rip), %rdi
	call	puts@PLT
	jmp	.L77
.L67:
	cmpl	$1, -28(%rbp)
	je	.L69
	cmpl	$2, -28(%rbp)
	jne	.L70
	movq	-24(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC13(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L70
.L69:
	leaq	.LC14(%rip), %rdi
	call	chdir@PLT
	cmpl	$-1, %eax
	jne	.L71
	leaq	.LC15(%rip), %rdi
	call	puts@PLT
.L71:
	leaq	.LC16(%rip), %rdi
	call	chdir@PLT
	cmpl	$-1, %eax
	jne	.L72
	leaq	.LC15(%rip), %rdi
	call	puts@PLT
.L72:
	leaq	.LC17(%rip), %rax
	movq	%rax, -8(%rbp)
	call	getlogin@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L73
	leaq	.LC15(%rip), %rdi
	call	puts@PLT
.L73:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	chdir@PLT
	cmpl	$-1, %eax
	jne	.L76
	leaq	.LC15(%rip), %rdi
	call	puts@PLT
	jmp	.L76
.L70:
	cmpl	$2, -28(%rbp)
	jne	.L75
	movq	-24(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L75
	movq	-24(%rbp), %rax
	movl	$7627107, (%rax)
	movq	-24(%rbp), %rax
	addq	$1000, %rax
	leaq	AbsolutePath(%rip), %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-24(%rbp), %rax
	leaq	1000(%rax), %rdx
	movq	%rdx, %rax
	movq	$-1, %rcx
	movq	%rax, %rsi
	movl	$0, %eax
	movq	%rsi, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	subq	$1, %rax
	addq	%rdx, %rax
	movabsq	$3342906084974945640, %rdx
	movq	%rdx, (%rax)
	movl	$7633012, 8(%rax)
	movl	-28(%rbp), %edx
	movq	-24(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	run_cat
	jmp	.L68
.L75:
	movq	-24(%rbp), %rax
	addq	$1000, %rax
	movq	%rax, %rdi
	call	chdir@PLT
	cmpl	$-1, %eax
	jne	.L77
	leaq	.LC19(%rip), %rdi
	call	puts@PLT
	jmp	.L77
.L76:
	nop
.L68:
.L77:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	run_cd, .-run_cd
	.section	.rodata
.LC20:
	.string	"-n"
.LC21:
	.string	"%s "
.LC22:
	.string	"-E"
.LC23:
	.string	"-e"
.LC24:
	.string	"Unrecognised flag"
	.text
	.globl	run_echo
	.type	run_echo, @function
run_echo:
.LFB19:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	cmpl	$1, -28(%rbp)
	jne	.L79
	movl	$10, %edi
	call	putchar@PLT
	jmp	.L90
.L79:
	movq	-24(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC20(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L81
	movl	$2, -12(%rbp)
	jmp	.L82
.L83:
	movl	-12(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rsi
	leaq	.LC21(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -12(%rbp)
.L82:
	movl	-12(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L83
	jmp	.L90
.L81:
	movq	-24(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC22(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L84
	movl	$2, -8(%rbp)
	jmp	.L85
.L86:
	movl	-8(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rsi
	leaq	.LC21(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -8(%rbp)
.L85:
	movl	-8(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L86
	movl	$10, %edi
	call	putchar@PLT
	jmp	.L90
.L84:
	movq	-24(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC23(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L87
	movl	$1, -4(%rbp)
	jmp	.L88
.L89:
	movl	-4(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, %rsi
	leaq	.LC21(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -4(%rbp)
.L88:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L89
	movl	$10, %edi
	call	putchar@PLT
	jmp	.L90
.L87:
	leaq	.LC24(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L90:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	run_echo, .-run_echo
	.section	.rodata
.LC25:
	.string	"%5d %s"
.LC26:
	.string	"-c"
.LC27:
	.string	"w"
.LC28:
	.string	"Invalid argument"
	.text
	.globl	run_history
	.type	run_history, @function
run_history:
.LFB20:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	-999424(%rsp), %r11
.LPSRL1:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL1
	subq	$1632, %rsp
	movq	%rdi, -1001048(%rbp)
	movl	%esi, -1001052(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$1, -1001052(%rbp)
	jne	.L92
	movq	historyFile(%rip), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek@PLT
	movl	$0, -1001036(%rbp)
	jmp	.L93
.L94:
	addl	$1, -1001036(%rbp)
	leaq	-1008(%rbp), %rdx
	movl	-1001036(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC25(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L93:
	movq	historyFile(%rip), %rdx
	leaq	-1008(%rbp), %rax
	movl	$1000, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L94
	movq	historyFile(%rip), %rax
	movl	$0, %edx
	movl	$2, %esi
	movq	%rax, %rdi
	call	fseek@PLT
	jmp	.L111
.L92:
	cmpl	$2, -1001052(%rbp)
	jle	.L96
	leaq	.LC12(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L111
.L96:
	movq	-1001048(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L97
	movq	-1001048(%rbp), %rax
	movl	$7627107, (%rax)
	movq	-1001048(%rbp), %rax
	addq	$1000, %rax
	leaq	AbsolutePath(%rip), %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-1001048(%rbp), %rax
	leaq	1000(%rax), %rdx
	movq	%rdx, %rax
	movq	$-1, %rcx
	movq	%rax, %rsi
	movl	$0, %eax
	movq	%rsi, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	subq	$1, %rax
	addq	%rdx, %rax
	movabsq	$8316292946033665384, %rsi
	movabsq	$8392585648559779700, %rdi
	movq	%rsi, (%rax)
	movq	%rdi, 8(%rax)
	movb	$0, 16(%rax)
	movl	-1001052(%rbp), %edx
	movq	-1001048(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	run_cat
	jmp	.L111
.L97:
	movq	-1001048(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC26(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L98
	movq	historyFile(%rip), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	leaq	.LC27(%rip), %rsi
	leaq	fileName(%rip), %rdi
	call	fopen@PLT
	movq	%rax, historyFile(%rip)
	movq	historyFile(%rip), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	leaq	.LC1(%rip), %rsi
	leaq	fileName(%rip), %rdi
	call	fopen@PLT
	movq	%rax, historyFile(%rip)
	movq	historyFile(%rip), %rax
	movl	$0, %edx
	movl	$2, %esi
	movq	%rax, %rdi
	call	fseek@PLT
	jmp	.L111
.L98:
	movl	$0, -1001032(%rbp)
	movl	$1, -1001028(%rbp)
	jmp	.L99
.L102:
	call	__ctype_b_loc@PLT
	movq	(%rax), %rdx
	movq	-1001048(%rbp), %rax
	leaq	1000(%rax), %rcx
	movl	-1001032(%rbp), %eax
	cltq
	movzbl	(%rcx,%rax), %eax
	movsbq	%al, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$2048, %eax
	testl	%eax, %eax
	jne	.L100
	movl	$0, -1001028(%rbp)
	jmp	.L101
.L100:
	addl	$1, -1001032(%rbp)
.L99:
	movq	-1001048(%rbp), %rax
	leaq	1000(%rax), %rdx
	movl	-1001032(%rbp), %eax
	cltq
	movzbl	(%rdx,%rax), %eax
	testb	%al, %al
	jne	.L102
.L101:
	cmpl	$0, -1001028(%rbp)
	jne	.L103
	leaq	.LC28(%rip), %rdi
	call	puts@PLT
	jmp	.L111
.L103:
	movq	-1001048(%rbp), %rax
	addq	$1000, %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -1001016(%rbp)
	cmpl	$0, -1001016(%rbp)
	je	.L104
	cmpl	$0, -1001016(%rbp)
	jns	.L105
.L104:
	leaq	.LC28(%rip), %rdi
	call	puts@PLT
	jmp	.L111
.L105:
	movq	historyFile(%rip), %rax
	movl	$0, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	fseek@PLT
	movl	$0, -1001024(%rbp)
	jmp	.L106
.L107:
	leaq	-1001008(%rbp), %rdx
	movl	-1001024(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rax
	addq	%rax, %rdx
	leaq	-1008(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	addl	$1, -1001024(%rbp)
.L106:
	movq	historyFile(%rip), %rdx
	leaq	-1008(%rbp), %rax
	movl	$1000, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L107
	movq	historyFile(%rip), %rax
	movl	$0, %edx
	movl	$2, %esi
	movq	%rax, %rdi
	call	fseek@PLT
	movl	-1001016(%rbp), %eax
	cmpl	%eax, -1001024(%rbp)
	cmovle	-1001024(%rbp), %eax
	movl	%eax, -1001012(%rbp)
	movl	-1001024(%rbp), %eax
	subl	-1001012(%rbp), %eax
	movl	%eax, -1001020(%rbp)
	jmp	.L108
.L109:
	leaq	-1001008(%rbp), %rdx
	movl	-1001020(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rax
	addq	%rax, %rdx
	movl	-1001020(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %esi
	leaq	.LC25(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -1001020(%rbp)
.L108:
	movl	-1001020(%rbp), %eax
	cmpl	-1001024(%rbp), %eax
	jl	.L109
.L111:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L110
	call	__stack_chk_fail@PLT
.L110:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	run_history, .-run_history
	.section	.rodata
.LC29:
	.string	"-P"
	.text
	.globl	run_pwd
	.type	run_pwd, @function
run_pwd:
.LFB21:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1024, %rsp
	movq	%rdi, -1016(%rbp)
	movl	%esi, -1020(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$2, -1020(%rbp)
	jle	.L113
	leaq	.LC12(%rip), %rdi
	call	puts@PLT
	jmp	.L121
.L113:
	cmpl	$1, -1020(%rbp)
	je	.L115
	cmpl	$2, -1020(%rbp)
	jne	.L116
	movq	-1016(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC29(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L116
.L115:
	leaq	-1008(%rbp), %rax
	movl	$1000, %esi
	movq	%rax, %rdi
	call	getcwd@PLT
	testq	%rax, %rax
	jne	.L117
	leaq	.LC7(%rip), %rdi
	call	puts@PLT
	jmp	.L114
.L117:
	leaq	-1008(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L114
.L116:
	cmpl	$2, -1020(%rbp)
	jne	.L119
	movq	-1016(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L119
	movq	-1016(%rbp), %rax
	movl	$7627107, (%rax)
	movq	-1016(%rbp), %rax
	addq	$1000, %rax
	leaq	AbsolutePath(%rip), %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-1016(%rbp), %rax
	leaq	1000(%rax), %rdx
	movq	%rdx, %rax
	movq	$-1, %rcx
	movq	%rax, %rsi
	movl	$0, %eax
	movq	%rsi, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	subq	$1, %rax
	addq	%rdx, %rax
	movabsq	$7239378481231717736, %rdx
	movq	%rdx, (%rax)
	movl	$1954051118, 8(%rax)
	movb	$0, 12(%rax)
	movl	-1020(%rbp), %edx
	movq	-1016(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	run_cat
	jmp	.L114
.L119:
	leaq	.LC24(%rip), %rdi
	call	puts@PLT
	jmp	.L121
.L114:
.L121:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L120
	call	__stack_chk_fail@PLT
.L120:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	run_pwd, .-run_pwd
	.section	.rodata
.LC30:
	.string	"Excess arguments"
	.text
	.globl	run_exit
	.type	run_exit, @function
run_exit:
.LFB22:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$2, -12(%rbp)
	jne	.L123
	movq	-8(%rbp), %rax
	addq	$1000, %rax
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L123
	movq	-8(%rbp), %rax
	movl	$7627107, (%rax)
	movq	-8(%rbp), %rax
	addq	$1000, %rax
	leaq	AbsolutePath(%rip), %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-8(%rbp), %rax
	leaq	1000(%rax), %rdx
	movq	%rdx, %rax
	movq	$-1, %rcx
	movq	%rax, %rsi
	movl	$0, %eax
	movq	%rsi, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	subq	$1, %rax
	addq	%rdx, %rax
	movabsq	$7599935831770162536, %rdx
	movq	%rdx, (%rax)
	movl	$2020879988, 8(%rax)
	movw	$116, 12(%rax)
	movl	-12(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	run_cat
	jmp	.L124
.L123:
	cmpl	$2, -12(%rbp)
	jg	.L125
	movq	historyFile(%rip), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %edi
	call	exit@PLT
.L125:
	leaq	.LC30(%rip), %rdi
	call	puts@PLT
	nop
.L124:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	run_exit, .-run_exit
	.section	.rodata
.LC31:
	.string	"Failed to create process"
.LC32:
	.string	"Process didn't worked"
	.text
	.globl	run_ls
	.type	run_ls, @function
run_ls:
.LFB23:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1040, %rsp
	movq	%rdi, -1032(%rbp)
	movl	%esi, -1036(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-1036(%rbp), %eax
	addl	$1, %eax
	cltq
	movl	$1000, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -1016(%rbp)
	leaq	-1008(%rbp), %rax
	leaq	AbsolutePath(%rip), %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-1008(%rbp), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	leaq	-1008(%rbp), %rax
	addq	%rdx, %rax
	movl	$1397501742, (%rax)
	movb	$0, 4(%rax)
	movq	-1016(%rbp), %rax
	leaq	-1008(%rbp), %rdx
	movq	%rdx, (%rax)
	movl	$1, -1024(%rbp)
	jmp	.L127
.L128:
	movl	-1024(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rcx
	movl	-1024(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	-1032(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, (%rax)
	addl	$1, -1024(%rbp)
.L127:
	movl	-1024(%rbp), %eax
	cmpl	-1036(%rbp), %eax
	jl	.L128
	movl	-1036(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	addl	$1, -1036(%rbp)
	call	fork@PLT
	movl	%eax, -1020(%rbp)
	cmpl	$0, -1020(%rbp)
	jns	.L129
	leaq	.LC31(%rip), %rdi
	call	puts@PLT
	jmp	.L134
.L129:
	cmpl	$0, -1020(%rbp)
	jne	.L131
	movq	-1016(%rbp), %rax
	movq	(%rax), %rax
	movq	-1016(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execv@PLT
	cmpl	$-1, %eax
	jne	.L132
	movl	$-1, %edi
	call	exit@PLT
.L132:
	movl	$0, %edi
	call	exit@PLT
.L131:
	movl	-1020(%rbp), %eax
	movl	$0, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	waitpid@PLT
	cmpl	$-1, %eax
	jne	.L134
	leaq	.LC32(%rip), %rdi
	call	puts@PLT
.L134:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L133
	call	__stack_chk_fail@PLT
.L133:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	run_ls, .-run_ls
	.globl	run_cat
	.type	run_cat, @function
run_cat:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1040, %rsp
	movq	%rdi, -1032(%rbp)
	movl	%esi, -1036(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-1036(%rbp), %eax
	addl	$1, %eax
	cltq
	movl	$1000, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -1016(%rbp)
	leaq	-1008(%rbp), %rax
	leaq	AbsolutePath(%rip), %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-1008(%rbp), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	leaq	-1008(%rbp), %rax
	addq	%rdx, %rax
	movl	$1094922030, (%rax)
	movw	$84, 4(%rax)
	movq	-1016(%rbp), %rax
	leaq	-1008(%rbp), %rdx
	movq	%rdx, (%rax)
	movl	$1, -1024(%rbp)
	jmp	.L136
.L137:
	movl	-1024(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rcx
	movl	-1024(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	-1032(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, (%rax)
	addl	$1, -1024(%rbp)
.L136:
	movl	-1024(%rbp), %eax
	cmpl	-1036(%rbp), %eax
	jl	.L137
	movl	-1036(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	addl	$1, -1036(%rbp)
	call	fork@PLT
	movl	%eax, -1020(%rbp)
	cmpl	$0, -1020(%rbp)
	jns	.L138
	leaq	.LC31(%rip), %rdi
	call	puts@PLT
	jmp	.L143
.L138:
	cmpl	$0, -1020(%rbp)
	jne	.L140
	movq	-1016(%rbp), %rax
	movq	(%rax), %rax
	movq	-1016(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execv@PLT
	cmpl	$-1, %eax
	jne	.L141
	movl	$-1, %edi
	call	exit@PLT
.L141:
	movl	$0, %edi
	call	exit@PLT
.L140:
	movl	-1020(%rbp), %eax
	movl	$0, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	waitpid@PLT
	cmpl	$-1, %eax
	jne	.L143
	leaq	.LC32(%rip), %rdi
	call	puts@PLT
.L143:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L142
	call	__stack_chk_fail@PLT
.L142:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	run_cat, .-run_cat
	.globl	run_date
	.type	run_date, @function
run_date:
.LFB25:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1040, %rsp
	movq	%rdi, -1032(%rbp)
	movl	%esi, -1036(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-1036(%rbp), %eax
	addl	$1, %eax
	cltq
	movl	$1000, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -1016(%rbp)
	leaq	-1008(%rbp), %rax
	leaq	AbsolutePath(%rip), %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-1008(%rbp), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	leaq	-1008(%rbp), %rax
	addq	%rdx, %rax
	movl	$1094987566, (%rax)
	movw	$17748, 4(%rax)
	movb	$0, 6(%rax)
	movq	-1016(%rbp), %rax
	leaq	-1008(%rbp), %rdx
	movq	%rdx, (%rax)
	movl	$1, -1024(%rbp)
	jmp	.L145
.L146:
	movl	-1024(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rcx
	movl	-1024(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	-1032(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, (%rax)
	addl	$1, -1024(%rbp)
.L145:
	movl	-1024(%rbp), %eax
	cmpl	-1036(%rbp), %eax
	jl	.L146
	movl	-1036(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	addl	$1, -1036(%rbp)
	call	fork@PLT
	movl	%eax, -1020(%rbp)
	cmpl	$0, -1020(%rbp)
	jns	.L147
	leaq	.LC31(%rip), %rdi
	call	puts@PLT
	jmp	.L152
.L147:
	cmpl	$0, -1020(%rbp)
	jne	.L149
	movq	-1016(%rbp), %rax
	movq	(%rax), %rax
	movq	-1016(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execv@PLT
	cmpl	$-1, %eax
	jne	.L150
	movl	$-1, %edi
	call	exit@PLT
.L150:
	movl	$0, %edi
	call	exit@PLT
.L149:
	movl	-1020(%rbp), %eax
	movl	$0, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	waitpid@PLT
	cmpl	$-1, %eax
	jne	.L152
	leaq	.LC32(%rip), %rdi
	call	puts@PLT
.L152:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L151
	call	__stack_chk_fail@PLT
.L151:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	run_date, .-run_date
	.globl	run_rm
	.type	run_rm, @function
run_rm:
.LFB26:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1040, %rsp
	movq	%rdi, -1032(%rbp)
	movl	%esi, -1036(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-1036(%rbp), %eax
	addl	$1, %eax
	cltq
	movl	$1000, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -1016(%rbp)
	leaq	-1008(%rbp), %rax
	leaq	AbsolutePath(%rip), %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-1008(%rbp), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	leaq	-1008(%rbp), %rax
	addq	%rdx, %rax
	movl	$1297231662, (%rax)
	movb	$0, 4(%rax)
	movq	-1016(%rbp), %rax
	leaq	-1008(%rbp), %rdx
	movq	%rdx, (%rax)
	movl	$1, -1024(%rbp)
	jmp	.L154
.L155:
	movl	-1024(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rcx
	movl	-1024(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	-1032(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, (%rax)
	addl	$1, -1024(%rbp)
.L154:
	movl	-1024(%rbp), %eax
	cmpl	-1036(%rbp), %eax
	jl	.L155
	movl	-1036(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	addl	$1, -1036(%rbp)
	call	fork@PLT
	movl	%eax, -1020(%rbp)
	cmpl	$0, -1020(%rbp)
	jns	.L156
	leaq	.LC31(%rip), %rdi
	call	puts@PLT
	jmp	.L161
.L156:
	cmpl	$0, -1020(%rbp)
	jne	.L158
	movq	-1016(%rbp), %rax
	movq	(%rax), %rax
	movq	-1016(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execv@PLT
	cmpl	$-1, %eax
	jne	.L159
	movl	$-1, %edi
	call	exit@PLT
.L159:
	movl	$0, %edi
	call	exit@PLT
.L158:
	movl	-1020(%rbp), %eax
	movl	$0, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	waitpid@PLT
	cmpl	$-1, %eax
	jne	.L161
	leaq	.LC32(%rip), %rdi
	call	puts@PLT
.L161:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L160
	call	__stack_chk_fail@PLT
.L160:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	run_rm, .-run_rm
	.globl	run_mkdir
	.type	run_mkdir, @function
run_mkdir:
.LFB27:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1040, %rsp
	movq	%rdi, -1032(%rbp)
	movl	%esi, -1036(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-1036(%rbp), %eax
	addl	$1, %eax
	cltq
	movl	$1000, %esi
	movq	%rax, %rdi
	call	calloc@PLT
	movq	%rax, -1016(%rbp)
	leaq	-1008(%rbp), %rax
	leaq	AbsolutePath(%rip), %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-1008(%rbp), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	leaq	-1008(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$23161505760227118, %rsi
	movq	%rsi, (%rax)
	movq	-1016(%rbp), %rax
	leaq	-1008(%rbp), %rdx
	movq	%rdx, (%rax)
	movl	$1, -1024(%rbp)
	jmp	.L163
.L164:
	movl	-1024(%rbp), %eax
	cltq
	imulq	$1000, %rax, %rcx
	movl	-1024(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	-1032(%rbp), %rdx
	addq	%rcx, %rdx
	movq	%rdx, (%rax)
	addl	$1, -1024(%rbp)
.L163:
	movl	-1024(%rbp), %eax
	cmpl	-1036(%rbp), %eax
	jl	.L164
	movl	-1036(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-1016(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	addl	$1, -1036(%rbp)
	call	fork@PLT
	movl	%eax, -1020(%rbp)
	cmpl	$0, -1020(%rbp)
	jns	.L165
	leaq	.LC31(%rip), %rdi
	call	puts@PLT
	jmp	.L170
.L165:
	cmpl	$0, -1020(%rbp)
	jne	.L167
	movq	-1016(%rbp), %rax
	movq	(%rax), %rax
	movq	-1016(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execv@PLT
	cmpl	$-1, %eax
	jne	.L168
	movl	$-1, %edi
	call	exit@PLT
.L168:
	movl	$0, %edi
	call	exit@PLT
.L167:
	movl	-1020(%rbp), %eax
	movl	$0, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	waitpid@PLT
	cmpl	$-1, %eax
	jne	.L170
	leaq	.LC32(%rip), %rdi
	call	puts@PLT
.L170:
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L169
	call	__stack_chk_fail@PLT
.L169:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	run_mkdir, .-run_mkdir
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
