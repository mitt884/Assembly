.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014
.data

Message: .asciiz "Oh my god, Someone's presed a button.\n"

.text
main:
    li $t1, IN_ADDRESS_HEXA_KEYBOARD
    li $t3, 0x80
    sb $t3, 0($t1)

Loop: 
    nop
    nop
    nop
    nop
    b Loop

end_main:
.ktext 0x80000180
IntSR:
    addi $v0, $zero, 4
    la $a0, Message
    syscall
    li $t1, IN_ADDRESS_HEXA_KEYBOARD
    li $t2, OUT_ADDRESS_HEXA_KEYBOARD

startPolling: 
    li $t3, 0x01
polling:
    sb $t3, 0($t1)
    sb $a0, 0($t2)
    beq $a0, $zero, back_to_polling
    li $t2, UT_ADDRESS_HEXA_KEYBOARD
startPolling:
    li $t3, 0x01
polling:
    sb $t3, 0x01
    lb $a0, 0($t2)
    beq $a0, $zero, back_to_polling
print:
    li $v0, 34
    syscall
    li $v0, 11
    li $a0, '\n'
    syscall

sleep:
    li $a0, 100
    li $v0, 32
    syscall

back_to_polling:
    sll $t3, $t3, 1

    ble $t3, 0x8, polling
    j startPolling

next_pc:
    mfc0 $at, $14
    addi $at, $at, 4
    mtc0 $at, $14

return: erets
