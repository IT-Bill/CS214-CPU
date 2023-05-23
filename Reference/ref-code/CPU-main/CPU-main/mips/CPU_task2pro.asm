.data 0x0000				      		
	buf: .space 200
.text 0x0000						
initial: 
	lui $1,0xFFFF			
	ori $28,$1,0xF000
	and $21,$0,$0		# set $21 to 0 --a
	and $22,$0,$0		# set $22 to 0 --b
	and $23,$0,$0		# set $23 to 0 --val
	ori $20,$0,0xFFFF	# set $20 to 1111 1111 1111 1111
	and $4,$0,$0
	and $3,$0,$0
	lw  $10,0xC70($28)	# $10 get value from switch
task2:
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
	j task2
	
	ooo:
	lw  $10,0xC70($28)
	addu $4,$10,$0
	addu $6,$10,$0
	oooloop:
	# index = $3 count=$4,$6  $5 immediate
	addiu $3,$3,0x00000004
	lw  $10,0xC70($28)
	sw  $10,buf($3)
	addiu $5,$0,0x00000001
	sub $4,$4,$5
	bne $4,$0,pause
	j oooloop

	ooa:
	and $23,$21,$22
	sw $23,0xC80($28)	# set val to scan
	sw $23,0xC60($28)
	j pause

	oao:
	or $23,$21,$22
	sw $23,0xC80($28)	# set val to scan
	sw $23,0xC60($28)
	j pause
	oaa:
	sllv $23,$21,$22
	sw $23,0xC80($28)	# set val to scan
	sw $23,0xC60($28)
	j pause
	aoo:
	srlv $23,$21,$22
	sw $23,0xC80($28)	# set val to scan
	sw $23,0xC60($28)
	j pause
	aoa:
	srav $23,$22,$21
	sw $23,0xC80($28)	# set val to scan
	sw $23,0xC60($28)
	j pause
	aao:
	and $23,$21,$22
	sw $23,0xC80($28)	# set val to scan
	sw $23,0xC60($28)
	j pause
	aaa:
	xor $23,$21,$22
	sw $23,0xC80($28)	# set val to scan
	sw $23,0xC60($28)
	j pause
	
pause:
	lw $25,0xC72($28)	# load the control bit
	bne $25,$9,task2
	j pause