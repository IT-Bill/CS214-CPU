.data

.text
#���ڼ�����Ҫ��ƫ������ַ��
#0xC60($28)����16λled
#0xC62($28)����8λled
#0xC70($28)����16λ����
#0xC72($28)����8λ����
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
	beq $1,$17,parity1	#000 0
	beq $1,$18,parity2	#001 1
	beq $1,$19,bitNor	#010 2
	beq $1,$20, bitOr	#011 3
	beq $1,$21, addition	#100 4
	beq $1,$22, subtraction		#101 5
	beq $1,$23, multiplication	#110 6
	beq $1,$24, division	#111 7

parity1:
	lw   $2,0xC70($28)	
	#obtain the first number a, get the first 8 bits and shift right 8 bits
	andi $2,$2,0xFF00
	sw   $2,0xC60($28)
	srl $2,$2,8		#a
	addi $3,$0,1            #test bit
	addi $5,$0,0		# $5:save the cnt of 1
loop1:
	addi $6, $0, 128
	beq $3,$6,Exit
	and $4,$2,$3
	beq $4,$3,isOne
	sll $3,$3,1
	j loop1
isOne:
	addi $5,$5,1
	sll $3,$3,1
	j loop1

Exit:
	andi $5,$5,1	#check if it is odd
	addi $6, $0, 1
	beq $5,$6,off
	addi $25,$0,1
	sw $25, 0xC62($28)
	j loop
	addi $1,$1,0	#filler
off:
	addi $25,$0,0
	sw $25, 0xC62($28)
	j loop
	addi $1,$1,0	#filler
	
	
parity2:
	lw   $2,0xC70($28)	
	#obtain the first number a, get the first 8 bits and shift right 8 bits
	andi $2,$2,0xFF00
	sw   $2,0xC60($28)
	srl $2,$2,8		#a
	addi $3,$0,1            #test bit
	addi $5,$0,0		#$5:save the cnt of 1
loop2:
	addi $6, $0, 256
	beq $3,$6,Exit2
	and $4,$2,$3
	beq $4,$3,isOne2
	sll $3,$3,1
	j loop2
isOne2:
	addi $5,$5,1
	sll $3,$3,1
	j loop2

Exit2:
	andi $5,$5,1	#check if it is odd
	addi $6, $0, 1
	beq $5,$6,off2
	addi $25,$0,1
	sw $25, 0xC62($28)
	j loop
	addi $1,$1,0	#filler
off2:
	addi $25,$0,0
	sw $25, 0xC62($28)
	j loop
	addi $1,$1,0	#filler


loadAndShow:
	sw $0,0xC62($28)#set left-8 led to be 0
	
	lw $2,0xC70($28)	#load right-16 switch in $2
	
	sw $2,0xC60($28) #save right-16 swicth into right-16 led
	
	#obtain the first number a, get the first 8 bits and shift right 8 bits
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	#obtain the second number a
	andi $3,$3,0x00FF	#b
	
	j loop
	addi $1,$1,0	#filler
	
bitNor:
	sw $0,0xC62($28)
	
	lw $2,0xC70($28)	#right-16 switch in $2
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b
	
	nor $4,$2,$3
	sw $4,0xC60($28)
	j loop
	addi $1,$1,0	#filler
	
bitOr:
	sw $0,0xC62($28)
	
	lw $2,0xC70($28)	#right-16 switch in $2
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b
	
	or $4,$2,$3
	sw $4,0xC60($28)
	j loop
	addi $1,$1,0	#filler
	
bitXor:
	sw $0,0xC62($28)

	lw $2,0xC70($28)	#right-16 switch in $2
	add $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b
	
	xor $4,$2,$3
	sw $4,0xC60($28)
	j loop
	addi $1,$1,0	#filler


uCompare:
	lw   $2,0xC70($28)
	sw   $2,0xC60($28)
	
	addu $3,$0,$2 
	andi $2,$2,0xFF00
	srl $2,$2,8		#a
	andi $3,$3,0x00FF	#b
	
	sltu $4,$2,$3
	beq $4,$18,Yesu
	addi $25,$0,0
	sw $25, 0xC62($28)
	j loop
	addi $1,$1,0	#filler
Yesu:	
	addi $25,$0,1
	sw $25, 0xC62($28)
	j loop
	addi $1,$1,0	#filler
	
	
Compare:
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
	addi $1,$1,0	#filler
Yes:	
	addi $25,$0,1
	sw $25, 0xC62($28)
	j loop
	addi $1,$1,0	#filler
	
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
	jr $ra
exit3:
	jr $ra
	
