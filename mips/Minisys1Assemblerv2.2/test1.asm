.data 0x0000 # the bitwidth of data* is 32, its initial value is 0
    buf : .word 0x0000
.text 0x0000 # instructions
    Initialize:

    lui $31, 0xFFFF
    ori $31, $31, 0xF000

    start:
    lw $1,0xC70($31) #move the data from 0xFFFF_FC70 to register $1
    sw $1,0xC60($31) #move the data from register $1 to 0xFFFF_FC60
    lw $1,0xC72($31)
    sw $1,0xC62($31)
    j start