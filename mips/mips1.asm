.data
	
.text
li $a0, 20
jal fact
li $v0, 10
syscall

fact:
 addi $sp, $sp, -8
 sw $ra, 4($sp)
 sw $a0, 0($sp)
 li $v0, 1
 syscall

 slti $t0, $a0, 1
 beq $t0, $zero, L1
 addi $v0, $zero, 1
 addi $sp, $sp, 8
 jr $ra
L1:
 addi $a0, $a0, -1
 jal fact
L2: 
 lw $a0, 0($sp)
 lw $ra, 4($sp)
 addi $sp, $sp, 8
 add $v0, $a0, $v0
 jr $ra






