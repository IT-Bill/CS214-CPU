.data
	
.text

fact:
 addi $sp, $sp, -8
 sw $ra, 4($sp)
 sw $4, 0($sp)



 slti $5, $4, 1
 beq $5, $zero, L1
 addi $6, $zero, 1
 addi $sp, $sp, 8
 jr $ra
L1:
 addi $4, $4, -1
 jal fact
L2:
 lw $4, 0($sp)
 lw $ra, 4($sp)
 addi $sp, $sp, 8
 add $6, $4, $6
 jr $ra







