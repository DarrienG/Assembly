.data
	inputString:	.asciiz "Enter a string (cannot be longer than length 100): "
	output2:	.asciiz "In reverse: "
	newLine:	.asciiz "\n"
	buffer:		.space 100
	
	
.text
main:
	la	$a0, inputString	# Showing the string asking for a string
	li	$v0, 4
	syscall
	
	li	$v0, 8			# Takes string as input from user
	la 	$a0, buffer
	li	$a1, 80
	move	$t0, $a0
	syscall
	
	
	li 	$a0, newLine		# Formatting. Keeps output looking nice
	syscall
	
	la 	$a0, output2 		# Why output2? output1 was nixed, and I don't feel like changing it
	syscall				# String that specifies reverse output
	
	li 	$a0, output2
	syscall
	
	li 	$t0, 0
	
strLength:				# Getting length of string
	lb	$t0, str($t2) 
	add	$t2, $t2, 1
	bne	$t0, $zero, strLen	# Yay recursion
	li $v0, 11
	
cycle:					# Swapping begins
	sub	t2, t2, 1
	la	$t0, 