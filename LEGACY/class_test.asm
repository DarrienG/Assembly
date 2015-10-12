	.data
promptS:	.asciiz		"Enter a string: "


	.text
	la	$a0, promptS
	li	$v0, 4
	syscall
	
	li	$v0, 5
	syscall
	
	move	$a0, $v0
	mul	$a0, $a0, $a0
	
	li	$v0, 1
	syscall
