.data

.text
#??????????????????????
#0xC60($28)????16??led
#0xC62($28)????8??led
#0xC70($28)????16??????
#0xC72($28)????8??????

main: 
	lui $1,0xFFFF			
	ori $28,$1,0xF000
	 
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

    lw $1, 0xC72($28)
    andi $1, $1, 7

	#no need to shift srl5 ?
	beq $1,$17,sum1	#000 0
	beq $1,$18,sum2	#001 1
	beq $1,$19,sum3	#010 2
	beq $1,$20, sum4	#011 3
	beq $1,$21, addition	#100 4
	beq $1,$22, subtraction		#101 5
	beq $1,$23, multiplication	#110 6
	beq $1,$24, division	#111 7

sum1:
    sw $0,0xC62($28)
	lw $2,0xC70($28)	#right-16 switch in $2
	andi $2,$2,0xFF00
	srl $2,$2,8		#a

    # negative detect
    andi $3, $2, 0x0080
    bne $3, $0, nega
    add $4, $2, $0
    add $6, $0, $0  # clear
    jal accumulate1
    sw $6, 0xC60($28)
    j loop

nega:
    sw $0, 0xC60($28)
    sw $18, 0xC62($28)
    jal show3s
    sw $0, 0xC62($28)
    jal show3s
    j loop


accumulate1:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $4, 0($sp)


    slt $5, $4, $18
    beq $5, $zero, leaf11
    addi $sp, $sp, 8
    jr $ra
leaf11:
    addi $4, $4, -1
    jal accumulate1
leaf12:
    lw $4, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    add $6, $4, $6
    jr $ra


sum2:
    sw $0,0xC62($28)
	lw $2,0xC70($28)	#right-16 switch in $2
	andi $2,$2,0xFF00
	srl $2,$2,6		#a
    sw $2, 0xC60($28)
    j loop


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

sum4:
    sw $0,0xC62($28)
	lw $2,0xC70($28)	#right-16 switch in $2
	andi $2,$2,0xFF00
	srl $2,$2,8		#a


    add $4, $2, $0
    add $6, $0, $0  # clear
    jal accumulate4
    j loop


accumulate4:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $4, 0($sp)


    slt $5, $4, $18
    beq $5, $zero, leaf41
    addi $sp, $sp, 8
    jr $ra
leaf41:
    addi $4, $4, -1
    jal accumulate4
leaf42:
    lw $4, 0($sp)
    lw $ra, 4($sp)
    sw $4, 0xC60($28)
    add $7, $0, $ra
    jal show3s
    add $ra, $0, $7
    addi $sp, $sp, 8
    add $6, $4, $6
    jr $ra

addition:
	sw $0,0xC62($28)
	lw $2,0xC70($28)	#right-16 switch in $2
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b
	jal  sign_extend
	add $4,$2,$3
	andi $5, $4, 0x00FF
	sw $5,0xC60($28)
	#???????????-2^7~2^7-1  -128~127
	#????$2??$3?????????
	addi $2, $0, 127
	addi $3, $0, -128
	slt $6, $2, $4
	beq $6,$18,overflow
	slt $6,$4,$3
	beq $6,$18,overflow
	addi $25,$0,0
	sw  $25,0xC62($28)
	j loop
	addi $1,$1,0	#filler
overflow:
	addi $25,$0,1
	sw  $25,0xC62($28)
	j loop
	addi $1,$1,0	#filler
	
subtraction:
	sw $0,0xC62($28)
	lw $2,0xC70($28)	#right-16 switch in $2
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b
	jal  sign_extend
	sub $4,$2,$3
	andi $5, $4, 0x00FF
	sw $5,0xC60($28)
	#???????????-2^7~2^7-1  -128~127
	#????$2??$3?????????
	addi $2, $0, 127
	addi $3, $0, -128
	slt $6, $2, $4
	beq $6,$18,overflow
	slt $6,$4,$3
	beq $6,$18,overflow
	addi $25,$0,0
	sw  $25,0xC62($28)
	j loop
	addi $1,$1,0	#filler


	
multiplication:
	sw $0,0xC62($28)
	lw $2,0xC70($28)	#right-16 switch in $2
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b
	jal  sign_extend
	addi $4, $0, 0x80
#????????????????
	and $5,$2,$4
	srl $5,$5,7 
	beq $5,$0,label
	sub $2,$0,$2
	label:
	and $6,$3,$4
	srl $6,$6,7 
	beq $6,$0,label2
	sub $3,$0,$3
	label2:
	jal multi
#??????????????????
	xor $4,$5,$6
	beq $4,$zero,exit6
	nor $8,$8,$8
	addi $8,$8,1
	sw $8,0xC60($28)
	j loop
	addi $1,$1,0	#filler
exit6:	
	sw $8,0xC60($28)
	j loop
	addi $1,$1,0	#filler
	
multi:
#$8: store the product
	add $8,$0,$0
	add $10,$0,$0
	addi $9,$0,8	#8 is the length in binary
	loopp:
	and $7,$18,$3 #to determine the lowest bit of $s1
	beq $7, $0, jumpAdd
	add $8, $2, $8
	jumpAdd:
	sll $2,$2,1
	srl $3,$3,1
	addi $10,$10,1
	slt $11, $10, $9
	bne $11, $0, loopp

	# add $a0,$0,$8

	jr $ra
	
division:
	sw $0,0xC62($28)
	lw $2,0xC70($28)	#right-16 switch in $2
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b
	jal  sign_extend
	addi $4, $0, 0x80
#取出两个数的最高位,对两个数取绝对值
	and $5,$2,$4
	srl $5,$5,7 
	beq $5,$0,labe3
	sub $2,$0,$2
	labe3:
	and $6,$3,$4
	srl $6,$6,7 
	beq $6,$0,label4
	sub $3,$0,$3
	label4:
	jal  divi
#判断最后的商为正还是负
	xor $4,$5,$6
	beq $4,$zero,next

#如果商为负数，对商取补码
	nor $8,$8,$8
	addi $8,$8,1

#余数的符号要与被除数保持一致
next:
	beq $5,$zero,fuck
	nor $9,$9,$9
	addi $9,$9,1
#得到最终结果的商和余数，分别存在寄存器$8,$9中
########	#############################################################
##########如何实现商和余数的交替显示，每个持续5s###########################
fuck:
	andi $8,$8,0xff
	sw $8,0xC60($28)
	jal show5s
	andi $9,$9,0xff
	sw $9,0xC60($28)
	jal show5s
	j loop
	addi $1,$1,0	#filler



divi:
#$8: store the quotient $9:store the reminder
	sll $3,$3,8 # $3 : dividor
	add $9,$2,$zero  # $9 store the remainder
	add $8,$0,$0 # $8: Quot
	add $10,$0,$0 # $10: loop cnt
	addi $7,$zero,9 #$7:: looptimes
loopb: 
# $2: dividend, $3: divisor, $9: remainder, $8: quot
# $10:cnt of loops $7: 9
	sub $9,$9,$3 #dividend - dividor
	andi $s0,$9,0x8000 # get the higest bit of rem to check if rem<0
	sll $8,$8,1 # shift left quot with 1bit
	beq $s0,$0, SdrUq # if rem>=0, shift Div right
	add $9,$9,$3 # if rem<0, rem=rem+div
	srl $3,$3,1
	addi $8,$8,0
	j loope
SdrUq:
	srl $3,$3,1
	addi $8,$8,1
loope:
	addi $10,$10,1
	bne $10,$7,loopb
	jr  $31

	

sign_extend:
	# param $2,$3, which stores a,b
	andi $9, $2, 0x0080
	beq $9, $0, continue
	lui $9, 0xffff
	ori $9, $9, 0xff00
	or $2, $2, $9
continue:
	andi $9, $3, 0x0080
	beq $9, $0, exit
	lui $9, 0xffff
	ori $9, $9, 0xff00
	or $3, $3, $9
	jr $ra
exit:
	jr $ra


show5s:	
	addi $t7, $zero,10000
	addi $t9,$zero, 1500

	loop73:
	addi $t9, $zero,1500 #??????????????????????????????????0
	loop74:
	addi $t5, $zero,1
	sub $t9, $t9, $t5#????????????????????????????????????
	bne $t9, $zero, loop74
	sub $t7,$t7,$t5
	bne $t7 ,$zero, loop73
	jr  $31


show3s:	
	addi $t7, $zero,2500
	addi $t9,$zero, 1500

	loop83:
	addi $t9, $zero,1500 
	loop84:
	addi $t5, $zero,1
	sub $t9, $t9, $t5 
	bne $t9, $zero, loop84
	sub $t7,$t7,$t5
	bne $t7 ,$zero, loop83
	jr  $31