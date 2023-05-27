.data

.text
#关于几个重要的偏移量地址：
#0xC60($28)：右16位led
#0xC62($28)：左8位led
#0xC70($28)：右16位开关
#0xC72($28)：左8位开关

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
	lw $1, 0xC72($28)	#left-8 switch in $1
	#no need to shift srl5 ?
	#beq $1,$17,sum	#000 0
	#beq $1,$18,parity2	#001 1
	#beq $1,$19,bitNor	#010 2
	#beq $1,$20, bitOr	#011 3
	#beq $1,$21, addition	#100 4
	#beq $1,$22, subtraction		#101 5
	beq $1,$23, multiplication	#110 6
	beq $1,$24, division	#111 7



	
multiplication:
	sw $0,0xC62($28)
	lw $2,0xC70($28)	#right-16 switch in $2
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b
	jal  sign_extend
	addi $4, $0, 0x80
#取出两个数的最高位
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
#判断最后的乘积为正还是负
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
	jal  divi
#判断最后的商为正还是负
	xor $4,$5,$6
	beq $4,$zero,next

#如果商为负数，对商取补码
	nor $8,$8,$8
	addi $8,$8,1

#余数的符号要与被除数保持一致
next:
	beq $5,$zero,show5s
	nor $9,$9,$9
	addi $9,$9,1
#得到最终结果的商和余数，分别存在寄存器$8,$9中
########	#############################################################
##########如何实现商和余数的交替显示，每个持续5s###########################
	sw $8,0xC60($28)
	jal show5s
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
exit:
	jr $ra


show5s:	
	addi $t7, $zero,1500
	addi $t9,$zero, 1500
	loop73:
	addi $t9, $zero,1500 #每次执行外层循环都将内层循环的循环变量置为0
	loop74:
	addi $t5, $zero,1
	sub $t9, $t9, $t5 #内层循环变量自增，且判断是否还满足循环条件
	bne $t9, $zero, loop74
	sub $t7,$t7,$t5
	bne $t7 ,$zero, loop73
	jr  $ra
