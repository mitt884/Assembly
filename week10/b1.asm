	
#Le Thi Ngocj Thao 20225673 
.eqv SEVENSEG_LEFT 0xFFFF0010   #dia chi cua led 7 thanh trai
.eqv SEVENSEG_RIGHT 0xFFFF0011  #dia chi cua led 7 thanh phai

.text 

main:
	li $a0, 0x7D
	
	jal SHOW_7SEG_LEFT
	
	li $a0, 0x6
	jal SHOW_7SEG_RIGHT
	
	
	li $v0, 10
	syscall 
	
end_main:

SHOW_7SEG_LEFT:
	li $t0, SEVENSEG_LEFT 
	sb $a0, 0($t0)          #assign new value
	jr $ra
	
SHOW_7SEG_RIGHT:
	li $t0, SEVENSEG_RIGHT 
	sb $a0, 0($t0)          #assign new value
	jr $ra
	
