.data 0x0000
	buf: .word 0x0000
.text 0x0000
initial:
	lui $1,0xFFFF			
	ori $28,$1,0xF000
	and $21,$0,$0		# set $21 to 0 --a
	and $22,$0,$0		# set $22 to 0 --b
	and $23,$0,$0		# set $23 to 0 --res
	ori $20,$0,0xFFFF	# set $20 to 1111 1111 1111 1111
task1:
	lw  $9,0xC72($28)	# load the control bit
	# according to the control bit, determine the action
	beq $9,$0,ooo		#000
	ori $2,$0,0x0020	#$2 store 001
	beq $9,$2,ooa		#001
	ori $2,$0,0x0040
	beq $9,$2,oao		#010
	ori $2,$0,0x0060
	beq $9,$2,oaa		#011
	ori $2,$0,0x0080
	beq $9,$2,aoo		#100
	ori $2,$0,0x00A0
	beq $9,$2,aoa		#101
	ori $2,$0,0x00C0
	beq $9,$2,aao		#110
	ori $2,$0,0x00E0
	beq $9,$2,aaa		#111
	j task1
	ooo:
	sw $0,0xC62($28)
	lw $12,0xC70($28)	# $12 as val get value from switch
	sw $12,0xC60($28)	# set value to leds
	j pause
	ooa:
	sw $0,0xC62($28)
	sw $8,0xC60($28)	# set value to leds
	nor $8,$8,$8		# set $8 to not $8
	j pause
	oao:
	addi $12,$12,1
	slt $21,$20,$12
	sw $21,0xC62($28)
	sw $12,0xC60($28)	# set value to leds
	j pause
	oaa:
	sw $0,0xC62($28)
	addi $12,$12,-1
	sw $12,0xC60($28)	# set value to leds
	j pause
	aoo:
	sw $0,0xC62($28)
	sll $12,$12,1
	sw $12,0xC60($28)	# set value to leds
	j pause
	aoa:
	sw $0,0xC62($28)
	srl $12,$12,1
	sw $12,0xC60($28)	# set value to leds
	j pause
	aao:
	sw $0,0xC62($28)
	sra $12,$12,1
	sw $12,0xC60($28)	# set value to leds
	j pause
	aaa:
	
	
pause:
	# $10 as counter, $11 as boundary
	and $10,$10,$0	# set $10 to 0
	lui $11,0x74
	ori $11,$11,0x7BEA	# set $11 to 26000
	pauseloop:
	lw $15,0xC72($28)	# load the control bit
	beq $15,$16,initial
	beq $10,$11,endloop
	addi $10,$10,0x0001
	j pauseloop
	endloop:
	j task1
