.data
	
.text
main: 
	lui $28,0xFFFF
	ori $28,$28,0xF000



	addi $17, $0, 0
	addi $18, $0, 1
	addi $19, $0, 2
	addi $20, $0, 3
	addi $21, $0, 4
	addi $22, $0, 5
	addi $23, $0, 6
	addi $24, $0, 7

loop:
    lui $sp, 0xFFFF
    ori $sp, $sp, 0xFC00

    j sum3

sum3:

    sw $0,0xC62($28)
	lw $2,0xC70($28)	#right-16 switch in $2
	andi $2,$2,0xFF00
	srl $2,$2,8		#a


    add $4, $2, $0
    add $6, $0, $0  # clear
    jal accumulate3
    j loop

accumulate3:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $4, 0($sp)
    sw $4, 0xC60($28)
    add $7, $0, $ra
    jal show3s
    add $ra, $0, $7

    slt $5, $4, $18
    beq $5, $zero, leaf31
    #lw $4, 0($sp)
    #lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
leaf31:
    addi $4, $4, -1
    jal accumulate3
leaf32:
    lw $4, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    add $6, $4, $6
    jr $ra


show3s:	
	addi $t7, $zero,2500

	loop73:
	addi $t9, $zero,1500
	loop74:
	addi $t5, $zero,1
	sub $t9, $t9, $t5 
	bne $t9, $zero, loop74
	sub $t7,$t7,$t5
	bne $t7 ,$zero, loop73
	jr  $31