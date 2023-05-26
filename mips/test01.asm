.data

.text 
main:   
	lui $1,0xFFFF
	ori $28,$1,0xF000

	addi $18, $0, 1



loop:
	lw   $2,0xC70($28)
	sw   $2,0xC60($28)
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b

	jal sign_extend
	slt $4,$2,$3


	beq $4,$18,Yes
	addi $25,$0,0
	sw $25, 0xC62($28)
	j loop

Yes:	
	addi $25,$0,1
	sw $25, 0xC62($28)
	j loop

	
sign_extend:
	# param $2,$3, which stores a,b
	andi $9, $2, 0x0080
	beq $9, $0, continue
	lui $9, 0xffff
	ori $9, $9, 0xff00
	or $2, $2, $9
continue:
	andi $9, $3, 0x0080
	beq $9, $0, exit3
	lui $9, 0xffff
	ori $9, $9, 0xff00
	or $3, $3, $9
exit3:
	jr $ra