.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014
.data

Message: .asciiz "Key scan code"

.text
main: 
    li $t1, IN_ADDRESS_HEXA_KEYBOARD
    li $t3, 0x80
    sb $t3, 0($t1)
    xor $s0, $s0, $s0

Loop:
    addi $s0, $s0, 1

prn_seq:
    addi $v0, $zero, 1
    add $a0, $s0, $zero
    syscall

prn_eol: 
    addi $v0, $zero, 11
    li $a0, 300
    syscall
    nop 
    b Loop

end_main:

.ktext 0x80000180

IntSR: 
    addi $sp, $sp, 4
    addi $sp, $sp, 4
    sw $at, 0($sp)
    addi $sp, $sp, 4
    sw $v0, 0($sp)
    addi $sp, $sp, 4
    sw $a0, 0($sp)
    addi $sp, $sp, 4
    sw $t1, 0($sp)
    addi $sp, $sp, 4
    sw $t3, 0($sp)

prn_msg: 
    addi $v0, $zero, 4
    la $a0, Message
    syscall

get_cod: 
    li $t1, IN_ADDRESS_HEXA_KEYBOARD
    li $t2, OUT_ADDRESS_HEXA_KEYBOARD
    li $t3, 0x1

pooling: 
    sb $t3, 0($t1)
    lb $a0, 0($t2)

    beqz $a0, back_to_polling

prn_cod:
    li $v0, 34
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall
sleep2: 
    li $a0, 100
    li $v0, 32
    syscall

back_to_polling:
    sll $t3, $t3, 1
    ble $t3, 0x8, pooling
    j next_pc

next_pc: 
    mfc0 $at, $14
    addi $at, $at, 4
    mtc0 $at, $14

restore:    
    lw $t3, 0($sp)
    addi $sp, $sp, -4
    lw $t1, 0($sp)
    addi $sp, $sp, -4
    lw $a0, 0($sp)
    addi $sp, $sp, -4
    lw $v0, 0($sp)
    addi $sp, $sp, -4
    lw $ra, 0($sp)
    addi $sp, $sp, -4

return: eret