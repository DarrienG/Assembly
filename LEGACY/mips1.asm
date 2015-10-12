.data
	
	
.text

	main: 
		addi $a0, $zero, 50
		addi $a2, $zero, 100
		
		jal addNumbers
		# Tells program that execution has completed
		
		li $v0, 1
		addi $a0, $v1, 0
		syscall
		
		li $v0, 10
		syscall
	

	addNumbers:
		add $v1, $a0, $a2
		
		jr $ra
	
		
