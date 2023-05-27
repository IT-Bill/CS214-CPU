

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
	beq $4,$0,next

#如果商为负数，对商取补码
	nor $8,$8,$8
	addi $8,$8,1

#余数的符号要与被除数保持一致
next:
	beq $5,$0,fuck
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
	add $9,$2,$0  # $9 store the remainder
	add $8,$0,$0 # $8: Quot
	add $10,$0,$0 # $10: loop cnt
	addi $7,$0,9 #$7:: looptimes
loopb: 
# $2: dividend, $3: divisor, $9: remainder, $8: quot
# $10:cnt of loops $7: 9
	sub $9,$9,$3 #dividend - dividor
	andi $10,$9,0x8000 # get the higest bit of rem to check if rem<0
	sll $8,$8,1 # shift left quot with 1bit
	beq $10,$0, SdrUq # if rem>=0, shift Div right
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
	addi $t7, $0,10000
	addi $t9,$0, 1500

	loop73:
	addi $t9, $0,1500 #每次执行外层循环都将内层循环的循环变量置为0
	loop74:
	addi $t5, $0,1
	sub $t9, $t9, $t5#内层循环变量自增，且判断是否还满足循环条件
	bne $t9, $0, loop74
	sub $t7,$t7,$t5
	bne $t7 ,$0, loop73
	jr  $31
