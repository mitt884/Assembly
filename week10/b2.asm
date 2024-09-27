.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014
.data

message: .asciiz "\n"
main: 
    li $t1, IN_ADDRESS_HEXA_KEYBOARD
    li $t2, OUT_ADDRESS_HEXA_KEYBOARD
start:
    li $t3, 0x01

polling:
    sb $t3, 0($t1)
    lb $a0, 0($t2)
    beq $a0, $zero, back_poll

printf:
    li $v0, 34
    syscall 

    li $v0, 11
    li $a0, '\n'
    syscall

sleep:
    li $a0, 100
    li $v0, 32
    syscall

back_poll: 
    sll $t3, $t3, 1
    ble $t3, 0x08, polling
    j start